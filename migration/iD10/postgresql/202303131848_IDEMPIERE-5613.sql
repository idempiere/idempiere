-- IDEMPIERE-5613 Make filling of _UU column optional
SELECT register_migration_script('202303131848_IDEMPIERE-5613.sql') FROM dual;

-- Mar 13, 2023, 6:48:00 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203792,0,0,'Y',TO_TIMESTAMP('2023-03-13 18:46:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-13 18:46:14','YYYY-MM-DD HH24:MI:SS'),100,'IsClearUUID','Clear UUID','Clear UUID when column is inactive',NULL,'Clear UUID','D','69bb1e9c-14f1-4e4a-a43e-4417875c0de3')
;

-- Mar 13, 2023, 6:48:13 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200432,0,0,'Y',TO_TIMESTAMP('2023-03-13 18:48:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-13 18:48:12','YYYY-MM-DD HH24:MI:SS'),100,'Clear UUID','Clear UUID when column is inactive',53252,30,20,'N',1,'Y','N','IsClearUUID','Y','D',203792,'ef8c4d7e-8ee4-4911-a6e5-4d1d8989e4be','N','N','D','N')
;

