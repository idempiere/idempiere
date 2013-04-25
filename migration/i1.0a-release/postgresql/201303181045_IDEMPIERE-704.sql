-- Mar 18, 2013 10:41:19 AM COT
-- IDEMPIERE-704 Fix Scheduler window
UPDATE AD_Column SET DefaultValue='1',Updated=TO_TIMESTAMP('2013-03-18 10:41:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200484
;

-- Mar 18, 2013 10:42:09 AM COT
UPDATE AD_Column SET DefaultValue='1',Updated=TO_TIMESTAMP('2013-03-18 10:42:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11523
;

SELECT register_migration_script('201303181045_IDEMPIERE-704.sql') FROM dual
;

