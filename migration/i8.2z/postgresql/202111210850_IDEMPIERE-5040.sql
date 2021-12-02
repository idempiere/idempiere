-- IDEMPIERE-5040 Stall M_InOutLine.QtyOverReceipt
-- Nov 19, 2021, 11:00:44 PM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201096,'c97e6bf9-5754-485c-a983-5cb01429032f',TO_TIMESTAMP('2021-11-19 23:00:43','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','m_inoutline_orderline_idx',TO_TIMESTAMP('2021-11-19 23:00:43','YYYY-MM-DD HH24:MI:SS'),100,320,'N','N','N','N','N')
;

-- Nov 19, 2021, 11:00:58 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201443,'4c920b11-27f2-40a5-b30f-cc8b525d942b',TO_TIMESTAMP('2021-11-19 23:00:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2021-11-19 23:00:57','YYYY-MM-DD HH24:MI:SS'),100,3811,201096,10)
;

-- Nov 19, 2021, 11:01:04 PM MYT
CREATE INDEX m_inoutline_orderline_idx ON M_InOutLine (C_OrderLine_ID)
;

-- Nov 26, 2021, 6:14:22 AM MYT
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2021-11-26 06:14:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210888
;

SELECT register_migration_script('202111210850_IDEMPIERE-5040.sql') FROM dual
;

