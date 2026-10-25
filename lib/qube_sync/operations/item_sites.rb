# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks item sites operations, reached as `client.item_sites`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ItemSites < Base
      # List item sites: GET /connections/{connection_id}/item-sites (`item_sites.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active.
      # - `include_ret_element` (Array<one of "AssemblyBuildPoint", "EditSequence",
      #   "InventorySiteLocationRef", "InventorySiteRef", "ItemInventoryAssemblyRef",
      #   "ItemInventoryRef", "ListID", "QuantityOnHand", "QuantityOnPendingTransfers",
      #   "QuantityOnPurchaseOrders", "QuantityOnSalesOrders", "QuantityRequiredByPendingBuildTxns",
      #   "QuantityToBeBuiltByPendingBuildTxns", "ReorderLevel", "TimeCreated", "TimeModified">)
      # - `item_site_filter` (Hash): Allows you to report on Item Sites. Choose at most one of:
      #   `list_id`, or the set (`item_site_filter`, `item_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   - `item_filter` (Hash): Filters according to the item name or ID. You can use an ItemQuery
      #     request to get information about all the items that are set up in the QuickBooks file.
      #     “Items” are line items used for fast entry on sales and purchase forms. They include
      #     services and goods that a business buys and sells, as well as special items that perform
      #     calculations–for example, subtotal, discount, and sales-tax items.
      #     Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #     `full_name_with_children`.
      #     - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #       list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #       specified object and its descendants. For names that don’t have children,
      #       `full_name_with_children` is exactly the same as `full_name`.
      #     - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #       QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #       within a list type, not globally across all lists. If both `full_name` and `list_id`
      #       are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #       specified object and its descendants.
      #   - `site_filter` (Hash): Allows you to report on Sites.
      #     Give at most one of: `list_id`, or `full_name`.
      #     - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #       list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #       QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #       within a list type, not globally across all lists. If both `full_name` and `list_id`
      #       are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `item_type_filter` (one of "AllExceptFixedAsset", "Assembly", "Discount", "FixedAsset",
      #   "Inventory", "InventoryAndAssembly", "NonInventory", "OtherCharge", "Payment", "Sales",
      #   "SalesTax", "Service"): Allows you to report on a specific item type. Choose at most one
      #   of: `list_id`, or the set (`item_site_filter`, `item_type_filter`). Members of a set
      #   combine with each other, not with the other choices.
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records; send `iterator=true` with `max_returned` for another
      #   size. Off when you send `iterator=false` (every match in one answer) or `max_returned`
      #   alone (at most that many, in one answer).
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`. Choose at most
      #   one of: `list_id`, or the set (`item_site_filter`, `item_type_filter`). Members of a set
      #   combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched.
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
      # @see https://docs.qubesync.com/api-reference/v2/item-sites/list-item-sites
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_sites.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
