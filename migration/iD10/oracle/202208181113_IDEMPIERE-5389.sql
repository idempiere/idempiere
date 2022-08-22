-- IDEMPIERE-5389
SELECT register_migration_script('202208181113_IDEMPIERE-5389.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 16, 2022, 4:52:58 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200203,0,0,TO_TIMESTAMP('2022-08-16 16:52:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-08-16 16:52:58','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','DASHBOARD_LAYOUT_ORIENTATION','R','C - columns (vertical layout) / R - rows (horizontal layout)','D','S','4de26350-c352-4552-87be-44abe331f821')
;

