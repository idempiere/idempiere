-- IDEMPIERE-5082 Drop Shipment: Pass shipper and tracking number from MR to Customer Shipment
SELECT register_migration_script('202204071450_IDEMPIERE-5082.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 7, 2022, 2:50:38 PM MYT
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-07 14:50:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3444
;

