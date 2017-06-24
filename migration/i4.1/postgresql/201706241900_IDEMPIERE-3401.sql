-- IDEMPIERE-3401 Orderline Discount Context issue
-- Jun 24, 2017 6:44:50 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.navigateOrderLine', IsUpdateable='N',Updated=TO_TIMESTAMP('2017-06-24 18:44:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2205
;

-- Jun 24, 2017 6:45:45 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutInvoice.navigateInvoiceLine', IsUpdateable='N',Updated=TO_TIMESTAMP('2017-06-24 18:45:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3828
;

SELECT register_migration_script('201706241900_IDEMPIERE-3401.sql') FROM dual
;

