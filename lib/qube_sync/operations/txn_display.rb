# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks txn display operations, reached as `client.txn_display`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class TxnDisplay < Base
      # Create txn display: POST /connections/{connection_id}/txn-displays (`txn_display.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `entity_ref` (Hash): A QuickBooks “entity” is a customer, vendor, employee, or person on
      #   the QuickBooks “other names” list. Special cases to note: In a BillToPayQuery message,
      #   `entity_ref` refers to the vendor name. In JournalCreditLine and JournalDebitLine messages
      #   for A/R accounts, `entity_ref` must refer to a customer, or else the transaction won’t be
      #   recorded.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_display_add_type` (one of "Bill", "BillPayment", "BuildAssembly", "Charge", "Check",
      #   "CreditCardCharge", "CreditCardCredit", "CreditMemo", "Deposit", "Estimate",
      #   "InventoryAdjustment", "Invoice", "ItemReceipt", "JournalEntry", "PurchaseOrder",
      #   "ReceivePayment", "SalesOrder", "SalesReceipt", "SalesTaxPaymentCheck", "VendorCredit",
      #   required): Specifies the type of QuickBooks transaction for which to open an edit form in
      #   the QuickBooks UI. Notice that some transaction types don’t support the entity reference
      #   that “prefills” the form because it would make no sense to do this for certain forms.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/txn-displays/create-txn-display
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("txn_display.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update txn display: PUT /connections/{connection_id}/txn-displays (`txn_display.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_display_mod_type` (one of "Bill", "BillPaymentCheck", "BillPaymentCreditCard",
      #   "BuildAssembly", "Charge", "Check", "CreditCardCharge", "CreditCardCredit", "CreditMemo",
      #   "Deposit", "Estimate", "InventoryAdjustment", "Invoice", "ItemReceipt", "JournalEntry",
      #   "PurchaseOrder", "ReceivePayment", "SalesOrder", "SalesReceipt", "SalesTaxPaymentCheck",
      #   "VendorCredit", required): The type of QuickBooks transaction to open for modification in
      #   the QuickBooks UI. (`txn_id` specifies the particular transaction.)
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/txn-displays/update-txn-display
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("txn_display.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
