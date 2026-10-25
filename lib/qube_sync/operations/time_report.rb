# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks time report operations, reached as `client.time_report`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class TimeReport < Base
      # List time reports: GET /connections/{connection_id}/time-reports (`time_report.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `display_report` (Boolean): Set `display_report` to true to display this report within the
      #   QuickBooks UI. (Default is false.) If you want the request to display the report without
      #   returning any data to your application, set the responseData attribute to includeNone.
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
      # - `include_subcolumns` (Boolean): The default value is false, which means that the report
      #   won’t include any subcolumn information. To include all available types of subcolumns for
      #   this report, set `include_subcolumns` to true. The SDK won’t return subcolumn information
      #   for data that can be easily computed. (For example, the SDK doesn’t return the “percent of
      #   row” column.)
      # - `report_calendar` (one of "CalendarYear", "FiscalYear", "TaxYear"): Specifies the type of
      #   year that will be used for this report.
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
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `return_columns` (one of "ActiveOnly", "All", "NonZero"): Specifies whether you want the
      #   report to include only columns with active information, only columns with nonzero values,
      #   or all columns regardless of their content or active status.
      # - `return_rows` (one of "ActiveOnly", "All", "NonZero"): Specifies whether you want the
      #   report to include only rows with active information, only rows with nonzero values, or all
      #   rows regardless of their content or active status.
      # - `summarize_columns_by` (one of "Account", "BalanceSheet", "Class", "Customer",
      #   "CustomerType", "Day", "Employee", "FourWeek", "HalfMonth", "IncomeStatement",
      #   "ItemDetail", "ItemType", "Month", "Payee", "PaymentMethod", "PayrollItemDetail",
      #   "PayrollYtdDetail", "Quarter", "SalesRep", "SalesTaxCode", "ShipMethod", "Terms",
      #   "TotalOnly", "TwoWeek", "Vendor", "VendorType", "Week", "Year"): `summarize_columns_by`
      #   determines which data the report calculates and how the columns will be labeled across the
      #   top of the report. For example, if you set the value to scbTwoWeek, the report’s column
      #   labels might be “Feb 10-23, 02,” “Feb 24-Mar9, 02,” and so on.
      # - `time_report_type` (one of "TimeByItem", "TimeByJobDetail", "TimeByJobSummary",
      #   "TimeByName", required): Allows you to report on time that has been recorded in a
      #   particular category.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/time-reports/list-time-reports
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("time_report.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
