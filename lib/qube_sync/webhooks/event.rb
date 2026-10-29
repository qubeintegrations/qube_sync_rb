# frozen_string_literal: true

module QubeSync
  module Webhooks
    # A parsed delivery. `QubeSync::Webhooks.parse` and `.verify` return one of the subclasses
    # below, picked by the body: RequestEvent, WorkflowRunEvent, NotificationEvent,
    # ConnectionEvent, NameIndexEvent, or UnknownEvent for anything else. Every accessor reads
    # the body and returns nil for a missing key; `[]` reads any other key.
    class Event
      WORKFLOW_RUN_EVENTS = %w[
        workflow_run.awaiting_input
        workflow_run.completed
        workflow_run.failed
        workflow_run.cancelled
      ].freeze
      NOTIFICATION_EVENT = "workflow_run.notification"

      # Picks the event class for a parsed body (a Hash with string keys).
      def self.build(body)
        event = body["event"]

        klass =
          if event.nil?
            body["page_request_id"].nil? ? UnknownEvent : RequestEvent
          elsif !event.is_a?(String)
            UnknownEvent
          elsif WORKFLOW_RUN_EVENTS.include?(event)
            WorkflowRunEvent
          elsif event == NOTIFICATION_EVENT
            NotificationEvent
          elsif event.start_with?("connection.")
            ConnectionEvent
          elsif event.start_with?("name_index.")
            NameIndexEvent
          else
            UnknownEvent
          end

        klass.new(body)
      end

      # Parses a raw JSON body without verifying it. Same as `QubeSync::Webhooks.parse`.
      def self.from_json(raw_body)
        Webhooks.parse(raw_body)
      end

      def self.fields(*names)
        names.each do |name|
          key = name.to_s
          define_method(name) { @body[key] }
        end
      end
      private_class_method :fields

      def initialize(body)
        @body = body
      end

      fields :event, :timestamp, :app_id, :sandbox

      # "request", "workflow_run", "notification", "connection", "name_index" or "unknown".
      def type
        self.class::TYPE
      end

      # The key to deduplicate deliveries on, or nil when this type has none.
      def dedupe_key
        nil
      end

      def reference
        nil
      end

      def revision
        nil
      end

      # Any key of the body, nil when it's missing.
      def [](key)
        @body[key.to_s]
      end

      def dig(*keys)
        @body.dig(*keys.map { |key| key.is_a?(Symbol) ? key.to_s : key })
      end

      # The whole parsed body.
      def to_h
        @body
      end

      def ==(other)
        other.instance_of?(self.class) && other.to_h == @body
      end
      alias eql? ==

      def hash
        [self.class, @body].hash
      end

      def inspect
        "#<#{self.class.name} type=#{type.inspect} event=#{event.inspect}>"
      end

      # Shared by the types that carry a revision to compare against the stored one.
      module Revisioned
        def revision
          @body["revision"]
        end

        # True when this delivery is newer than the revision stored for its subject (or nothing is
        # stored yet). Skip the delivery when false: an older one arrived late.
        def newer_than?(stored_revision)
          return true if stored_revision.nil?
          return false if revision.nil?

          revision > stored_revision
        end
      end
    end

    # A queued request's answer (or error). Deduplicate on `dedupe_key`, page_request_id + state.
    class RequestEvent < Event
      TYPE = "request"

      fields :id, :page_request_id, :state, :page, :iteration_state, :response_json, :response_xml, :error, :links

      def dedupe_key
        "#{page_request_id}:#{state}"
      end

      # `error.error_type` ("timed_out", "outcome_unknown", "retryable", ...), nil without an error.
      def error_type
        error.is_a?(Hash) ? error["error_type"] : nil
      end

      # True when QuickBooks may have applied the request though no answer says so: it
      # `timed_out`, or a write ended in an `error` with `error_type` `outcome_unknown`. Look in
      # QuickBooks (query the record) before sending a write again; a query is safe to resend.
      def perhaps_applied?
        state == "timed_out" || error_type == "timed_out" || error_type == "outcome_unknown"
      end

      # True when the body would have been over 1 MB, so it came without `response_xml` (nil).
      # `response_json` still came; fetch `self_link` (`Client#get_request(event.self_link)`) for
      # the request with `response_xml`.
      def response_xml_omitted?
        @body["response_xml_omitted"] == true
      end

      # `links.self`, the request's URL (v1 or v2, as it was queued). Sent with an omitted
      # `response_xml`; nil otherwise.
      def self_link
        links.is_a?(Hash) ? links["self"] : nil
      end
    end

    # A workflow run that is waiting for an answer, or has ended. Store by `reference` and skip
    # it unless `newer_than?` the revision you stored.
    class WorkflowRunEvent < Event
      include Event::Revisioned

      TYPE = "workflow_run"

      fields :run_id, :reference, :run_state, :workflow, :connection_id, :prompt, :outcome, :output,
             :error, :summary, :cancel_reason, :links

      def awaiting_input?
        event == "workflow_run.awaiting_input"
      end

      def completed?
        event == "workflow_run.completed"
      end

      def failed?
        event == "workflow_run.failed"
      end

      def cancelled?
        event == "workflow_run.cancelled"
      end
    end

    # Data a running workflow sent along. Deduplicate on `delivery_id`; never skip one by revision.
    class NotificationEvent < Event
      TYPE = "notification"

      fields :run_id, :reference, :revision, :delivery_id, :seq, :name, :state, :from, :data

      def dedupe_key
        delivery_id
      end
    end

    # A connection was set up, cancelled, stalled or resumed. Deduplicate on `delivery_id`, and
    # skip it unless `newer_than?` the connection's stored revision.
    class ConnectionEvent < Event
      include Event::Revisioned

      TYPE = "connection"

      fields :delivery_id, :connection

      def connection_id
        connection_hash["id"]
      end

      def stall_reason
        connection_hash["stall_reason"]
      end

      def dedupe_key
        delivery_id
      end

      def connected?
        event == "connection.connected"
      end

      def setup_cancelled?
        event == "connection.setup_cancelled"
      end

      def stalled?
        event == "connection.stalled"
      end

      def resumed?
        event == "connection.resumed"
      end

      private

      def connection_hash
        connection.is_a?(Hash) ? connection : {}
      end
    end

    # A connection's name index finished building, or failed.
    class NameIndexEvent < Event
      TYPE = "name_index"

      fields :connection_id, :name_index
    end

    # Anything this version of the library doesn't know. Never refused: acknowledge it (or log it).
    class UnknownEvent < Event
      TYPE = "unknown"
    end
  end
end
