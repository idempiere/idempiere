SET SQLBLANKLINES ON
SET DEFINE OFF

-- Quick Form button tooltip message
-- Apr 14, 2020, 6:00:58 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','UnSort',0,0,'Y',TO_DATE('2020-04-14 18:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:00:57','YYYY-MM-DD HH24:MI:SS'),100,200594,'UnSort','D','59bd510b-a62a-44f3-8c5b-4d341ddfdb64')
;

-- Apr 14, 2020, 6:01:25 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Save and Close ( Alt+K )',0,0,'Y',TO_DATE('2020-04-14 18:01:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:01:24','YYYY-MM-DD HH24:MI:SS'),100,200595,'QuickFormOk','D','58187f07-3e1c-4e3f-9a5c-dfb3f0376dff')
;

-- Apr 14, 2020, 6:02:16 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Save changes ( Alt+S )',0,0,'Y',TO_DATE('2020-04-14 18:02:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:02:16','YYYY-MM-DD HH24:MI:SS'),100,200596,'QuickFormSave','D','af523275-d6a2-4844-8e0d-b54c10cda673')
;

-- Apr 14, 2020, 6:02:39 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Close quick form ( Alt+X )',0,0,'Y',TO_DATE('2020-04-14 18:02:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:02:38','YYYY-MM-DD HH24:MI:SS'),100,200597,'QuickFormCancel','D','4e7a74e2-145e-4db6-9caf-6eb86e6644d1')
;

-- Apr 14, 2020, 6:03:05 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Ignore changes ( Alt+Z )',0,0,'Y',TO_DATE('2020-04-14 18:03:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:03:04','YYYY-MM-DD HH24:MI:SS'),100,200598,'QuickFormIgnore','D','df828ee6-f7e8-4e1a-a7fe-4a8b73eacfc5')
;

-- Apr 14, 2020, 6:03:31 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Delete selected or current record ( Alt+D )',0,0,'Y',TO_DATE('2020-04-14 18:03:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:03:30','YYYY-MM-DD HH24:MI:SS'),100,200599,'QuickFormDelete','D','bffa36a5-4351-4057-993c-2026032eda9b')
;

-- Apr 14, 2020, 6:04:04 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Restore sorting to natural order ( Alt+R )',0,0,'Y',TO_DATE('2020-04-14 18:04:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:04:03','YYYY-MM-DD HH24:MI:SS'),100,200600,'QuickFormUnSort','D','4f50ef68-ea76-401a-90c2-21bf09ca9673')
;

-- Apr 14, 2020, 6:04:49 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','ReQuery all record ( Alt+E )',0,0,'Y',TO_DATE('2020-04-14 18:04:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:04:49','YYYY-MM-DD HH24:MI:SS'),100,200601,'QuickFormRefresh','D','2a89576d-a216-43d2-97ae-64221701ad99')
;

-- Apr 14, 2020, 6:05:11 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Customize grid ( Alt+L )',0,0,'Y',TO_DATE('2020-04-14 18:05:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-04-14 18:05:10','YYYY-MM-DD HH24:MI:SS'),100,200602,'QuickFormCustomize','D','52801c89-07fc-4a9b-a84a-7d752feb8d63')
;

SELECT register_migration_script('202005061900_IDEMPIERE-4157.sql') FROM dual
;
