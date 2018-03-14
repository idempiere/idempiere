SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 11, 2013 6:56:20 PM COT
-- IDEMPIERE-1253 Password is not hidden in the window Storage Provider
UPDATE AD_Field SET IsEncrypted='Y',Updated=TO_DATE('2013-09-11 18:56:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200867
;

SELECT register_migration_script('201309111856_IDEMPIERE-1253.sql') FROM dual
;

