# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks billing rate operations, reached as `client.billing_rate`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class BillingRate < Base
      # Create billing rate: POST /connections/{connection_id}/billing-rates
      # (`billing_rate.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # Give at most one of: `fixed_billing_rate`, or `billing_rate_per_item`.
      # - `billing_rate_per_item` (Array<Hash>)
      #   - `adjust_billing_rate_relative_to` (one of "CurrentCustomRate", "StandardRate"):
      #     Specifies the service item rate that `adjust_percentage` is applied to. Normally, this
      #     is set to StandardRate. Choose exactly one of: the set (`custom_rate`,
      #     `custom_rate_percent`), or the set (`adjust_billing_rate_relative_to`,
      #     `adjust_percentage`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `adjust_percentage` (Numeric): If you don’t want to apply a custom price (for price
      #     levels) or custom rate (for billing rates), you can apply an adjusted price discount
      #     using the pair of fields `adjust_percentage` and AdjustRelativeTo
      #     (`adjust_billing_rate_relative_to` for billing rates). Choose exactly one of: the set
      #     (`custom_rate`, `custom_rate_percent`), or the set (`adjust_billing_rate_relative_to`,
      #     `adjust_percentage`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `custom_rate` (Numeric): The value specified here overrides the rate of the service item
      #     referenced in this aggregate (in the `item_ref`) with the rate you specify here. If
      #     instead you wanted a rate that is a percentage higher or lower than the service item
      #     rate, you wouldn’t use `custom_rate`, but you would use `adjust_percentage` and
      #     `adjust_billing_rate_relative_to`. Choose exactly one of: the set (`custom_rate`,
      #     `custom_rate_percent`), or the set (`adjust_billing_rate_relative_to`,
      #     `adjust_percentage`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `custom_rate_percent` (Numeric): Using this field with BillingRateAdd will work only if
      #     the service item itself is set to a percentage, not to an amount. If you attempt to set
      #     the Billing Rate to a percentage for a service item that has an amount for the Rate, you
      #     will get an error. The kind of rate you have on the service item determines the kind of
      #     billing rate you may have on that item. Choose exactly one of: the set (`custom_rate`,
      #     `custom_rate_percent`), or the set (`adjust_billing_rate_relative_to`,
      #     `adjust_percentage`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `item_ref` (Hash, required): `item_ref` may accept all item types or a restricted
      #     subset, depending on the request. Examples: PurchaseOrder and Bill do not allow discount
      #     or sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #     BillingRateAdd requires a service item. If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      # - `fixed_billing_rate` (Numeric): You use `fixed_billing_rate` if you want the rate to
      #   override all service items rates. Consequently, there is no need to specify any service
      #   items (and in fact you can’t specify them) if you use this element.
      # - `include_ret_element` (Array<one of "BillingRatePerItemRet", "BillingRateType",
      #   "EditSequence", "ExternalGUID", "FixedBillingRate", "ListID", "Name", "OwnerID",
      #   "TimeCreated", "TimeModified", "TxnID", "TxnNumber">)
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because `full_name` remains distinct.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/billing-rates/create-billing-rate
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("billing_rate.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List billing rates: GET /connections/{connection_id}/billing-rates (`billing_rate.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`from_modified_date`, `item_ref`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`from_modified_date`, `item_ref`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "BillingRatePerItemRet", "BillingRateType",
      #   "EditSequence", "FixedBillingRate", "ListID", "Name", "TimeCreated", "TimeModified">)
      # - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset, depending
      #   on the request. Examples: PurchaseOrder and Bill do not allow discount or sales-tax items;
      #   VehicleMileageAdd requires a service or other-charge item; BillingRateAdd requires a
      #   service item. If both `full_name` and `list_id` are provided, `full_name` is ignored.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`from_modified_date`,
      #   `item_ref`, `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`).
      #   Members of a set combine with each other, not with the other choices.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`from_modified_date`,
      #   `item_ref`, `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`).
      #   Members of a set combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. QuickBooks
      #   doesn't page this query: at most this many records come back, in one answer, with no sign
      #   of whether more matched. Leave it out for every match, in one answer; one over 4 MB as the
      #   Web Connector sends it, about 3 MB of qbXML isn't kept (`error_type`
      #   `response_too_large`), so narrow a large one with its filters. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`from_modified_date`, `item_ref`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set combine with
      #   each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`from_modified_date`, `item_ref`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set combine with
      #   each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`from_modified_date`, `item_ref`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set combine with
      #   each other, not with the other choices.
      #   - `from_name` (String): The first name or item in the search range. If `from_name` is
      #     omitted, the range will begin with first name on the list.
      #   - `to_name` (String): The final name or item in the search range. If `to_name` is omitted,
      #     the range will end with last name on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `to_modified_date` (String): Filters results to objects modified on or before this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to end-of-day (23:59:59). Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`from_modified_date`, `item_ref`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set combine with
      #   each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/billing-rates/list-billing-rates
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("billing_rate.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
