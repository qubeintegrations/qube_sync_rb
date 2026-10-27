# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks purchase order operations, reached as `client.purchase_order`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PurchaseOrder < Base
      # Create purchase order: POST /connections/{connection_id}/purchase-orders
      # (`purchase_order.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
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
      # - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #   or `txn_line_id` so later requests can reference it with `useMacro`. This feature requires
      #   SDK 2.0+.
      # - `due_date` (String): The date on which payment is due.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `expected_date` (String): The date on which shipment is expected.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `fob` (String): QuickBooks uses the term FOB, “freight on board,” to indicate the place
      #   from which the product is shipped. The FOB has no accounting implications.
      # - `include_ret_element` (Array<one of "ClassRef", "CurrencyRef", "DataExtRet", "DueDate",
      #   "EditSequence", "ExchangeRate", "ExpectedDate", "ExternalGUID", "FOB", "InventorySiteRef",
      #   "IsFullyReceived", "IsManuallyClosed", "IsTaxIncluded", "IsToBeEmailed", "IsToBePrinted",
      #   "LinkedTxn", "ListID", "Memo", "Other1", "Other2", "OwnerID", "PurchaseOrderLineGroupRet",
      #   "PurchaseOrderLineRet", "RefNumber", "SalesTaxCodeRef", "ShipAddress", "ShipAddressBlock",
      #   "ShipMethodRef", "ShipToEntityRef", "TemplateRef", "TermsRef", "TimeCreated",
      #   "TimeModified", "TotalAmount", "TotalAmountInHomeCurrency", "TxnDate", "TxnID",
      #   "TxnNumber", "VendorAddress", "VendorAddressBlock", "VendorMsg", "VendorRef">)
      # - `inventory_site_ref` (Hash): Site where inventory is located. Choose at most one of:
      #   `inventory_site_ref`, or `ship_to_entity_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `is_to_be_emailed` (Boolean): When enabled, QuickBooks validates the customer email at
      #   runtime before sending. If no valid email is available, the request fails.
      # - `is_to_be_printed` (Boolean): If `is_to_be_printed` is true, QuickBooks queues the form
      #   for later printing. It does not print immediately; printing is still a user action in
      #   QuickBooks.
      # - `memo` (String): This can be included in reports, but it doesn’t appear on the printed
      #   purchase order.
      # - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields. Other
      #   is transaction-level; Other1 and Other2 are line-level. These fields are always available
      #   through the SDK and do not require DataExtDef setup. Template labels in the UI can be
      #   renamed, but SDK names remain fixed as Other, Other1, and Other2.
      # - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields. Other
      #   is transaction-level; Other1 and Other2 are line-level. These fields are always available
      #   through the SDK and do not require DataExtDef setup. Template labels in the UI can be
      #   renamed, but SDK names remain fixed as Other, Other1, and Other2.
      # - `purchase_order_line_add` (Array<Hash>): One line of the purchase order. Compare with
      #   PurchaseOrderLineGroup, which represents a previously defined group of lines in the
      #   purchase order. At least one entry is required across `purchase_order_line_add` and
      #   `purchase_order_line_group_add`; they combine, any number of each. QuickBooks receives
      #   them in that order: every `purchase_order_line_add`, then every
      #   `purchase_order_line_group_add`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `class_ref` (Hash): Use classes to categorize transactions (for example, by department,
      #     location, or work type). Class tracking is off by default in QuickBooks. A `class_ref`
      #     points to one class; if both `full_name` and `list_id` are provided, `full_name` is
      #     ignored. In InvoiceAdd, a header-level `class_ref` is applied to line items unless you
      #     override or clear it on individual lines.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #     ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #     the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `data_ext` (Array<Hash>)
      #     - `data_ext_name` (String, required): The name of the data extension. If this is a
      #       custom field, `data_ext_name` will be visible as a label in the QuickBooks user
      #       interface. Also because `owner_id` and `data_ext_name` together make the data
      #       extension unique, and because custom fields all have the same `owner_id` of zero, the
      #       `data_ext_name` must be a unique value among existing custom fields.
      #     - `data_ext_value` (String, required): The data in this field. The maximum length of
      #       `data_ext_value` will depend on the `data_ext_type` of this data extension. For
      #       example, if `data_ext_type` is STR255TYPE, the maximum length of `data_ext_value` is
      #       255 characters. If `data_ext_type` is STR1024TYPE, the maximum size of
      #       `data_ext_value` is 1KB.
      #     - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use
      #       0 for QuickBooks custom fields that appear in the UI, or use a GUID for private
      #       extensions owned by an app. Keep private GUIDs confidential unless you intentionally
      #       share extensions across apps. If you do share them, both apps must use the same
      #       `owner_id` and `data_ext_name`, because that pair uniquely identifies the extension.
      #   - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #     or `txn_line_id` so later requests can reference it with `useMacro`. This feature
      #     requires SDK 2.0+.
      #   - `desc` (String): Description that appears on the purchase order for this line item.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
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
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `manufacturer_part_number` (String): The part number used by the manufacturer of the
      #     item.
      #   - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #     `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `rate` (Numeric): If you specify both Rate and Amount in a request, the Rate you provide
      #     will be ignored, and you will receive a warning. If you specify both Quantity and Amount
      #     in an Add or Mod request, QuickBooks will use them to calculate Rate. (Rate, Amount, and
      #     Quantity can’t be cleared.)
      #   - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used for
      #     an item or customer context. QuickBooks includes default TAX and NON codes, and a code
      #     can be deleted only when nothing references it. If sales tax is disabled, QuickBooks
      #     assigns the default non-taxable code. If both `full_name` and `list_id` are provided in
      #     `sales_tax_code_ref`, `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #     service for the customer.
      #   - `tax_amount` (Numeric)
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `purchase_order_line_group_add` (Array<Hash>): Represents a previously defined group of
      #   lines in the purchase order. Compare with PurchaseOrderLine, which represents just one
      #   line in the purchase order. At least one entry is required across
      #   `purchase_order_line_add` and `purchase_order_line_group_add`; they combine, any number of
      #   each. QuickBooks receives them in that order: every `purchase_order_line_add`, then every
      #   `purchase_order_line_group_add`.
      #   - `data_ext` (Array<Hash>)
      #     - `data_ext_name` (String, required): The name of the data extension. If this is a
      #       custom field, `data_ext_name` will be visible as a label in the QuickBooks user
      #       interface. Also because `owner_id` and `data_ext_name` together make the data
      #       extension unique, and because custom fields all have the same `owner_id` of zero, the
      #       `data_ext_name` must be a unique value among existing custom fields.
      #     - `data_ext_value` (String, required): The data in this field. The maximum length of
      #       `data_ext_value` will depend on the `data_ext_type` of this data extension. For
      #       example, if `data_ext_type` is STR255TYPE, the maximum length of `data_ext_value` is
      #       255 characters. If `data_ext_type` is STR1024TYPE, the maximum size of
      #       `data_ext_value` is 1KB.
      #     - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use
      #       0 for QuickBooks custom fields that appear in the UI, or use a GUID for private
      #       extensions owned by an app. Keep private GUIDs confidential unless you intentionally
      #       share extensions across apps. If you do share them, both apps must use the same
      #       `owner_id` and `data_ext_name`, because that pair uniquely identifies the extension.
      #   - `desc` (String): Description that appears on the purchase order for this line item.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `item_group_ref` (Hash, required): ItemGroup objects represent items that are grouped
      #     together for fast entry, and an `item_group_ref` aggregate refers to one of these item
      #     groups. In a request, if an `item_group_ref` aggregate includes both `full_name` and
      #     `list_id`, `full_name` will be ignored. You can use an ItemGroupQuery request to get
      #     information about all the item groups that are set up in the QuickBooks file.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #     service for the customer.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
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
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   BillAddressBlock.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a BillAddress or `ship_address` aggregate, the Note field value is
      #     written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `ship_method_ref` (Hash): A shipping method, for example, standard mail or overnight
      #   delivery. A `ship_method_ref` aggregate refers to an item on the ShipMethod list. In a
      #   request, if a `ship_method_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `ship_to_entity_ref` (Hash): Refers to a customer, vendor, employee, or person on the
      #   “other names” list to whom this order is to be shipped. If a `ship_to_entity_ref`
      #   aggregate includes both `full_name` and `list_id`, `full_name` will be ignored. Choose at
      #   most one of: `inventory_site_ref`, or `ship_to_entity_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `template_ref` (Hash): QuickBooks templates specify how to print certain transactions. A
      #   template query returns the names of all templates that have been defined in QuickBooks. A
      #   `template_ref` element refers to one of these templates.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `terms_ref` (Hash): Refers to the payment terms associated with this entity. (This will be
      #   an item on the DateDrivenTerms or StandardTerms list.) If a `terms_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      # - `vendor_address` (Hash): If an address request fails, some combination of address fields
      #   might be too long.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a BillAddress or `ship_address` aggregate, the Note field value is
      #     written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `vendor_msg` (String): Message to be printed on a purchase order for the vendor to read.
      # - `vendor_ref` (Hash): A vendor is any person or company from whom a small business owner
      #   buys goods and services. (Banks and tax agencies usually are included on the vendor list.)
      #   A company’s vendor list contains information such as account balance and contact
      #   information about each vendor. A `vendor_ref` aggregate refers to one of the vendors on
      #   the list.
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
      # @see https://docs.qubesync.com/api-reference/v2/purchase-orders/create-purchase-order
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("purchase_order.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List purchase orders: GET /connections/{connection_id}/purchase-orders
      # (`purchase_order.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `account_filter` (Hash): Filters according to the account name or `list_id`. If the “Use
      #   account numbers” preference is enabled in the QuickBooks company file, you can specify an
      #   account number (instead of an account name) for `full_name` and get the account you’re
      #   looking for. But if numbers have been used as account names, confusion could arise. Choose
      #   at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set
      #   (`account_filter`, `currency_filter`, `entity_filter`, `max_returned`,
      #   `modified_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
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
      # - `currency_filter` (Hash): Filters by the specified currency. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      # - `entity_filter` (Hash): An entity refers to a person on the QuickBooks Customer list,
      #   Vendor list, Employee list, or Other Names list. You can use an EntityQuery request to get
      #   information about all the entities that are set up in the QuickBooks file. In an
      #   ARRefundCreditCard query, this must be a customer/customer job. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
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
      # - `include_line_items` (Boolean): This filter allows you to omit line items from a query
      #   response to get a smaller result. The default value is false, so line items are omitted by
      #   default. Set `include_line_items` to true to include line items in the response if you
      #   don’t mind getting a larger result.
      # - `include_linked_txns` (Boolean): If you set `include_linked_txns` to true, then the
      #   returned object will include a list of all the transactions linked to the queried object.
      #   (This list is similar to the History view of a transaction in the user interface, but not
      #   identical, as the SDK list contains only linked transactions, not items.) Each linked
      #   transaction will be represented by a `linked_txn` aggregate.
      # - `include_ret_element` (Array<one of "ClassRef", "CurrencyRef", "DataExtRet", "DueDate",
      #   "EditSequence", "ExchangeRate", "ExpectedDate", "ExternalGUID", "FOB", "InventorySiteRef",
      #   "IsFullyReceived", "IsManuallyClosed", "IsTaxIncluded", "IsToBeEmailed", "IsToBePrinted",
      #   "LinkedTxn", "Memo", "Other1", "Other2", "PurchaseOrderLineGroupRet",
      #   "PurchaseOrderLineRet", "RefNumber", "SalesTaxCodeRef", "ShipAddress", "ShipAddressBlock",
      #   "ShipMethodRef", "ShipToEntityRef", "TemplateRef", "TermsRef", "TimeCreated",
      #   "TimeModified", "TotalAmount", "TotalAmountInHomeCurrency", "TxnDate", "TxnID",
      #   "TxnNumber", "VendorAddress", "VendorAddressBlock", "VendorMsg", "VendorRef">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records (25 with `include_line_items` or
      #   `include_linked_txns`); send `iterator=true` with `max_returned` for another size. Off
      #   when you send `iterator=false` (every match in one answer) or `max_returned` alone (at
      #   most that many, in one answer). It pages a filtered query only: with `ref_number`,
      #   `ref_number_case_sensitive` or `txn_id` every match comes back in one answer, so leave
      #   `iterator` out.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `modified_date_range_filter` (Hash): Filters according to the dates when transactions were
      #   last modified. The `modified_date_range_filter` aggregate isn’t required to contain any
      #   elements, but if it is empty, we recommend that you leave it out altogether. Note that the
      #   time portion of the `from_modified_date` and `to_modified_date` fields wasn’t supported in
      #   qbXML version 1.0 or 1.1. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      #   - `from_modified_date` (String): Filters results to objects modified on or after this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to 00:00:00.
      #   - `to_modified_date` (String): Filters results to objects modified on or before this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to end-of-day (23:59:59).
      # - `owner_id` (Array<String>): `owner_id` identifies who owns the data extension. Use 0 for
      #   QuickBooks custom fields that appear in the UI, or use a GUID for private extensions owned
      #   by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `ref_number` (Array<String>): `ref_number` is a user-managed transaction reference (for
      #   example, a check number). It can be edited and is not guaranteed to be globally unique.
      #   Some transaction types auto-populate `ref_number` when omitted, based on QuickBooks
      #   preferences and numbering state. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      # - `ref_number_case_sensitive` (Array<String>): Choose at most one of: `txn_id`, or
      #   `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      # - `ref_number_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `ref_number` (String, required): `ref_number` is a user-managed transaction reference
      #     (for example, a check number). It can be edited and is not guaranteed to be globally
      #     unique. Some transaction types auto-populate `ref_number` when omitted, based on
      #     QuickBooks preferences and numbering state.
      # - `ref_number_range_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_ref_number` (String): The first `ref_number` in the search range. If
      #     `from_ref_number` is omitted, the range will begin with first number on the list.
      #   - `to_ref_number` (String): The final `ref_number` in the search range. If `to_ref_number`
      #     is omitted, the range will end with last number on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_date_range_filter` (Hash): Filters according to the original transaction dates.
      #   Choose at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the
      #   set (`account_filter`, `currency_filter`, `entity_filter`, `max_returned`,
      #   `modified_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      #   Give at most one of: `from_txn_date` with `to_txn_date`, or `date_macro`.
      #   - `date_macro` (one of "All", "LastCalendarQuarter", "LastCalendarQuarterToDate",
      #     "LastCalendarYear", "LastCalendarYearToDate", "LastFiscalQuarter",
      #     "LastFiscalQuarterToDate", "LastFiscalYear", "LastFiscalYearToDate", "LastMonth",
      #     "LastMonthToDate", "LastWeek", "LastWeekToDate", "NextCalendarQuarter",
      #     "NextCalendarYear", "NextFiscalQuarter", "NextFiscalYear", "NextFourWeeks", "NextMonth",
      #     "NextWeek", "ThisCalendarQuarter", "ThisCalendarQuarterToDate", "ThisCalendarYear",
      #     "ThisCalendarYearToDate", "ThisFiscalQuarter", "ThisFiscalQuarterToDate",
      #     "ThisFiscalYear", "ThisFiscalYearToDate", "ThisMonth", "ThisMonthToDate", "ThisWeek",
      #     "ThisWeekToDate", "Today", "Yesterday"): `date_macro` filters by transaction date (not
      #     last-modified date). Do not combine `date_macro` with
      #     `from_modified_date`/`to_modified_date` in the same query filter set.
      #   - `from_txn_date` (String): Selects transactions created on or after this date. Both
      #     `from_txn_date` and `to_txn_date` must be between 01/01/1901 and 12/31/9999.If you omit
      #     `from_txn_date`, it will be set to 1970-01-01 (1969-12-31 PST).
      #   - `to_txn_date` (String): Selects transactions created on or before this date. Both
      #     `to_txn_date` and `from_txn_date` must be between 01/01/1901 and 12/31/9999. If you omit
      #     `to_txn_date`, it will be set to 2038-01-19 (2038-01-18 PST).
      # - `txn_id` (Array<String>): `txn_id` is the unique QuickBooks identifier for a transaction.
      #   Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types. Choose
      #   at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set
      #   (`account_filter`, `currency_filter`, `entity_filter`, `max_returned`,
      #   `modified_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/purchase-orders/list-purchase-orders
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("purchase_order.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update purchase order: PUT /connections/{connection_id}/purchase-orders
      # (`purchase_order.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
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
      # - `due_date` (String): The date on which payment is due.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `expected_date` (String): The date on which shipment is expected.
      # - `fob` (String): QuickBooks uses the term FOB, “freight on board,” to indicate the place
      #   from which the product is shipped. The FOB has no accounting implications.
      # - `include_ret_element` (Array<one of "ClassRef", "CurrencyRef", "DataExtRet", "DueDate",
      #   "EditSequence", "ExchangeRate", "ExpectedDate", "ExternalGUID", "FOB", "InventorySiteRef",
      #   "IsFullyReceived", "IsManuallyClosed", "IsTaxIncluded", "IsToBeEmailed", "IsToBePrinted",
      #   "LinkedTxn", "ListID", "Memo", "Other1", "Other2", "OwnerID", "PurchaseOrderLineGroupRet",
      #   "PurchaseOrderLineRet", "RefNumber", "SalesTaxCodeRef", "ShipAddress", "ShipAddressBlock",
      #   "ShipMethodRef", "ShipToEntityRef", "TemplateRef", "TermsRef", "TimeCreated",
      #   "TimeModified", "TotalAmount", "TotalAmountInHomeCurrency", "TxnDate", "TxnID",
      #   "TxnNumber", "VendorAddress", "VendorAddressBlock", "VendorMsg", "VendorRef">)
      # - `inventory_site_ref` (Hash): Site where inventory is located. Choose at most one of:
      #   `inventory_site_ref`, or `ship_to_entity_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `is_manually_closed` (Boolean): If `is_manually_closed` is true, this purchase order has
      #   been closed, even if all the items haven’t been received or the sale hasn’t been
      #   cancelled. Once the purchase order is marked as closed, all the line items within it
      #   become closed as well. You can’t change `is_manually_closed` to false after the purchase
      #   order has been fully received.
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `is_to_be_emailed` (Boolean): When enabled, QuickBooks validates the customer email at
      #   runtime before sending. If no valid email is available, the request fails.
      # - `is_to_be_printed` (Boolean): If `is_to_be_printed` is true, QuickBooks queues the form
      #   for later printing. It does not print immediately; printing is still a user action in
      #   QuickBooks.
      # - `memo` (String): This can be included in reports, but it doesn’t appear on the printed
      #   purchase order.
      # - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields. Other
      #   is transaction-level; Other1 and Other2 are line-level. These fields are always available
      #   through the SDK and do not require DataExtDef setup. Template labels in the UI can be
      #   renamed, but SDK names remain fixed as Other, Other1, and Other2.
      # - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields. Other
      #   is transaction-level; Other1 and Other2 are line-level. These fields are always available
      #   through the SDK and do not require DataExtDef setup. Template labels in the UI can be
      #   renamed, but SDK names remain fixed as Other, Other1, and Other2.
      # - `purchase_order_line_group_mod` (Array<Hash>): Represents a previously defined group of
      #   lines in the purchase order. Compare with PurchaseOrderLine, which represents just one
      #   line in the purchase order. `purchase_order_line_mod` and `purchase_order_line_group_mod`
      #   combine: any number of each. QuickBooks receives them in that order: every
      #   `purchase_order_line_mod`, then every `purchase_order_line_group_mod`.
      #   - `item_group_ref` (Hash): ItemGroup objects represent items that are grouped together for
      #     fast entry, and an `item_group_ref` aggregate refers to one of these item groups. In a
      #     request, if an `item_group_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored. You can use an ItemGroupQuery request to get information
      #     about all the item groups that are set up in the QuickBooks file.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `override_uom_set_ref` (Hash): When you modify a transaction line to change the unit of
      #     measure used in that line, you use this aggregate to specify the UOM set within which
      #     you are choosing an available unit of measure. The “override” here refers to the unit
      #     within the set, not the UOM Set itself, which you can’t change or override–the UOM set
      #     that can be set or changed only in the item itself via an Item Mod request.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `purchase_order_line_mod` (Array<Hash>): One line of the purchase order. Compare with
      #     PurchaseOrderLineGroup, which represents a previously defined group of lines in the
      #     purchase order.
      #     - `amount` (Numeric): A monetary amount.
      #     - `class_ref` (Hash): Use classes to categorize transactions (for example, by
      #       department, location, or work type). Class tracking is off by default in QuickBooks. A
      #       `class_ref` points to one class; if both `full_name` and `list_id` are provided,
      #       `full_name` is ignored. In InvoiceAdd, a header-level `class_ref` is applied to line
      #       items unless you override or clear it on individual lines.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #       `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #       ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #       the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `desc` (String): Description that appears on the purchase order for this line item.
      #     - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `is_manually_closed` (Boolean): If `is_manually_closed` is true, this purchase order
      #       has been closed, even if all the items haven’t been received or the sale hasn’t been
      #       cancelled. Once the purchase order is marked as closed, all the line items within it
      #       become closed as well. You can’t change `is_manually_closed` to false after the
      #       purchase order has been fully received.
      #     - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #       depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #       sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #       BillingRateAdd requires a service item. If both `full_name` and `list_id` are
      #       provided, `full_name` is ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `manufacturer_part_number` (String): The part number used by the manufacturer of the
      #       item.
      #     - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #       Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #       available through the SDK and do not require DataExtDef setup. Template labels in the
      #       UI can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #     - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #       Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #       available through the SDK and do not require DataExtDef setup. Template labels in the
      #       UI can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #     - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #       `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #       `full_name` will be ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `override_uom_set_ref` (Hash): When you modify a transaction line to change the unit
      #       of measure used in that line, you use this aggregate to specify the UOM set within
      #       which you are choosing an available unit of measure. The “override” here refers to the
      #       unit within the set, not the UOM Set itself, which you can’t change or override–the
      #       UOM set that can be set or changed only in the item itself via an Item Mod request.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #       other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #       QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #       Amount.
      #     - `rate` (Numeric): If you specify both Rate and Amount in a request, the Rate you
      #       provide will be ignored, and you will receive a warning. If you specify both Quantity
      #       and Amount in an Add or Mod request, QuickBooks will use them to calculate Rate.
      #       (Rate, Amount, and Quantity can’t be cleared.)
      #     - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used
      #       for an item or customer context. QuickBooks includes default TAX and NON codes, and a
      #       code can be deleted only when nothing references it. If sales tax is disabled,
      #       QuickBooks assigns the default non-taxable code. If both `full_name` and `list_id` are
      #       provided in `sales_tax_code_ref`, `full_name` is ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #       service for the customer.
      #     - `tax_amount` (Numeric)
      #     - `txn_line_id` (String, required): Identification number of the transaction line.
      #       (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #       `txn_line_id` is always returned as zero.) If you need to add a new transaction line
      #       in a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #     - `unit_of_measure` (String): In a transaction line item, the name of the unit of
      #       measure selected from within the item’s available units. If the company file is
      #       enabled only for single unit of measure per item, this must be the base unit!
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `purchase_order_line_mod` (Array<Hash>): One line of the purchase order. Compare with
      #   PurchaseOrderLineGroup, which represents a previously defined group of lines in the
      #   purchase order. `purchase_order_line_mod` and `purchase_order_line_group_mod` combine: any
      #   number of each. QuickBooks receives them in that order: every `purchase_order_line_mod`,
      #   then every `purchase_order_line_group_mod`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `class_ref` (Hash): Use classes to categorize transactions (for example, by department,
      #     location, or work type). Class tracking is off by default in QuickBooks. A `class_ref`
      #     points to one class; if both `full_name` and `list_id` are provided, `full_name` is
      #     ignored. In InvoiceAdd, a header-level `class_ref` is applied to line items unless you
      #     override or clear it on individual lines.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #     ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #     the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `desc` (String): Description that appears on the purchase order for this line item.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `is_manually_closed` (Boolean): If `is_manually_closed` is true, this purchase order has
      #     been closed, even if all the items haven’t been received or the sale hasn’t been
      #     cancelled. Once the purchase order is marked as closed, all the line items within it
      #     become closed as well. You can’t change `is_manually_closed` to false after the purchase
      #     order has been fully received.
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
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `manufacturer_part_number` (String): The part number used by the manufacturer of the
      #     item.
      #   - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #     `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `override_uom_set_ref` (Hash): When you modify a transaction line to change the unit of
      #     measure used in that line, you use this aggregate to specify the UOM set within which
      #     you are choosing an available unit of measure. The “override” here refers to the unit
      #     within the set, not the UOM Set itself, which you can’t change or override–the UOM set
      #     that can be set or changed only in the item itself via an Item Mod request.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `rate` (Numeric): If you specify both Rate and Amount in a request, the Rate you provide
      #     will be ignored, and you will receive a warning. If you specify both Quantity and Amount
      #     in an Add or Mod request, QuickBooks will use them to calculate Rate. (Rate, Amount, and
      #     Quantity can’t be cleared.)
      #   - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used for
      #     an item or customer context. QuickBooks includes default TAX and NON codes, and a code
      #     can be deleted only when nothing references it. If sales tax is disabled, QuickBooks
      #     assigns the default non-taxable code. If both `full_name` and `list_id` are provided in
      #     `sales_tax_code_ref`, `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #     service for the customer.
      #   - `tax_amount` (Numeric)
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
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
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   BillAddressBlock.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a BillAddress or `ship_address` aggregate, the Note field value is
      #     written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `ship_method_ref` (Hash): A shipping method, for example, standard mail or overnight
      #   delivery. A `ship_method_ref` aggregate refers to an item on the ShipMethod list. In a
      #   request, if a `ship_method_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `ship_to_entity_ref` (Hash): Refers to a customer, vendor, employee, or person on the
      #   “other names” list to whom this order is to be shipped. If a `ship_to_entity_ref`
      #   aggregate includes both `full_name` and `list_id`, `full_name` will be ignored. Choose at
      #   most one of: `inventory_site_ref`, or `ship_to_entity_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `template_ref` (Hash): QuickBooks templates specify how to print certain transactions. A
      #   template query returns the names of all templates that have been defined in QuickBooks. A
      #   `template_ref` element refers to one of these templates.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `terms_ref` (Hash): Refers to the payment terms associated with this entity. (This will be
      #   an item on the DateDrivenTerms or StandardTerms list.) If a `terms_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      # - `vendor_address` (Hash): If an address request fails, some combination of address fields
      #   might be too long.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a BillAddress or `ship_address` aggregate, the Note field value is
      #     written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `vendor_msg` (String): Message to be printed on a purchase order for the vendor to read.
      # - `vendor_ref` (Hash): A vendor is any person or company from whom a small business owner
      #   buys goods and services. (Banks and tax agencies usually are included on the vendor list.)
      #   A company’s vendor list contains information such as account balance and contact
      #   information about each vendor. A `vendor_ref` aggregate refers to one of the vendors on
      #   the list.
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
      # @see https://docs.qubesync.com/api-reference/v2/purchase-orders/update-purchase-order
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("purchase_order.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
