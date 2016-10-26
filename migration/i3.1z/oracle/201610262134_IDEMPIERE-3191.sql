SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3191 time to update performance gadget should use configuration
-- Oct 26, 2016 9:34:15 PM CEST
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_DATE('2016-10-26 21:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200082
;

SELECT register_migration_script('201610262134_IDEMPIERE-3191.sql') FROM dual
;

