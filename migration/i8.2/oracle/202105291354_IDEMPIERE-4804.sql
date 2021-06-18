SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4804 Message in Reset Password Panel is misleading
-- May 29, 2021, 1:51:27 PM CEST
UPDATE AD_Message SET MsgText='The new password is now valid in: {0}',Updated=TO_DATE('2021-05-29 13:51:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200076
;

SELECT register_migration_script('202105291354_IDEMPIERE-4804.sql') FROM dual
;

