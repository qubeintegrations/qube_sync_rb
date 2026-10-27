# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks item non inventory operations, reached as `client.item_non_inventory`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ItemNonInventory < Base
      # Create item non inventory: POST /connections/{connection_id}/item-non-inventories
      # (`item_non_inventory.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # Give at most one of: `sales_or_purchase`, or `sales_and_purchase`.
      # - `bar_code` (Hash): Barcode reference information.
      #   - `allow_override` (Boolean): Allows for barcode to be overridden for an item.
      #   - `assign_even_if_used` (Boolean): Allow barcode to be assigned to item, even if already
      #     in use.
      #   - `bar_code_value` (String): Value of the barcode in the item.
      # - `class_ref` (Hash): Use classes to categorize transactions (for example, by department,
      #   location, or work type). Class tracking is off by default in QuickBooks. A `class_ref`
      #   points to one class; if both `full_name` and `list_id` are provided, `full_name` is
      #   ignored. In InvoiceAdd, a header-level `class_ref` is applied to line items unless you
      #   override or clear it on individual lines.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `include_ret_element` (Array<one of "BarCodeValue", "ClassRef", "DataExtRet",
      #   "EditSequence", "ExternalGUID", "FullName", "IsActive", "IsTaxIncluded", "ListID",
      #   "ManufacturerPartNumber", "Name", "OwnerID", "ParentRef", "SalesAndPurchase",
      #   "SalesOrPurchase", "SalesTaxCodeRef", "Sublevel", "TimeCreated", "TimeModified", "TxnID",
      #   "TxnNumber", "UnitOfMeasureSetRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `manufacturer_part_number` (String): The part number used by the manufacturer of the item.
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because `full_name` remains distinct.
      # - `parent_ref` (Hash): A reference to the list object that is one level above this one. For
      #   example, an inventory item with the `full_name` of GermanCars:Mercedes-Benz:CL500I99AA
      #   might have a parent object with the `full_name` of GermanCars:Mercedes-Benz. In a request,
      #   if a `parent_ref` aggregate includes both `full_name` and `list_id`, `full_name` will be
      #   ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `sales_and_purchase` (Hash): A `sales_and_purchase` aggregate is used for items that are
      #   meant to be both purchased and sold, such as an “other charge” item that is reimbursable.
      #   - `expense_account_ref` (Hash): Refers to an expense account. If an `expense_account_ref`
      #     aggregate includes both `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `income_account_ref` (Hash): Refers to an income account. If an `income_account_ref`
      #     aggregate includes both `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `pref_vendor_ref` (Hash): The preferred vendor for this item. If a `pref_vendor_ref`
      #     aggregate includes both `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `purchase_cost` (Numeric): Amount that the QuickBooks user expects to pay when ordering
      #     or buying this item, or the amount that was actually paid for this item.
      #   - `purchase_desc` (String): Description that appears in the Description column of checks,
      #     bills, credit card charges, and item receipts (when an item is reordered). For a fixed
      #     asset, a description of the item as it was when it was purchased.
      #   - `purchase_tax_code_ref` (Hash): Account used for taxes on purchases in CA or UK.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `sales_desc` (String): Appears in the Description column of a sales form when the
      #     QuickBooks user sells this item. For a fixed asset, describes the sale of the asset (for
      #     accounting purposes).
      #   - `sales_price` (Numeric): Price charged for this item.
      # - `sales_or_purchase` (Hash): A `sales_or_purchase` aggregate is used for items that are
      #   meant to be either purchased or sold, but not both. For example, a `sales_or_purchase`
      #   aggregate would be used for a non-inventory item that is purchased but not sold, or for a
      #   service item that is sold but not purchased.
      #   - `account_ref` (Hash): `account_ref` points to an account in the company file. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #     context: for checks it is the funding account; for ExpenseLineAdd it may be required by
      #     accounting preferences; for credit-card transactions it identifies the bank or card
      #     account involved.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `desc` (String): A descriptive text field.
      #   - `price` (Numeric): The purchase price or sales price of this item. Choose at most one
      #     of: `price`, or `price_percent`.
      #   - `price_percent` (Numeric): The price expressed as a percent. (For example, an auto shop
      #     that calculates the cost of labor as a percentage of the cost of parts might have a
      #     service item called “Labor” that uses `price_percent` instead of Price.) Choose at most
      #     one of: `price`, or `price_percent`.
      # - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used for an
      #   item or customer context. QuickBooks includes default TAX and NON codes, and a code can be
      #   deleted only when nothing references it. If sales tax is disabled, QuickBooks assigns the
      #   default non-taxable code. If both `full_name` and `list_id` are provided in
      #   `sales_tax_code_ref`, `full_name` is ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `unit_of_measure_set_ref` (Hash): The unit of measure set consists of a base unit and 0-n
      #   related units.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/item-non-inventories/create-item-non-inventory
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_non_inventory.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List item non inventories: GET /connections/{connection_id}/item-non-inventories
      # (`item_non_inventory.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `class_filter` (Hash): Filters according to the object’s class. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #   `full_name_with_children`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `class_filter`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "BarCodeValue", "ClassRef", "DataExtRet",
      #   "EditSequence", "ExternalGUID", "FullName", "IsActive", "IsTaxIncluded", "ListID",
      #   "ManufacturerPartNumber", "Name", "ParentRef", "SalesAndPurchase", "SalesOrPurchase",
      #   "SalesTaxCodeRef", "Sublevel", "TimeCreated", "TimeModified", "UnitOfMeasureSetRef">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records; send `iterator=true` with `max_returned` for another
      #   size. Off when you send `iterator=false` (every match in one answer) or `max_returned`
      #   alone (at most that many, in one answer). It pages a filtered query only: with `full_name`
      #   or `list_id` every match comes back in one answer, so leave `iterator` out.
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `class_filter`, `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `class_filter`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
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
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/item-non-inventories/list-item-non-inventories
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_non_inventory.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update item non inventory: PUT /connections/{connection_id}/item-non-inventories
      # (`item_non_inventory.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `bar_code` (Hash): Barcode reference information.
      #   - `allow_override` (Boolean): Allows for barcode to be overridden for an item.
      #   - `assign_even_if_used` (Boolean): Allow barcode to be assigned to item, even if already
      #     in use.
      #   - `bar_code_value` (String): Value of the barcode in the item.
      # - `class_ref` (Hash): Use classes to categorize transactions (for example, by department,
      #   location, or work type). Class tracking is off by default in QuickBooks. A `class_ref`
      #   points to one class; if both `full_name` and `list_id` are provided, `full_name` is
      #   ignored. In InvoiceAdd, a header-level `class_ref` is applied to line items unless you
      #   override or clear it on individual lines.
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
      # - `force_uom_change` (Boolean): By Default `force_uom_change` is false. However, in item Mod
      #   requests, you need to set the `force_uom_change` field to True if you are changing the UOM
      #   set and the base unit of the new set doesn’t match the base unit of the UOM set currently
      #   assigned to the item. This does the same thing as the user accepting the warning prompt in
      #   the UI.
      # - `include_ret_element` (Array<one of "BarCodeValue", "ClassRef", "DataExtRet",
      #   "EditSequence", "ExternalGUID", "FullName", "IsActive", "IsTaxIncluded", "ListID",
      #   "ManufacturerPartNumber", "Name", "OwnerID", "ParentRef", "SalesAndPurchase",
      #   "SalesOrPurchase", "SalesTaxCodeRef", "Sublevel", "TimeCreated", "TimeModified", "TxnID",
      #   "TxnNumber", "UnitOfMeasureSetRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      # - `manufacturer_part_number` (String): The part number used by the manufacturer of the item.
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because `full_name` remains distinct.
      # - `parent_ref` (Hash): A reference to the list object that is one level above this one. For
      #   example, an inventory item with the `full_name` of GermanCars:Mercedes-Benz:CL500I99AA
      #   might have a parent object with the `full_name` of GermanCars:Mercedes-Benz. In a request,
      #   if a `parent_ref` aggregate includes both `full_name` and `list_id`, `full_name` will be
      #   ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `sales_and_purchase_mod` (Hash): A `sales_and_purchase` aggregate is used for items that
      #   are meant to be both purchased and sold, such as an “other charge” item that is
      #   reimbursable. Choose at most one of: `sales_or_purchase_mod`, or `sales_and_purchase_mod`.
      #   - `apply_expense_account_ref_to_existing_txns` (Boolean): Used to support changing the
      #     `account_ref` in the Mod request. When you do this, the QuickBooks UI normally displays
      #     a prompt asking whether the change should apply to existing transactions or not.
      #     Specifying False basically dismisses this with a “No” answer; specifying True dismisses
      #     it with a “Yes” answer and then changes the existing transactions that use the item with
      #     that `account_ref`.
      #   - `apply_income_account_ref_to_existing_txns` (Boolean): Used to support changing the
      #     `account_ref` in the Mod request. When you do this, the QuickBooks UI normally displays
      #     a prompt asking whether the change should apply to existing transactions or not.
      #     Specifying False basically dismisses this with a “No” answer; specifying True dismisses
      #     it with a “Yes” answer and then changes the existing transactions that use the item with
      #     that `account_ref`.
      #   - `expense_account_ref` (Hash): Refers to an expense account. If an `expense_account_ref`
      #     aggregate includes both `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `income_account_ref` (Hash): Refers to an income account. If an `income_account_ref`
      #     aggregate includes both `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `pref_vendor_ref` (Hash): The preferred vendor for this item. If a `pref_vendor_ref`
      #     aggregate includes both `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `purchase_cost` (Numeric): Amount that the QuickBooks user expects to pay when ordering
      #     or buying this item, or the amount that was actually paid for this item.
      #   - `purchase_desc` (String): Description that appears in the Description column of checks,
      #     bills, credit card charges, and item receipts (when an item is reordered). For a fixed
      #     asset, a description of the item as it was when it was purchased.
      #   - `purchase_tax_code_ref` (Hash): Account used for taxes on purchases in CA or UK.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `sales_desc` (String): Appears in the Description column of a sales form when the
      #     QuickBooks user sells this item. For a fixed asset, describes the sale of the asset (for
      #     accounting purposes).
      #   - `sales_price` (Numeric): Price charged for this item.
      # - `sales_or_purchase_mod` (Hash): A `sales_or_purchase` aggregate is used for items that are
      #   meant to be either purchased or sold, but not both. For example, a `sales_or_purchase`
      #   aggregate would be used for a non-inventory item that is purchased but not sold, or for a
      #   service item that is sold but not purchased. Choose at most one of:
      #   `sales_or_purchase_mod`, or `sales_and_purchase_mod`.
      #   - `account_ref` (Hash): `account_ref` points to an account in the company file. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #     context: for checks it is the funding account; for ExpenseLineAdd it may be required by
      #     accounting preferences; for credit-card transactions it identifies the bank or card
      #     account involved.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `apply_account_ref_to_existing_txns` (Boolean): Used to support changing the
      #     `account_ref` in the Mod request. When you do this, the QuickBooks UI normally displays
      #     a prompt asking whether the change should apply to existing transactions or not.
      #     Specifying False basically dismisses this with a “No” answer; specifying True dismisses
      #     it with a “Yes” answer and then changes the existing transactions that use the item with
      #     that `account_ref`.
      #   - `desc` (String): A descriptive text field.
      #   - `price` (Numeric): The purchase price or sales price of this item. Choose at most one
      #     of: `price`, or `price_percent`.
      #   - `price_percent` (Numeric): The price expressed as a percent. (For example, an auto shop
      #     that calculates the cost of labor as a percentage of the cost of parts might have a
      #     service item called “Labor” that uses `price_percent` instead of Price.) Choose at most
      #     one of: `price`, or `price_percent`.
      # - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used for an
      #   item or customer context. QuickBooks includes default TAX and NON codes, and a code can be
      #   deleted only when nothing references it. If sales tax is disabled, QuickBooks assigns the
      #   default non-taxable code. If both `full_name` and `list_id` are provided in
      #   `sales_tax_code_ref`, `full_name` is ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `unit_of_measure_set_ref` (Hash): The unit of measure set consists of a base unit and 0-n
      #   related units.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/item-non-inventories/update-item-non-inventory
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("item_non_inventory.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
