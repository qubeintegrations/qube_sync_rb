# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks vendor operations, reached as `client.vendor`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Vendor < Base
      # Create vendor: POST /connections/{connection_id}/vendors (`vendor.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_number` (String): Account numbers appear in the QuickBooks chart of accounts,
      #   Account fields, and reports and graphs. If the IsUsingAccountNumber preference is false
      #   (that is, if the QuickBooks user has the account numbers Preference turned off), you can
      #   still set account numbers through the SDK, but the numbers won’t be visible in the user
      #   interface.
      # - `additional_contact_ref` (Array<Hash>)
      #   - `contact_name` (String, required): The name of the contact.
      #   - `contact_value` (String, required): The value of the contact field.
      # - `additional_notes` (Array<Hash>)
      #   - `note` (String, required): In a BillAddress or `ship_address` aggregate, the Note field
      #     value is written at the bottom of the address in the form in which it appears, such as
      #     the invoice form.
      # - `alt_contact` (String): The name of an alternate contact person for a vendor, customer, or
      #   “other name” entry.
      # - `alt_phone` (String): A telephone number given as an alternative to Phone.
      # - `billing_rate_ref` (Hash): Billing rates are used to override the service item rate in a
      #   time transaction (TimeTrackingAdd) based on the employee or vendor performing the work.
      #   Billing rates are assigned to an employee or a vendor to specify overrides to service
      #   items.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `cc` (String): Email address that would be carbon copied or CC.
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
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `company_name` (String): The name of the QuickBooks user’s business, as specified in
      #   QuickBooks. `company_name` and Address are used on invoices, checks, and other forms.
      #   (LegalCompanyName and LegalAddress, on the other hand, are used on a company’s tax forms
      #   and pay stubs.)
      # - `contact` (String): The name of a contact person for a customer or vendor.
      # - `contacts` (Array<Hash>)
      #   - `additional_contact_ref` (Array<Hash>)
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #   - `first_name` (String, required): The first name of a customer, vendor, employee, or
      #     person on the “other names” list.
      #   - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `middle_name` (String): The middle name of a customer, vendor, employee, or person on
      #     the “other names” list.
      #   - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `credit_limit` (Numeric): Set and returned as a positive number that indicates a
      #   customer’s or vendor’s credit limit. If no value has been defined, there is no credit
      #   limit.
      # - `currency_ref` (Hash): A currency record defines how QuickBooks stores and displays a
      #   currency. Built-in currency name/code values are fixed; formatting and active status can
      #   vary by settings and workflow.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `email` (String): E-mail address.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AltContact", "AltPhone", "Balance", "BillingRateRef", "Cc",
      #   "ClassRef", "CompanyName", "Contact", "ContactsRet", "CreditLimit", "CurrencyRef",
      #   "DataExtRet", "EditSequence", "Email", "ExternalGUID", "Fax", "FirstName", "IsActive",
      #   "IsSalesTaxAgency", "IsTaxAgency", "IsTaxOnTax", "IsTaxTrackedOnPurchases",
      #   "IsTaxTrackedOnSales", "IsVendorEligibleFor1099", "JobTitle", "LastName", "ListID",
      #   "MiddleName", "Mobile", "Name", "NameOnCheck", "Notes", "OwnerID", "Pager", "Phone",
      #   "PrefillAccountRef", "ReportingPeriod", "SalesTaxCodeRef", "SalesTaxCountry",
      #   "SalesTaxReturnRef", "Salutation", "ShipAddress", "Suffix", "TaxOnPurchasesAccountRef",
      #   "TaxOnSalesAccountRef", "TaxRegistrationNumber", "TermsRef", "TimeCreated",
      #   "TimeModified", "TxnID", "TxnNumber", "VendorAddress", "VendorAddressBlock",
      #   "VendorTaxIdent", "VendorTypeRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_sales_tax_agency` (Boolean): Indicates whether the entity is a sales tax agency.
      # - `is_tax_on_tax` (Boolean): For vendor in CA or UK, is there tax charged on top of tax.
      # - `is_tax_tracked_on_purchases` (Boolean): This flag is used for CA or UK and whether tax is
      #   tracked on purchases.
      # - `is_tax_tracked_on_sales` (Boolean): This flag is used for CA or UK and whether tax is
      #   tracked on sales.
      # - `is_vendor_eligible_for1099` (Boolean): If `is_vendor_eligible_for1099` is set to true,
      #   `vendor_tax_ident` and `vendor_address` are required in a vendor add request message.
      #   Otherwise, `vendor_tax_ident` and `vendor_address` are optional.
      # - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `middle_name` (String): The middle name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `mobile` (String)
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because `full_name` remains distinct.
      # - `name_on_check` (String): The vendor’s name as it will appear on checks sent to the
      #   vendor. (Corresponds in the QuickBooks user interface to the “Print on Check as” field of
      #   the Edit Vendor and New Vendor windows.)
      # - `notes` (String): Additional information about this vendor.
      # - `open_balance` (Numeric): The opening balance of this vendor’s account. A positive number
      #   indicates money owed to this vendor.
      # - `open_balance_date` (String): The date of the opening balance for this vendor.
      # - `pager` (String)
      # - `phone` (String): The telephone number.
      # - `prefill_account_ref` (Array<Hash>)
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `reporting_period` (one of "Monthly", "Quarterly"): Vendor reporting period for CA or UK.
      #   This can be monthly or quarterly.
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
      # - `sales_tax_country` (one of "Australia", "Canada", "UK", "US"): The country that sales tax
      #   is collected for.
      # - `sales_tax_return_ref` (Hash): Sales tax return information.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in ShipAddressBlock or BillAddressBlock.
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
      # - `suffix` (String)
      # - `tax_on_purchases_account_ref` (Hash): Account used for taxes on purchases in CA or UK.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `tax_on_sales_account_ref` (Hash): Account used for taxes on sales in CA or UK.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `tax_registration_number` (String): The tax registration number used in CA and UK.
      # - `terms_ref` (Hash): Refers to the payment terms associated with this entity. (This will be
      #   an item on the DateDrivenTerms or StandardTerms list.) If a `terms_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
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
      # - `vendor_tax_ident` (String): A character string that identifies a vendor.
      # - `vendor_type_ref` (Hash): Vendor types allow business owners to categorize vendors in ways
      #   that are meaningful for their businesses. For example, a vendor type might indicate which
      #   industry a vendor represents, or which part of the country a vendor is in. A
      #   `vendor_type_ref` aggregate refers to one of the types on the VendorType list.
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
      # @see https://docs.qubesync.com/api-reference/v2/vendors/create-vendor
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("vendor.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List vendors: GET /connections/{connection_id}/vendors (`vendor.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `currency_filter`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`, `total_balance_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `class_filter` (Hash): Filter according to class. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `class_filter`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`, `total_balance_filter`). Members of a set combine with each other, not
      #   with the other choices.
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
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`, `total_balance_filter`). Members of a set combine with each other, not
      #   with the other choices.
      #   Give at most one of: `list_id`, or `full_name`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `class_filter`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`, `total_balance_filter`). Members of a set combine with each other, not
      #   with the other choices.
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `currency_filter`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`, `total_balance_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AltContact", "AltPhone", "Balance", "BillingRateRef", "Cc",
      #   "ClassRef", "CompanyName", "Contact", "ContactsRet", "CreditLimit", "CurrencyRef",
      #   "DataExtRet", "EditSequence", "Email", "ExternalGUID", "Fax", "FirstName", "IsActive",
      #   "IsSalesTaxAgency", "IsTaxAgency", "IsTaxOnTax", "IsTaxTrackedOnPurchases",
      #   "IsTaxTrackedOnSales", "IsVendorEligibleFor1099", "JobTitle", "LastName", "ListID",
      #   "MiddleName", "Mobile", "Name", "NameOnCheck", "Notes", "Pager", "Phone",
      #   "PrefillAccountRef", "ReportingPeriod", "SalesTaxCodeRef", "SalesTaxCountry",
      #   "SalesTaxReturnRef", "Salutation", "ShipAddress", "Suffix", "TaxOnPurchasesAccountRef",
      #   "TaxOnSalesAccountRef", "TaxRegistrationNumber", "TermsRef", "TimeCreated",
      #   "TimeModified", "VendorAddress", "VendorAddressBlock", "VendorTaxIdent", "VendorTypeRef">)
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
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `class_filter`,
      #   `currency_filter`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`, `total_balance_filter`). Members of a set combine
      #   with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `class_filter`, `currency_filter`, `from_modified_date`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`, `total_balance_filter`). Members
      #   of a set combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`, `total_balance_filter`). Members of a set combine with each other, not
      #   with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`, `total_balance_filter`). Members of a set combine with each other, not
      #   with the other choices.
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
      #   `list_id`, or `full_name`, or the set (`active_status`, `class_filter`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`, `total_balance_filter`). Members of a set combine with each other, not
      #   with the other choices.
      # - `total_balance_filter` (Hash): Filters according to total balance. Total balance includes
      #   the balance for all subaccounts; for example, a customer’s TotalBalance would include all
      #   the jobs for that customer. Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `class_filter`, `currency_filter`, `from_modified_date`, `max_returned`,
      #   `name_filter`, `name_range_filter`, `to_modified_date`, `total_balance_filter`). Members
      #   of a set combine with each other, not with the other choices.
      #   - `amount` (Numeric, required): The monetary amount to which Operator refers.
      #   - `operator` (one of "Equal", "GreaterThan", "GreaterThanEqual", "LessThan",
      #     "LessThanEqual", required): Indicates whether to filter for amounts that are less than,
      #     equal to or less than, exactly equal to, greater than, or equal to or greater than the
      #     given Amount.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/vendors/list-vendors
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("vendor.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update vendor: PUT /connections/{connection_id}/vendors (`vendor.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_number` (String): Account numbers appear in the QuickBooks chart of accounts,
      #   Account fields, and reports and graphs. If the IsUsingAccountNumber preference is false
      #   (that is, if the QuickBooks user has the account numbers Preference turned off), you can
      #   still set account numbers through the SDK, but the numbers won’t be visible in the user
      #   interface.
      # - `additional_contact_ref` (Array<Hash>)
      #   - `contact_name` (String, required): The name of the contact.
      #   - `contact_value` (String, required): The value of the contact field.
      # - `additional_notes_mod` (Array<Hash>)
      #   - `note` (String, required): In a BillAddress or `ship_address` aggregate, the Note field
      #     value is written at the bottom of the address in the form in which it appears, such as
      #     the invoice form.
      #   - `note_id` (Integer, required): The ID of the note.
      # - `alt_contact` (String): The name of an alternate contact person for a vendor, customer, or
      #   “other name” entry.
      # - `alt_phone` (String): A telephone number given as an alternative to Phone.
      # - `billing_rate_ref` (Hash): Billing rates are used to override the service item rate in a
      #   time transaction (TimeTrackingAdd) based on the employee or vendor performing the work.
      #   Billing rates are assigned to an employee or a vendor to specify overrides to service
      #   items.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `cc` (String): Email address that would be carbon copied or CC.
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
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `company_name` (String): The name of the QuickBooks user’s business, as specified in
      #   QuickBooks. `company_name` and Address are used on invoices, checks, and other forms.
      #   (LegalCompanyName and LegalAddress, on the other hand, are used on a company’s tax forms
      #   and pay stubs.)
      # - `contact` (String): The name of a contact person for a customer or vendor.
      # - `contacts_mod` (Array<Hash>)
      #   - `additional_contact_ref` (Array<Hash>)
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #   - `edit_sequence` (String): `edit_sequence` is a server-generated revision token. It
      #     changes each time the object is updated. To modify an existing object, you must send the
      #     current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #     overwriting newer changes.
      #   - `first_name` (String, required): The first name of a customer, vendor, employee, or
      #     person on the “other names” list.
      #   - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `middle_name` (String): The middle name of a customer, vendor, employee, or person on
      #     the “other names” list.
      #   - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `credit_limit` (Numeric): Set and returned as a positive number that indicates a
      #   customer’s or vendor’s credit limit. If no value has been defined, there is no credit
      #   limit.
      # - `currency_ref` (Hash): A currency record defines how QuickBooks stores and displays a
      #   currency. Built-in currency name/code values are fixed; formatting and active status can
      #   vary by settings and workflow.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `email` (String): E-mail address.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AltContact", "AltPhone", "Balance", "BillingRateRef", "Cc",
      #   "ClassRef", "CompanyName", "Contact", "ContactsRet", "CreditLimit", "CurrencyRef",
      #   "DataExtRet", "EditSequence", "Email", "ExternalGUID", "Fax", "FirstName", "IsActive",
      #   "IsSalesTaxAgency", "IsTaxAgency", "IsTaxOnTax", "IsTaxTrackedOnPurchases",
      #   "IsTaxTrackedOnSales", "IsVendorEligibleFor1099", "JobTitle", "LastName", "ListID",
      #   "MiddleName", "Mobile", "Name", "NameOnCheck", "Notes", "OwnerID", "Pager", "Phone",
      #   "PrefillAccountRef", "ReportingPeriod", "SalesTaxCodeRef", "SalesTaxCountry",
      #   "SalesTaxReturnRef", "Salutation", "ShipAddress", "Suffix", "TaxOnPurchasesAccountRef",
      #   "TaxOnSalesAccountRef", "TaxRegistrationNumber", "TermsRef", "TimeCreated",
      #   "TimeModified", "TxnID", "TxnNumber", "VendorAddress", "VendorAddressBlock",
      #   "VendorTaxIdent", "VendorTypeRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_sales_tax_agency` (Boolean): Indicates whether the entity is a sales tax agency.
      # - `is_tax_on_tax` (Boolean): For vendor in CA or UK, is there tax charged on top of tax.
      # - `is_tax_tracked_on_purchases` (Boolean): This flag is used for CA or UK and whether tax is
      #   tracked on purchases.
      # - `is_tax_tracked_on_sales` (Boolean): This flag is used for CA or UK and whether tax is
      #   tracked on sales.
      # - `is_vendor_eligible_for1099` (Boolean): If `is_vendor_eligible_for1099` is set to true,
      #   `vendor_tax_ident` and `vendor_address` are required in a vendor add request message.
      #   Otherwise, `vendor_tax_ident` and `vendor_address` are optional.
      # - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `middle_name` (String): The middle name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `mobile` (String)
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because `full_name` remains distinct.
      # - `name_on_check` (String): The vendor’s name as it will appear on checks sent to the
      #   vendor. (Corresponds in the QuickBooks user interface to the “Print on Check as” field of
      #   the Edit Vendor and New Vendor windows.)
      # - `notes` (String): Additional information about this vendor.
      # - `pager` (String)
      # - `phone` (String): The telephone number.
      # - `prefill_account_ref` (Array<Hash>)
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `reporting_period` (one of "Monthly", "Quarterly"): Vendor reporting period for CA or UK.
      #   This can be monthly or quarterly.
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
      # - `sales_tax_country` (one of "Australia", "Canada", "UK", "US"): The country that sales tax
      #   is collected for.
      # - `sales_tax_return_ref` (Hash): Sales tax return information.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in ShipAddressBlock or BillAddressBlock.
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
      # - `suffix` (String)
      # - `tax_on_purchases_account_ref` (Hash): Account used for taxes on purchases in CA or UK.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `tax_on_sales_account_ref` (Hash): Account used for taxes on sales in CA or UK.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `tax_registration_number` (String): The tax registration number used in CA and UK.
      # - `terms_ref` (Hash): Refers to the payment terms associated with this entity. (This will be
      #   an item on the DateDrivenTerms or StandardTerms list.) If a `terms_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
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
      # - `vendor_tax_ident` (String): A character string that identifies a vendor.
      # - `vendor_type_ref` (Hash): Vendor types allow business owners to categorize vendors in ways
      #   that are meaningful for their businesses. For example, a vendor type might indicate which
      #   industry a vendor represents, or which part of the country a vendor is in. A
      #   `vendor_type_ref` aggregate refers to one of the types on the VendorType list.
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
      # @see https://docs.qubesync.com/api-reference/v2/vendors/update-vendor
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("vendor.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
