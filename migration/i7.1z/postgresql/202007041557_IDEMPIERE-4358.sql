-- IDEMPIERE-4358 Processes to drop some objects from database
-- Jul 4, 2020, 3:35:36 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200120,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:35:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:35:35','YYYY-MM-DD HH24:MI:SS'),100,'Drop Database Table','Drop the table in the database','WARNING!!!  This is a destructive action, please make a backup before proceeding.','N','DatabaseTableDrop','N','org.compiere.process.DatabaseTableDrop','4','D',0,0,'N','N','Y','N','1fc89f20-060a-424b-8634-2bccbdb6de12')
;

-- Jul 4, 2020, 3:37:03 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203424,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:36:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:36:16','YYYY-MM-DD HH24:MI:SS'),100,'AreYouSure','Are you sure?','Confirmation request when doing dangerous actions.','Please confirm you understand the risk of the action you are taking.','Are you sure?','D','88849a2f-3a27-438d-86c9-ce72b3ea141d')
;

-- Jul 4, 2020, 3:37:22 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200301,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:37:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:37:21','YYYY-MM-DD HH24:MI:SS'),100,'Are you sure?','Confirmation request when doing dangerous actions.','Please confirm you understand the risk of the action you are taking.',200120,10,20,'N',1,'Y','N','AreYouSure','Y','D',203424,'55023129-ce02-4ce1-939a-43832c003629','N','N')
;

-- Jul 4, 2020, 3:38:19 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203425,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:38:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:38:01','YYYY-MM-DD HH24:MI:SS'),100,'IsEvenWithData','Even with data?',NULL,NULL,'Even with data?','D','6c63e33e-2313-483d-abd2-f92e7b8c08fe')
;

-- Jul 4, 2020, 3:38:30 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200302,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:38:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:38:30','YYYY-MM-DD HH24:MI:SS'),100,'Even with data?',200120,20,20,'N',1,'Y','N','IsEvenWithData','Y','D',203425,'9825273a-d91d-46b5-99b3-95050e17ec62','N','N')
;

-- Jul 4, 2020, 3:46:59 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200121,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:46:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:46:59','YYYY-MM-DD HH24:MI:SS'),100,'Rename Database Table','Rename the table in the database and dictionary','This process renames the table in database, the dictionary and also the associated columns _ID and _UU','N','DatabaseTableRename','N','org.compiere.process.DatabaseTableRename','4','D',0,0,'N','N','Y','N','e012d5a2-f228-4864-8232-7bb4434456d1','P')
;

-- Jul 4, 2020, 3:47:39 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203426,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:47:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:47:26','YYYY-MM-DD HH24:MI:SS'),100,'NewName','New Name',NULL,NULL,'New Name','D','8741354b-d4cf-4853-8ce3-11fc1159f721')
;

-- Jul 4, 2020, 3:48:59 PM CEST
UPDATE AD_Element SET ColumnName='NewTableName', Name='New Table Name', PrintName='New Table Name',Updated=TO_TIMESTAMP('2020-07-04 15:48:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203426
;

-- Jul 4, 2020, 3:48:59 PM CEST
UPDATE AD_Column SET ColumnName='NewTableName', Name='New Table Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203426
;

-- Jul 4, 2020, 3:48:59 PM CEST
UPDATE AD_Process_Para SET ColumnName='NewTableName', Name='New Table Name', Description=NULL, Help=NULL, AD_Element_ID=203426 WHERE UPPER(ColumnName)='NEWTABLENAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jul 4, 2020, 3:48:59 PM CEST
UPDATE AD_Process_Para SET ColumnName='NewTableName', Name='New Table Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203426 AND IsCentrallyMaintained='Y'
;

-- Jul 4, 2020, 3:48:59 PM CEST
UPDATE AD_InfoColumn SET ColumnName='NewTableName', Name='New Table Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203426 AND IsCentrallyMaintained='Y'
;

-- Jul 4, 2020, 3:48:59 PM CEST
UPDATE AD_Field SET Name='New Table Name', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203426) AND IsCentrallyMaintained='Y'
;

-- Jul 4, 2020, 3:48:59 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='New Table Name', Name='New Table Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203426)
;

-- Jul 4, 2020, 3:49:06 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200303,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:49:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:49:06','YYYY-MM-DD HH24:MI:SS'),100,'New Table Name',200121,10,10,'N',40,'Y','NewTableName','Y','D',203426,'1a83701b-42ee-4505-a864-3a7322c2d77f','N','N')
;

-- Jul 4, 2020, 3:50:04 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200122,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:50:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:50:04','YYYY-MM-DD HH24:MI:SS'),100,'Drop Database Column','Drop the column in the database','WARNING!!!  This is a destructive action, please make a backup before proceeding.','N','DatabaseColumneDrop','N','org.compiere.process.DatabaseColumnDrop','4','D',0,0,'N','N','Y','N','6e752ca3-f909-43f6-b8ae-d45c68a5d0c2','P')
;

