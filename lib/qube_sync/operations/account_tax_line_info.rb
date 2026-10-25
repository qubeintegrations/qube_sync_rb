# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks account tax line info operations, reached as `client.account_tax_line_info`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class AccountTaxLineInfo < Base
      # List account tax line infos: GET /connections/{connection_id}/account-tax-line-infos
      # (`account_tax_line_info.query`).
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
      # @see https://docs.qubesync.com/api-reference/v2/account-tax-line-infos/list-account-tax-line-infos
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("account_tax_line_info.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
