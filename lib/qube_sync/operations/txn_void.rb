# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks txn void operations, reached as `client.txn_void`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class TxnVoid < Base
      # Execute txn void: POST /connections/{connection_id}/txn-void (`txn_void.execute`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      # - `txn_void_type` (one of "ARRefundCreditCard", "Bill", "BillPaymentCheck",
      #   "BillPaymentCreditCard", "Charge", "Check", "CreditCardCharge", "CreditCardCredit",
      #   "CreditMemo", "Deposit", "InventoryAdjustment", "Invoice", "ItemReceipt", "JournalEntry",
      #   "SalesReceipt", "VendorCredit", required): The type of transaction being voided.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/txn-void/execute-txn-void
      def execute(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("txn_void.execute", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
