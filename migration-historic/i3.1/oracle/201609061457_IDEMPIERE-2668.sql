SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2668 Exclude Locators for Demand Operations
-- Sep 6, 2016 1:55:35 PM GMT+01:00
UPDATE AD_Field SET IsMandatory=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2016-09-06 13:55:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200649
;

-- Sep 6, 2016 1:55:56 PM GMT+01:00
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, MandatoryLogic='@M_Warehouse_ID@>0', IsToolbarButton=NULL,Updated=TO_DATE('2016-09-06 13:55:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200649
;

SELECT register_migration_script('201609061457_IDEMPIERE-2668.sql') FROM dual
;

