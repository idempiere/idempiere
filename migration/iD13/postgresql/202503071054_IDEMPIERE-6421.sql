-- IDEMPIERE-6421 Make the "Server started" email configurable to enable/disable
SELECT register_migration_script('202503071054_IDEMPIERE-6421.sql') FROM dual;

-- Mar 7, 2025, 10:58:49 AM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200260,0,0,TO_TIMESTAMP('2025-03-07 10:58:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-03-07 10:58:48','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','EMAIL_SERVER_START_ENABLED','Y','Enabled the "Send Email" feature upon server startup','D','S','79350426-5d2c-4b95-b9f0-ec9de2363a2d')
;

