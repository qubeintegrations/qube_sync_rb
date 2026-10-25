# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks special item operations, reached as `client.special_item`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class SpecialItem < Base
      # Create special item: POST /connections/{connection_id}/special-items
      # (`special_item.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `bar_code` (Hash): Barcode reference information.
      #   - `allow_override` (Boolean): Allows for barcode to be overridden for an item.
      #   - `assign_even_if_used` (Boolean): Allow barcode to be assigned to item, even if already
      #     in use.
      #   - `bar_code_value` (String): Value of the barcode in the item.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `include_ret_element` (Array<one of "BarCodeValue", "ClassRef", "DataExtRet",
      #   "EditSequence", "ExternalGUID", "FullName", "IsActive", "IsPrintItemsInGroup",
      #   "IsTaxIncluded", "ItemDesc", "ItemGroupLine", "ListID", "Name", "ParentRef",
      #   "SalesAndPurchase", "SalesOrPurchase", "SalesTaxCodeRef", "SpecialItemType", "Sublevel",
      #   "TimeCreated", "TimeModified", "UnitOfMeasureSetRef">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `special_item_type` (one of "FinanceCharge", "ReimbursableExpenseGroup",
      #   "ReimbursableExpenseSubtotal", required): Identifies the type of special item. See type
      #   for possible enum values.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/special-items/create-special-item
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("special_item.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
