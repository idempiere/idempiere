-- IDEMPIERE-6203 Back-dating costing
SELECT register_migration_script('202409271057_IDEMPIERE-6203.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 27, 2024, 10:57:49 AM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Account Date cannot be changed',0,0,'Y',TO_TIMESTAMP('2024-09-27 10:57:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-09-27 10:57:47','YYYY-MM-DD HH24:MI:SS'),100,200905,'CannotChangeAccountDate','D','c8f46114-a307-4a5a-9874-851580472dd0')
;

-- Sep 27, 2024, 11:01:08 AM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201276,'944e6879-4d08-4b9d-ba96-a8add3ff2e47',TO_TIMESTAMP('2024-09-27 11:01:07','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','t_fact_acct_history_update',TO_TIMESTAMP('2024-09-27 11:01:07','YYYY-MM-DD HH24:MI:SS'),100,200420,'N','N','N','N','N')
;

-- Sep 27, 2024, 11:02:22 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201732,'cd3d12f9-7f7c-4537-a21c-b115b1e58e6b',TO_TIMESTAMP('2024-09-27 11:02:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-09-27 11:02:21','YYYY-MM-DD HH24:MI:SS'),100,216841,201276,10)
;

-- Sep 27, 2024, 11:02:38 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201733,'07b24791-9f1f-4db4-a851-a3482b724a24',TO_TIMESTAMP('2024-09-27 11:02:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-09-27 11:02:37','YYYY-MM-DD HH24:MI:SS'),100,216843,201276,20)
;

-- Sep 27, 2024, 11:02:56 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201734,'c62a6318-541f-4d16-a979-b68b1d7e2d3e',TO_TIMESTAMP('2024-09-27 11:02:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-09-27 11:02:55','YYYY-MM-DD HH24:MI:SS'),100,216850,201276,30)
;

-- Sep 27, 2024, 11:03:04 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201735,'29e9a2ca-de5a-41da-841a-bb8fc697c377',TO_TIMESTAMP('2024-09-27 11:03:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-09-27 11:03:03','YYYY-MM-DD HH24:MI:SS'),100,216851,201276,40)
;

-- Sep 27, 2024, 11:03:14 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201736,'8099f11b-419d-4d4e-bd17-49c4604f6909',TO_TIMESTAMP('2024-09-27 11:03:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-09-27 11:03:13','YYYY-MM-DD HH24:MI:SS'),100,216845,201276,50)
;

-- Sep 27, 2024, 11:03:23 AM MYT
CREATE INDEX t_fact_acct_history_update ON T_Fact_Acct_History (Created,Updated,AD_Table_ID,Record_ID,C_AcctSchema_ID)
;

