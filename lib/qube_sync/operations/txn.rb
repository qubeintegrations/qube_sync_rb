# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks txn operations, reached as `client.txn`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Txn < Base
      # Delete txn: DELETE /connections/{connection_id}/txns (`txn.delete`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_del_type` (one of "ARRefundCreditCard", "Bill", "BillPaymentCheck",
      #   "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check", "CreditCardCharge",
      #   "CreditCardCredit", "CreditMemo", "Deposit", "Estimate", "InventoryAdjustment", "Invoice",
      #   "ItemReceipt", "JournalEntry", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "TimeTracking", "TransferInventory",
      #   "VehicleMileage", "VendorCredit", required): The type of transaction to be deleted.
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/txns/delete-txn
      def delete(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("txn.delete", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
