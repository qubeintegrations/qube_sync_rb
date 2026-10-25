# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks customer operations, reached as `client.customer`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Customer < Base
      # Create customer: POST /connections/{connection_id}/customers (`customer.create`).
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
      #   - `note` (String, required): In a `bill_address` or `ship_address` aggregate, the Note
      #     field value is written at the bottom of the address in the form in which it appears,
      #     such as the invoice form.
      # - `alt_contact` (String): The name of an alternate contact person for a vendor, customer, or
      #   “other name” entry.
      # - `alt_phone` (String): A telephone number given as an alternative to Phone.
      # - `bill_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
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
      # - `credit_card_info` (Hash): Customer’s credit-card information.
      #   - `credit_card_address` (String): The address associated with this credit card.
      #   - `credit_card_number` (String): Credit-card number for this customer or this payment.
      #     Beginning with qbXML spec 6.0 and QuickBooks 2007, you must mask the credit card number
      #     with lower case “x” and no dashes. For example, xxxxxxxxxxxx1234.
      #   - `credit_card_postal_code` (String): The postal code associated with the address for this
      #     credit card.
      #   - `expiration_month` (Integer): The month when the credit card expires.
      #   - `expiration_year` (Integer): The year when the credit card expires.
      #   - `name_on_card` (String): The name on the customer’s credit card.
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
      # - `customer_type_ref` (Hash): Customer types allow business owners to categorize customers
      #   in ways that are meaningful for their businesses. For example, a customer type might
      #   indicate which industry a customer represents, or which part of the country a customer is
      #   in. A `customer_type_ref` aggregate refers to one of the types on the CustomerType list.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `delivery_method` (one of "Email", "Fax", "Print")
      # - `email` (String): E-mail address.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AltContact", "AltPhone", "Balance", "BillAddress",
      #   "BillAddressBlock", "Cc", "ClassRef", "CompanyName", "Contact", "ContactsRet",
      #   "CreditCardInfo", "CreditLimit", "CurrencyRef", "CustomerTypeRef", "DataExtRet",
      #   "DeliveryMethod", "EditSequence", "Email", "ExternalGUID", "Fax", "FirstName", "FullName",
      #   "IsActive", "IsStatementWithParent", "ItemSalesTaxRef", "JobDesc", "JobEndDate",
      #   "JobProjectedEndDate", "JobStartDate", "JobStatus", "JobTitle", "JobTypeRef", "LastName",
      #   "ListID", "MiddleName", "Mobile", "Name", "Notes", "OwnerID", "Pager", "ParentRef",
      #   "Phone", "PreferredDeliveryMethod", "PreferredPaymentMethodRef", "PriceLevelRef",
      #   "PrintAs", "ResaleNumber", "SalesRepRef", "SalesTaxCodeRef", "SalesTaxCountry",
      #   "Salutation", "ShipAddress", "ShipAddressBlock", "ShipToAddress", "Sublevel", "Suffix",
      #   "TaxRegistrationNumber", "TermsRef", "TimeCreated", "TimeModified", "TotalBalance",
      #   "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_statement_with_parent` (Boolean)
      # - `item_sales_tax_ref` (Hash): An ItemSalesTax entry represents one tax rate paid to one tax
      #   agency. Use it when a transaction needs a single tax calculation. For multi-rate
      #   scenarios, use a sales-tax group instead. If both `full_name` and `list_id` are provided
      #   for `item_sales_tax_ref`, `list_id` is used.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `job_desc` (String): A short job description for a sub-customer; used in reports. The Job-
      #   elements (`job_desc`, `job_end_date`, `job_projected_end_date`, `job_start_date`, and
      #   `job_status`) correspond to the fields in the Job Info tab of the Edit Job window in
      #   QuickBooks.
      # - `job_end_date` (String): The date on which work for a sub-customer was completed; used in
      #   reports. The Job- elements (`job_desc`, `job_end_date`, `job_projected_end_date`,
      #   `job_start_date`, and `job_status`) correspond to the fields in the Job Info tab of the
      #   Edit Job window in QuickBooks.
      # - `job_projected_end_date` (String): The date on which work for a sub-customer is expected
      #   to be complete; used in reports. The Job- elements (`job_desc`, `job_end_date`,
      #   `job_projected_end_date`, `job_start_date`, and `job_status`) correspond to the fields in
      #   the Job Info tab of the Edit Job window in QuickBooks.
      # - `job_start_date` (String): The date on which work for a sub-customer was started; used in
      #   reports. The Job- elements (`job_desc`, `job_end_date`, `job_projected_end_date`,
      #   `job_start_date`, and `job_status`) correspond to the fields in the Job Info tab of the
      #   Edit Job window in QuickBooks.
      # - `job_status` (one of "Awarded", "Closed", "InProgress", "None", "NotAwarded", "Pending"):
      #   `job_status` Status information about a sub-customer; used in reports. The Job- elements
      #   (`job_desc`, `job_end_date`, `job_projected_end_date`, `job_start_date`, and `job_status`)
      #   correspond to the fields in the Job Info tab of the Edit Job window in QuickBooks.
      # - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `job_type_ref` (Hash): Job type can be used to separate jobs into any categories that are
      #   meaningful to the business. A `job_type_ref` aggregate refers to a job type on the JobType
      #   list. In a request, if a `job_type_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `middle_name` (String): The middle name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `mobile` (String)
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because `full_name` remains distinct.
      # - `notes` (String): Not supported.
      # - `open_balance` (Numeric): The opening balance of this customer’s account. A positive
      #   number indicates money owed by the customer.
      # - `open_balance_date` (String): The date of the opening balance for this customer.
      # - `pager` (String)
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
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `phone` (String): The telephone number.
      # - `preferred_delivery_method` (one of "Email", "Fax", "None"): Preference for how invoices
      #   are delivered.
      # - `preferred_payment_method_ref` (Hash): Refers to a PaymentMethod object. In a request, if
      #   a `preferred_payment_method_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `price_level_ref` (Hash): Price levels let you apply custom pricing rules for selected
      #   customers. Once assigned, QuickBooks uses those prices automatically on supported sales
      #   forms unless explicitly overridden.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `print_as` (String)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `resale_number` (String): The customer’s resale number, if they have one. This number
      #   won’t affect reports or sales tax calculations.
      # - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #   Names list within QuickBooks. Sales representative’s names and initials appear on the Rep
      #   drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on the
      #   SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both `full_name` and
      #   `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
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
      # - `sales_tax_country` (one of "Australia", "Canada", "UK", "US"): Country that sales tax is
      #   collected for.
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `ship_to_address` (Array<Hash>)
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `default_ship_to` (Boolean): Flag that address is the default ship to address.
      #   - `name` (String, required): Name is the case-insensitive short name of a list object
      #     (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists
      #     can reuse the same Name in different branches because `full_name` remains distinct.
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `suffix` (String)
      # - `tax_registration_number` (String): Tax registration number used in CA and UK.
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
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/customers/create-customer
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("customer.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List customers: GET /connections/{connection_id}/customers (`customer.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_contains`, `name_ends_with`, `name_range`, `name_starts_with`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`active_status`, `from_modified_date`, `max_returned`,
      #   `name_contains`, `name_ends_with`, `name_range`, `name_starts_with`, `to_modified_date`).
      #   Members of a set combine with each other, not with the other choices.
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_contains`, `name_ends_with`, `name_range`, `name_starts_with`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `include` (Array<one of "AccountNumber", "AdditionalContactRef", "AdditionalNotesRet",
      #   "AltContact", "AltPhone", "Balance", "BillAddress", "BillAddressBlock", "Cc", "ClassRef",
      #   "CompanyName", "Contact", "ContactsRet", "CreditCardInfo", "CreditLimit", "CurrencyRef",
      #   "CustomerTypeRef", "DataExtRet", "DeliveryMethod", "EditSequence", "Email",
      #   "ExternalGUID", "Fax", "FirstName", "FullName", "IsActive", "IsStatementWithParent",
      #   "ItemSalesTaxRef", "JobDesc", "JobEndDate", "JobProjectedEndDate", "JobStartDate",
      #   "JobStatus", "JobTitle", "JobTypeRef", "LastName", "ListID", "MiddleName", "Mobile",
      #   "Name", "Notes", "Pager", "ParentRef", "Phone", "PreferredDeliveryMethod",
      #   "PreferredPaymentMethodRef", "PriceLevelRef", "PrintAs", "ResaleNumber", "SalesRepRef",
      #   "SalesTaxCodeRef", "SalesTaxCountry", "Salutation", "ShipAddress", "ShipAddressBlock",
      #   "ShipToAddress", "Sublevel", "Suffix", "TaxRegistrationNumber", "TermsRef", "TimeCreated",
      #   "TimeModified", "TotalBalance">)
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
      #   `max_returned`, `name_contains`, `name_ends_with`, `name_range`, `name_starts_with`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the metaData query attribute.)
      #   If you include a `max_returned` value, it must be at least 1. The page size, with
      #   `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap instead: at
      #   most this many records come back, in one answer, and QuickBooks doesn't say whether more
      #   matched. Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `from_modified_date`, `max_returned`, `name_contains`, `name_ends_with`, `name_range`,
      #   `name_starts_with`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `name_contains` (String): Filters according to the object’s Name. Choose at most one of:
      #   the set (`name_contains`, `name_ends_with`, `name_starts_with`), or `name_range`. Members
      #   of a set combine with each other, not with the other choices.
      # - `name_ends_with` (String): Filters according to the object’s Name. Choose at most one of:
      #   the set (`name_contains`, `name_ends_with`, `name_starts_with`), or `name_range`. Members
      #   of a set combine with each other, not with the other choices.
      # - `name_range` (Hash): Filters according to the object’s Name. Choose at most one of: the
      #   set (`name_contains`, `name_ends_with`, `name_starts_with`), or `name_range`. Members of a
      #   set combine with each other, not with the other choices.
      #   - `from` (String)
      #   - `to` (String)
      # - `name_starts_with` (String): Filters according to the object’s Name. Choose at most one
      #   of: the set (`name_contains`, `name_ends_with`, `name_starts_with`), or `name_range`.
      #   Members of a set combine with each other, not with the other choices.
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
      #   `max_returned`, `name_contains`, `name_ends_with`, `name_range`, `name_starts_with`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/customers/list-customers
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("customer.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update customer: PUT /connections/{connection_id}/customers (`customer.update`).
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
      #   - `note` (String, required): In a `bill_address` or `ship_address` aggregate, the Note
      #     field value is written at the bottom of the address in the form in which it appears,
      #     such as the invoice form.
      #   - `note_id` (Integer, required): The ID of the note.
      # - `alt_contact` (String): The name of an alternate contact person for a vendor, customer, or
      #   “other name” entry.
      # - `alt_phone` (String): A telephone number given as an alternative to Phone.
      # - `bill_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
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
      # - `credit_card_info` (Hash): Customer’s credit-card information.
      #   - `credit_card_address` (String): The address associated with this credit card.
      #   - `credit_card_number` (String): Credit-card number for this customer or this payment.
      #     Beginning with qbXML spec 6.0 and QuickBooks 2007, you must mask the credit card number
      #     with lower case “x” and no dashes. For example, xxxxxxxxxxxx1234.
      #   - `credit_card_postal_code` (String): The postal code associated with the address for this
      #     credit card.
      #   - `expiration_month` (Integer): The month when the credit card expires.
      #   - `expiration_year` (Integer): The year when the credit card expires.
      #   - `name_on_card` (String): The name on the customer’s credit card.
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
      # - `customer_type_ref` (Hash): Customer types allow business owners to categorize customers
      #   in ways that are meaningful for their businesses. For example, a customer type might
      #   indicate which industry a customer represents, or which part of the country a customer is
      #   in. A `customer_type_ref` aggregate refers to one of the types on the CustomerType list.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `delivery_method` (one of "Email", "Fax", "Print")
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `email` (String): E-mail address.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AltContact", "AltPhone", "Balance", "BillAddress",
      #   "BillAddressBlock", "Cc", "ClassRef", "CompanyName", "Contact", "ContactsRet",
      #   "CreditCardInfo", "CreditLimit", "CurrencyRef", "CustomerTypeRef", "DataExtRet",
      #   "DeliveryMethod", "EditSequence", "Email", "ExternalGUID", "Fax", "FirstName", "FullName",
      #   "IsActive", "IsStatementWithParent", "ItemSalesTaxRef", "JobDesc", "JobEndDate",
      #   "JobProjectedEndDate", "JobStartDate", "JobStatus", "JobTitle", "JobTypeRef", "LastName",
      #   "ListID", "MiddleName", "Mobile", "Name", "Notes", "OwnerID", "Pager", "ParentRef",
      #   "Phone", "PreferredDeliveryMethod", "PreferredPaymentMethodRef", "PriceLevelRef",
      #   "PrintAs", "ResaleNumber", "SalesRepRef", "SalesTaxCodeRef", "SalesTaxCountry",
      #   "Salutation", "ShipAddress", "ShipAddressBlock", "ShipToAddress", "Sublevel", "Suffix",
      #   "TaxRegistrationNumber", "TermsRef", "TimeCreated", "TimeModified", "TotalBalance",
      #   "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_statement_with_parent` (Boolean)
      # - `item_sales_tax_ref` (Hash): An ItemSalesTax entry represents one tax rate paid to one tax
      #   agency. Use it when a transaction needs a single tax calculation. For multi-rate
      #   scenarios, use a sales-tax group instead. If both `full_name` and `list_id` are provided
      #   for `item_sales_tax_ref`, `list_id` is used.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `job_desc` (String): A short job description for a sub-customer; used in reports. The Job-
      #   elements (`job_desc`, `job_end_date`, `job_projected_end_date`, `job_start_date`, and
      #   `job_status`) correspond to the fields in the Job Info tab of the Edit Job window in
      #   QuickBooks.
      # - `job_end_date` (String): The date on which work for a sub-customer was completed; used in
      #   reports. The Job- elements (`job_desc`, `job_end_date`, `job_projected_end_date`,
      #   `job_start_date`, and `job_status`) correspond to the fields in the Job Info tab of the
      #   Edit Job window in QuickBooks.
      # - `job_projected_end_date` (String): The date on which work for a sub-customer is expected
      #   to be complete; used in reports. The Job- elements (`job_desc`, `job_end_date`,
      #   `job_projected_end_date`, `job_start_date`, and `job_status`) correspond to the fields in
      #   the Job Info tab of the Edit Job window in QuickBooks.
      # - `job_start_date` (String): The date on which work for a sub-customer was started; used in
      #   reports. The Job- elements (`job_desc`, `job_end_date`, `job_projected_end_date`,
      #   `job_start_date`, and `job_status`) correspond to the fields in the Job Info tab of the
      #   Edit Job window in QuickBooks.
      # - `job_status` (one of "Awarded", "Closed", "InProgress", "None", "NotAwarded", "Pending"):
      #   `job_status` Status information about a sub-customer; used in reports. The Job- elements
      #   (`job_desc`, `job_end_date`, `job_projected_end_date`, `job_start_date`, and `job_status`)
      #   correspond to the fields in the Job Info tab of the Edit Job window in QuickBooks.
      # - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `job_type_ref` (Hash): Job type can be used to separate jobs into any categories that are
      #   meaningful to the business. A `job_type_ref` aggregate refers to a job type on the JobType
      #   list. In a request, if a `job_type_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
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
      # - `notes` (String): Not supported.
      # - `pager` (String)
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
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `phone` (String): The telephone number.
      # - `preferred_delivery_method` (one of "Email", "Fax", "None"): Preference for how invoices
      #   are delivered.
      # - `preferred_payment_method_ref` (Hash): Refers to a PaymentMethod object. In a request, if
      #   a `preferred_payment_method_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `price_level_ref` (Hash): Price levels let you apply custom pricing rules for selected
      #   customers. Once assigned, QuickBooks uses those prices automatically on supported sales
      #   forms unless explicitly overridden.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `print_as` (String)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `resale_number` (String): The customer’s resale number, if they have one. This number
      #   won’t affect reports or sales tax calculations.
      # - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #   Names list within QuickBooks. Sales representative’s names and initials appear on the Rep
      #   drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on the
      #   SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both `full_name` and
      #   `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
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
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `ship_to_address` (Array<Hash>)
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `default_ship_to` (Boolean): Flag that address is the default ship to address.
      #   - `name` (String, required): Name is the case-insensitive short name of a list object
      #     (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists
      #     can reuse the same Name in different branches because `full_name` remains distinct.
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `suffix` (String)
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
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/customers/update-customer
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("customer.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
