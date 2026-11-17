-- IDEMPIERE-7213 - Allow creation of View Components from an existing Database View (reverse of DatabaseViewValidate)
SELECT register_migration_script('202611171341_IDEMPIERE-7213.sql') FROM dual;

-- Nov 17, 2026, 1:41:00 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200174,0,0,'Y',TO_TIMESTAMP('2026-11-17 13:41:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-17 13:41:00','YYYY-MM-DD HH24:MI:SS'),100,'Create View Components from Database','Read the view definition from the database and create the view components and view columns','N','AD_Table_CreateViewComponentsFromDB','N','org.compiere.process.DatabaseViewImport','4','D',0,0,'N','Y','N','01a1e986-61a7-7e3c-8fd6-2ba6cd0be894','P')
;

-- Nov 17, 2026, 1:41:44 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200528,0,0,'Y',TO_TIMESTAMP('2026-11-17 13:41:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-17 13:41:43','YYYY-MM-DD HH24:MI:SS'),100,'Delete existing view components','Delete the existing view components and view columns before creating them from the database. If not selected, the process fails when the table already has view components',200174,10,20,'N',1,'N','N','DeleteOld','N','D',1669,'01a1e987-0bdc-7ff3-9469-3c62c38c08d3','N','N','D','N')
;

-- Nov 17, 2026, 1:43:36 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200529,0,0,'Y',TO_TIMESTAMP('2026-11-17 13:43:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-17 13:43:36','YYYY-MM-DD HH24:MI:SS'),100,'Create Columns from DB','Create the view columns as AD_Column in the dictionary','The result is the same as running the Create Columns from DB process manually',200174,20,20,'N',1,'N','Y','IsCreateColumns','N','D','01a1e988-c332-7052-ad5e-6afb2eb6ad19','N','N','D','N')
;

-- Nov 17, 2026, 1:46:01 PM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2026-11-17 13:46:01','YYYY-MM-DD HH24:MI:SS'),100,'Create View Components from Database','Y',200142,'Create View Components from Database',TO_TIMESTAMP('2026-11-17 13:46:01','YYYY-MM-DD HH24:MI:SS'),100,'N','01a1e98a-f98d-71f5-a2e2-3ce511619808','W',100,200174,'@IsView@=Y',40,'D')
;

-- Nov 17, 2026, 1:46:23 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','View {0} does not exist in the database',0,0,'Y',TO_TIMESTAMP('2026-11-17 13:46:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-17 13:46:23','YYYY-MM-DD HH24:MI:SS'),100,201073,'ViewNotFoundInDB','D','01a1e98b-4eb7-7855-8404-7daf4568f055')
;

-- Nov 17, 2026, 1:46:37 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The view definition cannot be converted to view components: {0}',0,0,'Y',TO_TIMESTAMP('2026-11-17 13:46:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-17 13:46:37','YYYY-MM-DD HH24:MI:SS'),100,201074,'ViewDefinitionNotSupported','D','01a1e98b-867c-7735-9a72-a84b76371f6c')
;

