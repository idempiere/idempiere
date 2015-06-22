-- IDEMPIERE-2676 Incorrect context variables
-- Jun 17, 2015 4:40:47 PM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.priceList', IsUpdateable='N',Updated=TO_TIMESTAMP('2015-06-17 16:40:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2161
;

-- Jun 22, 2015 12:50:04 PM COT
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.priceList', IsUpdateable='N',Updated=TO_TIMESTAMP('2015-06-22 12:50:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3484
;

SELECT register_migration_script('201506171641_IDEMPIERE-2676.sql') FROM dual
;

