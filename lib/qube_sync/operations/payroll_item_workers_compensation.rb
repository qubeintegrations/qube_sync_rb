# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll item workers compensation operations, reached as `client.payroll_item_workers_compensation`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollItemWorkersCompensation < Base
      # Create payroll item workers compensation: POST
      # /connections/{connection_id}/payroll-item-workers-compensations
      # (`payroll_item_workers_compensation.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `expense_account_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "EditSequence", "ExpenseAccountRef", "IsActive",
      #   "IsTrackedByCustJob", "LiabilityAccountRef", "LiabilityPaymentSchedule", "ListID", "Name",
      #   "PaymentTemplateRef", "PayrollItemDetailTypeValue", "TimeCreated", "TimeModified",
      #   "VendorAccountNumber", "VendorRef">)
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
      # - `name` (String, required)
      # - `payment_template_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `payroll_item_detail_type_value` (Integer)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `vendor_account_number` (String)
      # - `vendor_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-workers-compensations/create-payroll-item-workers-compensation
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_workers_compensation.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update payroll item workers compensation: PUT
      # /connections/{connection_id}/payroll-item-workers-compensations
      # (`payroll_item_workers_compensation.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `edit_sequence` (String, required)
      # - `expense_account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `include_ret_element` (Array<one of "EditSequence", "ExpenseAccountRef", "IsActive",
      #   "IsTrackedByCustJob", "LiabilityAccountRef", "LiabilityPaymentSchedule", "ListID", "Name",
      #   "PaymentTemplateRef", "PayrollItemDetailTypeValue", "TimeCreated", "TimeModified",
      #   "VendorAccountNumber", "VendorRef">)
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
      # - `list_id` (String, required)
      # - `name` (String)
      # - `payment_template_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `payroll_item_detail_type_value` (Integer)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `vendor_account_number` (String)
      # - `vendor_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-workers-compensations/update-payroll-item-workers-compensation
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_workers_compensation.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
