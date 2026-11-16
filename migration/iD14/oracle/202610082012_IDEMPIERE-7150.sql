-- IDEMPIERE-7150 Auto Produce: Add AD_SysConfig configuration for auto produce of nested BOM
SELECT register_migration_script('202610082012_IDEMPIERE-7150.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 8, 2026, 8:12:37 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200333,0,0,TO_TIMESTAMP('2026-10-08 20:12:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-10-08 20:12:36','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','AUTO_PRODUCE_NESTED_BOM','F','Determines auto-production behavior for nested BOM components with insufficient on-hand quantity. Values: Y - Auto-produce nested BOM, N - Do not auto-produce nested BOM, F - Auto-produce only if the nested BOM/item is marked for auto-produce.','D','C','01a11b6e-04e5-7688-b349-45d367015779')
;

