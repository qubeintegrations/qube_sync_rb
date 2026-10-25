# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks transaction operations, reached as `client.transaction`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Transaction < Base
      # List transactions: GET /connections/{connection_id}/transactions (`transaction.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `currency_filter` (Hash): Filters by the specified currency. Choose at most one of:
      #   `txn_id`, or the set (`currency_filter`, `max_returned`, `ref_number`,
      #   `ref_number_case_sensitive`, `ref_number_filter`, `ref_number_range_filter`,
      #   `transaction_account_filter`, `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `include_ret_element` (Array<one of "AccountRef", "Amount", "AmountInHomeCurrency",
      #   "CurrencyRef", "EntityRef", "ExchangeRate", "Memo", "RefNumber", "TimeCreated",
      #   "TimeModified", "TxnDate", "TxnID", "TxnLineID", "TxnType">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records; send `iterator=true` with `max_returned` for another
      #   size. Off when you send `iterator=false` (every match in one answer) or `max_returned`
      #   alone (at most that many, in one answer). It pages a filtered query only: with `txn_id`
      #   every match comes back in one answer, so leave `iterator` out.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `txn_id`, or the set (`currency_filter`,
      #   `max_returned`, `ref_number`, `ref_number_case_sensitive`, `ref_number_filter`,
      #   `ref_number_range_filter`, `transaction_account_filter`, `transaction_class_filter`,
      #   `transaction_date_range_filter`, `transaction_detail_level_filter`,
      #   `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `ref_number` (Array<String>): `ref_number` is a user-managed transaction reference (for
      #   example, a check number). It can be edited and is not guaranteed to be globally unique.
      #   Some transaction types auto-populate `ref_number` when omitted, based on QuickBooks
      #   preferences and numbering state. Choose at most one of: `txn_id`, or the set
      #   (`currency_filter`, `max_returned`, `ref_number`, `ref_number_case_sensitive`,
      #   `ref_number_filter`, `ref_number_range_filter`, `transaction_account_filter`,
      #   `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `ref_number_case_sensitive` (Array<String>): Choose at most one of: `txn_id`, or the set
      #   (`currency_filter`, `max_returned`, `ref_number`, `ref_number_case_sensitive`,
      #   `ref_number_filter`, `ref_number_range_filter`, `transaction_account_filter`,
      #   `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `ref_number_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or the set (`currency_filter`, `max_returned`, `ref_number`,
      #   `ref_number_case_sensitive`, `ref_number_filter`, `ref_number_range_filter`,
      #   `transaction_account_filter`, `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `ref_number` (String, required): `ref_number` is a user-managed transaction reference
      #     (for example, a check number). It can be edited and is not guaranteed to be globally
      #     unique. Some transaction types auto-populate `ref_number` when omitted, based on
      #     QuickBooks preferences and numbering state.
      # - `ref_number_range_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or the set (`currency_filter`, `max_returned`, `ref_number`,
      #   `ref_number_case_sensitive`, `ref_number_filter`, `ref_number_range_filter`,
      #   `transaction_account_filter`, `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   - `from_ref_number` (String): The first `ref_number` in the search range. If
      #     `from_ref_number` is omitted, the range will begin with first number on the list.
      #   - `to_ref_number` (String): The final `ref_number` in the search range. If `to_ref_number`
      #     is omitted, the range will end with last number on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `transaction_account_filter` (Hash): Filters the transactions based on the `account_ref`
      #   in the transaction or transaction line using an account type filter or a specific
      #   `list_id`, or a `full_name`, or a `list_id_with_children`, or a `full_name_with_children`.
      #   To filter on transaction lines, you must specify the `transaction_detail_level_filter`
      #   with a value of either “All” or “AllExceptSummary”. Choose at most one of: `txn_id`, or
      #   the set (`currency_filter`, `max_returned`, `ref_number`, `ref_number_case_sensitive`,
      #   `ref_number_filter`, `ref_number_range_filter`, `transaction_account_filter`,
      #   `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   Give at most one of: `account_type_filter`, or `list_id`, or `full_name`, or
      #   `list_id_with_children`, or `full_name_with_children`.
      #   - `account_type_filter` (one of "APAndSalesTax", "APOrCreditCard", "ARAndAP",
      #     "AccountsPayable", "AccountsReceivable", "AllowedFor1099", "Asset", "BalanceSheet",
      #     "Bank", "BankAndARAndAPAndUF", "BankAndUF", "CostOfSales", "CreditCard", "CurrentAsset",
      #     "CurrentAssetAndExpense", "CurrentLiability", "Equity", "EquityAndIncomeAndExpense",
      #     "ExpenseAndOtherExpense", "FixedAsset", "IncomeAndExpense", "IncomeAndOtherIncome",
      #     "Liability", "LiabilityAndEquity", "LongTermLiability", "NonPosting", "OrdinaryExpense",
      #     "OrdinaryIncome", "OrdinaryIncomeAndCOGS", "OrdinaryIncomeAndExpense", "OtherAsset",
      #     "OtherCurrentAsset", "OtherCurrentLiability", "OtherExpense", "OtherIncome",
      #     "OtherIncomeOrExpense"): Allows you to report on a specific account type.
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
      # - `transaction_class_filter` (Hash): Filters the transactions based on the ClassRef in the
      #   transaction or transaction line by using a specific `list_id`, or a `full_name`, or a
      #   `list_id_with_children`, or a `full_name_with_children`. To filter on transaction lines,
      #   you must specify the `transaction_detail_level_filter` with a value of either “All” or
      #   “AllExceptSummary”. Choose at most one of: `txn_id`, or the set (`currency_filter`,
      #   `max_returned`, `ref_number`, `ref_number_case_sensitive`, `ref_number_filter`,
      #   `ref_number_range_filter`, `transaction_account_filter`, `transaction_class_filter`,
      #   `transaction_date_range_filter`, `transaction_detail_level_filter`,
      #   `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
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
      # - `transaction_date_range_filter` (Hash): Filters the transactions based on the
      #   transaction’s date either by specifying a “from” and/or “to” date, or by using a
      #   `date_macro`. Choose at most one of: `txn_id`, or the set (`currency_filter`,
      #   `max_returned`, `ref_number`, `ref_number_case_sensitive`, `ref_number_filter`,
      #   `ref_number_range_filter`, `transaction_account_filter`, `transaction_class_filter`,
      #   `transaction_date_range_filter`, `transaction_detail_level_filter`,
      #   `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
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
      #     `from_txn_date` and `to_txn_date` must be between 01/01/1901 and 12/31/9999. If you omit
      #     `from_txn_date`, it will be set to 1970-01-01 (1969-12-31 PST).
      #   - `to_txn_date` (String): Selects transactions created on or before this date. Both
      #     `to_txn_date` and `from_txn_date` must be between 01/01/1901 and 12/31/9999. If you omit
      #     `to_txn_date`, it will be set to 2038-01-19 (2038-01-18 PST).
      # - `transaction_detail_level_filter` (one of "All", "AllExceptSummary", "SummaryOnly"):
      #   Allows you to specify the detail level of the query results. You can specify all, summary
      #   only (the default), or all except summary. Summary only refers to the transaction as a
      #   whole, whereas all except summary refers to the transaction lines. Choose at most one of:
      #   `txn_id`, or the set (`currency_filter`, `max_returned`, `ref_number`,
      #   `ref_number_case_sensitive`, `ref_number_filter`, `ref_number_range_filter`,
      #   `transaction_account_filter`, `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `transaction_entity_filter` (Hash): Filters the transactions based on the `entity_ref`
      #   used in the transaction or transaction line by specifying an entity type filter, a
      #   `list_id`, a `full_name`, a `list_id_with_children`, or a `full_name_with_children`. If
      #   you want to filter on transaction lines you must specify the
      #   `transaction_detail_level_filter` with a value of either “All” or “AllExceptSummary”.
      #   Choose at most one of: `txn_id`, or the set (`currency_filter`, `max_returned`,
      #   `ref_number`, `ref_number_case_sensitive`, `ref_number_filter`, `ref_number_range_filter`,
      #   `transaction_account_filter`, `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   Give at most one of: `entity_type_filter`, or `list_id`, or `full_name`, or
      #   `list_id_with_children`, or `full_name_with_children`.
      #   - `entity_type_filter` (one of "Customer", "Employee", "OtherName", "Vendor"): Allows you
      #     to report on a specific name type.
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
      # - `transaction_item_filter` (Hash): Filters the transactions based on the ItemRef used in
      #   the transaction line using an item type filter, or a specific `list_id`, or a `full_name`,
      #   or a `list_id_with_children`, or a `full_name_with_children`. To filter on transaction
      #   lines, you must specify the `transaction_detail_level_filter` with a value of either “All”
      #   or “AllExceptSummary”. Choose at most one of: `txn_id`, or the set (`currency_filter`,
      #   `max_returned`, `ref_number`, `ref_number_case_sensitive`, `ref_number_filter`,
      #   `ref_number_range_filter`, `transaction_account_filter`, `transaction_class_filter`,
      #   `transaction_date_range_filter`, `transaction_detail_level_filter`,
      #   `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   Give at most one of: `item_type_filter`, or `list_id`, or `full_name`, or
      #   `list_id_with_children`, or `full_name_with_children`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `item_type_filter` (one of "AllExceptFixedAsset", "Assembly", "Discount", "FixedAsset",
      #     "Inventory", "InventoryAndAssembly", "NonInventory", "OtherCharge", "Payment", "Sales",
      #     "SalesTax", "Service"): Allows you to report on a specific item type.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `transaction_modified_date_range_filter` (Hash): Filters the transactions based on the
      #   transaction’s modified datetime, either by specifying a “from” and/or “to” date or by
      #   using a `date_macro`. Choose at most one of: `txn_id`, or the set (`currency_filter`,
      #   `max_returned`, `ref_number`, `ref_number_case_sensitive`, `ref_number_filter`,
      #   `ref_number_range_filter`, `transaction_account_filter`, `transaction_class_filter`,
      #   `transaction_date_range_filter`, `transaction_detail_level_filter`,
      #   `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   Give at most one of: `from_modified_date` with `to_modified_date`, or `date_macro`.
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
      #   - `from_modified_date` (String): Filters results to objects modified on or after this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to 00:00:00.
      #   - `to_modified_date` (String): Filters results to objects modified on or before this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to end-of-day (23:59:59).
      # - `transaction_paid_status_filter` (one of "Closed", "Either", "Open"): This filter allows
      #   you to search for “open” transactions, i.e. transactions with a remaining balance (for
      #   example, credits not fully applied or invoices not fully paid). Valid values are closed,
      #   open, or either, which is the default. Choose at most one of: `txn_id`, or the set
      #   (`currency_filter`, `max_returned`, `ref_number`, `ref_number_case_sensitive`,
      #   `ref_number_filter`, `ref_number_range_filter`, `transaction_account_filter`,
      #   `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `transaction_posting_status_filter` (one of "Either", "NonPosting", "Posting"): Allows you
      #   to filter transactions based on posting status. Valid values are posting, non-posting, or
      #   either. The default is “either.” (Posting status refers to whether QuickBooks records a
      #   transaction in one of your account registers.) Choose at most one of: `txn_id`, or the set
      #   (`currency_filter`, `max_returned`, `ref_number`, `ref_number_case_sensitive`,
      #   `ref_number_filter`, `ref_number_range_filter`, `transaction_account_filter`,
      #   `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `transaction_type_filter` (Hash): Filters the transactions based on the transaction’s
      #   type. You can specify one or more transaction types in the filter. Notice that
      #   TimeTracking transactions aren’t supported. If you set the transaction type filter to
      #   “All” (or if you don’t set it at all), the query will be searching only those transaction
      #   types that are permissible types for the user currently logged in. Choose at most one of:
      #   `txn_id`, or the set (`currency_filter`, `max_returned`, `ref_number`,
      #   `ref_number_case_sensitive`, `ref_number_filter`, `ref_number_range_filter`,
      #   `transaction_account_filter`, `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #   - `txn_type_filter` (Array<one of "ARRefundCreditCard", "All", "Bill", "BillPaymentCheck",
      #     "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check", "CreditCardCharge",
      #     "CreditCardCredit", "CreditMemo", "Deposit", "Estimate", "InventoryAdjustment",
      #     "Invoice", "ItemReceipt", "JournalEntry", "LiabilityAdjustment", "Paycheck",
      #     "PayrollLiabilityCheck", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #     "SalesReceipt", "SalesTaxPaymentCheck", "Transfer", "VendorCredit", "YTDAdjustment">,
      #     required)
      # - `txn_id` (Array<String>): `txn_id` is the unique QuickBooks identifier for a transaction.
      #   Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types. Choose
      #   at most one of: `txn_id`, or the set (`currency_filter`, `max_returned`, `ref_number`,
      #   `ref_number_case_sensitive`, `ref_number_filter`, `ref_number_range_filter`,
      #   `transaction_account_filter`, `transaction_class_filter`, `transaction_date_range_filter`,
      #   `transaction_detail_level_filter`, `transaction_entity_filter`, `transaction_item_filter`,
      #   `transaction_modified_date_range_filter`, `transaction_paid_status_filter`,
      #   `transaction_posting_status_filter`, `transaction_type_filter`). Members of a set combine
      #   with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/transactions/list-transactions
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("transaction.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
