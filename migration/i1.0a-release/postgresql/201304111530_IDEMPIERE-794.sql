-- Apr 11, 2013 3:33:35 PM COT
UPDATE AD_ReportView SET WhereClause='(QtyToDeliver<>0 OR QtyToInvoice<>0) AND RV_OrderDetail.DocStatus NOT IN (''VO'',''CL'')',Updated=TO_TIMESTAMP('2013-04-11 15:33:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=104
;

SELECT register_migration_script('201304111530_IDEMPIERE-794.sql') FROM dual
;

