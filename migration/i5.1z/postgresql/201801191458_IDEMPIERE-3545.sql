-- IDEMPIERE-3545 Add plugin information in About window
-- Jan 19, 2018 2:56:10 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Stop',0,0,'Y',TO_TIMESTAMP('2018-01-19 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,200443,'Stop','D','e250a904-9b0d-49a5-bfb3-d96702f035d1')
;

-- Jan 19, 2018 2:56:44 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Uninstall',0,0,'Y',TO_TIMESTAMP('2018-01-19 14:56:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 14:56:44','YYYY-MM-DD HH24:MI:SS'),100,200444,'Uninstall','D','0bbd28ab-67e4-4a61-95f9-10da8e2c875b')
;

-- Jan 19, 2018 2:56:52 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Install',0,0,'Y',TO_TIMESTAMP('2018-01-19 14:56:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 14:56:52','YYYY-MM-DD HH24:MI:SS'),100,200445,'Install','D','f187b323-baa0-4207-9a98-8e931277f2ea')
;

-- Jan 19, 2018 2:57:00 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Id',0,0,'Y',TO_TIMESTAMP('2018-01-19 14:57:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 14:57:00','YYYY-MM-DD HH24:MI:SS'),100,200446,'Id','D','14fd776d-47a6-4b4f-a6e0-7f8aae564339')
;

-- Jan 19, 2018 2:57:09 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','State',0,0,'Y',TO_TIMESTAMP('2018-01-19 14:57:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 14:57:08','YYYY-MM-DD HH24:MI:SS'),100,200447,'State','D','1109bf43-b855-4846-9cca-abe90fbf1ba7')
;

-- Jan 19, 2018 2:57:18 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Version',0,0,'Y',TO_TIMESTAMP('2018-01-19 14:57:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 14:57:17','YYYY-MM-DD HH24:MI:SS'),100,200448,'Version','D','64e718bd-5195-4a0f-ae54-5d67af26f4e4')
;

-- Jan 19, 2018 2:57:26 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Plugins',0,0,'Y',TO_TIMESTAMP('2018-01-19 14:57:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 14:57:25','YYYY-MM-DD HH24:MI:SS'),100,200449,'Plugins','D','712ab4af-73c4-4998-b1c0-a0664f334945')
;

SELECT register_migration_script('201801191458_IDEMPIERE-3545.sql') FROM dual
;

