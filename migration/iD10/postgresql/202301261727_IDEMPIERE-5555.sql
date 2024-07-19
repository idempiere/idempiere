-- IDEMPIERE-5555 Locator not showing all options on Product window with only a warehouse
SELECT register_migration_script('202301261727_IDEMPIERE-5555.sql') FROM dual;

-- Jan 26, 2023, 5:27:51 PM CET
UPDATE AD_Window SET PredefinedContextVariables='IgnoreIsSOTrxInBPInfo=Y
IgnoreProductInLocatorEditor=Y',Updated=TO_TIMESTAMP('2023-01-26 17:27:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=140
;

