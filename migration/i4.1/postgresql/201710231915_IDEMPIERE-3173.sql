-- IDEMPIERE-3173 Columns that must not be copied
-- Oct 23, 2017 7:14:50 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2017-10-23 19:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200558
;

-- Oct 23, 2017 7:15:09 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2017-10-23 19:15:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200704
;

SELECT register_migration_script('201710231915_IDEMPIERE-3173.sql') FROM dual
;

