-- IDEMPIERE-4553 POS menu option throwing error
-- Nov 20, 2020, 8:58:28 PM CET
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2020-11-20 20:58:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=419
;

SELECT register_migration_script('202011202059_IDEMPIERE-4553.sql') FROM dual
;

