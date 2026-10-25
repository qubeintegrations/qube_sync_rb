# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks data event recovery info operations, reached as `client.data_event_recovery_info`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class DataEventRecoveryInfo < Base
      # Delete data event recovery info: DELETE
      # /connections/{connection_id}/data-event-recovery-infos (`data_event_recovery_info.delete`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `subscriber_id` (String, required): A unique identifier that an application sets when it
      #   adds a subscription so that the application can later query or delete the subscription.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-event-recovery-infos/delete-data-event-recovery-info
      def delete(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_event_recovery_info.delete", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List data event recovery infos: GET /connections/{connection_id}/data-event-recovery-infos
      # (`data_event_recovery_info.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `subscriber_id` (String, required): A unique identifier that an application sets when it
      #   adds a subscription so that the application can later query or delete the subscription.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-event-recovery-infos/list-data-event-recovery-infos
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_event_recovery_info.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
