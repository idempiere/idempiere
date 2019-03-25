SET SQLBLANKLINES ON
SET DEFINE OFF

-- sjeffen: 
-- 22. mar. 2019 16.00.03 CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed when processing document',0,0,'Y',TO_DATE('2019-03-22 16:00:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-03-22 16:00:03','YYYY-MM-DD HH24:MI:SS'),100,200489,'FailedProcessingDocument','D','21281020-8057-4315-b0c0-144c874a5f46')
;

SELECT register_migration_script('201903241211_IDEMPIERE-3929.sql') FROM dual
;

