SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4566 Translation Import/Export - output message is not visible
-- Nov 24, 2020, 2:45:45 PM CET
UPDATE AD_Form SET Name='Initial Client Setup Form (deprecated)',Updated=TO_DATE('2020-11-24 14:45:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=102
;

-- Nov 24, 2020, 2:45:45 PM CET
UPDATE AD_Menu SET Name='Initial Client Setup Form (deprecated)', Description='Initial new Client/Tenant Setup', IsActive='N',Updated=TO_DATE('2020-11-24 14:45:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=225
;

-- Nov 24, 2020, 2:45:58 PM CET
UPDATE AD_Process SET Name='Initial Client Setup',Updated=TO_DATE('2020-11-24 14:45:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53161
;

-- Nov 24, 2020, 2:45:58 PM CET
UPDATE AD_Menu SET Name='Initial Client Setup', Description=NULL, IsActive='Y',Updated=TO_DATE('2020-11-24 14:45:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=53202
;

-- Nov 24, 2020, 2:46:51 PM CET
UPDATE AD_Form SET IsActive='N', Name='Translation Import/Export Form (deprecated)',Updated=TO_DATE('2020-11-24 14:46:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=109
;

-- Nov 24, 2020, 2:46:51 PM CET
UPDATE AD_Menu SET Name='Translation Import/Export Form (deprecated)', Description='Import or Export Language Translation', IsActive='N',Updated=TO_DATE('2020-11-24 14:46:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=336
;

-- Nov 24, 2020, 2:48:24 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200126,0,0,'Y',TO_DATE('2020-11-24 14:48:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 14:48:24','YYYY-MM-DD HH24:MI:SS'),100,'Translation Import/Export','Import or Export Language Translation','Export/Import Translation info to/from xml for translation in external tool. Please note that the Language MUST be an enabled and verified System Langage.','N','TranslationImpExp','N','org.idempiere.process.TranslationImpExp','4','D',0,0,'N','N','Y','N','9b654152-331f-4ac7-9c61-06b1d1bc3edf','P')
;

-- Nov 24, 2020, 2:48:39 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200176,'Translation Import/Export','Import or Export Language Translation','P',0,0,'Y',TO_DATE('2020-11-24 14:48:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 14:48:39','YYYY-MM-DD HH24:MI:SS'),100,'N',200126,'N','N','D','Y','a478ce09-f97b-4541-a9be-4af79f32e712')
;

-- Nov 24, 2020, 2:48:39 PM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200176, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200176)
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=334
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=498
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=224
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=145
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=336
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=341
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=144
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=170
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=465
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200137
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=18, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200093
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=19, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=50008
;

-- Nov 24, 2020, 2:49:21 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=20, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200176
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=0, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=334
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=1, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=498
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=2, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=224
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=3, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=145
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=4, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200176
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=5, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=336
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=6, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=341
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=7, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=144
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=8, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=170
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=9, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=465
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=10, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200137
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=18, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=19, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=200093
;

-- Nov 24, 2020, 2:49:25 PM CET
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=20, Updated=getDate() WHERE AD_Tree_ID=10 AND Node_ID=50008
;

-- Nov 24, 2020, 2:50:12 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200327,0,0,'Y',TO_DATE('2020-11-24 14:50:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 14:50:11','YYYY-MM-DD HH24:MI:SS'),100,'Client (All)',200126,10,19,'N',0,'N','AD_AllClients_V_ID','Y','D',203119,'242503a7-d42c-408f-b1b2-15939d5a6abb','N','N')
;

-- Nov 24, 2020, 6:55:58 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200328,0,0,'Y',TO_DATE('2020-11-24 18:55:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 18:55:58','YYYY-MM-DD HH24:MI:SS'),100,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200126,20,18,327,'N',6,'N','AD_Language','Y','D',109,'a0c0f233-3825-4e0f-870d-e4dfb73b696d','N','N')
;

-- Nov 24, 2020, 6:56:11 PM CET
UPDATE AD_Process_Para SET SeqNo=30,Updated=TO_DATE('2020-11-24 18:56:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200328
;

-- Nov 24, 2020, 6:56:19 PM CET
UPDATE AD_Process_Para SET SeqNo=20,Updated=TO_DATE('2020-11-24 18:56:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200327
;

-- Nov 24, 2020, 6:56:48 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203448,0,0,'Y',TO_DATE('2020-11-24 18:56:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 18:56:29','YYYY-MM-DD HH24:MI:SS'),100,'ImportOrExport','Import/Export',NULL,NULL,'Import/Export','D','1f83a77c-cc8f-45ed-a1e2-66674494b371')
;

-- Nov 24, 2020, 6:57:14 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200178,'ImportOrExport','L',0,0,'Y',TO_DATE('2020-11-24 18:57:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 18:57:14','YYYY-MM-DD HH24:MI:SS'),100,'D','N','2d291969-c2a8-401d-b9ed-1d6f23539f04')
;

-- Nov 24, 2020, 6:57:29 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200495,'Import',200178,'import',0,0,'Y',TO_DATE('2020-11-24 18:57:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 18:57:29','YYYY-MM-DD HH24:MI:SS'),100,'D','b4359db4-9448-4a1f-b38a-38dc35335b02')
;

