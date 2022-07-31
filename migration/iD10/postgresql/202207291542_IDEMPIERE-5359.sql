-- IDEMPIERE-5359 Unit test not working with Oracle
SELECT register_migration_script('202207291542_IDEMPIERE-5359.sql') FROM dual;

-- Jul 29, 2022, 3:42:38 PM MYT
UPDATE AD_Column SET ColumnSQL='(SELECT 123.45 FROM DUAL)',Updated=TO_TIMESTAMP('2022-07-29 15:42:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214655
;

