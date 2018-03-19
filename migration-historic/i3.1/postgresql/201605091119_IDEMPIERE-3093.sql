-- IDEMPIERE-3093 Product fields not showing identifiers in some windows
-- May 9, 2016 11:18:56 AM PDT
UPDATE AD_Ref_Table SET IsValueDisplayed='Y',Updated=TO_TIMESTAMP('2016-05-09 11:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID IN (161,
162,
171,
211)
;

SELECT register_migration_script('201605091119_IDEMPIERE-3093.sql') FROM dual
;

