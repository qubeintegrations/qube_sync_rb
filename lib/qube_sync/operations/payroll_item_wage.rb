# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll item wage operations, reached as `client.payroll_item_wage`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollItemWage < Base
      # Create payroll item wage: POST /connections/{connection_id}/payroll-item-wages
      # (`payroll_item_wage.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `expense_account_ref` (Hash, required): Refers to an expense account. If an
      #   `expense_account_ref` aggregate includes both `full_name` and `list_id`, `full_name` will
      #   be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `include_ret_element` (Array<one of "EditSequence", "ExpenseAccountRef", "IsActive",
      #   "ListID", "Name", "OvertimeMultiplier", "PayrollItemDetailTypeValue", "Rate",
      #   "RatePercent", "TimeCreated", "TimeModified", "WageType">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `name` (String, required): Description of the wage: for example, Regular Pay or Overtime
      #   Pay.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `wage_type` (one of "Bonus", "Commission", "HourlyOvertime", "HourlyRegular",
      #   "HourlySick", "HourlyVacation", "SalaryRegular", "SalarySick", "SalaryVacation",
      #   required): The type of pay.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-wages/create-payroll-item-wage
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_wage.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List payroll item wages: GET /connections/{connection_id}/payroll-item-wages
      # (`payroll_item_wage.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `from_modified_date`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set combine with
      #   each other, not with the other choices.
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "EditSequence", "ExpenseAccountRef", "IsActive",
      #   "ListID", "Name", "OvertimeMultiplier", "PayrollItemDetailTypeValue", "Rate",
      #   "RatePercent", "TimeCreated", "TimeModified", "WageType">)
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. QuickBooks
      #   doesn't page this query: at most this many records come back, in one answer, with no sign
      #   of whether more matched. Leave it out for every match, in one answer; one over 4 MB as the
      #   Web Connector sends it, about 3 MB of qbXML isn't kept (`error_type`
      #   `response_too_large`), so narrow a large one with its filters. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_name` (String): The first name or item in the search range. If `from_name` is
      #     omitted, the range will begin with first name on the list.
      #   - `to_name` (String): The final name or item in the search range. If `to_name` is omitted,
      #     the range will end with last name on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `to_modified_date` (String): Filters results to objects modified on or before this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to end-of-day (23:59:59). Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-wages/list-payroll-item-wages
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_wage.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update payroll item wage: PUT /connections/{connection_id}/payroll-item-wages
      # (`payroll_item_wage.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `edit_sequence` (String, required)
      # - `expense_account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "EditSequence", "ExpenseAccountRef", "IsActive",
      #   "ListID", "Name", "OvertimeMultiplier", "PayrollItemDetailTypeValue", "Rate",
      #   "RatePercent", "TimeCreated", "TimeModified", "WageType">)
      # - `is_active` (Boolean)
      # - `list_id` (String, required)
      # - `name` (String)
      # - `overtime_multiplier` (Numeric)
      # - `payroll_item_detail_type_value` (Integer)
      # - `rate` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `rate_percent` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-wages/update-payroll-item-wage
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_wage.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
