SET DEFINE OFF

-- May 28, 2012 3:21:04 PM MYT
-- IDEMPIERE-277 Wrong Translation for "Home"
UPDATE AD_Message SET MsgText='&Home',Updated=TO_DATE('2012-05-28 15:21:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=293
;

-- May 28, 2012 3:21:04 PM MYT
-- IDEMPIERE-277 Wrong Translation for "Home"
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=293
;

UPDATE AD_System
  SET LastMigrationScriptApplied='842_IDEMPIERE-277.sql'
WHERE LastMigrationScriptApplied<'842_IDEMPIERE-277.sql'
   OR LastMigrationScriptApplied IS NULL
;

