# Generated from operations.json by bin/generate-operations: don't edit.
# frozen_string_literal: true

module QubeSync
  # QuickBooks operations, one class per entity, each loaded on first use. A client reaches
  # them through its entity accessors: `client.customer.create(...)`.
  module Operations
    # The digest of the operations.json these were generated from. A workflow types document
    # names the one its `$operation` ids refer to (`operations_digest`).
    DIGEST = "sha256:fbbc56fa74196e96903b2eef75216be240e409296641d33f4158da2b48020540"

    # Operation id => how it's sent. `path` is relative to the connection. `id_param` is the
    # param a query looks records up by ("list_id" or "txn_id", a list of ids), else nil.
    INDEX = {
      "account.create" => {method: "POST", path: "accounts", params_in: :body, paged: false, entity: "account", id_param: nil}.freeze,
      "account.query" => {method: "GET", path: "accounts", params_in: :query, paged: false, entity: "account", id_param: "list_id"}.freeze,
      "account.update" => {method: "PUT", path: "accounts", params_in: :body, paged: false, entity: "account", id_param: nil}.freeze,
      "account_tax_line_info.query" => {method: "GET", path: "account-tax-line-infos", params_in: :query, paged: false, entity: "account_tax_line_info", id_param: nil}.freeze,
      "aging_report.query" => {method: "GET", path: "aging-reports", params_in: :query, paged: false, entity: "aging_report", id_param: nil}.freeze,
      "alert.create" => {method: "POST", path: "alerts", params_in: :body, paged: false, entity: "alert", id_param: nil}.freeze,
      "alert.delete" => {method: "DELETE", path: "alerts", params_in: :body, paged: false, entity: "alert", id_param: nil}.freeze,
      "alert.query" => {method: "GET", path: "alerts", params_in: :query, paged: false, entity: "alert", id_param: nil}.freeze,
      "ar_refund_credit_card.create" => {method: "POST", path: "ar-refund-credit-cards", params_in: :body, paged: false, entity: "ar_refund_credit_card", id_param: nil}.freeze,
      "ar_refund_credit_card.query" => {method: "GET", path: "ar-refund-credit-cards", params_in: :query, paged: true, entity: "ar_refund_credit_card", id_param: "txn_id"}.freeze,
      "bar_code.query" => {method: "GET", path: "bar-codes", params_in: :query, paged: false, entity: "bar_code", id_param: nil}.freeze,
      "bill.create" => {method: "POST", path: "bills", params_in: :body, paged: false, entity: "bill", id_param: nil}.freeze,
      "bill.query" => {method: "GET", path: "bills", params_in: :query, paged: true, entity: "bill", id_param: "txn_id"}.freeze,
      "bill.update" => {method: "PUT", path: "bills", params_in: :body, paged: false, entity: "bill", id_param: nil}.freeze,
      "bill_payment_check.create" => {method: "POST", path: "bill-payment-checks", params_in: :body, paged: false, entity: "bill_payment_check", id_param: nil}.freeze,
      "bill_payment_check.query" => {method: "GET", path: "bill-payment-checks", params_in: :query, paged: true, entity: "bill_payment_check", id_param: "txn_id"}.freeze,
      "bill_payment_check.update" => {method: "PUT", path: "bill-payment-checks", params_in: :body, paged: false, entity: "bill_payment_check", id_param: nil}.freeze,
      "bill_payment_credit_card.create" => {method: "POST", path: "bill-payment-credit-cards", params_in: :body, paged: false, entity: "bill_payment_credit_card", id_param: nil}.freeze,
      "bill_payment_credit_card.query" => {method: "GET", path: "bill-payment-credit-cards", params_in: :query, paged: true, entity: "bill_payment_credit_card", id_param: "txn_id"}.freeze,
      "bill_to_pay.query" => {method: "GET", path: "bill-to-pays", params_in: :query, paged: false, entity: "bill_to_pay", id_param: nil}.freeze,
      "billing_rate.create" => {method: "POST", path: "billing-rates", params_in: :body, paged: false, entity: "billing_rate", id_param: nil}.freeze,
      "billing_rate.query" => {method: "GET", path: "billing-rates", params_in: :query, paged: false, entity: "billing_rate", id_param: "list_id"}.freeze,
      "budget_summary_report.query" => {method: "GET", path: "budget-summary-reports", params_in: :query, paged: false, entity: "budget_summary_report", id_param: nil}.freeze,
      "build_assembly.create" => {method: "POST", path: "build-assemblies", params_in: :body, paged: false, entity: "build_assembly", id_param: nil}.freeze,
      "build_assembly.query" => {method: "GET", path: "build-assemblies", params_in: :query, paged: true, entity: "build_assembly", id_param: "txn_id"}.freeze,
      "build_assembly.update" => {method: "PUT", path: "build-assemblies", params_in: :body, paged: false, entity: "build_assembly", id_param: nil}.freeze,
      "charge.create" => {method: "POST", path: "charges", params_in: :body, paged: false, entity: "charge", id_param: nil}.freeze,
      "charge.query" => {method: "GET", path: "charges", params_in: :query, paged: true, entity: "charge", id_param: "txn_id"}.freeze,
      "charge.update" => {method: "PUT", path: "charges", params_in: :body, paged: false, entity: "charge", id_param: nil}.freeze,
      "check.create" => {method: "POST", path: "checks", params_in: :body, paged: false, entity: "check", id_param: nil}.freeze,
      "check.query" => {method: "GET", path: "checks", params_in: :query, paged: true, entity: "check", id_param: "txn_id"}.freeze,
      "check.update" => {method: "PUT", path: "checks", params_in: :body, paged: false, entity: "check", id_param: nil}.freeze,
      "class.create" => {method: "POST", path: "classes", params_in: :body, paged: false, entity: "class", id_param: nil}.freeze,
      "class.query" => {method: "GET", path: "classes", params_in: :query, paged: false, entity: "class", id_param: "list_id"}.freeze,
      "class.update" => {method: "PUT", path: "classes", params_in: :body, paged: false, entity: "class", id_param: nil}.freeze,
      "cleared_status.update" => {method: "PUT", path: "cleared-statuses", params_in: :body, paged: false, entity: "cleared_status", id_param: nil}.freeze,
      "company.query" => {method: "GET", path: "companies", params_in: :query, paged: false, entity: "company", id_param: nil}.freeze,
      "company_activity.query" => {method: "GET", path: "company-activities", params_in: :query, paged: false, entity: "company_activity", id_param: nil}.freeze,
      "credit_card_charge.create" => {method: "POST", path: "credit-card-charges", params_in: :body, paged: false, entity: "credit_card_charge", id_param: nil}.freeze,
      "credit_card_charge.query" => {method: "GET", path: "credit-card-charges", params_in: :query, paged: true, entity: "credit_card_charge", id_param: "txn_id"}.freeze,
      "credit_card_charge.update" => {method: "PUT", path: "credit-card-charges", params_in: :body, paged: false, entity: "credit_card_charge", id_param: nil}.freeze,
      "credit_card_credit.create" => {method: "POST", path: "credit-card-credits", params_in: :body, paged: false, entity: "credit_card_credit", id_param: nil}.freeze,
      "credit_card_credit.query" => {method: "GET", path: "credit-card-credits", params_in: :query, paged: true, entity: "credit_card_credit", id_param: "txn_id"}.freeze,
      "credit_card_credit.update" => {method: "PUT", path: "credit-card-credits", params_in: :body, paged: false, entity: "credit_card_credit", id_param: nil}.freeze,
      "credit_memo.create" => {method: "POST", path: "credit-memos", params_in: :body, paged: false, entity: "credit_memo", id_param: nil}.freeze,
      "credit_memo.query" => {method: "GET", path: "credit-memos", params_in: :query, paged: true, entity: "credit_memo", id_param: "txn_id"}.freeze,
      "credit_memo.update" => {method: "PUT", path: "credit-memos", params_in: :body, paged: false, entity: "credit_memo", id_param: nil}.freeze,
      "currency.create" => {method: "POST", path: "currencies", params_in: :body, paged: false, entity: "currency", id_param: nil}.freeze,
      "currency.query" => {method: "GET", path: "currencies", params_in: :query, paged: false, entity: "currency", id_param: "list_id"}.freeze,
      "currency.update" => {method: "PUT", path: "currencies", params_in: :body, paged: false, entity: "currency", id_param: nil}.freeze,
      "custom_detail_report.query" => {method: "GET", path: "custom-detail-reports", params_in: :query, paged: false, entity: "custom_detail_report", id_param: nil}.freeze,
      "custom_summary_report.query" => {method: "GET", path: "custom-summary-reports", params_in: :query, paged: false, entity: "custom_summary_report", id_param: nil}.freeze,
      "customer.create" => {method: "POST", path: "customers", params_in: :body, paged: false, entity: "customer", id_param: nil}.freeze,
      "customer.query" => {method: "GET", path: "customers", params_in: :query, paged: true, entity: "customer", id_param: "list_id"}.freeze,
      "customer.update" => {method: "PUT", path: "customers", params_in: :body, paged: false, entity: "customer", id_param: nil}.freeze,
      "customer_msg.create" => {method: "POST", path: "customer-msgs", params_in: :body, paged: false, entity: "customer_msg", id_param: nil}.freeze,
      "customer_msg.query" => {method: "GET", path: "customer-msgs", params_in: :query, paged: false, entity: "customer_msg", id_param: "list_id"}.freeze,
      "customer_type.create" => {method: "POST", path: "customer-types", params_in: :body, paged: false, entity: "customer_type", id_param: nil}.freeze,
      "customer_type.query" => {method: "GET", path: "customer-types", params_in: :query, paged: false, entity: "customer_type", id_param: "list_id"}.freeze,
      "data_event_recovery_info.delete" => {method: "DELETE", path: "data-event-recovery-infos", params_in: :body, paged: false, entity: "data_event_recovery_info", id_param: nil}.freeze,
      "data_event_recovery_info.query" => {method: "GET", path: "data-event-recovery-infos", params_in: :query, paged: false, entity: "data_event_recovery_info", id_param: nil}.freeze,
      "data_ext.create" => {method: "POST", path: "data-exts", params_in: :body, paged: false, entity: "data_ext", id_param: nil}.freeze,
      "data_ext.delete" => {method: "DELETE", path: "data-exts", params_in: :body, paged: false, entity: "data_ext", id_param: nil}.freeze,
      "data_ext.update" => {method: "PUT", path: "data-exts", params_in: :body, paged: false, entity: "data_ext", id_param: nil}.freeze,
      "data_ext_def.create" => {method: "POST", path: "data-ext-defs", params_in: :body, paged: false, entity: "data_ext_def", id_param: nil}.freeze,
      "data_ext_def.delete" => {method: "DELETE", path: "data-ext-defs", params_in: :body, paged: false, entity: "data_ext_def", id_param: nil}.freeze,
      "data_ext_def.query" => {method: "GET", path: "data-ext-defs", params_in: :query, paged: false, entity: "data_ext_def", id_param: nil}.freeze,
      "data_ext_def.update" => {method: "PUT", path: "data-ext-defs", params_in: :body, paged: false, entity: "data_ext_def", id_param: nil}.freeze,
      "date_driven_terms.create" => {method: "POST", path: "date-driven-terms", params_in: :body, paged: false, entity: "date_driven_terms", id_param: nil}.freeze,
      "date_driven_terms.query" => {method: "GET", path: "date-driven-terms", params_in: :query, paged: false, entity: "date_driven_terms", id_param: "list_id"}.freeze,
      "deposit.create" => {method: "POST", path: "deposits", params_in: :body, paged: false, entity: "deposit", id_param: nil}.freeze,
      "deposit.query" => {method: "GET", path: "deposits", params_in: :query, paged: true, entity: "deposit", id_param: "txn_id"}.freeze,
      "deposit.update" => {method: "PUT", path: "deposits", params_in: :body, paged: false, entity: "deposit", id_param: nil}.freeze,
      "employee.create" => {method: "POST", path: "employees", params_in: :body, paged: false, entity: "employee", id_param: nil}.freeze,
      "employee.query" => {method: "GET", path: "employees", params_in: :query, paged: false, entity: "employee", id_param: "list_id"}.freeze,
      "employee.update" => {method: "PUT", path: "employees", params_in: :body, paged: false, entity: "employee", id_param: nil}.freeze,
      "employee_default.query" => {method: "GET", path: "employee-defaults", params_in: :query, paged: false, entity: "employee_default", id_param: nil}.freeze,
      "employee_default.update" => {method: "PUT", path: "employee-defaults", params_in: :body, paged: false, entity: "employee_default", id_param: nil}.freeze,
      "entity.query" => {method: "GET", path: "entities", params_in: :query, paged: true, entity: "entity", id_param: "list_id"}.freeze,
      "estimate.create" => {method: "POST", path: "estimates", params_in: :body, paged: false, entity: "estimate", id_param: nil}.freeze,
      "estimate.query" => {method: "GET", path: "estimates", params_in: :query, paged: true, entity: "estimate", id_param: "txn_id"}.freeze,
      "estimate.update" => {method: "PUT", path: "estimates", params_in: :body, paged: false, entity: "estimate", id_param: nil}.freeze,
      "form1099_category_account_mapping.query" => {method: "GET", path: "form1099-category-account-mappings", params_in: :query, paged: false, entity: "form1099_category_account_mapping", id_param: nil}.freeze,
      "form1099_category_account_mapping.update" => {method: "PUT", path: "form1099-category-account-mappings", params_in: :body, paged: false, entity: "form1099_category_account_mapping", id_param: nil}.freeze,
      "general_detail_report.query" => {method: "GET", path: "general-detail-reports", params_in: :query, paged: false, entity: "general_detail_report", id_param: nil}.freeze,
      "general_summary_report.query" => {method: "GET", path: "general-summary-reports", params_in: :query, paged: false, entity: "general_summary_report", id_param: nil}.freeze,
      "host.query" => {method: "GET", path: "hosts", params_in: :query, paged: false, entity: "host", id_param: nil}.freeze,
      "inventory_adjustment.create" => {method: "POST", path: "inventory-adjustments", params_in: :body, paged: false, entity: "inventory_adjustment", id_param: nil}.freeze,
      "inventory_adjustment.query" => {method: "GET", path: "inventory-adjustments", params_in: :query, paged: true, entity: "inventory_adjustment", id_param: "txn_id"}.freeze,
      "inventory_adjustment.update" => {method: "PUT", path: "inventory-adjustments", params_in: :body, paged: false, entity: "inventory_adjustment", id_param: nil}.freeze,
      "inventory_site.create" => {method: "POST", path: "inventory-sites", params_in: :body, paged: false, entity: "inventory_site", id_param: nil}.freeze,
      "inventory_site.query" => {method: "GET", path: "inventory-sites", params_in: :query, paged: false, entity: "inventory_site", id_param: "list_id"}.freeze,
      "inventory_site.update" => {method: "PUT", path: "inventory-sites", params_in: :body, paged: false, entity: "inventory_site", id_param: nil}.freeze,
      "invoice.create" => {method: "POST", path: "invoices", params_in: :body, paged: false, entity: "invoice", id_param: nil}.freeze,
      "invoice.query" => {method: "GET", path: "invoices", params_in: :query, paged: true, entity: "invoice", id_param: "txn_id"}.freeze,
      "invoice.update" => {method: "PUT", path: "invoices", params_in: :body, paged: false, entity: "invoice", id_param: nil}.freeze,
      "item.query" => {method: "GET", path: "items", params_in: :query, paged: true, entity: "item", id_param: "list_id"}.freeze,
      "item_assemblies_can_build.query" => {method: "GET", path: "item-assemblies-can-builds", params_in: :query, paged: false, entity: "item_assemblies_can_build", id_param: nil}.freeze,
      "item_discount.create" => {method: "POST", path: "item-discounts", params_in: :body, paged: false, entity: "item_discount", id_param: nil}.freeze,
      "item_discount.query" => {method: "GET", path: "item-discounts", params_in: :query, paged: true, entity: "item_discount", id_param: "list_id"}.freeze,
      "item_discount.update" => {method: "PUT", path: "item-discounts", params_in: :body, paged: false, entity: "item_discount", id_param: nil}.freeze,
      "item_fixed_asset.create" => {method: "POST", path: "item-fixed-assets", params_in: :body, paged: false, entity: "item_fixed_asset", id_param: nil}.freeze,
      "item_fixed_asset.query" => {method: "GET", path: "item-fixed-assets", params_in: :query, paged: true, entity: "item_fixed_asset", id_param: "list_id"}.freeze,
      "item_fixed_asset.update" => {method: "PUT", path: "item-fixed-assets", params_in: :body, paged: false, entity: "item_fixed_asset", id_param: nil}.freeze,
      "item_group.create" => {method: "POST", path: "item-groups", params_in: :body, paged: false, entity: "item_group", id_param: nil}.freeze,
      "item_group.query" => {method: "GET", path: "item-groups", params_in: :query, paged: true, entity: "item_group", id_param: "list_id"}.freeze,
      "item_group.update" => {method: "PUT", path: "item-groups", params_in: :body, paged: false, entity: "item_group", id_param: nil}.freeze,
      "item_inventory.create" => {method: "POST", path: "item-inventories", params_in: :body, paged: false, entity: "item_inventory", id_param: nil}.freeze,
      "item_inventory.query" => {method: "GET", path: "item-inventories", params_in: :query, paged: true, entity: "item_inventory", id_param: "list_id"}.freeze,
      "item_inventory.update" => {method: "PUT", path: "item-inventories", params_in: :body, paged: false, entity: "item_inventory", id_param: nil}.freeze,
      "item_inventory_assembly.create" => {method: "POST", path: "item-inventory-assemblies", params_in: :body, paged: false, entity: "item_inventory_assembly", id_param: nil}.freeze,
      "item_inventory_assembly.query" => {method: "GET", path: "item-inventory-assemblies", params_in: :query, paged: true, entity: "item_inventory_assembly", id_param: "list_id"}.freeze,
      "item_inventory_assembly.update" => {method: "PUT", path: "item-inventory-assemblies", params_in: :body, paged: false, entity: "item_inventory_assembly", id_param: nil}.freeze,
      "item_non_inventory.create" => {method: "POST", path: "item-non-inventories", params_in: :body, paged: false, entity: "item_non_inventory", id_param: nil}.freeze,
      "item_non_inventory.query" => {method: "GET", path: "item-non-inventories", params_in: :query, paged: true, entity: "item_non_inventory", id_param: "list_id"}.freeze,
      "item_non_inventory.update" => {method: "PUT", path: "item-non-inventories", params_in: :body, paged: false, entity: "item_non_inventory", id_param: nil}.freeze,
      "item_other_charge.create" => {method: "POST", path: "item-other-charges", params_in: :body, paged: false, entity: "item_other_charge", id_param: nil}.freeze,
      "item_other_charge.query" => {method: "GET", path: "item-other-charges", params_in: :query, paged: true, entity: "item_other_charge", id_param: "list_id"}.freeze,
      "item_other_charge.update" => {method: "PUT", path: "item-other-charges", params_in: :body, paged: false, entity: "item_other_charge", id_param: nil}.freeze,
      "item_payment.create" => {method: "POST", path: "item-payments", params_in: :body, paged: false, entity: "item_payment", id_param: nil}.freeze,
      "item_payment.query" => {method: "GET", path: "item-payments", params_in: :query, paged: true, entity: "item_payment", id_param: "list_id"}.freeze,
      "item_payment.update" => {method: "PUT", path: "item-payments", params_in: :body, paged: false, entity: "item_payment", id_param: nil}.freeze,
      "item_receipt.create" => {method: "POST", path: "item-receipts", params_in: :body, paged: false, entity: "item_receipt", id_param: nil}.freeze,
      "item_receipt.query" => {method: "GET", path: "item-receipts", params_in: :query, paged: true, entity: "item_receipt", id_param: "txn_id"}.freeze,
      "item_receipt.update" => {method: "PUT", path: "item-receipts", params_in: :body, paged: false, entity: "item_receipt", id_param: nil}.freeze,
      "item_sales_tax.create" => {method: "POST", path: "item-sales-taxes", params_in: :body, paged: false, entity: "item_sales_tax", id_param: nil}.freeze,
      "item_sales_tax.query" => {method: "GET", path: "item-sales-taxes", params_in: :query, paged: true, entity: "item_sales_tax", id_param: "list_id"}.freeze,
      "item_sales_tax.update" => {method: "PUT", path: "item-sales-taxes", params_in: :body, paged: false, entity: "item_sales_tax", id_param: nil}.freeze,
      "item_sales_tax_group.create" => {method: "POST", path: "item-sales-tax-groups", params_in: :body, paged: false, entity: "item_sales_tax_group", id_param: nil}.freeze,
      "item_sales_tax_group.query" => {method: "GET", path: "item-sales-tax-groups", params_in: :query, paged: true, entity: "item_sales_tax_group", id_param: "list_id"}.freeze,
      "item_sales_tax_group.update" => {method: "PUT", path: "item-sales-tax-groups", params_in: :body, paged: false, entity: "item_sales_tax_group", id_param: nil}.freeze,
      "item_service.create" => {method: "POST", path: "item-services", params_in: :body, paged: false, entity: "item_service", id_param: nil}.freeze,
      "item_service.query" => {method: "GET", path: "item-services", params_in: :query, paged: true, entity: "item_service", id_param: "list_id"}.freeze,
      "item_service.update" => {method: "PUT", path: "item-services", params_in: :body, paged: false, entity: "item_service", id_param: nil}.freeze,
      "item_sites.query" => {method: "GET", path: "item-sites", params_in: :query, paged: true, entity: "item_sites", id_param: "list_id"}.freeze,
      "item_subtotal.create" => {method: "POST", path: "item-subtotals", params_in: :body, paged: false, entity: "item_subtotal", id_param: nil}.freeze,
      "item_subtotal.query" => {method: "GET", path: "item-subtotals", params_in: :query, paged: true, entity: "item_subtotal", id_param: "list_id"}.freeze,
      "item_subtotal.update" => {method: "PUT", path: "item-subtotals", params_in: :body, paged: false, entity: "item_subtotal", id_param: nil}.freeze,
      "job_report.query" => {method: "GET", path: "job-reports", params_in: :query, paged: false, entity: "job_report", id_param: nil}.freeze,
      "job_type.create" => {method: "POST", path: "job-types", params_in: :body, paged: false, entity: "job_type", id_param: nil}.freeze,
      "job_type.query" => {method: "GET", path: "job-types", params_in: :query, paged: false, entity: "job_type", id_param: "list_id"}.freeze,
      "journal_entry.create" => {method: "POST", path: "journal-entries", params_in: :body, paged: false, entity: "journal_entry", id_param: nil}.freeze,
      "journal_entry.query" => {method: "GET", path: "journal-entries", params_in: :query, paged: true, entity: "journal_entry", id_param: "txn_id"}.freeze,
      "journal_entry.update" => {method: "PUT", path: "journal-entries", params_in: :body, paged: false, entity: "journal_entry", id_param: nil}.freeze,
      "lead.create" => {method: "POST", path: "leads", params_in: :body, paged: false, entity: "lead", id_param: nil}.freeze,
      "lead.query" => {method: "GET", path: "leads", params_in: :query, paged: true, entity: "lead", id_param: "list_id"}.freeze,
      "lead.update" => {method: "PUT", path: "leads", params_in: :body, paged: false, entity: "lead", id_param: nil}.freeze,
      "list.delete" => {method: "DELETE", path: "lists", params_in: :body, paged: false, entity: "list", id_param: nil}.freeze,
      "list_deleted.query" => {method: "GET", path: "list-deleteds", params_in: :query, paged: false, entity: "list_deleted", id_param: nil}.freeze,
      "list_display.create" => {method: "POST", path: "list-displays", params_in: :body, paged: false, entity: "list_display", id_param: nil}.freeze,
      "list_display.update" => {method: "PUT", path: "list-displays", params_in: :body, paged: false, entity: "list_display", id_param: nil}.freeze,
      "list_merge.execute" => {method: "POST", path: "list-merge", params_in: :body, paged: false, entity: "list_merge", id_param: nil}.freeze,
      "other_name.create" => {method: "POST", path: "other-names", params_in: :body, paged: false, entity: "other_name", id_param: nil}.freeze,
      "other_name.query" => {method: "GET", path: "other-names", params_in: :query, paged: false, entity: "other_name", id_param: "list_id"}.freeze,
      "other_name.update" => {method: "PUT", path: "other-names", params_in: :body, paged: false, entity: "other_name", id_param: nil}.freeze,
      "paycheck.query" => {method: "GET", path: "paychecks", params_in: :query, paged: false, entity: "paycheck", id_param: "txn_id"}.freeze,
      "payment_method.create" => {method: "POST", path: "payment-methods", params_in: :body, paged: false, entity: "payment_method", id_param: nil}.freeze,
      "payment_method.query" => {method: "GET", path: "payment-methods", params_in: :query, paged: false, entity: "payment_method", id_param: "list_id"}.freeze,
      "payroll_detail_report.query" => {method: "GET", path: "payroll-detail-reports", params_in: :query, paged: false, entity: "payroll_detail_report", id_param: nil}.freeze,
      "payroll_item.query" => {method: "GET", path: "payroll-items", params_in: :query, paged: false, entity: "payroll_item", id_param: "list_id"}.freeze,
      "payroll_item_addition.create" => {method: "POST", path: "payroll-item-additions", params_in: :body, paged: false, entity: "payroll_item_addition", id_param: nil}.freeze,
      "payroll_item_addition.update" => {method: "PUT", path: "payroll-item-additions", params_in: :body, paged: false, entity: "payroll_item_addition", id_param: nil}.freeze,
      "payroll_item_company_contribution.create" => {method: "POST", path: "payroll-item-company-contributions", params_in: :body, paged: false, entity: "payroll_item_company_contribution", id_param: nil}.freeze,
      "payroll_item_company_contribution.update" => {method: "PUT", path: "payroll-item-company-contributions", params_in: :body, paged: false, entity: "payroll_item_company_contribution", id_param: nil}.freeze,
      "payroll_item_deduction.create" => {method: "POST", path: "payroll-item-deductions", params_in: :body, paged: false, entity: "payroll_item_deduction", id_param: nil}.freeze,
      "payroll_item_deduction.update" => {method: "PUT", path: "payroll-item-deductions", params_in: :body, paged: false, entity: "payroll_item_deduction", id_param: nil}.freeze,
      "payroll_item_direct_deposit.create" => {method: "POST", path: "payroll-item-direct-deposits", params_in: :body, paged: false, entity: "payroll_item_direct_deposit", id_param: nil}.freeze,
      "payroll_item_direct_deposit.update" => {method: "PUT", path: "payroll-item-direct-deposits", params_in: :body, paged: false, entity: "payroll_item_direct_deposit", id_param: nil}.freeze,
      "payroll_item_non_wage.query" => {method: "GET", path: "payroll-item-non-wages", params_in: :query, paged: false, entity: "payroll_item_non_wage", id_param: "list_id"}.freeze,
      "payroll_item_tax.create" => {method: "POST", path: "payroll-item-taxes", params_in: :body, paged: false, entity: "payroll_item_tax", id_param: nil}.freeze,
      "payroll_item_tax.update" => {method: "PUT", path: "payroll-item-taxes", params_in: :body, paged: false, entity: "payroll_item_tax", id_param: nil}.freeze,
      "payroll_item_wage.create" => {method: "POST", path: "payroll-item-wages", params_in: :body, paged: false, entity: "payroll_item_wage", id_param: nil}.freeze,
      "payroll_item_wage.query" => {method: "GET", path: "payroll-item-wages", params_in: :query, paged: false, entity: "payroll_item_wage", id_param: "list_id"}.freeze,
      "payroll_item_wage.update" => {method: "PUT", path: "payroll-item-wages", params_in: :body, paged: false, entity: "payroll_item_wage", id_param: nil}.freeze,
      "payroll_item_workers_compensation.create" => {method: "POST", path: "payroll-item-workers-compensations", params_in: :body, paged: false, entity: "payroll_item_workers_compensation", id_param: nil}.freeze,
      "payroll_item_workers_compensation.update" => {method: "PUT", path: "payroll-item-workers-compensations", params_in: :body, paged: false, entity: "payroll_item_workers_compensation", id_param: nil}.freeze,
      "payroll_last_period.query" => {method: "GET", path: "payroll-last-periods", params_in: :query, paged: false, entity: "payroll_last_period", id_param: nil}.freeze,
      "payroll_liability_adjustment.create" => {method: "POST", path: "payroll-liability-adjustments", params_in: :body, paged: false, entity: "payroll_liability_adjustment", id_param: nil}.freeze,
      "payroll_liability_adjustment.query" => {method: "GET", path: "payroll-liability-adjustments", params_in: :query, paged: false, entity: "payroll_liability_adjustment", id_param: "txn_id"}.freeze,
      "payroll_liability_check.query" => {method: "GET", path: "payroll-liability-checks", params_in: :query, paged: false, entity: "payroll_liability_check", id_param: "txn_id"}.freeze,
      "payroll_prior_payment.create" => {method: "POST", path: "payroll-prior-payments", params_in: :body, paged: false, entity: "payroll_prior_payment", id_param: nil}.freeze,
      "payroll_prior_payment.query" => {method: "GET", path: "payroll-prior-payments", params_in: :query, paged: false, entity: "payroll_prior_payment", id_param: "txn_id"}.freeze,
      "payroll_summary_report.query" => {method: "GET", path: "payroll-summary-reports", params_in: :query, paged: false, entity: "payroll_summary_report", id_param: nil}.freeze,
      "payroll_year_to_date_adjustment.create" => {method: "POST", path: "payroll-year-to-date-adjustments", params_in: :body, paged: false, entity: "payroll_year_to_date_adjustment", id_param: nil}.freeze,
      "payroll_year_to_date_adjustment.query" => {method: "GET", path: "payroll-year-to-date-adjustments", params_in: :query, paged: false, entity: "payroll_year_to_date_adjustment", id_param: "txn_id"}.freeze,
      "preferences.query" => {method: "GET", path: "preferences", params_in: :query, paged: false, entity: "preferences", id_param: nil}.freeze,
      "preferences.update" => {method: "PUT", path: "preferences", params_in: :body, paged: false, entity: "preferences", id_param: nil}.freeze,
      "price_level.create" => {method: "POST", path: "price-levels", params_in: :body, paged: false, entity: "price_level", id_param: nil}.freeze,
      "price_level.query" => {method: "GET", path: "price-levels", params_in: :query, paged: false, entity: "price_level", id_param: "list_id"}.freeze,
      "price_level.update" => {method: "PUT", path: "price-levels", params_in: :body, paged: false, entity: "price_level", id_param: nil}.freeze,
      "purchase_order.create" => {method: "POST", path: "purchase-orders", params_in: :body, paged: false, entity: "purchase_order", id_param: nil}.freeze,
      "purchase_order.query" => {method: "GET", path: "purchase-orders", params_in: :query, paged: true, entity: "purchase_order", id_param: "txn_id"}.freeze,
      "purchase_order.update" => {method: "PUT", path: "purchase-orders", params_in: :body, paged: false, entity: "purchase_order", id_param: nil}.freeze,
      "qb_command_exec.execute" => {method: "POST", path: "qb-command-exec", params_in: :body, paged: false, entity: "qb_command_exec", id_param: nil}.freeze,
      "receive_payment.create" => {method: "POST", path: "payments", params_in: :body, paged: false, entity: "receive_payment", id_param: nil}.freeze,
      "receive_payment.query" => {method: "GET", path: "receive-payments", params_in: :query, paged: true, entity: "receive_payment", id_param: "txn_id"}.freeze,
      "receive_payment.update" => {method: "PUT", path: "receive-payments", params_in: :body, paged: false, entity: "receive_payment", id_param: nil}.freeze,
      "receive_payment_to_deposit.query" => {method: "GET", path: "receive-payment-to-deposits", params_in: :query, paged: false, entity: "receive_payment_to_deposit", id_param: nil}.freeze,
      "sales_order.create" => {method: "POST", path: "sales-orders", params_in: :body, paged: false, entity: "sales_order", id_param: nil}.freeze,
      "sales_order.query" => {method: "GET", path: "sales-orders", params_in: :query, paged: true, entity: "sales_order", id_param: "txn_id"}.freeze,
      "sales_order.update" => {method: "PUT", path: "sales-orders", params_in: :body, paged: false, entity: "sales_order", id_param: nil}.freeze,
      "sales_receipt.create" => {method: "POST", path: "sales-receipts", params_in: :body, paged: false, entity: "sales_receipt", id_param: nil}.freeze,
      "sales_receipt.query" => {method: "GET", path: "sales-receipts", params_in: :query, paged: true, entity: "sales_receipt", id_param: "txn_id"}.freeze,
      "sales_receipt.update" => {method: "PUT", path: "sales-receipts", params_in: :body, paged: false, entity: "sales_receipt", id_param: nil}.freeze,
      "sales_rep.create" => {method: "POST", path: "sales-reps", params_in: :body, paged: false, entity: "sales_rep", id_param: nil}.freeze,
      "sales_rep.query" => {method: "GET", path: "sales-reps", params_in: :query, paged: false, entity: "sales_rep", id_param: "list_id"}.freeze,
      "sales_rep.update" => {method: "PUT", path: "sales-reps", params_in: :body, paged: false, entity: "sales_rep", id_param: nil}.freeze,
      "sales_tax_code.create" => {method: "POST", path: "sales-tax-codes", params_in: :body, paged: false, entity: "sales_tax_code", id_param: nil}.freeze,
      "sales_tax_code.query" => {method: "GET", path: "sales-tax-codes", params_in: :query, paged: false, entity: "sales_tax_code", id_param: "list_id"}.freeze,
      "sales_tax_code.update" => {method: "PUT", path: "sales-tax-codes", params_in: :body, paged: false, entity: "sales_tax_code", id_param: nil}.freeze,
      "sales_tax_payable.query" => {method: "GET", path: "sales-tax-payables", params_in: :query, paged: false, entity: "sales_tax_payable", id_param: nil}.freeze,
      "sales_tax_payment_check.create" => {method: "POST", path: "sales-tax-payment-checks", params_in: :body, paged: false, entity: "sales_tax_payment_check", id_param: nil}.freeze,
      "sales_tax_payment_check.query" => {method: "GET", path: "sales-tax-payment-checks", params_in: :query, paged: true, entity: "sales_tax_payment_check", id_param: "txn_id"}.freeze,
      "sales_tax_payment_check.update" => {method: "PUT", path: "sales-tax-payment-checks", params_in: :body, paged: false, entity: "sales_tax_payment_check", id_param: nil}.freeze,
      "sales_tax_return.query" => {method: "GET", path: "sales-tax-returns", params_in: :query, paged: false, entity: "sales_tax_return", id_param: nil}.freeze,
      "sales_tax_return_line.query" => {method: "GET", path: "sales-tax-return-lines", params_in: :query, paged: false, entity: "sales_tax_return_line", id_param: nil}.freeze,
      "ship_method.create" => {method: "POST", path: "ship-methods", params_in: :body, paged: false, entity: "ship_method", id_param: nil}.freeze,
      "ship_method.query" => {method: "GET", path: "ship-methods", params_in: :query, paged: false, entity: "ship_method", id_param: "list_id"}.freeze,
      "special_account.create" => {method: "POST", path: "special-accounts", params_in: :body, paged: false, entity: "special_account", id_param: nil}.freeze,
      "special_item.create" => {method: "POST", path: "special-items", params_in: :body, paged: false, entity: "special_item", id_param: nil}.freeze,
      "standard_terms.create" => {method: "POST", path: "standard-terms", params_in: :body, paged: false, entity: "standard_terms", id_param: nil}.freeze,
      "standard_terms.query" => {method: "GET", path: "standard-terms", params_in: :query, paged: false, entity: "standard_terms", id_param: "list_id"}.freeze,
      "template.query" => {method: "GET", path: "templates", params_in: :query, paged: false, entity: "template", id_param: nil}.freeze,
      "terms.query" => {method: "GET", path: "terms", params_in: :query, paged: false, entity: "terms", id_param: "list_id"}.freeze,
      "time_report.query" => {method: "GET", path: "time-reports", params_in: :query, paged: false, entity: "time_report", id_param: nil}.freeze,
      "time_tracking.create" => {method: "POST", path: "time-trackings", params_in: :body, paged: false, entity: "time_tracking", id_param: nil}.freeze,
      "time_tracking.query" => {method: "GET", path: "time-trackings", params_in: :query, paged: true, entity: "time_tracking", id_param: "txn_id"}.freeze,
      "time_tracking.update" => {method: "PUT", path: "time-trackings", params_in: :body, paged: false, entity: "time_tracking", id_param: nil}.freeze,
      "to_do.create" => {method: "POST", path: "to-dos", params_in: :body, paged: false, entity: "to_do", id_param: nil}.freeze,
      "to_do.query" => {method: "GET", path: "to-dos", params_in: :query, paged: false, entity: "to_do", id_param: "list_id"}.freeze,
      "to_do.update" => {method: "PUT", path: "to-dos", params_in: :body, paged: false, entity: "to_do", id_param: nil}.freeze,
      "transaction.query" => {method: "GET", path: "transactions", params_in: :query, paged: true, entity: "transaction", id_param: "txn_id"}.freeze,
      "transfer.create" => {method: "POST", path: "transfers", params_in: :body, paged: false, entity: "transfer", id_param: nil}.freeze,
      "transfer.query" => {method: "GET", path: "transfers", params_in: :query, paged: true, entity: "transfer", id_param: "txn_id"}.freeze,
      "transfer.update" => {method: "PUT", path: "transfers", params_in: :body, paged: false, entity: "transfer", id_param: nil}.freeze,
      "transfer_inventory.create" => {method: "POST", path: "transfer-inventories", params_in: :body, paged: false, entity: "transfer_inventory", id_param: nil}.freeze,
      "transfer_inventory.query" => {method: "GET", path: "transfer-inventories", params_in: :query, paged: true, entity: "transfer_inventory", id_param: "txn_id"}.freeze,
      "transfer_inventory.update" => {method: "PUT", path: "transfer-inventories", params_in: :body, paged: false, entity: "transfer_inventory", id_param: nil}.freeze,
      "txn.delete" => {method: "DELETE", path: "txns", params_in: :body, paged: false, entity: "txn", id_param: nil}.freeze,
      "txn_deleted.query" => {method: "GET", path: "txn-deleteds", params_in: :query, paged: false, entity: "txn_deleted", id_param: nil}.freeze,
      "txn_display.create" => {method: "POST", path: "txn-displays", params_in: :body, paged: false, entity: "txn_display", id_param: nil}.freeze,
      "txn_display.update" => {method: "PUT", path: "txn-displays", params_in: :body, paged: false, entity: "txn_display", id_param: nil}.freeze,
      "txn_void.execute" => {method: "POST", path: "txn-void", params_in: :body, paged: false, entity: "txn_void", id_param: nil}.freeze,
      "unit_of_measure_set.create" => {method: "POST", path: "unit-of-measure-sets", params_in: :body, paged: false, entity: "unit_of_measure_set", id_param: nil}.freeze,
      "unit_of_measure_set.query" => {method: "GET", path: "unit-of-measure-sets", params_in: :query, paged: false, entity: "unit_of_measure_set", id_param: "list_id"}.freeze,
      "vehicle.create" => {method: "POST", path: "vehicles", params_in: :body, paged: false, entity: "vehicle", id_param: nil}.freeze,
      "vehicle.query" => {method: "GET", path: "vehicles", params_in: :query, paged: false, entity: "vehicle", id_param: "list_id"}.freeze,
      "vehicle.update" => {method: "PUT", path: "vehicles", params_in: :body, paged: false, entity: "vehicle", id_param: nil}.freeze,
      "vehicle_mileage.create" => {method: "POST", path: "vehicle-mileages", params_in: :body, paged: false, entity: "vehicle_mileage", id_param: nil}.freeze,
      "vehicle_mileage.query" => {method: "GET", path: "vehicle-mileages", params_in: :query, paged: true, entity: "vehicle_mileage", id_param: "txn_id"}.freeze,
      "vendor.create" => {method: "POST", path: "vendors", params_in: :body, paged: false, entity: "vendor", id_param: nil}.freeze,
      "vendor.query" => {method: "GET", path: "vendors", params_in: :query, paged: true, entity: "vendor", id_param: "list_id"}.freeze,
      "vendor.update" => {method: "PUT", path: "vendors", params_in: :body, paged: false, entity: "vendor", id_param: nil}.freeze,
      "vendor_credit.create" => {method: "POST", path: "vendor-credits", params_in: :body, paged: false, entity: "vendor_credit", id_param: nil}.freeze,
      "vendor_credit.query" => {method: "GET", path: "vendor-credits", params_in: :query, paged: true, entity: "vendor_credit", id_param: "txn_id"}.freeze,
      "vendor_credit.update" => {method: "PUT", path: "vendor-credits", params_in: :body, paged: false, entity: "vendor_credit", id_param: nil}.freeze,
      "vendor_type.create" => {method: "POST", path: "vendor-types", params_in: :body, paged: false, entity: "vendor_type", id_param: nil}.freeze,
      "vendor_type.query" => {method: "GET", path: "vendor-types", params_in: :query, paged: false, entity: "vendor_type", id_param: "list_id"}.freeze,
      "workers_comp_code.create" => {method: "POST", path: "workers-comp-codes", params_in: :body, paged: false, entity: "workers_comp_code", id_param: nil}.freeze,
      "workers_comp_code.query" => {method: "GET", path: "workers-comp-codes", params_in: :query, paged: false, entity: "workers_comp_code", id_param: "list_id"}.freeze,
      "workers_comp_code.update" => {method: "PUT", path: "workers-comp-codes", params_in: :body, paged: false, entity: "workers_comp_code", id_param: nil}.freeze
    }.freeze

    # Entity => its class's name.
    ENTITIES = {
      "account" => :Account,
      "account_tax_line_info" => :AccountTaxLineInfo,
      "aging_report" => :AgingReport,
      "alert" => :Alert,
      "ar_refund_credit_card" => :ArRefundCreditCard,
      "bar_code" => :BarCode,
      "bill" => :Bill,
      "bill_payment_check" => :BillPaymentCheck,
      "bill_payment_credit_card" => :BillPaymentCreditCard,
      "bill_to_pay" => :BillToPay,
      "billing_rate" => :BillingRate,
      "budget_summary_report" => :BudgetSummaryReport,
      "build_assembly" => :BuildAssembly,
      "charge" => :Charge,
      "check" => :Check,
      "class" => :Class_,
      "cleared_status" => :ClearedStatus,
      "company" => :Company,
      "company_activity" => :CompanyActivity,
      "credit_card_charge" => :CreditCardCharge,
      "credit_card_credit" => :CreditCardCredit,
      "credit_memo" => :CreditMemo,
      "currency" => :Currency,
      "custom_detail_report" => :CustomDetailReport,
      "custom_summary_report" => :CustomSummaryReport,
      "customer" => :Customer,
      "customer_msg" => :CustomerMsg,
      "customer_type" => :CustomerType,
      "data_event_recovery_info" => :DataEventRecoveryInfo,
      "data_ext" => :DataExt,
      "data_ext_def" => :DataExtDef,
      "date_driven_terms" => :DateDrivenTerms,
      "deposit" => :Deposit,
      "employee" => :Employee,
      "employee_default" => :EmployeeDefault,
      "entity" => :Entity,
      "estimate" => :Estimate,
      "form1099_category_account_mapping" => :Form1099CategoryAccountMapping,
      "general_detail_report" => :GeneralDetailReport,
      "general_summary_report" => :GeneralSummaryReport,
      "host" => :Host,
      "inventory_adjustment" => :InventoryAdjustment,
      "inventory_site" => :InventorySite,
      "invoice" => :Invoice,
      "item" => :Item,
      "item_assemblies_can_build" => :ItemAssembliesCanBuild,
      "item_discount" => :ItemDiscount,
      "item_fixed_asset" => :ItemFixedAsset,
      "item_group" => :ItemGroup,
      "item_inventory" => :ItemInventory,
      "item_inventory_assembly" => :ItemInventoryAssembly,
      "item_non_inventory" => :ItemNonInventory,
      "item_other_charge" => :ItemOtherCharge,
      "item_payment" => :ItemPayment,
      "item_receipt" => :ItemReceipt,
      "item_sales_tax" => :ItemSalesTax,
      "item_sales_tax_group" => :ItemSalesTaxGroup,
      "item_service" => :ItemService,
      "item_sites" => :ItemSites,
      "item_subtotal" => :ItemSubtotal,
      "job_report" => :JobReport,
      "job_type" => :JobType,
      "journal_entry" => :JournalEntry,
      "lead" => :Lead,
      "list" => :List,
      "list_deleted" => :ListDeleted,
      "list_display" => :ListDisplay,
      "list_merge" => :ListMerge,
      "other_name" => :OtherName,
      "paycheck" => :Paycheck,
      "payment_method" => :PaymentMethod,
      "payroll_detail_report" => :PayrollDetailReport,
      "payroll_item" => :PayrollItem,
      "payroll_item_addition" => :PayrollItemAddition,
      "payroll_item_company_contribution" => :PayrollItemCompanyContribution,
      "payroll_item_deduction" => :PayrollItemDeduction,
      "payroll_item_direct_deposit" => :PayrollItemDirectDeposit,
      "payroll_item_non_wage" => :PayrollItemNonWage,
      "payroll_item_tax" => :PayrollItemTax,
      "payroll_item_wage" => :PayrollItemWage,
      "payroll_item_workers_compensation" => :PayrollItemWorkersCompensation,
      "payroll_last_period" => :PayrollLastPeriod,
      "payroll_liability_adjustment" => :PayrollLiabilityAdjustment,
      "payroll_liability_check" => :PayrollLiabilityCheck,
      "payroll_prior_payment" => :PayrollPriorPayment,
      "payroll_summary_report" => :PayrollSummaryReport,
      "payroll_year_to_date_adjustment" => :PayrollYearToDateAdjustment,
      "preferences" => :Preferences,
      "price_level" => :PriceLevel,
      "purchase_order" => :PurchaseOrder,
      "qb_command_exec" => :QbCommandExec,
      "receive_payment" => :ReceivePayment,
      "receive_payment_to_deposit" => :ReceivePaymentToDeposit,
      "sales_order" => :SalesOrder,
      "sales_receipt" => :SalesReceipt,
      "sales_rep" => :SalesRep,
      "sales_tax_code" => :SalesTaxCode,
      "sales_tax_payable" => :SalesTaxPayable,
      "sales_tax_payment_check" => :SalesTaxPaymentCheck,
      "sales_tax_return" => :SalesTaxReturn,
      "sales_tax_return_line" => :SalesTaxReturnLine,
      "ship_method" => :ShipMethod,
      "special_account" => :SpecialAccount,
      "special_item" => :SpecialItem,
      "standard_terms" => :StandardTerms,
      "template" => :Template,
      "terms" => :Terms,
      "time_report" => :TimeReport,
      "time_tracking" => :TimeTracking,
      "to_do" => :ToDo,
      "transaction" => :Transaction,
      "transfer" => :Transfer,
      "transfer_inventory" => :TransferInventory,
      "txn" => :Txn,
      "txn_deleted" => :TxnDeleted,
      "txn_display" => :TxnDisplay,
      "txn_void" => :TxnVoid,
      "unit_of_measure_set" => :UnitOfMeasureSet,
      "vehicle" => :Vehicle,
      "vehicle_mileage" => :VehicleMileage,
      "vendor" => :Vendor,
      "vendor_credit" => :VendorCredit,
      "vendor_type" => :VendorType,
      "workers_comp_code" => :WorkersCompCode
    }.freeze

    # One entity's operations, bound to a client.
    class Base
      def initialize(client)
        @client = client
      end

      def inspect
        "#<#{self.class.name}>"
      end

      private

      def queue(operation_id, connection_id, params, webhook_url:, idempotency_key:)
        @client.queue(operation_id, connection_id, params, webhook_url: webhook_url, idempotency_key: idempotency_key)
      end
    end

    autoload :Account, File.expand_path("operations/account", __dir__)
    autoload :AccountTaxLineInfo, File.expand_path("operations/account_tax_line_info", __dir__)
    autoload :AgingReport, File.expand_path("operations/aging_report", __dir__)
    autoload :Alert, File.expand_path("operations/alert", __dir__)
    autoload :ArRefundCreditCard, File.expand_path("operations/ar_refund_credit_card", __dir__)
    autoload :BarCode, File.expand_path("operations/bar_code", __dir__)
    autoload :Bill, File.expand_path("operations/bill", __dir__)
    autoload :BillPaymentCheck, File.expand_path("operations/bill_payment_check", __dir__)
    autoload :BillPaymentCreditCard, File.expand_path("operations/bill_payment_credit_card", __dir__)
    autoload :BillToPay, File.expand_path("operations/bill_to_pay", __dir__)
    autoload :BillingRate, File.expand_path("operations/billing_rate", __dir__)
    autoload :BudgetSummaryReport, File.expand_path("operations/budget_summary_report", __dir__)
    autoload :BuildAssembly, File.expand_path("operations/build_assembly", __dir__)
    autoload :Charge, File.expand_path("operations/charge", __dir__)
    autoload :Check, File.expand_path("operations/check", __dir__)
    autoload :Class_, File.expand_path("operations/class", __dir__)
    autoload :ClearedStatus, File.expand_path("operations/cleared_status", __dir__)
    autoload :Company, File.expand_path("operations/company", __dir__)
    autoload :CompanyActivity, File.expand_path("operations/company_activity", __dir__)
    autoload :CreditCardCharge, File.expand_path("operations/credit_card_charge", __dir__)
    autoload :CreditCardCredit, File.expand_path("operations/credit_card_credit", __dir__)
    autoload :CreditMemo, File.expand_path("operations/credit_memo", __dir__)
    autoload :Currency, File.expand_path("operations/currency", __dir__)
    autoload :CustomDetailReport, File.expand_path("operations/custom_detail_report", __dir__)
    autoload :CustomSummaryReport, File.expand_path("operations/custom_summary_report", __dir__)
    autoload :Customer, File.expand_path("operations/customer", __dir__)
    autoload :CustomerMsg, File.expand_path("operations/customer_msg", __dir__)
    autoload :CustomerType, File.expand_path("operations/customer_type", __dir__)
    autoload :DataEventRecoveryInfo, File.expand_path("operations/data_event_recovery_info", __dir__)
    autoload :DataExt, File.expand_path("operations/data_ext", __dir__)
    autoload :DataExtDef, File.expand_path("operations/data_ext_def", __dir__)
    autoload :DateDrivenTerms, File.expand_path("operations/date_driven_terms", __dir__)
    autoload :Deposit, File.expand_path("operations/deposit", __dir__)
    autoload :Employee, File.expand_path("operations/employee", __dir__)
    autoload :EmployeeDefault, File.expand_path("operations/employee_default", __dir__)
    autoload :Entity, File.expand_path("operations/entity", __dir__)
    autoload :Estimate, File.expand_path("operations/estimate", __dir__)
    autoload :Form1099CategoryAccountMapping, File.expand_path("operations/form1099_category_account_mapping", __dir__)
    autoload :GeneralDetailReport, File.expand_path("operations/general_detail_report", __dir__)
    autoload :GeneralSummaryReport, File.expand_path("operations/general_summary_report", __dir__)
    autoload :Host, File.expand_path("operations/host", __dir__)
    autoload :InventoryAdjustment, File.expand_path("operations/inventory_adjustment", __dir__)
    autoload :InventorySite, File.expand_path("operations/inventory_site", __dir__)
    autoload :Invoice, File.expand_path("operations/invoice", __dir__)
    autoload :Item, File.expand_path("operations/item", __dir__)
    autoload :ItemAssembliesCanBuild, File.expand_path("operations/item_assemblies_can_build", __dir__)
    autoload :ItemDiscount, File.expand_path("operations/item_discount", __dir__)
    autoload :ItemFixedAsset, File.expand_path("operations/item_fixed_asset", __dir__)
    autoload :ItemGroup, File.expand_path("operations/item_group", __dir__)
    autoload :ItemInventory, File.expand_path("operations/item_inventory", __dir__)
    autoload :ItemInventoryAssembly, File.expand_path("operations/item_inventory_assembly", __dir__)
    autoload :ItemNonInventory, File.expand_path("operations/item_non_inventory", __dir__)
    autoload :ItemOtherCharge, File.expand_path("operations/item_other_charge", __dir__)
    autoload :ItemPayment, File.expand_path("operations/item_payment", __dir__)
    autoload :ItemReceipt, File.expand_path("operations/item_receipt", __dir__)
    autoload :ItemSalesTax, File.expand_path("operations/item_sales_tax", __dir__)
    autoload :ItemSalesTaxGroup, File.expand_path("operations/item_sales_tax_group", __dir__)
    autoload :ItemService, File.expand_path("operations/item_service", __dir__)
    autoload :ItemSites, File.expand_path("operations/item_sites", __dir__)
    autoload :ItemSubtotal, File.expand_path("operations/item_subtotal", __dir__)
    autoload :JobReport, File.expand_path("operations/job_report", __dir__)
    autoload :JobType, File.expand_path("operations/job_type", __dir__)
    autoload :JournalEntry, File.expand_path("operations/journal_entry", __dir__)
    autoload :Lead, File.expand_path("operations/lead", __dir__)
    autoload :List, File.expand_path("operations/list", __dir__)
    autoload :ListDeleted, File.expand_path("operations/list_deleted", __dir__)
    autoload :ListDisplay, File.expand_path("operations/list_display", __dir__)
    autoload :ListMerge, File.expand_path("operations/list_merge", __dir__)
    autoload :OtherName, File.expand_path("operations/other_name", __dir__)
    autoload :Paycheck, File.expand_path("operations/paycheck", __dir__)
    autoload :PaymentMethod, File.expand_path("operations/payment_method", __dir__)
    autoload :PayrollDetailReport, File.expand_path("operations/payroll_detail_report", __dir__)
    autoload :PayrollItem, File.expand_path("operations/payroll_item", __dir__)
    autoload :PayrollItemAddition, File.expand_path("operations/payroll_item_addition", __dir__)
    autoload :PayrollItemCompanyContribution, File.expand_path("operations/payroll_item_company_contribution", __dir__)
    autoload :PayrollItemDeduction, File.expand_path("operations/payroll_item_deduction", __dir__)
    autoload :PayrollItemDirectDeposit, File.expand_path("operations/payroll_item_direct_deposit", __dir__)
    autoload :PayrollItemNonWage, File.expand_path("operations/payroll_item_non_wage", __dir__)
    autoload :PayrollItemTax, File.expand_path("operations/payroll_item_tax", __dir__)
    autoload :PayrollItemWage, File.expand_path("operations/payroll_item_wage", __dir__)
    autoload :PayrollItemWorkersCompensation, File.expand_path("operations/payroll_item_workers_compensation", __dir__)
    autoload :PayrollLastPeriod, File.expand_path("operations/payroll_last_period", __dir__)
    autoload :PayrollLiabilityAdjustment, File.expand_path("operations/payroll_liability_adjustment", __dir__)
    autoload :PayrollLiabilityCheck, File.expand_path("operations/payroll_liability_check", __dir__)
    autoload :PayrollPriorPayment, File.expand_path("operations/payroll_prior_payment", __dir__)
    autoload :PayrollSummaryReport, File.expand_path("operations/payroll_summary_report", __dir__)
    autoload :PayrollYearToDateAdjustment, File.expand_path("operations/payroll_year_to_date_adjustment", __dir__)
    autoload :Preferences, File.expand_path("operations/preferences", __dir__)
    autoload :PriceLevel, File.expand_path("operations/price_level", __dir__)
    autoload :PurchaseOrder, File.expand_path("operations/purchase_order", __dir__)
    autoload :QbCommandExec, File.expand_path("operations/qb_command_exec", __dir__)
    autoload :ReceivePayment, File.expand_path("operations/receive_payment", __dir__)
    autoload :ReceivePaymentToDeposit, File.expand_path("operations/receive_payment_to_deposit", __dir__)
    autoload :SalesOrder, File.expand_path("operations/sales_order", __dir__)
    autoload :SalesReceipt, File.expand_path("operations/sales_receipt", __dir__)
    autoload :SalesRep, File.expand_path("operations/sales_rep", __dir__)
    autoload :SalesTaxCode, File.expand_path("operations/sales_tax_code", __dir__)
    autoload :SalesTaxPayable, File.expand_path("operations/sales_tax_payable", __dir__)
    autoload :SalesTaxPaymentCheck, File.expand_path("operations/sales_tax_payment_check", __dir__)
    autoload :SalesTaxReturn, File.expand_path("operations/sales_tax_return", __dir__)
    autoload :SalesTaxReturnLine, File.expand_path("operations/sales_tax_return_line", __dir__)
    autoload :ShipMethod, File.expand_path("operations/ship_method", __dir__)
    autoload :SpecialAccount, File.expand_path("operations/special_account", __dir__)
    autoload :SpecialItem, File.expand_path("operations/special_item", __dir__)
    autoload :StandardTerms, File.expand_path("operations/standard_terms", __dir__)
    autoload :Template, File.expand_path("operations/template", __dir__)
    autoload :Terms, File.expand_path("operations/terms", __dir__)
    autoload :TimeReport, File.expand_path("operations/time_report", __dir__)
    autoload :TimeTracking, File.expand_path("operations/time_tracking", __dir__)
    autoload :ToDo, File.expand_path("operations/to_do", __dir__)
    autoload :Transaction, File.expand_path("operations/transaction", __dir__)
    autoload :Transfer, File.expand_path("operations/transfer", __dir__)
    autoload :TransferInventory, File.expand_path("operations/transfer_inventory", __dir__)
    autoload :Txn, File.expand_path("operations/txn", __dir__)
    autoload :TxnDeleted, File.expand_path("operations/txn_deleted", __dir__)
    autoload :TxnDisplay, File.expand_path("operations/txn_display", __dir__)
    autoload :TxnVoid, File.expand_path("operations/txn_void", __dir__)
    autoload :UnitOfMeasureSet, File.expand_path("operations/unit_of_measure_set", __dir__)
    autoload :Vehicle, File.expand_path("operations/vehicle", __dir__)
    autoload :VehicleMileage, File.expand_path("operations/vehicle_mileage", __dir__)
    autoload :Vendor, File.expand_path("operations/vendor", __dir__)
    autoload :VendorCredit, File.expand_path("operations/vendor_credit", __dir__)
    autoload :VendorType, File.expand_path("operations/vendor_type", __dir__)
    autoload :WorkersCompCode, File.expand_path("operations/workers_comp_code", __dir__)
  end

  class Client
    # Account operations: create, query, update.
    def account
      @account_operations ||= Operations::Account.new(self)
    end

    # AccountTaxLineInfo operations: query.
    def account_tax_line_info
      @account_tax_line_info_operations ||= Operations::AccountTaxLineInfo.new(self)
    end

    # AgingReport operations: query.
    def aging_report
      @aging_report_operations ||= Operations::AgingReport.new(self)
    end

    # Alert operations: create, delete, query.
    def alert
      @alert_operations ||= Operations::Alert.new(self)
    end

    # ArRefundCreditCard operations: create, query.
    def ar_refund_credit_card
      @ar_refund_credit_card_operations ||= Operations::ArRefundCreditCard.new(self)
    end

    # BarCode operations: query.
    def bar_code
      @bar_code_operations ||= Operations::BarCode.new(self)
    end

    # Bill operations: create, query, update.
    def bill
      @bill_operations ||= Operations::Bill.new(self)
    end

    # BillPaymentCheck operations: create, query, update.
    def bill_payment_check
      @bill_payment_check_operations ||= Operations::BillPaymentCheck.new(self)
    end

    # BillPaymentCreditCard operations: create, query.
    def bill_payment_credit_card
      @bill_payment_credit_card_operations ||= Operations::BillPaymentCreditCard.new(self)
    end

    # BillToPay operations: query.
    def bill_to_pay
      @bill_to_pay_operations ||= Operations::BillToPay.new(self)
    end

    # BillingRate operations: create, query.
    def billing_rate
      @billing_rate_operations ||= Operations::BillingRate.new(self)
    end

    # BudgetSummaryReport operations: query.
    def budget_summary_report
      @budget_summary_report_operations ||= Operations::BudgetSummaryReport.new(self)
    end

    # BuildAssembly operations: create, query, update.
    def build_assembly
      @build_assembly_operations ||= Operations::BuildAssembly.new(self)
    end

    # Charge operations: create, query, update.
    def charge
      @charge_operations ||= Operations::Charge.new(self)
    end

    # Check operations: create, query, update.
    def check
      @check_operations ||= Operations::Check.new(self)
    end

    # Class operations: create, query, update.
    def class_
      @class_operations ||= Operations::Class_.new(self)
    end

    # ClearedStatus operations: update.
    def cleared_status
      @cleared_status_operations ||= Operations::ClearedStatus.new(self)
    end

    # Company operations: query.
    def company
      @company_operations ||= Operations::Company.new(self)
    end

    # CompanyActivity operations: query.
    def company_activity
      @company_activity_operations ||= Operations::CompanyActivity.new(self)
    end

    # CreditCardCharge operations: create, query, update.
    def credit_card_charge
      @credit_card_charge_operations ||= Operations::CreditCardCharge.new(self)
    end

    # CreditCardCredit operations: create, query, update.
    def credit_card_credit
      @credit_card_credit_operations ||= Operations::CreditCardCredit.new(self)
    end

    # CreditMemo operations: create, query, update.
    def credit_memo
      @credit_memo_operations ||= Operations::CreditMemo.new(self)
    end

    # Currency operations: create, query, update.
    def currency
      @currency_operations ||= Operations::Currency.new(self)
    end

    # CustomDetailReport operations: query.
    def custom_detail_report
      @custom_detail_report_operations ||= Operations::CustomDetailReport.new(self)
    end

    # CustomSummaryReport operations: query.
    def custom_summary_report
      @custom_summary_report_operations ||= Operations::CustomSummaryReport.new(self)
    end

    # Customer operations: create, query, update.
    def customer
      @customer_operations ||= Operations::Customer.new(self)
    end

    # CustomerMsg operations: create, query.
    def customer_msg
      @customer_msg_operations ||= Operations::CustomerMsg.new(self)
    end

    # CustomerType operations: create, query.
    def customer_type
      @customer_type_operations ||= Operations::CustomerType.new(self)
    end

    # DataEventRecoveryInfo operations: delete, query.
    def data_event_recovery_info
      @data_event_recovery_info_operations ||= Operations::DataEventRecoveryInfo.new(self)
    end

    # DataExt operations: create, delete, update.
    def data_ext
      @data_ext_operations ||= Operations::DataExt.new(self)
    end

    # DataExtDef operations: create, delete, query, update.
    def data_ext_def
      @data_ext_def_operations ||= Operations::DataExtDef.new(self)
    end

    # DateDrivenTerms operations: create, query.
    def date_driven_terms
      @date_driven_terms_operations ||= Operations::DateDrivenTerms.new(self)
    end

    # Deposit operations: create, query, update.
    def deposit
      @deposit_operations ||= Operations::Deposit.new(self)
    end

    # Employee operations: create, query, update.
    def employee
      @employee_operations ||= Operations::Employee.new(self)
    end

    # EmployeeDefault operations: query, update.
    def employee_default
      @employee_default_operations ||= Operations::EmployeeDefault.new(self)
    end

    # Entity operations: query.
    def entity
      @entity_operations ||= Operations::Entity.new(self)
    end

    # Estimate operations: create, query, update.
    def estimate
      @estimate_operations ||= Operations::Estimate.new(self)
    end

    # Form1099CategoryAccountMapping operations: query, update.
    def form1099_category_account_mapping
      @form1099_category_account_mapping_operations ||= Operations::Form1099CategoryAccountMapping.new(self)
    end

    # GeneralDetailReport operations: query.
    def general_detail_report
      @general_detail_report_operations ||= Operations::GeneralDetailReport.new(self)
    end

    # GeneralSummaryReport operations: query.
    def general_summary_report
      @general_summary_report_operations ||= Operations::GeneralSummaryReport.new(self)
    end

    # Host operations: query.
    def host
      @host_operations ||= Operations::Host.new(self)
    end

    # InventoryAdjustment operations: create, query, update.
    def inventory_adjustment
      @inventory_adjustment_operations ||= Operations::InventoryAdjustment.new(self)
    end

    # InventorySite operations: create, query, update.
    def inventory_site
      @inventory_site_operations ||= Operations::InventorySite.new(self)
    end

    # Invoice operations: create, query, update.
    def invoice
      @invoice_operations ||= Operations::Invoice.new(self)
    end

    # Item operations: query.
    def item
      @item_operations ||= Operations::Item.new(self)
    end

    # ItemAssembliesCanBuild operations: query.
    def item_assemblies_can_build
      @item_assemblies_can_build_operations ||= Operations::ItemAssembliesCanBuild.new(self)
    end

    # ItemDiscount operations: create, query, update.
    def item_discount
      @item_discount_operations ||= Operations::ItemDiscount.new(self)
    end

    # ItemFixedAsset operations: create, query, update.
    def item_fixed_asset
      @item_fixed_asset_operations ||= Operations::ItemFixedAsset.new(self)
    end

    # ItemGroup operations: create, query, update.
    def item_group
      @item_group_operations ||= Operations::ItemGroup.new(self)
    end

    # ItemInventory operations: create, query, update.
    def item_inventory
      @item_inventory_operations ||= Operations::ItemInventory.new(self)
    end

    # ItemInventoryAssembly operations: create, query, update.
    def item_inventory_assembly
      @item_inventory_assembly_operations ||= Operations::ItemInventoryAssembly.new(self)
    end

    # ItemNonInventory operations: create, query, update.
    def item_non_inventory
      @item_non_inventory_operations ||= Operations::ItemNonInventory.new(self)
    end

    # ItemOtherCharge operations: create, query, update.
    def item_other_charge
      @item_other_charge_operations ||= Operations::ItemOtherCharge.new(self)
    end

    # ItemPayment operations: create, query, update.
    def item_payment
      @item_payment_operations ||= Operations::ItemPayment.new(self)
    end

    # ItemReceipt operations: create, query, update.
    def item_receipt
      @item_receipt_operations ||= Operations::ItemReceipt.new(self)
    end

    # ItemSalesTax operations: create, query, update.
    def item_sales_tax
      @item_sales_tax_operations ||= Operations::ItemSalesTax.new(self)
    end

    # ItemSalesTaxGroup operations: create, query, update.
    def item_sales_tax_group
      @item_sales_tax_group_operations ||= Operations::ItemSalesTaxGroup.new(self)
    end

    # ItemService operations: create, query, update.
    def item_service
      @item_service_operations ||= Operations::ItemService.new(self)
    end

    # ItemSites operations: query.
    def item_sites
      @item_sites_operations ||= Operations::ItemSites.new(self)
    end

    # ItemSubtotal operations: create, query, update.
    def item_subtotal
      @item_subtotal_operations ||= Operations::ItemSubtotal.new(self)
    end

    # JobReport operations: query.
    def job_report
      @job_report_operations ||= Operations::JobReport.new(self)
    end

    # JobType operations: create, query.
    def job_type
      @job_type_operations ||= Operations::JobType.new(self)
    end

    # JournalEntry operations: create, query, update.
    def journal_entry
      @journal_entry_operations ||= Operations::JournalEntry.new(self)
    end

    # Lead operations: create, query, update.
    def lead
      @lead_operations ||= Operations::Lead.new(self)
    end

    # List operations: delete.
    def list
      @list_operations ||= Operations::List.new(self)
    end

    # ListDeleted operations: query.
    def list_deleted
      @list_deleted_operations ||= Operations::ListDeleted.new(self)
    end

    # ListDisplay operations: create, update.
    def list_display
      @list_display_operations ||= Operations::ListDisplay.new(self)
    end

    # ListMerge operations: execute.
    def list_merge
      @list_merge_operations ||= Operations::ListMerge.new(self)
    end

    # OtherName operations: create, query, update.
    def other_name
      @other_name_operations ||= Operations::OtherName.new(self)
    end

    # Paycheck operations: query.
    def paycheck
      @paycheck_operations ||= Operations::Paycheck.new(self)
    end

    # PaymentMethod operations: create, query.
    def payment_method
      @payment_method_operations ||= Operations::PaymentMethod.new(self)
    end

    # PayrollDetailReport operations: query.
    def payroll_detail_report
      @payroll_detail_report_operations ||= Operations::PayrollDetailReport.new(self)
    end

    # PayrollItem operations: query.
    def payroll_item
      @payroll_item_operations ||= Operations::PayrollItem.new(self)
    end

    # PayrollItemAddition operations: create, update.
    def payroll_item_addition
      @payroll_item_addition_operations ||= Operations::PayrollItemAddition.new(self)
    end

    # PayrollItemCompanyContribution operations: create, update.
    def payroll_item_company_contribution
      @payroll_item_company_contribution_operations ||= Operations::PayrollItemCompanyContribution.new(self)
    end

    # PayrollItemDeduction operations: create, update.
    def payroll_item_deduction
      @payroll_item_deduction_operations ||= Operations::PayrollItemDeduction.new(self)
    end

    # PayrollItemDirectDeposit operations: create, update.
    def payroll_item_direct_deposit
      @payroll_item_direct_deposit_operations ||= Operations::PayrollItemDirectDeposit.new(self)
    end

    # PayrollItemNonWage operations: query.
    def payroll_item_non_wage
      @payroll_item_non_wage_operations ||= Operations::PayrollItemNonWage.new(self)
    end

    # PayrollItemTax operations: create, update.
    def payroll_item_tax
      @payroll_item_tax_operations ||= Operations::PayrollItemTax.new(self)
    end

    # PayrollItemWage operations: create, query, update.
    def payroll_item_wage
      @payroll_item_wage_operations ||= Operations::PayrollItemWage.new(self)
    end

    # PayrollItemWorkersCompensation operations: create, update.
    def payroll_item_workers_compensation
      @payroll_item_workers_compensation_operations ||= Operations::PayrollItemWorkersCompensation.new(self)
    end

    # PayrollLastPeriod operations: query.
    def payroll_last_period
      @payroll_last_period_operations ||= Operations::PayrollLastPeriod.new(self)
    end

    # PayrollLiabilityAdjustment operations: create, query.
    def payroll_liability_adjustment
      @payroll_liability_adjustment_operations ||= Operations::PayrollLiabilityAdjustment.new(self)
    end

    # PayrollLiabilityCheck operations: query.
    def payroll_liability_check
      @payroll_liability_check_operations ||= Operations::PayrollLiabilityCheck.new(self)
    end

    # PayrollPriorPayment operations: create, query.
    def payroll_prior_payment
      @payroll_prior_payment_operations ||= Operations::PayrollPriorPayment.new(self)
    end

    # PayrollSummaryReport operations: query.
    def payroll_summary_report
      @payroll_summary_report_operations ||= Operations::PayrollSummaryReport.new(self)
    end

    # PayrollYearToDateAdjustment operations: create, query.
    def payroll_year_to_date_adjustment
      @payroll_year_to_date_adjustment_operations ||= Operations::PayrollYearToDateAdjustment.new(self)
    end

    # Preferences operations: query, update.
    def preferences
      @preferences_operations ||= Operations::Preferences.new(self)
    end

    # PriceLevel operations: create, query, update.
    def price_level
      @price_level_operations ||= Operations::PriceLevel.new(self)
    end

    # PurchaseOrder operations: create, query, update.
    def purchase_order
      @purchase_order_operations ||= Operations::PurchaseOrder.new(self)
    end

    # QbCommandExec operations: execute.
    def qb_command_exec
      @qb_command_exec_operations ||= Operations::QbCommandExec.new(self)
    end

    # ReceivePayment operations: create, query, update.
    def receive_payment
      @receive_payment_operations ||= Operations::ReceivePayment.new(self)
    end

    # ReceivePaymentToDeposit operations: query.
    def receive_payment_to_deposit
      @receive_payment_to_deposit_operations ||= Operations::ReceivePaymentToDeposit.new(self)
    end

    # SalesOrder operations: create, query, update.
    def sales_order
      @sales_order_operations ||= Operations::SalesOrder.new(self)
    end

    # SalesReceipt operations: create, query, update.
    def sales_receipt
      @sales_receipt_operations ||= Operations::SalesReceipt.new(self)
    end

    # SalesRep operations: create, query, update.
    def sales_rep
      @sales_rep_operations ||= Operations::SalesRep.new(self)
    end

    # SalesTaxCode operations: create, query, update.
    def sales_tax_code
      @sales_tax_code_operations ||= Operations::SalesTaxCode.new(self)
    end

    # SalesTaxPayable operations: query.
    def sales_tax_payable
      @sales_tax_payable_operations ||= Operations::SalesTaxPayable.new(self)
    end

    # SalesTaxPaymentCheck operations: create, query, update.
    def sales_tax_payment_check
      @sales_tax_payment_check_operations ||= Operations::SalesTaxPaymentCheck.new(self)
    end

    # SalesTaxReturn operations: query.
    def sales_tax_return
      @sales_tax_return_operations ||= Operations::SalesTaxReturn.new(self)
    end

    # SalesTaxReturnLine operations: query.
    def sales_tax_return_line
      @sales_tax_return_line_operations ||= Operations::SalesTaxReturnLine.new(self)
    end

    # ShipMethod operations: create, query.
    def ship_method
      @ship_method_operations ||= Operations::ShipMethod.new(self)
    end

    # SpecialAccount operations: create.
    def special_account
      @special_account_operations ||= Operations::SpecialAccount.new(self)
    end

    # SpecialItem operations: create.
    def special_item
      @special_item_operations ||= Operations::SpecialItem.new(self)
    end

    # StandardTerms operations: create, query.
    def standard_terms
      @standard_terms_operations ||= Operations::StandardTerms.new(self)
    end

    # Template operations: query.
    def template
      @template_operations ||= Operations::Template.new(self)
    end

    # Terms operations: query.
    def terms
      @terms_operations ||= Operations::Terms.new(self)
    end

    # TimeReport operations: query.
    def time_report
      @time_report_operations ||= Operations::TimeReport.new(self)
    end

    # TimeTracking operations: create, query, update.
    def time_tracking
      @time_tracking_operations ||= Operations::TimeTracking.new(self)
    end

    # ToDo operations: create, query, update.
    def to_do
      @to_do_operations ||= Operations::ToDo.new(self)
    end

    # Transaction operations: query.
    def transaction
      @transaction_operations ||= Operations::Transaction.new(self)
    end

    # Transfer operations: create, query, update.
    def transfer
      @transfer_operations ||= Operations::Transfer.new(self)
    end

    # TransferInventory operations: create, query, update.
    def transfer_inventory
      @transfer_inventory_operations ||= Operations::TransferInventory.new(self)
    end

    # Txn operations: delete.
    def txn
      @txn_operations ||= Operations::Txn.new(self)
    end

    # TxnDeleted operations: query.
    def txn_deleted
      @txn_deleted_operations ||= Operations::TxnDeleted.new(self)
    end

    # TxnDisplay operations: create, update.
    def txn_display
      @txn_display_operations ||= Operations::TxnDisplay.new(self)
    end

    # TxnVoid operations: execute.
    def txn_void
      @txn_void_operations ||= Operations::TxnVoid.new(self)
    end

    # UnitOfMeasureSet operations: create, query.
    def unit_of_measure_set
      @unit_of_measure_set_operations ||= Operations::UnitOfMeasureSet.new(self)
    end

    # Vehicle operations: create, query, update.
    def vehicle
      @vehicle_operations ||= Operations::Vehicle.new(self)
    end

    # VehicleMileage operations: create, query.
    def vehicle_mileage
      @vehicle_mileage_operations ||= Operations::VehicleMileage.new(self)
    end

    # Vendor operations: create, query, update.
    def vendor
      @vendor_operations ||= Operations::Vendor.new(self)
    end

    # VendorCredit operations: create, query, update.
    def vendor_credit
      @vendor_credit_operations ||= Operations::VendorCredit.new(self)
    end

    # VendorType operations: create, query.
    def vendor_type
      @vendor_type_operations ||= Operations::VendorType.new(self)
    end

    # WorkersCompCode operations: create, query, update.
    def workers_comp_code
      @workers_comp_code_operations ||= Operations::WorkersCompCode.new(self)
    end
  end
end
