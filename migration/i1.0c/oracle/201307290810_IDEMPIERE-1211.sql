-- Jul 29, 2013 2:55:25 PM IST
-- IDEMPIERE-1211: Tenant view of Dashboard Content and Dashboard Preference windows incorrect.
UPDATE AD_Tab SET WhereClause='PA_DashboardPreference.AD_Client_ID = @#AD_Client_ID@',Updated=TO_DATE('2013-07-29 14:55:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200011
;

SELECT register_migration_script('201307290810_IDEMPIERE-1211.sql') FROM dual
;
