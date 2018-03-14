-- Dec 2, 2014 4:51:26 PM COT
-- IDEMPIERE-2103 Process for run import/export csv
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Name,AD_Org_ID,UpdatedBy,IsActive,CreatedBy,Classname,Value,AD_Client_ID,EntityType,Created,Updated) VALUES ('N',200076,'N','N','95ee94ea-d050-4f20-b4f3-1b6776df6d62','7','N','N',0,0,'Y','Import CSV Process',0,100,'Y',100,'org.idempiere.process.ImportCSVProcess','ImportCSVProcess',0,'D',TO_TIMESTAMP('2014-12-02 16:51:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-12-02 16:51:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:52:29 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,EntityType,Created) VALUES ('N',200111,'a75e1a11-f9e5-4d1f-9140-dde15f7c4c61',200076,'Y','Import Template','AD_ImportTemplate_ID',0,'Y',10,'Y',100,TO_TIMESTAMP('2014-12-02 16:52:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,202793,19,'D',TO_TIMESTAMP('2014-12-02 16:52:28','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:53:00 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,IsMandatory,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,EntityType,Created) VALUES ('N',200112,'11253af5-7dd2-441a-b1c1-2b1350e99e4e','Name of a file in the local directory space - or URL (file://.., http://.., ftp://..)',200076,'Y','File Name','FileName','Name of the local file or URL',0,'Y',20,'Y',100,TO_TIMESTAMP('2014-12-02 16:52:59','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,2295,38,'D',TO_TIMESTAMP('2014-12-02 16:52:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:55:07 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType,Created) VALUES ('ImportMode',202807,'Import Mode','Import Mode','fef3fdab-e970-4c03-8789-1ae1c944ea5a',TO_TIMESTAMP('2014-12-02 16:55:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D',TO_TIMESTAMP('2014-12-02 16:55:06','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:55:29 PM COT
INSERT INTO AD_Reference (AD_Reference_ID,AD_Reference_UU,Name,EntityType,IsOrderByValue,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,UpdatedBy,AD_Client_ID,Created) VALUES (200098,'3892e140-7f08-4f89-a510-493e0f7cb775','Import Mode','D','N','L',0,100,TO_TIMESTAMP('2014-12-02 16:55:29','YYYY-MM-DD HH24:MI:SS'),'Y',100,0,TO_TIMESTAMP('2014-12-02 16:55:29','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:55:46 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,UpdatedBy,Updated,IsActive,EntityType,AD_Client_ID,AD_Org_ID,Created) VALUES (200281,200098,'39b8fe8e-3d83-419d-96ce-519550cc5baf','Insert','I',100,100,TO_TIMESTAMP('2014-12-02 16:55:44','YYYY-MM-DD HH24:MI:SS'),'Y','D',0,0,TO_TIMESTAMP('2014-12-02 16:55:44','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:55:54 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,UpdatedBy,Updated,IsActive,EntityType,AD_Client_ID,AD_Org_ID,Created) VALUES (200282,200098,'17e4b7b0-3699-4b98-ab13-c19fe531d4de','Update','U',100,100,TO_TIMESTAMP('2014-12-02 16:55:53','YYYY-MM-DD HH24:MI:SS'),'Y','D',0,0,TO_TIMESTAMP('2014-12-02 16:55:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:55:59 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,UpdatedBy,Updated,IsActive,EntityType,AD_Client_ID,AD_Org_ID,Created) VALUES (200283,200098,'9d47e0f4-0ed4-41bb-a7d5-8dd7dc120394','Merge','M',100,100,TO_TIMESTAMP('2014-12-02 16:55:59','YYYY-MM-DD HH24:MI:SS'),'Y','D',0,0,TO_TIMESTAMP('2014-12-02 16:55:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:56:37 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,IsMandatory,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,AD_Org_ID,IsEncrypted,AD_Client_ID,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,EntityType,Created) VALUES ('N',200113,'7c2d264e-2622-494a-81a4-03f84ea99061',200076,'Y','Import Mode','ImportMode',0,'Y',30,'I','Y',100,TO_TIMESTAMP('2014-12-02 16:56:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N',0,202807,17,200098,'D',TO_TIMESTAMP('2014-12-02 16:56:36','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:56:59 PM COT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,IsCentrallyMaintained,Name,AD_Menu_UU,"action",IsActive,CreatedBy,Updated,UpdatedBy,AD_Org_ID,AD_Client_ID,AD_Process_ID,EntityType,Created) VALUES (200096,'N','N','N','Y','Import CSV Process','06345362-8973-4923-85a7-e41f61289953','P','Y',100,TO_TIMESTAMP('2014-12-02 16:56:59','YYYY-MM-DD HH24:MI:SS'),100,0,0,200076,'D',TO_TIMESTAMP('2014-12-02 16:56:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 2, 2014 4:56:59 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200096, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200096)
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=1000000
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=1000003
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=222
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=223
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=185
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=340
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53264
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53206
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=339
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=338
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53282
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=363
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=376
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=382
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=486
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=425
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=378
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=374
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53284
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=423
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53263
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=373
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=424
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200095
;

-- Dec 2, 2014 4:57:23 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=163, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200096
;

-- Dec 2, 2014 6:04:14 PM COT
UPDATE AD_Process_Para SET AD_Reference_ID=39,Updated=TO_TIMESTAMP('2014-12-02 18:04:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200112
;

SELECT register_migration_script('201412021658_IDEMPIERE-2103.sql') FROM dual
;

