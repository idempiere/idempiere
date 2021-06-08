-- IDEMPIERE-3980
-- Jun 8, 2021, 4:32:50 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','File not allowed for uploading, just image types jpg/png/gif/tiff/bmp/ico',0,0,'Y',TO_TIMESTAMP('2021-06-08 16:32:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-08 16:32:49','YYYY-MM-DD HH24:MI:SS'),100,200711,'UploadImageTypeNotAllowed','D','7f3ed66b-6875-49e2-b45f-42ed9c7548e1')
;

SELECT register_migration_script('202106081633_IDEMPIERE-3980.sql') FROM dual
;

