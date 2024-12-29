-- IDEMPIERE-6356 Theme Selector on Login
SELECT register_migration_script('202412292146_IDEMPIERE-6356.sql') FROM dual;

-- Dec 29, 2024, 9:46:53 PM CET
UPDATE AD_SysConfig SET Value='iceblue_c,default',Updated=TO_TIMESTAMP('2024-12-29 21:46:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200021
;

