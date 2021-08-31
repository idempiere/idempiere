SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4853 Process to copy a Packout definition (FHCA-859)
-- Jun 30, 2021, 7:59:32 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200133,0,0,'Y',TO_DATE('2021-06-30 19:59:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-30 19:59:31','YYYY-MM-DD HH24:MI:SS'),100,'Copy from Pack Out','Copy Package Details from another Pack Out','N','CopyFromPackOut','N','org.compiere.process.CopyFromPackOut','6','D',0,0,'N','Y','N','65392ae4-8a3e-4a6e-a4ca-e665102df00a','P')
;

-- Jun 30, 2021, 7:59:58 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_DATE('2021-06-30 19:59:57','YYYY-MM-DD HH24:MI:SS'),100,'CopyFromPackOut','Y',200113,'CopyFromPackOut',TO_DATE('2021-06-30 19:59:57','YYYY-MM-DD HH24:MI:SS'),100,'N','a4e828bd-7fd5-4aa0-acf1-ba5dc91891d8','W',50005,200133,10,'D')
;

-- Jun 30, 2021, 8:02:52 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200353,0,0,'Y',TO_DATE('2021-06-30 20:02:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-30 20:02:52','YYYY-MM-DD HH24:MI:SS'),100,'Package Exp.',200133,10,30,NULL,'N',22,'N','AD_Package_Exp_ID','Y','D',50018,'7130b395-15d3-4c42-a598-190704860f7e','N','N')
;

-- Jun 30, 2021, 8:03:01 PM CEST
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_DATE('2021-06-30 20:03:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200353
;

-- Jun 30, 2021, 8:34:36 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200151,'AD_Package_Exp_ID except the current','S','AD_Package_Exp.AD_Package_Exp_ID!=@AD_Package_Exp_ID@',0,0,'Y',TO_DATE('2021-06-30 20:34:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-30 20:34:35','YYYY-MM-DD HH24:MI:SS'),100,'D','c33608e1-4124-4ec4-9eb3-7144d7ebb45d')
;

-- Jun 30, 2021, 8:34:43 PM CEST
UPDATE AD_Process_Para SET AD_Val_Rule_ID=200151,Updated=TO_DATE('2021-06-30 20:34:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200353
;

-- Jun 30, 2021, 8:51:25 PM CEST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_DATE('2021-06-30 20:51:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50106
;

-- Jun 30, 2021, 8:51:44 PM CEST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_DATE('2021-06-30 20:51:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213804
;

SELECT register_migration_script('202106302004_IDEMPIERE-4853.sql') FROM dual
;

