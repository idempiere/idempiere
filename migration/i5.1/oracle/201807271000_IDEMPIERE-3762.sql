SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3762 : Fix AD_Column_ID / AD_Field_ID : Loader - Too many records
-- Jul 26, 2018 10:06:34 AM CEST
UPDATE AD_Field SET AD_Reference_ID=30,Updated=TO_DATE('2018-07-26 10:06:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4599
;

-- Jul 26, 2018 10:06:42 AM CEST
UPDATE AD_Field SET AD_Reference_ID=30,Updated=TO_DATE('2018-07-26 10:06:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=59576
;

SELECT register_migration_script('201807271000_IDEMPIERE-3762.sql') FROM dual
;
