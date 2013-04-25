-- Apr 12, 2013 11:41:32 AM COT
UPDATE AD_ReportView SET WhereClause='NOT EXISTS (SELECT * FROM C_AllocationLine al WHERE al.C_Invoice_ID=RV_C_Invoice.C_Invoice_ID) AND RV_C_Invoice.DocStatus IN (''CO'',''CL'')',Updated=TO_DATE('2013-04-12 11:41:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=154
;

SELECT register_migration_script('201304121145_IDEMPIERE-794.sql') FROM dual
;
