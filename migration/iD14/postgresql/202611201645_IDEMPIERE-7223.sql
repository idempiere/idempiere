-- IDEMPIERE-7223 Make zero-cost posting checks configurable via SysConfig and support zero-cost production and free purchase price list in Doc_InOut and Doc_Inventory
SELECT register_migration_script('202611201645_IDEMPIERE-7223.sql') FROM dual;

-- Nov 20, 2026, 4:45:12 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200339,0,0,TO_TIMESTAMP('2026-11-20 16:45:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-11-20 16:45:11','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CHECK_ZERO_COST_PO_FOR_ZERO_COST_POSTING','Y','Check for processed zero-cost PO or vendor invoice cost detail before failing zero-cost posting on shipment and physical inventory. Options: Y (Yes, default), N (No).','D','C','01a1f821-940a-7793-a896-43f6390bb5e0')
;

-- Nov 20, 2026, 4:47:10 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200340,0,0,TO_TIMESTAMP('2026-11-20 16:47:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-11-20 16:47:09','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CHECK_ZERO_COST_PRODUCTION_FOR_ZERO_COST_POSTING','N','Check for processed zero-cost production cost detail before failing zero-cost posting on shipment and physical inventory. Options: Y (Yes), N (No, default).','D','C','01a1f823-601c-7e60-b452-65f5f9069e26')
;

-- Nov 20, 2026, 4:47:18 PM MYT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200341,0,0,TO_TIMESTAMP('2026-11-20 16:47:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-11-20 16:47:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','CHECK_PURCHASE_PRICE_LIST_FOR_ZERO_COST_POSTING','N','Check for active zero-price purchase price list (with no positive purchase price) before failing zero-cost posting on shipment, receipt and physical inventory. Options: Y (Yes), N (No, default).','D','C','01a1f823-802a-7e50-8044-e559d7136fbb')
;

