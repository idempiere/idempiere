-- IDEMPIERE-7074 Assign Business Partner fields to the complex (200001) or simplified (200025) info window
SELECT register_migration_script('202609020910_IDEMPIERE-7074.sql') FROM dual;

-- Sep 2, 2026, 9:10:00 AM
-- IDEMPIERE-7074
-- Generic: every existing Business Partner reference column keeps the complex window,
-- this is what makes the change of the table default below backward compatible.
-- The references are resolved through AD_Ref_Table for Search, Table and Table Direct
-- references pointing to C_BPartner (DropShip_BPartner_ID, Pay_BPartner_ID,
-- ReturnBPartner_ID, C_BPartnerSR_ID, C_Employee_ID, ...), references without
-- AD_Reference_Value_ID take the lookup table from the column name and are covered by
-- name (C_BPartner_ID, Bill_BPartner_ID, e.g. Fact_Reconciliation.C_BPartner_ID).
-- There is no AD_Client_ID filter, so columns of windows created by customers are
-- pinned to the complex window as well.
-- The "AD_InfoWindow_ID IS NULL" condition ensures columns created after this script
-- (new fields) are not touched - they resolve to the table default (simplified window).
UPDATE AD_Column SET AD_InfoWindow_ID = 200001
WHERE AD_InfoWindow_ID IS NULL
  AND ( ColumnName IN ('C_BPartner_ID','Bill_BPartner_ID')
     OR EXISTS (SELECT 1 FROM AD_Ref_Table rt
                JOIN AD_Table t ON t.AD_Table_ID = rt.AD_Table_ID
                WHERE rt.AD_Reference_ID = AD_Column.AD_Reference_Value_ID
                  AND t.TableName = 'C_BPartner') )
;

-- Sep 2, 2026, 9:10:01 AM
-- IDEMPIERE-7074
-- Explicit: the CORE Business Partner columns that can not use the selection are
-- reset to NULL, so they follow the table default info window
-- (the simplified window - one row per partner, no contact/location columns).
-- The criterion is not "no callout" but "no callout that consumes the selection":
-- the only core callouts reading AD_User_ID or C_BPartner_Location_ID from the info
-- selection are CalloutOrder.bPartner, CalloutOrder.bPartnerBill,
-- CalloutInvoice.bPartner and CalloutInvoiceBatch.bPartner, and their columns
-- (C_Order.C_BPartner_ID, C_Order.Bill_BPartner_ID, C_Invoice.C_BPartner_ID and
-- C_InvoiceBatchLine.C_BPartner_ID) stay on the complex window pinned above.
-- NULL instead of a pinned window id keeps them on the current table default
-- if the default is changed later.
UPDATE AD_Column SET AD_InfoWindow_ID = NULL
WHERE AD_Client_ID = 0
  AND AD_InfoWindow_ID = 200001
  AND EXISTS (SELECT 1 FROM AD_Table t
              WHERE t.AD_Table_ID = AD_Column.AD_Table_ID
                AND t.TableName || '.' || AD_Column.ColumnName IN (
                  'C_AllocationLine.C_BPartner_ID',
                  'C_BankStatementLine.C_BPartner_ID',
                  'C_BPartner.C_BPartnerSR_ID',
                  'C_BPartner_Product.C_BPartner_ID',
                  'C_BP_Customer_Acct.C_BPartner_ID',
                  'C_BP_Vendor_Acct.C_BPartner_ID',
                  'C_BP_Employee_Acct.C_BPartner_ID',
                  'C_BP_Withholding.C_BPartner_ID',
                  'C_BP_EDI.C_BPartner_ID',
                  'C_CashPlan.C_BPartner_ID',
                  'C_CashPlanLine.C_BPartner_ID',
                  'C_Charge.C_BPartner_ID',
                  'C_Commission.C_BPartner_ID',
                  'C_CommissionLine.C_BPartner_ID',
                  'C_Payment.C_BPartner_ID',
                  'C_PaymentTransaction.C_BPartner_ID',
                  'C_PaySelectionCheck.C_BPartner_ID',
                  'C_Subscription.C_BPartner_ID',
                  'C_TaxDeclarationAcct.C_BPartner_ID',
                  'C_TaxDeclarationLine.C_BPartner_ID',
                  'C_ValidCombination.C_BPartner_ID',
                  'GL_JournalLine.C_BPartner_ID',
                  'GL_JournalLine.C_Employee_ID',
                  'M_BP_Price.C_BPartner_ID',
                  'M_DiscountSchemaLine.C_BPartner_ID',
                  'M_Production.C_BPartner_ID',
                  'M_Product_PO.C_BPartner_ID',
                  'M_ProductPriceVendorBreak.C_BPartner_ID',
                  'M_RequisitionLine.C_BPartner_ID',
                  'M_RMA.C_BPartner_ID',
                  'M_Shipper.C_BPartner_ID',
                  'PA_GoalRestriction.C_BPartner_ID',
                  'PA_ReportSource.C_BPartner_ID',
                  'PA_SLA_Goal.C_BPartner_ID',
                  'S_TimeExpense.C_BPartner_ID',
                  'S_TimeExpenseLine.C_BPartner_ID',
                  'AD_User.C_BPartner_ID',
                  'A_Asset_Info_Fin.C_BPartner_ID',
                  'C_AcctSchema_Element.C_BPartner_ID'
                ) )
;
