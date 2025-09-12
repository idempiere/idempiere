-- IDEMPIERE-5088 fix predefined context in bank/cash transfer window
SELECT register_migration_script('202507041519_IDEMPIERE-5088.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 4, 2025, 3:19:02 PM CEST
UPDATE AD_Menu SET PredefinedContextVariables=NULL,Updated=TO_TIMESTAMP('2025-07-04 15:19:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200160
;

-- Jul 4, 2025, 3:19:04 PM CEST
UPDATE AD_Window SET PredefinedContextVariables='IgnoreIsSOTrxInBPInfo=Y',Updated=TO_TIMESTAMP('2025-07-04 15:19:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200105
;

