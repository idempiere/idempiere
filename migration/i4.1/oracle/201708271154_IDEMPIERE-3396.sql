SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3396
-- Aug 27, 2017 11:52:21 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201059,'6a6f51d9-b636-48f8-ae98-33204895c8f4',TO_DATE('2017-08-27 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_pinstance_last_ix',TO_DATE('2017-08-27 11:52:20','YYYY-MM-DD HH24:MI:SS'),100,282,'N','N','N','N','N')
;

-- Aug 27, 2017 11:52:37 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201347,'c9cc1891-e41b-4d3e-8c36-f746e5b0fe39',TO_DATE('2017-08-27 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-08-27 11:52:37','YYYY-MM-DD HH24:MI:SS'),100,5951,201059,1)
;

-- Aug 27, 2017 11:52:45 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201348,'7b63fe78-7d25-49a8-a64c-1ab5b9fa90d1',TO_DATE('2017-08-27 11:52:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-08-27 11:52:45','YYYY-MM-DD HH24:MI:SS'),100,2781,201059,2)
;

-- Aug 27, 2017 11:53:49 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201349,'50e5ad46-685a-470b-a42c-239f2a104246',TO_DATE('2017-08-27 11:53:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-08-27 11:53:49','YYYY-MM-DD HH24:MI:SS'),100,8221,201059,3)
;

-- Aug 27, 2017 11:53:56 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201350,'f65ee789-904b-433f-b4c9-bbc1fde9ca8a',TO_DATE('2017-08-27 11:53:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-08-27 11:53:55','YYYY-MM-DD HH24:MI:SS'),100,8225,201059,4)
;

-- Aug 27, 2017 11:54:02 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201351,'1875c8e6-f900-4486-8c22-b6bda65e751a',TO_DATE('2017-08-27 11:54:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2017-08-27 11:54:02','YYYY-MM-DD HH24:MI:SS'),100,210890,201059,5)
;

-- Aug 27, 2017 11:54:08 AM CEST
CREATE INDEX ad_pinstance_last_ix ON AD_PInstance (AD_User_ID,AD_Process_ID,AD_Client_ID,IsActive,Name)
;

SELECT register_migration_script('201708271154_IDEMPIERE-3396.sql') FROM dual
;

