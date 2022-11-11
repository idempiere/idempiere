-- IDEMPIERE-2398
SELECT register_migration_script('202211112054_IDEMPIERE-2398.sql') FROM dual;

-- Nov 11, 2022, 8:54:32 PM CET
UPDATE AD_Menu SET Name='Create Asset from Project', AD_Window_ID=NULL, AD_Workflow_ID=NULL, AD_Task_ID=NULL, AD_Form_ID=NULL, AD_InfoWindow_ID=NULL,Updated=TO_TIMESTAMP('2022-11-11 20:54:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200006
;

-- Nov 11, 2022, 8:54:32 PM CET
UPDATE AD_Process SET Name='Create Asset from Project', AD_ReportView_ID=NULL, Statistic_Count=9, Statistic_Seconds=461, AD_PrintFormat_ID=NULL, AD_Workflow_ID=NULL, AD_Form_ID=NULL, AD_CtxHelp_ID=NULL,Updated=TO_TIMESTAMP('2022-11-11 20:54:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200000
;

-- Nov 11, 2022, 8:54:32 PM CET
UPDATE AD_Process_Para SET AD_Reference_Value_ID=NULL, FieldLength=10, DefaultValue=NULL, IsCentrallyMaintained='N', AD_Element_ID=208, DisplayLogic=NULL,Updated=TO_TIMESTAMP('2022-11-11 20:54:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200000
;

-- Nov 11, 2022, 8:54:33 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200413,0,0,'Y',TO_TIMESTAMP('2022-11-11 20:54:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-11 20:54:32','YYYY-MM-DD HH24:MI:SS'),100,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200000,20,30,'N',10,'N','M_Product_ID','Y','U',454,'269067ec-4d24-4b67-a918-cc62c016107e','N')
;

