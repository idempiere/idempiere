-- Sep 30, 2013 9:38:50 PM COT
-- IDEMPIERE-1408 User window must not show System users
UPDATE AD_Tab SET WhereClause='(AD_User.AD_Client_ID=@#AD_Client_ID@)',Updated=TO_TIMESTAMP('2013-09-30 21:38:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=118
;

SELECT register_migration_script('201309302139_IDEMPIERE-1408.sql') FROM dual
;

