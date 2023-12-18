-- IDEMPIERE-5954 Payment Info Window failing on Payments into Batch > Lines
SELECT register_migration_script('202312111654_IDEMPIERE-5954.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 11, 2023, 4:54:28 PM CET
UPDATE AD_Val_Rule SET Code='C_Payment.IsReconciled=''N'' AND C_Payment.TrxType <> ''X'' AND (SELECT COALESCE(pi.C_DepositBatch_ID,0) FROM C_Payment pi WHERE pi.C_Payment_ID=C_Payment.C_Payment_ID)=0 AND C_Payment.C_DocType_ID=@C_DocType_ID@',Updated=TO_TIMESTAMP('2023-12-11 16:54:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200039
;

