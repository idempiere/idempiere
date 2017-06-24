-- IDEMPIERE-3409
-- Jun 24, 2017 6:06:16 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200103,0,0,TO_TIMESTAMP('2017-06-24 18:06:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2017-06-24 18:06:16','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','IDENTIFIER_SEPARATOR','_','Separator for the fields that compose an identifier on lookup boxes','D','C','3139dada-425f-42ea-8840-3080e88aa5e2')
;

SELECT register_migration_script('201706241808_IDEMPIERE-3409.sql') FROM dual
;

