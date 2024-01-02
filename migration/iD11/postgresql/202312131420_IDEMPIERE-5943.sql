-- IDEMPIERE-5943 Implement table partitioning support
SELECT register_migration_script('202312131420_IDEMPIERE-5943.sql') FROM dual;

-- Dec 13, 2023, 2:20:14 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Table partition is not empty',0,0,'Y',TO_TIMESTAMP('2023-12-13 14:20:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 14:20:13','YYYY-MM-DD HH24:MI:SS'),100,200854,'TablePartitionNotEmpty','D','fc4d156d-d59f-4449-bfa8-584497efd6b4')
;

-- Dec 13, 2023, 3:44:16 PM MYT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200230,'Create/Update Table Partition','Process which create or update table partitions for partitioned tables','P',0,0,'Y',TO_TIMESTAMP('2023-12-13 15:44:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-13 15:44:14','YYYY-MM-DD HH24:MI:SS'),100,'N',200157,'Y','N','D','N','aeea2c2f-fcd7-422b-a708-a3c2905a47db')
;

-- Dec 13, 2023, 3:44:16 PM MYT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200230, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200230)
;

-- Dec 13, 2023, 3:47:37 PM MYT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9,Updated=TO_TIMESTAMP('2023-12-13 15:47:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200230
;

-- Dec 13, 2023, 3:58:59 PM MYT
INSERT INTO AD_Scheduler (AD_Client_ID,Supervisor_ID,IsActive,Processing,AD_Scheduler_ID,AD_Process_ID,CreatedBy,Updated,DateNextRun,AD_Org_ID,UpdatedBy,Created,Name,KeepLogDays,AD_Scheduler_UU,AD_Schedule_ID) VALUES (0,10,'Y','N',200003,200157,100,TO_TIMESTAMP('2023-12-13 15:58:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-12-14 15:58:59','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2023-12-13 15:58:59','YYYY-MM-DD HH24:MI:SS'),'Create/Update Table Partitions',7,'46d0a09b-71b5-4ca2-b8ed-a61a3c77999c',200000)
;

-- Dec 13, 2023, 3:59:11 PM MYT
INSERT INTO AD_Scheduler_Para (AD_Process_Para_ID,IsActive,AD_Org_ID,CreatedBy,UpdatedBy,Created,Updated,AD_Client_ID,AD_Scheduler_ID,AD_Scheduler_Para_UU) VALUES (200448,'Y',0,100,100,TO_TIMESTAMP('2023-12-13 15:59:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-12-13 15:59:10','YYYY-MM-DD HH24:MI:SS'),0,200003,'b2693a75-9687-4701-967b-27339ed4f260')
;

-- Dec 13, 2023, 3:59:11 PM MYT
INSERT INTO AD_Scheduler_Para (AD_Process_Para_ID,IsActive,AD_Org_ID,CreatedBy,UpdatedBy,Created,Updated,ParameterDefault,AD_Client_ID,AD_Scheduler_ID,AD_Scheduler_Para_UU) VALUES (200449,'Y',0,100,100,TO_TIMESTAMP('2023-12-13 15:59:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-12-13 15:59:11','YYYY-MM-DD HH24:MI:SS'),NULL,0,200003,'16a4a485-e81d-46ac-b021-f78e363a75cf')
;

-- Dec 14, 2023, 2:41:34 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invalid Range Partition Interval',E'The Range Partition Interval has to match the date/number patterns: ^([1-9]{1}[0-9]?)\\s+year(?:s)?\\s+([1-9]{1}[0-9]?)\\s+month(?:s)?$; ^([1-9]{1}[0-9]?)\\s+(year)(?:s)?$; ^([1-9]{1}[0-9]?)\\s+(month)(?:s)?$; ^[1-9]\\d*$',0,0,'Y',TO_TIMESTAMP('2023-12-14 14:41:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-14 14:41:32','YYYY-MM-DD HH24:MI:SS'),100,200855,'InvalidRangePartitionInterval','D','6d5b187c-246b-427b-9b31-e9d3f4d0d892')
;

-- Dec 14, 2023, 2:53:11 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Range partition key type not supported','Support date and numeric types only',0,0,'Y',TO_TIMESTAMP('2023-12-14 14:53:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-14 14:53:10','YYYY-MM-DD HH24:MI:SS'),100,200856,'RangePartitionKeyTypeNotSupported','D','289e23ba-ad2e-4ae8-b777-aa4d08186d15')
;

-- Dec 14, 2023, 3:17:41 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Database adapter doesn''t have table partition support',NULL,0,0,'Y',TO_TIMESTAMP('2023-12-14 15:17:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-14 15:17:40','YYYY-MM-DD HH24:MI:SS'),100,200857,'DBAdapterNoTablePartitionSupport','D','37388fcf-1594-4385-8a10-7aa177ea9d8f')
;

-- Dec 14, 2023, 3:35:29 PM MYT
UPDATE AD_Message SET MsgText='Changed in the table partition configuration',Updated=TO_TIMESTAMP('2023-12-14 15:35:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200853
;

-- Dec 15, 2023, 4:50:28 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Only one partition key is allowed',0,0,'Y',TO_TIMESTAMP('2023-12-15 16:50:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-15 16:50:27','YYYY-MM-DD HH24:MI:SS'),100,200858,'OnlyOnePartitionKeyAllowed','D','8e205344-7629-441a-af13-c831bafcbf00')
;

