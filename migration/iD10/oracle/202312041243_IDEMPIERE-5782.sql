-- IDEMPIERE-5782 Generated Shipments/MR and Invoices with Invalid Sales Rep
SELECT register_migration_script('202312041243_IDEMPIERE-5782.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 4, 2023, 12:43:33 PM CET
UPDATE AD_Column SET Callout='org.adempiere.model.CalloutRMA.inout',Updated=TO_TIMESTAMP('2023-12-04 12:43:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10842
;

