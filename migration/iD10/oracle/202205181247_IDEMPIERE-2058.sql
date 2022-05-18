-- IDEMPIERE-2058
SELECT register_migration_script('202205181247_IDEMPIERE-2058.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 18, 2022, 12:47:26 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Operations',0,0,'Y',TO_TIMESTAMP('2022-05-18 12:47:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-18 12:47:26','YYYY-MM-DD HH24:MI:SS'),100,200751,'Operations','D','8c854bb3-553a-45de-8650-d2271bf0c094')
;

-- May 18, 2022, 12:47:47 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Copy Report',0,0,'Y',TO_TIMESTAMP('2022-05-18 12:47:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-18 12:47:47','YYYY-MM-DD HH24:MI:SS'),100,200752,'CopyReport','D','829ae7a6-b716-4969-b95a-8440666032c2')
;