-- Nov 24, 2020, 6:57:36 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200496,'Export',200178,'export',0,0,'Y',TO_DATE('2020-11-24 18:57:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 18:57:36','YYYY-MM-DD HH24:MI:SS'),100,'D','51595870-5f58-45d0-80d6-8b075fd86d33')
;

-- Nov 24, 2020, 6:57:58 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200329,0,0,'Y',TO_DATE('2020-11-24 18:57:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 18:57:58','YYYY-MM-DD HH24:MI:SS'),100,'Import/Export',200126,10,17,200178,'N',6,'N','ImportOrExport','Y','D',203448,'c9301822-bbe7-4058-9087-6c90c71a878c','N','N')
;

-- Nov 24, 2020, 6:59:14 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,Description,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200179,'AD_Table Trl','Translated Tables','T',0,0,'Y',TO_DATE('2020-11-24 18:59:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 18:59:14','YYYY-MM-DD HH24:MI:SS'),100,'D','N','78da012b-514b-45e0-b253-84510b08cd32')
;

-- Nov 24, 2020, 7:00:14 PM CET
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200179,100,100,102,'AD_Table.TableName LIKE ''%_Trl'' AND AD_Table.TableName<>''AD_Column_Trl''',0,0,'Y',TO_DATE('2020-11-24 19:00:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 19:00:14','YYYY-MM-DD HH24:MI:SS'),100,'N','D','4b956f11-6628-49fa-9fd6-5d469bf2f464')
;

-- Nov 24, 2020, 7:00:57 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200330,0,0,'Y',TO_DATE('2020-11-24 19:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 19:00:57','YYYY-MM-DD HH24:MI:SS'),100,'Table','Database Table information','The Database Table provides the information of the table definition',200126,40,19,200179,'N',10,'N','AD_Table_ID','Y','D',126,'6aee4c66-4fa8-4712-bf96-69b3a38b0204','N','N')
;

-- Nov 24, 2020, 7:01:33 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203449,0,0,'Y',TO_DATE('2020-11-24 19:01:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 19:01:21','YYYY-MM-DD HH24:MI:SS'),100,'IsOnlyCentralizedData','Only Centralized Data',NULL,NULL,'Only Centralized Data','D','02bf77ad-69e3-4fec-88aa-d484f9d6c55e')
;

-- Nov 24, 2020, 7:02:30 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200331,0,0,'Y',TO_DATE('2020-11-24 19:02:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 19:02:29','YYYY-MM-DD HH24:MI:SS'),100,'Only Centralized Data',200126,50,20,'N',1,'Y','Y','IsOnlyCentralizedData','Y','D',203449,'@ImpExp@=''export''','47674c8b-4235-44b5-97c1-84d1d44e99c1','N','N')
;

