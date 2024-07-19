-- IDEMPIERE-5616 Reverse Shipments don't post because of Not Balanced in special case
SELECT register_migration_script('202303151137_IDEMPIERE-5616.sql') FROM dual;

-- Mar 15, 2023, 11:37:25 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201179,'83106196-6ad0-43c9-b45d-a4d12a07abaa',TO_TIMESTAMP('2023-03-15 11:37:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','fact_acct_tabrec',TO_TIMESTAMP('2023-03-15 11:37:24','YYYY-MM-DD HH24:MI:SS'),100,270,'N','N','N','N','N')
;

-- Mar 15, 2023, 11:37:33 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201614,'8fb1113c-6342-4d43-babc-7f636caa58ac',TO_TIMESTAMP('2023-03-15 11:37:33','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-03-15 11:37:33','YYYY-MM-DD HH24:MI:SS'),100,5102,201179,10)
;

-- Mar 15, 2023, 11:37:44 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201615,'e8da75b4-a3e7-47f6-8645-7d0c303ec7fb',TO_TIMESTAMP('2023-03-15 11:37:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-03-15 11:37:43','YYYY-MM-DD HH24:MI:SS'),100,5103,201179,20)
;

-- Mar 15, 2023, 11:38:08 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201616,'d2aa2e5b-9ef2-45ed-94c7-382587ebd2ac',TO_TIMESTAMP('2023-03-15 11:38:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-03-15 11:38:07','YYYY-MM-DD HH24:MI:SS'),100,6701,201179,30)
;

-- Mar 15, 2023, 11:38:21 AM CET
CREATE INDEX fact_acct_tabrec ON Fact_Acct (AD_Table_ID,Record_ID,Line_ID)
;

