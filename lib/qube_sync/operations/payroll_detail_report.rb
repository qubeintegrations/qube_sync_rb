# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll detail report operations, reached as `client.payroll_detail_report`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollDetailReport < Base
      # List payroll detail reports: GET /connections/{connection_id}/payroll-detail-reports
      # (`payroll_detail_report.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `display_report` (Boolean): Set `display_report` to true to display this report within the
      #   QuickBooks UI. (Default is false.) If you want the request to display the report without
      #   returning any data to your application, set the responseData attribute to includeNone.
      # - `include_accounts` (one of "All", "InUse"): Indicates whether this report should include
      #   all accounts or just those that are currently in use.
      # - `include_column` (Array<one of "Account", "Aging", "Amount", "AmountDifference",
      #   "AverageCost", "BilledDate", "BillingStatus", "CalculatedAmount", "Class",
      #   "ClearedStatus", "CostPrice", "Credit", "Currency", "Date", "Debit", "DeliveryDate",
      #   "DueDate", "EstimateActive", "ExchangeRate", "FOB", "IncomeSubjectToTax", "Invoiced",
      #   "Item", "ItemDesc", "LastModifiedBy", "LatestOrPriorState", "Memo", "ModifiedTime",
      #   "Name", "NameAccountNumber", "NameAddress", "NameCity", "NameContact", "NameEmail",
      #   "NameFax", "NamePhone", "NameState", "NameZip", "OpenBalance", "OriginalAmount",
      #   "PONumber", "PaidAmount", "PaidStatus", "PaidThroughDate", "PaymentMethod", "PayrollItem",
      #   "PrintStatus", "ProgressAmount", "ProgressPercent", "Quantity", "QuantityAvailable",
      #   "QuantityOnHand", "QuantityOnSalesOrder", "ReceivedQuantity", "RefNumber",
      #   "RunningBalance", "SSNOrTaxID", "SalesRep", "SalesTaxCode", "SerialOrLotNumber",
      #   "ShipDate", "ShipMethod", "SourceName", "SplitAccount", "TaxLine", "TaxTableVersion",
      #   "Terms", "TxnID", "TxnNumber", "TxnType", "UnitPrice", "UserEdit", "ValueOnHand",
      #   "WageBase", "WageBaseTips">)
      # - `payroll_detail_report_type` (one of "EmployeeStateTaxesDetail", "PayrollItemDetail",
      #   "PayrollReviewDetail", "PayrollTransactionDetail", "PayrollTransactionsByPayee", required)
      # - `report_account_filter` (Hash): Allows you to query for a specified account type or for
      #   specific list elements.
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
      #   - `full_name` (Array<String>)
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `list_id` (Array<String>)
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `report_class_filter` (Hash): Allows you to query for a specified class. Classes can be
      #   used to separate transactions into meaningful categories. (For example, transactions could
      #   be classified according to department, business location, or type of work.) In QuickBooks,
      #   class tracking is off by default.
      #   Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #   `full_name_with_children`.
      #   - `full_name` (Array<String>)
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `list_id` (Array<String>)
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `report_date_macro` (one of "All", "LastMonth", "LastMonthToDate", "LastQuarter",
      #   "LastQuarterToDate", "LastWeek", "LastWeekToDate", "LastYear", "LastYearToDate",
      #   "NextFourWeeks", "NextMonth", "NextQuarter", "NextWeek", "NextYear", "ThisMonth",
      #   "ThisMonthToDate", "ThisQuarter", "ThisQuarterToDate", "ThisWeek", "ThisWeekToDate",
      #   "ThisYear", "ThisYearToDate", "Today", "Yesterday"): The time period covered by this
      #   report. Choose at most one of: `report_period`, or `report_date_macro`.
      # - `report_detail_level_filter` (one of "All", "AllExceptSummary", "SummaryOnly"): The level
      #   of detail to include in the report.
      # - `report_entity_filter` (Hash): Allows you to query for a specified name type (customer,
      #   employee, vendor, or other) or query for specific list elements.
      #   Give at most one of: `entity_type_filter`, or `list_id`, or `full_name`, or
      #   `list_id_with_children`, or `full_name_with_children`.
      #   - `entity_type_filter` (one of "Customer", "Employee", "OtherName", "Vendor"): Allows you
      #     to report on a specific name type.
      #   - `full_name` (Array<String>)
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `list_id` (Array<String>)
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `report_item_filter` (Hash): Allows you to query for a specified item type (for example,
      #   discount, inventory, or non-inventory) or query for specific list elements.
      #   Give at most one of: `item_type_filter`, or `list_id`, or `full_name`, or
      #   `list_id_with_children`, or `full_name_with_children`.
      #   - `full_name` (Array<String>)
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `item_type_filter` (one of "AllExceptFixedAsset", "Assembly", "Discount", "FixedAsset",
      #     "Inventory", "InventoryAndAssembly", "NonInventory", "OtherCharge", "Payment", "Sales",
      #     "SalesTax", "Service"): Allows you to report on a specific item type.
      #   - `list_id` (Array<String>)
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `report_modified_date_range_filter` (Hash): Returns reports that were modified between
      #   these two dates (inclusive). The range of acceptable dates for both
      #   `from_report_modified_date` and `to_report_modified_date` is 1970-01-01 to
      #   2038-01-19T03:14:07 (2038-01-18T19:14:07-08:00 PST). Choose at most one of:
      #   `report_modified_date_range_filter`, or `report_modified_date_range_macro`.
      #   - `from_report_modified_date` (String): Selects information from this date and later. The
      #     range of acceptable dates is 1970-01-01 to 2038-01-19T03:14:07
      #     (2038-01-18T19:14:07-08:00 PST).
      #   - `to_report_modified_date` (String): Selects information created on this date or earlier.
      #     The range of acceptable dates is 1970-01-01 to 2038-01-19T03:14:07
      #     (2038-01-18T19:14:07-08:00 PST).
      # - `report_modified_date_range_macro` (one of "All", "LastMonth", "LastMonthToDate",
      #   "LastQuarter", "LastQuarterToDate", "LastWeek", "LastWeekToDate", "LastYear",
      #   "LastYearToDate", "NextFourWeeks", "NextMonth", "NextQuarter", "NextWeek", "NextYear",
      #   "ThisMonth", "ThisMonthToDate", "ThisQuarter", "ThisQuarterToDate", "ThisWeek",
      #   "ThisWeekToDate", "ThisYear", "ThisYearToDate", "Today", "Yesterday"): The time period
      #   covered by this report. Choose at most one of: `report_modified_date_range_filter`, or
      #   `report_modified_date_range_macro`.
      # - `report_open_balance_as_of` (one of "ReportEndDate", "Today"): The report will return open
      #   balance information up to the `report_open_balance_as_of` date.
      # - `report_period` (Hash): If you omit both `to_report_date` and `from_report_date`, the
      #   report will cover the current fiscal year to date. Choose at most one of: `report_period`,
      #   or `report_date_macro`.
      #   - `from_report_date` (String): Selects information from this date and later. The range of
      #     acceptable `from_report_date` and `to_report_date` values depends on how the report
      #     dates are determined. If the report dates are based on the dates of transactions, the
      #     range is 01/01/1901 to 12/31/9999.
      #   - `to_report_date` (String): Selects information created on this date or earlier. The
      #     range of acceptable `to_report_date` and `from_report_date` values depends on how the
      #     report dates are determined. If the report dates are based on the dates of transactions,
      #     the range is 01/01/1901 to 12/31/9999.
      # - `report_posting_status_filter` (one of "Either", "NonPosting", "Posting"): Allows you to
      #   query for posting reports, non-posting reports, or reports that are either one.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `summarize_rows_by` (one of "Account", "BalanceSheet", "Class", "Customer",
      #   "CustomerType", "Day", "Employee", "FourWeek", "HalfMonth", "IncomeStatement",
      #   "ItemDetail", "ItemType", "Month", "Payee", "PaymentMethod", "PayrollItemDetail",
      #   "PayrollYtdDetail", "Quarter", "SalesRep", "SalesTaxCode", "ShipMethod", "TaxLine",
      #   "Terms", "TotalOnly", "TwoWeek", "Vendor", "VendorType", "Week", "Year"):
      #   `summarize_rows_by` (along with IncludeColumnList, in most cases) determines what data is
      #   calculated for this report and controls how the rows are organized and labeled. For
      #   example, if you set the value to srbAccount, the report’s row labels might be “Checking,”
      #   “Savings,” and so on.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-detail-reports/list-payroll-detail-reports
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_detail_report.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
