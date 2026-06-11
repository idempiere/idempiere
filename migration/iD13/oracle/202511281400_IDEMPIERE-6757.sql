-- IDEMPIERE-6757 - Asset Group lookup shows no records while Asset Groups exist
SELECT register_migration_script('202511281400_IDEMPIERE-6757.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 28, 2025, 2:00:14 PM CET
UPDATE AD_Val_Rule SET Code='(A_Asset_Type_ID IS NULL OR A_Asset_Type_ID = @A_Asset_Type_ID@)',Updated=TO_TIMESTAMP('2025-11-28 14:00:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52085
;

