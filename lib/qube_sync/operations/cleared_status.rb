# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks cleared status operations, reached as `client.cleared_status`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ClearedStatus < Base
      # Update cleared status: PUT /connections/{connection_id}/cleared-statuses
      # (`cleared_status.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `cleared_status` (one of "Cleared", "NotCleared", "Pending", required): Indicates whether
      #   a transaction or transaction line has been cleared.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      # - `txn_line_id` (String): Identification number of the transaction line. (`txn_line_id` is
      #   supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1, `txn_line_id` is always
      #   returned as zero.) G/p>If you need to add a new transaction line in a transaction Mod
      #   request, you can do so by setting the `txn_line_id` to -1.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/cleared-statuses/update-cleared-status
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("cleared_status.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
