-- IDEMPIERE-6248
SELECT register_migration_script('202409231820_IDEMPIERE-6248.sql') FROM dual;

-- Sep 23, 2024, 6:20:30 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200250,0,0,TO_TIMESTAMP('2024-09-23 18:20:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2024-09-23 18:20:29','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','FULL_EXCEPTION_TRACE_IN_LOG','N','If set to Y, the stack trace is not cut in the log (see https://idempiere.atlassian.net/browse/IDEMPIERE-6248)','D','S','8308ac18-d0a6-479f-ab59-7edd0bcb0b54')
;

