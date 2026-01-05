-- IDEMPIERE-6806
SELECT register_migration_script('202601050959_IDEMPIERE-6806.sql') FROM dual;

-- Jan 5, 2026, 9:59:56 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204024,0,0,'Y',TO_TIMESTAMP('2026-01-05 09:59:56','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-01-05 09:59:56','YYYY-MM-DD HH24:MI:SS'),10,'IsDeleteFactReconciled','Delete Reconciled Facts','Delete Reconciled Facts','D','019b8d62-6d9e-7bc2-a7a0-c728527391eb')
;

-- Jan 5, 2026, 10:00:16 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200519,0,0,'Y',TO_TIMESTAMP('2026-01-05 10:00:16','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-01-05 10:00:16','YYYY-MM-DD HH24:MI:SS'),10,'Delete Reconciled Facts',53199,10,20,'N',0,'N','N','IsDeleteFactReconciled','Y','D',204024,'@SQL=SELECT 1 FROM Fact_Reconciliation WHERE Fact_Acct_ID IN (SELECT Fact_Acct_ID FROM Fact_Acct WHERE AD_Table_ID = 735 AND Record_ID = @C_AllocationHdr_ID@)','019b8d62-ba62-7c09-a007-765e38f5575f','N','N','D','N')
;

