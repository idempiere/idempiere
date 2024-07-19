-- IDEMPIERE-2901 - Period Control Management - Multi-Select List Parameters
SELECT register_migration_script('202210191926_IDEMPIERE-2901.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 19, 2022, 7:26:01 PM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200161, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-19 19:26:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200222
;

-- Oct 19, 2022, 7:26:13 PM CEST
UPDATE AD_InfoColumn SET AD_Reference_ID=200161, QueryOperator='Like', QueryFunction='Upper',Updated=TO_TIMESTAMP('2022-10-19 19:26:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200223
;

