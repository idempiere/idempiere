SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5073 M_InOutLineMA.DateMaterialPolicy should comes from MStorageOnHand or Shipment instead of through user entry
-- Dec 5, 2021, 5:06:51 PM MYT
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-12-05 17:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201618
;


SELECT register_migration_script('202112050910_IDEMPIERE-5073.sql') FROM dual
;

