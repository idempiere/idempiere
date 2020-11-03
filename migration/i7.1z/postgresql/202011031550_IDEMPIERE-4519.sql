-- IDEMPIERE-4519 Zk: Implement optional defer rendering for Grid View
-- Nov 3, 2020, 3:39:40 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200165,0,0,TO_TIMESTAMP('2020-11-03 15:39:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2020-11-03 15:39:39','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_GRID_VIEW_USE_DEFER_RENDERING','N','Defer row rendering for grid view','D','C','6a107269-96ba-45f9-9cda-6df7d04c3d3e')
;

SELECT register_migration_script('202011031550_IDEMPIERE-4519.sql') FROM dual
;

