-- May 29, 2013 11:54:03 AM COT
-- IDEMPIERE-983 Cannot print cash payments generated
UPDATE AD_Column SET AD_Val_Rule_ID=52033,Updated=TO_TIMESTAMP('2013-05-29 11:54:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5637
;

SELECT register_migration_script('201305291158_IDEMPIERE-983.sql') FROM dual
;

