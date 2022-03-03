--     IDEMPIERE-5218  Improvements for Record Info dialog
SELECT register_migration_script('202203031428_IDEMPIERE-5218.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 3, 2022, 2:28:28 PM CET
UPDATE AD_Message SET MsgText='Click to copy a permanent link to this record',Updated=TO_TIMESTAMP('2022-03-03 14:28:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200370
;

-- Mar 3, 2022, 2:29:07 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Copy SELECT',0,0,'Y',TO_TIMESTAMP('2022-03-03 14:29:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-03 14:29:06','YYYY-MM-DD HH24:MI:SS'),100,200733,'CopySelect','D','441bb105-9f59-44db-a9bc-a1873f3678e3')
;

-- Mar 3, 2022, 2:29:34 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Click to copy a SELECT SQL query pointing to this record',0,0,'Y',TO_TIMESTAMP('2022-03-03 14:29:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-03 14:29:33','YYYY-MM-DD HH24:MI:SS'),100,200734,'CopySelect_tooltip','D','8f403aaf-6fe4-4fdb-9630-5ec81cd03a4e')
;

