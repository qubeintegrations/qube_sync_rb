# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks alert operations, reached as `client.alert`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Alert < Base
      # Create alert: POST /connections/{connection_id}/alerts (`alert.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # Give at most one of: `com_callback_info`, or `http_callback_info`.
      # - `activation_date` (String)
      # - `alert_permission` (Hash)
      #   - `permission_level` (Array<one of "AccountsPayable", "AccountsReceivable", "Banking",
      #     "Finance", "Inventory", "TimeTracking">, required)
      #   - `permission_needed` (one of "All", "Any", required)
      # - `alert_tag` (String, required)
      # - `com_callback_info` (Hash)
      #   Give at most one of: `prog_id`, or `clsid`.
      #   - `app_name` (String, required)
      #   - `clsid` (String)
      #   - `prog_id` (String)
      # - `desc` (String, required)
      # - `expiration_date` (String)
      # - `help_text` (String, required)
      # - `http_callback_info` (Hash)
      #   - `url` (String, required)
      # - `message_text` (String, required)
      # - `owner_id` (String, required)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `ui_context` (Array<one of "AlertsManager", "CompanyNavigator">)
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/alerts/create-alert
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("alert.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Delete alert: DELETE /connections/{connection_id}/alerts (`alert.delete`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `alert_tag` (String, required)
      # - `owner_id` (String, required)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/alerts/delete-alert
      def delete(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("alert.delete", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List alerts: GET /connections/{connection_id}/alerts (`alert.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData")
      # - `owner_id` (Array<String>, required)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/alerts/list-alerts
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("alert.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
