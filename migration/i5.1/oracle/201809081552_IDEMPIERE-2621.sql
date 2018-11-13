SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2621 Assign default warehouse from Org on inventory docs
-- Sep 8, 2018 3:47:28 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.organization',Updated=TO_DATE('2018-09-08 15:47:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3523
;

-- Sep 8, 2018 3:48:02 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutOrder.organization',Updated=TO_DATE('2018-09-08 15:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3544
;

-- Sep 8, 2018 3:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=130, Callout='org.compiere.model.CalloutOrder.organization',Updated=TO_DATE('2018-09-08 15:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11469
;

SELECT register_migration_script('201809081552_IDEMPIERE-2621.sql') FROM dual
;

