# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks account operations, reached as `client.account`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class Account < Base
      # Create account: POST /connections/{connection_id}/accounts (`account.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_number` (String): Account numbers appear in the QuickBooks chart of accounts,
      #   Account fields, and reports and graphs. If the IsUsingAccountNumber preference is false
      #   (that is, if the QuickBooks user has the account numbers Preference turned off), you can
      #   still set account numbers through the SDK, but the numbers won’t be visible in the user
      #   interface.
      # - `account_type` (one of "AccountsPayable", "AccountsReceivable", "Bank", "CostOfGoodsSold",
      #   "CreditCard", "Equity", "Expense", "FixedAsset", "Income", "LongTermLiability",
      #   "NonPosting", "OtherAsset", "OtherCurrentAsset", "OtherCurrentLiability", "OtherExpense",
      #   "OtherIncome", required): The type of QuickBooks account. You can’t create or modify a
      #   non-posting account through the SDK, because QuickBooks creates these accounts behind the
      #   scenes. This means that you can’t send an AccountAdd request with an `account_type` of
      #   NonPosting.
      # - `bank_number` (String): The bank account number or an identifying note about the account.
      #   If a `bank_number` exists in a QuickBooks company file, it will only be returned to
      #   applications that have been granted permission to access sensitive data and that are using
      #   SDK v2.0 or greater.
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
      # - `desc` (String): A descriptive text field.
      # - `detail_account_type` (one of "AP", "AR", "AccumulatedAdjustment",
      #   "AccumulatedAmortization", "AccumulatedAmortizationOfOtherAssets", "AccumulatedDepletion",
      #   "AccumulatedDepreciation", "AdvertisingOrPromotional", "AllowanceForBadDebts",
      #   "Amortization", "Auto", "BadDebts", "BankCharges", "Buildings", "CashOnHand",
      #   "CharitableContributions", "Checking", "CommonStock", "CostOfLabor", "CostOfLaborCOS",
      #   "CreditCard", "DepletableAssets", "Depreciation", "DevelopmentCosts",
      #   "DiscountsOrRefundsGiven", "DividendIncome", "DuesAndSubscriptions",
      #   "EmployeeCashAdvances", "Entertainment", "EntertainmentMeals", "EquipmentRental",
      #   "EquipmentRentalCOS", "FederalIncomeTaxPayable", "FurnitureAndFixtures", "Goodwill",
      #   "Insurance", "InsurancePayable", "IntangibleAssets", "InterestEarned", "InterestPaid",
      #   "Inventory", "InvestmentMortgageOrRealEstateLoans", "InvestmentOther",
      #   "InvestmentTaxExemptSecurities", "InvestmentUSGovObligations", "Land", "LeaseBuyout",
      #   "LeaseholdImprovements", "LegalAndProfessionalFees", "Licenses", "LineOfCredit",
      #   "LoanPayable", "LoansToOfficers", "LoansToOthers", "LoansToStockholders",
      #   "MachineryAndEquipment", "MoneyMarket", "NonProfitIncome", "NotesPayable",
      #   "OfficeOrGeneralAdministrativeExpenses", "OpeningBalanceEquity", "OrganizationalCosts",
      #   "OtherCostsOfServiceCOS", "OtherCurrentAssets", "OtherCurrentLiab", "OtherFixedAssets",
      #   "OtherInvestmentIncome", "OtherLongTermAssets", "OtherLongTermLiab", "OtherMiscExpense",
      #   "OtherMiscIncome", "OtherMiscServiceCost", "OtherPrimaryIncome", "OwnersEquity",
      #   "PaidInCapitalOrSurplus", "PartnerContributions", "PartnerDistributions",
      #   "PartnersEquity", "PayrollClearing", "PayrollExpenses", "PayrollTaxPayable",
      #   "PenaltiesAndSettlements", "PreferredStock", "PrepaidExpenses", "PrepaidExpensesPayable",
      #   "PromotionalMeals", "RentOrLeaseOfBuildings", "RentsHeldInTrust", "RentsInTrustLiab",
      #   "RepairAndMaintenance", "Retainage", "RetainedEarnings", "SalesOfProductIncome",
      #   "SalesTaxPayable", "Savings", "SecurityDeposits", "ServiceOrFeeIncome",
      #   "ShareholderNotesPayable", "ShippingFreightAndDelivery", "ShippingFreightAndDeliveryCOS",
      #   "StateOrLocalIncomeTaxPayable", "SuppliesAndMaterials", "SuppliesAndMaterialsCOGS",
      #   "TaxExemptInterest", "TaxesPaid", "Travel", "TravelMeals", "TreasuryStock",
      #   "TrustAccounts", "TrustAccountsLiab", "UndepositedFunds", "Utilities", "Vehicles")
      # - `include_ret_element` (Array<one of "AccountNumber", "AccountType", "Balance",
      #   "BankNumber", "CashFlowClassification", "CurrencyRef", "DataExtRet", "Desc",
      #   "DetailAccountType", "EditSequence", "ExternalGUID", "FullName", "IsActive",
      #   "IsTaxAccount", "LastCheckNumber", "ListID", "Name", "OwnerID", "ParentRef",
      #   "SalesTaxCodeRef", "SpecialAccountType", "Sublevel", "TaxLineInfoRet", "TimeCreated",
      #   "TimeModified", "TotalBalance", "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `name` (String, required): Name is the case-insensitive short name of a list object
      #   (without ancestors). It must be unique within its hierarchy scope. Hierarchical lists can
      #   reuse the same Name in different branches because `full_name` remains distinct.
      # - `open_balance` (Numeric): The amount of money in, or the value of, this account as of
      #   `open_balance_date`. On a bank statement, the amount of money in the account at the
      #   beginning of the statement period.
      # - `open_balance_date` (String): The date when an opening balance was entered for this
      #   account.
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
      # - `tax_line_id` (Integer): An internal representation of the tax line associated with this
      #   account.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/accounts/create-account
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("account.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List accounts: GET /connections/{connection_id}/accounts (`account.query`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the query string:
      # - `account_type` (Array<one of "AccountsPayable", "AccountsReceivable", "Bank",
      #   "CostOfGoodsSold", "CreditCard", "Equity", "Expense", "FixedAsset", "Income",
      #   "LongTermLiability", "NonPosting", "OtherAsset", "OtherCurrentAsset",
      #   "OtherCurrentLiability", "OtherExpense", "OtherIncome">): The type of QuickBooks account.
      #   You can’t create or modify a non-posting account through the SDK, because QuickBooks
      #   creates these accounts behind the scenes. This means that you can’t send an AccountAdd
      #   request with an `account_type` of NonPosting. Choose at most one of: `list_id`, or
      #   `full_name`, or the set (`account_type`, `active_status`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `active_status` (one of "ActiveOnly", "All", "InactiveOnly"): Used in filters to select
      #   list objects based on whether or not they are currently enabled for use by QuickBooks. The
      #   default value is asActiveOnly, which selects only list objects that are active. Choose at
      #   most one of: `list_id`, or `full_name`, or the set (`account_type`, `active_status`,
      #   `currency_filter`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `currency_filter` (Hash): Filters by the specified currency. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`account_type`, `active_status`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
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
      #   `full_name`, or the set (`account_type`, `active_status`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #   list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #   example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`account_type`, `active_status`,
      #   `currency_filter`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `include_ret_element` (Array<one of "AccountNumber", "AccountType", "Balance",
      #   "BankNumber", "CashFlowClassification", "CurrencyRef", "DataExtRet", "Desc",
      #   "DetailAccountType", "EditSequence", "FullName", "IsActive", "IsTaxAccount",
      #   "LastCheckNumber", "ListID", "Name", "ParentRef", "SalesTaxCodeRef", "SpecialAccountType",
      #   "Sublevel", "TaxLineInfoRet", "TimeCreated", "TimeModified", "TotalBalance">)
      # - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`. Choose at most
      #   one of: `list_id`, or `full_name`, or the set (`account_type`, `active_status`,
      #   `currency_filter`, `from_modified_date`, `max_returned`, `name_filter`,
      #   `name_range_filter`, `to_modified_date`). Members of a set combine with each other, not
      #   with the other choices.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. QuickBooks
      #   doesn't page this query: at most this many records come back, in one answer, with no sign
      #   of whether more matched. Leave it out for every match, in one answer; one over 4 MB as the
      #   Web Connector sends it, about 3 MB of qbXML isn't kept (`error_type`
      #   `response_too_large`), so narrow a large one with its filters. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`account_type`, `active_status`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      # - `meta_data` (one of "MetaDataAndResponseData", "MetaDataOnly", "NoMetaData"): Use the
      #   `meta_data` attribute to control whether query responses include counts. Options are
      #   NoMetaData (default), MetaDataOnly (count only), and MetaDataAndResponseData (count plus
      #   objects). Counts are approximate and may vary slightly if records are created or deleted
      #   during processing.
      # - `name_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`account_type`, `active_status`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `name` (String, required): The string to match.
      # - `name_range_filter` (Hash): Filters according to the object’s Name. Choose at most one of:
      #   `list_id`, or `full_name`, or the set (`account_type`, `active_status`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
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
      #   `list_id`, or `full_name`, or the set (`account_type`, `active_status`, `currency_filter`,
      #   `from_modified_date`, `max_returned`, `name_filter`, `name_range_filter`,
      #   `to_modified_date`). Members of a set combine with each other, not with the other choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/accounts/list-accounts
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("account.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update account: PUT /connections/{connection_id}/accounts (`account.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `account_number` (String): Account numbers appear in the QuickBooks chart of accounts,
      #   Account fields, and reports and graphs. If the IsUsingAccountNumber preference is false
      #   (that is, if the QuickBooks user has the account numbers Preference turned off), you can
      #   still set account numbers through the SDK, but the numbers won’t be visible in the user
      #   interface.
      # - `account_type` (one of "AccountsPayable", "AccountsReceivable", "Bank", "CostOfGoodsSold",
      #   "CreditCard", "Equity", "Expense", "FixedAsset", "Income", "LongTermLiability",
      #   "NonPosting", "OtherAsset", "OtherCurrentAsset", "OtherCurrentLiability", "OtherExpense",
      #   "OtherIncome"): The type of QuickBooks account. You can’t create or modify a non-posting
      #   account through the SDK, because QuickBooks creates these accounts behind the scenes. This
      #   means that you can’t send an AccountAdd request with an `account_type` of NonPosting.
      # - `bank_number` (String): The bank account number or an identifying note about the account.
      #   If a `bank_number` exists in a QuickBooks company file, it will only be returned to
      #   applications that have been granted permission to access sensitive data and that are using
      #   SDK v2.0 or greater.
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
      # - `desc` (String): A descriptive text field.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `include_ret_element` (Array<one of "AccountNumber", "AccountType", "Balance",
      #   "BankNumber", "CashFlowClassification", "CurrencyRef", "DataExtRet", "Desc",
      #   "DetailAccountType", "EditSequence", "ExternalGUID", "FullName", "IsActive",
      #   "IsTaxAccount", "LastCheckNumber", "ListID", "Name", "OwnerID", "ParentRef",
      #   "SalesTaxCodeRef", "SpecialAccountType", "Sublevel", "TaxLineInfoRet", "TimeCreated",
      #   "TimeModified", "TotalBalance", "TxnID", "TxnNumber">)
      # - `is_active` (Boolean): If `is_active` is true, this object is currently enabled for use by
      #   QuickBooks. The default value is true.
      # - `list_id` (String, required): `list_id` and `full_name` both identify a list object.
      #   QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #   within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #   supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `name` (String): Name is the case-insensitive short name of a list object (without
      #   ancestors). It must be unique within its hierarchy scope. Hierarchical lists can reuse the
      #   same Name in different branches because `full_name` remains distinct.
      # - `open_balance` (Numeric): The amount of money in, or the value of, this account as of
      #   `open_balance_date`. On a bank statement, the amount of money in the account at the
      #   beginning of the statement period.
      # - `open_balance_date` (String): The date when an opening balance was entered for this
      #   account.
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
      # - `tax_line_id` (Integer): An internal representation of the tax line associated with this
      #   account.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/accounts/update-account
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("account.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
