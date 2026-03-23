-- IDEMPIERE-6698 - Enhance Print Invoices Process to Support Multi-Select Document Type Parameter
SELECT register_migration_script('202510141430_IDEMPIERE-6698.sql') FROM dual;

-- Oct 14, 2025, 2:30:40 PM CEST
UPDATE AD_Process_Para SET AD_Reference_ID=200162, AD_Reference_Value_ID=170, IsShowNegateButton='Y',Updated=TO_TIMESTAMP('2025-10-14 14:30:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200219
;

