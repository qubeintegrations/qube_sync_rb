# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll year to date adjustment operations, reached as `client.payroll_year_to_date_adjustment`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollYearToDateAdjustment < Base
      # Create payroll year to date adjustment: POST
      # /connections/{connection_id}/payroll-year-to-date-adjustments
      # (`payroll_year_to_date_adjustment.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `class_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `def_macro` (String)
      # - `employee_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "AccountRef", "Amount", "ClassRef", "EditSequence",
      #   "EmployeeRef", "IsAffectingAccounts", "Memo", "PayPeriodBeginDate", "PayPeriodEndDate",
      #   "PayrollDate", "PayrollYearToDateAdjustmentLineRet", "RefNumber", "TaxTableVersion",
      #   "TimeCreated", "TimeModified", "TxnDate", "TxnID", "TxnNumber">)
      # - `is_affecting_accounts` (Boolean, required)
      # - `memo` (String)
      # - `pay_period_begin_date` (String)
      # - `pay_period_end_date` (String)
      # - `payroll_date` (String)
      # - `payroll_year_to_date_adjustment_line_add` (Array<Hash>, required)
      #   - `account_ref` (Hash)
      #     - `full_name` (String)
      #     - `list_id` (String)
      #   - `amount` (Numeric)
      #   - `calculated_amount` (Numeric)
      #   - `class_ref` (Hash)
      #     - `full_name` (String)
      #     - `list_id` (String)
      #   - `company_paid_attribute` (one of "IsExpense", "IsLiability", "IsLiabilityAndExpense",
      #     "NotApplicable")
      #   - `experience_mod_rate_amount` (Numeric)
      #   - `hours_worked` (String)
      #   - `income_subject_to_tax_amount` (Numeric)
      #   - `is_amount_overridden` (Boolean)
      #   - `memo` (String)
      #   - `other_account_ref` (Hash)
      #     - `full_name` (String)
      #     - `list_id` (String)
      #   - `payroll_item_ref` (Hash)
      #     - `full_name` (String)
      #     - `list_id` (String)
      #   - `rate` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      #   - `rate_percent` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      #   - `wage_base_amount` (Numeric)
      #   - `workers_comp_amount` (Numeric)
      #   - `workers_comp_code_ref` (Hash)
      #     - `full_name` (String)
      #     - `list_id` (String)
      # - `ref_number` (String)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `tax_table_version` (Integer)
      # - `txn_date` (String)
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-year-to-date-adjustments/create-payroll-year-to-date-adjustment
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_year_to_date_adjustment.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List payroll year to date adjustments: GET
      # /connections/{connection_id}/payroll-year-to-date-adjustments
      # (`payroll_year_to_date_adjustment.query`).
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
      # - `include_ret_element` (Array<one of "AccountRef", "Amount", "ClassRef", "EditSequence",
      #   "EmployeeRef", "IsAffectingAccounts", "Memo", "PayPeriodBeginDate", "PayPeriodEndDate",
      #   "PayrollDate", "PayrollYearToDateAdjustmentLineRet", "RefNumber", "TaxTableVersion",
      #   "TimeCreated", "TimeModified", "TxnDate", "TxnID", "TxnNumber">)
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
      # @see https://docs.qubesync.com/api-reference/v2/payroll-year-to-date-adjustments/list-payroll-year-to-date-adjustments
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_year_to_date_adjustment.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
