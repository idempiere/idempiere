-- IDEMPIERE-5576
SELECT register_migration_script('202302171049_IDEMPIERE-5576.sql') FROM dual;

-- Feb 17, 2023, 10:49:11 AM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200218,0,0,TO_TIMESTAMP('2023-02-17 10:49:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-02-17 10:49:10','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','FORCE_POSTING_PRIOR_TO_PERIOD_CLOSE','Y','Force posting prior to period close','D','C','53851066-a2fa-401e-8655-dc86c91d3241')
;

