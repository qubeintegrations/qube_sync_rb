# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll item tax operations, reached as `client.payroll_item_tax`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollItemTax < Base
      # Create payroll item tax: POST /connections/{connection_id}/payroll-item-taxes
      # (`payroll_item_tax.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `expense_account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "EditSequence", "ExpenseAccountRef", "IsActive",
      #   "LiabilityAccountRef", "LiabilityPaymentSchedule", "Limit", "ListID", "Name",
      #   "PaymentTemplateRef", "PayrollItemDetailTypeValue", "Rate", "RateChange", "RatePercent",
      #   "State", "TaxCalculatedBasedOn", "TimeCreated", "TimeModified", "VendorAccountNumber",
      #   "VendorRef", "W2TrackingTypeValue">)
      # - `is_active` (Boolean)
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
      # - `name` (String, required)
      # - `payment_template_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `payroll_item_detail_type_value` (Integer, required)
      # - `rate` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `rate_change` (Array<Hash>)
      #   - `rate_percent` (Numeric, required)
      #   - `sunset_date` (String, required)
      # - `rate_percent` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `state` (String)
      # - `tax_calculated_based_on` (one of "Compensation", "HoursAll", "HoursWorked", "Quantity")
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
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-taxes/create-payroll-item-tax
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_tax.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update payroll item tax: PUT /connections/{connection_id}/payroll-item-taxes
      # (`payroll_item_tax.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `edit_sequence` (String, required)
      # - `expense_account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "EditSequence", "ExpenseAccountRef", "IsActive",
      #   "LiabilityAccountRef", "LiabilityPaymentSchedule", "Limit", "ListID", "Name",
      #   "PaymentTemplateRef", "PayrollItemDetailTypeValue", "Rate", "RateChange", "RatePercent",
      #   "State", "TaxCalculatedBasedOn", "TimeCreated", "TimeModified", "VendorAccountNumber",
      #   "VendorRef", "W2TrackingTypeValue">)
      # - `is_active` (Boolean)
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
      # - `list_id` (String, required)
      # - `name` (String)
      # - `payment_template_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `rate` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `rate_change` (Array<Hash>)
      #   - `rate_percent` (Numeric, required)
      #   - `sunset_date` (String, required)
      # - `rate_percent` (Numeric): Choose at most one of: `rate`, or `rate_percent`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `state` (String)
      # - `tax_calculated_based_on` (one of "Compensation", "HoursAll", "HoursWorked", "Quantity")
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
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-taxes/update-payroll-item-tax
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_tax.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
