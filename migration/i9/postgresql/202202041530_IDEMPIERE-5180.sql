-- IDEMPIERE-5180
-- Feb 4, 2022, 3:35:17 PM CET
UPDATE AD_Process_Para SET AD_Val_Rule_ID=129, DefaultValue='@#AD_Client_ID@',Updated=TO_TIMESTAMP('2022-02-04 15:35:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=538
;

SELECT register_migration_script('202202041530_IDEMPIERE-5180.sql') FROM dual
;
