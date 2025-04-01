-- IDEMPIERE-6475
SELECT register_migration_script('202504010915_IDEMPIERE-6475.sql') FROM dual;

-- Apr 1, 2025, 9:15:48 AM CEST
UPDATE AD_Process_Para SET Name='From Bank Account', Description=NULL, Help=NULL, ColumnName='From_C_BankAccount_ID', IsCentrallyMaintained='Y', AD_Element_ID=203248,Updated=TO_TIMESTAMP('2025-04-01 09:15:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_Para_ID=53246
;

-- Apr 1, 2025, 9:15:58 AM CEST
UPDATE AD_Process_Para SET Name='To Bank Account', Description=NULL, Help=NULL, ColumnName='To_C_BankAccount_ID', IsCentrallyMaintained='Y', AD_Element_ID=203249,Updated=TO_TIMESTAMP('2025-04-01 09:15:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Process_Para_ID=53247
;

