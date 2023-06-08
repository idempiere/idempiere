--
SELECT register_migration_script('202304042029_IDEMPIERE-5650.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 4, 2023, 8:29:09 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Process_ID@!0&@IsEmbedReportContent@=''Y''', DefaultValue=NULL,Updated=TO_TIMESTAMP('2023-04-04 20:29:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200263
;

-- Apr 4, 2023, 8:45:33 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Please review the definition of Process Parameters',0,0,'Y',TO_TIMESTAMP('2023-04-04 20:45:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-04 20:45:31','YYYY-MM-DD HH24:MI:SS'),100,200829,'WrongProcessParameters','D','3cda0c21-5059-4f49-8971-6ffcf969efee')
;
