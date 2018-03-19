-- Jul 17, 2013 6:31:01 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process_Para SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2013-07-17 18:31:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200067
;

-- Jul 17, 2013 6:32:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value,AD_Client_ID) VALUES ('N',200058,'N','N','a3b56b92-5704-48f7-b05a-c82adc965c1e','4','N','N',0,0,'Y','D','Create Foreign Key',0,TO_TIMESTAMP('2013-07-17 18:32:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 18:32:14','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.compiere.process.CreateForeignKey','CreateForeignKey',0)
;

-- Jul 17, 2013 6:32:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200058 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jul 17, 2013 6:32:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,AD_Val_Rule_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID) VALUES ('N',126,200069,'79638995-cc19-4b2d-99f9-3280ab62ae11','The Database Table provides the information of the table definition',200058,30,200047,'N',53290,'D','Table','AD_Table_ID','Database Table information',0,'Y',10,'Y',100,TO_TIMESTAMP('2013-07-17 18:32:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 18:32:53','YYYY-MM-DD HH24:MI:SS'),0,'N',0)
;

-- Jul 17, 2013 6:32:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Jul 17, 2013 6:33:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,AD_Val_Rule_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID) VALUES ('N',104,200070,'e16a1a3c-31e3-4b7a-af4d-05420e7b17bb','Link to the database column of the table',200058,30,100,'N',3,'D','Column','AD_Column_ID','Column in the table',0,'Y',20,'Y',100,TO_TIMESTAMP('2013-07-17 18:33:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-17 18:33:34','YYYY-MM-DD HH24:MI:SS'),0,'N',0)
;

-- Jul 17, 2013 6:33:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Jul 17, 2013 6:34:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,"action",IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200065,'N','N','N',200058,'D','Y','Create Foreign Key','54351c18-3276-4429-b9c0-1d072b296e91','P','Y',100,TO_TIMESTAMP('2013-07-17 18:34:30','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-07-17 18:34:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Jul 17, 2013 6:34:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Jul 17, 2013 6:34:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200065, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200065)
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Jul 17, 2013 6:34:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Jul 17, 2013 7:12:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process_Para SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2013-07-17 19:12:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200067
;

-- Jul 17, 2013 7:12:39 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process_Para SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2013-07-17 19:12:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200069
;

-- Jul 17, 2013 7:12:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process_Para SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2013-07-17 19:12:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200070
;

-- Jul 17, 2013 7:14:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Processed table: {0}, Processed foreign key: {1}, Error: {2}',200205,'D','2ea056aa-31ad-479b-8649-a9c7c202cbcb','CreateForeignKeyProcessResult','Y',TO_TIMESTAMP('2013-07-17 19:14:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-17 19:14:13','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 17, 2013 7:14:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200205 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 17, 2013 7:14:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Process table: ',200206,'D','e2a802b1-2a0d-4f80-859a-1c2ef7fd92c2','CreateForeignKeyProcessTable','Y',TO_TIMESTAMP('2013-07-17 19:14:47','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-17 19:14:47','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 17, 2013 7:14:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200206 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 18, 2013 6:00:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-07-18 18:00:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200069
;

-- Jul 19, 2013 6:02:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Process column: ',200209,'D','28924812-7226-4107-8c36-8447763bc7cd','CreateForeignKeyProcessColumn','Y',TO_TIMESTAMP('2013-07-19 18:02:30','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-19 18:02:30','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 19, 2013 6:02:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200209 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 19, 2013 6:05:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Foreign key already exists:  ',200210,'D','fc625fe7-0dcb-455c-b4ba-7b5cc7dd2939','CreateForeignKeyProcessExists','Y',TO_TIMESTAMP('2013-07-19 18:05:20','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-19 18:05:20','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 19, 2013 6:05:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200210 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 19, 2013 6:05:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Message SET MsgText='Foreign key already exists: ',Updated=TO_TIMESTAMP('2013-07-19 18:05:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200210
;

-- Jul 19, 2013 6:05:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Message_Trl SET MsgText='Foreign key already exists: ',Updated=TO_TIMESTAMP('2013-07-19 18:05:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200210 AND AD_Language='es_CO'
;

SELECT register_migration_script('201307191811_IDEMPIERE-1132.sql') FROM dual
;