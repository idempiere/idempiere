-- IDEMPIERE-5883 Improve default for Receipt parameter in Payment Info
SELECT register_migration_script('202310161235_IDEMPIERE-5883.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 16, 2023, 12:35:12 PM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=17, AD_Reference_Value_ID=319, DefaultValue=NULL,Updated=TO_TIMESTAMP('2023-10-16 12:35:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200085
;

