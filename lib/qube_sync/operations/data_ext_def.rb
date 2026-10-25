# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks data ext def operations, reached as `client.data_ext_def`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class DataExtDef < Base
      # Create data ext def: POST /connections/{connection_id}/data-ext-defs
      # (`data_ext_def.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `assign_to_object` (Array<one of "ARRefundCreditCard", "Account", "Bill",
      #   "BillPaymentCheck", "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check",
      #   "Company", "CreditCardCharge", "CreditCardCredit", "CreditMemo", "Customer", "Deposit",
      #   "Employee", "Estimate", "InventoryAdjustment", "Invoice", "Item", "ItemReceipt",
      #   "JournalEntry", "OtherName", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "Vendor", "VendorCredit">)
      # - `data_ext_format_string` (String): The string format required for the data extension.
      # - `data_ext_list_require` (Boolean): If `data_ext_list_require` is true, this data extension
      #   field is required to be entered in lists. The default value is false.
      # - `data_ext_name` (String, required): The name of the data extension. If this is a custom
      #   field, `data_ext_name` will be visible as a label in the QuickBooks user interface. Also
      #   because `owner_id` and `data_ext_name` together make the data extension unique, and
      #   because custom fields all have the same `owner_id` of zero, the `data_ext_name` must be a
      #   unique value among existing custom fields.
      # - `data_ext_txn_require` (Boolean): If `data_ext_txn_require` is true, this data extension
      #   field is required to be entered in transaction. The default value is false.
      # - `data_ext_type` (one of "AMTTYPE", "DATETIMETYPE", "INTTYPE", "PERCENTTYPE", "PRICETYPE",
      #   "QUANTYPE", "STR1024TYPE", "STR255TYPE", required): The field’s data type, which
      #   corresponds to a qbXML data type. In an IDataExtDefAdd request object, if this is a custom
      #   field, `data_ext_type` must be detSTR255TYPE.
      # - `include_ret_element` (Array<one of "AssignToObject", "DataExtFormatString", "DataExtID",
      #   "DataExtListRequire", "DataExtName", "DataExtTxnRequire", "DataExtType", "EditSequence",
      #   "ExternalGUID", "ListID", "OwnerID", "TxnID", "TxnNumber">)
      # - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use 0
      #   for QuickBooks custom fields that appear in the UI, or use a GUID for private extensions
      #   owned by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-ext-defs/create-data-ext-def
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_ext_def.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Delete data ext def: DELETE /connections/{connection_id}/data-ext-defs
      # (`data_ext_def.delete`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `data_ext_name` (String, required): The name of the data extension. If this is a custom
      #   field, `data_ext_name` will be visible as a label in the QuickBooks user interface. Also
      #   because `owner_id` and `data_ext_name` together make the data extension unique, and
      #   because custom fields all have the same `owner_id` of zero, the `data_ext_name` must be a
      #   unique value among existing custom fields.
      # - `owner_id` (String, required): `owner_id` identifies the extension owner. `owner_id` 0
      #   means a public custom field visible in the QuickBooks UI. A GUID means a private app
      #   extension that is not shown in the UI. `owner_id` matching is case-insensitive. To share
      #   private extensions across apps, both apps must use the same `owner_id` and
      #   `data_ext_name`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-ext-defs/delete-data-ext-def
      def delete(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_ext_def.delete", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List data ext defs: GET /connections/{connection_id}/data-ext-defs (`data_ext_def.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `assign_to_object` (Array<one of "ARRefundCreditCard", "Account", "Bill",
      #   "BillPaymentCheck", "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check",
      #   "Company", "CreditCardCharge", "CreditCardCredit", "CreditMemo", "Customer", "Deposit",
      #   "Employee", "Estimate", "InventoryAdjustment", "Invoice", "Item", "ItemReceipt",
      #   "JournalEntry", "OtherName", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "Vendor", "VendorCredit">): Choose at most one of:
      #   `owner_id`, or `assign_to_object`.
      # - `include_ret_element` (Array<one of "AssignToObject", "DataExtFormatString", "DataExtID",
      #   "DataExtListRequire", "DataExtName", "DataExtTxnRequire", "DataExtType", "OwnerID">)
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `owner_id` (Array<String>): `owner_id` identifies who owns the data extension. Use 0 for
      #   QuickBooks custom fields that appear in the UI, or use a GUID for private extensions owned
      #   by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension. Choose at most one
      #   of: `owner_id`, or `assign_to_object`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-ext-defs/list-data-ext-defs
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_ext_def.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update data ext def: PUT /connections/{connection_id}/data-ext-defs (`data_ext_def.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `assign_to_object` (Array<one of "ARRefundCreditCard", "Account", "Bill",
      #   "BillPaymentCheck", "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check",
      #   "Company", "CreditCardCharge", "CreditCardCredit", "CreditMemo", "Customer", "Deposit",
      #   "Employee", "Estimate", "InventoryAdjustment", "Invoice", "Item", "ItemReceipt",
      #   "JournalEntry", "OtherName", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "Vendor", "VendorCredit">)
      # - `data_ext_format_string` (String): The string format required for the data extension.
      # - `data_ext_list_require` (Boolean): If `data_ext_list_require` is true, this data extension
      #   field is required to be entered in lists. The default value is false.
      # - `data_ext_name` (String, required): The name of the data extension. If this is a custom
      #   field, `data_ext_name` will be visible as a label in the QuickBooks user interface. Also
      #   because `owner_id` and `data_ext_name` together make the data extension unique, and
      #   because custom fields all have the same `owner_id` of zero, the `data_ext_name` must be a
      #   unique value among existing custom fields.
      # - `data_ext_new_name` (String): The new name for this field. Note that in the case of custom
      #   fields, `data_ext_new_name` can run into name conflicts, because the name space of custom
      #   fields (data extensions with an `owner_id` of 0) is shared by all applications.
      # - `data_ext_txn_require` (Boolean): If `data_ext_txn_require` is true, this data extension
      #   field is required to be entered in transaction. The default value is false.
      # - `include_ret_element` (Array<one of "AssignToObject", "DataExtFormatString", "DataExtID",
      #   "DataExtListRequire", "DataExtName", "DataExtTxnRequire", "DataExtType", "EditSequence",
      #   "ExternalGUID", "ListID", "OwnerID", "TxnID", "TxnNumber">)
      # - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use 0
      #   for QuickBooks custom fields that appear in the UI, or use a GUID for private extensions
      #   owned by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `remove_from_object` (Array<one of "ARRefundCreditCard", "Account", "Bill",
      #   "BillPaymentCheck", "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check",
      #   "Company", "CreditCardCharge", "CreditCardCredit", "CreditMemo", "Customer", "Deposit",
      #   "Employee", "Estimate", "InventoryAdjustment", "Invoice", "Item", "ItemReceipt",
      #   "JournalEntry", "OtherName", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "Vendor", "VendorCredit">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-ext-defs/update-data-ext-def
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_ext_def.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
