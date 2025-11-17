-- 
SELECT register_migration_script('202511171122_IDEMPIERE-6724.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 17, 2025, 11:23:32 AM BRT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (nextidfunc(50009,'N'),0,0,TO_TIMESTAMP('2025-11-17 11:23:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-11-17 11:23:32','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','TRUNC_REPORT_DATE_FIELD','N','Y/N - Defines if TRUNC will be used in the Date type field of the report','D','S','019a9233-1488-794a-adc4-fdde6e16ac76')
;

