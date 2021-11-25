SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4808 Payment Allocation should be IsSOTrx neutral
-- Nov 16, 2021, 2:29:19 PM CET
UPDATE AD_Window SET PredefinedContextVariables='IgnoreIsSOTrxInBPInfo=Y',Updated=TO_DATE('2021-11-16 14:29:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=140
;

SELECT register_migration_script('202111161430_IDEMPIERE-4808.sql') FROM dual
;

