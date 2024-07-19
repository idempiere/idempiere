-- IDEMPIERE-5497 Support User vs Roles - minor improvement - change Role to list (FHCA-4016)
SELECT register_migration_script('202211281240_IDEMPIERE-5497.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 28, 2022, 12:40:37 PM CET
UPDATE AD_InfoColumn SET AD_Reference_ID=19,Updated=TO_TIMESTAMP('2022-11-28 12:40:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200158
;

