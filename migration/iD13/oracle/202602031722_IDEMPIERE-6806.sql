-- IDEMPIERE-6806
SELECT register_migration_script('202602031722_IDEMPIERE-6806.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 3, 2026, 5:22:05 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','The General Ledger entries from this Payment Allocation ({0}) have been reconciled in the General Ledger.
Please use the Accounting Fact Reconciliation (Manual) form if you want to delete the reconciliation entry then try to reset the Payment Allocation',0,0,'Y',TO_TIMESTAMP('2026-02-03 17:22:05','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-02-03 17:22:05','YYYY-MM-DD HH24:MI:SS'),10,200990,'AllocationDeletionFailedReconciliation','D','019c244f-a697-7253-85fe-d3b494fa4795')
;

