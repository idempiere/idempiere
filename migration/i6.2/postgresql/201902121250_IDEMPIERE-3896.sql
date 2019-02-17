-- Feb 11, 2019 4:36:05 PM CET
-- IDEMPIERE-3896 Process that fixes M_StorageReservation when wrong reservations are found
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,Help,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Updated,IsActive,UpdatedBy,Name,Created,CreatedBy,Classname,AD_Client_ID,EntityType,Value,AD_Org_ID,AllowMultipleExecution) VALUES ('N',200107,'The process checks if there are errors in storage reservartion (storageqtyReserved <> orderqtyreserved), if there are, it recreates all the reservation records for the offending products.','N','N','c4409eac-e5a8-4eac-b34a-1ac73319aa03','3','N','N',0,0,'Y',TO_TIMESTAMP('2019-02-11 16:36:04','YYYY-MM-DD HH24:MI:SS'),'Y',100,'Recreate Storage Reservation',TO_TIMESTAMP('2019-02-11 16:36:04','YYYY-MM-DD HH24:MI:SS'),100,'org.adempiere.process.RecreateStorageReservation',0,'D','RecreateStorageReservation',0,'N')
;

-- Feb 11, 2019 4:37:49 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,AD_Menu_UU,IsSOTrx,IsReadOnly,AD_Process_ID,IsCentrallyMaintained,Name,"action",IsActive,CreatedBy,AD_Client_ID,Created,Updated,UpdatedBy,EntityType,AD_Org_ID) VALUES (200166,'N','cac979ac-f9b3-4756-a367-1f2f5941ad41','N','N',200107,'Y','Recreate Storage Reservation','P','Y',100,0,TO_TIMESTAMP('2019-02-11 16:37:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2019-02-11 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,'D',0)
;

-- Feb 11, 2019 4:37:49 PM CET
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200166, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200166)
;

-- Feb 11, 2019 4:37:49 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200166, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200166)
;

-- Feb 17, 2019, 11:22:47 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200166
;

-- Feb 17, 2019, 11:22:47 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Feb 17, 2019, 11:22:47 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Feb 17, 2019, 11:22:47 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Feb 17, 2019, 11:22:47 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=24, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=515
;

SELECT register_migration_script('201902121250_IDEMPIERE-3896.sql') FROM dual
;
