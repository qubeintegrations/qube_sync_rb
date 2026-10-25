# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks employee operations, reached as `client.employee`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Employee < Base
      # Create employee: POST /connections/{connection_id}/employees (`employee.create`).
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
      #   - `note` (String, required): In a BillAddress or ShipAddress aggregate, the Note field
      #     value is written at the bottom of the address in the form in which it appears, such as
      #     the invoice form.
      # - `adjusted_service_date` (String): Adjusted service date for the employee.
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
      # - `birth_date` (String): Date of birth.
      # - `department` (String): The name of the department in the employment job details section.
      # - `description` (String): The description details in the employment job details section.
      # - `disability_desc` (String): Description of employee’s disablitily.
      # - `disabled` (one of "No", "Yes"): Is employee disabled?
      # - `email` (String): E-mail address.
      # - `emergency_contacts` (Hash): Emergency Contact information for the employee.
      #   - `primary_contact` (Hash): Primary emergency contact information for the employee.
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #     - `relation` (one of "Brother", "Daughter", "Father", "Friend", "Mother", "Other",
      #       "Partner", "Sister", "Son", "Spouse"): Relationship of emergency contact information
      #       to the employee.
      #   - `secondary_contact` (Hash): Secondary emergency contact information for the employee.
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #     - `relation` (one of "Brother", "Daughter", "Father", "Friend", "Mother", "Other",
      #       "Partner", "Sister", "Son", "Spouse"): Relationship of emergency contact information
      #       to the employee.
      # - `employee_address` (Hash): If an address request fails, some combination of address fields
      #   might be too long. If you use payroll, you must specify the employee’s city, state (or
      #   province), ZIP (or postal) code, and at least one line of the street address. (Note that
      #   the State element has restrictions when it’s used in the `employee_address` aggregate. For
      #   more information, click State in the table.)
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String)
      #   - `addr4` (String)
      #   - `city` (String): The city name in an address.
      #   - `country` (String)
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): When it appears in the `employee_address` aggregate, the State element
      #     acts like an ENUMTYPE with the following possible values: None, AA (military), AE
      #     (military), AK, AL, AP (military), AR, AZ, CA, CO, CT, DC, DE, FL, GA, HI, IA, ID, IL,
      #     IN, KS, KY, LA, MA, MD, ME, MI, MN, MO, MS, MT, NC, ND, NE, NH, NJ, NM, NV, NY, OH, OK,
      #     OR, PA, PR, RI, SC, SD, TN, TX, UT, VA, VT, WA, WI, WV, and WY.
      # - `employee_payroll_info` (Hash): Pay information for this employee.
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
      #   - `clear_earnings` (Boolean): If `clear_earnings` is set to true, the earnings will be
      #     deleted for this employee. Choose at most one of: `clear_earnings`, or `earnings`.
      #   - `earnings` (Array<Hash>): Choose at most one of: `clear_earnings`, or `earnings`.
      #     - `payroll_item_wage_ref` (Hash, required): Each payroll wage item describes and names a
      #       payment scheme, for example, Regular Pay or Overtime Pay. A `payroll_item_wage_ref`
      #       aggregate refers to one of these wage items. In a request, if a
      #       `payroll_item_wage_ref` aggregate includes both `full_name` and `list_id`, `full_name`
      #       will be ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `rate` (Numeric): Indicates the price of something. Choose at most one of: `rate`, or
      #       `rate_percent`.
      #     - `rate_percent` (Numeric): Indicates the price of something as a percent. Choose at
      #       most one of: `rate`, or `rate_percent`.
      #   - `pay_period` (one of "Biweekly", "Daily", "Monthly", "Quarterly", "Semimonthly",
      #     "Weekly", "Yearly"): Indicates how often employees are paid. If you include a blank
      #     `pay_period` element in an EmployeeMod message, you’ll receive an error. The default
      #     value is whatever the QuickBooks user has set in the QuickBooks Employee Preferences.
      #   - `sick_hours` (Hash): Describes how “sick time” is accrued for this employee, along with
      #     how many sick hours the employee has accrued.
      #     - `accrual_period` (one of "BeginningOfYear", "EveryHourOnPaycheck", "EveryPaycheck"):
      #       Indicates how an employee accrues time off. If you include a blank `accrual_period`
      #       element in an EmployeeMod message, you’ll receive an error. The default value is
      #       whatever the QuickBooks user has set in the QuickBooks Employee Preferences.
      #     - `accrual_start_date` (String): When used in the `sick_hours` or `vacation_hours`
      #       aggregates, refers to the date on which sick leave or vacation hours in the current
      #       year began to accrue.
      #     - `hours_accrued` (String): The number of hours that the employee will accrue per
      #       accrual period. The default value is whatever the QuickBooks user has set in the
      #       QuickBooks Employee Preferences.
      #     - `hours_available` (String): The total number of hours currently available for the
      #       employee to use. If this value is empty, it will default to 0.
      #     - `hours_used` (String): When used in the `sick_hours` or `vacation_hours` aggregates,
      #       refers to the number of sick leave or vacation hours used in the current year.
      #     - `is_resetting_hours_each_new_year` (Boolean): Indicates whether or not the hours
      #       accrued resets to zero at the beginning of the new year. If you include a blank
      #       `is_resetting_hours_each_new_year` element in an EmployeeMod message, you’ll receive
      #       an error.
      #     - `maximum_hours` (String): The maximum number of hours that the employee can accrue.
      #       (QuickBooks itself doesn’t enforce this limit, however. `hours_available` can be
      #       greater than `maximum_hours`.) The default value is whatever the QuickBooks user has
      #       set in the QuickBooks Employee Preferences.
      #   - `use_time_data_to_create_paychecks` (one of "DoNotUseTimeData", "NotSet",
      #     "UseTimeData"): Indicates whether time data is used to create paychecks for this
      #     employee.
      #   - `vacation_hours` (Hash): Describes how vacation time is accrued for this employee, along
      #     with how many vacation hours the employee has accrued.
      #     - `accrual_period` (one of "BeginningOfYear", "EveryHourOnPaycheck", "EveryPaycheck"):
      #       Indicates how an employee accrues time off. If you include a blank `accrual_period`
      #       element in an EmployeeMod message, you’ll receive an error. The default value is
      #       whatever the QuickBooks user has set in the QuickBooks Employee Preferences.
      #     - `accrual_start_date` (String): When used in the `sick_hours` or `vacation_hours`
      #       aggregates, refers to the date on which sick leave or vacation hours in the current
      #       year began to accrue.
      #     - `hours_accrued` (String): The number of hours that the employee will accrue per
      #       accrual period. The default value is whatever the QuickBooks user has set in the
      #       QuickBooks Employee Preferences.
      #     - `hours_available` (String): The total number of hours currently available for the
      #       employee to use. If this value is empty, it will default to 0.
      #     - `hours_used` (String): When used in the `sick_hours` or `vacation_hours` aggregates,
      #       refers to the number of sick leave or vacation hours used in the current year.
      #     - `is_resetting_hours_each_new_year` (Boolean): Indicates whether or not the hours
      #       accrued resets to zero at the beginning of the new year. If you include a blank
      #       `is_resetting_hours_each_new_year` element in an EmployeeMod message, you’ll receive
      #       an error.
      #     - `maximum_hours` (String): The maximum number of hours that the employee can accrue.
      #       (QuickBooks itself doesn’t enforce this limit, however. `hours_available` can be
      #       greater than `maximum_hours`.) The default value is whatever the QuickBooks user has
      #       set in the QuickBooks Employee Preferences.
      # - `employee_type` (one of "Officer", "Owner", "Regular", "Statutory"): `employee_type` can
      #   affect payroll taxes for an employee. A statutory employee is a person who is defined as
      #   an employee by statute. Usually an owner or partner will be on the Other Names list, but
      #   if they are on the Employee list, their `employee_type` will be Owner.
      # - `ethnicity` (one of "AmericianIndian", "Asian", "Black", "Hawaiian", "Hispanic",
      #   "TwoOrMoreRaces", "White"): Ethnicity of employee from AmericianIndian, Asian, Black,
      #   Hawaiian, Hispanic, White, TwoOrMoreRaces
      # - `exempt` (one of "Exempt", "NonExempt"): Exempt or Non-exempt status of the employee.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `gender` (one of "Female", "Male"): The gender of this employee.
      # - `hired_date` (String): An employee’s date of hire.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AdjustedServiceDate", "AltPhone", "BillingRateRef", "BirthDate",
      #   "DataExtRet", "Department", "Description", "DisabilityDesc", "Disabled", "EditSequence",
      #   "Email", "EmergencyContacts", "EmployeeAddress", "EmployeePayrollInfo", "EmployeeType",
      #   "Ethnicity", "Exempt", "ExternalGUID", "Fax", "FirstName", "Gender", "HiredDate",
      #   "IsActive", "JobTitle", "KeyEmployee", "LastName", "ListID", "MiddleName",
      #   "MilitaryStatus", "Mobile", "Name", "Notes", "OnFile", "OriginalHireDate", "OwnerID",
      #   "Pager", "PagerPIN", "PartOrFullTime", "Phone", "PrintAs", "ReleasedDate", "SSN",
      #   "Salutation", "Suffix", "SupervisorRef", "TargetBonus", "TimeCreated", "TimeModified",
      #   "TxnID", "TxnNumber", "USCitizen", "USVeteran", "WorkAuthExpireDate">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `key_employee` (one of "No", "Yes"): Is employee a key or critical employee.
      # - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `middle_name` (String): The middle name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `military_status` (one of "Active", "Reserve"): Military status if the employee is a US
      #   veteran.
      # - `mobile` (String): Mobile telephone number.
      # - `name` (String): A concatenation of `first_name`, `middle_name`, and `last_name`.
      # - `notes` (String): Additional information.
      # - `on_file` (one of "No", "Yes"): Is the employee’s I-9 on file?
      # - `original_hire_date` (String): Original hire date the employee was hired.
      # - `pager` (String): The pager number.
      # - `pager_pin` (String): A personal identification number for this employee’s pager.
      # - `part_or_full_time` (one of "FullTime", "PartTime"): Full or Part time status of the
      #   employee.
      # - `phone` (String): The telephone number.
      # - `print_as` (String): By default within QuickBooks, the `print_as` element is the same as
      #   the Name element.
      # - `released_date` (String): The date on which this person’s employment with the company
      #   ended.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `ssn` (String): Social security number. When you add an SSN value to an employee record,
      #   it doesn’t have to include dashes; for example, either 123-45-6789 or 123456789 would be
      #   valid.
      # - `suffix` (String)
      # - `supervisor_ref` (Hash): The name of a customer, vendor, employee, or person on the “other
      #   names” list in the employment job details section.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `target_bonus` (Numeric): The target bonus amount in the employment job details section.
      # - `us_citizen` (one of "No", "Yes"): Is employee a US citizen?
      # - `us_veteran` (one of "No", "Yes"): Is employee a US veteran?
      # - `work_auth_expire_date` (String): Date the employee’s work authorization expires.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/employees/create-employee
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("employee.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List employees: GET /connections/{connection_id}/employees (`employee.query`).
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
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AdjustedServiceDate", "AltPhone", "BillingRateRef", "BirthDate",
      #   "DataExtRet", "Department", "Description", "DisabilityDesc", "Disabled", "EditSequence",
      #   "Email", "EmergencyContacts", "EmployeeAddress", "EmployeePayrollInfo", "EmployeeType",
      #   "Ethnicity", "Exempt", "ExternalGUID", "Fax", "FirstName", "Gender", "HiredDate",
      #   "IsActive", "JobTitle", "KeyEmployee", "LastName", "ListID", "MiddleName",
      #   "MilitaryStatus", "Mobile", "Name", "Notes", "OnFile", "OriginalHireDate", "Pager",
      #   "PagerPIN", "PartOrFullTime", "Phone", "PrintAs", "ReleasedDate", "SSN", "Salutation",
      #   "Suffix", "SupervisorRef", "TargetBonus", "TimeCreated", "TimeModified", "USCitizen",
      #   "USVeteran", "WorkAuthExpireDate">)
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
      # @see https://docs.qubesync.com/api-reference/v2/employees/list-employees
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("employee.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update employee: PUT /connections/{connection_id}/employees (`employee.update`).
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
      #   - `note` (String, required): In a BillAddress or ShipAddress aggregate, the Note field
      #     value is written at the bottom of the address in the form in which it appears, such as
      #     the invoice form.
      #   - `note_id` (Integer, required): The ID of the note.
      # - `adjusted_service_date` (String): Adjusted service date for the employee.
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
      # - `birth_date` (String): Date of birth.
      # - `department` (String): The name of the department in the employment job details section.
      # - `description` (String): The description details in the employment job details section.
      # - `disability_desc` (String): Description of employee’s disablitily.
      # - `disabled` (one of "No", "Yes"): Is employee disabled?
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `email` (String): E-mail address.
      # - `emergency_contacts` (Hash): Emergency Contact information for the employee.
      #   - `primary_contact` (Hash): Primary emergency contact information for the employee.
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #     - `relation` (one of "Brother", "Daughter", "Father", "Friend", "Mother", "Other",
      #       "Partner", "Sister", "Son", "Spouse"): Relationship of emergency contact information
      #       to the employee.
      #   - `secondary_contact` (Hash): Secondary emergency contact information for the employee.
      #     - `contact_name` (String, required): The name of the contact.
      #     - `contact_value` (String, required): The value of the contact field.
      #     - `relation` (one of "Brother", "Daughter", "Father", "Friend", "Mother", "Other",
      #       "Partner", "Sister", "Son", "Spouse"): Relationship of emergency contact information
      #       to the employee.
      # - `employee_address` (Hash): If an address request fails, some combination of address fields
      #   might be too long. If you use payroll, you must specify the employee’s city, state (or
      #   province), ZIP (or postal) code, and at least one line of the street address. (Note that
      #   the State element has restrictions when it’s used in the `employee_address` aggregate. For
      #   more information, click State in the table.)
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String)
      #   - `addr4` (String)
      #   - `city` (String): The city name in an address.
      #   - `country` (String)
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): When it appears in the `employee_address` aggregate, the State element
      #     acts like an ENUMTYPE with the following possible values: None, AA (military), AE
      #     (military), AK, AL, AP (military), AR, AZ, CA, CO, CT, DC, DE, FL, GA, HI, IA, ID, IL,
      #     IN, KS, KY, LA, MA, MD, ME, MI, MN, MO, MS, MT, NC, ND, NE, NH, NJ, NM, NV, NY, OH, OK,
      #     OR, PA, PR, RI, SC, SD, TN, TX, UT, VA, VT, WA, WI, WV, and WY.
      # - `employee_payroll_info_mod` (Hash): Pay information for this employee.
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
      #   - `clear_earnings` (Boolean): If `clear_earnings` is set to true, the earnings will be
      #     deleted for this employee. Choose at most one of: `clear_earnings`, or `earnings`.
      #   - `earnings` (Array<Hash>): Choose at most one of: `clear_earnings`, or `earnings`.
      #     - `payroll_item_wage_ref` (Hash, required): Each payroll wage item describes and names a
      #       payment scheme, for example, Regular Pay or Overtime Pay. A `payroll_item_wage_ref`
      #       aggregate refers to one of these wage items. In a request, if a
      #       `payroll_item_wage_ref` aggregate includes both `full_name` and `list_id`, `full_name`
      #       will be ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list type, not globally across all lists. If both `full_name` and `list_id`
      #         are supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #     - `rate` (Numeric): Indicates the price of something. Choose at most one of: `rate`, or
      #       `rate_percent`.
      #     - `rate_percent` (Numeric): Indicates the price of something as a percent. Choose at
      #       most one of: `rate`, or `rate_percent`.
      #   - `pay_period` (one of "Biweekly", "Daily", "Monthly", "Quarterly", "Semimonthly",
      #     "Weekly", "Yearly"): Indicates how often employees are paid. If you include a blank
      #     `pay_period` element in an EmployeeMod message, you’ll receive an error. The default
      #     value is whatever the QuickBooks user has set in the QuickBooks Employee Preferences.
      #   - `sick_hours` (Hash): Describes how “sick time” is accrued for this employee, along with
      #     how many sick hours the employee has accrued.
      #     - `accrual_period` (one of "BeginningOfYear", "EveryHourOnPaycheck", "EveryPaycheck"):
      #       Indicates how an employee accrues time off. If you include a blank `accrual_period`
      #       element in an EmployeeMod message, you’ll receive an error. The default value is
      #       whatever the QuickBooks user has set in the QuickBooks Employee Preferences.
      #     - `accrual_start_date` (String): When used in the `sick_hours` or `vacation_hours`
      #       aggregates, refers to the date on which sick leave or vacation hours in the current
      #       year began to accrue.
      #     - `hours_accrued` (String): The number of hours that the employee will accrue per
      #       accrual period. The default value is whatever the QuickBooks user has set in the
      #       QuickBooks Employee Preferences.
      #     - `hours_available` (String): The total number of hours currently available for the
      #       employee to use. If this value is empty, it will default to 0.
      #     - `hours_used` (String): When used in the `sick_hours` or `vacation_hours` aggregates,
      #       refers to the number of sick leave or vacation hours used in the current year.
      #     - `is_resetting_hours_each_new_year` (Boolean): Indicates whether or not the hours
      #       accrued resets to zero at the beginning of the new year. If you include a blank
      #       `is_resetting_hours_each_new_year` element in an EmployeeMod message, you’ll receive
      #       an error.
      #     - `maximum_hours` (String): The maximum number of hours that the employee can accrue.
      #       (QuickBooks itself doesn’t enforce this limit, however. `hours_available` can be
      #       greater than `maximum_hours`.) The default value is whatever the QuickBooks user has
      #       set in the QuickBooks Employee Preferences.
      #   - `use_time_data_to_create_paychecks` (one of "DoNotUseTimeData", "NotSet",
      #     "UseTimeData"): Indicates whether time data is used to create paychecks for this
      #     employee.
      #   - `vacation_hours` (Hash): Describes how vacation time is accrued for this employee, along
      #     with how many vacation hours the employee has accrued.
      #     - `accrual_period` (one of "BeginningOfYear", "EveryHourOnPaycheck", "EveryPaycheck"):
      #       Indicates how an employee accrues time off. If you include a blank `accrual_period`
      #       element in an EmployeeMod message, you’ll receive an error. The default value is
      #       whatever the QuickBooks user has set in the QuickBooks Employee Preferences.
      #     - `accrual_start_date` (String): When used in the `sick_hours` or `vacation_hours`
      #       aggregates, refers to the date on which sick leave or vacation hours in the current
      #       year began to accrue.
      #     - `hours_accrued` (String): The number of hours that the employee will accrue per
      #       accrual period. The default value is whatever the QuickBooks user has set in the
      #       QuickBooks Employee Preferences.
      #     - `hours_available` (String): The total number of hours currently available for the
      #       employee to use. If this value is empty, it will default to 0.
      #     - `hours_used` (String): When used in the `sick_hours` or `vacation_hours` aggregates,
      #       refers to the number of sick leave or vacation hours used in the current year.
      #     - `is_resetting_hours_each_new_year` (Boolean): Indicates whether or not the hours
      #       accrued resets to zero at the beginning of the new year. If you include a blank
      #       `is_resetting_hours_each_new_year` element in an EmployeeMod message, you’ll receive
      #       an error.
      #     - `maximum_hours` (String): The maximum number of hours that the employee can accrue.
      #       (QuickBooks itself doesn’t enforce this limit, however. `hours_available` can be
      #       greater than `maximum_hours`.) The default value is whatever the QuickBooks user has
      #       set in the QuickBooks Employee Preferences.
      # - `employee_type` (one of "Officer", "Owner", "Regular", "Statutory"): `employee_type` can
      #   affect payroll taxes for an employee. A statutory employee is a person who is defined as
      #   an employee by statute. Usually an owner or partner will be on the Other Names list, but
      #   if they are on the Employee list, their `employee_type` will be Owner.
      # - `ethnicity` (one of "AmericianIndian", "Asian", "Black", "Hawaiian", "Hispanic",
      #   "TwoOrMoreRaces", "White"): Ethnicity of employee from AmericianIndian, Asian, Black,
      #   Hawaiian, Hispanic, White, TwoOrMoreRaces.
      # - `exempt` (one of "Exempt", "NonExempt"): Exempt or Non-exempt status of the employee.
      # - `fax` (String): Fax number.
      # - `first_name` (String): The first name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `hired_date` (String): An employee’s date of hire.
      # - `include_ret_element` (Array<one of "AccountNumber", "AdditionalContactRef",
      #   "AdditionalNotesRet", "AdjustedServiceDate", "AltPhone", "BillingRateRef", "BirthDate",
      #   "DataExtRet", "Department", "Description", "DisabilityDesc", "Disabled", "EditSequence",
      #   "Email", "EmergencyContacts", "EmployeeAddress", "EmployeePayrollInfo", "EmployeeType",
      #   "Ethnicity", "Exempt", "ExternalGUID", "Fax", "FirstName", "Gender", "HiredDate",
      #   "IsActive", "JobTitle", "KeyEmployee", "LastName", "ListID", "MiddleName",
      #   "MilitaryStatus", "Mobile", "Name", "Notes", "OnFile", "OriginalHireDate", "OwnerID",
      #   "Pager", "PagerPIN", "PartOrFullTime", "Phone", "PrintAs", "ReleasedDate", "SSN",
      #   "Salutation", "Suffix", "SupervisorRef", "TargetBonus", "TimeCreated", "TimeModified",
      #   "TxnID", "TxnNumber", "USCitizen", "USVeteran", "WorkAuthExpireDate">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `job_title` (String): The job title of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `key_employee` (one of "No", "Yes"): Is employee a key or critical employee.
      # - `last_name` (String): The last name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `middle_name` (String): The middle name of a customer, vendor, employee, or person on the
      #   “other names” list.
      # - `military_status` (one of "Active", "Reserve"): Military status if the employee is a US
      #   veteran.
      # - `mobile` (String): Mobile telephone number.
      # - `name` (String): A concatenation of `first_name`, `middle_name`, and `last_name`.
      # - `notes` (String): Additional information.
      # - `on_file` (one of "No", "Yes"): Is the employee’s I-9 on file?
      # - `original_hire_date` (String): Original hire date the employee was hired.
      # - `pager` (String): The pager number.
      # - `pager_pin` (String): A personal identification number for this employee’s pager.
      # - `part_or_full_time` (one of "FullTime", "PartTime"): Full or Part time status of the
      #   employee.
      # - `phone` (String): The telephone number.
      # - `print_as` (String): By default within QuickBooks, the `print_as` element is the same as
      #   the Name element.
      # - `released_date` (String): The date on which this person’s employment with the company
      #   ended.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `salutation` (String): A formal reference, such as Mr. or Dr., that precedes a name.
      # - `suffix` (String)
      # - `supervisor_ref` (Hash): The name of a customer, vendor, employee, or person on the “other
      #   names” list in the employment job details section.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `target_bonus` (Numeric): The target bonus amount in the employment job details section.
      # - `us_citizen` (one of "No", "Yes"): Is employee a US citizen?
      # - `us_veteran` (one of "No", "Yes"): Is employee a US veteran?
      # - `work_auth_expire_date` (String): Date the employee’s work authorization expires.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/employees/update-employee
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("employee.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
