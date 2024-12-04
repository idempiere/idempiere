-- IDEMPIERE-6335
SELECT register_migration_script('202412041007_IDEMPIERE-6335.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 4, 2024, 10:07:59 AM BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (nextidfunc(200,'N'),0,0,'Y',TO_TIMESTAMP('2024-12-04 10:07:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-04 10:07:59','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',142,20,19,'N',52054,0,'N','C_DocType_ID','Y','U',196,'2c4cf92c-8326-4fa5-8e0c-8643bf05a2e1','N','N','D','N')
;

