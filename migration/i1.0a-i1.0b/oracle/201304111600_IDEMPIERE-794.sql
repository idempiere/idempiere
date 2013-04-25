-- Apr 11, 2013 3:57:16 PM COT
UPDATE AD_ReportView SET WhereClause='RV_InOutDetails.IsSOTrx=''N''',Updated=TO_DATE('2013-04-11 15:57:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=152
;

-- Apr 11, 2013 3:57:24 PM COT
UPDATE AD_ReportView SET WhereClause='RV_InOutDetails.IsSOTrx=''Y''',Updated=TO_DATE('2013-04-11 15:57:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ReportView_ID=151
;

SELECT register_migration_script('201304111600_IDEMPIERE-794.sql') FROM dual
;


