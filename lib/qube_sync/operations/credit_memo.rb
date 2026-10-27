# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  module Operations
    # QuickBooks credit memo operations, reached as `client.credit_memo`. Each queues a request and
    # returns it (the response's `data`); the answer comes to `webhook_url`.
    class CreditMemo < Base
      # Create credit memo: POST /connections/{connection_id}/credit-memos (`credit_memo.create`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `ar_account_ref` (Hash): `ar_account_ref` points to an Accounts Receivable account. If
      #   both `full_name` and `list_id` are provided, `full_name` is ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `bill_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
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
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `credit_memo_line_add` (Array<Hash>): Represents one line in the credit memo. Compare with
      #   CreditMemoGroupLine, which represents a previously defined group of lines in the credit
      #   memo. At least one entry is required across `credit_memo_line_add` and
      #   `credit_memo_line_group_add`; they combine, any number of each. QuickBooks receives them
      #   in that order: every `credit_memo_line_add`, then every `credit_memo_line_group_add`.
      #   - `amount` (Numeric): A monetary amount.
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
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `credit_card_txn_info` (Hash): Contains data from the credit card transaction used in
      #     the payment. This data originates from a previous qbmsXML credit card transaction. The
      #     data following the element `credit_card_txn_input_info`” data is the data from the
      #     original qbmsXML request. The “`credit_card_txn_result_info`” is the data from the
      #     original qbmsXML response.
      #     - `credit_card_txn_input_info` (Hash, required): This contains data originally supplied
      #       in the QBMS transaction request. This information block shouldn’t be used in
      #       CreditMemo requests for QuickBooks 2007 and new versions. Instead, use the
      #       ARRefundCreditCard request.
      #       - `commercial_card_code` (String): This optional field is used only for Visa and
      #         Master Card commercial cards. There are three types of these cards: purchase,
      #         corporate, and business. Normally, special lower transaction fee rates apply when
      #         these cards are used and this field is filled out. If this field is left blank, then
      #         the usual (and higher) discount rate applies.
      #       - `credit_card_address` (String): The address associated with this credit card.
      #       - `credit_card_number` (String, required): Credit-card number for this customer or
      #         this payment. Beginning with qbXML spec 6.0 and QuickBooks 2007, you must mask the
      #         credit card number with lower case “x” and no dashes. For example, xxxxxxxxxxxx1234.
      #       - `credit_card_postal_code` (String): The postal code associated with the address for
      #         this credit card.
      #       - `credit_card_txn_type` (one of "Authorization", "Capture", "Charge", "Refund",
      #         "VoiceAuthorization"): Indicates the QBMS transaction from which the current
      #         transaction data originated, for example, Charge, Authorization, Capture, Refund,
      #         VoiceAuthorization, or Void.
      #       - `expiration_month` (Integer, required): The month when the credit card expires.
      #       - `expiration_year` (Integer, required): The year when the credit card expires.
      #       - `name_on_card` (String, required): The name on the customer’s credit card.
      #       - `transaction_mode` (one of "CardNotPresent", "CardPresent"): Indicates whether this
      #         transaction came from a card swipe (tmCardPresent) or not (tmCardNotPresent).
      #     - `credit_card_txn_result_info` (Hash, required): This contains data returned in the
      #       QBMS transaction response. This information block shouldn’t be used in CreditMemo
      #       requests for QuickBooks 2007 and new versions. Instead, use the ARRefundCreditCard
      #       request.
      #       - `authorization_code` (String): The authorization code is returned from the credit
      #         card processor to indicate that the charge will be paid by the card issuer. In a
      #         voice authorization request (CustomerCreditCardVoiceAuthRq), the authorization code
      #         is supplied by the card issuer over the telephone.
      #       - `avs_street` (one of "Fail", "NotAvailable", "Pass"): This field contains the value
      #         avssPass if the street address supplied in the transaction request matches the
      #         customer’s address on file at the card issuer. It contains the value avssFail if
      #         there isn’t a match, or avssNotAvailable if the card issuer doesn’t support AVS.
      #         Note: This field was required in qbXML 4.1, but is optional in qbXML 5.0 and later.
      #       - `avs_zip` (one of "Fail", "NotAvailable", "Pass"): This field contains the value
      #         avszPass if the customer postal ZIP code supplied in the transaction request matches
      #         the customer’s postal code recognized at the card issuer. It contains the value
      #         avszFail if there isn’t a match, or avszNotAvailable if the card issuer doesn’t
      #         support AVS. Note: This field was required in qbXML 4.1, but is optional in qbXML
      #         5.0 and later.
      #       - `card_security_code_match` (one of "Fail", "NotAvailable", "Pass"): This field
      #         contains the value Pass if the card security code supplied in the transaction
      #         request matches the card security code recognized for that credit card number at the
      #         card issuer. It contains the value Fail if there isn’t a match.
      #       - `client_trans_id` (String): This value is returned from QBMS transactions for future
      #         use by the QuickBooks Reconciliation feature.
      #       - `credit_card_trans_id` (String, required): This transaction ID is returned from the
      #         credit card processor. You should save this value for any possible QBMS SDK
      #         transaction requests that need it, for example, CustomerCreditCardTxnVoidRq, or
      #         CustomerCreditCardCaptureRq.
      #       - `merchant_account_number` (String, required): This is the QBMS account number of the
      #         merchant who is running the transaction using the customer’s credit card. It is
      #         returned from the transaction request and should be stored for subsequent
      #         transactions, such as using it in the QB SDK SalesReceiptAdd, ReceivePaymentAdd,
      #         ARRefundCreditCard requests to save the transaction data in QuickBooks.
      #       - `payment_grouping_code` (Integer): Internal code needed for the QuickBooks
      #         reconciliation feature, if integrating with QuickBooks. This value is returned in
      #         the QBMS response to a QBMS transaction request, and must be subsequently supplied
      #         by your application in the QB SDK ReceivePaymentAdd or SalesReceiptAdd request.
      #       - `payment_status` (one of "Completed", "Unknown", required): Indicates payment
      #         processing status as known by QuickBooks/QBMS integration state. `psCompleted`
      #         indicates confirmed success; `psUnknown` indicates status could not be definitively
      #         confirmed.
      #       - `recon_batch_id` (String): This value is returned by QBMS from the transaction
      #         request, and is used internally by the QuickBooks/QBMS Recon (reconcile) feature.
      #         You should save this value without modification and include it in the QB SDK
      #         SalesReceiptAdd or ReceivePaymentAdd requests if you want to save the transaction
      #         data in QuickBooks.
      #       - `result_code` (Integer, required): This contains the status code returned in the
      #         original QBMS transaction response.
      #       - `result_message` (String, required): This contains the status message returned in
      #         the original QBMS transaction response.
      #       - `txn_authorization_stamp` (Integer): This value is used to support the credit card
      #         transaction Reconcile feature within QuickBooks.
      #       - `txn_authorization_time` (String, required): Timestamp indicating the time in which
      #         the card processor authorized the transaction.
      #   - `data_ext` (Array<Hash>)
      #     - `data_ext_name` (String, required): The name of the data extension. If this is a
      #       custom field, `data_ext_name` will be visible as a label in the QuickBooks user
      #       interface. Also because `owner_id` and `data_ext_name` together make the data
      #       extension unique, and because custom fields all have the same `owner_id` of zero, the
      #       `data_ext_name` must be a unique value among existing custom fields.
      #     - `data_ext_value` (String, required): The data in this field. The maximum length of
      #       `data_ext_value` will depend on the `data_ext_type` of this data extension. For
      #       example, if `data_ext_type` is STR255TYPE, the maximum length of `data_ext_value` is
      #       255 characters. If `data_ext_type` is STR1024TYPE, the maximum size of
      #       `data_ext_value` is 1KB.
      #     - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use
      #       0 for QuickBooks custom fields that appear in the UI, or use a GUID for private
      #       extensions owned by an app. Keep private GUIDs confidential unless you intentionally
      #       share extensions across apps. If you do share them, both apps must use the same
      #       `owner_id` and `data_ext_name`, because that pair uniquely identifies the extension.
      #   - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #     or `txn_line_id` so later requests can reference it with `useMacro`. This feature
      #     requires SDK 2.0+.
      #   - `desc` (String): A descriptive text field.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `inventory_site_ref` (Hash): Site where inventory is located.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `is_taxable` (Boolean)
      #   - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #     depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #     sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #     BillingRateAdd requires a service item. If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #     `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `price_level_ref` (Hash): Price levels let you apply custom pricing rules for selected
      #     customers. Once assigned, QuickBooks uses those prices automatically on supported sales
      #     forms unless explicitly overridden. Choose at most one of: `rate`, or `rate_percent`, or
      #     `price_level_ref`.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `rate` (Numeric): If you specify both Rate and Amount in a request, the Rate you provide
      #     will be ignored, and you will receive a warning. If you specify both Quantity and Amount
      #     in an Add request, QuickBooks will use them to calculate Rate. (Rate, Amount, and
      #     Quantity can’t be cleared.) Choose at most one of: `rate`, or `rate_percent`, or
      #     `price_level_ref`.
      #   - `rate_percent` (Numeric): Indicates the price of something as a percent. Choose at most
      #     one of: `rate`, or `rate_percent`, or `price_level_ref`.
      #   - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used for
      #     an item or customer context. QuickBooks includes default TAX and NON codes, and a code
      #     can be deleted only when nothing references it. If sales tax is disabled, QuickBooks
      #     assigns the default non-taxable code. If both `full_name` and `list_id` are provided in
      #     `sales_tax_code_ref`, `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #     service for the customer.
      #   - `tax_amount` (Numeric)
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `credit_memo_line_group_add` (Array<Hash>): Represents a previously defined group of lines
      #   in the credit memo. Compare with CreditMemoLine, which represents just one line in the
      #   credit memo. At least one entry is required across `credit_memo_line_add` and
      #   `credit_memo_line_group_add`; they combine, any number of each. QuickBooks receives them
      #   in that order: every `credit_memo_line_add`, then every `credit_memo_line_group_add`.
      #   - `data_ext` (Array<Hash>)
      #     - `data_ext_name` (String, required): The name of the data extension. If this is a
      #       custom field, `data_ext_name` will be visible as a label in the QuickBooks user
      #       interface. Also because `owner_id` and `data_ext_name` together make the data
      #       extension unique, and because custom fields all have the same `owner_id` of zero, the
      #       `data_ext_name` must be a unique value among existing custom fields.
      #     - `data_ext_value` (String, required): The data in this field. The maximum length of
      #       `data_ext_value` will depend on the `data_ext_type` of this data extension. For
      #       example, if `data_ext_type` is STR255TYPE, the maximum length of `data_ext_value` is
      #       255 characters. If `data_ext_type` is STR1024TYPE, the maximum size of
      #       `data_ext_value` is 1KB.
      #     - `owner_id` (String, required): `owner_id` identifies who owns the data extension. Use
      #       0 for QuickBooks custom fields that appear in the UI, or use a GUID for private
      #       extensions owned by an app. Keep private GUIDs confidential unless you intentionally
      #       share extensions across apps. If you do share them, both apps must use the same
      #       `owner_id` and `data_ext_name`, because that pair uniquely identifies the extension.
      #   - `desc` (String): A descriptive text field.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `inventory_site_ref` (Hash): Site where inventory is located.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `item_group_ref` (Hash, required): ItemGroup objects represent items that are grouped
      #     together for fast entry, and an `item_group_ref` aggregate refers to one of these item
      #     groups. In a request, if an `item_group_ref` aggregate includes both `full_name` and
      #     `list_id`, `full_name` will be ignored. You can use an ItemGroupQuery request to get
      #     information about all the item groups that are set up in the QuickBooks file.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #     service for the customer.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `customer_msg_ref` (Hash): A standard message such as “Thank you for your business,” or
      #   “Please sign and return this estimate to indicate your approval.” A customer message can
      #   be included at the bottom of a form. A `customer_msg_ref` aggregate refers to one of the
      #   messages on the CustomerMsg list. In a request, if a `customer_msg_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `customer_ref` (Hash, required): `customer_ref` identifies a customer or customer job. If
      #   both `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #   ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who the
      #   time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `customer_sales_tax_code_ref` (Hash): Refers to the sales-tax code for sales related to
      #   this customer. (That is, it refers to a member of the SalesTaxCode list.) The sales-tax
      #   code indicates whether an item is taxable or non-taxable, and why. In a request, if a
      #   `customer_sales_tax_code_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `def_macro` (String): `def_macro` lets you assign a reusable name to a returned `txn_id`
      #   or `txn_line_id` so later requests can reference it with `useMacro`. This feature requires
      #   SDK 2.0+.
      # - `discount_line_add` (Hash)
      #   - `account_ref` (Hash)
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `amount` (Numeric): A monetary amount. Choose at most one of: `amount`, or
      #     `rate_percent`.
      #   - `is_taxable` (Boolean)
      #   - `rate_percent` (Numeric): Indicates the price of something as a percent. Choose at most
      #     one of: `amount`, or `rate_percent`.
      # - `due_date` (String): The date on which payment is due.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `external_guid` (String): Allows for the attachment of a user defined GUID value.
      # - `fob` (String): QuickBooks uses the term FOB, “freight on board,” to indicate the place
      #   from which the product is shipped. The FOB has no accounting implications.
      # - `include_ret_element` (Array<one of "ARAccountRef", "BillAddress", "BillAddressBlock",
      #   "ClassRef", "CreditMemoLineGroupRet", "CreditMemoLineRet", "CreditRemaining",
      #   "CreditRemainingInHomeCurrency", "CurrencyRef", "CustomerMsgRef", "CustomerRef",
      #   "CustomerSalesTaxCodeRef", "DataExtRet", "DiscountLineRet", "DueDate", "EditSequence",
      #   "ExchangeRate", "ExternalGUID", "FOB", "IsPending", "IsTaxIncluded", "IsToBeEmailed",
      #   "IsToBePrinted", "ItemSalesTaxRef", "LinkedTxn", "ListID", "Memo", "Other", "OwnerID",
      #   "PONumber", "RefNumber", "SalesRepRef", "SalesTaxLineRet", "SalesTaxPercentage",
      #   "SalesTaxTotal", "ShipAddress", "ShipAddressBlock", "ShipDate", "ShipMethodRef",
      #   "ShippingLineRet", "Subtotal", "TemplateRef", "TermsRef", "TimeCreated", "TimeModified",
      #   "TotalAmount", "TxnDate", "TxnID", "TxnNumber">)
      # - `is_pending` (Boolean): If `is_pending` is set to true, the credit memo hasn’t been
      #   completed. Within QuickBooks, you can change the `is_pending` status for a credit memo by
      #   choosing “Mark Credit Memo As Pending” or “Mark Credit Memo As Final” from the Edit menu.
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `is_to_be_emailed` (Boolean): When enabled, QuickBooks validates the customer email at
      #   runtime before sending. If no valid email is available, the request fails.
      # - `is_to_be_printed` (Boolean): If `is_to_be_printed` is true, QuickBooks queues the form
      #   for later printing. It does not print immediately; printing is still a user action in
      #   QuickBooks.
      # - `item_sales_tax_ref` (Hash): An ItemSalesTax entry represents one tax rate paid to one tax
      #   agency. Use it when a transaction needs a single tax calculation. For multi-rate
      #   scenarios, use a sales-tax group instead. If both `full_name` and `list_id` are provided
      #   for `item_sales_tax_ref`, `list_id` is used.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `memo` (String): The memo doesn’t print on the credit memo, but does appear in the account
      #   register and the customer register.
      # - `other` (String): Other, Other1, and Other2 are built-in transaction custom fields. Other
      #   is transaction-level; Other1 and Other2 are line-level. These fields are always available
      #   through the SDK and do not require DataExtDef setup. Template labels in the UI can be
      #   renamed, but SDK names remain fixed as Other, Other1, and Other2.
      # - `po_number` (String): Purchase order number.
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #   Names list within QuickBooks. Sales representative’s names and initials appear on the Rep
      #   drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on the
      #   SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both `full_name` and
      #   `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `sales_tax_line_add` (Hash)
      #   - `account_ref` (Hash)
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `amount` (Numeric): A monetary amount. Choose at most one of: `amount`, or
      #     `rate_percent`.
      #   - `rate_percent` (Numeric): Indicates the price of something as a percent. Choose at most
      #     one of: `amount`, or `rate_percent`.
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `ship_date` (String): The date when the product was, or will be, shipped.
      # - `ship_method_ref` (Hash): A shipping method, for example, standard mail or overnight
      #   delivery. A `ship_method_ref` aggregate refers to an item on the ShipMethod list. In a
      #   request, if a `ship_method_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `shipping_line_add` (Hash)
      #   - `account_ref` (Hash)
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `amount` (Numeric, required): A monetary amount.
      # - `template_ref` (Hash): QuickBooks templates specify how to print certain transactions. A
      #   template query returns the names of all templates that have been defined in QuickBooks. A
      #   `template_ref` element refers to one of these templates.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `terms_ref` (Hash): Refers to the payment terms associated with this entity. (This will be
      #   an item on the DateDrivenTerms or StandardTerms list.) If a `terms_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/credit-memos/create-credit-memo
      def create(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("credit_memo.create", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # List credit memos: GET /connections/{connection_id}/credit-memos (`credit_memo.query`).
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
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
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
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
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
      #     within a list family, not across the company file: customers, vendors, employees and
      #     other names share one sequence, every item type shares another, and each other list has
      #     its own.
      #   - `list_id_with_children` (String): Allows you to filter for data that relates to the
      #     specified object and its descendants.
      # - `include_line_items` (Boolean): This filter allows you to omit line items from a query
      #   response to get a smaller result. The default value is false, so line items are omitted by
      #   default. Set `include_line_items` to true to include line items in the response if you
      #   don’t mind getting a larger result.
      # - `include_linked_txns` (Boolean): If you set `include_linked_txns` to true, then the
      #   returned object will include a list of all the transactions linked to the queried object.
      #   (This list is similar to the History view of a transaction in the user interface, but not
      #   identical, as the SDK list contains only linked transactions, not items.) Each linked
      #   transaction will be represented by a `linked_txn` aggregate.
      # - `include_ret_element` (Array<one of "ARAccountRef", "BillAddress", "BillAddressBlock",
      #   "ClassRef", "CreditMemoLineGroupRet", "CreditMemoLineRet", "CreditRemaining",
      #   "CreditRemainingInHomeCurrency", "CurrencyRef", "CustomerMsgRef", "CustomerRef",
      #   "CustomerSalesTaxCodeRef", "DataExtRet", "DiscountLineRet", "DueDate", "EditSequence",
      #   "ExchangeRate", "ExternalGUID", "FOB", "IsPending", "IsTaxIncluded", "IsToBeEmailed",
      #   "IsToBePrinted", "ItemSalesTaxRef", "LinkedTxn", "Memo", "Other", "PONumber", "RefNumber",
      #   "SalesRepRef", "SalesTaxLineRet", "SalesTaxPercentage", "SalesTaxTotal", "ShipAddress",
      #   "ShipAddressBlock", "ShipDate", "ShipMethodRef", "ShippingLineRet", "Subtotal",
      #   "TemplateRef", "TermsRef", "TimeCreated", "TimeModified", "TotalAmount", "TxnDate",
      #   "TxnID", "TxnNumber">)
      # - `iterator` (Boolean): Page through every match: QuBe Sync asks QuickBooks for each page in
      #   turn and sends each to your `webhook_url` as it arrives, all with the same `id`. On by
      #   default, with pages of 100 records (25 with `include_line_items` or
      #   `include_linked_txns`); send `iterator=true` with `max_returned` for another size. Off
      #   when you send `iterator=false` (every match in one answer) or `max_returned` alone (at
      #   most that many, in one answer). It pages a filtered query only: with `ref_number`,
      #   `ref_number_case_sensitive` or `txn_id` every match comes back in one answer, so leave
      #   `iterator` out.
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
      # @see https://docs.qubesync.com/api-reference/v2/credit-memos/list-credit-memos
      def query(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("credit_memo.query", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end

      # Update credit memo: PUT /connections/{connection_id}/credit-memos (`credit_memo.update`).
      #
      # QuickBooks answers in one webhook.
      #
      # Params, sent as the JSON body:
      # - `ar_account_ref` (Hash): `ar_account_ref` points to an Accounts Receivable account. If
      #   both `full_name` and `list_id` are provided, `full_name` is ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `bill_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
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
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `credit_memo_line_group_mod` (Array<Hash>): Represents a previously defined group of lines
      #   in the credit memo. Compare with CreditMemoLine, which represents just one line in the
      #   credit memo. `credit_memo_line_mod` and `credit_memo_line_group_mod` combine: any number
      #   of each. QuickBooks receives them in that order: every `credit_memo_line_mod`, then every
      #   `credit_memo_line_group_mod`.
      #   - `credit_memo_line_mod` (Array<Hash>): Represents one line in the credit memo. Compare
      #     with CreditMemoGroupLine, which represents a previously defined group of lines in the
      #     credit memo.
      #     - `amount` (Numeric): A monetary amount.
      #     - `class_ref` (Hash): Use classes to categorize transactions (for example, by
      #       department, location, or work type). Class tracking is off by default in QuickBooks. A
      #       `class_ref` points to one class; if both `full_name` and `list_id` are provided,
      #       `full_name` is ignored. In InvoiceAdd, a header-level `class_ref` is applied to line
      #       items unless you override or clear it on individual lines.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `desc` (String): A descriptive text field.
      #     - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `inventory_site_ref` (Hash): Site where inventory is located.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #       depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #       sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #       BillingRateAdd requires a service item. If both `full_name` and `list_id` are
      #       provided, `full_name` is ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #       `serial_number`, or `lot_number`.
      #     - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #       Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #       available through the SDK and do not require DataExtDef setup. Template labels in the
      #       UI can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #     - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #       Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #       available through the SDK and do not require DataExtDef setup. Template labels in the
      #       UI can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #     - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #       `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #       `full_name` will be ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `override_uom_set_ref` (Hash): When you modify a transaction line to change the unit
      #       of measure used in that line, you use this aggregate to specify the UOM set within
      #       which you are choosing an available unit of measure. The “override” here refers to the
      #       unit within the set, not the UOM Set itself, which you can’t change or override–the
      #       UOM set that can be set or changed only in the item itself via an Item Mod request.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `price_level_ref` (Hash): Price levels let you apply custom pricing rules for selected
      #       customers. Once assigned, QuickBooks uses those prices automatically on supported
      #       sales forms unless explicitly overridden. Choose at most one of: `rate`, or
      #       `rate_percent`, or `price_level_ref`.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #       other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #       QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #       Amount.
      #     - `rate` (Numeric): If you specify both Rate and Amount in a request, the Rate you
      #       provide will be ignored, and you will receive a warning. If you specify both Quantity
      #       and Amount in an Add request, QuickBooks will use them to calculate Rate. (Rate,
      #       Amount, and Quantity can’t be cleared.) Choose at most one of: `rate`, or
      #       `rate_percent`, or `price_level_ref`.
      #     - `rate_percent` (Numeric): Indicates the price of something as a percent. Choose at
      #       most one of: `rate`, or `rate_percent`, or `price_level_ref`.
      #     - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used
      #       for an item or customer context. QuickBooks includes default TAX and NON codes, and a
      #       code can be deleted only when nothing references it. If sales tax is disabled,
      #       QuickBooks assigns the default non-taxable code. If both `full_name` and `list_id` are
      #       provided in `sales_tax_code_ref`, `full_name` is ignored.
      #       - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #         object. The `full_name` is the name prefixed by the names of each ancestor, for
      #         example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #       - `list_id` (String): `list_id` and `full_name` both identify a list object.
      #         QuickBooks assigns `list_id` when the object is created. `list_id` values are unique
      #         within a list family, not across the company file: customers, vendors, employees and
      #         other names share one sequence, every item type shares another, and each other list
      #         has its own.
      #     - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #       `serial_number`, or `lot_number`.
      #     - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #       service for the customer.
      #     - `tax_amount` (Numeric)
      #     - `txn_line_id` (String, required): Identification number of the transaction line.
      #       (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #       `txn_line_id` is always returned as zero.) If you need to add a new transaction line
      #       in a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #     - `unit_of_measure` (String): In a transaction line item, the name of the unit of
      #       measure selected from within the item’s available units. If the company file is
      #       enabled only for single unit of measure per item, this must be the base unit!
      #   - `item_group_ref` (Hash): ItemGroup objects represent items that are grouped together for
      #     fast entry, and an `item_group_ref` aggregate refers to one of these item groups. In a
      #     request, if an `item_group_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored. You can use an ItemGroupQuery request to get information
      #     about all the item groups that are set up in the QuickBooks file.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `override_uom_set_ref` (Hash): When you modify a transaction line to change the unit of
      #     measure used in that line, you use this aggregate to specify the UOM set within which
      #     you are choosing an available unit of measure. The “override” here refers to the unit
      #     within the set, not the UOM Set itself, which you can’t change or override–the UOM set
      #     that can be set or changed only in the item itself via an Item Mod request.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `credit_memo_line_mod` (Array<Hash>): Represents one line in the credit memo. Compare with
      #   CreditMemoGroupLine, which represents a previously defined group of lines in the credit
      #   memo. `credit_memo_line_mod` and `credit_memo_line_group_mod` combine: any number of each.
      #   QuickBooks receives them in that order: every `credit_memo_line_mod`, then every
      #   `credit_memo_line_group_mod`.
      #   - `amount` (Numeric): A monetary amount.
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
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `desc` (String): A descriptive text field.
      #   - `inventory_site_location_ref` (Hash): Location within the Inventory Site.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `inventory_site_ref` (Hash): Site where inventory is located.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `item_ref` (Hash): `item_ref` may accept all item types or a restricted subset,
      #     depending on the request. Examples: PurchaseOrder and Bill do not allow discount or
      #     sales-tax items; VehicleMileageAdd requires a service or other-charge item;
      #     BillingRateAdd requires a service item. If both `full_name` and `list_id` are provided,
      #     `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `lot_number` (String): The lot number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `other1` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `other2` (String): Other, Other1, and Other2 are built-in transaction custom fields.
      #     Other is transaction-level; Other1 and Other2 are line-level. These fields are always
      #     available through the SDK and do not require DataExtDef setup. Template labels in the UI
      #     can be renamed, but SDK names remain fixed as Other, Other1, and Other2.
      #   - `override_item_account_ref` (Hash): Refers to a QuickBooks account. If an
      #     `override_item_account_ref` aggregate includes both `full_name` and `list_id`,
      #     `full_name` will be ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `override_uom_set_ref` (Hash): When you modify a transaction line to change the unit of
      #     measure used in that line, you use this aggregate to specify the UOM set within which
      #     you are choosing an available unit of measure. The “override” here refers to the unit
      #     within the set, not the UOM Set itself, which you can’t change or override–the UOM set
      #     that can be set or changed only in the item itself via an Item Mod request.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `price_level_ref` (Hash): Price levels let you apply custom pricing rules for selected
      #     customers. Once assigned, QuickBooks uses those prices automatically on supported sales
      #     forms unless explicitly overridden. Choose at most one of: `rate`, or `rate_percent`, or
      #     `price_level_ref`.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `quantity` (Numeric): On transaction lines, QuickBooks can derive one value from the
      #     other two among Quantity, Rate, and Amount. If you supply Quantity and Amount,
      #     QuickBooks calculates Rate. If you supply Quantity and Rate, QuickBooks calculates
      #     Amount.
      #   - `rate` (Numeric): If you specify both Rate and Amount in a request, the Rate you provide
      #     will be ignored, and you will receive a warning. If you specify both Quantity and Amount
      #     in an Add request, QuickBooks will use them to calculate Rate. (Rate, Amount, and
      #     Quantity can’t be cleared.) Choose at most one of: `rate`, or `rate_percent`, or
      #     `price_level_ref`.
      #   - `rate_percent` (Numeric): Indicates the price of something as a percent. Choose at most
      #     one of: `rate`, or `rate_percent`, or `price_level_ref`.
      #   - `sales_tax_code_ref` (Hash): `sales_tax_code_ref` points to the sales-tax code used for
      #     an item or customer context. QuickBooks includes default TAX and NON codes, and a code
      #     can be deleted only when nothing references it. If sales tax is disabled, QuickBooks
      #     assigns the default non-taxable code. If both `full_name` and `list_id` are provided in
      #     `sales_tax_code_ref`, `full_name` is ignored.
      #     - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #       object. The `full_name` is the name prefixed by the names of each ancestor, for
      #       example Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #     - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #       assigns `list_id` when the object is created. `list_id` values are unique within a
      #       list family, not across the company file: customers, vendors, employees and other
      #       names share one sequence, every item type shares another, and each other list has its
      #       own.
      #   - `serial_number` (String): The serial number of the asset. Choose at most one of:
      #     `serial_number`, or `lot_number`.
      #   - `service_date` (String): Indicates the date on which the QuickBooks user performs the
      #     service for the customer.
      #   - `tax_amount` (Numeric)
      #   - `txn_line_id` (String, required): Identification number of the transaction line.
      #     (`txn_line_id` is supported as of v2.0 of the SDK. With qbXML v1.0 and v1.1,
      #     `txn_line_id` is always returned as zero.) If you need to add a new transaction line in
      #     a transaction Mod request, you can do so by setting the `txn_line_id` to -1.
      #   - `unit_of_measure` (String): In a transaction line item, the name of the unit of measure
      #     selected from within the item’s available units. If the company file is enabled only for
      #     single unit of measure per item, this must be the base unit!
      # - `customer_msg_ref` (Hash): A standard message such as “Thank you for your business,” or
      #   “Please sign and return this estimate to indicate your approval.” A customer message can
      #   be included at the bottom of a form. A `customer_msg_ref` aggregate refers to one of the
      #   messages on the CustomerMsg list. In a request, if a `customer_msg_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `customer_ref` (Hash): `customer_ref` identifies a customer or customer job. If both
      #   `full_name` and `list_id` are provided, `full_name` is ignored. In SalesReceipt and
      #   ReceivePayment, it identifies who receives credit. In TimeTracking, it identifies who the
      #   time can be billed to and is required in TimeTrackingAdd when IsBillable is true.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `customer_sales_tax_code_ref` (Hash): Refers to the sales-tax code for sales related to
      #   this customer. (That is, it refers to a member of the SalesTaxCode list.) The sales-tax
      #   code indicates whether an item is taxable or non-taxable, and why. In a request, if a
      #   `customer_sales_tax_code_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `due_date` (String): The date on which payment is due.
      # - `edit_sequence` (String, required): `edit_sequence` is a server-generated revision token.
      #   It changes each time the object is updated. To modify an existing object, you must send
      #   the current `edit_sequence`. If your value is stale, the update is rejected to prevent
      #   overwriting newer changes.
      # - `exchange_rate` (Numeric): `exchange_rate` is the rate from this currency to the company’s
      #   home currency at AsOfDate. You can supply a rate when adding transactions, but QuickBooks
      #   does not provide rates through the SDK. If your home currency is USD and internet access
      #   is available, rates can be downloaded in the QuickBooks UI via Lists > Currency >
      #   Activities > Download Latest Exchange Rates.
      # - `fob` (String): QuickBooks uses the term FOB, “freight on board,” to indicate the place
      #   from which the product is shipped. The FOB has no accounting implications.
      # - `include_ret_element` (Array<one of "ARAccountRef", "BillAddress", "BillAddressBlock",
      #   "ClassRef", "CreditMemoLineGroupRet", "CreditMemoLineRet", "CreditRemaining",
      #   "CreditRemainingInHomeCurrency", "CurrencyRef", "CustomerMsgRef", "CustomerRef",
      #   "CustomerSalesTaxCodeRef", "DataExtRet", "DiscountLineRet", "DueDate", "EditSequence",
      #   "ExchangeRate", "ExternalGUID", "FOB", "IsPending", "IsTaxIncluded", "IsToBeEmailed",
      #   "IsToBePrinted", "ItemSalesTaxRef", "LinkedTxn", "ListID", "Memo", "Other", "OwnerID",
      #   "PONumber", "RefNumber", "SalesRepRef", "SalesTaxLineRet", "SalesTaxPercentage",
      #   "SalesTaxTotal", "ShipAddress", "ShipAddressBlock", "ShipDate", "ShipMethodRef",
      #   "ShippingLineRet", "Subtotal", "TemplateRef", "TermsRef", "TimeCreated", "TimeModified",
      #   "TotalAmount", "TxnDate", "TxnID", "TxnNumber">)
      # - `is_pending` (Boolean): If `is_pending` is set to true, the credit memo hasn’t been
      #   completed. Within QuickBooks, you can change the `is_pending` status for a credit memo by
      #   choosing “Mark Credit Memo As Pending” or “Mark Credit Memo As Final” from the Edit menu.
      # - `is_tax_included` (Boolean): For future use with international versions of QuickBooks.
      # - `is_to_be_emailed` (Boolean): When enabled, QuickBooks validates the customer email at
      #   runtime before sending. If no valid email is available, the request fails.
      # - `is_to_be_printed` (Boolean): If `is_to_be_printed` is true, QuickBooks queues the form
      #   for later printing. It does not print immediately; printing is still a user action in
      #   QuickBooks.
      # - `item_sales_tax_ref` (Hash): An ItemSalesTax entry represents one tax rate paid to one tax
      #   agency. Use it when a transaction needs a single tax calculation. For multi-rate
      #   scenarios, use a sales-tax group instead. If both `full_name` and `list_id` are provided
      #   for `item_sales_tax_ref`, `list_id` is used.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `memo` (String): The memo doesn’t print on the credit memo, but does appear in the account
      #   register and the customer register.
      # - `other` (String): Other, Other1, and Other2 are built-in transaction custom fields. Other
      #   is transaction-level; Other1 and Other2 are line-level. These fields are always available
      #   through the SDK and do not require DataExtDef setup. Template labels in the UI can be
      #   renamed, but SDK names remain fixed as Other, Other1, and Other2.
      # - `po_number` (String): Purchase order number.
      # - `ref_number` (String): `ref_number` is a user-managed transaction reference (for example,
      #   a check number). It can be edited and is not guaranteed to be globally unique. Some
      #   transaction types auto-populate `ref_number` when omitted, based on QuickBooks preferences
      #   and numbering state.
      # - `request_id` (String): Your own label for the request, sent to QuickBooks as its qbXML
      #   `requestID` and echoed in the raw answer (`response_xml`); optional, since the answer's
      #   webhook already carries the request's `id`.
      # - `sales_rep_ref` (Hash): A sales representative must be on the Employee, Vendor, or Other
      #   Names list within QuickBooks. Sales representative’s names and initials appear on the Rep
      #   drop-down list on QuickBooks sales forms. A `sales_rep_ref` refers to a person on the
      #   SalesRep list. In a request, if a `sales_rep_ref` aggregate includes both `full_name` and
      #   `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `ship_address` (Hash): This aggregate supports at most five address lines. You can provide
      #   a structured address (Addr1-Addr3 plus City/State/`postal_code`/etc.) or use block mode
      #   (Addr1-Addr5 only). Do not mix block mode with other address fields. In block mode, each
      #   Addr line prints as its own line and is returned in `ship_address_block` or
      #   `bill_address_block`.
      #   - `addr1` (String): The first line of an address.
      #   - `addr2` (String): The second line of an address (if a second line is needed).
      #   - `addr3` (String): The third line of an address (if a third line is needed).
      #   - `addr4` (String): The fourth line of an address (if a fourth line is needed).
      #   - `addr5` (String): The fifth line of an address (if a fifth line is needed).
      #   - `city` (String): The city name in an address.
      #   - `country` (String): The country name in an address, or, in returned Host information
      #     (HostRet or HostInfo), the country for which this edition of QuickBooks was designed.
      #     (Possible values are US, CA, UK, and AU.)
      #   - `note` (String): In a `bill_address` or `ship_address` aggregate, the Note field value
      #     is written at the bottom of the address in the form in which it appears, such as the
      #     invoice form.
      #   - `postal_code` (String): The postal code in an address.
      #   - `state` (String): The state name in an address.
      # - `ship_date` (String): The date when the product was, or will be, shipped.
      # - `ship_method_ref` (Hash): A shipping method, for example, standard mail or overnight
      #   delivery. A `ship_method_ref` aggregate refers to an item on the ShipMethod list. In a
      #   request, if a `ship_method_ref` aggregate includes both `full_name` and `list_id`,
      #   `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `template_ref` (Hash): QuickBooks templates specify how to print certain transactions. A
      #   template query returns the names of all templates that have been defined in QuickBooks. A
      #   `template_ref` element refers to one of these templates.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `terms_ref` (Hash): Refers to the payment terms associated with this entity. (This will be
      #   an item on the DateDrivenTerms or StandardTerms list.) If a `terms_ref` aggregate includes
      #   both `full_name` and `list_id`, `full_name` will be ignored.
      #   - `full_name` (String): `full_name` (along with `list_id`) is a way to identify a list
      #     object. The `full_name` is the name prefixed by the names of each ancestor, for example
      #     Jones:Kitchen:Cabinets. `full_name` values aren’t case-sensitive.
      #   - `list_id` (String): `list_id` and `full_name` both identify a list object. QuickBooks
      #     assigns `list_id` when the object is created. `list_id` values are unique within a list
      #     family, not across the company file: customers, vendors, employees and other names share
      #     one sequence, every item type shares another, and each other list has its own.
      # - `txn_date` (String): The date of the transaction. In some cases, if you leave `txn_date`
      #   out of an -Add message, QuickBooks will prefill `txn_date` with the date of the last-saved
      #   transaction of the same type.
      # - `txn_id` (String, required): `txn_id` is the unique QuickBooks identifier for a
      #   transaction. Use it to reference that transaction in later requests. `txn_id` values are
      #   transaction-specific and should not be reused across unrelated transaction types.
      #
      # @param connection_id [String]
      # @param params [Hash] the fields above
      # @param webhook_url [String] where QuBe Sync sends the answer
      # @param idempotency_key [String, nil] made for the call when nil, and reused on its retries
      # @return [Hash] the queued request
      # @see https://docs.qubesync.com/api-reference/v2/credit-memos/update-credit-memo
      def update(connection_id, params = {}, webhook_url:, idempotency_key: nil)
        queue("credit_memo.update", connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end
  end
end
