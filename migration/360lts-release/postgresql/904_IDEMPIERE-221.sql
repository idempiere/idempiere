-- Sep 5, 2012 5:06:57 PM COT
-- IDEMPIERE-221 Implement password policies
UPDATE AD_Field SET DisplayLogic='@AD_Client_ID@=0',Updated=TO_TIMESTAMP('2012-09-05 17:06:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200096
;

SELECT register_migration_script('904_IDEMPIERE-221.sql') FROM dual
;

