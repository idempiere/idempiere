-- IDEMPIERE-5412
SELECT register_migration_script('202209080926_IDEMPIERE-5412.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 8, 2022, 9:26:00 AM CEST
UPDATE PA_DocumentStatus SET Name_PrintFont_ID=NULL, Number_PrintFont_ID=NULL,Updated=TO_TIMESTAMP('2022-09-08 09:26:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200001
;

-- Sep 8, 2022, 9:26:06 AM CEST
UPDATE PA_DocumentStatus SET Name_PrintFont_ID=NULL, Number_PrintFont_ID=NULL,Updated=TO_TIMESTAMP('2022-09-08 09:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DocumentStatus_ID=200000
;

-- Sep 8, 2022, 4:19:56 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No Data Available',0,0,'Y',TO_TIMESTAMP('2022-09-08 16:19:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-08 16:19:56','YYYY-MM-DD HH24:MI:SS'),100,200781,'NoDataAvailable','D','fe21c31e-2932-461c-a4bf-02eba321f509')
;

