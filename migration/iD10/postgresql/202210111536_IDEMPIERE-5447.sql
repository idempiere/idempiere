-- IDEMPIERE-5447 Add unit test for Merge form
SELECT register_migration_script('202210111536_IDEMPIERE-5447.sql') FROM dual;

-- Oct 11, 2022, 3:36:36 PM CEST
UPDATE AD_Menu SET PredefinedContextVariables='IgnoreIsSOTrxInBPInfo=Y',Updated=TO_TIMESTAMP('2022-10-11 15:36:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=397
;

