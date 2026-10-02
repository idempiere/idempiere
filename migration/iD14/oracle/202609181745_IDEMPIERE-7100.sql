-- IDEMPIERE-7100 Web Client Desktop Refresh
SELECT register_migration_script('202609181745_IDEMPIERE-7100.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 18, 2026, 5:45:29 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No pending Activities',0,0,'Y',TO_TIMESTAMP('2026-09-18 17:45:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-18 17:45:28','YYYY-MM-DD HH24:MI:SS'),100,201068,'NoPendingActivities','D','01a0b3e8-1fbe-74c3-b9fc-8610ea0a3446')
;

