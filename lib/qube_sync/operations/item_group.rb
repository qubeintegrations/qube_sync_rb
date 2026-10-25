# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks item group operations, reached as `client.item_group`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ItemGroup < Base
      # Create item group: POST /connections/{connection_id}/item-groups (`item_group.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `bar_code` (Hash): Barcode reference information.
      #   - `allow_override` (Boolean): Allows for barcode to be overridden for an item.
      #   - `assign_even_if_used` (Boolean): Allow barcode to be assigned to item, even if already
      #     in use.
      #   - `bar_code_value` (String): Value of the barcode in the item.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `include_ret_element` (Array<one of "BarCodeValue", "DataExtRet", "EditSequence",
      #   "ExternalGUID", "IsActive", "IsPrintItemsInGroup", "ItemDesc", "ItemGroupLine", "ListID",
      #   "Name", "OwnerID", "SpecialItemType", "TimeCreated", "TimeModified", "TxnID", "TxnNumber",
      #   "UnitOfMeasureSetRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_print_items_in_group` (Boolean): If true, a list of this group’s individual items
      #   their amounts will appear on printed forms.
      # - `item_desc` (String): The description that will appear on a sales form when the item is
      #   used.
      # - `item_group_line` (Array<Hash>)
      #   - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #     depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #     sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #     BillingRateAdd requires a service item. If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because `full_name` remains distinct.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `unit_of_measure_set_ref` (Hash): The unit of measure set consists of a base unit and 0-n
      #   related units.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/item-groups/create-item-group
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_group.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List item groups: GET /connections/{connection_id}/item-groups (`item_group.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
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
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "BarCodeValue", "DataExtRet", "EditSequence",
      #   "ExternalGUID", "IsActive", "IsPrintItemsInGroup", "ItemDesc", "ItemGroupLine", "ListID",
      #   "Name", "SpecialItemType", "TimeCreated", "TimeModified", "UnitOfMeasureSetRef">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records; send `iterator=true` with `max_returned` for another
      #   size. Off when you send `iterator=false` (every match in one answer) or `max_returned`
      #   alone (at most that many, in one answer). It pages a filtered query only: with `full_name`
      #   or `list_id` every match comes back in one answer, so leave `iterator` out.
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
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
      # - `owner_id` (Array<String>): `owner_id` identifies who owns the data extension. Use 0 for
      #   QuickBooks custom fields that appear in the UI, or use a GUID for private extensions owned
      #   by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
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
      # @see https://docs.qubesync.com/api-reference/v2/item-groups/list-item-groups
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_group.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update item group: PUT /connections/{connection_id}/item-groups (`item_group.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `bar_code` (Hash): Barcode reference information.
      #   - `allow_override` (Boolean): Allows for barcode to be overridden for an item.
      #   - `assign_even_if_used` (Boolean): Allow barcode to be assigned to item, even if already
      #     in use.
      #   - `bar_code_value` (String): Value of the barcode in the item.
      # - `clear_items_in_group` (Boolean): Set to true to clear all the items in this group. Choose
      #   at most one of: `clear_items_in_group`, or `item_group_line`.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `force_uom_change` (Boolean): By Default `force_uom_change` is false. However, in item Mod
      #   requests, you need to set the `force_uom_change` field to True if you are changing the UOM
      #   set and the base unit of the new set doesn’t match the base unit of the UOM set currently
      #   assigned to the item. This does the same thing as the user accepting the warning prompt in
      #   the UI.
      # - `include_ret_element` (Array<one of "BarCodeValue", "DataExtRet", "EditSequence",
      #   "ExternalGUID", "IsActive", "IsPrintItemsInGroup", "ItemDesc", "ItemGroupLine", "ListID",
      #   "Name", "OwnerID", "SpecialItemType", "TimeCreated", "TimeModified", "TxnID", "TxnNumber",
      #   "UnitOfMeasureSetRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_print_items_in_group` (Boolean): If true, a list of this group’s individual items
      #   their amounts will appear on printed forms.
      # - `item_desc` (String): The description that will appear on a sales form when the item is
      #   used.
      # - `item_group_line` (Array<Hash>): Choose at most one of: `clear_items_in_group`, or
      #   `item_group_line`.
      #   - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #     depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #     sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #     BillingRateAdd requires a service item. If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because `full_name` remains distinct.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `unit_of_measure_set_ref` (Hash): The unit of measure set consists of a base unit and 0-n
      #   related units.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/item-groups/update-item-group
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_group.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
