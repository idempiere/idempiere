-- IDEMPIERE-6471 Prevent data corruption if a plugin is missing
SELECT register_migration_script('202504051454_IDEMPIERE-6471.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 5, 2025, 2:54:45 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200261,0,0,TO_TIMESTAMP('2025-04-05 14:54:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-04-05 14:54:44','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ALLOW_SYSTEM_LOGIN_ON_MISSING_PLUGIN','N','Defines if System Role is allowed to login when there is a missing model validator or plugin','D','S','824fd6a8-8897-49be-84fb-4c801679bf04')
;

