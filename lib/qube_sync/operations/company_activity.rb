# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks company activity operations, reached as `client.company_activity`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class CompanyActivity < Base
      # List company activities: GET /connections/{connection_id}/company-activities
      # (`company_activity.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `include_ret_element` (Array<one of "LastCondenseTime", "LastRestoreTime">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/company-activities/list-company-activities
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("company_activity.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
