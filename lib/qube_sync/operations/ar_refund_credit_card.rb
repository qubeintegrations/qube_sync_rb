# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks ar refund credit card operations, reached as `client.ar_refund_credit_card`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class ArRefundCreditCard < Base
      # Create ar refund credit card: POST /connections/{connection_id}/ar-refund-credit-cards
      # (`ar_refund_credit_card.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `address` (Hash): If an address request fails, some combination of address fields might be
      #   too long. In a Check, BillPaymentCheck, or SalesTaxPaymentCheck message, Address is the
      #   address that will print on the check.
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
      # - `ar_account_ref` (Hash): `ar_account_ref` points to an Accounts Receivable account. If
      #   both `full_name` and `list_id` are provided, `full_name` is ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `credit_card_txn_info` (Hash): Contains data from the credit card transaction used in the
      #   payment. This data originates from a previous qbmsXML credit card transaction. The data
      #   following the element `credit_card_txn_input_info`” data is the data from the original
      #   qbmsXML request. The “`credit_card_txn_result_info`” is the data from the original qbmsXML
      #   response.
      #   - `credit_card_txn_input_info` (Hash, required): This contains data originally supplied in
      #     the QBMS transaction request. This information block shouldn’t be used in CreditMemo
      #     requests for QuickBooks 2007 and new versions. Instead, use the ARRefundCreditCard
      #     request.
      #     - `commercial_card_code` (String): This optional field is used only for Visa and Master
      #       Card commercial cards. There are three types of these cards: purchase, corporate, and
      #       business. Normally, special lower transaction fee rates apply when these cards are
      #       used and this field is filled out. If this field is left blank, then the usual (and
      #       higher) discount rate applies.
      #     - `credit_card_address` (String): The address associated with this credit card.
      #     - `credit_card_number` (String, required): Credit-card number for this customer or this
      #       payment. Beginning with qbXML spec 6.0 and QuickBooks 2007, you must mask the credit
      #       card number with lower case “x” and no dashes. For example, xxxxxxxxxxxx1234.
      #     - `credit_card_postal_code` (String): The postal code associated with the address for
      #       this credit card.
      #     - `credit_card_txn_type` (one of "Authorization", "Capture", "Charge", "Refund",
      #       "VoiceAuthorization"): Indicates the QBMS transaction from which the current
      #       transaction data originated, for example, Charge, Authorization, Capture, Refund,
      #       VoiceAuthorization, or Void.
      #     - `expiration_month` (Integer, required): The month when the credit card expires.
      #     - `expiration_year` (Integer, required): The year when the credit card expires.
      #     - `name_on_card` (String, required): The name on the customer’s credit card.
      #     - `transaction_mode` (one of "CardNotPresent", "CardPresent"): Indicates whether this
      #       transaction came from a card swipe (tmCardPresent) or not (tmCardNotPresent).
      #   - `credit_card_txn_result_info` (Hash, required): This contains data returned in the QBMS
      #     transaction response. This information block shouldn’t be used in CreditMemo requests
      #     for QuickBooks 2007 and new versions. Instead, use the ARRefundCreditCard request.
      #     - `authorization_code` (String): The authorization code is returned from the credit card
      #       processor to indicate that the charge will be paid by the card issuer. In a voice
      #       authorization request (CustomerCreditCardVoiceAuthRq), the authorization code is
      #       supplied by the card issuer over the telephone.
      #     - `avs_street` (one of "Fail", "NotAvailable", "Pass"): This field contains the value
      #       avssPass if the street address supplied in the transaction request matches the
      #       customer’s address on file at the card issuer. It contains the value avssFail if there
      #       isn’t a match, or avssNotAvailable if the card issuer doesn’t support AVS. Note: This
      #       field was required in qbXML 4.1, but is optional in qbXML 5.0 and later.
      #     - `avs_zip` (one of "Fail", "NotAvailable", "Pass"): This field contains the value
      #       avszPass if the customer postal ZIP code supplied in the transaction request matches
      #       the customer’s postal code recognized at the card issuer. It contains the value
      #       avszFail if there isn’t a match, or avszNotAvailable if the card issuer doesn’t
      #       support AVS. Note: This field was required in qbXML 4.1, but is optional in qbXML 5.0
      #       and later.
      #     - `card_security_code_match` (one of "Fail", "NotAvailable", "Pass"): This field
      #       contains the value Pass if the card security code supplied in the transaction request
      #       matches the card security code recognized for that credit card number at the card
      #       issuer. It contains the value Fail if there isn’t a match.
      #     - `client_trans_id` (String): This value is returned from QBMS transactions for future
      #       use by the QuickBooks Reconciliation feature.
      #     - `credit_card_trans_id` (String, required): This transaction ID is returned from the
      #       credit card processor. You should save this value for any possible QBMS SDK
      #       transaction requests that need it, for example, CustomerCreditCardTxnVoidRq, or
      #       CustomerCreditCardCaptureRq.
      #     - `merchant_account_number` (String, required): This is the QBMS account number of the
      #       merchant who is running the transaction using the customer’s credit card. It is
      #       returned from the transaction request and should be stored for subsequent
      #       transactions, such as using it in the QB SDK SalesReceiptAdd, ReceivePaymentAdd,
      #       ARRefundCreditCard requests to save the transaction data in QuickBooks.
      #     - `payment_grouping_code` (Integer): Internal code needed for the QuickBooks
      #       reconciliation feature, if integrating with QuickBooks. This value is returned in the
      #       QBMS response to a QBMS transaction request, and must be subsequently supplied by your
      #       application in the QB SDK ReceivePaymentAdd or SalesReceiptAdd request.
      #     - `payment_status` (one of "Completed", "Unknown", required): Indicates payment
      #       processing status as known by QuickBooks/QBMS integration state. `psCompleted`
      #       indicates confirmed success; `psUnknown` indicates status could not be definitively
      #       confirmed.
      #     - `recon_batch_id` (String): This value is returned by QBMS from the transaction
      #       request, and is used internally by the QuickBooks/QBMS Recon (reconcile) feature. You
      #       should save this value without modification and include it in the QB SDK
      #       SalesReceiptAdd or ReceivePaymentAdd requests if you want to save the transaction data
      #       in QuickBooks.
      #     - `result_code` (Integer, required): This contains the status code returned in the
      #       original QBMS transaction response.
      #     - `result_message` (String, required): This contains the status message returned in the
      #       original QBMS transaction response.
      #     - `txn_authorization_stamp` (Integer): This value is used to support the credit card
      #       transaction Reconcile feature within QuickBooks.
      #     - `txn_authorization_time` (String, required): Timestamp indicating the time in which
      #       the card processor authorized the transaction.
      # - `customer_ref` (Hash, required): `customer_ref` identifies a customer or customer job. If
      #   both `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
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
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `include_ret_element` (Array<one of "ARAccountRef", "Address", "AddressBlock",
      #   "CreditCardTxnInfo", "CurrencyRef", "CustomerRef", "DataExtRet", "EditSequence",
      #   "ExchangeRate", "ExternalGUID", "ListID", "Memo", "OwnerID", "PaymentMethodRef",
      #   "RefNumber", "RefundAppliedToTxnRet", "RefundFromAccountRef", "TimeCreated",
      #   "TimeModified", "TotalAmount", "TotalAmountInHomeCurrency", "TxnDate", "TxnID",
      #   "TxnNumber">)
      # - `memo` (String): Additional information.
      # - `payment_method_ref` (Hash): `payment_method_ref` identifies how a payment is made (for
      #   example, cash, check, or card type). If both `full_name` and `list_id` are provided,
      #   `full_name` is ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     type, not globally across all lists. If both `full_name` and `list_id` are supplied in a
      #     request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `refund_applied_to_txn_add` (Array<Hash>, required)
      #   - `refund_amount` (Numeric, required): Specifies the amount to be taken from the credit
      #     transaction you are linking via this aggregate. The amount specified in this aggregate
      #     can’t exceed the amount of the credit transaction you are linking. If you supply an
      #     amount that exceeds, you’ll get a runtime error.
      #   - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #     transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #     transaction-specific and should not be reused across unrelated transaction types.
      # - `refund_from_account_ref` (Hash): In an ARRefundCreditCardAdd, the account which is the
      #   source of funds for the credit card refund. Normally this is Undeposited Funds. However,
      #   you can specify another account if you wish. If you specify nothing here, Undeposited
      #   Funds is used by default.
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
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/ar-refund-credit-cards/create-ar-refund-credit-card
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("ar_refund_credit_card.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List ar refund credit cards: GET /connections/{connection_id}/ar-refund-credit-cards
      # (`ar_refund_credit_card.query`).
      #
      # QuickBooks answers in pages: one webhook per page, each with its `page`, the last with
      # `iteration_state` `done`.
      #
      # Params, sent as the query string:
      # - `account_filter` (Hash): Filters according to the account name or `list_id`. If the “Use
      #   account numbers” preference is enabled in the QuickBooks company file, you can specify an
      #   account number (instead of an account name) for `full_name` and get the account you’re
      #   looking for. But if numbers have been used as account names, confusion could arise. Choose
      #   at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set
      #   (`account_filter`, `currency_filter`, `entity_filter`, `max_returned`,
      #   `modified_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      #   Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #   `full_name_with_children`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `currency_filter` (Hash): Filters by the specified currency. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      # - `entity_filter` (Hash): An entity refers to a person on the QuickBooks Customer list,
      #   Vendor list, Employee list, or Other Names list. You can use an EntityQuery request to get
      #   information about all the entities that are set up in the QuickBooks file. In an
      #   ARRefundCreditCard query, this must be a customer/customer job. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   Give at most one of: `list_id`, or `full_name`, or `list_id_with_children`, or
      #   `full_name_with_children`.
      #   - `full_name` (Array<String>): `full_name` (along with `list_id`) is a way to identify a
      #     list object. The `full_name` is the name prefixed by the names of each ancestor, for
      #     example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `full_name_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants. For names that don’t have children,
      #     `full_name_with_children` is exactly the same as `full_name`.
      #   - `list_id` (Array<String>): `list_id` and `full_name` both identify a list object.
      #     QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #     within a list type, not globally across all lists. If both `full_name` and `list_id` are
      #     supplied in a request, QuickBooks uses `list_id` and ignores `full_name`.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `include_line_items` (Boolean): This filter allows you to omit line items from a query
      #   response to get a smaller result. The default value is false, so line items are omitted by
      #   default. Set `include_line_items` to true to include line items in the response if you
      #   don’t mind getting a larger result.
      # - `include_ret_element` (Array<one of "ARAccountRef", "Address", "AddressBlock",
      #   "CreditCardTxnInfo", "CurrencyRef", "CustomerRef", "DataExtRet", "EditSequence",
      #   "ExchangeRate", "ExternalGUID", "Memo", "PaymentMethodRef", "RefNumber",
      #   "RefundAppliedToTxnRet", "RefundFromAccountRef", "TimeCreated", "TimeModified",
      #   "TotalAmount", "TotalAmountInHomeCurrency", "TxnDate", "TxnID", "TxnNumber">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records (25 with `include_line_items`); send `iterator=true`
      #   with `max_returned` for another size. Off when you send `iterator=false` (every match in
      #   one answer) or `max_returned` alone (at most that many, in one answer). It pages a
      #   filtered query only: with `ref_number`, `ref_number_case_sensitive` or `txn_id` every
      #   match comes back in one answer, so leave `iterator` out.
      # - `max_returned` (Integer): Limits the number of objects that a query returns. (To get a
      #   count of how many objects could possibly be returned, use the `meta_data` query
      #   attribute.) If you include a `max_returned` value, it must be at least 1. The page size,
      #   with `iterator=true`. Sent without `iterator`, or with `iterator=false`, it's a cap
      #   instead: at most this many records come back, in one answer, and QuickBooks doesn't say
      #   whether more matched. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
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
      #   qbXML version 1.0 or 1.1. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      #   - `from_modified_date` (String): Filters results to objects modified on or after this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to 00:00:00.
      #   - `to_modified_date` (String): Filters results to objects modified on or before this
      #     timestamp. QuickBooks Desktop accepts 1970-01-01 through 2038-01-19T03:14:07. If only a
      #     date is provided, time defaults to end-of-day (23:59:59).
      # - `owner_id` (Array<String>): `owner_id` identifies who owns the data extension. Use 0 for
      #   QuickBooks custom fields that appear in the UI, or use a GUID for private extensions owned
      #   by an app. Keep private GUIDs confidential unless you intentionally share extensions
      #   across apps. If you do share them, both apps must use the same `owner_id` and
      #   `data_ext_name`, because that pair uniquely identifies the extension.
      # - `ref_number` (Array<String>): `ref_number` is a user-managed transaction reference (for
      #   example, a check number). It can be edited and is not guaranteed to be globally unique.
      #   Some transaction types auto-populate `ref_number` when omitted, based on QuickBooks
      #   preferences and numbering state. Choose at most one of: `txn_id`, or `ref_number`, or
      #   `ref_number_case_sensitive`, or the set (`account_filter`, `currency_filter`,
      #   `entity_filter`, `max_returned`, `modified_date_range_filter`, `ref_number_filter`,
      #   `ref_number_range_filter`, `txn_date_range_filter`). Members of a set combine with each
      #   other, not with the other choices.
      # - `ref_number_case_sensitive` (Array<String>): Choose at most one of: `txn_id`, or
      #   `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      # - `ref_number_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `match_criterion` (one of "Contains", "EndsWith", "StartsWith", required): The criterion
      #     to match.
      #   - `ref_number` (String, required): `ref_number` is a user-managed transaction reference
      #     (for example, a check number). It can be edited and is not guaranteed to be globally
      #     unique. Some transaction types auto-populate `ref_number` when omitted, based on
      #     QuickBooks preferences and numbering state.
      # - `ref_number_range_filter` (Hash): Filters by `ref_number` range. Numeric-only bounds are
      #   compared numerically; otherwise comparison is lexicographic. Choose at most one of:
      #   `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set (`account_filter`,
      #   `currency_filter`, `entity_filter`, `max_returned`, `modified_date_range_filter`,
      #   `ref_number_filter`, `ref_number_range_filter`, `txn_date_range_filter`). Members of a set
      #   combine with each other, not with the other choices.
      #   - `from_ref_number` (String): The first `ref_number` in the search range. If
      #     `from_ref_number` is omitted, the range will begin with first number on the list.
      #   - `to_ref_number` (String): The final `ref_number` in the search range. If `to_ref_number`
      #     is omitted, the range will end with last number on the list.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `txn_date_range_filter` (Hash): Filters according to the original transaction dates.
      #   Choose at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the
      #   set (`account_filter`, `currency_filter`, `entity_filter`, `max_returned`,
      #   `modified_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
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
      #   at most one of: `txn_id`, or `ref_number`, or `ref_number_case_sensitive`, or the set
      #   (`account_filter`, `currency_filter`, `entity_filter`, `max_returned`,
      #   `modified_date_range_filter`, `ref_number_filter`, `ref_number_range_filter`,
      #   `txn_date_range_filter`). Members of a set combine with each other, not with the other
      #   choices.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/ar-refund-credit-cards/list-ar-refund-credit-cards
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("ar_refund_credit_card.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
