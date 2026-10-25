# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks payroll item operations, reached as `client.payroll_item`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class PayrollItem < Base
      # List payroll items: GET /connections/{connection_id}/payroll-items (`payroll_item.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`active_status`, `from_modified_date`,
      #   `max_returned`, `name_filter`, `name_range_filter`, `to_modified_date`). Members of a set
      #   combine with each other, not with the other choices.
      # - `from_modified_date` (String): Choose at most one of: `list_id`, or `full_name`, or the
      #   set (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `full_name` (Array<String>): Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `include_ret_element` (Array<one of "CalculatedBasedOn", "EditSequence",
      #   "ExpenseAccountRef", "IsActive", "IsTrackedByCustJob", "LiabilityAccountRef",
      #   "LiabilityPaymentSchedule", "Limit", "LimitTimePeriod", "ListID", "Name", "NetOrGross",
      #   "OvertimeMultiplier", "PaymentTemplateRef", "PayrollItemDetailTypeValue", "Rate",
      #   "RateChange", "RatePercent", "State", "TaxCalculatedBasedOn", "Taxability", "TimeCreated",
      #   "TimeModified", "VendorAccountNumber", "VendorRef", "W2TrackingTypeValue", "WageType">)
      # - `list_id` (Array<String>): Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `max_returned` (Integer): QuickBooks doesn't page this query: at most this many records
      #   come back, in one answer, with no sign of whether more matched. Leave it out for every
      #   match, in one answer; one over 4 MB as the Web Connector sends it, about 3 MB of qbXML
      #   isn't kept (`error_type` `response_too_large`), so narrow a large one with its filters.
      #   Choose at most one of: `list_id`, or `full_name`, or the set (`active_status`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData")
      # - `name_filter` (Hash): Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required)
      #   - `name` (String, required)
      # - `name_range_filter` (Hash): Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #   - `from_name` (String)
      #   - `to_name` (String)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `to_modified_date` (String): Choose at most one of: `list_id`, or `full_name`, or the set
      #   (`active_status`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/payroll-items/list-payroll-items
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("payroll_item.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
