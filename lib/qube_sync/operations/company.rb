# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks company operations, reached as `client.company`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Company < Base
      # List companies: GET /connections/{connection_id}/companies (`company.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `include_ret_element` (Array<one of "AccountantCopy", "Address", "AddressBlock",
      #   "CompanyAddressBlockForCustomer", "CompanyAddressForCustomer", "CompanyEmailForCustomer",
      #   "CompanyName", "CompanyType", "CompanyWebSite", "DataExtRet", "EIN", "Email", "Fax",
      #   "FirstMonthFiscalYear", "FirstMonthIncomeTaxYear", "IsSampleCompany", "LegalAddress",
      #   "LegalCompanyName", "Phone", "SSN", "SubscribedServices", "TaxForm">)
      # - `owner_id` (Array<String>): `owner_id` identifies who owns the data extension. Use 0 for
      #   QuickBooks custom fields that appear in the UI, or use a GUID for private extensions owned
      #   by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/companies/list-companies
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("company.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
