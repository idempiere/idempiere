SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 8, 2021, 8:22:01 AM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200134,0,0,'Y',TO_DATE('2021-07-08 08:22:00','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:22:00','YYYY-MM-DD HH24:MI:SS'),0,'Create Table','N','CreateTable','N','org.idempiere.process.CreateTable','4','D',0,0,'N','Y','N','7920ec21-56c0-4d97-9047-fc97e0f2f562','P')
;

-- Jul 8, 2021, 8:22:41 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200354,0,0,'Y',TO_DATE('2021-07-08 08:22:40','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:22:40','YYYY-MM-DD HH24:MI:SS'),0,'DB Table Name','Name of the table in the database','The DB Table Name indicates the name of the table in database.',200134,10,10,'N',27,'Y','TableName','Y','D',587,'fd9df7a7-10a5-40aa-a738-3acbd94934f3','N','N')
;

-- Jul 8, 2021, 8:22:58 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200355,0,0,'Y',TO_DATE('2021-07-08 08:22:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:22:57','YYYY-MM-DD HH24:MI:SS'),0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200134,20,10,'N',0,'N','Name','Y','D',469,'88868426-9b38-4166-aa17-4b5fd1d70759','N','N')
;

-- Jul 8, 2021, 8:23:09 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200356,0,0,'Y',TO_DATE('2021-07-08 08:23:08','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:08','YYYY-MM-DD HH24:MI:SS'),0,'Description','Optional short description of the record','A description is limited to 255 characters.',200134,30,10,'N',0,'N','Description','Y','D',275,'9589d825-1777-425e-827a-68f2643dbea2','N','N')
;

-- Jul 8, 2021, 8:23:26 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200357,0,0,'Y',TO_DATE('2021-07-08 08:23:26','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:26','YYYY-MM-DD HH24:MI:SS'),0,'Data Access Level','Access Level required','Indicates the access level required for this record or process.',200134,40,17,5,'N',0,'Y','AccessLevel','Y','D',145,'3d340ca9-6a2c-4e5a-8593-4acddb1902c6','N','N')
;

-- Jul 8, 2021, 8:23:39 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200358,0,0,'Y',TO_DATE('2021-07-08 08:23:39','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:39','YYYY-MM-DD HH24:MI:SS'),0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.

For customizations, copy the entity and select "User"!',200134,50,18,389,'N',0,'Y','EntityType','Y','D',1682,'4954083e-5856-4fc9-85bb-a187d9e12af4','N','N')
;

-- Jul 8, 2021, 8:24:00 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,Placeholder,IsAutocomplete) VALUES (200359,0,0,'Y',TO_DATE('2021-07-08 08:23:59','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:23:59','YYYY-MM-DD HH24:MI:SS'),0,'Length of Value Column',200134,60,11,'N',0,'N','ValueLength','N','D','890ece13-6f2c-4757-b175-63b1358fd89f','N','Leave empty if not needed','N')
;

-- Jul 8, 2021, 8:24:11 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,Placeholder,IsAutocomplete) VALUES (200360,0,0,'Y',TO_DATE('2021-07-08 08:24:11','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:24:11','YYYY-MM-DD HH24:MI:SS'),0,'Length of Name Column',200134,70,11,'N',0,'N','NameLength','N','D','65bd630e-40b1-40ec-8e19-49da03fe239f','N','Leave empty if not needed','N')
;

-- Jul 8, 2021, 8:24:33 AM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,ReadOnlyLogic) VALUES (200361,0,0,'Y',TO_DATE('2021-07-08 08:24:32','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-08 08:24:32','YYYY-MM-DD HH24:MI:SS'),0,'Create KeyColumn',200134,80,20,'N',0,'N','Y','IsCreateKeyColumn','N','D','372a15e7-cc49-41cc-811d-cac11e446057','N','N', '1=1')
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