-- Nov 24, 2020, 7:02:49 PM CET
UPDATE AD_Process_Para SET DisplayLogic='@ImportOrExport@=''export''',Updated=TO_DATE('2020-11-24 19:02:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200331
;

-- Nov 24, 2020, 7:04:15 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200332,0,0,'Y',TO_DATE('2020-11-24 19:04:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 19:04:15','YYYY-MM-DD HH24:MI:SS'),100,'Folder','A folder on a local or remote system to store data into','We store files in folders, especially media files.',200126,60,38,'N',255,'N','Folder','Y','D',3012,'39d67de6-2e3e-40d4-ae75-44913e80ca31','N','N')
;

-- Nov 24, 2020, 7:07:41 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200333,0,0,'Y',TO_DATE('2020-11-24 19:07:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 19:07:41','YYYY-MM-DD HH24:MI:SS'),100,'File Name','Name of the local file or URL','Name of a file in the local directory space - or URL (file://.., http://.., ftp://..)',200126,70,39,'N',1000,'N','FileName','Y','D',2295,'25f51c86-2286-45dd-9d14-1e34bbd5e148','N','N')
;

-- Nov 24, 2020, 7:07:46 PM CET
UPDATE AD_Process_Para SET FieldLength=1000,Updated=TO_DATE('2020-11-24 19:07:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200332
;

-- Nov 24, 2020, 7:10:10 PM CET
UPDATE AD_Process_Para SET DisplayLogic='@Folder@=''''',Updated=TO_DATE('2020-11-24 19:10:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200333
;

-- Nov 24, 2020, 7:10:19 PM CET
UPDATE AD_Process_Para SET DisplayLogic='@FileName@=''''',Updated=TO_DATE('2020-11-24 19:10:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200332
;

-- Nov 24, 2020, 7:11:59 PM CET
UPDATE AD_Process SET Help='Export/Import Translation info to/from xml for translation in external tool.  Please note that the Language MUST be an enabled and verified System Language.',Updated=TO_DATE('2020-11-24 19:11:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200126
;

-- Nov 24, 2020, 7:46:43 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Invalid File Format: only ZIP files are supported',0,0,'Y',TO_DATE('2020-11-24 19:46:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-11-24 19:46:42','YYYY-MM-DD HH24:MI:SS'),100,200654,'FileMustBeZIP','D','b05ed207-31c0-46c9-80b0-815b57aab19a')
;

-- Nov 24, 2020, 9:43:54 PM CET
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_DATE('2020-11-24 21:43:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200329
;

-- Nov 24, 2020, 9:44:04 PM CET
UPDATE AD_Process_Para SET DefaultValue='import',Updated=TO_DATE('2020-11-24 21:44:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200329
;

-- Nov 24, 2020, 9:45:54 PM CET
UPDATE AD_Process_Para SET IsMandatory='Y', DefaultValue='@SQL=SELECT MIN(AD_Language) FROM AD_Language WHERE IsSystemLanguage=''Y''',Updated=TO_DATE('2020-11-24 21:45:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200328
;

-- Nov 24, 2020, 9:56:12 PM CET
UPDATE AD_Process_Para SET DisplayLogic='@Folder@='''' & @ImportOrExport@=''import''',Updated=TO_DATE('2020-11-24 21:56:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200333
;

-- Nov 24, 2020, 9:56:29 PM CET
UPDATE AD_Process_Para SET SeqNo=55,Updated=TO_DATE('2020-11-24 21:56:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200332
;

-- Nov 24, 2020, 9:56:45 PM CET
UPDATE AD_Process_Para SET SeqNo=60,Updated=TO_DATE('2020-11-24 21:56:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200333
;

-- Nov 24, 2020, 9:56:48 PM CET
UPDATE AD_Process_Para SET SeqNo=70,Updated=TO_DATE('2020-11-24 21:56:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200332
;

-- Nov 24, 2020, 11:02:05 PM CET
UPDATE AD_Process_Para SET AD_Reference_ID=18,Updated=TO_DATE('2020-11-24 23:02:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200330
;

SELECT register_migration_script('202011241451_IDEMPIERE-4566.sql') FROM dual
;

