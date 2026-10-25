# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks employee default operations, reached as `client.employee_default`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class EmployeeDefault < Base
      # List employee defaults: GET /connections/{connection_id}/employee-defaults
      # (`employee_default.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `include_ret_element` (Array<one of "EmployeeDefaultPayrollInfo">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/employee-defaults/list-employee-defaults
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("employee_default.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update employee default: PUT /connections/{connection_id}/employee-defaults
      # (`employee_default.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `employee_default_payroll_info_mod` (Hash)
      #   - `class_ref` (Hash)
      #     - `full_name` (String)
      #     - `list_id` (String)
      #   - `clear_earnings` (Boolean): Choose at most one of: `clear_earnings`, or `earnings`.
      #   - `clear_non_earnings` (Boolean): Choose at most one of: `clear_non_earnings`, or
      #     `non_earnings`.
      #   - `earnings` (Array<Hash>): Choose at most one of: `clear_earnings`, or `earnings`.
      #     - `payroll_item_wage_ref` (Hash, required)
      #       - `full_name` (String)
      #       - `list_id` (String)
      #     - `rate` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      #     - `rate_percent` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      #   - `employee_tax_info` (Hash)
      #     - `employee_tax` (Array<Hash>)
      #       - `is_subject_to_tax` (Boolean)
      #       - `payroll_item_tax_ref` (Hash, required)
      #         - `full_name` (String)
      #         - `list_id` (String)
      #       - `tax_info` (Array<Hash>)
      #         - `tax_info_category` (String, required)
      #         - `tax_info_value` (String, required)
      #       - `tax_law_version` (Integer)
      #     - `is_standard_taxation_required` (Boolean)
      #     - `state_lived` (String)
      #     - `state_worked` (String)
      #   - `is_covered_by_qualified_pension_plan` (Boolean)
      #   - `non_earnings` (Array<Hash>): Choose at most one of: `clear_non_earnings`, or
      #     `non_earnings`.
      #     - `amount` (Numeric): Choose at most one of: `amount`, or `rate_percent`.
      #     - `limit` (Numeric)
      #     - `payroll_item_non_wage_ref` (Hash, required)
      #       - `full_name` (String)
      #       - `list_id` (String)
      #     - `rate_percent` (Numeric): Choose at most one of: `amount`, or `rate_percent`.
      #   - `pay_period` (one of "Biweekly", "Daily", "Monthly", "Quarterly", "Semimonthly",
      #     "Weekly", "Yearly")
      #   - `sick_hours_default` (Hash)
      #     - `accrual_period` (one of "BeginningOfYear", "EveryHourOnPaycheck", "EveryPaycheck")
      #     - `hours_accrued` (String)
      #     - `is_resetting_hours_each_new_year` (Boolean)
      #     - `maximum_hours` (String)
      #   - `use_time_data_to_create_paychecks` (one of "DoNotUseTimeData", "NotSet", "UseTimeData")
      #   - `vacation_hours_default` (Hash)
      #     - `accrual_period` (one of "BeginningOfYear", "EveryHourOnPaycheck", "EveryPaycheck")
      #     - `hours_accrued` (String)
      #     - `is_resetting_hours_each_new_year` (Boolean)
      #     - `maximum_hours` (String)
      # - `include_ret_element` (Array<one of "EmployeeDefaultPayrollInfo">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/employee-defaults/update-employee-default
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("employee_default.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
