# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks qb command exec operations, reached as `client.qb_command_exec`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class QbCommandExec < Base
      # Execute QB command exec: POST /connections/{connection_id}/qb-command-exec
      # (`qb_command_exec.execute`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `argument` (Array<Hash>)
      #   - `arg_name` (String, required)
      #   - `arg_value` (String): Choose exactly one of: `arg_value`, or `list_id`, or `txn_id`.
      #   - `list_id` (String): Choose exactly one of: `arg_value`, or `list_id`, or `txn_id`.
      #   - `txn_id` (String): Choose exactly one of: `arg_value`, or `list_id`, or `txn_id`.
      # - `qb_command` (one of "Backup", "ExportQBDT2QBO", "ExportReport", "IIFImport",
      #   "MobiLinkSync", "Restore", "ScheduledReport", required)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/qb-command-exec/execute-qb-command-exec
      def execute(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("qb_command_exec.execute", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
