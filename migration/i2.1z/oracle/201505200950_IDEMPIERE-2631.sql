SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2631 Process Indicator in CVS Import process
-- May 19, 2015 12:54:20 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Processing... {0} of {1} ({2}%)',0,0,'Y',TO_DATE('2015-05-19 12:54:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-05-19 12:54:19','YYYY-MM-DD HH24:MI:SS'),0,200351,'PercentProcessingProgress','D','ca3d703d-8777-451e-8b78-f05c65e6e99c')
;

INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Checking for errors... {0} preprocessed.',0,0,'Y',TO_DATE('2015-05-20 10:42:30','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2015-05-20 10:42:30','YYYY-MM-DD HH24:MI:SS'),0,200352,'PreProcessingCVSProgress','D','86c3ae89-0e50-49cf-b5c0-128bb4a91fd8')
;

SELECT register_migration_script('201505200950_IDEMPIERE-2631.sql') FROM dual
;
