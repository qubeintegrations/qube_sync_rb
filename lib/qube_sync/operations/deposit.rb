# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks deposit operations, reached as `client.deposit`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Deposit < Base
      # Create deposit: POST /connections/{connection_id}/deposits (`deposit.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `cash_back_info_add` (Hash): This aggregate is included if there is cash back from this
      #   deposit. `account_ref` indicates where the cash back Amount is going (for example, into a
      #   petty cash account).
      #   - `account_ref` (Hash, required): `account_ref` points to an account in the company file.
      #     If both `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends
      #     on context: for checks it is the funding account; for ExpenseLineAdd it may be required
      #     by accounting preferences; for credit-card transactions it identifies the bank or card
      #     account involved.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #     or `txn_line_id` so later requests can reference it with `useMacro`. This feature
      #     requires SDK 2.0+.
      #   - `memo` (String): Additional information.
      # - `currency_ref` (Hash): A currency record defines how QuickBooks stores and displays a
      #   currency. Built-in currency name/code values are fixed; formatting and active status can
      #   vary by settings and workflow.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #   or `txn_line_id` so later requests can reference it with `useMacro`. This feature requires
      #   SDK 2.0+.
      # - `deposit_line_add` (Array<Hash>)
      #   - `account_ref` (Hash): `account_ref` points to an account in the company file. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #     context: for checks it is the funding account; for ExpenseLineAdd it may be required by
      #     accounting preferences; for credit-card transactions it identifies the bank or card
      #     account involved. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `amount` (Numeric): A monetary amount. Choose exactly one of: the set
      #     (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #   - `check_number` (String): The check number of a check that a QuickBooks user writes or
      #     receives from someone else. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `class_ref` (Hash): Use classes to categorize transactions (for example, by department,
      #     location, or work type). Class tracking is off by default in QuickBooks. A `class_ref`
      #     points to one class; if both `full_name` and `list_id` are provided, `full_name` is
      #     ignored. In InvoiceAdd, a header-level `class_ref` is applied to line items unless you
      #     override or clear it on individual lines. Choose exactly one of: the set
      #     (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #     or `txn_line_id` so later requests can reference it with `useMacro`. This feature
      #     requires SDK 2.0+.
      #   - `entity_ref` (Hash): A QuickBooks “entity” is a customer, vendor, employee, or person on
      #     the QuickBooks “other names” list. Special cases to note: In a BillToPayQuery message,
      #     `entity_ref` refers to the vendor name. In JournalCreditLine and JournalDebitLine
      #     messages for A/R accounts, `entity_ref` must refer to a customer, or else the
      #     transaction won’t be recorded. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `memo` (String): Additional information. Choose exactly one of: the set
      #     (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #   - `override_check_number` (String): Deposit line check number. Choose exactly one of: the
      #     set (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #   - `override_class_ref` (Hash): Deposit line class reference. Choose exactly one of: the
      #     set (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `override_memo` (String): Depost line memo additional information. Choose exactly one
      #     of: the set (`override_check_number`, `override_class_ref`, `override_memo`,
      #     `payment_txn_id`, `payment_txn_line_id`), or the set (`account_ref`, `amount`,
      #     `check_number`, `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a
      #     set combine with each other, not with the other choices.
      #   - `payment_method_ref` (Hash): `payment_method_ref` identifies how a payment is made (for
      #     example, cash, check, or card type). If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `payment_txn_id` (String): For the `payment_txn_id`, use either of these two values:A
      #     `txn_id` value exactly as it is returned by the ReceivePaymentToDepositQuery request, or
      #     A `txn_id` value exactly as it is returned in a ReceivePaymentAdd response. Choose
      #     exactly one of: the set (`override_check_number`, `override_class_ref`, `override_memo`,
      #     `payment_txn_id`, `payment_txn_line_id`), or the set (`account_ref`, `amount`,
      #     `check_number`, `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a
      #     set combine with each other, not with the other choices.
      #   - `payment_txn_line_id` (String): For the `payment_txn_line_id`, use a `txn_line_id` value
      #     exactly as it has been returned by the ReceivePaymentToDepositQuery request. If you
      #     don’t include a `payment_txn_line_id` and include a `payment_txn_id` for a transaction
      #     that includes payment lines, only the first payment line from that transaction will be
      #     deposited. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      # - `deposit_to_account_ref` (Hash, required): Refers to the account where these funds will be
      #   (or have been) deposited. In a ReceivePaymentAdd request, the default is Undeposited Funds
      #   if this isn’t included in the request. In a request, if a `deposit_to_account_ref`
      #   aggregate includes both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `include_ret_element` (Array<one of "CashBackInfoRet", "CurrencyRef", "DataExtRet",
      #   "DepositLineRet", "DepositToAccountRef", "DepositTotal", "DepositTotalInHomeCurrency",
      #   "EditSequence", "ExchangeRate", "ExternalGUID", "ListID", "Memo", "OwnerID",
      #   "TimeCreated", "TimeModified", "TxnDate", "TxnID", "TxnNumber">)
      # - `memo` (String): Additional information.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/deposits/create-deposit
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("deposit.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List deposits: GET /connections/{connection_id}/deposits (`deposit.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `account_filter` (Hash): Filters according to the account name or `list_id`. If the “Use
      #   account numbers” preference is enabled in the QuickBooks company file, you can specify an
      #   account number (instead of an account name) for `full_name` and get the account you’re
      #   looking for. But if numbers have been used as account names, confusion could arise. Choose
      #   at most one of: `txn_id`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `txn_date_range_filter`).
      #   Members of a set combine with each other, not with the other choices.
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
      # - `currency_filter` (Hash): Filters by the specified currency. Choose at most one of:
      #   `txn_id`, or the set (`account_filter`, `currency_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `entity_filter` (Hash): An entity refers to a person on the QuickBooks Customer list,
      #   Vendor list, Employee list, or Other Names list. You can use an EntityQuery request to get
      #   information about all the entities that are set up in the QuickBooks file. In an
      #   ARRefundCreditCard query, this must be a customer/customer job. Choose at most one of:
      #   `txn_id`, or the set (`account_filter`, `currency_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `txn_date_range_filter`). Members of a set
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
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `include_line_items` (Boolean): This filter allows you to omit line items from a query
      #   response to get a smaller result. The default value is false, so line items are omitted by
      #   default. Set `include_line_items` to true to include line items in the response if you
      #   don’t mind getting a larger result.
      # - `include_ret_element` (Array<one of "CashBackInfoRet", "CurrencyRef", "DataExtRet",
      #   "DepositLineRet", "DepositToAccountRef", "DepositTotal", "DepositTotalInHomeCurrency",
      #   "EditSequence", "ExchangeRate", "ExternalGUID", "Memo", "TimeCreated", "TimeModified",
      #   "TxnDate", "TxnID", "TxnNumber">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records (25 with `include_line_items`); send `iterator=true`
      #   with `max_returned` for another size. Off when you send `iterator=false` (every match in
      #   one answer) or `max_returned` alone (at most that many, in one answer). It pages a
      #   filtered query only: with `txn_id` every match comes back in one answer, so leave
      #   `iterator` out.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `txn_id`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `modified_date_range_filter` (Hash): Filters according to the dates when transactions were
      #   last modified. The `modified_date_range_filter` aggregate isn’t required to contain any
      #   elements, but if it is empty, we recommend that you leave it out altogether. Note that the
      #   time portion of the `from_modified_date` and `to_modified_date` fields wasn’t supported in
      #   qbXML version 1.0 or 1.1. Choose at most one of: `txn_id`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
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
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_date_range_filter` (Hash): Filters according to the original transaction dates.
      #   Choose at most one of: `txn_id`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `txn_date_range_filter`).
      #   Members of a set combine with each other, not with the other choices.
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
      #   at most one of: `txn_id`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `txn_date_range_filter`).
      #   Members of a set combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/deposits/list-deposits
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("deposit.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update deposit: PUT /connections/{connection_id}/deposits (`deposit.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `cash_back_info_mod` (Hash): This aggregate is included if there is cash back from this
      #   deposit. `account_ref` indicates where the cash back Amount is going (for example, into a
      #   petty cash account).
      #   - `account_ref` (Hash): `account_ref` points to an account in the company file. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #     context: for checks it is the funding account; for ExpenseLineAdd it may be required by
      #     accounting preferences; for credit-card transactions it identifies the bank or card
      #     account involved.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `memo` (String): Additional information.
      # - `currency_ref` (Hash): A currency record defines how QuickBooks stores and displays a
      #   currency. Built-in currency name/code values are fixed; formatting and active status can
      #   vary by settings and workflow.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `deposit_line_mod` (Array<Hash>)
      #   - `account_ref` (Hash): `account_ref` points to an account in the company file. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #     context: for checks it is the funding account; for ExpenseLineAdd it may be required by
      #     accounting preferences; for credit-card transactions it identifies the bank or card
      #     account involved. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `amount` (Numeric): A monetary amount. Choose exactly one of: the set
      #     (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #   - `check_number` (String): The check number of a check that a QuickBooks user writes or
      #     receives from someone else. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `class_ref` (Hash): Use classes to categorize transactions (for example, by department,
      #     location, or work type). Class tracking is off by default in QuickBooks. A `class_ref`
      #     points to one class; if both `full_name` and `list_id` are provided, `full_name` is
      #     ignored. In InvoiceAdd, a header-level `class_ref` is applied to line items unless you
      #     override or clear it on individual lines. Choose exactly one of: the set
      #     (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `entity_ref` (Hash): A QuickBooks “entity” is a customer, vendor, employee, or person on
      #     the QuickBooks “other names” list. Special cases to note: In a BillToPayQuery message,
      #     `entity_ref` refers to the vendor name. In JournalCreditLine and JournalDebitLine
      #     messages for A/R accounts, `entity_ref` must refer to a customer, or else the
      #     transaction won’t be recorded. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `memo` (String): Additional information. Choose exactly one of: the set
      #     (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #   - `override_check_number` (String): Deposit line check number. Choose exactly one of: the
      #     set (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #   - `override_class_ref` (Hash): Deposit line class reference. Choose exactly one of: the
      #     set (`override_check_number`, `override_class_ref`, `override_memo`, `payment_txn_id`,
      #     `payment_txn_line_id`), or the set (`account_ref`, `amount`, `check_number`,
      #     `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a set combine with
      #     each other, not with the other choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `override_memo` (String): Depost line memo additional information. Choose exactly one
      #     of: the set (`override_check_number`, `override_class_ref`, `override_memo`,
      #     `payment_txn_id`, `payment_txn_line_id`), or the set (`account_ref`, `amount`,
      #     `check_number`, `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a
      #     set combine with each other, not with the other choices.
      #   - `payment_method_ref` (Hash): `payment_method_ref` identifies how a payment is made (for
      #     example, cash, check, or card type). If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `payment_txn_id` (String): For the `payment_txn_id`, use either of these two values:A
      #     `txn_id` value exactly as it is returned by the ReceivePaymentToDepositQuery request, or
      #     A `txn_id` value exactly as it is returned in a ReceivePaymentAdd response. Choose
      #     exactly one of: the set (`override_check_number`, `override_class_ref`, `override_memo`,
      #     `payment_txn_id`, `payment_txn_line_id`), or the set (`account_ref`, `amount`,
      #     `check_number`, `class_ref`, `entity_ref`, `memo`, `payment_method_ref`). Members of a
      #     set combine with each other, not with the other choices.
      #   - `payment_txn_line_id` (String): For the `payment_txn_line_id`, use a `txn_line_id` value
      #     exactly as it has been returned by the ReceivePaymentToDepositQuery request. If you
      #     don’t include a `payment_txn_line_id` and include a `payment_txn_id` for a transaction
      #     that includes payment lines, only the first payment line from that transaction will be
      #     deposited. Choose exactly one of: the set (`override_check_number`,
      #     `override_class_ref`, `override_memo`, `payment_txn_id`, `payment_txn_line_id`), or the
      #     set (`account_ref`, `amount`, `check_number`, `class_ref`, `entity_ref`, `memo`,
      #     `payment_method_ref`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      # - `deposit_to_account_ref` (Hash): Refers to the account where these funds will be (or have
      #   been) deposited. In a ReceivePaymentAdd request, the default is Undeposited Funds if this
      #   isn’t included in the request. In a request, if a `deposit_to_account_ref` aggregate
      #   includes both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `include_ret_element` (Array<one of "CashBackInfoRet", "CurrencyRef", "DataExtRet",
      #   "DepositLineRet", "DepositToAccountRef", "DepositTotal", "DepositTotalInHomeCurrency",
      #   "EditSequence", "ExchangeRate", "ExternalGUID", "ListID", "Memo", "OwnerID",
      #   "TimeCreated", "TimeModified", "TxnDate", "TxnID", "TxnNumber">)
      # - `memo` (String): Additional information.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
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
      # @see https://docs.qubesync.com/api-reference/v2/deposits/update-deposit
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("deposit.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
