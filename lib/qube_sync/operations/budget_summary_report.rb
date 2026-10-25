# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks budget summary report operations, reached as `client.budget_summary_report`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class BudgetSummaryReport < Base
      # List budget summary reports: GET /connections/{connection_id}/budget-summary-reports
      # (`budget_summary_report.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `budget_criterion` (one of "Accounts", "AccountsAndClasses", "AccountsAndCustomers"): What
      #   this budget covers.
      # - `budget_summary_report_type` (one of "BalanceSheetBudgetOverview",
      #   "BalanceSheetBudgetVsActual", "ProfitAndLossBudgetOverview",
      #   "ProfitAndLossBudgetPerformance", "ProfitAndLossBudgetVsActual", required): The type of
      #   budget report being queried.
      # - `display_report` (Boolean): Set `display_report` to true to display this report within the
      #   QuickBooks UI. (Default is false.) If you want the request to display the report without
      #   returning any data to your application, set the responseData attribute to includeNone.
      # - `fiscal_year` (Integer, required): Specify the fiscal year of the budget to be queried.
      #   There can only be one balance sheet budget for each fiscal year, one profit and loss (P&L)
      #   by account budget per fiscal year, and one profit and loss (P&L) by account and customer
      #   budget per fiscal year. When Fiscal year isn’t the current year, the report returns the
      #   data for the full fiscal year.
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
      # - `summarize_budget_columns_by` (one of "Class", "Customer", "Date"):
      #   `summarize_budget_columns_by` determines which data the report calculates and how the
      #   columns will be labeled across the top of the report.
      # - `summarize_budget_rows_by` (one of "Account", "Class", "Customer"): How you want rows to
      #   be labeled in the report. For example, if you set the value to sbrbAccount, the report’s
      #   row labels might be “Checking,” “Savings,” and so on.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/budget-summary-reports/list-budget-summary-reports
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("budget_summary_report.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
