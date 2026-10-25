# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks txn deleted operations, reached as `client.txn_deleted`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class TxnDeleted < Base
      # List txn deleteds: GET /connections/{connection_id}/txn-deleteds (`txn_deleted.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `deleted_date_range_filter` (Hash): Filters according to delete dates (within the last 90
      #   days).
      #   - `from_deleted_date` (String): Selects objects deleted on or after this date. Both
      #     `from_deleted_date` and `to_deleted_date` must be between 1970-01-01 and
      #     2038-01-19T03:14:07 (2038-01-18T19:14:07-08:00 PST). (But note that ListDeletedQuery
      #     requests will only return records deleted within the last 90 days, even if the specified
      #     `from_deleted_date` is earlier.)
      #   - `to_deleted_date` (String): Selects objects deleted on or before this date. Both
      #     `to_deleted_date` and `from_deleted_date` must be between 1970-01-01 and
      #     2038-01-19T03:14:07 (2038-01-18T19:14:07-08:00 PST). If `to_deleted_date` includes a
      #     date but not a time (for example, if you set it to 2002-02-14), the time is assumed to
      #     be the end of the day (2003-02-14T23:59:59).
      # - `include_ret_element` (Array<one of "RefNumber", "TimeCreated", "TimeDeleted",
      #   "TxnDelType", "TxnID">)
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_del_type` (Array<one of "ARRefundCreditCard", "Bill", "BillPaymentCheck",
      #   "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check", "CreditCardCharge",
      #   "CreditCardCredit", "CreditMemo", "Deposit", "Estimate", "InventoryAdjustment", "Invoice",
      #   "ItemReceipt", "JournalEntry", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "TimeTracking", "TransferInventory",
      #   "VehicleMileage", "VendorCredit">, required): The type of transaction to be deleted.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/txn-deleteds/list-txn-deleteds
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("txn_deleted.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
