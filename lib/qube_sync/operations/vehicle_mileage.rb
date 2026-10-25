# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks vehicle mileage operations, reached as `client.vehicle_mileage`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class VehicleMileage < Base
      # Create vehicle mileage: POST /connections/{connection_id}/vehicle-mileages
      # (`vehicle_mileage.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # Give at most one of: `odometer_end` with `odometer_start`, or `total_miles`.
      # - `billable_status` (one of "Billable", "HasBeenBilled", "NotBillable"): The billing status
      #   of this item line or expense line.
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
      # - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #   `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #   ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who the
      #   time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #   or TxnLineID so later requests can reference it with `useMacro`. This feature requires SDK
      #   2.0+.
      # - `include_ret_element` (Array<one of "BillableAmount", "BillableRate", "BillableStatus",
      #   "ClassRef", "CustomerRef", "EditSequence", "ExternalGUID", "ItemRef", "ListID", "Notes",
      #   "OdometerEnd", "OdometerStart", "OwnerID", "StandardMileageRate",
      #   "StandardMileageTotalAmount", "TimeCreated", "TimeModified", "TotalMiles", "TripEndDate",
      #   "TripStartDate", "TxnID", "TxnNumber", "VehicleRef">)
      # - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset, depending
      #   on the request. Examples: PurchaseOrder and Bill do not allow discount or sales-tax items;
      #   VehicleMileageAdd requires a service or other-charge item; BillingRateAdd requires a
      #   service item. If both `full_name` and `list_id` are provided, `full_name` is ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `notes` (String): Additional information.
      # - `odometer_end` (Numeric): Odometer reading at the end of the trip. `odometer_start` and
      #   `odometer_end` must both be specified if `total_miles` isn’t specified. QuickBooks will
      #   calculate the total trip miles from these two values. If `total_miles` is specified, you
      #   can’t specify `odometer_start` and `odometer_end`.
      # - `odometer_start` (Numeric): Odometer reading at the start of the trip. `odometer_start`
      #   and `odometer_end` must both be specified if `total_miles` isn’t specified. QuickBooks
      #   will calculate the total trip miles from these two values. If `total_miles` is specified,
      #   you can’t specify `odometer_start` and `odometer_end`.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `total_miles` (Numeric): Total trip miles. If `total_miles` is specified, you can’t
      #   specify `odometer_start` and `odometer_end`. If you use `odometer_start` and
      #   `odometer_end` instead of `total_miles`, QuickBooks will calculate the total trip miles
      #   from these two values.
      # - `trip_end_date` (String): Date the trip ended. If left blank, the current date at the time
      #   of transaction will be used. Notice that only dates are supported for vehicle mileage, so
      #   make sure you enter any datetime values with dates only, no time values. That is,
      #   2002-02-02 will work for trip end date or start date, but 2002-02-02T12:20:20 won’t work.
      # - `trip_start_date` (String): Date the trip began. If left blank, the current date at the
      #   time of transaction will be used. Notice that only dates are supported for vehicle
      #   mileage, so make sure you enter any datetime values with dates only, no time values. That
      #   is, 2002-02-02 will work for trip end date or start date, but 2002-02-02T12:20:20 won’t
      #   work.
      # - `vehicle_ref` (Hash, required): A vehicle for use in VehicleMileage transactions. Each
      #   vehicle name must be unique.
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
      # @see https://docs.qubesync.com/api-reference/v2/vehicle-mileages/create-vehicle-mileage
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("vehicle_mileage.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List vehicle mileages: GET /connections/{connection_id}/vehicle-mileages
      # (`vehicle_mileage.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `include_ret_element` (Array<one of "BillableAmount", "BillableRate", "BillableStatus",
      #   "ClassRef", "CustomerRef", "EditSequence", "ItemRef", "Notes", "OdometerEnd",
      #   "OdometerStart", "StandardMileageRate", "StandardMileageTotalAmount", "TimeCreated",
      #   "TimeModified", "TotalMiles", "TripEndDate", "TripStartDate", "TxnID", "VehicleRef">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records; send `iterator=true` with `max_returned` for another
      #   size. Off when you send `iterator=false` (every match in one answer) or `max_returned`
      #   alone (at most that many, in one answer). It pages a filtered query only: with `txn_id`
      #   every match comes back in one answer, so leave `iterator` out.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `txn_id`, or the set (`max_returned`,
      #   `modified_date_range_filter`, `txn_date_range_filter`). Members of a set combine with each
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
      #   qbXML version 1.0 or 1.1. Choose at most one of: `txn_id`, or the set (`max_returned`,
      #   `modified_date_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      #   - `from_modified_date` (String): Filters results to objects modified on or after this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to 00:00:00.
      #   - `to_modified_date` (String): Filters results to objects modified on or before this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to end-of-day (23:59:59).
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_date_range_filter` (Hash): Filters according to the original transaction dates.
      #   Choose at most one of: `txn_id`, or the set (`max_returned`, `modified_date_range_filter`,
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
      #   at most one of: `txn_id`, or the set (`max_returned`, `modified_date_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/vehicle-mileages/list-vehicle-mileages
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("vehicle_mileage.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
