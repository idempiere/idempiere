-- IDEMPIERE-2676 Incorrect context variables - onNavigate Callout
-- Sep 3, 2016 3:07:56 PM GMT+01:00
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.priceListReadOnly', IsUpdateable='N',Updated=TO_TIMESTAMP('2016-09-03 15:07:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2161
;

-- Sep 3, 2016 3:08:09 PM GMT+01:00
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.priceListReadOnly', IsUpdateable='N',Updated=TO_TIMESTAMP('2016-09-03 15:08:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3484
;

SELECT register_migration_script('201609031608_IDEMPIERE-2676.sql') FROM dual
;

