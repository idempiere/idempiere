-- IDEMPIERE-6335
SELECT register_migration_script('202412101102_IDEMPIERE-6335.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 10, 2024, 11:06:45 AM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200484,0,0,'Y',TO_TIMESTAMP('2024-12-10 11:06:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-10 11:06:44','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',142,20,19,'N',52054,0,'N','C_DocType_ID','Y','D',196,'2b9ac743-0893-474a-aa96-c1eafe8fba86','N','N','D','N')
;

