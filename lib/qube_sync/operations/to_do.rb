# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks to do operations, reached as `client.to_do`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ToDo < Base
      # Create to do: POST /connections/{connection_id}/to-dos (`to_do.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #   `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #   ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who the
      #   time can be billed to and is required in TimeTrackingAdd when IsBillable is true. Choose
      #   at most one of: `customer_ref`, or `employee_ref`, or `lead_ref`, or `vendor_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `employee_ref` (Hash): The employee list contains payroll information about each of the
      #   company’s employees. Choose at most one of: `customer_ref`, or `employee_ref`, or
      #   `lead_ref`, or `vendor_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `include_ret_element` (Array<one of "CustomerRef", "EditSequence", "EmployeeRef",
      #   "ExternalGUID", "IsActive", "IsDone", "LeadRef", "ListID", "Notes", "OwnerID", "Priority",
      #   "ReminderDate", "ReminderTime", "TimeCreated", "TimeModified", "TxnID", "TxnNumber",
      #   "Type", "VendorRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_done` (Boolean): If `is_done` is true, this “to do” task has been completed. The
      #   default value of `is_done` is false.
      # - `lead_ref` (Hash): The lead list contains information about leads for a company. Choose at
      #   most one of: `customer_ref`, or `employee_ref`, or `lead_ref`, or `vendor_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `notes` (String, required): Additional information.
      # - `priority` (one of "High", "Low", "Medium"): Priority may have one of the following
      #   values: Low [DEFAULT], Medium, High
      # - `reminder_date` (String): The date on which the contents of the Notes string will appear
      #   on the Reminder list within QuickBooks.
      # - `reminder_time` (String): The time on which the contents of the Notes string will appear
      #   on the Reminder list within QuickBooks.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `type` (one of "Appointment", "Call", "Email", "Fax", "Meeting", "Task"): Type may have
      #   one of the following values: Task [DEFAULT], Call, Fax, Email, Meeting, Appointment
      # - `vendor_ref` (Hash): A vendor is any person or company from whom a small business owner
      #   buys goods and services. (Banks and tax agencies usually are included on the vendor list.)
      #   A company’s vendor list contains information such as account balance and contact
      #   information about each vendor. A `vendor_ref` aggregate refers to one of the vendors on
      #   the list. Choose at most one of: `customer_ref`, or `employee_ref`, or `lead_ref`, or
      #   `vendor_ref`.
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
      # @see https://docs.qubesync.com/api-reference/v2/to-dos/create-to-do
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("to_do.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List to dos: GET /connections/{connection_id}/to-dos (`to_do.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or the set (`active_status`, `done_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `done_status` (one of "All", "DoneOnly", "NotDoneOnly"): Selects all the relevant “to do”
      #   notes (dsAll), only those that are done (dsDoneOnly), or only those that aren’t done
      #   (dsNotDoneOnly). Choose at most one of: `list_id`, or the set (`active_status`,
      #   `done_status`, `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `from_modified_date` (String): Filters results to objects modified on or after this
      #   timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #   date is provided, time defaults to 00:00:00. Choose at most one of: `list_id`, or the set
      #   (`active_status`, `done_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `include_ret_element` (Array<one of "CustomerRef", "EditSequence", "EmployeeRef",
      #   "IsActive", "IsDone", "LeadRef", "ListID", "Notes", "Priority", "ReminderDate",
      #   "ReminderTime", "TimeCreated", "TimeModified", "Type", "VendorRef">)
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      #   Choose at most one of: `list_id`, or the set (`active_status`, `done_status`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. QuickBooks
      #   doesn't page this query: at most this many records come back, in one answer, with no sign
      #   of whether more matched. Leave it out for every match, in one answer; one over 4 MB as the
      #   Web Connector sends it, about 3 MB of qbXML isn't kept (`error_type`
      #   `response_too_large`), so narrow a large one with its filters. Choose at most one of:
      #   `list_id`, or the set (`active_status`, `done_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or the set (`active_status`, `done_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or the set (`active_status`, `done_status`, `from_modified_date`,
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
      #   `list_id`, or the set (`active_status`, `done_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/to-dos/list-to-dos
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("to_do.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update to do: PUT /connections/{connection_id}/to-dos (`to_do.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #   `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #   ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who the
      #   time can be billed to and is required in TimeTrackingAdd when IsBillable is true. Choose
      #   at most one of: `customer_ref`, or `employee_ref`, or `lead_ref`, or `vendor_ref`.
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
      # - `employee_ref` (Hash): The employee list contains payroll information about each of the
      #   company’s employees. Choose at most one of: `customer_ref`, or `employee_ref`, or
      #   `lead_ref`, or `vendor_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `include_ret_element` (Array<one of "CustomerRef", "EditSequence", "EmployeeRef",
      #   "ExternalGUID", "IsActive", "IsDone", "LeadRef", "ListID", "Notes", "OwnerID", "Priority",
      #   "ReminderDate", "ReminderTime", "TimeCreated", "TimeModified", "TxnID", "TxnNumber",
      #   "Type", "VendorRef">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `is_done` (Boolean): If `is_done` is true, this “to do” task has been completed. The
      #   default value of `is_done` is false.
      # - `lead_ref` (Hash): The lead list contains information about leads for a company. Choose at
      #   most one of: `customer_ref`, or `employee_ref`, or `lead_ref`, or `vendor_ref`.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list family, not across the company file: customers, vendors, employees and other
      #   names share one sequence, every item type shares another, and each other list has its own.
      # - `notes` (String): Additional information.
      # - `priority` (one of "High", "Low", "Medium"): Priority may have one of the following
      #   values: Low [DEFAULT], Medium, High
      # - `reminder_date` (String): The date on which the contents of the Notes string will appear
      #   on the Reminder list within QuickBooks.
      # - `reminder_time` (String): The time on which the contents of the Notes string will appear
      #   on the Reminder list within QuickBooks.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `type` (one of "Appointment", "Call", "Email", "Fax", "Meeting", "Task"): Type may have
      #   one of the following values: Task [DEFAULT], Call, Fax, Email, Meeting, Appointment
      # - `vendor_ref` (Hash): A vendor is any person or company from whom a small business owner
      #   buys goods and services. (Banks and tax agencies usually are included on the vendor list.)
      #   A company’s vendor list contains information such as account balance and contact
      #   information about each vendor. A `vendor_ref` aggregate refers to one of the vendors on
      #   the list. Choose at most one of: `customer_ref`, or `employee_ref`, or `lead_ref`, or
      #   `vendor_ref`.
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
      # @see https://docs.qubesync.com/api-reference/v2/to-dos/update-to-do
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("to_do.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
