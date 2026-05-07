-- 
SELECT register_migration_script('202602251139_IDEMPIERE-6882.sql') FROM dual;

-- Feb 25, 2026, 11:39:58 AM CET
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2026-02-25 11:39:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=8418
;

