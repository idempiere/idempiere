SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 17, 2014 7:50:03 PM COT
-- IDEMPIERE-1996 InventoryLine inherits bad default
UPDATE AD_Column SET Callout='org.idempiere.model.CalloutFillLocator.fillLocator',Updated=TO_DATE('2014-12-17 19:50:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3537
;

-- Dec 17, 2014 7:51:10 PM COT
UPDATE AD_Column SET Callout='org.idempiere.model.CalloutFillLocator.fillLocator;org.compiere.model.CalloutInventory.product',Updated=TO_DATE('2014-12-17 19:51:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3564
;

SELECT register_migration_script('201412171953_IDEMPIERE-1996.sql') FROM dual
;

