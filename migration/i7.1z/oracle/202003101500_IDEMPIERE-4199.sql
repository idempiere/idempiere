SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4199 Clean up org.adempiere.extend
UPDATE AD_Client
SET ModelValidationClasses=NULL
WHERE AD_Client_ID=11
AND ModelValidationClasses='compiere.model.MyValidator'
;

UPDATE AD_Column
SET CallOut = NULL
WHERE CallOut = 'compiere.model.CalloutUser.justAnExample' AND AD_Column_ID=329
;

SELECT register_migration_script('202003101500_IDEMPIERE-4199.sql') FROM dual
;
