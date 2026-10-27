# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks transfer inventory operations, reached as `client.transfer_inventory`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class TransferInventory < Base
      # Create transfer inventory: POST /connections/{connection_id}/transfer-inventories
      # (`transfer_inventory.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #   or `txn_line_id` so later requests can reference it with `useMacro`. This feature requires
      #   SDK 2.0+.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `from_inventory_site_ref` (Hash, required): Inventory site that transfer will be taken
      #   from.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `include_ret_element` (Array<one of "EditSequence", "ExternalGUID",
      #   "FromInventorySiteRef", "ListID", "Memo", "OwnerID", "RefNumber", "TimeCreated",
      #   "TimeModified", "ToInventorySiteRef", "TransferInventoryLineRet", "TxnDate", "TxnID",
      #   "TxnNumber">)
      # - `memo` (String): Additional information.
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `to_inventory_site_ref` (Hash, required): Inventory site that transfer will be sent to.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `transfer_inventory_line_add` (Array<Hash>)
      #   - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #     or `txn_line_id` so later requests can reference it with `useMacro`. This feature
      #     requires SDK 2.0+.
      #   - `from_inventory_site_location_ref` (Hash): Location within the inventory site that
      #     transfer will be taken from.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #     depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #     sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #     BillingRateAdd requires a service item. If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `quantity_to_transfer` (Numeric): Quantity of items transferred.
      #   - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `to_inventory_site_location_ref` (Hash): Location within the inventory site that
      #     transfer will be sent to.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/transfer-inventories/create-transfer-inventory
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("transfer_inventory.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List transfer inventories: GET /connections/{connection_id}/transfer-inventories
      # (`transfer_inventory.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `account_filter` (Hash): Filters according to the account name or `list_id`. If the “Use
      #   account numbers” preference is enabled in the QuickBooks company file, you can specify an
      #   account number (instead of an account name) for `full_name` and get the account you’re
      #   looking for. But if numbers have been used as account names, confusion could arise. Choose
      #   at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set
      #   (`account_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`), or
      #   `site_filter`. Members of a set combine with each other, not with the other choices.
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
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `entity_filter` (Hash): An entity refers to a person on the QuickBooks Customer list,
      #   Vendor list, Employee list, or Other Names list. You can use an EntityQuery request to get
      #   information about all the entities that are set up in the QuickBooks file. In an
      #   ARRefundCreditCard query, this must be a customer/customer job. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
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
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `include_line_items` (Boolean): This filter allows you to omit line items from a query
      #   response to get a smaller result. The default value is false, so line items are omitted by
      #   default. Set `include_line_items` to true to include line items in the response if you
      #   don’t mind getting a larger result.
      # - `include_ret_element` (Array<one of "EditSequence", "ExternalGUID",
      #   "FromInventorySiteRef", "Memo", "RefNumber", "TimeCreated", "TimeModified",
      #   "ToInventorySiteRef", "TransferInventoryLineRet", "TxnDate", "TxnID", "TxnNumber">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records (25 with `include_line_items`); send `iterator=true`
      #   with `max_returned` for another size. Off when you send `iterator=false` (every match in
      #   one answer) or `max_returned` alone (at most that many, in one answer). It pages a
      #   filtered query only: with `ref_number`, `ref_number_case_sensitive`, `site_filter` or
      #   `txn_id` every match comes back in one answer, so leave `iterator` out.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `modified_date_range_filter` (Hash): Filters according to the dates when transactions were
      #   last modified. The `modified_date_range_filter` aggregate isn’t required to contain any
      #   elements, but if it is empty, we recommend that you leave it out altogether. Note that the
      #   time portion of the `from_modified_date` and `to_modified_date` fields wasn’t supported in
      #   qbXML version 1.0 or 1.1. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_modified_date` (String): Filters results to objects modified on or after this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to 00:00:00.
      #   - `to_modified_date` (String): Filters results to objects modified on or before this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to end-of-day (23:59:59).
      # - `ref_number` (Array<String>): `ref_number` is a user-managed transaction reference (for
      #   example, a check number). It can be edited and is not guaranteed to be globally unique.
      #   Some transaction types auto-populate `ref_number` when omitted, based on QuickBooks
      #   preferences and numbering state. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
      # - `ref_number_case_sensitive` (Array<String>): Choose at most one of: `txn_id`, or
      #   `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
      # - `ref_number_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `ref_number` (String, required): `ref_number` is a user-managed transaction reference
      #     (for example, a check number). It can be edited and is not guaranteed to be globally
      #     unique. Some transaction types auto-populate `ref_number` when omitted, based on
      #     QuickBooks preferences and numbering state.
      # - `ref_number_range_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_ref_number` (String): The first `ref_number` in the search range. If
      #     `from_ref_number` is omitted, the range will begin with first number on the list.
      #   - `to_ref_number` (String): The final `ref_number` in the search range. If `to_ref_number`
      #     is omitted, the range will end with last number on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `site_filter` (Hash): Allows you to report on Sites. Choose at most one of: `txn_id`, or
      #   `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`), or `site_filter`. Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      # - `txn_date_range_filter` (Hash): Filters according to the original transaction dates.
      #   Choose at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the
      #   set (`account_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`), or
      #   `site_filter`. Members of a set combine with each other, not with the other choices.
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
      #   (`account_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`), or
      #   `site_filter`. Members of a set combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/transfer-inventories/list-transfer-inventories
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("transfer_inventory.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update transfer inventory: PUT /connections/{connection_id}/transfer-inventories
      # (`transfer_inventory.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `from_inventory_site_ref` (Hash): Inventory site that transfer will be taken from.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `include_ret_element` (Array<one of "EditSequence", "ExternalGUID",
      #   "FromInventorySiteRef", "ListID", "Memo", "OwnerID", "RefNumber", "TimeCreated",
      #   "TimeModified", "ToInventorySiteRef", "TransferInventoryLineRet", "TxnDate", "TxnID",
      #   "TxnNumber">)
      # - `memo` (String): Additional information.
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `to_inventory_site_ref` (Hash): Inventory site that transfer will be sent to.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `transfer_inventory_line_mod` (Array<Hash>)
      #   - `from_inventory_site_location_ref` (Hash): Location within the inventory site that
      #     transfer will be taken from.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #     depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #     sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #     BillingRateAdd requires a service item. If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `quantity_to_transfer` (Numeric): Quantity of items transferred.
      #   - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `to_inventory_site_location_ref` (Hash): Location within the inventory site that
      #     transfer will be sent to.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
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
      # @see https://docs.qubesync.com/api-reference/v2/transfer-inventories/update-transfer-inventory
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("transfer_inventory.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
