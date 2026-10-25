# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll item direct deposit operations, reached as `client.payroll_item_direct_deposit`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollItemDirectDeposit < Base
      # Create payroll item direct deposit: POST
      # /connections/{connection_id}/payroll-item-direct-deposits
      # (`payroll_item_direct_deposit.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `include_ret_element` (Array<one of "EditSequence", "IsActive", "LiabilityAccountRef",
      #   "ListID", "Name", "PayrollItemDetailTypeValue", "TimeCreated", "TimeModified">)
      # - `is_active` (Boolean)
      # - `liability_account_ref` (Hash, required)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `name` (String, required)
      # - `payroll_item_detail_type_value` (Integer)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-direct-deposits/create-payroll-item-direct-deposit
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_direct_deposit.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update payroll item direct deposit: PUT
      # /connections/{connection_id}/payroll-item-direct-deposits
      # (`payroll_item_direct_deposit.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `edit_sequence` (String, required)
      # - `include_ret_element` (Array<one of "EditSequence", "IsActive", "LiabilityAccountRef",
      #   "ListID", "Name", "PayrollItemDetailTypeValue", "TimeCreated", "TimeModified">)
      # - `is_active` (Boolean)
      # - `liability_account_ref` (Hash)
      #   - `full_name` (String)
      #   - `list_id` (String)
      # - `list_id` (String, required)
      # - `name` (String)
      # - `payroll_item_detail_type_value` (Integer)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-item-direct-deposits/update-payroll-item-direct-deposit
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item_direct_deposit.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
