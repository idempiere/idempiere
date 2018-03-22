-- IDEMPIERE-3664
-- Mar 22, 2018 10:16:54 AM BRT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200116,0,0,TO_TIMESTAMP('2018-03-22 10:16:53','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2018-03-22 10:16:53','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','AUTO_ASSIGN_ROLE_TO_CREATOR_USER','N','Defines if a role is assigned to the creator user when creating a new role ','D','S','dc4be8d1-a164-4e6d-8e02-be6c498d1669')
;

-- Mar 22, 2018 10:17:03 AM BRT
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_TIMESTAMP('2018-03-22 10:17:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200116
;

SELECT register_migration_script('201803221017_IDEMPIERE-3664.sql') FROM dual
;

