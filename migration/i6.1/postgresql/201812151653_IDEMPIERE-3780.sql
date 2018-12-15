-- IDEMPIERE-3780
-- Dec 15, 2018, 4:51:29 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2018-12-15 16:51:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205827
;

SELECT register_migration_script('201812151653_IDEMPIERE-3780.sql') FROM dual
;

