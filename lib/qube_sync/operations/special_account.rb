# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks special account operations, reached as `client.special_account`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class SpecialAccount < Base
      # Create special account: POST /connections/{connection_id}/special-accounts
      # (`special_account.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
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
      # - `include_ret_element` (Array<one of "AccountNumber", "AccountType", "Balance",
      #   "BankNumber", "CashFlowClassification", "CurrencyRef", "DataExtRet", "Desc",
      #   "DetailAccountType", "EditSequence", "ExternalGUID", "FullName", "IsActive",
      #   "IsTaxAccount", "LastCheckNumber", "ListID", "Name", "OwnerID", "ParentRef",
      #   "SalesTaxCodeRef", "SpecialAccountType", "Sublevel", "TaxLineInfoRet", "TimeCreated",
      #   "TimeModified", "TotalBalance", "TxnID", "TxnNumber">)
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `special_account_type` (one of "AccountsPayable", "AccountsReceivable",
      #   "CondenseItemAdjustmentExpenses", "CostOfGoodsSold", "DirectDepositLiabilities",
      #   "Estimates", "ExchangeGainLoss", "InventoryAssets", "ItemReceiptAccount",
      #   "OpeningBalanceEquity", "PayrollExpenses", "PayrollLiabilities", "PettyCash",
      #   "PurchaseOrders", "ReconciliationDifferences", "RetainedEarnings", "SalesOrders",
      #   "SalesTaxPayable", "UncategorizedExpenses", "UncategorizedIncome", "UndepositedFunds",
      #   required): If `special_account_type` returns a value, then QuickBooks automatically
      #   created this account when it was needed. Some special accounts can’t be overridden,
      #   because QuickBooks uses them exclusively for special purposes.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/special-accounts/create-special-account
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("special_account.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
