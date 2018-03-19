-- IDEMPIERE-2771 Improve 2pack tracing for errors
-- Aug 19, 2015 9:55:02 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200067,0,0,TO_TIMESTAMP('2015-08-19 21:55:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2015-08-19 21:55:02','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','EMAIL_NOTIFY_2PACK',' ','EMail to get 2Pack Notifications','D','C','12ab33a5-4129-4d5b-9066-dbdbc20df816')
;

SELECT register_migration_script('201508192155_IDEMPIERE-2771.sql') FROM dual
;

