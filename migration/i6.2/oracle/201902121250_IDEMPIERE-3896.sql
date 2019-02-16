SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 11, 2019 4:36:05 PM CET
-- IDEMPIERE-3896 Process that fixes M_StorageReservation when wrong reservations are found
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,Help,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Updated,IsActive,UpdatedBy,Name,Created,CreatedBy,Classname,AD_Client_ID,EntityType,Value,AD_Org_ID,AllowMultipleExecution) VALUES ('N',200107,'The process checks if there are errors in storage reservartion (storageqtyReserved <> orderqtyreserved), if there are, it recreates all the reservation records for the offending products.','N','N','c4409eac-e5a8-4eac-b34a-1ac73319aa03','3','N','N',0,0,'Y',TO_DATE('2019-02-11 16:36:04','YYYY-MM-DD HH24:MI:SS'),'Y',100,'Recreate Storage Reservation',TO_DATE('2019-02-11 16:36:04','YYYY-MM-DD HH24:MI:SS'),100,'org.adempiere.process.RecreateStorageReservation',0,'D','RecreateStorageReservation',0,'N')
;

-- Feb 11, 2019 4:37:49 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,AD_Menu_UU,IsSOTrx,IsReadOnly,AD_Process_ID,IsCentrallyMaintained,Name,Action,IsActive,CreatedBy,AD_Client_ID,Created,Updated,UpdatedBy,EntityType,AD_Org_ID) VALUES (200166,'N','cac979ac-f9b3-4756-a367-1f2f5941ad41','N','N',200107,'Y','Recreate Storage Reservation','P','Y',100,0,TO_DATE('2019-02-11 16:37:48','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2019-02-11 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,'D',0)
;

-- Feb 11, 2019 4:37:49 PM CET
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200166, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200166)
;

-- Feb 11, 2019 4:37:49 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200166, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200166)
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000087
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000361
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000050
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000343
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000460
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000385
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000386
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000244
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000232
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000256
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000284
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000329
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000313
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000225
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000394
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000155
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000144
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=30, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000167
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=31, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000081
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=32, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000171
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=33, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000170
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=34, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000156
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=35, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000049
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=36, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000175
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=37, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000279
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=38, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000295
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=39, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000183
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=40, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000377
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=41, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000381
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=42, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000092
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=43, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000250
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=44, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000181
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=45, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000182
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=46, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000052
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=47, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000231
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=48, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000152
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=49, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000389
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=50, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000230
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=51, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000240
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=52, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000403
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=53, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000406
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=54, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000407
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=55, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000402
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=56, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000411
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=57, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000442
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=58, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000443
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=59, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000452
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=60, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000428
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=61, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000431
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=62, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000424
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=63, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000433
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=64, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000434
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=65, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000413
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=66, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000429
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=67, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000414
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=68, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000464
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=69, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000445
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=70, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000465
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=71, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000454
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=72, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000463
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=73, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000447
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=74, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000455
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=75, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000449
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=76, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000459
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=77, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000448
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200166
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=167
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=357
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=229
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=412
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=256
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=197
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=477
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=181
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=484
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=179
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=503
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200064
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=196
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=479
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=482
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=481
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=411
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000305
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53253
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=426
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=537
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=311
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=292
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=504
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=515
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000252
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000373
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000372
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000370
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=30, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000151
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=31, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000241
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=32, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000323
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=33, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000278
;

-- Feb 11, 2019 4:38:11 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=183, SeqNo=34, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=1000312
;

SELECT register_migration_script('201902121250_IDEMPIERE-3896.sql') FROM dual
;
