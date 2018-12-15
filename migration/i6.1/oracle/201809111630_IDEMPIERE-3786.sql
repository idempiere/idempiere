SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3786 : Number of records in detail grid must not be hardcoded
-- Sep 11, 2018 4:29:18 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200143,0,0,TO_DATE('2018-09-11 16:29:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-09-11 16:29:17','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','ZK_PAGING_DETAIL_SIZE','10','Default paging size for detail grid view in zk webui','D','C','e4555557-68a2-4b87-a605-4da79de87644')
;

SELECT register_migration_script('201809111630_IDEMPIERE-3786.sql') FROM dual
;
