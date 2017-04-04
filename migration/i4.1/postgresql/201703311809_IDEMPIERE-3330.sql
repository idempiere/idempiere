-- IDEMPIERE-3330 Shipment Line - movement qty field not shown until qty is changed
-- Mar 31, 2017 6:03:02 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutInOut.navigateInOutLine', IsUpdateable='N',Updated=TO_TIMESTAMP('2017-03-31 18:03:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3529
;

SELECT register_migration_script('201703311809_IDEMPIERE-3330.sql') FROM dual
;

