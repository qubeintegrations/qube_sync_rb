# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks lead operations, reached as `client.lead`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Lead < Base
      # Create lead: POST /connections/{connection_id}/leads (`lead.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `additional_contact_ref` (Array<Hash>)
      #   - `contact_name` (String, required): The name of the contact.
      #   - `contact_value` (String, required): The value of the contact field.
      # - `company_name` (String): The name of the QuickBooks user’s business, as specified in
      #   QuickBooks. `company_name` and Address are used on invoices, checks, and other forms.
      #   (LegalCompanyName and LegalAddress, on the other hand, are used on a company’s tax forms
      #   and pay stubs.)
      # - `full_name` (String, required): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      # - `include_ret_element` (Array<one of "AdditionalContactRef", "CompanyName", "EditSequence",
      #   "ExternalGUID", "FullName", "LeadContactsRet", "ListID", "LocationsRet", "MainPhone",
      #   "OwnerID", "Status", "TimeCreated", "TimeModified", "TxnID", "TxnNumber">)
      # - `lead_contacts` (Array<Hash>)
      #   - `additional_contact_ref` (Array<Hash>)
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #   - `first_name` (String, required): The first name of a customer, vendor, employee, or
      #     person on the “other names” list.
      #   - `is_primary_contact` (Boolean): Flag for if this is a primary contact on a lead.
      #   - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `middle_name` (String): The middle name of a customer, vendor, employee, or person on
      #     the “other names” list.
      #   - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `locations` (Array<Hash>)
      #   - `lead_address` (Hash): Address for the lead.
      #     - `addr1` (String): The first line of an address.
      #     - `addr2` (String): The second line of an address (if a second line is needed).
      #     - `addr3` (String): The third line of an address (if a third line is needed).
      #     - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #     - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `location` (String, required): Where the asset is located or has been placed into
      #     service.
      # - `main_phone` (String): The main phone number.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `status` (one of "Cold", "Hot", "Warm"): The status of the lead.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/leads/create-lead
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("lead.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List leads: GET /connections/{connection_id}/leads (`lead.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or `name`,
      #   or the set (`from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "AdditionalContactRef", "CompanyName", "EditSequence",
      #   "FullName", "LeadContactsRet", "ListID", "LocationsRet", "MainPhone", "Status",
      #   "TimeCreated", "TimeModified">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records; send `iterator=true` with `max_returned` for another
      #   size. Off when you send `iterator=false` (every match in one answer) or `max_returned`
      #   alone (at most that many, in one answer). It pages a filtered query only: with `list_id`
      #   or `name` every match comes back in one answer, so leave `iterator` out.
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      #   Choose at most one of: `list_id`, or `name`, or the set (`from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `list_id`, or `name`, or the set
      #   (`from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name` (Array<String>): The string to match. Choose at most one of: `list_id`, or `name`,
      #   or the set (`from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `name`, or the set (`from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `name`, or the set (`from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
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
      #   `list_id`, or `name`, or the set (`from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/leads/list-leads
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("lead.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update lead: PUT /connections/{connection_id}/leads (`lead.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `additional_contact_ref` (Array<Hash>)
      #   - `contact_name` (String, required): The name of the contact.
      #   - `contact_value` (String, required): The value of the contact field.
      # - `company_name` (String): The name of the QuickBooks user’s business, as specified in
      #   QuickBooks. `company_name` and Address are used on invoices, checks, and other forms.
      #   (LegalCompanyName and LegalAddress, on the other hand, are used on a company’s tax forms
      #   and pay stubs.)
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `full_name` (String, required): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      # - `include_ret_element` (Array<one of "AdditionalContactRef", "CompanyName", "EditSequence",
      #   "ExternalGUID", "FullName", "LeadContactsRet", "ListID", "LocationsRet", "MainPhone",
      #   "OwnerID", "Status", "TimeCreated", "TimeModified", "TxnID", "TxnNumber">)
      # - `lead_contacts_mod` (Array<Hash>)
      #   - `additional_contact_ref` (Array<Hash>)
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #   - `first_name` (String, required): The first name of a customer, vendor, employee, or
      #     person on the “other names” list.
      #   - `is_primary_contact` (Boolean): Flag for if this is a primary contact on a lead.
      #   - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #     “other names” list.
      #   - `lead_contact_id` (Integer): `lead_contact_id` is a way to identify a lead contact
      #     object. When a lead contact object is added to QuickBooks through the SDK or through the
      #     QuickBooks user interface, the server assigns it a `lead_contact_id`.
      #   - `middle_name` (String): The middle name of a customer, vendor, employee, or person on
      #     the “other names” list.
      #   - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      # - `locations_mod` (Array<Hash>)
      #   - `lead_address` (Hash): Address for the lead.
      #     - `addr1` (String): The first line of an address.
      #     - `addr2` (String): The second line of an address (if a second line is needed).
      #     - `addr3` (String): The third line of an address (if a third line is needed).
      #     - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #     - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `location` (String, required): Where the asset is located or has been placed into
      #     service.
      #   - `location_id` (Integer, required): `location_id` is a way to identify a location object.
      #     When a location object is added to QuickBooks through the SDK or through the QuickBooks
      #     user interface, the server assigns it a `location_id`.
      # - `main_phone` (String): The main phone number.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `status` (one of "Cold", "Hot", "Warm"): The status of the lead.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/leads/update-lead
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("lead.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
