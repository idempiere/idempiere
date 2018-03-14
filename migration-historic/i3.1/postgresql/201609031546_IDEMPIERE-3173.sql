-- IDEMPIERE-3173 Columns that must not be copied
-- Sep 3, 2016 2:45:57 PM GMT+01:00
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2016-09-03 14:45:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2925
;

SELECT register_migration_script('201609031546_IDEMPIERE-3173.sql') FROM dual
;