-- Jul 20, 2021, 2:55:13 PM CEST
UPDATE AD_Process_Para SET DefaultValue='@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',Updated=TO_DATE('2021-07-20 14:55:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200358
;

-- Jul 20, 2021, 2:56:00 PM CEST
UPDATE AD_Process_Para SET Name='Create ''Value'' column', AD_Reference_ID=20, IsMandatory='Y', DefaultValue='Y', ColumnName='IsCreateColValue', Placeholder=NULL,Updated=TO_DATE('2021-07-20 14:56:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200359
;

-- Jul 20, 2021, 2:56:18 PM CEST
UPDATE AD_Process_Para SET Name='Create ''Name'' column', AD_Reference_ID=20, DefaultValue='Y', ColumnName='IsCreateColName', Placeholder=NULL,Updated=TO_DATE('2021-07-20 14:56:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200360
;

-- Jul 20, 2021, 2:56:42 PM CEST
UPDATE AD_Process_Para SET SeqNo=999,Updated=TO_DATE('2021-07-20 14:56:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200359
;

-- Jul 20, 2021, 2:56:46 PM CEST
UPDATE AD_Process_Para SET SeqNo=9999,Updated=TO_DATE('2021-07-20 14:56:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200360
;

-- Jul 20, 2021, 2:56:50 PM CEST
UPDATE AD_Process_Para SET SeqNo=60,Updated=TO_DATE('2021-07-20 14:56:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200361
;

-- Jul 20, 2021, 2:56:52 PM CEST
UPDATE AD_Process_Para SET SeqNo=70,Updated=TO_DATE('2021-07-20 14:56:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200362
;

-- Jul 20, 2021, 2:56:55 PM CEST
UPDATE AD_Process_Para SET SeqNo=80,Updated=TO_DATE('2021-07-20 14:56:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200363
;

-- Jul 20, 2021, 2:56:57 PM CEST
UPDATE AD_Process_Para SET SeqNo=90,Updated=TO_DATE('2021-07-20 14:56:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200359
;

-- Jul 20, 2021, 2:56:59 PM CEST
UPDATE AD_Process_Para SET SeqNo=100,Updated=TO_DATE('2021-07-20 14:56:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Process_Para_ID=200360
;

-- Jul 20, 2021, 3:24:57 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200364,0,0,'Y',TO_DATE('2021-07-20 15:24:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:24:57','YYYY-MM-DD HH24:MI:SS'),0,'Create ''Description'' column',200134,110,20,'N',0,'N','Y','IsCreateColDescription','N','D','7e942d0b-47fd-4442-8d29-48b4587adf42','N','N')
;

-- Jul 20, 2021, 3:25:11 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200365,0,0,'Y',TO_DATE('2021-07-20 15:25:11','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:25:11','YYYY-MM-DD HH24:MI:SS'),0,'Create ''Help'' column',200134,120,20,'N',0,'N','Y','IsCreateColHelp','N','D','c4fcfdef-5363-4bcd-8de7-716242a0ea9b','N','N')
;

-- Jul 20, 2021, 3:25:23 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200366,0,0,'Y',TO_DATE('2021-07-20 15:25:22','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:25:22','YYYY-MM-DD HH24:MI:SS'),0,'Create ''DocumentNo'' column',200134,130,20,'N',0,'N','N','IsCreateColDocumentNo','N','D','545b1499-3d88-4f28-a919-aa4de11c7f5b','N','N')
;

-- Jul 20, 2021, 3:25:35 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200367,0,0,'Y',TO_DATE('2021-07-20 15:25:35','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:25:35','YYYY-MM-DD HH24:MI:SS'),0,'Create ''DocAction'' column',200134,140,20,'N',0,'N','N','IsCreateColDocAction','N','D','c71da134-4b3c-4ddd-91bc-2d235a6973cc','N','N')
;

-- Jul 20, 2021, 3:25:45 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200368,0,0,'Y',TO_DATE('2021-07-20 15:25:44','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:25:44','YYYY-MM-DD HH24:MI:SS'),0,'Create ''DocStatus'' column',200134,150,20,'N',0,'N','N','IsCreateColDocStatus','N','D','fa6f4c61-6cad-46b6-a11b-14fbab2eb39d','N','N')
;

-- Jul 20, 2021, 3:25:53 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200369,0,0,'Y',TO_DATE('2021-07-20 15:25:53','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:25:53','YYYY-MM-DD HH24:MI:SS'),0,'Create ''Processed'' column',200134,160,20,'N',0,'N','N','IsCreateColProcessed','N','D','9859451e-5c4e-4e0f-a663-d5f8463dc8c6','N','N')
;

-- Jul 20, 2021, 3:26:02 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200370,0,0,'Y',TO_DATE('2021-07-20 15:26:02','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:26:02','YYYY-MM-DD HH24:MI:SS'),0,'Create ''ProcessedOn'' column',200134,170,20,'N',0,'N','N','IsCreateColProcessedOn','N','D','1819ed86-c467-4052-b84b-cbbd46e3bb18','N','N')
;

-- Jul 20, 2021, 3:26:11 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200371,0,0,'Y',TO_DATE('2021-07-20 15:26:11','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:26:11','YYYY-MM-DD HH24:MI:SS'),0,'Create ''Processing'' column',200134,180,20,'N',0,'N','N','IsCreateColProcessing','N','D','f9f26c01-30de-4eab-b2f9-f19975b4278b','N','N')
;

-- Jul 20, 2021, 3:26:22 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200372,0,0,'Y',TO_DATE('2021-07-20 15:26:21','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:26:21','YYYY-MM-DD HH24:MI:SS'),0,'Create ''C_DocTypeTarget_ID'' column',200134,190,20,'N',0,'N','N','IsCreateColC_DocTypeTarget_ID','N','D','51a57984-1a2b-4e18-b36a-8cc8fe300dea','N','N')
;

-- Jul 20, 2021, 3:26:30 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200373,0,0,'Y',TO_DATE('2021-07-20 15:26:30','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:26:30','YYYY-MM-DD HH24:MI:SS'),0,'Create ''C_DocType_ID'' column',200134,200,20,'N',0,'N','N','IsCreateColC_DocType_ID','N','D','ce0b0d61-db59-4595-8d10-1a399d93f708','N','N')
;

