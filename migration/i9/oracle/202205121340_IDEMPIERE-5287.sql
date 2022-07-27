-- IDEMPIERE-5287 Minor issue in 'sql where' from Window 'User Preference' (impact Report function)
SELECT register_migration_script('202205121340_IDEMPIERE-5287.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 12, 2022, 1:40:51 PM CEST
UPDATE AD_Tab SET WhereClause='AD_UserPreference.AD_User_ID=@#AD_User_ID@ AND AD_UserPreference.AD_Client_ID=@#AD_Client_ID@',Updated=TO_TIMESTAMP('2022-05-12 13:40:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200189
;

-- May 12, 2022, 1:41:37 PM CEST
UPDATE AD_Tab SET WhereClause='C_City.C_Region_ID IS NULL AND C_City.C_Country_ID = @C_Country_ID@',Updated=TO_TIMESTAMP('2022-05-12 13:41:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200095
;

-- May 12, 2022, 1:42:09 PM CEST
UPDATE AD_Tab SET WhereClause='AD_CtxHelpSuggestion.Processed=''N''',Updated=TO_TIMESTAMP('2022-05-12 13:42:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200216
;

