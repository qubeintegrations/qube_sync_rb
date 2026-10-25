# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll last period operations, reached as `client.payroll_last_period`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollLastPeriod < Base
      # List payroll last periods: GET /connections/{connection_id}/payroll-last-periods
      # (`payroll_last_period.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-last-periods/list-payroll-last-periods
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_last_period.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
