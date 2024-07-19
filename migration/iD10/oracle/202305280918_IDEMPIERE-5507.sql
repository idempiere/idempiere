-- IDEMPIERE-5507
SELECT register_migration_script('202305280918_IDEMPIERE-5507.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 28, 2023, 9:18:45 AM CEST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200159,Updated=TO_TIMESTAMP('2023-05-28 09:18:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_Para_ID=200416
;

-- May 30, 2023, 6:48:44 AM CEST
UPDATE AD_Process SET Name='Synchronize Print Format based on Report View',Updated=TO_TIMESTAMP('2023-05-30 06:48:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_ID=200146
;

-- May 30, 2023, 6:48:44 AM CEST
UPDATE AD_Menu SET Name='Synchronize Print Format based on Report View', Description=NULL, IsActive='Y',Updated=TO_TIMESTAMP('2023-05-30 06:48:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Menu_ID=200220
;
