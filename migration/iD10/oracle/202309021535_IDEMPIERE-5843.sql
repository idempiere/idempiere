-- IDEMPIERE-5843 System support users (like SuperUser) cannot see (fix) preferences on tenants
SELECT register_migration_script('202309021535_IDEMPIERE-5843.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 2, 2023, 3:45:38 PM CEST
UPDATE AD_Tab SET WhereClause='(AD_Client_ID = @#AD_Client_ID@ OR ((SELECT AD_Client_ID FROM AD_User WHERE AD_User_ID=@#AD_User_ID@) = 0))',Updated=TO_TIMESTAMP('2023-09-02 15:45:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=156
;

DELETE FROM AD_Preference WHERE AD_User_ID=0
;

