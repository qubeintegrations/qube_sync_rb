# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks host operations, reached as `client.host`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Host < Base
      # List hosts: GET /connections/{connection_id}/hosts (`host.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `include_list_meta_data` (Hash): Use this aggregate if you want the query to return list
      #   capacity metadata for each object type in QuickBooks.
      #   - `include_max_capacity` (Boolean, required): Specify the value “true” to return max list
      #     limits for each object type, or “false” to not return these in the query response. By
      #     default, this is “false” for HostQuery.
      # - `include_ret_element` (Array<one of "Country", "IsAutomaticLogin", "ListMetaData",
      #   "MajorVersion", "MinorVersion", "ProductName", "QBFileMode", "SupportedQBXMLVersion">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/hosts/list-hosts
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("host.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
