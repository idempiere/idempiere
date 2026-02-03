-- IDEMPIERE-6811
SELECT register_migration_script('202601081923_IDEMPIERE-6811.sql') FROM dual;

-- Jan 8, 2026, 7:23:37 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Some lines are reconciled, unreconcile them to reactivate this document. Account(s): {0}.',0,0,'Y',TO_TIMESTAMP('2026-01-08 19:23:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-01-08 19:23:36','YYYY-MM-DD HH24:MI:SS'),10,200989,'JournalReactivationFailedReconciliation','D','019b9ed9-90e4-7753-be0c-f6c674a3ade2')
;

-- Feb 3, 2026, 5:01:53 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201297,'019c243d-2737-7a8e-875c-a9b20c57878d',TO_TIMESTAMP('2026-02-03 17:01:53','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','fact_factacctid',TO_TIMESTAMP('2026-02-03 17:01:53','YYYY-MM-DD HH24:MI:SS'),10,53286,'N','N','N','N')
;

-- Feb 3, 2026, 5:01:56 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_TableIndex_ID,SeqNo) VALUES (0,0,201780,'019c243d-34c5-7ebe-8326-36e26507ca13',TO_TIMESTAMP('2026-02-03 17:01:56','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-02-03 17:01:56','YYYY-MM-DD HH24:MI:SS'),10,201297,10)
;

-- Feb 3, 2026, 5:01:57 PM CET
UPDATE AD_IndexColumn SET AD_Column_ID=59777,Updated=TO_TIMESTAMP('2026-02-03 17:01:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_IndexColumn_ID=201780
;

-- Feb 3, 2026, 5:01:59 PM CET
CREATE INDEX fact_factacctid ON Fact_Reconciliation (Fact_Acct_ID)
;

