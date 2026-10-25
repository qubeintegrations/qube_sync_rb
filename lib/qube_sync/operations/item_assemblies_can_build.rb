# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks item assemblies can build operations, reached as `client.item_assemblies_can_build`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ItemAssembliesCanBuild < Base
      # List item assemblies can builds: GET /connections/{connection_id}/item-assemblies-can-builds
      # (`item_assemblies_can_build.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `item_inventory_assembly_ref` (Hash, required): An inventory assembly item is one that is
      #   assembled or manufactured from inventory items. The items and/or assemblies that make up
      #   the assembly are called components. For Premier, an assembly can have a maximum of 100
      #   components. For Enterprise, the maximum is 500 components.
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
      # - `txn_date` (String, required): The date of the transaction. In some cases, if you leave
      #   `txn_date` out of an -Add message, QuickBooks will prefill `txn_date` with the date of the
      #   last-saved transaction of the same type.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/item-assemblies-can-builds/list-item-assemblies-can-builds
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_assemblies_can_build.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
