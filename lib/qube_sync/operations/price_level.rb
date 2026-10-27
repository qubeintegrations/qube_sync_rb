# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks price level operations, reached as `client.price_level`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PriceLevel < Base
      # Create price level: POST /connections/{connection_id}/price-levels (`price_level.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # Give at most one of: `price_level_fixed_percentage`, or `currency_ref` with
      # `price_level_per_item`.
      # - `currency_ref` (Hash): A currency record defines how QuickBooks stores and displays a
      #   currency. Built-in currency name/code values are fixed; formatting and active status can
      #   vary by settings and workflow.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `include_ret_element` (Array<one of "CurrencyRef", "EditSequence", "ExternalGUID",
      #   "IsActive", "ListID", "Name", "OwnerID", "PriceLevelFixedPercentage",
      #   "PriceLevelPerItemRet", "PriceLevelType", "TimeCreated", "TimeModified", "TxnID",
      #   "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because `full_name` remains distinct.
      # - `price_level_fixed_percentage` (Numeric): When you create a price level, you must specify
      #   whether it is a fixed percentage or a per item price level. Once you create the price
      #   level, you can’t change this. QuickBooks Pro and greater versions support fixed
      #   percentages, but only QuickBooks Premier and Enterprise support the per item price level.
      #   Where is this discount applied if Price Levels are enabled in QuickBooks preferences?
      # - `price_level_per_item` (Array<Hash>)
      #   - `adjust_percentage` (Numeric): If you don’t want to apply a custom price (for price
      #     levels) or custom rate (for billing rates), you can apply an adjusted price discount
      #     using the pair of fields `adjust_percentage` and `adjust_relative_to`
      #     (AdjustBillingRateRelativeTo for billing rates). Choose exactly one of: the set
      #     (`custom_price`, `custom_price_percent`), or the set (`adjust_percentage`,
      #     `adjust_relative_to`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `adjust_relative_to` (one of "Cost", "CurrentCustomPrice", "StandardPrice"): When you
      #     create a price level, you have the option to create it with a flat custom price (flat
      #     amount or percentage) or you could use PriceLevelAdjustment to apply a price discount
      #     based on either the current custom price, the standard price of the item, or the cost of
      #     the item. Choose exactly one of: the set (`custom_price`, `custom_price_percent`), or
      #     the set (`adjust_percentage`, `adjust_relative_to`). Members of a set combine with each
      #     other, not with the other choices.
      #   - `custom_price` (Numeric): When you create a price level, you have the option to create
      #     it with a custom price that is either a fixed amount (`custom_price`) or a fixed
      #     discount percentage (`custom_price_percent`). Alternatively, instead of a flat custom
      #     price or discount, you could apply a price discount based on either the current custom
      #     price, the standard price of the item, or the cost of the item. Choose exactly one of:
      #     the set (`custom_price`, `custom_price_percent`), or the set (`adjust_percentage`,
      #     `adjust_relative_to`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `custom_price_percent` (Numeric): When you create a price level, you have the option to
      #     create it with a custom price that is either a fixed amount (`custom_price`) or a fixed
      #     discount percentage (`custom_price_percent`). Choose exactly one of: the set
      #     (`custom_price`, `custom_price_percent`), or the set (`adjust_percentage`,
      #     `adjust_relative_to`). Members of a set combine with each other, not with the other
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
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/price-levels/create-price-level
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("price_level.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List price levels: GET /connections/{connection_id}/price-levels (`price_level.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`active_status`, `currency_filter`,
      #   `from_modified_date`, `item_ref`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `currency_filter` (Hash): Filters by the specified currency. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `currency_filter`,
      #   `from_modified_date`, `item_ref`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `currency_filter`, `from_modified_date`,
      #   `item_ref`, `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`).
      #   Members of a set combine with each other, not with the other choices.
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `currency_filter`,
      #   `from_modified_date`, `item_ref`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "CurrencyRef", "EditSequence", "IsActive", "ListID",
      #   "Name", "PriceLevelFixedPercentage", "PriceLevelPerItemRet", "PriceLevelType",
      #   "TimeCreated", "TimeModified">)
      # - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset, depending
      #   on the request. Examples: PurchaseOrder and Bill do not allow discount or sales-tax items;
      #   VehicleMileageAdd requires a service or other-charge item; BillingRateAdd requires a
      #   service item. If both `full_name` and `list_id` are provided, `full_name` is ignored.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `currency_filter`, `from_modified_date`, `item_ref`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
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
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `currency_filter`, `from_modified_date`, `item_ref`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. QuickBooks
      #   doesn't page this query: at most this many records come back, in one answer, with no sign
      #   of whether more matched. Leave it out for every match, in one answer; one over 4 MB as the
      #   Web Connector sends it, about 3 MB of qbXML isn't kept (`error_type`
      #   `response_too_large`), so narrow a large one with its filters. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `currency_filter`,
      #   `from_modified_date`, `item_ref`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `currency_filter`,
      #   `from_modified_date`, `item_ref`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `currency_filter`,
      #   `from_modified_date`, `item_ref`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
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
      #   `list_id`, or `full_name`, or the set (`active_status`, `currency_filter`,
      #   `from_modified_date`, `item_ref`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/price-levels/list-price-levels
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("price_level.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update price level: PUT /connections/{connection_id}/price-levels (`price_level.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `currency_ref` (Hash): A currency record defines how QuickBooks stores and displays a
      #   currency. Built-in currency name/code values are fixed; formatting and active status can
      #   vary by settings and workflow. Choose at most one of: `price_level_fixed_percentage`, or
      #   the set (`currency_ref`, `price_level_per_item`). Members of a set combine with each
      #   other, not with the other choices.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `include_ret_element` (Array<one of "CurrencyRef", "EditSequence", "ExternalGUID",
      #   "IsActive", "ListID", "Name", "OwnerID", "PriceLevelFixedPercentage",
      #   "PriceLevelPerItemRet", "PriceLevelType", "TimeCreated", "TimeModified", "TxnID",
      #   "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because `full_name` remains distinct.
      # - `price_level_fixed_percentage` (Numeric): When you create a price level, you must specify
      #   whether it is a fixed percentage or a per item price level. Once you create the price
      #   level, you can’t change this. QuickBooks Pro and greater versions support fixed
      #   percentages, but only QuickBooks Premier and Enterprise support the per item price level.
      #   Where is this discount applied if Price Levels are enabled in QuickBooks preferences?
      #   Choose at most one of: `price_level_fixed_percentage`, or the set (`currency_ref`,
      #   `price_level_per_item`). Members of a set combine with each other, not with the other
      #   choices.
      # - `price_level_per_item` (Array<Hash>): Choose at most one of:
      #   `price_level_fixed_percentage`, or the set (`currency_ref`, `price_level_per_item`).
      #   Members of a set combine with each other, not with the other choices.
      #   - `adjust_percentage` (Numeric): If you don’t want to apply a custom price (for price
      #     levels) or custom rate (for billing rates), you can apply an adjusted price discount
      #     using the pair of fields `adjust_percentage` and `adjust_relative_to`
      #     (AdjustBillingRateRelativeTo for billing rates). Choose exactly one of: the set
      #     (`custom_price`, `custom_price_percent`), or the set (`adjust_percentage`,
      #     `adjust_relative_to`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `adjust_relative_to` (one of "Cost", "CurrentCustomPrice", "StandardPrice"): When you
      #     create a price level, you have the option to create it with a flat custom price (flat
      #     amount or percentage) or you could use PriceLevelAdjustment to apply a price discount
      #     based on either the current custom price, the standard price of the item, or the cost of
      #     the item. Choose exactly one of: the set (`custom_price`, `custom_price_percent`), or
      #     the set (`adjust_percentage`, `adjust_relative_to`). Members of a set combine with each
      #     other, not with the other choices.
      #   - `custom_price` (Numeric): When you create a price level, you have the option to create
      #     it with a custom price that is either a fixed amount (`custom_price`) or a fixed
      #     discount percentage (`custom_price_percent`). Alternatively, instead of a flat custom
      #     price or discount, you could apply a price discount based on either the current custom
      #     price, the standard price of the item, or the cost of the item. Choose exactly one of:
      #     the set (`custom_price`, `custom_price_percent`), or the set (`adjust_percentage`,
      #     `adjust_relative_to`). Members of a set combine with each other, not with the other
      #     choices.
      #   - `custom_price_percent` (Numeric): When you create a price level, you have the option to
      #     create it with a custom price that is either a fixed amount (`custom_price`) or a fixed
      #     discount percentage (`custom_price_percent`). Choose exactly one of: the set
      #     (`custom_price`, `custom_price_percent`), or the set (`adjust_percentage`,
      #     `adjust_relative_to`). Members of a set combine with each other, not with the other
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
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/price-levels/update-price-level
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("price_level.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
