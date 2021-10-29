SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5020 Allow to show products without price in Info Product window
-- Oct 28, 2021, 3:59:55 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200186,0,0,TO_DATE('2021-10-28 15:59:55','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2021-10-28 15:59:55','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','INFO_PRODUCT_SHOW_PRODUCTS_WITHOUT_PRICE','N','Show products without price in Info Product window','D','C','23e1f806-a084-4379-83ea-182dab696126')
;

SELECT register_migration_script('202110281600_IDEMPIERE-5020.sql') FROM dual
;

