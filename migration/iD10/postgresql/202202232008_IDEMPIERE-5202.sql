-- IDEMPIERE-5202 Implement auto save of current tab
SELECT register_migration_script('202202232008_IDEMPIERE-5202.sql') FROM dual;

-- Feb 23, 2022, 8:08:00 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200193,0,0,TO_TIMESTAMP('2022-02-23 20:07:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-02-23 20:07:59','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_AUTO_SAVE_CHANGES','N','Y/N - Define if the application will auto save changes of current tab','D','C','f7d6a7ee-7af4-465c-a9c5-21094250c736')
;

