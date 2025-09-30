-- IDEMPIERE-6203 Back-dating costing
SELECT register_migration_script('202412031749_IDEMPIERE-6203.sql') FROM dual;

-- Dec 3, 2024, 5:49:20 PM MYT
DELETE FROM AD_IndexColumn WHERE AD_IndexColumn_UU='cd3d12f9-7f7c-4537-a21c-b115b1e58e6b'
;

-- Dec 3, 2024, 5:49:32 PM MYT
UPDATE AD_IndexColumn SET SeqNo=10,Updated=TO_TIMESTAMP('2024-12-03 17:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201733
;

-- Dec 3, 2024, 5:49:38 PM MYT
UPDATE AD_IndexColumn SET SeqNo=20,Updated=TO_TIMESTAMP('2024-12-03 17:49:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201734
;

-- Dec 3, 2024, 5:49:44 PM MYT
UPDATE AD_IndexColumn SET SeqNo=30,Updated=TO_TIMESTAMP('2024-12-03 17:49:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201735
;

-- Dec 3, 2024, 5:49:53 PM MYT
UPDATE AD_IndexColumn SET SeqNo=40,Updated=TO_TIMESTAMP('2024-12-03 17:49:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201736
;

-- Dec 3, 2024, 5:50:04 PM MYT
DROP INDEX t_fact_acct_history_update
;

-- Dec 3, 2024, 5:50:04 PM MYT
CREATE INDEX t_fact_acct_history_update ON T_Fact_Acct_History (Updated,AD_Table_ID,Record_ID,C_AcctSchema_ID)
;

