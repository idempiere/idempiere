-- IDEMPIERE-2058
SELECT register_migration_script('202205181247_IDEMPIERE-2058.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 18, 2022, 12:47:47 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Copy Report',0,0,'Y',TO_TIMESTAMP('2022-05-18 12:47:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-18 12:47:47','YYYY-MM-DD HH24:MI:SS'),100,200752,'CopyReport','D','829ae7a6-b716-4969-b95a-8440666032c2')
;

-- May 23, 2022, 10:45:29 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','You selected the Copy Report function. It creates a brand new Print Format which you can modify, update, change. This is usually used for improving reporting to get additional information views',0,0,'Y',TO_TIMESTAMP('2022-05-23 10:45:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-23 10:45:29','YYYY-MM-DD HH24:MI:SS'),100,200753,'CreateCopyReport?','D','c482066a-d3bf-40d1-8525-1e303c49e586')
;

-- May 23, 2022, 10:47:59 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','You selected the New Report function. It creates a brand new Print Format which you can modify, update, change. This is usually used for improving reporting to get additional information views',0,0,'Y',TO_TIMESTAMP('2022-05-23 10:47:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-23 10:47:59','YYYY-MM-DD HH24:MI:SS'),100,200754,'CreateNewReport?','D','fa925848-3e7b-45ed-9300-cb2e2b8fda97')
;

