-- May 23, 2013 11:43:26 AM COT
-- Proper English
UPDATE AD_Message SET MsgText='Report Wizard',Updated=TO_TIMESTAMP('2013-05-23 11:43:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200090
;


SELECT register_migration_script('201305231200_IDEMPIERE-955.sql') FROM dual
;
