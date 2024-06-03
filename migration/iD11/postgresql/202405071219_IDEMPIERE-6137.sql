-- IDEMPIERE-6137 Payment Rule does not appear in reports from Sales Order
SELECT register_migration_script('202405071219_IDEMPIERE-6137.sql') FROM dual;

-- May 7, 2024, 12:19:00 PM CEST
UPDATE AD_Column SET AD_Reference_Value_ID=195,Updated=TO_TIMESTAMP('2024-05-07 12:19:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Reference_ID=200012 AND COALESCE(AD_Reference_Value_ID,0)!=195
;

