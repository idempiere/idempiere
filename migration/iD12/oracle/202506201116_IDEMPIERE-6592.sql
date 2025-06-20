-- IDEMPIERE-6592 T_Spool wrongly defined as view in dictionary
SELECT register_migration_script('202506201116_IDEMPIERE-6592.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 20, 2025, 11:16:47 AM CEST
UPDATE AD_Table SET IsView='N',Updated=TO_TIMESTAMP('2025-06-20 11:16:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=365
;

