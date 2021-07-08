SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 8, 2021, 8:22:01 AM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200134,0,0,'Y',TO_DATE('2021-07-08 08:22:00','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:22:00','YYYY-MM-DD HH24:MI:SS'),0,'Create Table','N','CreateTable','N','org.idempiere.process.CreateTable','4','D',0,0,'N','Y','N','7920ec21-56c0-4d97-9047-fc97e0f2f562','P')
;

-- Jul 8, 2021, 8:22:41 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200354,0,0,'Y',TO_DATE('2021-07-08 08:22:40','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:22:40','YYYY-MM-DD HH24:MI:SS'),0,'DB Table Name','Name of the table in the database','The DB Table Name indicates the name of the table in database.',200134,10,10,'N',27,'Y','TableName','Y','D',587,'fd9df7a7-10a5-40aa-a738-3acbd94934f3','N','N')
;

-- Jul 8, 2021, 8:22:58 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200355,0,0,'Y',TO_DATE('2021-07-08 08:22:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:22:57','YYYY-MM-DD HH24:MI:SS'),0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200134,20,10,'N',0,'N','Name','Y','U',469,'88868426-9b38-4166-aa17-4b5fd1d70759','N','N')
;

-- Jul 8, 2021, 8:23:09 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200356,0,0,'Y',TO_DATE('2021-07-08 08:23:08','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:08','YYYY-MM-DD HH24:MI:SS'),0,'Description','Optional short description of the record','A description is limited to 255 characters.',200134,30,10,'N',0,'N','Description','Y','D',275,'9589d825-1777-425e-827a-68f2643dbea2','N','N')
;

-- Jul 8, 2021, 8:23:11 AM CEST
UPDATE AD_Process_Para SET EntityType='D',Updated=TO_DATE('2021-07-08 08:23:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200355
;

-- Jul 8, 2021, 8:23:26 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200357,0,0,'Y',TO_DATE('2021-07-08 08:23:26','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:26','YYYY-MM-DD HH24:MI:SS'),0,'Data Access Level','Access Level required','Indicates the access level required for this record or process.',200134,40,17,5,'N',0,'Y','AccessLevel','Y','D',145,'3d340ca9-6a2c-4e5a-8593-4acddb1902c6','N','N')
;

-- Jul 8, 2021, 8:23:39 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200358,0,0,'Y',TO_DATE('2021-07-08 08:23:39','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:39','YYYY-MM-DD HH24:MI:SS'),0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.

For customizations, copy the entity and select "User"!',200134,50,18,389,'N',0,'Y','EntityType','Y','D',1682,'4954083e-5856-4fc9-85bb-a187d9e12af4','N','N')
;

-- Jul 8, 2021, 8:24:00 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,Placeholder,IsAutocomplete) VALUES (200359,0,0,'Y',TO_DATE('2021-07-08 08:23:59','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:59','YYYY-MM-DD HH24:MI:SS'),0,'Length of Value Column',200134,60,11,'N',0,'N','ValueLength','N','D','890ece13-6f2c-4757-b175-63b1358fd89f','N','Leave empty is not needed','N')
;

-- Jul 8, 2021, 8:24:11 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,Placeholder,IsAutocomplete) VALUES (200360,0,0,'Y',TO_DATE('2021-07-08 08:24:11','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:24:11','YYYY-MM-DD HH24:MI:SS'),0,'Length of Name Column',200134,70,11,'N',0,'N','NameLength','N','D','65bd630e-40b1-40ec-8e19-49da03fe239f','N','Leave empty is not needed','N')
;

-- Jul 8, 2021, 8:24:33 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200361,0,0,'Y',TO_DATE('2021-07-08 08:24:32','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:24:32','YYYY-MM-DD HH24:MI:SS'),0,'Create KeyColumn',200134,80,20,'N',0,'N','Y','IsCreateKeyColumn','N','D','372a15e7-cc49-41cc-811d-cac11e446057','N','N')
;

-- Jul 8, 2021, 8:24:48 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200362,0,0,'Y',TO_DATE('2021-07-08 08:24:48','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:24:48','YYYY-MM-DD HH24:MI:SS'),0,'Create a Workflow',200134,90,20,'N',0,'N','N','IsCreateWorkflow','N','D','4927153b-5408-4565-939f-7352a37dea43','N','N')
;

-- Jul 8, 2021, 8:25:04 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200363,0,0,'Y',TO_DATE('2021-07-08 08:25:04','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:25:04','YYYY-MM-DD HH24:MI:SS'),0,'Create a Translation Table',200134,100,20,'N',0,'N','N','IsCreateTranslationTable','N','D','af1cbfdf-d1e3-441e-86ad-4b7ba6b35c0b','N','N')
;

-- Jul 8, 2021, 8:25:41 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200194,'Create Table','P',0,0,'Y',TO_DATE('2021-07-08 08:25:41','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:25:41','YYYY-MM-DD HH24:MI:SS'),0,'N',200134,'Y','N','D','Y','bb9dd54f-09a4-4056-9ceb-d2d4ecae39f6')
;

-- Jul 8, 2021, 8:25:41 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 0, getDate(), 0,t.AD_Tree_ID, 200194, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200194)
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200145
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200142
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200194
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200150
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200174
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=33, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=34, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- Jul 8, 2021, 8:26:45 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=35, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=50001
;

SELECT register_migration_script('202107080800_IDEMPIERE-4628.sql') FROM dual
;
