-- IDEMPIERE-7097 Workflow editor: rendering and interaction overhaul
SELECT register_migration_script('202609081138_IDEMPIERE-7097.sql') FROM dual;

-- Sep 8, 2026, 11:38:07 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Zoom out',0,0,'Y',TO_TIMESTAMP('2026-09-08 11:38:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 11:38:07','YYYY-MM-DD HH24:MI:SS'),100,201055,'ZoomOut','D','01a07f18-33b7-74d3-b295-fcd0d5d5d25e')
;

-- Sep 8, 2026, 11:38:32 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Zoom In',0,0,'Y',TO_TIMESTAMP('2026-09-08 11:38:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 11:38:31','YYYY-MM-DD HH24:MI:SS'),100,201056,'ZoomIn','D','01a07f18-92ff-77fa-88f5-c97aaa506c79')
;

-- Sep 8, 2026, 11:38:51 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Fit to width',0,0,'Y',TO_TIMESTAMP('2026-09-08 11:38:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 11:38:50','YYYY-MM-DD HH24:MI:SS'),100,201057,'FitToWidth','D','01a07f18-dfa2-76ab-8a2f-b9a97c7428da')
;

-- Sep 8, 2026, 11:39:05 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Actual size',0,0,'Y',TO_TIMESTAMP('2026-09-08 11:39:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 11:39:05','YYYY-MM-DD HH24:MI:SS'),100,201058,'ActualSize','D','01a07f19-1723-7a61-a74f-2afe637d6e2b')
;

-- Sep 8, 2026, 11:39:19 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I',E'Drag nodes to move \u2022 Click for actions',0,0,'Y',TO_TIMESTAMP('2026-09-08 11:39:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 11:39:18','YYYY-MM-DD HH24:MI:SS'),100,201059,'WFGraphHint','D','01a07f19-4c30-7fe2-b280-b8d960b80bf1')
;

-- Sep 8, 2026, 11:39:35 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Workflow graph',0,0,'Y',TO_TIMESTAMP('2026-09-08 11:39:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 11:39:35','YYYY-MM-DD HH24:MI:SS'),100,201060,'WorkflowGraph','D','01a07f19-8bdc-76e0-9fcf-e381f5bb644e')
;

-- Sep 8, 2026, 11:39:51 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','No workflow nodes',0,0,'Y',TO_TIMESTAMP('2026-09-08 11:39:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 11:39:50','YYYY-MM-DD HH24:MI:SS'),100,201061,'NoWorkflowNodes','D','01a07f19-c7e7-77d5-b54a-c7b344886a72')
;

