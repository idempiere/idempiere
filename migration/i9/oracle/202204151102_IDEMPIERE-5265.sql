-- IDEMPIERE-5265
SELECT register_migration_script('202204151102_IDEMPIERE-5265.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 15, 2022, 11:02:38 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Assistant',0,0,'Y',TO_TIMESTAMP('2022-04-15 11:02:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 11:02:38','YYYY-MM-DD HH24:MI:SS'),100,200740,'Assistant','D','9a4df9bc-2c84-4bd2-9ca6-ca89794e901d')
;

-- Apr 15, 2022, 11:03:28 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Selected Items',0,0,'Y',TO_TIMESTAMP('2022-04-15 11:03:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 11:03:28','YYYY-MM-DD HH24:MI:SS'),100,200741,'SelectedItems','D','219fc977-68a7-459c-aaab-a3f32a32fd2b')
;

