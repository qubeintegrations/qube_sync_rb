# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks sales tax payable operations, reached as `client.sales_tax_payable`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class SalesTaxPayable < Base
      # List sales tax payables: GET /connections/{connection_id}/sales-tax-payables
      # (`sales_tax_payable.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `as_of_date` (String): The date when the exchange rate was last changed.
      # - `include_ret_element` (Array<one of "Amount", "PayeeEntityRef", "SalesTaxPayableLineRet">)
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/sales-tax-payables/list-sales-tax-payables
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("sales_tax_payable.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
