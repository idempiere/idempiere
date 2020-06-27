SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1117 Attachment -> Disable preview over certain size
-- Jun 26, 2020, 11:05:28 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200154,0,0,TO_DATE('2020-06-26 23:05:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2020-06-26 23:05:27','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_MAX_ATTACHMENT_PREVIEW_SIZE','1048576','Max size in bytes for a file to be previewed in attachment window','D','C','c1eb659c-2e44-4717-8407-d9075f2436ed')
;

-- Jun 26, 2020, 11:07:11 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<html>The file is too large for automatic viewing, click the Preview button to load it</html>',0,0,'Y',TO_DATE('2020-06-26 23:07:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-26 23:07:10','YYYY-MM-DD HH24:MI:SS'),100,200620,'FileTooBigForPreview','D','013da62e-8989-4682-9f1b-36f568d773d4')
;

SELECT register_migration_script('202006262307_IDEMPIERE-1117.sql') FROM dual
;

