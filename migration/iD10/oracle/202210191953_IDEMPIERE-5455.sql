-- IDEMPIERE-5455 Use Multi-Select parameters in Info Windows
SELECT register_migration_script('202210191953_IDEMPIERE-5455.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 19, 2022, 7:53:10 PM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200163, AD_Reference_Value_ID=138, AD_Val_Rule_ID=NULL, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-19 19:53:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200039
;

