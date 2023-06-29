-- IDEMPIERE-5739 Allow Inventory Valuation Report for more than one warehouse
SELECT register_migration_script('202305262207_IDEMPIERE-5739.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 26, 2023, 10:07:05 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203812,0,0,'Y',TO_TIMESTAMP('2023-05-26 22:06:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-26 22:06:31','YYYY-MM-DD HH24:MI:SS'),100,'M_Warehouse_IDs','Warehouses',NULL,NULL,'Storage Warehouses and Service Points','D','ed8c53b8-6032-4e6a-b226-07c2c7624d63')
;

-- May 26, 2023, 10:09:14 PM CEST
UPDATE AD_Process_Para SET IsActive='N', SeqNo=5, IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2023-05-26 22:09:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=230
;

-- May 26, 2023, 10:09:19 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200438,0,0,'Y',TO_TIMESTAMP('2023-05-26 22:09:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-05-26 22:09:19','YYYY-MM-DD HH24:MI:SS'),100,'Warehouses',180,10,200162,197,'N',1000,'N','M_Warehouse_IDs','Y','D',203812,'74c772f8-692e-4eea-9dff-24652fa878e9','N','N','D','N')
;

