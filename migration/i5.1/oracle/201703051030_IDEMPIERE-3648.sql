SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3648 Bank statement : Error on BeginningBalance when creating a bank statement with empty BankAccount field
-- Mar 5, 2018 10:21:44 AM CET
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MIN(CurrentBalance),0) FROM C_BankAccount WHERE C_BankAccount_ID=@C_BankAccount_ID:0@',Updated=TO_DATE('2018-03-05 10:21:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=4919
;

SELECT register_migration_script('201703051030_IDEMPIERE-3648.sql') FROM dual
;