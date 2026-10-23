-- IDEMPIERE-7156
SELECT register_migration_script('202610231508_IDEMPIERE-7156.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 23, 2026, 3:08:32 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,Description,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201326,'01a168e0-9ba0-7a59-a45d-bcf8fd6daa1c',TO_TIMESTAMP('2026-10-23 15:08:32','YYYY-MM-DD HH24:MI:SS'),100,'Unique name per tenant and date range group','D','Y','AD_DateRange_Name_Unique',TO_TIMESTAMP('2026-10-23 15:08:32','YYYY-MM-DD HH24:MI:SS'),100,800173,'N','Y','N','N','N')
;

-- Oct 23, 2026, 3:09:06 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201833,'01a168e1-2109-7bef-9b22-27707ba2d5d5',TO_TIMESTAMP('2026-10-23 15:09:06','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-10-23 15:09:06','YYYY-MM-DD HH24:MI:SS'),100,802964,201326,10)
;

-- Oct 23, 2026, 3:09:13 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201834,'01a168e1-3b36-7f81-9a95-0f6428ebcad6',TO_TIMESTAMP('2026-10-23 15:09:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-10-23 15:09:13','YYYY-MM-DD HH24:MI:SS'),100,802973,201326,20)
;

-- Oct 23, 2026, 3:09:34 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201835,'01a168e1-8c2b-764a-abf4-4d07dbfd219e',TO_TIMESTAMP('2026-10-23 15:09:34','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-10-23 15:09:34','YYYY-MM-DD HH24:MI:SS'),100,802991,201326,'COALESCE(AD_DateRangeGroup_ID, 0)',30)
;

-- Oct 23, 2026, 3:10:41 PM CEST
CREATE UNIQUE INDEX AD_DateRange_Name_Unique ON AD_DateRange (AD_Client_ID,Name,COALESCE(AD_DateRangeGroup_ID, 0))
;

-- Oct 23, 2026, 3:56:33 PM CEST
UPDATE AD_Field SET DisplayLogic='@RangeType@=R | @RangeType@=O', SeqNo=100,Updated=TO_TIMESTAMP('2026-10-23 15:56:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802496
;

-- Oct 23, 2026, 3:56:33 PM CEST
UPDATE AD_Field SET DisplayLogic='@RangeType@=R | @RangeType@=O', SeqNo=120,Updated=TO_TIMESTAMP('2026-10-23 15:56:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=802501
;

