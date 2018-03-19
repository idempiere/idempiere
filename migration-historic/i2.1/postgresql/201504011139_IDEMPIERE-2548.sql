-- IDEMPIERE-2548 Misspelling in Unit of Measure Type
-- Apr 1, 2015 11:39:33 AM COT
UPDATE AD_Ref_List SET Name='Weight',Updated=TO_TIMESTAMP('2015-04-01 11:39:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=53530
;

SELECT register_migration_script('201504011139_IDEMPIERE-2548.sql') FROM dual
;

