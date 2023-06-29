-- IDEMPIERE-5663
SELECT register_migration_script('202304111125_IDEMPIERE-5663.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 11, 2023, 11:25:54 AM BRT
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200241,'GL_Category (all)','T',0,0,'Y',TO_TIMESTAMP('2023-04-11 11:25:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-11 11:25:54','YYYY-MM-DD HH24:MI:SS'),100,'D','N','2f47a672-6fc4-4298-8026-ab34ee5e37e3','N')
;

-- Apr 11, 2023, 11:27:28 AM BRT
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU) VALUES (200241,218,1530,1530,0,0,'Y',TO_TIMESTAMP('2023-04-11 11:27:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-11 11:27:28','YYYY-MM-DD HH24:MI:SS'),100,'N','D','efc301b9-abc9-48f4-86b7-746091dcfcdd')
;

-- Apr 11, 2023, 11:31:20 AM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200435,0,0,'Y',TO_TIMESTAMP('2023-04-11 11:31:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-04-11 11:31:20','YYYY-MM-DD HH24:MI:SS'),100,'GL Category','General Ledger Category','The General Ledger Category is an optional, user defined method of grouping journal lines.',252,80,200162,200241,'N',0,'N','GL_Category_ID','Y','D',309,'44b1e9e4-c88d-4fec-8f7f-8bfd2cd5db79','N','N','D','Y')
;

