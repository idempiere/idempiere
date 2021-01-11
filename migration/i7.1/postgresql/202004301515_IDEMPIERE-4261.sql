-- IDEMPIERE-4261 Fix typo in ProcessOK message
-- Apr 30, 2020, 3:16:56 PM CEST
UPDATE AD_Message SET MsgText='Process finished successfully',Updated=TO_TIMESTAMP('2020-04-30 15:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=441
;

SELECT register_migration_script('202004301515_IDEMPIERE-4261.sql') FROM dual
;