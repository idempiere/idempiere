-- IDEMPIERE-7048 -  Improve "Load Template" button in Send Mail dialog
SELECT register_migration_script('202606241259_IDEMPIERE-7048.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 24, 2026, 12:59:40 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Load Mail Template',0,0,'Y',TO_TIMESTAMP('2026-06-24 12:59:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-24 12:59:40','YYYY-MM-DD HH24:MI:SS'),100,201044,'AddDefaultMailText','D','019ef949-2400-75ee-a06c-a88a227b7b1d')
;

