-- IDEMPIERE-5295 Trial Balance Report creates wrong Opening Balance
SELECT register_migration_script('202206282000_IDEMPIERE-5295.sql') FROM dual;

-- Jun 28, 2022, 7:52:14 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203609,0,0,'Y',TO_TIMESTAMP('2022-06-28 19:46:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-28 19:46:33','YYYY-MM-DD HH24:MI:SS'),100,'IsGroupByOrg','Group by Organization','Grouping based on Organization','An Organization wise grouping apply','Group by Organization','D','252461a9-046f-4c0a-baf8-105a21621ff7')
;

-- Jun 28, 2022, 7:53:01 PM IST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200386,0,0,'Y',TO_TIMESTAMP('2022-06-28 19:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-28 19:53:00','YYYY-MM-DD HH24:MI:SS'),100,'Group by Organization','Grouping based on Organization','An Organization wise grouping apply',310,140,20,'N',1,'N','N','IsGroupByOrg','Y','D',203609,'8791be5a-2921-4ed3-8bd5-e0f793af0543','N','N')
;

ALTER TABLE t_trialbalance 
DROP CONSTRAINT t_trialbalance_pkey
;

ALTER TABLE t_trialbalance
ADD CONSTRAINT t_trialbalance_pkey PRIMARY KEY (AD_PInstance_ID, Fact_Acct_ID, Account_ID, AD_Org_ID)
;