-- Jul 20, 2021, 3:26:39 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200374,0,0,'Y',TO_DATE('2021-07-20 15:26:39','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:26:39','YYYY-MM-DD HH24:MI:SS'),0,'Create ''C_Currency_ID'' column',200134,210,20,'N',0,'N','N','IsCreateColC_Currency_ID','N','D','104e29c4-06d9-4926-b887-f2321ae1bed7','N','N')
;

-- Jul 20, 2021, 3:26:47 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200375,0,0,'Y',TO_DATE('2021-07-20 15:26:47','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:26:47','YYYY-MM-DD HH24:MI:SS'),0,'Create ''DateTrx'' column',200134,220,20,'N',0,'N','N','IsCreateColDateTrx','N','D','8e93af3c-c5f7-42b4-b8bc-6436421f8ed8','N','N')
;

-- Jul 20, 2021, 3:26:55 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200376,0,0,'Y',TO_DATE('2021-07-20 15:26:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:26:55','YYYY-MM-DD HH24:MI:SS'),0,'Create ''DateAcct'' column',200134,230,20,'N',0,'N','N','IsCreateColDateAcct','N','D','a27f9a81-194f-457e-a535-7c7d6ba58473','N','N')
;

-- Jul 20, 2021, 3:27:04 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200377,0,0,'Y',TO_DATE('2021-07-20 15:27:04','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:27:04','YYYY-MM-DD HH24:MI:SS'),0,'Create ''Posted'' column',200134,240,20,'N',0,'N','N','IsCreateColPosted','N','D','790453eb-7c27-45de-a6cd-96b56fcc37bb','N','N')
;

-- Jul 20, 2021, 3:27:14 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200378,0,0,'Y',TO_DATE('2021-07-20 15:27:14','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:27:14','YYYY-MM-DD HH24:MI:SS'),0,'Create ''IsApproved'' column',200134,250,20,'N',0,'N','N','IsCreateColIsApproved','N','D','9410f400-7785-43c2-9a7b-1eb676c42295','N','N')
;

