-- IDEMPIERE-3655
-- Mar 14, 2018 2:27:47 PM BRT
UPDATE AD_SysConfig SET Value=CASE WHEN Value NOT LIKE 'migration;%' THEN 'migration;'||TRIM(Value) ELSE Value END,Updated=TO_DATE('2018-03-14 14:27:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200102
;

SELECT register_migration_script('201803141439_IDEMPIERE-3655.sql') FROM dual
;

