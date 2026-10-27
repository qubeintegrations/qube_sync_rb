# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks data ext operations, reached as `client.data_ext`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class DataExt < Base
      # Create data ext: POST /connections/{connection_id}/data-exts (`data_ext.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # Give at most one of: `list_data_ext_type` with `list_obj_ref`, or `txn_data_ext_type` with
      # `txn_id` with `txn_line_id`, or `other_data_ext_type`.
      # - `data_ext_name` (String, required): The name of the data extension. If this is a custom
      #   field, `data_ext_name` will be visible as a label in the QuickBooks user interface. Also
      #   because `owner_id` and `data_ext_name` together make the data extension unique, and
      #   because custom fields all have the same `owner_id` of zero, the `data_ext_name` must be a
      #   unique value among existing custom fields.
      # - `data_ext_value` (String, required): The data in this field. The maximum length of
      #   `data_ext_value` will depend on the `data_ext_type` of this data extension. For example,
      #   if `data_ext_type` is STR255TYPE, the maximum length of `data_ext_value` is 255
      #   characters. If `data_ext_type` is STR1024TYPE, the maximum size of `data_ext_value` is
      #   1KB.
      # - `list_data_ext_type` (one of "Account", "Customer", "Employee", "Item", "OtherName",
      #   "Vendor"): The type of list object (e.g. Customer) that this data extension is attached
      #   to.
      # - `list_obj_ref` (Hash): Refers to a list object. In a DataExtAdd request, the list object
      #   ref must be the same type as the type specified in `list_data_ext_type`. If a
      #   `list_obj_ref` aggregate includes both `full_name` and `list_id`, `full_name` will be
      #   ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `other_data_ext_type` (one of "Company"): Not supported.
      # - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use 0
      #   for QuickBooks custom fields that appear in the UI, or use a GUID for private extensions
      #   owned by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_data_ext_type` (one of "ARRefundCreditCard", "Bill", "BillPaymentCheck",
      #   "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check", "CreditCardCharge",
      #   "CreditCardCredit", "CreditMemo", "Deposit", "Estimate", "InventoryAdjustment", "Invoice",
      #   "ItemReceipt", "JournalEntry", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "VendorCredit"): The type of transaction that the
      #   data extension belongs to.
      # - `txn_id` (String): `txn_id` is the unique QuickBooks identifier for a transaction. Use it
      #   to reference that transaction in later requests. `txn_id` values are transaction-specific
      #   and should not be reused across unrelated transaction types.
      # - `txn_line_id` (String): Identification number of the transaction line. (`txn_line_id` is
      #   supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1, `txn_line_id` is always
      #   returned as zero.) If you need to add a new transaction line in a transaction Mod request,
      #   you can do so by setting the `txn_line_id` to -1.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-exts/create-data-ext
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_ext.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Delete data ext: DELETE /connections/{connection_id}/data-exts (`data_ext.delete`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `data_ext_del` (Hash, required): DataExt The DataExtAdd request writes data to the
      #   specified data extension for the specified object. Before you can use a DataExtAdd message
      #   to populate a data-extension field with data, the field must be defined, either through
      #   the SDK via a DataExtDefAdd request or via the QuickBooks UI by the interactive user.
      #   Give at most one of: `list_data_ext_type` with `list_obj_ref`, or `txn_data_ext_type` with
      #   `txn_id` with `txn_line_id`, or `other_data_ext_type`.
      #   - `data_ext_name` (String, required): The name of the data extension. If this is a custom
      #     field, `data_ext_name` will be visible as a label in the QuickBooks user interface. Also
      #     because `owner_id` and `data_ext_name` together make the data extension unique, and
      #     because custom fields all have the same `owner_id` of zero, the `data_ext_name` must be
      #     a unique value among existing custom fields.
      #   - `list_data_ext_type` (one of "Account", "Customer", "Employee", "Item", "OtherName",
      #     "Vendor"): The type of list object (e.g. Customer) that this data extension is attached
      #     to.
      #   - `list_obj_ref` (Hash): Refers to a list object. In a DataExtAdd request, the list object
      #     ref must be the same type as the type specified in `list_data_ext_type`. If a
      #     `list_obj_ref` aggregate includes both `full_name` and `list_id`, `full_name` will be
      #     ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `other_data_ext_type` (one of "Company"): Not supported.
      #   - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use 0
      #     for QuickBooks custom fields that appear in the UI, or use a GUID for private extensions
      #     owned by an app. Keep private GUIDs confidential unless you intentionally share
      #     extensions across apps. If you do share them, both apps must use the same `owner_id` and
      #     `data_ext_name`, because that pair uniquely identifies the extension.
      #   - `txn_data_ext_type` (one of "ARRefundCreditCard", "Bill", "BillPaymentCheck",
      #     "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check", "CreditCardCharge",
      #     "CreditCardCredit", "CreditMemo", "Deposit", "Estimate", "InventoryAdjustment",
      #     "Invoice", "ItemReceipt", "JournalEntry", "PurchaseOrder", "ReceivePayment",
      #     "SalesOrder", "SalesReceipt", "SalesTaxPaymentCheck", "VendorCredit"): The type of
      #     transaction that the data extension belongs to.
      #   - `txn_id` (String): `txn_id` is the unique QuickBooks identifier for a transaction. Use
      #     it to reference that transaction in later requests. `txn_id` values are
      #     transaction-specific and should not be reused across unrelated transaction types.
      #   - `txn_line_id` (String): Identification number of the transaction line. (`txn_line_id` is
      #     supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1, `txn_line_id` is always
      #     returned as zero.) If you need to add a new transaction line in a transaction Mod
      #     request, you can do so by setting the `txn_line_id` to -1.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-exts/delete-data-ext
      def delete(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_ext.delete", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update data ext: PUT /connections/{connection_id}/data-exts (`data_ext.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # Give at most one of: `list_data_ext_type` with `list_obj_ref`, or `txn_data_ext_type` with
      # `txn_id` with `txn_line_id`, or `other_data_ext_type`.
      # - `data_ext_name` (String, required): The name of the data extension. If this is a custom
      #   field, `data_ext_name` will be visible as a label in the QuickBooks user interface. Also
      #   because `owner_id` and `data_ext_name` together make the data extension unique, and
      #   because custom fields all have the same `owner_id` of zero, the `data_ext_name` must be a
      #   unique value among existing custom fields.
      # - `data_ext_value` (String, required): The data in this field. The maximum length of
      #   `data_ext_value` will depend on the `data_ext_type` of this data extension. For example,
      #   if `data_ext_type` is STR255TYPE, the maximum length of `data_ext_value` is 255
      #   characters. If `data_ext_type` is STR1024TYPE, the maximum size of `data_ext_value` is
      #   1KB.
      # - `list_data_ext_type` (one of "Account", "Customer", "Employee", "Item", "OtherName",
      #   "Vendor"): The type of list object (e.g. Customer) that this data extension is attached
      #   to.
      # - `list_obj_ref` (Hash): Refers to a list object. In a DataExtAdd request, the list object
      #   ref must be the same type as the type specified in `list_data_ext_type`. If a
      #   `list_obj_ref` aggregate includes both `full_name` and `list_id`, `full_name` will be
      #   ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `other_data_ext_type` (one of "Company"): Not supported.
      # - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use 0
      #   for QuickBooks custom fields that appear in the UI, or use a GUID for private extensions
      #   owned by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_data_ext_type` (one of "ARRefundCreditCard", "Bill", "BillPaymentCheck",
      #   "BillPaymentCreditCard", "BuildAssembly", "Charge", "Check", "CreditCardCharge",
      #   "CreditCardCredit", "CreditMemo", "Deposit", "Estimate", "InventoryAdjustment", "Invoice",
      #   "ItemReceipt", "JournalEntry", "PurchaseOrder", "ReceivePayment", "SalesOrder",
      #   "SalesReceipt", "SalesTaxPaymentCheck", "VendorCredit"): The type of transaction that the
      #   data extension belongs to.
      # - `txn_id` (String): `txn_id` is the unique QuickBooks identifier for a transaction. Use it
      #   to reference that transaction in later requests. `txn_id` values are transaction-specific
      #   and should not be reused across unrelated transaction types.
      # - `txn_line_id` (String): Identification number of the transaction line. (`txn_line_id` is
      #   supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1, `txn_line_id` is always
      #   returned as zero.) If you need to add a new transaction line in a transaction Mod request,
      #   you can do so by setting the `txn_line_id` to -1.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/data-exts/update-data-ext
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("data_ext.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
