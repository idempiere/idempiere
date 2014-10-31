-- Mar 20, 2014 10:54:24 AM COT
-- IDEMPIERE-1840 Reference AD_Org Parent WhereClause bug
UPDATE AD_Ref_Table SET WhereClause='AD_Org.IsSummary=''Y''',Updated=TO_DATE('2014-03-20 10:54:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=113
;

SELECT register_migration_script('201409251410_IDEMPIERE-1840.sql') FROM dual
;

