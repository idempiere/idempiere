-- IDEMPIERE-5765 Shipment generated service lines cannot be directly edited because the Locator is empty
SELECT register_migration_script('202306072319_IDEMPIERE-5765.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 7, 2023, 11:21:24 PM CEST
UPDATE AD_Column SET MandatoryLogic='@M_Product_ID.ProductType@=I',Updated=TO_TIMESTAMP('2023-06-07 23:21:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3537
;

-- Jun 7, 2023, 11:21:28 PM CEST
UPDATE AD_Field SET IsMandatory=NULL,Updated=TO_TIMESTAMP('2023-06-07 23:21:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57905
;

-- Jun 7, 2023, 11:21:35 PM CEST
UPDATE AD_Field SET IsMandatory=NULL,Updated=TO_TIMESTAMP('2023-06-07 23:21:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2717
;

-- Jun 7, 2023, 11:21:44 PM CEST
UPDATE AD_Field SET IsMandatory=NULL,Updated=TO_TIMESTAMP('2023-06-07 23:21:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57766
;

-- Jun 7, 2023, 11:21:48 PM CEST
UPDATE AD_Field SET IsMandatory=NULL,Updated=TO_TIMESTAMP('2023-06-07 23:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3514
;

