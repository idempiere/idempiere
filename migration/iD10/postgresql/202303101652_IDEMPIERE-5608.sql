-- IDEMPIERE-5608
SELECT register_migration_script('202303101652_IDEMPIERE-5608.sql') FROM dual;

-- Mar 10, 2023, 4:52:29 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200219,0,0,TO_TIMESTAMP('2023-03-10 16:52:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2023-03-10 16:52:28','YYYY-MM-DD HH24:MI:SS'),10,10,'Y','LOG_PREFIX','@#AD_Client_Name@ - @#AD_User_Name@ - @#AD_Session_ID@','Prefix for logs ; you can use any context variables such as @#AD_Client_Name@, @#AD_User_Name@, @#AD_Session_ID@','D','C','f7c613cf-6264-44b8-b283-2fb642a9a7b4')
;

