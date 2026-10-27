# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks list operations, reached as `client.list`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class List < Base
      # Delete list: DELETE /connections/{connection_id}/lists (`list.delete`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `list_del_type` (one of "Account", "BillingRate", "Class", "Currency", "Customer",
      #   "CustomerMsg", "CustomerType", "DateDrivenTerms", "Employee", "InventorySite",
      #   "ItemDiscount", "ItemFixedAsset", "ItemGroup", "ItemInventory", "ItemInventoryAssembly",
      #   "ItemNonInventory", "ItemOtherCharge", "ItemPayment", "ItemSalesTax", "ItemSalesTaxGroup",
      #   "ItemService", "ItemSubtotal", "JobType", "OtherName", "PaymentMethod",
      #   "PayrollItemNonWage", "PayrollItemWage", "PriceLevel", "SalesRep", "SalesTaxCode",
      #   "ShipMethod", "StandardTerms", "ToDo", "UnitOfMeasureSet", "Vehicle", "Vendor",
      #   "VendorType", "WorkersCompCode", required): The type of list from which a list member is
      #   being deleted.
      # - `list_id` (String, required): `list_id` and FullName both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/lists/delete-list
      def delete(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("list.delete", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
