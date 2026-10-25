# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks paycheck operations, reached as `client.paycheck`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Paycheck < Base
      # List paychecks: GET /connections/{connection_id}/paychecks (`paycheck.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `account_filter` (Hash): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #   `full_name_with_children`.
      #   - `full_name` (Array<String>)
      #   - `full_name_with_children` (String)
      #   - `list_id` (Array<String>)
      #   - `list_id_with_children` (String)
      # - `entity_filter` (Hash): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #   `full_name_with_children`.
      #   - `full_name` (Array<String>)
      #   - `full_name_with_children` (String)
      #   - `list_id` (Array<String>)
      #   - `list_id_with_children` (String)
      # - `include_line_items` (Boolean)
      # - `include_ret_element` (Array<one of "AccountRef", "Address", "Amount", "ClassRef",
      #   "EditSequence", "EmployeeRef", "IsAccruingTime", "IsToBePrinted", "Memo",
      #   "PayPeriodBeginDate", "PayPeriodEndDate", "PaycheckLineRet", "PayrollDate", "RefNumber",
      #   "SickHoursAccrued", "SickHoursAvailable", "TaxTableVersion", "TimeCreated",
      #   "TimeModified", "TxnDate", "TxnID", "TxnNumber", "VacationHoursAccrued",
      #   "VacationHoursAvailable">)
      # - `max_returned` (Integer): QuickBooks doesn't page this query: at most this many records
      #   come back, in one answer, with no sign of whether more matched. Leave it out for every
      #   match, in one answer; one over 4 MB as the Web Connector sends it, about 3 MB of qbXML
      #   isn't kept (`error_type` `response_too_large`), so narrow a large one with its filters.
      #   Choose at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the
      #   set (`account_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `payroll_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData")
      # - `modified_date_range_filter` (Hash): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_modified_date` (String)
      #   - `to_modified_date` (String)
      # - `payroll_date_range_filter` (Hash): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `from_payroll_date` with `to_payroll_date`, or `date_macro`.
      #   - `date_macro` (one of "All", "LastCalendarQuarter", "LastCalendarQuarterToDate",
      #     "LastCalendarYear", "LastCalendarYearToDate", "LastFiscalQuarter",
      #     "LastFiscalQuarterToDate", "LastFiscalYear", "LastFiscalYearToDate", "LastMonth",
      #     "LastMonthToDate", "LastWeek", "LastWeekToDate", "NextCalendarQuarter",
      #     "NextCalendarYear", "NextFiscalQuarter", "NextFiscalYear", "NextFourWeeks", "NextMonth",
      #     "NextWeek", "ThisCalendarQuarter", "ThisCalendarQuarterToDate", "ThisCalendarYear",
      #     "ThisCalendarYearToDate", "ThisFiscalQuarter", "ThisFiscalQuarterToDate",
      #     "ThisFiscalYear", "ThisFiscalYearToDate", "ThisMonth", "ThisMonthToDate", "ThisWeek",
      #     "ThisWeekToDate", "Today", "Yesterday")
      #   - `from_payroll_date` (String)
      #   - `to_payroll_date` (String)
      # - `ref_number` (Array<String>): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      # - `ref_number_case_sensitive` (Array<String>): Choose at most one of: `txn_id`, or
      #   `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `payroll_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      # - `ref_number_filter` (Hash): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required)
      #   - `ref_number` (String, required)
      # - `ref_number_range_filter` (Hash): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_ref_number` (String)
      #   - `to_ref_number` (String)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_date_range_filter` (Hash): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
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
      #     "ThisWeekToDate", "Today", "Yesterday")
      #   - `from_txn_date` (String)
      #   - `to_txn_date` (String)
      # - `txn_id` (Array<String>): Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `entity_filter`,
      #   `max_returned`, `modified_date_range_filter`, `payroll_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/paychecks/list-paychecks
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("paycheck.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
