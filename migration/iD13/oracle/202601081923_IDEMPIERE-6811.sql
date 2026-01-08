-- IDEMPIERE-6811
SELECT register_migration_script('202601081923_IDEMPIERE-6811.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 8, 2026, 7:23:37 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Some lines are reconciled, unreconcile them to reactivate this document. Account(s): {0}.',0,0,'Y',TO_TIMESTAMP('2026-01-08 19:23:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-01-08 19:23:36','YYYY-MM-DD HH24:MI:SS'),10,200989,'JournalReactivationFailedReconciliation','D','019b9ed9-90e4-7753-be0c-f6c674a3ade2')
;

