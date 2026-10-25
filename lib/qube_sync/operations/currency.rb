# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks currency operations, reached as `client.currency`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Currency < Base
      # Create currency: POST /connections/{connection_id}/currencies (`currency.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `currency_code` (String, required): For built-in currencies, the currency code and name is
      #   the generally accepted code and name. These are based on the standard ISO 4217 code/name
      #   for a country’s currency. In most cases, the currency code is composed of the country’s
      #   two-character Internet country code plus an extra character representing the currency
      #   unit.
      # - `currency_format` (Hash): The aggregate controlling the appearance of the currency with
      #   regard to comma and decimal.
      #   - `decimal_places` (one of "0", "2"): This enumerated value controls the display of the
      #     decimal value, for example, 1.00. The default is 2 which means 2 decimals are displayed
      #     to the right of the decimal point, but you can specify 0 (zero) if you don’t want’
      #     decimals to be displayed.
      #   - `decimal_separator` (one of "Comma", "Period"): This enumerated value controls the
      #     display of the decimal point, for example, 1.00 or 1,00. The default is Period but you
      #     could alternatively specify a value of Comma.
      #   - `thousand_separator` (one of "Apostrophe", "Comma", "Period", "Space"): This enumerated
      #     value controls how the thousandth’s place is separated from the next thousand, for
      #     example, 1,000,000. The default is Comma, as shown, but you can replace this with one of
      #     these values: Period, Space, Apostrophe .
      #   - `thousand_separator_grouping` (one of "XX_XXX_XXX", "X_XX_XX_XXX"): This enumerated
      #     value controls how the display of the currency value is grouped, for example,
      #     10,000,000. The default is XX_XXX_XXX but you could replace this with X_XX_XX_XXX
      # - `include_ret_element` (Array<one of "AsOfDate", "CurrencyCode", "CurrencyFormat",
      #   "EditSequence", "ExchangeRate", "ExternalGUID", "IsActive", "IsUserDefinedCurrency",
      #   "ListID", "Name", "OwnerID", "TimeCreated", "TimeModified", "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because FullName remains distinct.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/currencies/create-currency
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("currency.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List currencies: GET /connections/{connection_id}/currencies (`currency.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `from_modified_date`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set combine with
      #   each other, not with the other choices.
      # - `full_name` (Array<String>): Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `include_ret_element` (Array<one of "AsOfDate", "CurrencyCode", "CurrencyFormat",
      #   "EditSequence", "ExchangeRate", "IsActive", "IsUserDefinedCurrency", "ListID", "Name",
      #   "TimeCreated", "TimeModified">)
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. QuickBooks
      #   doesn't page this query: at most this many records come back, in one answer, with no sign
      #   of whether more matched. Leave it out for every match, in one answer; one over 4 MB as the
      #   Web Connector sends it, about 3 MB of qbXML isn't kept (`error_type`
      #   `response_too_large`), so narrow a large one with its filters. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
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
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/currencies/list-currencies
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("currency.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update currency: PUT /connections/{connection_id}/currencies (`currency.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `currency_code` (String): For built-in currencies, the currency code and name is the
      #   generally accepted code and name. These are based on the standard ISO 4217 code/name for a
      #   country’s currency. In most cases, the currency code is composed of the country’s
      #   two-character Internet country code plus an extra character representing the currency
      #   unit.
      # - `currency_format` (Hash): The aggregate controlling the appearance of the currency with
      #   regard to comma and decimal.
      #   - `decimal_places` (one of "0", "2"): This enumerated value controls the display of the
      #     decimal value, for example, 1.00. The default is 2 which means 2 decimals are displayed
      #     to the right of the decimal point, but you can specify 0 (zero) if you don’t want’
      #     decimals to be displayed.
      #   - `decimal_separator` (one of "Comma", "Period"): This enumerated value controls the
      #     display of the decimal point, for example, 1.00 or 1,00. The default is Period but you
      #     could alternatively specify a value of Comma.
      #   - `thousand_separator` (one of "Apostrophe", "Comma", "Period", "Space"): This enumerated
      #     value controls how the thousandth’s place is separated from the next thousand, for
      #     example, 1,000,000. The default is Comma, as shown, but you can replace this with one of
      #     these values: Period, Space, Apostrophe .
      #   - `thousand_separator_grouping` (one of "XX_XXX_XXX", "X_XX_XX_XXX"): This enumerated
      #     value controls how the display of the currency value is grouped, for example,
      #     10,000,000. The default is XX_XXX_XXX but you could replace this with X_XX_XX_XXX
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `include_ret_element` (Array<one of "AsOfDate", "CurrencyCode", "CurrencyFormat",
      #   "EditSequence", "ExchangeRate", "ExternalGUID", "IsActive", "IsUserDefinedCurrency",
      #   "ListID", "Name", "OwnerID", "TimeCreated", "TimeModified", "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `list_id` (String, required): `list_id` and FullName both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both FullName and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores FullName.
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because FullName remains distinct.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/currencies/update-currency
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("currency.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
