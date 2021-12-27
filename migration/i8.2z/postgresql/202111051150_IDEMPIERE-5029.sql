-- IDEMPIERE-5029 User can make Shipment/Receipt Line Product different from Order Line Product
-- Nov 5, 2021, 7:31:15 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Shipment/Receipt Line Product is different from Order Line Product',0,0,'Y',TO_TIMESTAMP('2021-11-05 19:31:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-11-05 19:31:14','YYYY-MM-DD HH24:MI:SS'),100,200720,'MInOutLineAndOrderLineProductDifferent','D','2e24aa42-6a8e-4ff1-b236-43d16e543389')
;

-- Nov 8, 2021, 5:28:35 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200187,0,0,TO_TIMESTAMP('2021-11-08 17:28:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2021-11-08 17:28:34','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','VALIDATE_MATCHING_PRODUCT_ON_SHIPMENT','Y','Validate if the product on shipment line must match the same product on order line  (Y/N)','D','C','f8eb3b4b-a267-409a-ab83-fccdb11c8c88')
;

SELECT register_migration_script('202111051150_IDEMPIERE-5029.sql') FROM dual
;

