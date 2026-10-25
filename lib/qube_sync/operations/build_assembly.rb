# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks build assembly operations, reached as `client.build_assembly`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class BuildAssembly < Base
      # Create build assembly: POST /connections/{connection_id}/build-assemblies
      # (`build_assembly.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #   or TxnLineID so later requests can reference it with `useMacro`. This feature requires SDK
      #   2.0+.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `include_ret_element` (Array<one of "ComponentItemLineRet", "DataExtRet", "EditSequence",
      #   "ExpirationDateForSerialLotNumber", "ExternalGUID", "InventorySiteLocationRef",
      #   "InventorySiteRef", "IsPending", "ItemInventoryAssemblyRef", "ListID", "LotNumber",
      #   "Memo", "OwnerID", "QuantityCanBuild", "QuantityOnHand", "QuantityOnSalesOrder",
      #   "QuantityToBuild", "RefNumber", "SerialNumber", "TimeCreated", "TimeModified", "TxnDate",
      #   "TxnID", "TxnNumber">)
      # - `inventory_site_location_ref` (Hash): Location within the Inventory Site
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `inventory_site_ref` (Hash): Site where inventory is located.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `item_inventory_assembly_ref` (Hash, required): An inventory assembly item is one that is
      #   assembled or manufactured from inventory items. The items and/or assemblies that make up
      #   the assembly are called components. For Premier, an assembly can have a maximum of 100
      #   components. For Enterprise, the maximum is 500 components.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #   `serial_number`, or `lot_number`.
      # - `mark_pending_if_required` (Boolean): Allows the build assembly to be marked pending if
      #   there are insufficient quantities to complete the build assembly.
      # - `memo` (String): Additional information.
      # - `quantity_to_build` (Numeric, required): Specifies the number of assemblies to be built.
      #   The transaction will fail if the number specified here exceeds the number of on-hand
      #   components.
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #   `serial_number`, or `lot_number`.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/build-assemblies/create-build-assembly
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("build_assembly.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List build assemblies: GET /connections/{connection_id}/build-assemblies
      # (`build_assembly.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `include_component_line_items` (Boolean): Specify “true” if component line items for each
      #   returned transaction are to be included in the returned data. Specify “false” if the line
      #   items aren’t be returned.
      # - `include_ret_element` (Array<one of "ComponentItemLineRet", "DataExtRet", "EditSequence",
      #   "ExpirationDateForSerialLotNumber", "ExternalGUID", "InventorySiteLocationRef",
      #   "InventorySiteRef", "IsPending", "ItemInventoryAssemblyRef", "LotNumber", "Memo",
      #   "QuantityCanBuild", "QuantityOnHand", "QuantityOnSalesOrder", "QuantityToBuild",
      #   "RefNumber", "SerialNumber", "TimeCreated", "TimeModified", "TxnDate", "TxnID",
      #   "TxnNumber">)
      # - `item_filter` (Hash): Filters according to the item name or ID. You can use an ItemQuery
      #   request to get information about all the items that are set up in the QuickBooks file.
      #   “Items” are line items used for fast entry on sales and purchase forms. They include
      #   services and goods that a business buys and sells, as well as special items that perform
      #   calculations–for example, subtotal, discount, and sales-tax items. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`item_filter`,
      #   `max_returned`, `modified_date_range_filter`, `pending_status`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #   `full_name_with_children`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records; send `iterator=true` with `max_returned` for another
      #   size. Off when you send `iterator=false` (every match in one answer) or `max_returned`
      #   alone (at most that many, in one answer). It pages a filtered query only: with
      #   `ref_number`, `ref_number_case_sensitive` or `txn_id` every match comes back in one
      #   answer, so leave `iterator` out.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`item_filter`, `max_returned`,
      #   `modified_date_range_filter`, `pending_status`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `modified_date_range_filter` (Hash): Filters according to the dates when transactions were
      #   last modified. The `modified_date_range_filter` aggregate isn’t required to contain any
      #   elements, but if it is empty, we recommend that you leave it out altogether. Choose at
      #   most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set
      #   (`item_filter`, `max_returned`, `modified_date_range_filter`, `pending_status`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_modified_date` (String): Filters results to objects modified on or after this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to 00:00:00.
      #   - `to_modified_date` (String): Filters results to objects modified on or before this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to end-of-day (23:59:59).
      # - `owner_id` (Array<String>): `owner_id` identifies who owns the data extension. Use 0 for
      #   QuickBooks custom fields that appear in the UI, or use a GUID for private extensions owned
      #   by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `pending_status` (one of "All", "NotPendingOnly", "PendingOnly"): Specifies whether the
      #   transaction is pending (posted) or not. Choose at most one of: `txn_id`, or `ref_number`,
      #   or `ref_number_case_sensitive`, or the set (`item_filter`, `max_returned`,
      #   `modified_date_range_filter`, `pending_status`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      # - `ref_number` (Array<String>): `ref_number` is a user-managed transaction reference (for
      #   example, a check number). It can be edited and is not guaranteed to be globally unique.
      #   Some transaction types auto-populate `ref_number` when omitted, based on QuickBooks
      #   preferences and numbering state. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`item_filter`, `max_returned`,
      #   `modified_date_range_filter`, `pending_status`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      # - `ref_number_case_sensitive` (Array<String>): Choose at most one of: `txn_id`, or
      #   `ref_number`, or `ref_number_case_sensitive`, or the set (`item_filter`, `max_returned`,
      #   `modified_date_range_filter`, `pending_status`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      # - `ref_number_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`item_filter`,
      #   `max_returned`, `modified_date_range_filter`, `pending_status`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `ref_number` (String, required): `ref_number` is a user-managed transaction reference
      #     (for example, a check number). It can be edited and is not guaranteed to be globally
      #     unique. Some transaction types auto-populate `ref_number` when omitted, based on
      #     QuickBooks preferences and numbering state.
      # - `ref_number_range_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`item_filter`,
      #   `max_returned`, `modified_date_range_filter`, `pending_status`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      #   - `from_ref_number` (String): The first `ref_number` in the search range. If
      #     `from_ref_number` is omitted, the range will begin with first number on the list.
      #   - `to_ref_number` (String): The final `ref_number` in the search range. If `to_ref_number`
      #     is omitted, the range will end with last number on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_date_range_filter` (Hash): Filters according to the original transaction dates.
      #   Choose at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the
      #   set (`item_filter`, `max_returned`, `modified_date_range_filter`, `pending_status`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `from_txn_date` with `to_txn_date`, or `date_macro`.
      #   - `date_macro` (one of "All", "LastCalendarQuarter", "LastCalendarQuarterToDate",
      #     "LastCalendarYear", "LastCalendarYearToDate", "LastFiscalQuarter",
      #     "LastFiscalQuarterToDate", "LastFiscalYear", "LastFiscalYearToDate", "LastMonth",
      #     "LastMonthToDate", "LastWeek", "LastWeekToDate", "NextCalendarQuarter",
      #     "NextCalendarYear", "NextFiscalQuarter", "NextFiscalYear", "NextFourWeeks", "NextMonth",
      #     "NextWeek", "ThisCalendarQuarter", "ThisCalendarQuarterToDate", "ThisCalendarYear",
      #     "ThisCalendarYearToDate", "ThisFiscalQuarter", "ThisFiscalQuarterToDate",
      #     "ThisFiscalYear", "ThisFiscalYearToDate", "ThisMonth", "ThisMonthToDate", "ThisWeek",
      #     "ThisWeekToDate", "Today", "Yesterday"): `date_macro` filters by transaction date (not
      #     last-modified date). Do not combine `date_macro` with
      #     `from_modified_date`/`to_modified_date` in the same query filter set.
      #   - `from_txn_date` (String): Selects transactions created on or after this date. Both
      #     `from_txn_date` and `to_txn_date` must be between 01/01/1901 and 12/31/9999.If you omit
      #     `from_txn_date`, it will be set to 1970-01-01 (1969-12-31 PST).
      #   - `to_txn_date` (String): Selects transactions created on or before this date. Both
      #     `to_txn_date` and `from_txn_date` must be between 01/01/1901 and 12/31/9999. If you omit
      #     `to_txn_date`, it will be set to 2038-01-19 (2038-01-18 PST).
      # - `txn_id` (Array<String>): `txn_id` is the unique QuickBooks identifier for a transaction.
      #   Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types. Choose
      #   at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set
      #   (`item_filter`, `max_returned`, `modified_date_range_filter`, `pending_status`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/build-assemblies/list-build-assemblies
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("build_assembly.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update build assembly: PUT /connections/{connection_id}/build-assemblies
      # (`build_assembly.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `include_ret_element` (Array<one of "ComponentItemLineRet", "DataExtRet", "EditSequence",
      #   "ExpirationDateForSerialLotNumber", "ExternalGUID", "InventorySiteLocationRef",
      #   "InventorySiteRef", "IsPending", "ItemInventoryAssemblyRef", "ListID", "LotNumber",
      #   "Memo", "OwnerID", "QuantityCanBuild", "QuantityOnHand", "QuantityOnSalesOrder",
      #   "QuantityToBuild", "RefNumber", "SerialNumber", "TimeCreated", "TimeModified", "TxnDate",
      #   "TxnID", "TxnNumber">)
      # - `inventory_site_location_ref` (Hash): Location within the Inventory Site
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `inventory_site_ref` (Hash): Site where inventory is located.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #   `serial_number`, or `lot_number`.
      # - `mark_pending_if_required` (Boolean): Allows the build assembly to be marked pending if
      #   there are insufficient quantities to complete the build assembly.
      # - `memo` (String): Additional information.
      # - `quantity_to_build` (Numeric): Specifies the number of assemblies to be built. The
      #   transaction will fail if the number specified here exceeds the number of on-hand
      #   components.
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `remove_pending` (Boolean): Changes the transaction’s pending status from Pending to non
      #   pending. In BuildAssembly transactions, this effectively does the build transaction.
      #   Hence, removing the Pending status will fail if there aren’t enough components on hand for
      #   the build.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #   `serial_number`, or `lot_number`.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/build-assemblies/update-build-assembly
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("build_assembly.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
