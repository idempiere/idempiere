SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 7, 2023, 11:30:09 AM WIB
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ValueMin,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete,DateRangeOption,IsShowNegateButton) VALUES (200447,0,0,'Y',TO_TIMESTAMP('2023-11-07 11:30:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-11-07 11:30:08','YYYY-MM-DD HH24:MI:SS'),100,'Keep Log Days',200156,10,11,'N',0,'Y','7','0','KeepLogDays','N','D','05b81f27-19df-4758-9a49-ffaeab4d6287','N','N','D','N')
;

-- Nov 7, 2023, 11:39:19 AM WIB
INSERT INTO AD_Scheduler_Para (AD_Process_Para_ID,IsActive,AD_Org_ID,CreatedBy,UpdatedBy,Created,Updated,ParameterDefault,AD_Client_ID,AD_Scheduler_ID,AD_Scheduler_Para_UU) VALUES (200447,'Y',0,100,100,TO_TIMESTAMP('2023-11-07 11:39:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-11-07 11:39:19','YYYY-MM-DD HH24:MI:SS'),'7',0,200002,'8b2ddb62-f7c0-4205-b827-d4ddbe9bd12c')
;

-- IDEMPIERE-5913
SELECT register_migration_script('202311071130_IDEMPIERE-5913.sql') FROM dual;