# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll item company contribution operations, reached as `client.payroll_item_company_contribution`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollItemCompanyContribution < Base
      # Create payroll item company contribution: POST
      # /connections/{connection_id}/payroll-item-company-contributions
      # (`payroll_item_company_contribution.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `calculated_based_on` (one of "HoursAll", "HoursWorked", "Quantity", "Rate")
      # - `expense_account_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "CalculatedBasedOn", "EditSequence",
      #   "ExpenseAccountRef", "IsActive", "IsTrackedByCustJob", "LiabilityAccountRef",
      #   "LiabilityPaymentSchedule", "Limit", "LimitTimePeriod", "ListID", "Name", "NetOrGross",
      #   "PaymentTemplateRef", "PayrollItemDetailTypeValue", "Rate", "RatePercent", "Taxability",
      #   "TimeCreated", "TimeModified", "VendorAccountNumber", "VendorRef", "W2TrackingTypeValue">)
      # - `is_active` (Boolean)
      # - `is_tracked_by_cust_job` (Boolean)
      # - `liability_account_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `liability_payment_schedule` (Hash)
      #   - `payment_due_date` (String)
      #   - `payment_due_num_days_after` (Integer)
      #   - `payment_schedule_type` (one of "Empty", "FederalMonthly", "FederalNextDay",
      #     "FederalQuarterly", "FederalSemiweekly", "Monthly", "Quarterly", "Semiweekly", "Weekly",
      #     "Yearly", required)
      # - `limit` (Numeric)
      # - `limit_time_period` (one of "Annual", "Forever")
      # - `name` (String, required)
      # - `net_or_gross` (one of "Gross", "Net")
      # - `payment_template_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `payroll_item_detail_type_value` (Integer)
      # - `rate` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `rate_percent` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `taxability` (Array<Hash>)
      #   - `is_tax_applied` (Boolean, required)
      #   - `payroll_item_tax_ref` (Hash, required)
      #     - `full_name` (String)
      #     - `list_id` (String)
      # - `vendor_account_number` (String)
      # - `vendor_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `w2_tracking_type_value` (Integer)
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-company-contributions/create-payroll-item-company-contribution
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_company_contribution.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update payroll item company contribution: PUT
      # /connections/{connection_id}/payroll-item-company-contributions
      # (`payroll_item_company_contribution.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `calculated_based_on` (one of "HoursAll", "HoursWorked", "Quantity", "Rate")
      # - `edit_sequence` (String, required)
      # - `expense_account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "CalculatedBasedOn", "EditSequence",
      #   "ExpenseAccountRef", "IsActive", "IsTrackedByCustJob", "LiabilityAccountRef",
      #   "LiabilityPaymentSchedule", "Limit", "LimitTimePeriod", "ListID", "Name", "NetOrGross",
      #   "PaymentTemplateRef", "PayrollItemDetailTypeValue", "Rate", "RatePercent", "Taxability",
      #   "TimeCreated", "TimeModified", "VendorAccountNumber", "VendorRef", "W2TrackingTypeValue">)
      # - `is_active` (Boolean)
      # - `is_tracked_by_cust_job` (Boolean)
      # - `liability_account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `liability_payment_schedule` (Hash)
      #   - `payment_due_date` (String)
      #   - `payment_due_num_days_after` (Integer)
      #   - `payment_schedule_type` (one of "Empty", "FederalMonthly", "FederalNextDay",
      #     "FederalQuarterly", "FederalSemiweekly", "Monthly", "Quarterly", "Semiweekly", "Weekly",
      #     "Yearly", required)
      # - `limit` (Numeric)
      # - `limit_time_period` (one of "Annual", "Forever")
      # - `list_id` (String, required)
      # - `name` (String)
      # - `net_or_gross` (one of "Gross", "Net")
      # - `payment_template_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `payroll_item_detail_type_value` (Integer)
      # - `rate` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `rate_percent` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `taxability` (Array<Hash>)
      #   - `is_tax_applied` (Boolean, required)
      #   - `payroll_item_tax_ref` (Hash, required)
      #     - `full_name` (String)
      #     - `list_id` (String)
      # - `vendor_account_number` (String)
      # - `vendor_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `w2_tracking_type_value` (Integer)
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-company-contributions/update-payroll-item-company-contribution
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_company_contribution.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
