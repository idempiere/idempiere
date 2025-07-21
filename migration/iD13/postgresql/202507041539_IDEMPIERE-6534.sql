-- IDEMPIERE-6534 Rename "Reset Locked Account" to "Unlock Account"
SELECT register_migration_script('202507041539_IDEMPIERE-6534.sql') FROM dual;

-- Jul 4, 2025, 3:39:02 PM CEST
UPDATE AD_Process SET Name='Unlock Account', Description='Unlock Account for User',Updated=TO_TIMESTAMP('2025-07-04 15:39:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200008
;

-- Jul 4, 2025, 3:39:02 PM CEST
UPDATE AD_Menu SET Name='Unlock Account', Description='Unlock Account for User', IsActive='Y',Updated=TO_TIMESTAMP('2025-07-04 15:39:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200012
;

