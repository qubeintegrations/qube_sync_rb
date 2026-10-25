# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks list display operations, reached as `client.list_display`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ListDisplay < Base
      # Create list display: POST /connections/{connection_id}/list-displays
      # (`list_display.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `list_display_add_type` (one of "Account", "Customer", "Employee", "Item", "OtherName",
      #   "Vendor", required): Specifies the type of QuickBooks list for which to open an “add” form
      #   in the QuickBooks UI.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/list-displays/create-list-display
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("list_display.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update list display: PUT /connections/{connection_id}/list-displays (`list_display.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `list_display_mod_type` (one of "Account", "Customer", "Employee", "Item", "OtherName",
      #   "Vendor", required): The type of QuickBooks list element to open for modification in the
      #   QuickBooks UI. (`list_id` specifies the particular list element.)
      # - `list_id` (String, required): `list_id` and FullName both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both FullName and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores FullName.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/list-displays/update-list-display
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("list_display.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
