-- IDEMPIERE-4567 Resetting payment allocation to a charge leaves wrong BP Balance
-- Nov 26, 2020, 9:35:38 AM CET
UPDATE C_BPartner bp
SET
SO_CreditUsed =
  COALESCE((SELECT SUM(currencyBase(invoiceOpen(i.C_Invoice_ID,i.C_InvoicePaySchedule_ID),i.C_Currency_ID,i.DateInvoiced, i.AD_Client_ID,i.AD_Org_ID)) FROM C_Invoice_v i
  WHERE i.C_BPartner_ID=bp.C_BPartner_ID AND i.IsSOTrx='Y' AND i.IsPaid='N' AND i.DocStatus IN ('CO','CL')),0),
TotalOpenBalance =
  COALESCE((SELECT SUM(currencyBase(invoiceOpen(i.C_Invoice_ID,i.C_InvoicePaySchedule_ID),i.C_Currency_ID,i.DateInvoiced, i.AD_Client_ID,i.AD_Org_ID)*i.MultiplierAP) FROM C_Invoice_v i
  WHERE i.C_BPartner_ID=bp.C_BPartner_ID AND i.IsPaid='N' AND i.DocStatus IN ('CO','CL')),0) -
  COALESCE((SELECT SUM(currencyBase(Paymentavailable(p.C_Payment_ID),p.C_Currency_ID,p.DateTrx,p.AD_Client_ID,p.AD_Org_ID)) FROM C_Payment_v p
  WHERE p.C_BPartner_ID=bp.C_BPartner_ID AND p.IsAllocated='N'
  AND p.C_Charge_ID IS NULL AND p.DocStatus IN ('CO','CL')),0)
WHERE AD_Client_ID = 11 AND (
SO_CreditUsed !=
  COALESCE((SELECT SUM(currencyBase(invoiceOpen(i.C_Invoice_ID,i.C_InvoicePaySchedule_ID),i.C_Currency_ID,i.DateInvoiced, i.AD_Client_ID,i.AD_Org_ID)) FROM C_Invoice_v i
  WHERE i.C_BPartner_ID=bp.C_BPartner_ID AND i.IsSOTrx='Y' AND i.IsPaid='N' AND i.DocStatus IN ('CO','CL')),0)
OR
TotalOpenBalance !=
  COALESCE((SELECT SUM(currencyBase(invoiceOpen(i.C_Invoice_ID,i.C_InvoicePaySchedule_ID),i.C_Currency_ID,i.DateInvoiced, i.AD_Client_ID,i.AD_Org_ID)*i.MultiplierAP) FROM C_Invoice_v i
  WHERE i.C_BPartner_ID=bp.C_BPartner_ID AND i.IsPaid='N' AND i.DocStatus IN ('CO','CL')),0) -
  COALESCE((SELECT SUM(currencyBase(Paymentavailable(p.C_Payment_ID),p.C_Currency_ID,p.DateTrx,p.AD_Client_ID,p.AD_Org_ID)) FROM C_Payment_v p
  WHERE p.C_BPartner_ID=bp.C_BPartner_ID AND p.IsAllocated='N'
  AND p.C_Charge_ID IS NULL AND p.DocStatus IN ('CO','CL')),0)
)
;

SELECT register_migration_script('202011260936_IDEMPIERE-4567.sql') FROM dual
;

