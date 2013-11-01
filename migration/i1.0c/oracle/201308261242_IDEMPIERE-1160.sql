-- Aug 26, 2013 12:41:41 PM COT
-- IDEMPIERE-1160 Hide potentially dangerous stuff from non-admin users
UPDATE AD_Field SET IsAdvancedField='Y',Updated=TO_DATE('2013-08-26 12:41:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56486
;

SELECT register_migration_script('201308261242_IDEMPIERE-1160.sql') FROM dual
;

