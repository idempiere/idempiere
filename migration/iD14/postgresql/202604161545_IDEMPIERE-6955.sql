-- IDEMPIERE-6955 - Move SOAP Web Services out of core
SELECT register_migration_script('202604161545_IDEMPIERE-6955.sql') FROM dual;

-- Apr 16, 2026, 3:45:15 PM CEST
UPDATE AD_Extension SET IsBundled='N',Updated=TO_TIMESTAMP('2026-04-16 15:45:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Extension_ID = 200000
;
