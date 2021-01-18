-- Jan 18, 2021, 11:13:52 AM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200168,0,0,TO_TIMESTAMP('2021-01-18 11:13:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-01-18 11:13:51','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SEARCH_AUTO_COMPLETE_MAX_ROWS','500','Maximum number of rows to retrieve and display for search field''s autocomplete list','D','C','a54d5000-57db-42f7-a910-06ea1e1fd245')
;

SELECT register_migration_script('202001180340_IDEMPIERE-4651.sql') FROM dual
;

