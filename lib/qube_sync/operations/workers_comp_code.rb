# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks workers comp code operations, reached as `client.workers_comp_code`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class WorkersCompCode < Base
      # Create workers comp code: POST /connections/{connection_id}/workers-comp-codes
      # (`workers_comp_code.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `desc` (String): A descriptive text field.
      # - `include_ret_element` (Array<one of "CurrentEffectiveDate", "CurrentRate", "Desc",
      #   "EditSequence", "ExternalGUID", "IsActive", "ListID", "Name", "NextEffectiveDate",
      #   "NextRate", "OwnerID", "RateHistory", "TimeCreated", "TimeModified", "TxnID",
      #   "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because FullName remains distinct.
      # - `rate_entry` (Array<Hash>, required)
      #   - `effective_date` (String, required): Specifies the date at which the workers’ comp code
      #     and it’s related premium goes into effect.
      #   - `rate` (Numeric, required): Indicates the price of something.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/workers-comp-codes/create-workers-comp-code
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("workers_comp_code.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List workers comp codes: GET /connections/{connection_id}/workers-comp-codes
      # (`workers_comp_code.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `from_effective_date`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_effective_date`, `to_modified_date`). Members of a set combine
      #   with each other, not with the other choices.
      # - `from_effective_date` (String): The beginning of the range of effective dates to be
      #   searched. Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `from_effective_date`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_effective_date`, `to_modified_date`). Members of a set combine
      #   with each other, not with the other choices.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `from_effective_date`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_effective_date`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `full_name` (Array<String>): Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_effective_date`, `from_modified_date`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_effective_date`, `to_modified_date`). Members of a
      #   set combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "CurrentEffectiveDate", "CurrentRate", "Desc",
      #   "EditSequence", "IsActive", "ListID", "Name", "NextEffectiveDate", "NextRate",
      #   "RateHistory", "TimeCreated", "TimeModified">)
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `from_effective_date`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_effective_date`, `to_modified_date`). Members of a set combine
      #   with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. QuickBooks
      #   doesn't page this query: at most this many records come back, in one answer, with no sign
      #   of whether more matched. Leave it out for every match, in one answer; one over 4 MB as the
      #   Web Connector sends it, about 3 MB of qbXML isn't kept (`error_type`
      #   `response_too_large`), so narrow a large one with its filters. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_effective_date`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_effective_date`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_effective_date`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_effective_date`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_effective_date`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_effective_date`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #   - `from_name` (String): The first name or item in the search range. If `from_name` is
      #     omitted, the range will begin with first name on the list.
      #   - `to_name` (String): The final name or item in the search range. If `to_name` is omitted,
      #     the range will end with last name on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `to_effective_date` (String): The end of the range of effective dates to be searched.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `from_effective_date`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_effective_date`, `to_modified_date`). Members of a set combine
      #   with each other, not with the other choices.
      # - `to_modified_date` (String): Filters results to objects modified on or before this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to end-of-day (23:59:59). Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_effective_date`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_effective_date`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/workers-comp-codes/list-workers-comp-codes
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("workers_comp_code.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update workers comp code: PUT /connections/{connection_id}/workers-comp-codes
      # (`workers_comp_code.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `desc` (String): A descriptive text field.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `include_ret_element` (Array<one of "CurrentEffectiveDate", "CurrentRate", "Desc",
      #   "EditSequence", "ExternalGUID", "IsActive", "ListID", "Name", "NextEffectiveDate",
      #   "NextRate", "OwnerID", "RateHistory", "TimeCreated", "TimeModified", "TxnID",
      #   "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `list_id` (String, required): `list_id` and FullName both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because FullName remains distinct.
      # - `rate_entry` (Array<Hash>)
      #   - `effective_date` (String, required): Specifies the date at which the workers’ comp code
      #     and it’s related premium goes into effect.
      #   - `rate` (Numeric, required): Indicates the price of something.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/workers-comp-codes/update-workers-comp-code
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("workers_comp_code.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
