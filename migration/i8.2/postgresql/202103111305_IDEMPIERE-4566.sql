-- IDEMPIERE-4566 Translation Import/Export - output message is not visible
-- Mar 11, 2021, 12:50:15 PM CET
UPDATE AD_Process_Para SET DisplayLogic='@FileName@='''' | @ImportOrExport@=''export''',Updated=TO_TIMESTAMP('2021-03-11 12:50:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200332
;

SELECT register_migration_script('202103111305_IDEMPIERE-4566.sql') FROM dual
;

