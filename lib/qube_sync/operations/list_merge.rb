# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks list merge operations, reached as `client.list_merge`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ListMerge < Base
      # Execute list merge: POST /connections/{connection_id}/list-merge (`list_merge.execute`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `list_merge_type` (one of "Account", "Class", "Customer", "ItemDiscount", "ItemGroup",
      #   "ItemInventory", "ItemNonInventory", "ItemOtherCharge", "ItemPayment", "ItemSalesTax",
      #   "ItemSalesTaxGroup", "ItemService", "ItemSubtotal", "Vendor", required): The type of the
      #   objects to be merged. Both of the objects must be the same type, for example both must be
      #   customers, because you can’t merge a vendor with a customer.
      # - `merge_from` (Hash, required): The object to be merged into another object.
      #   - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision
      #     token. It changes each time the object is updated. To modify an existing object, you
      #     must send the current `edit_sequence`. If your value is stale, the update is rejected to
      #     prevent overwriting newer changes.
      #   - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      # - `merge_to` (Hash, required): The object into which you are merging another object.
      #   - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision
      #     token. It changes each time the object is updated. To modify an existing object, you
      #     must send the current `edit_sequence`. If your value is stale, the update is rejected to
      #     prevent overwriting newer changes.
      #   - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `same_ship_addr_ok` (Boolean): A new tag (SameshipAddressOk) is added to ListMerge
      #   request. If true is supplied in this tag then the merge will go through even if elements
      #   have same default shipto address.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/list-merge/execute-list-merge
      def execute(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("list_merge.execute", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