-- Jul 4, 2020, 3:50:21 PM CEST
UPDATE AD_Process SET Description='Drop the table in the database', Help='WARNING!!!  This is a destructive action, please make a backup before proceeding.', ProcedureName=NULL, IsReport='N', IsDirectPrint='N', AD_ReportView_ID=NULL, Classname='org.compiere.process.DatabaseTableDrop', AccessLevel='4', AD_PrintFormat_ID=NULL, AD_Workflow_ID=NULL, IsBetaFunctionality='N', IsServerProcess='N', ShowHelp='Y', JasperReport=NULL, AD_Form_ID=NULL,Updated=TO_TIMESTAMP('2020-07-04 15:50:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200122
;

-- Jul 4, 2020, 3:50:22 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU) VALUES (200304,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:50:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:50:21','YYYY-MM-DD HH24:MI:SS'),100,'Are you sure?','Confirmation request when doing dangerous actions.','Please confirm you understand the risk of the action you are taking.',200122,10,20,'N',1,'Y','N','AreYouSure','Y','D',203424,'bad8ba70-5d16-4440-a14b-5437fddc371a')
;

-- Jul 4, 2020, 3:50:22 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU) VALUES (200305,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:50:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:50:22','YYYY-MM-DD HH24:MI:SS'),100,'Even with data?',200122,20,20,'N',1,'Y','N','IsEvenWithData','Y','D',203425,'dc0f76f7-2a5d-49ad-9f01-6ab1e7cafbe2')
;

-- Jul 4, 2020, 3:50:48 PM CEST
UPDATE AD_Process SET Description='Drop the column in the database', Value='DatabaseColumnDrop', Classname='org.compiere.process.DatabaseColumnDrop',Updated=TO_TIMESTAMP('2020-07-04 15:50:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200122
;

-- Jul 4, 2020, 3:51:23 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200123,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:51:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:51:22','YYYY-MM-DD HH24:MI:SS'),100,'Drop Database Constraint','Drop the constraint in the database','WARNING!!!  This is a destructive action, please make a backup before proceeding.','N','DatabaseConstraintDrop','N','org.compiere.process.DatabaseConstraintDrop','4','D',0,0,'N','N','Y','N','6a3ee613-efb9-456b-b713-c95e3f99ffe6','P')
;

-- Jul 4, 2020, 3:51:31 PM CEST
UPDATE AD_Process SET Help=NULL,Updated=TO_TIMESTAMP('2020-07-04 15:51:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200123
;

-- Jul 4, 2020, 3:52:38 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200124,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:52:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:52:38','YYYY-MM-DD HH24:MI:SS'),100,'Rename Column(s) in Database','Rename Column(s) in Database','This process rename all the columns associated with the element','N','DatabaseColumnRename','N','org.compiere.process.DatabaseColumnRename','4','D',0,0,'N','N','Y','N','f56e0b37-4f5a-4d23-ae3b-6f9219e2a1a3','P')
;

-- Jul 4, 2020, 3:53:39 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2020-07-04 15:53:39','YYYY-MM-DD HH24:MI:SS'),100,'DatabaseColumnRename','Y',200102,'DatabaseColumnRename',TO_TIMESTAMP('2020-07-04 15:53:39','YYYY-MM-DD HH24:MI:SS'),100,'N','7091148c-f9a2-44d0-8e1f-7425c117e275','W',203,200124,10,'D')
;

-- Jul 4, 2020, 3:54:39 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203427,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:53:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:53:53','YYYY-MM-DD HH24:MI:SS'),100,'NewColumnName','New Column Name',NULL,NULL,'New Column Name','D','94dc7592-831a-4a04-b21a-9dc33f2f8c97')
;

-- Jul 4, 2020, 3:54:51 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200306,0,0,'Y',TO_TIMESTAMP('2020-07-04 15:54:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2020-07-04 15:54:50','YYYY-MM-DD HH24:MI:SS'),100,'New Column Name',200124,10,10,'N',30,'Y','NewColumnName','Y','D',203427,'0b888e85-be69-4818-a657-d1c436ee3cc2','N','N')
;

-- Jul 4, 2020, 3:55:38 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2020-07-04 15:55:38','YYYY-MM-DD HH24:MI:SS'),100,'DatabaseTableRename','Y',200103,'DatabaseTableRename',TO_TIMESTAMP('2020-07-04 15:55:38','YYYY-MM-DD HH24:MI:SS'),100,'N','c4c20409-42a7-4dcc-9b22-c2c9b288eda9','W',100,200121,10,'D')
;

-- Jul 4, 2020, 3:55:55 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2020-07-04 15:55:55','YYYY-MM-DD HH24:MI:SS'),100,'DatabaseTableDrop','Y',200104,'DatabaseTableDrop',TO_TIMESTAMP('2020-07-04 15:55:55','YYYY-MM-DD HH24:MI:SS'),100,'N','8760c7f5-8978-41e5-bb04-65fc5398ad4a','W',100,200120,20,'D')
;

-- Jul 4, 2020, 3:56:18 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2020-07-04 15:56:17','YYYY-MM-DD HH24:MI:SS'),100,'DatabaseColumnDrop','Y',200105,'DatabaseColumnDrop',TO_TIMESTAMP('2020-07-04 15:56:17','YYYY-MM-DD HH24:MI:SS'),100,'N','ae7e64e8-1fd8-40d6-855b-71f4f7a2f449','W',101,200122,10,'D')
;

-- Jul 4, 2020, 3:57:08 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2020-07-04 15:57:07','YYYY-MM-DD HH24:MI:SS'),100,'DatabaseConstraintDrop','Y',200106,'DatabaseConstraintDrop',TO_TIMESTAMP('2020-07-04 15:57:07','YYYY-MM-DD HH24:MI:SS'),100,'N','b6285a11-29d9-4ff8-bbc9-436a3202cffd','W',101,200123,'@FKConstraintName@!''''',20,'D')
;

-- Jul 5, 2020, 2:16:24 PM CEST
UPDATE AD_Column SET IsToolbarButton='B',Updated=TO_TIMESTAMP('2020-07-05 14:16:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6483
;

SELECT register_migration_script('202007041557_IDEMPIERE-4358.sql') FROM dual
;

