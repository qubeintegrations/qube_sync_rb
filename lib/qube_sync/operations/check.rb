# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks check operations, reached as `client.check`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Check < Base
      # Create check: POST /connections/{connection_id}/checks (`check.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_ref` (Hash, required): `account_ref` points to an account in the company file. If
      #   both `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #   context: for checks it is the funding account; for `expense_line_add` it may be required
      #   by accounting preferences; for credit-card transactions it identifies the bank or card
      #   account involved.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `address` (Hash): If an address request fails, some combination of address fields might be
      #   too long. In a Check, BillPaymentCheck, or SalesTaxPaymentCheck message, Address is the
      #   address that will print on the check.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a BillAddress or ShipAddress aggregate, the Note field value is
      #     written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `apply_check_to_txn_add` (Array<Hash>)
      #   - `amount` (Numeric): A monetary amount.
      #   - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #     transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #     transaction-specific and should not be reused across unrelated transaction types.
      # - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #   or `txn_line_id` so later requests can reference it with `useMacro`. This feature requires
      #   SDK 2.0+.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `expense_line_add` (Array<Hash>)
      #   - `account_ref` (Hash): `account_ref` points to an account in the company file. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #     context: for checks it is the funding account; for `expense_line_add` it may be required
      #     by accounting preferences; for credit-card transactions it identifies the bank or card
      #     account involved.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `billable_status` (one of "Billable", "HasBeenBilled", "NotBillable"): The billing
      #     status of this item line or expense line.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #     ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #     the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #   - `memo` (String): The memo that is printed on the check itself.
      #   - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #     Names list within QuickBooks. Sales representative’s names and initials appear on the
      #     Rep drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on
      #     the SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both
      #     `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `tax_amount` (Numeric)
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `include_ret_element` (Array<one of "AccountRef", "Address", "AddressBlock", "Amount",
      #   "AmountInHomeCurrency", "CurrencyRef", "DataExtRet", "EditSequence", "ExchangeRate",
      #   "ExpenseLineRet", "ExternalGUID", "IsPending", "IsTaxIncluded", "IsToBePrinted",
      #   "ItemGroupLineRet", "ItemLineRet", "LinkedTxn", "ListID", "Memo", "OwnerID",
      #   "PayeeEntityRef", "RefNumber", "SalesTaxCodeRef", "TimeCreated", "TimeModified",
      #   "TxnDate", "TxnID", "TxnNumber">)
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `is_to_be_printed` (Boolean): If `is_to_be_printed` is true, QuickBooks queues the form
      #   for later printing. It does not print immediately; printing is still a user action in
      #   QuickBooks.
      # - `item_group_line_add` (Array<Hash>): Refers to items that are grouped together in
      #   QuickBooks for fast entry. `item_line_add` and `item_group_line_add` combine: any number
      #   of each. QuickBooks receives them in that order: every `item_line_add`, then every
      #   `item_group_line_add`.
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
      #   - `desc` (String): A descriptive text field.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `inventory_site_ref` (Hash): Site where inventory is located.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `item_line_add` (Array<Hash>): An ItemLine is used to track any portion of a transaction
      #   that represents the purchase of an “item.” If `item_line_add` doesn’t specify an Amount,
      #   Cost, or Quantity, then QuickBooks will calculate Amount based on a Quantity of 1 and the
      #   suggested Cost. `item_line_add` and `item_group_line_add` combine: any number of each.
      #   QuickBooks receives them in that order: every `item_line_add`, then every
      #   `item_group_line_add`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `billable_status` (one of "Billable", "HasBeenBilled", "NotBillable"): The billing
      #     status of this item line or expense line.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `cost` (Numeric): If both Quantity and Amount are specified, QuickBooks will use them to
      #     calculate Cost. Likewise, if both Quantity and Cost are specified, QuickBooks will use
      #     them to calculate the total Amount.
      #   - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #     ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #     the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #   - `desc` (String): A descriptive text field.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `inventory_site_ref` (Hash): Site where inventory is located.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #   - `link_to_txn` (Hash)
      #     - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #       transaction. Use it to reference that transaction in later requests. `txn_id` values
      #       are transaction-specific and should not be reused across unrelated transaction types.
      #     - `txn_line_id` (String, required): Identification number of the transaction line.
      #       (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #       `txn_line_id` is always returned as zero.) If you need to add a new transaction line
      #       in a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #   - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #     `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored.
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
      #   - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #     Names list within QuickBooks. Sales representative’s names and initials appear on the
      #     Rep drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on
      #     the SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both
      #     `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `tax_amount` (Numeric)
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `memo` (String): The memo that is printed on the check itself.
      # - `payee_entity_ref` (Hash): `payee_entity_ref` identifies the payee (customer, vendor,
      #   employee, or Other Name). If both `full_name` and `list_id` are provided, `full_name` is
      #   ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `txn_date` (String): The date written on the check. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/checks/create-check
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("check.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List checks: GET /connections/{connection_id}/checks (`check.query`).
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
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      # - `include_ret_element` (Array<one of "AccountRef", "Address", "AddressBlock", "Amount",
      #   "AmountInHomeCurrency", "CurrencyRef", "DataExtRet", "EditSequence", "ExchangeRate",
      #   "ExpenseLineRet", "ExternalGUID", "IsPending", "IsTaxIncluded", "IsToBePrinted",
      #   "ItemGroupLineRet", "ItemLineRet", "LinkedTxn", "Memo", "PayeeEntityRef", "RefNumber",
      #   "SalesTaxCodeRef", "TimeCreated", "TimeModified", "TxnDate", "TxnID", "TxnNumber">)
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
      # @see https://docs.qubesync.com/api-reference/v2/checks/list-checks
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("check.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update check: PUT /connections/{connection_id}/checks (`check.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_ref` (Hash): `account_ref` points to an account in the company file. If both
      #   `full_name` and `list_id` are provided, `full_name` is ignored. Meaning depends on
      #   context: for checks it is the funding account; for ExpenseLineAdd it may be required by
      #   accounting preferences; for credit-card transactions it identifies the bank or card
      #   account involved.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `address` (Hash): If an address request fails, some combination of address fields might be
      #   too long. In a Check, BillPaymentCheck, or SalesTaxPaymentCheck message, Address is the
      #   address that will print on the check.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a BillAddress or ShipAddress aggregate, the Note field value is
      #     written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `apply_check_to_txn_mod` (Array<Hash>)
      #   - `amount` (Numeric): A monetary amount.
      #   - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #     transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #     transaction-specific and should not be reused across unrelated transaction types.
      # - `clear_expense_lines` (Boolean): Set `clear_expense_lines` to true to clear all the
      #   expense lines. To modify individual lines, use `expense_line_mod`.
      # - `clear_item_lines` (Boolean): Set `clear_item_lines` to true to clear all the item lines.
      #   To modify individual lines, use `item_line_mod`.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `expense_line_mod` (Array<Hash>)
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `billable_status` (one of "Billable", "HasBeenBilled", "NotBillable"): The billing
      #     status of this item line or expense line.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #     ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #     the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `memo` (String): The memo that is printed on the check itself.
      #   - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #     Names list within QuickBooks. Sales representative’s names and initials appear on the
      #     Rep drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on
      #     the SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both
      #     `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `tax_amount` (Numeric)
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      # - `include_ret_element` (Array<one of "AccountRef", "Address", "AddressBlock", "Amount",
      #   "AmountInHomeCurrency", "CurrencyRef", "DataExtRet", "EditSequence", "ExchangeRate",
      #   "ExpenseLineRet", "ExternalGUID", "IsPending", "IsTaxIncluded", "IsToBePrinted",
      #   "ItemGroupLineRet", "ItemLineRet", "LinkedTxn", "ListID", "Memo", "OwnerID",
      #   "PayeeEntityRef", "RefNumber", "SalesTaxCodeRef", "TimeCreated", "TimeModified",
      #   "TxnDate", "TxnID", "TxnNumber">)
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `is_to_be_printed` (Boolean): If `is_to_be_printed` is true, QuickBooks queues the form
      #   for later printing. It does not print immediately; printing is still a user action in
      #   QuickBooks.
      # - `item_group_line_mod` (Array<Hash>): Refers to items that are grouped together in
      #   QuickBooks for fast entry. `item_line_mod` and `item_group_line_mod` combine: any number
      #   of each. QuickBooks receives them in that order: every `item_line_mod`, then every
      #   `item_group_line_mod`.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `item_line_mod` (Array<Hash>): An ItemLine is used to track any portion of a transaction
      #     that represents the purchase of an “item.” If ItemLineAdd doesn’t specify an Amount,
      #     Cost, or Quantity, then QuickBooks will calculate Amount based on a Quantity of 1 and
      #     the suggested Cost.
      #     - `amount` (Numeric): A monetary amount.
      #     - `billable_status` (one of "Billable", "HasBeenBilled", "NotBillable"): The billing
      #       status of this item line or expense line.
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
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `cost` (Numeric): If both Quantity and Amount are specified, QuickBooks will use them
      #       to calculate Cost. Likewise, if both Quantity and Cost are specified, QuickBooks will
      #       use them to calculate the total Amount.
      #     - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #       `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #       ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #       the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `desc` (String): A descriptive text field.
      #     - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `inventory_site_ref` (Hash): Site where inventory is located.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #       `serial_number`, or `lot_number`.
      #     - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #       `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #       `full_name` will be ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #       other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #       QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #       Amount.
      #     - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or
      #       Other Names list within QuickBooks. Sales representative’s names and initials appear
      #       on the Rep drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a
      #       person on the SalesRep list. In a request, if a `sales_rep_ref` aggregate includes
      #       both `full_name` and `list_id`, `full_name` will be ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #       `serial_number`, or `lot_number`.
      #     - `tax_amount` (Numeric)
      #     - `txn_line_id` (String, required): Identification number of the transaction line.
      #       (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #       `txn_line_id` is always returned as zero.) If you need to add a new transaction line
      #       in a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #     - `unit_of_measure` (String): In a transaction line item, the name of the unit of
      #       measure selected from within the item’s available units. If the company file is
      #       enabled only for single unit of measure per item, this must be the base unit!
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      # - `item_line_mod` (Array<Hash>): An ItemLine is used to track any portion of a transaction
      #   that represents the purchase of an “item.” If ItemLineAdd doesn’t specify an Amount, Cost,
      #   or Quantity, then QuickBooks will calculate Amount based on a Quantity of 1 and the
      #   suggested Cost. `item_line_mod` and `item_group_line_mod` combine: any number of each.
      #   QuickBooks receives them in that order: every `item_line_mod`, then every
      #   `item_group_line_mod`.
      #   - `amount` (Numeric): A monetary amount.
      #   - `billable_status` (one of "Billable", "HasBeenBilled", "NotBillable"): The billing
      #     status of this item line or expense line.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `cost` (Numeric): If both Quantity and Amount are specified, QuickBooks will use them to
      #     calculate Cost. Likewise, if both Quantity and Cost are specified, QuickBooks will use
      #     them to calculate the total Amount.
      #   - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #     `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #     ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who
      #     the time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `desc` (String): A descriptive text field.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `inventory_site_ref` (Hash): Site where inventory is located.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #   - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #     `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #     Names list within QuickBooks. Sales representative’s names and initials appear on the
      #     Rep drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on
      #     the SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both
      #     `full_name` and `list_id`, `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #       list type, not globally across all lists. If both `full_name` and `list_id` are
      #       supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `tax_amount` (Numeric)
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `memo` (String): The memo that is printed on the check itself.
      # - `payee_entity_ref` (Hash): `payee_entity_ref` identifies the payee (customer, vendor,
      #   employee, or Other Name). If both `full_name` and `list_id` are provided, `full_name` is
      #   ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
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
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `txn_date` (String): The date written on the check. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/checks/update-check
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("check.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
