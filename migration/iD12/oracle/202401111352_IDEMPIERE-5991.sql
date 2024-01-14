-- IDEMPIERE-5991 test process define
SELECT register_migration_script('202401111352_IDEMPIERE-5991.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 11, 2024, 1:52:52 PM ICT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (nextidfunc(199,'N'),0,0,'Y',TO_TIMESTAMP('2024-01-11 13:52:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 13:52:52','YYYY-MM-DD HH24:MI:SS'),100,'Test File Download Dialog','Process to test implement of IDEMPIERE-5991','N','10000000','N','org.idempiere.process.TestFileDownloadProcess','4','U',0,0,'N','Y','N','a20d7420-2a03-4329-a232-b29f72da660f','P')
;

-- Jan 11, 2024, 1:53:30 PM ICT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (nextidfunc(200,'N'),0,0,'Y',TO_TIMESTAMP('2024-01-11 13:53:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 13:53:30','YYYY-MM-DD HH24:MI:SS'),100,'isError',toRecordId('AD_Process','a20d7420-2a03-4329-a232-b29f72da660f'),10,20,'N',0,'N','N','isError','N','U','878e3b8b-6d19-4d62-88d8-172ab59e0bb5','N','N','D','N')
;

-- Jan 11, 2024, 1:54:24 PM ICT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (nextidfunc(200,'N'),0,0,'Y',TO_TIMESTAMP('2024-01-11 13:54:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 13:54:24','YYYY-MM-DD HH24:MI:SS'),100,'Has Log',toRecordId('AD_Process','a20d7420-2a03-4329-a232-b29f72da660f'),20,20,'N',0,'N','Y','isHasLog','N','U','4c2b04c5-f56a-47a0-9d37-c17b5a7003fe','N','N','D','N')
;

-- Jan 11, 2024, 1:54:33 PM ICT
UPDATE AD_Process_Para SET Name='Error',Updated=TO_TIMESTAMP('2024-01-11 13:54:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_UU='878e3b8b-6d19-4d62-88d8-172ab59e0bb5'
;

-- Jan 11, 2024, 1:55:04 PM ICT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (nextidfunc(200,'N'),0,0,'Y',TO_TIMESTAMP('2024-01-11 13:55:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 13:55:04','YYYY-MM-DD HH24:MI:SS'),100,'Has File',toRecordId('AD_Process','a20d7420-2a03-4329-a232-b29f72da660f'),30,20,'N',0,'N','Y','isHasFile','N','U','fba3e00c-f6d5-4e1a-89e1-637991e9f521','N','N','D','N')
;

-- Jan 11, 2024, 1:56:02 PM ICT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2024-01-11 13:56:02','YYYY-MM-DD HH24:MI:SS'),100,'Test Download','Y',nextidfunc(200003,'N'),'Test Download',TO_TIMESTAMP('2024-01-11 13:56:02','YYYY-MM-DD HH24:MI:SS'),100,'N','fd9b81fa-93ba-4e5b-8905-c2170cdecc3e','W',152,toRecordId('AD_Process','a20d7420-2a03-4329-a232-b29f72da660f'),10,'U')
;

-- Jan 11, 2024, 1:59:02 PM ICT
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (nextidfunc(7,'N'),'Test File Download','P',0,0,'Y',TO_TIMESTAMP('2024-01-11 13:59:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 13:59:02','YYYY-MM-DD HH24:MI:SS'),100,'N',toRecordId('AD_Process','a20d7420-2a03-4329-a232-b29f72da660f'),'Y','N','U','Y','3527029e-f9b3-40eb-a54f-f83514fb0155')
;

-- Jan 11, 2024, 1:59:02 PM ICT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, toRecordId('AD_Menu','3527029e-f9b3-40eb-a54f-f83514fb0155'), 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=toRecordId('AD_Menu','3527029e-f9b3-40eb-a54f-f83514fb0155'))
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=1000000
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200224
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200225
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200218
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200221
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200222
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=24,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=25,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=26,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=27,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=28,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=29,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=30,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Jan 11, 2024, 2:00:32 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=31,Updated=TO_TIMESTAMP('2024-01-11 14:00:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200177
;

