# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks other name operations, reached as `client.other_name`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class OtherName < Base
      # Create other name: POST /connections/{connection_id}/other-names (`other_name.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_number` (String): Account numbers appear in the QuickBooks chart of accounts,
      #   Account fields, and reports and graphs. If the IsUsingAccountNumber preference is false
      #   (that is, if the QuickBooks user has the account numbers Preference turned off), you can
      #   still set account numbers through the SDK, but the numbers won’t be visible in the user
      #   interface.
      # - `alt_contact` (String): The name of an alternate contact person for a vendor, customer, or
      #   “other name” entry.
      # - `alt_phone` (String): A telephone number given as an alternative to Phone.
      # - `company_name` (String): The name of the QuickBooks user’s business, as specified in
      #   QuickBooks. `company_name` and Address are used on invoices, checks, and other forms.
      #   (LegalCompanyName and LegalAddress, on the other hand, are used on a company’s tax forms
      #   and pay stubs.)
      # - `contact` (String): The name of a contact person for a customer or vendor.
      # - `email` (String): E-mail address.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `include_ret_element` (Array<one of "AccountNumber", "AltContact", "AltPhone",
      #   "CompanyName", "Contact", "DataExtRet", "EditSequence", "Email", "ExternalGUID", "Fax",
      #   "FirstName", "IsActive", "LastName", "ListID", "MiddleName", "Name", "Notes",
      #   "OtherNameAddress", "OtherNameAddressBlock", "OwnerID", "Phone", "Salutation",
      #   "TimeCreated", "TimeModified", "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `middle_name` (String): The middle name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because FullName remains distinct.
      # - `notes` (String): Additional information.
      # - `other_name_address` (Hash): If an address request fails, some combination of address
      #   fields might be too long.
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
      # - `phone` (String): The telephone number.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/other-names/create-other-name
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("other_name.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List other names: GET /connections/{connection_id}/other-names (`other_name.query`).
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
      # - `include_ret_element` (Array<one of "AccountNumber", "AltContact", "AltPhone",
      #   "CompanyName", "Contact", "DataExtRet", "EditSequence", "Email", "ExternalGUID", "Fax",
      #   "FirstName", "IsActive", "LastName", "ListID", "MiddleName", "Name", "Notes",
      #   "OtherNameAddress", "OtherNameAddressBlock", "Phone", "Salutation", "TimeCreated",
      #   "TimeModified">)
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
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
      # @see https://docs.qubesync.com/api-reference/v2/other-names/list-other-names
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("other_name.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update other name: PUT /connections/{connection_id}/other-names (`other_name.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_number` (String): Account numbers appear in the QuickBooks chart of accounts,
      #   Account fields, and reports and graphs. If the IsUsingAccountNumber preference is false
      #   (that is, if the QuickBooks user has the account numbers Preference turned off), you can
      #   still set account numbers through the SDK, but the numbers won’t be visible in the user
      #   interface.
      # - `alt_contact` (String): The name of an alternate contact person for a vendor, customer, or
      #   “other name” entry.
      # - `alt_phone` (String): A telephone number given as an alternative to Phone.
      # - `company_name` (String): The name of the QuickBooks user’s business, as specified in
      #   QuickBooks. `company_name` and Address are used on invoices, checks, and other forms.
      #   (LegalCompanyName and LegalAddress, on the other hand, are used on a company’s tax forms
      #   and pay stubs.)
      # - `contact` (String): The name of a contact person for a customer or vendor.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `email` (String): E-mail address.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `include_ret_element` (Array<one of "AccountNumber", "AltContact", "AltPhone",
      #   "CompanyName", "Contact", "DataExtRet", "EditSequence", "Email", "ExternalGUID", "Fax",
      #   "FirstName", "IsActive", "LastName", "ListID", "MiddleName", "Name", "Notes",
      #   "OtherNameAddress", "OtherNameAddressBlock", "OwnerID", "Phone", "Salutation",
      #   "TimeCreated", "TimeModified", "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `list_id` (String, required): `list_id` and FullName both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      # - `middle_name` (String): The middle name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because FullName remains distinct.
      # - `notes` (String): Additional information.
      # - `other_name_address` (Hash): If an address request fails, some combination of address
      #   fields might be too long.
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
      # - `phone` (String): The telephone number.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/other-names/update-other-name
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("other_name.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
