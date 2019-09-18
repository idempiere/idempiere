SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4050 Minor bug: spelling error in report Invoice Transactions (Doc)
-- Sep 18, 2019, 6:39:20 PM CEST
UPDATE AD_Process SET Help='The report lists the invoice transactions by invoice date',Updated=TO_DATE('2019-09-18 18:39:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=151
;

SELECT register_migration_script('201909181839_IDEMPIERE-4050.sql') FROM dual
;

