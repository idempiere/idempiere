SET SQLBLANKLINES ON
SET DEFINE OFF

-- CPH::ERP Comments: 
-- 25. aug. 2019 13.25.17 CEST

-- 25. aug. 2019 13.26.44 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No OrderLine',0,0,'Y',TO_DATE('2019-08-25 13:26:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-08-25 13:26:43','YYYY-MM-DD HH24:MI:SS'),100,200539,'No OrderLine','C','f5eb2dcc-2a77-4442-86c1-d41bbb79fc75')
;

-- 25. aug. 2019 13.31.12 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Order line not found',0,0,'Y',TO_DATE('2019-08-25 13:31:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-08-25 13:31:11','YYYY-MM-DD HH24:MI:SS'),100,200543,'Order line not found','C','493c2571-38ec-4e81-8fc3-b837035a4287')
;

-- 25. aug. 2019 13.35.38 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Order not completed',0,0,'Y',TO_DATE('2019-08-25 13:35:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-08-25 13:35:38','YYYY-MM-DD HH24:MI:SS'),100,200544,'Order not completed','C','a7a7c7cd-4bc5-439a-bfc7-534ca5b4b51e')
;

-- 25. aug. 2019 13.38.23 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Ordered quantity already shipped',0,0,'Y',TO_DATE('2019-08-25 13:38:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-08-25 13:38:23','YYYY-MM-DD HH24:MI:SS'),100,200545,'Ordered quantity already shipped','C','dd045eef-f1b1-41e3-bc43-c17be39cdeb8')
;

-- 25. aug. 2019 13.38.51 CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Cannot save shipment header',0,0,'Y',TO_DATE('2019-08-25 13:38:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-08-25 13:38:50','YYYY-MM-DD HH24:MI:SS'),100,200546,'Cannot save shipment header','C','65847324-2c57-4cb6-8e2c-91ddffd4969b')
;

SELECT register_migration_script('201908271211_IDEMPIERE-4035.sql') FROM dual
;