-- Jul 20, 2021, 3:27:24 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200379,0,0,'Y',TO_DATE('2021-07-20 15:27:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:27:23','YYYY-MM-DD HH24:MI:SS'),0,'Create ''SalesRep_ID'' column',200134,260,20,'N',0,'N','N','IsCreateColSalesRep_ID','N','D','561fca18-19e0-44f8-b530-bc3a2e3adedf','N','N')
;

-- Jul 20, 2021, 3:27:34 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200380,0,0,'Y',TO_DATE('2021-07-20 15:27:34','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-07-20 15:27:34','YYYY-MM-DD HH24:MI:SS'),0,'Create ''AD_User_ID'' column',200134,270,20,'N',0,'N','N','IsCreateColAD_User_ID','N','D','017601cc-3f7b-4492-8b9f-b71c632224dd','N','N')
;

-- Jul 21, 2021, 4:31:09 PM CEST
UPDATE AD_Process_Para SET ReadOnlyLogic='@IsCreateWorkflow@=Y',Updated=TO_DATE('2021-07-21 16:31:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200367
;

-- Jul 21, 2021, 4:31:15 PM CEST
UPDATE AD_Process_Para SET ReadOnlyLogic='@IsCreateWorkflow@=Y',Updated=TO_DATE('2021-07-21 16:31:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200368
;

-- Jul 21, 2021, 4:31:17 PM CEST
UPDATE AD_Process_Para SET ReadOnlyLogic='@IsCreateWorkflow@=Y',Updated=TO_DATE('2021-07-21 16:31:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200369
;

-- Jul 21, 2021, 4:31:19 PM CEST
UPDATE AD_Process_Para SET ReadOnlyLogic='@IsCreateWorkflow@=Y',Updated=TO_DATE('2021-07-21 16:31:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200370
;

-- Jul 21, 2021, 4:31:21 PM CEST
UPDATE AD_Process_Para SET ReadOnlyLogic='@IsCreateWorkflow@=Y',Updated=TO_DATE('2021-07-21 16:31:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200371
;

-- Jul 21, 2021, 5:21:47 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_DATE('2021-07-21 17:21:47','YYYY-MM-DD HH24:MI:SS'),100,'Create Table','Y',200114,'Create Table',TO_DATE('2021-07-21 17:21:47','YYYY-MM-DD HH24:MI:SS'),100,'N','f9537ff0-2389-47d6-afa3-0d864a34eb8d','W',100,200134,'@IsView@=N',30,'D')
;

-- Jul 21, 2021, 5:23:36 PM CEST
UPDATE AD_Process_Para SET DisplayLogic='@AD_Table_ID@=0',DefaultValue='@TableName@',Updated=TO_DATE('2021-07-21 17:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200354
;

-- Jul 21, 2021, 5:23:59 PM CEST
UPDATE AD_Process_Para SET DisplayLogic='@AD_Table_ID@=0',Updated=TO_DATE('2021-07-21 17:23:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200355
;

-- Jul 21, 2021, 5:24:09 PM CEST
UPDATE AD_Process_Para SET DisplayLogic='@AD_Table_ID@=0',DefaultValue='@Description@',Updated=TO_DATE('2021-07-21 17:24:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200356
;

-- Jul 21, 2021, 5:24:13 PM CEST
UPDATE AD_Process_Para SET DisplayLogic='@AD_Table_ID@=0',DefaultValue='@Name@',Updated=TO_DATE('2021-07-21 17:24:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200355
;

-- Jul 21, 2021, 5:24:24 PM CEST
UPDATE AD_Process_Para SET DisplayLogic='@AD_Table_ID@=0',DefaultValue='@AccessLevel@',Updated=TO_DATE('2021-07-21 17:24:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200357
;

-- Jul 21, 2021, 7:10:05 PM CEST
UPDATE AD_Process SET Name='Create/Complete Table',Updated=TO_DATE('2021-07-21 19:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200134
;

-- Jul 21, 2021, 7:10:05 PM CEST
UPDATE AD_Menu SET Name='Create/Complete Table', Description=NULL, IsActive='Y',Updated=TO_DATE('2021-07-21 19:10:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200194
;

SELECT register_migration_script('202107080800_IDEMPIERE-4858.sql') FROM dual
;
