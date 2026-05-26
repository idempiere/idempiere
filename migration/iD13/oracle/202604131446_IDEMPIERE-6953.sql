-- IDEMPIERE-6953
SELECT register_migration_script('202604131446_IDEMPIERE-6953.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 13, 2026, 2:46:58 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200308,0,0,TO_TIMESTAMP('2026-04-13 14:46:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-04-13 14:46:57','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','CKEDITOR_FILE_CONFIG','/js/ckeditor/config.js','Path to the config file of CKEditor','D','C','019d86e1-7e24-71fc-a850-ca85ac51ede3')
;

-- Apr 13, 2026, 2:47:17 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200309,0,0,TO_TIMESTAMP('2026-04-13 14:47:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-04-13 14:47:17','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','CKEDITOR_FILE_CONFIG_MIN','/js/ckeditor/config-min.js','Path to the minimum (ie when in mobile mode) config file of CKEditor','D','C','019d86e1-caa6-7189-8e3e-621ea53b0bb7')
;

