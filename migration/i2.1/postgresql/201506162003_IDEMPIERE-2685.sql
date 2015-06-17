-- Jun 16, 2015 7:11:44 PM CEST
-- IDEMPIERE - 2685
UPDATE AD_Column SET ReadOnlyLogic='@#ShowAdvanced@ = N',Updated=TO_TIMESTAMP('2015-06-16 19:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=50209
;

-- Jun 16, 2015 7:11:49 PM CEST
UPDATE AD_Column SET ReadOnlyLogic='@#ShowAdvanced@ = N',Updated=TO_TIMESTAMP('2015-06-16 19:11:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=54091
;

SELECT register_migration_script('201506162003_IDEMPIERE-2685.sql') FROM dual
;