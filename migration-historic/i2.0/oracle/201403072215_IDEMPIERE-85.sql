SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 7, 2014 10:13:16 PM COT
-- IDEMPIERE-85 Add confirmation on TreeMaintenance when moving all nodes
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','Add to Tree',200255,'D','0f54ecd3-b5ea-47de-8ff9-a3a7ffe0826f','AddToTree','Y',TO_DATE('2014-03-07 22:13:15','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-07 22:13:15','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Mar 7, 2014 10:13:32 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','Add ALL to Tree',200256,'D','b544cbd4-9d28-401d-93a5-6351b6480108','AddAllToTree','Y',TO_DATE('2014-03-07 22:13:32','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-07 22:13:32','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Mar 7, 2014 10:13:44 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','Delete from Tree',200257,'D','27c456c5-4044-4502-8e7b-f42e1097f25b','DeleteFromTree','Y',TO_DATE('2014-03-07 22:13:43','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-07 22:13:43','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Mar 7, 2014 10:13:54 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Client_ID,AD_Org_ID) VALUES ('I','Delete ALL from Tree',200258,'D','ed972baa-3e1b-4819-b62a-fbf8047cd62d','DeleteAllFromTree','Y',TO_DATE('2014-03-07 22:13:53','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-07 22:13:53','YYYY-MM-DD HH24:MI:SS'),0,0)
;

SELECT register_migration_script('201403072215_IDEMPIERE-85.sql') FROM dual
;

