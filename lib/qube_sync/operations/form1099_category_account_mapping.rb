# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks form1099 category account mapping operations, reached as `client.form1099_category_account_mapping`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Form1099CategoryAccountMapping < Base
      # List form1099 category account mappings: GET
      # /connections/{connection_id}/form1099-category-account-mappings
      # (`form1099_category_account_mapping.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `form_type` (String): Added a form type to support Form 1099-NEC and Form 1099-MISC.
      #   `form_type` is a property to identify the type of form (MISC/NEC) for which
      #   Form1099CategoryAccountMapping query is run. Form type will be MISC if no `form_type` is
      #   specified.
      # - `mapping_category` (Array<one of "BOX1", "BOX10", "BOX13", "BOX14", "BOX2", "BOX3",
      #   "BOX4", "BOX5", "BOX6", "BOX7", "BOX8", "BOX9">): A mapping category indicates the form
      #   1099 box that one or more accounts is being mapped to. You must specify one of the
      #   following enumerated values based on the form type:
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/form1099-category-account-mappings/list-form1099-category-account-mappings
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("form1099_category_account_mapping.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update form1099 category account mapping: PUT
      # /connections/{connection_id}/form1099-category-account-mappings
      # (`form1099_category_account_mapping.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `category_account_mapping_mod` (Array<Hash>)
      #   - `mapping_account` (Array<Hash>)
      #     - `account_ref` (Hash, required): `account_ref` points to an account in the company
      #       file. If both `full_name` and `list_id` are provided, `full_name` is ignored. Meaning
      #       depends on context: for checks it is the funding account; for ExpenseLineAdd it may be
      #       required by accounting preferences; for credit-card transactions it identifies the
      #       bank or card account involved.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `force_mapping` (Boolean): In some circumstances, changing the account mapping could
      #       result in the displaying of a user dialog in the QuickBooks UI prompting the user to
      #       confirm, which would prevent the SDK request from completing. Setting this property to
      #       true causes that user dialog to be suppressed.
      #   - `mapping_category` (one of "BOX1", "BOX10", "BOX13", "BOX14", "BOX2", "BOX3", "BOX4",
      #     "BOX5", "BOX6", "BOX7", "BOX8", "BOX9", required): A mapping category indicates the form
      #     1099 box that one or more accounts is being mapped to. You must specify one of the
      #     following enumerated values based on the form type:
      #   - `threshold` (Numeric): This is the dollar amount at which the IRS requires you to file
      #     the 1099-MISC and 1099-NEC forms. Each box (“Category” in SDK lingo) can have a separate
      #     threshold, as established by the IRS. For the latest thresholds, check the website for
      #     the Internal Revenue Service, currently at www.irs.gov.
      # - `is_filing1099_misc` (Boolean): This property reports only (it doesn’t set!) the current
      #   status of 1099 preferences setting in the company file. The value true indicates that the
      #   company file currently has the 1099 filing preference turned on. The value false indicates
      #   that the company file isn’t currently set to file 1099-MISC and 1099-NEC forms.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/form1099-category-account-mappings/update-form1099-category-account-mapping
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("form1099_category_account_mapping.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
