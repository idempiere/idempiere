-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202303181647_IDEMPIERE-5567.sql') FROM dual;

-- Mar 18, 2023, 4:47:30 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200433,0,0,'Y',TO_TIMESTAMP('2023-03-18 16:47:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-03-18 16:47:29','YYYY-MM-DD HH24:MI:SS'),100,'Link Column','Link Column for Multi-Parent tables','The Link Column indicates which column is the primary key for those situations where there is more than one parent.  Only define it, if the table has more than one parent column (e.g. AD_User_Roles).',200118,70,19,3,'N',100,10,'N','AD_Column_ID','N','D',104,'5fce2b79-b32a-4b42-868b-c6d1dbee5cc9','N','N','D','N')
;

-- Mar 18, 2023, 4:48:24 PM CET
UPDATE AD_Process_Para SET DisplayLogic='@TabLevel@>0 & @IsNewWindow@=''N''', MandatoryLogic='@TabLevel@>0 & @IsNewWindow@=''N''',Updated=TO_TIMESTAMP('2023-03-18 16:48:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200433
;

