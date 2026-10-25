# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks preferences operations, reached as `client.preferences`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Preferences < Base
      # List preferences: GET /connections/{connection_id}/preferences (`preferences.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `include_ret_element` (Array<one of "AccountingPreferences", "CurrentAppAccessRights",
      #   "FinanceChargePreferences", "ItemsAndInventoryPreferences", "JobsAndEstimatesPreferences",
      #   "MultiCurrencyPreferences", "MultiLocationInventoryPreferences",
      #   "PurchasesAndVendorsPreferences", "ReportsPreferences", "SalesAndCustomersPreferences",
      #   "SalesTaxPreferences", "TimeTrackingPreferences">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/preferences/list-preferences
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("preferences.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update preferences: PUT /connections/{connection_id}/preferences (`preferences.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `accounting_preferences_mod` (Hash, required)
      #   - `closing_date` (String)
      #   - `closing_date_password` (String)
      # - `include_ret_element` (Array<one of "AccountingPreferences", "CurrentAppAccessRights",
      #   "FinanceChargePreferences", "ItemsAndInventoryPreferences", "JobsAndEstimatesPreferences",
      #   "MultiCurrencyPreferences", "MultiLocationInventoryPreferences",
      #   "PurchasesAndVendorsPreferences", "ReportsPreferences", "SalesAndCustomersPreferences",
      #   "SalesTaxPreferences", "TimeTrackingPreferences">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/preferences/update-preferences
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("preferences.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
