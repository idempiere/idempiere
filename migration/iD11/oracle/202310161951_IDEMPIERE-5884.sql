-- IDEMPIERE-5884 Query on RV_OpenItem too slow
SELECT register_migration_script('202310161951_IDEMPIERE-5884.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 16, 2023, 7:51:34 PM CEST
UPDATE AD_ViewComponent SET WhereClause='WHERE i.ispaid=''N'' AND invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) <> 0 AND i.ispayschedulevalid = ''Y'' AND (i.docstatus IN (''CO'', ''CL'')) AND ips.isvalid = ''Y''',Updated=TO_TIMESTAMP('2023-10-16 19:51:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200153
;

-- Oct 16, 2023, 7:51:39 PM CEST
UPDATE AD_ViewComponent SET WhereClause='WHERE i.ispaid=''N'' AND invoiceopen(i.c_invoice_id, 0) <> 0 AND i.ispayschedulevalid <> ''Y'' AND (i.docstatus IN (''CO'', ''CL''))',Updated=TO_TIMESTAMP('2023-10-16 19:51:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewComponent_ID=200152
;

-- Oct 16, 2023, 7:51:46 PM CEST
CREATE OR REPLACE VIEW RV_OpenItem(AD_Org_ID, AD_Client_ID, DocumentNo, C_Invoice_ID, C_Order_ID, C_BPartner_ID, IsSOTrx, DateInvoiced, DateAcct, NetDays, DueDate, DaysDue, DiscountDate, DiscountAmt, GrandTotal, PaidAmt, OpenAmt, C_Currency_ID, C_ConversionType_ID, C_PaymentTerm_ID, IsPayScheduleValid, C_InvoicePaySchedule_ID, InvoiceCollectionType, C_Campaign_ID, C_Project_ID, C_Activity_ID, AD_OrgTrx_ID, AD_User_ID, C_BPartner_Location_ID, C_Charge_ID, C_DocType_ID, C_DocTypeTarget_ID, C_DunningLevel_ID, ChargeAmt, C_Payment_ID, Created, CreatedBy, DateOrdered, DatePrinted, Description, DocAction, DocStatus, DunningGrace, GenerateTo, IsActive, IsApproved, IsDiscountPrinted, IsInDispute, IsPaid, IsPrinted, IsSelfService, IsTaxIncluded, IsTransferred, M_PriceList_ID, M_RMA_ID, PaymentRule, POReference, Posted, ProcessedOn, Processing, Ref_Invoice_ID, Reversal_ID, SalesRep_ID, SendEMail, TotalLines, Updated, UpdatedBy, User1_ID, User2_ID) AS SELECT i.ad_org_id AS AD_Org_ID, i.ad_client_id AS AD_Client_ID, i.documentno AS DocumentNo, i.c_invoice_id AS C_Invoice_ID, i.c_order_id AS C_Order_ID, i.c_bpartner_id AS C_BPartner_ID, i.issotrx AS IsSOTrx, i.dateinvoiced AS DateInvoiced, i.dateacct AS DateAcct, p.netdays AS NetDays, paymenttermduedate(i.c_paymentterm_id, i.dateinvoiced) AS DueDate, paymenttermduedays(i.c_paymentterm_id, i.dateinvoiced, getdate()) AS DaysDue, adddays(i.dateinvoiced, p.discountdays) AS DiscountDate, currencyround(i.grandtotal * p.discount / 100, i.c_currency_id, 'N') AS DiscountAmt, i.grandtotal AS GrandTotal, invoicepaid(i.c_invoice_id, i.c_currency_id, 1) AS PaidAmt, invoiceopen(i.c_invoice_id, 0) AS OpenAmt, i.c_currency_id AS C_Currency_ID, i.c_conversiontype_id AS C_ConversionType_ID, i.c_paymentterm_id AS C_PaymentTerm_ID, i.ispayschedulevalid AS IsPayScheduleValid, NULL AS C_InvoicePaySchedule_ID, i.invoicecollectiontype AS InvoiceCollectionType, i.c_campaign_id AS C_Campaign_ID, i.c_project_id AS C_Project_ID, i.c_activity_id AS C_Activity_ID, i.c_invoice_ad_orgtrx_id AS AD_OrgTrx_ID, i.ad_user_id AS AD_User_ID, i.c_bpartner_location_id AS C_BPartner_Location_ID, i.c_charge_id AS C_Charge_ID, i.c_doctype_id AS C_DocType_ID, i.c_doctypetarget_id AS C_DocTypeTarget_ID, i.c_dunninglevel_id AS C_DunningLevel_ID, i.chargeamt AS ChargeAmt, i.c_payment_id AS C_Payment_ID, i.created AS Created, i.createdby AS CreatedBy, i.dateordered AS DateOrdered, i.dateprinted AS DatePrinted, i.description AS Description, i.docaction AS DocAction,
i.docstatus AS DocStatus, i.dunninggrace AS DunningGrace, i.generateto AS GenerateTo, i.isactive AS IsActive, i.isapproved AS IsApproved, i.isdiscountprinted AS IsDiscountPrinted, i.isindispute AS IsInDispute, i.ispaid AS IsPaid, i.isprinted AS IsPrinted, i.c_invoice_isselfservice AS IsSelfService, i.istaxincluded AS IsTaxIncluded, i.istransferred AS IsTransferred, i.m_pricelist_id AS M_PriceList_ID, i.m_rma_id AS M_RMA_ID, i.paymentrule AS PaymentRule, i.poreference AS POReference, i.posted AS Posted, i.processedon AS ProcessedOn, i.processing AS Processing, i.ref_invoice_id AS Ref_Invoice_ID, i.reversal_id AS Reversal_ID, i.salesrep_id AS SalesRep_ID, i.sendemail AS SendEMail, i.totallines AS TotalLines, i.updated AS Updated, i.updatedby AS UpdatedBy, i.user1_id AS User1_ID, i.user2_id AS User2_ID FROM rv_c_invoice i
JOIN c_paymentterm p ON i.c_paymentterm_id = p.c_paymentterm_id WHERE i.ispaid='N' AND invoiceopen(i.c_invoice_id, 0) <> 0 AND i.ispayschedulevalid <> 'Y' AND (i.docstatus IN ('CO', 'CL')) UNION SELECT i.ad_org_id AS AD_Org_ID, i.ad_client_id AS AD_Client_ID, i.documentno AS DocumentNo, i.c_invoice_id AS C_Invoice_ID, i.c_order_id AS C_Order_ID, i.c_bpartner_id AS C_BPartner_ID, i.issotrx AS IsSOTrx, i.dateinvoiced AS DateInvoiced, i.dateacct AS DateAcct, daysbetween(ips.duedate, i.dateinvoiced) AS NetDays, ips.duedate AS DueDate, daysbetween(getdate(), ips.duedate) AS DaysDue, ips.discountdate AS DiscountDate, ips.discountamt AS DiscountAmt, ips.dueamt AS GrandTotal, invoicepaid(i.c_invoice_id, i.c_currency_id, 1) AS PaidAmt, invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) AS OpenAmt, i.c_currency_id AS C_Currency_ID, i.c_conversiontype_id AS C_ConversionType_ID, i.c_paymentterm_id AS C_PaymentTerm_ID, i.ispayschedulevalid AS IsPayScheduleValid, ips.c_invoicepayschedule_id AS C_InvoicePaySchedule_ID, i.invoicecollectiontype AS InvoiceCollectionType, i.c_campaign_id AS C_Campaign_ID, i.c_project_id AS C_Project_ID, i.c_activity_id AS C_Activity_ID, i.c_invoice_ad_orgtrx_id AS AD_OrgTrx_ID, i.ad_user_id AS AD_User_ID, i.c_bpartner_location_id AS C_BPartner_Location_ID, i.c_charge_id AS C_Charge_ID, i.c_doctype_id AS C_DocType_ID, i.c_doctypetarget_id AS C_DocTypeTarget_ID, i.c_dunninglevel_id AS C_DunningLevel_ID, i.chargeamt AS ChargeAmt, i.c_payment_id AS C_Payment_ID, i.created AS Created, i.createdby AS CreatedBy, i.dateordered AS DateOrdered, i.dateprinted AS DatePrinted, i.description AS Description, i.docaction AS DocAction, i.docstatus AS DocStatus, i.dunninggrace AS DunningGrace, i.generateto AS GenerateTo, i.isactive AS IsActive, i.isapproved AS IsApproved, i.isdiscountprinted AS IsDiscountPrinted, i.isindispute AS IsInDispute, i.ispaid AS IsPaid, i.isprinted AS IsPrinted, i.c_invoice_isselfservice AS IsSelfService, i.istaxincluded AS IsTaxIncluded, i.istransferred AS IsTransferred, i.m_pricelist_id AS M_PriceList_ID, i.m_rma_id AS M_RMA_ID, i.paymentrule AS PaymentRule, i.poreference AS POReference, i.posted AS Posted, i.processedon AS ProcessedOn, i.processing AS Processing, i.ref_invoice_id AS Ref_Invoice_ID, i.reversal_id AS Reversal_ID, i.salesrep_id AS SalesRep_ID, i.sendemail AS SendEMail, i.totallines AS TotalLines, i.updated AS Updated, i.updatedby AS UpdatedBy, i.user1_id AS User1_ID, i.user2_id AS User2_ID FROM rv_c_invoice i
JOIN c_invoicepayschedule ips ON i.c_invoice_id = ips.c_invoice_id WHERE i.ispaid='N' AND invoiceopen(i.c_invoice_id, ips.c_invoicepayschedule_id) <> 0 AND i.ispayschedulevalid = 'Y' AND (i.docstatus IN ('CO', 'CL')) AND ips.isvalid = 'Y'
;

-- Oct 18, 2023, 2:26:19 PM CEST
UPDATE AD_Element SET Description='The document is fully paid',Updated=TO_TIMESTAMP('2023-10-18 14:26:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1402
;

-- Oct 18, 2023, 2:26:19 PM CEST
UPDATE AD_Column SET ColumnName='IsPaid', Name='Paid', Description='The document is fully paid', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=1402
;

-- Oct 18, 2023, 2:26:19 PM CEST
UPDATE AD_Process_Para SET ColumnName='IsPaid', Name='Paid', Description='The document is fully paid', Help=NULL, AD_Element_ID=1402 WHERE UPPER(ColumnName)='ISPAID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 18, 2023, 2:26:19 PM CEST
UPDATE AD_Process_Para SET ColumnName='IsPaid', Name='Paid', Description='The document is fully paid', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=1402 AND IsCentrallyMaintained='Y'
;

-- Oct 18, 2023, 2:26:19 PM CEST
UPDATE AD_InfoColumn SET ColumnName='IsPaid', Name='Paid', Description='The document is fully paid', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=1402 AND IsCentrallyMaintained='Y'
;

-- Oct 18, 2023, 2:26:19 PM CEST
UPDATE AD_Field SET Name='Paid', Description='The document is fully paid', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1402) AND IsCentrallyMaintained='Y'
;

