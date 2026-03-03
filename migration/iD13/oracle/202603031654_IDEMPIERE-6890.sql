-- IDEMPIERE-6890 ZK Autocomplete Timeout System Configurator
SELECT register_migration_script('202603031654_IDEMPIERE-6890.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 3, 2026, 4:54:40 PM BRT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200298,0,0,TO_TIMESTAMP('2026-03-03 16:54:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-03-03 16:54:39','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SEARCH_AUTO_COMPLETE_TIMEOUT','1','Maximum time to retrieve and display for search field''s autocomplete list','U','C','d1a92d69-93dc-4b6a-a271-e4161504858f')
;

