-- IDEMPIERE-7100 Web Client Desktop Refresh
SELECT register_migration_script('202610281035_IDEMPIERE-7100.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 28, 2026, 10:35:05 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Activities',0,0,'Y',TO_TIMESTAMP('2026-10-28 10:35:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-28 10:35:04','YYYY-MM-DD HH24:MI:SS'),100,201071,'Activities','D','01a1805c-7545-7f7b-b02f-f0fae4193f41')
;

