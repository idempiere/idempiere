-- IDEMPIERE-2296/IDEMPIERE-2367
-- Aug 19, 2015 4:02:58 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200065,0,0,TO_TIMESTAMP('2015-08-19 16:02:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2015-08-19 16:02:57','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SEQ_DEFAULT_VALUE_PANEL','63','Define the order to apply defaults on Info Windows - please check wiki for detailed explanation','D','C','bc05e8e6-1a56-4f06-a019-24f42e48d02a')
;

-- Aug 19, 2015 4:05:25 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200066,0,0,TO_TIMESTAMP('2015-08-19 16:05:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2015-08-19 16:05:25','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_INFO_NUM_PAGE_PRELOAD','4','Default of pages preloaded on Info Windows','D','S','f8fee03f-5922-4cf3-bf5a-ce7c5548dcb7')
;

SELECT register_migration_script('201508191607_IDEMPIERE-2296.sql') FROM dual
;

