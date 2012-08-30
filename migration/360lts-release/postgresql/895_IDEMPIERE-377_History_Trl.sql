-- Aug 27, 2012 9:48:50 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Message SET MsgText='History records',Updated=TO_TIMESTAMP('2012-08-27 21:48:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=292
;

-- Aug 27, 2012 9:48:50 PM IST
-- Add search sequence support for search dialog
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=292
;

UPDATE AD_System
  SET LastMigrationScriptApplied='895_IDEMPIERE-377_History_Trl.sql'
WHERE LastMigrationScriptApplied<'895_IDEMPIERE-377_History_Trl.sql'
   OR LastMigrationScriptApplied IS NULL
;