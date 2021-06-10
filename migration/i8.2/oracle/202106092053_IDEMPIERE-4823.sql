SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4823 - RV_C_Invoice does not have a key column
-- Jun 9, 2021, 8:51:34 PM CEST
UPDATE AD_Column SET IsKey='Y', IsUpdateable='N', IsAllowCopy='N',Updated=TO_DATE('2021-06-09 20:51:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=5522
;

SELECT register_migration_script('202106092053_IDEMPIERE-4823.sql') FROM dual
;
