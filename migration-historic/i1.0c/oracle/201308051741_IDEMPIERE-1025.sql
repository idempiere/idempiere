-- Aug 5, 2013 5:41:02 PM COT
-- IDEMPIERE-1025 Improve translation for custom tables
UPDATE AD_SysConfig SET Value='Y',Updated=TO_DATE('2013-08-05 17:41:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50031
;

SELECT register_migration_script('201308051741_IDEMPIERE-1025.sql') FROM dual
;

