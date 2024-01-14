-- IDEMPIERE-5991 test process define
SELECT register_migration_script('202401111559_IDEMPIERE-5991.sql') FROM dual;

-- Jan 11, 2024, 3:59:11 PM ICT
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (nextidfunc(1281,'N'),0,0,'Y',TO_TIMESTAMP('2024-01-11 15:59:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 15:59:11','YYYY-MM-DD HH24:MI:SS'),100,'Test Info',100,'U','AD_Table a','N','d695dab6-d1b4-4bc0-ab6c-e12ae624763f','N','N','N',110,'N',0,'Y',0)
;

-- Jan 11, 2024, 3:59:51 PM ICT
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete,IsQueryAfterChange,IsRange) VALUES (nextidfunc(1283,'N'),0,0,'Y',TO_TIMESTAMP('2024-01-11 15:59:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 15:59:51','YYYY-MM-DD HH24:MI:SS'),100,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',toRecordId('AD_InfoWindow','d695dab6-d1b4-4bc0-ab6c-e12ae624763f'),'U','a.Name',10,'Y','Y',469,10,'a421f4d7-b95e-4b89-8614-5c1ff234a513','Y','Name','Like','Upper','Y',10,'N','N','Y','N','N','N')
;

-- Jan 11, 2024, 3:59:51 PM ICT
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2024-01-11 15:59:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_UU='d695dab6-d1b4-4bc0-ab6c-e12ae624763f'
;

-- Jan 11, 2024, 4:00:20 PM ICT
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,EntityType) VALUES (nextidfunc(200176,'N'),'6895babe-9e74-4e11-9fd3-090b545f60a6',0,0,'Y',TO_TIMESTAMP('2024-01-11 16:00:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 16:00:20','YYYY-MM-DD HH24:MI:SS'),100,10,toRecordId('AD_Process','a20d7420-2a03-4329-a232-b29f72da660f'),toRecordId('AD_InfoWindow','d695dab6-d1b4-4bc0-ab6c-e12ae624763f'),'B','U')
;

-- Jan 11, 2024, 4:01:35 PM ICT
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU,AD_InfoWindow_ID) VALUES (nextidfunc(7,'N'),'Test Info','I',0,0,'Y',TO_TIMESTAMP('2024-01-11 16:01:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-11 16:01:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','U','Y','8e063054-f716-405f-856d-27751986c3ce',toRecordId('AD_InfoWindow','d695dab6-d1b4-4bc0-ab6c-e12ae624763f'))
;

-- Jan 11, 2024, 4:01:35 PM ICT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, toRecordId('AD_Menu','8e063054-f716-405f-856d-27751986c3ce'), 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=toRecordId('AD_Menu','8e063054-f716-405f-856d-27751986c3ce'))
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=1000001
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200224
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200225
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200218
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200168
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=20,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200169
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=21,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200221
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=22,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200222
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=23,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=24,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=25,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=26,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=27,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=28,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=29,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200161
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=30,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=31,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Jan 11, 2024, 4:02:41 PM ICT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=32,Updated=TO_TIMESTAMP('2024-01-11 16:02:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200177
;

