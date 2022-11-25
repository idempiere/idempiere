-- IDEMPIERE-5450 Form SQL Process has security issues
SELECT register_migration_script('202210131724_IDEMPIERE-5450.sql') FROM dual;

-- Oct 13, 2022, 5:24:11 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200209,0,0,TO_TIMESTAMP('2022-10-13 17:24:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-10-13 17:24:11','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','FORM_SQL_PROCESS_ALLOWED_KEYWORDS','ALTER,ANALYZE,COMMENT,CREATE,DELETE,DROP,GRANT,INSERT,REINDEX,REVOKE,SET,UPDATE,TRUNCATE,VACUUM','Comma separated list of commands allowed in the SQL Process form','D','S','52f9e30d-4a15-4a63-890c-c338e9f20f61')
;

