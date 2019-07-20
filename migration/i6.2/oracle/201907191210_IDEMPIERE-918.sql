SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-918  Allow to choose the reversal document for invoice
-- Jul 19, 2019, 12:09:45 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203347,0,0,'Y',TO_DATE('2019-07-19 12:09:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-07-19 12:09:33','YYYY-MM-DD HH24:MI:SS'),100,'IsCreateAllocation','Create Allocation',NULL,NULL,'Create Allocation','D','99112248-05b8-41d1-857c-5620a990c2f6')
;

-- Jul 19, 2019, 12:10:16 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200279,0,0,'Y',TO_DATE('2019-07-19 12:10:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2019-07-19 12:10:16','YYYY-MM-DD HH24:MI:SS'),100,'Create Allocation',200100,50,20,'N',1,'N','N','IsCreateAllocation','Y','D',203347,'49d6934d-3604-4acc-b24e-6c0d4054cd2b','N')
;

-- Jul 19, 2019, 12:14:09 PM CEST
UPDATE AD_Process_Para SET DisplayLogic='@DocAction@=CO',Updated=TO_DATE('2019-07-19 12:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200279
;

SELECT register_migration_script('201907191210_IDEMPIERE-918.sql') FROM dual
;

