-- IDEMPIERE-6821
SELECT register_migration_script('202601201613_IDEMPIERE-6821.sql') FROM dual;

-- Jan 20, 2026, 4:13:36 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200520,0,0,'Y',TO_TIMESTAMP('2026-01-20 16:13:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-01-20 16:13:36','YYYY-MM-DD HH24:MI:SS'),10,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',156,90,200162,170,'N',173,0,'N','C_DocType_ID','Y','D',196,'019bdbf7-eb00-704a-bb31-b0a4a66c6bc5','N','N','D','N')
;

