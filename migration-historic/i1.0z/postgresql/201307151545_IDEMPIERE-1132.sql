-- Jul 12, 2013 5:21:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process (AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value,AD_Client_ID) VALUES (200057,'N','N','11d63490-997c-423d-b332-893132874f78','4','N','N',22,17,'Y','D','Create Table Index',0,TO_TIMESTAMP('2013-07-12 17:21:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-12 17:21:11','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.compiere.process.CreateTableIndex','CreateTableIndex',0)
;

-- Jul 12, 2013 5:21:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200057 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jul 12, 2013 5:23:08 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES ('AD_Table.IsView=''N''',200047,'D','AD_Table not View','S','47987b6f-4a3c-4cb7-aca2-6601f0eb8238',100,100,TO_TIMESTAMP('2013-07-12 17:23:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-12 17:23:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Jul 12, 2013 5:23:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,AD_Val_Rule_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID) VALUES ('N',126,200067,'c2a888cf-4319-495d-9982-aa4da8aca86d','The Database Table provides the information of the table definition',200057,18,200047,'N',53290,'D','Table','AD_Table_ID','Database Table information',0,'Y',10,'Y',100,TO_TIMESTAMP('2013-07-12 17:23:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-12 17:23:30','YYYY-MM-DD HH24:MI:SS'),0,'N',0)
;

-- Jul 12, 2013 5:23:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Jul 12, 2013 5:24:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,"action",IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200063,'N','N','N',200057,'D','Y','Create Table Index','1fc8d8ab-6932-42d5-a25e-a2c1bd946f4e','P','Y',100,TO_TIMESTAMP('2013-07-12 17:24:24','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-07-12 17:24:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 12, 2013 5:24:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200063 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Jul 12, 2013 5:24:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200063, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200063)
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Jul 12, 2013 5:24:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Jul 12, 2013 5:24:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Jul 15, 2013 3:21:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2013-07-15 15:21:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210545
;

-- Jul 15, 2013 3:21:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO t_alter_column values('ad_indexcolumn','AD_Column_ID','NUMERIC(10)',null,'NULL')
;

-- Jul 15, 2013 3:21:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO t_alter_column values('ad_indexcolumn','AD_Column_ID',null,'NULL',null)
;

-- Jul 15, 2013 3:32:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Processed table: {0}, Processed index: {1}, Error: {2}',200201,'D','ddf8d6fa-6c15-4738-b5d6-bb251eec7fb3','CreateTableIndexProcessResult','Y',TO_TIMESTAMP('2013-07-15 15:32:09','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-15 15:32:09','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 15, 2013 3:32:12 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200201 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 15, 2013 3:34:01 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Process table: ',200202,'D','930d4e28-6ec3-4b39-aafa-b150e3fc2423','CreateTableIndexProcessTable','Y',TO_TIMESTAMP('2013-07-15 15:34:00','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-15 15:34:00','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 15, 2013 3:34:01 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200202 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 15, 2013 3:34:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Create table index: ',200203,'D','d3065c3e-84e2-4d82-aa8c-1a14f12c6810','CreateTableIndexCreateTableIndex','Y',TO_TIMESTAMP('2013-07-15 15:34:55','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-15 15:34:55','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 15, 2013 3:34:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200203 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 15, 2013 3:35:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Validate table index: ',200204,'D','c3278c18-4d56-4860-a60e-3aa5d7e4001e','CreateTableIndexValidateTableIndex','Y',TO_TIMESTAMP('2013-07-15 15:35:35','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-15 15:35:35','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 15, 2013 3:35:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200204 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201307151545_IDEMPIERE-1132.sql') FROM dual
;