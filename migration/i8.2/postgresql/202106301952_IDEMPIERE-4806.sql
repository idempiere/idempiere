-- IDEMPIERE-4806 System Configurator window must be Advanced
-- Jun 30, 2021, 7:51:57 PM CEST
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_TIMESTAMP('2021-06-30 19:51:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=50009
;

SELECT register_migration_script('202106301952_IDEMPIERE-4806.sql') FROM dual
;

