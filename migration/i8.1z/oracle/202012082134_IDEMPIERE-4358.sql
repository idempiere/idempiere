SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4358 Processes to drop some objects from database
-- Dec 8, 2020, 9:25:38 PM CET
UPDATE AD_Process SET Value='DatabaseElementColumnRename',Classname='org.compiere.process.DatabaseElementColumnRename',Updated=TO_DATE('2020-12-08 21:25:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200124
;

-- Dec 8, 2020, 9:26:37 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200127,0,0,'Y',TO_DATE('2020-12-08 21:26:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-12-08 21:26:37','YYYY-MM-DD HH24:MI:SS'),100,'Rename Column in Database','Rename Column in Database','This process rename the column on the database','N','DatabaseTableColumnRename','N','org.compiere.process.DatabaseTableColumnRename','4','D',0,0,'N','N','Y','N','b2da47fb-cc79-4d79-a526-d9ca8907ca57','P')
;

-- Dec 8, 2020, 9:32:10 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200334,0,0,'Y',TO_DATE('2020-12-08 21:32:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-12-08 21:32:10','YYYY-MM-DD HH24:MI:SS'),100,'System Element','System Element enables the central maintenance of column description and help.','The System Element allows for the central maintenance of help, descriptions and terminology for a database column.',200127,10,30,'N',10,'Y','AD_Element_ID','Y','D',106,'65d005d9-7211-4806-b3b5-8d8ba51453a8','N','N')
;

-- Dec 8, 2020, 9:33:15 PM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_DATE('2020-12-08 21:33:15','YYYY-MM-DD HH24:MI:SS'),100,'DatabaseTableColumnRename','Y',200111,'DatabaseTableColumnRename',TO_DATE('2020-12-08 21:33:15','YYYY-MM-DD HH24:MI:SS'),100,'N','53b26db7-e3bc-43f4-8d35-8c3fd5d36586','W',101,200127,30,'D')
;

-- Dec 8, 2020, 9:44:30 PM CET
UPDATE AD_ToolBarButton SET DisplayLogic='@IsView@=N',Updated=TO_DATE('2020-12-08 21:44:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200103
;

-- Dec 8, 2020, 9:44:45 PM CET
UPDATE AD_ToolBarButton SET DisplayLogic='@IsView@=N',Updated=TO_DATE('2020-12-08 21:44:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200104
;

-- Dec 8, 2020, 9:45:17 PM CET
UPDATE AD_ToolBarButton SET DisplayLogic='@IsView@=N',Updated=TO_DATE('2020-12-08 21:45:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200105
;

-- Dec 8, 2020, 9:45:23 PM CET
UPDATE AD_ToolBarButton SET DisplayLogic='@IsView@=N',Updated=TO_DATE('2020-12-08 21:45:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200111
;

SELECT register_migration_script('202012082134_IDEMPIERE-4358.sql') FROM dual
;

