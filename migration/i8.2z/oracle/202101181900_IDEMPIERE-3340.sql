SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3340 Add tooltip messages
-- Jan 18, 2021, 6:52:01 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','New folder added as in root level.',0,0,'Y',TO_DATE('2021-01-18 18:52:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-01-18 18:52:00','YYYY-MM-DD HH24:MI:SS'),100,200656,'Tooltip_AddAsRoot','D','7bd7ffa8-5596-4c2e-a0c1-7062f0c8c3a1')
;

-- Jan 18, 2021, 6:53:13 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','This flag is marked then folder default open with expanded view.',0,0,'Y',TO_DATE('2021-01-18 18:53:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-01-18 18:53:12','YYYY-MM-DD HH24:MI:SS'),100,200657,'Tooltip_DefaultExpanded','D','57eb03cd-86ca-42a7-9a4a-0fd8c014e1f7')
;

-- Jan 18, 2021, 6:56:38 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Expand/Collapse Tree',0,0,'Y',TO_DATE('2021-01-18 18:56:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-01-18 18:56:38','YYYY-MM-DD HH24:MI:SS'),100,200658,'Tooltip_ExpandCollapseTree','D','26463bcc-7a17-444c-aab4-51fda0fde442')
;

-- May 7, 2020 7:15:41 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Down',0,0,'Y',TO_DATE('2020-05-07 19:15:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:15:40','YYYY-MM-DD HH24:MI:SS'),100,200608,'MoveDown','D','525bf4d4-5ce3-4a7d-9081-2e3b96708cf1')
;

-- May 7, 2020 7:16:04 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Up',0,0,'Y',TO_DATE('2020-05-07 19:16:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:16:03','YYYY-MM-DD HH24:MI:SS'),100,200609,'MoveUp','D','bdf56785-ce50-49ce-a2c5-d20a1a08ec96')
;

-- May 7, 2020 7:16:17 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Left',0,0,'Y',TO_DATE('2020-05-07 19:16:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:16:16','YYYY-MM-DD HH24:MI:SS'),100,200610,'MoveLeft','D','f0082f8f-7ecf-4682-9ee2-593b6b21fe41')
;

-- May 7, 2020 7:16:31 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Move Right',0,0,'Y',TO_DATE('2020-05-07 19:16:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-07 19:16:30','YYYY-MM-DD HH24:MI:SS'),100,200611,'MoveRight','D','0d2f8a50-350d-43c5-9629-64c3a6ea88d1')
;

SELECT register_migration_script('202101181900_IDEMPIERE-3340.sql') FROM dual
;