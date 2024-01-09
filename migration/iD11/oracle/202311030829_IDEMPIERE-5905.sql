-- IDEMPIERE-5905
SELECT register_migration_script('202311030829_IDEMPIERE-5905.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 3, 2023, 8:29:15 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201260,'430561de-d437-4645-8c42-0aba53bce742',TO_TIMESTAMP('2023-11-03 08:29:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_impformat_row_ad_column',TO_TIMESTAMP('2023-11-03 08:29:15','YYYY-MM-DD HH24:MI:SS'),100,382,'N','Y','N','N')
;

-- Nov 3, 2023, 8:29:39 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201704,'75ab1123-6093-418e-88b0-d0067b8775c4',TO_TIMESTAMP('2023-11-03 08:29:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-11-03 08:29:39','YYYY-MM-DD HH24:MI:SS'),100,4690,201260,10)
;

-- Nov 3, 2023, 8:29:46 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201705,'583eb5cf-6041-4c61-a74c-efe48c23a73d',TO_TIMESTAMP('2023-11-03 08:29:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-11-03 08:29:46','YYYY-MM-DD HH24:MI:SS'),100,4702,201260,20)
;

-- Nov 3, 2023, 8:29:50 AM CET
CREATE UNIQUE INDEX ad_impformat_row_ad_column ON AD_ImpFormat_Row (AD_ImpFormat_ID,AD_Column_ID)
;

