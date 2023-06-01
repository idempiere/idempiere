-- IDEMPIERE-5418
SELECT register_migration_script('202209131253_IDEMPIERE-5418.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 13, 2022, 12:53:45 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201128,'549d8043-081c-45f6-8091-aa84bc58a354',TO_TIMESTAMP('2022-09-13 12:53:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_ChartDatasource_Trl_pkey',TO_TIMESTAMP('2022-09-13 12:53:45','YYYY-MM-DD HH24:MI:SS'),100,200361,'Y','Y','N','N','N')
;

-- Sep 13, 2022, 12:53:50 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201510,'172ba24a-c5aa-49a7-a599-4d8cf020c28b',TO_TIMESTAMP('2022-09-13 12:53:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-13 12:53:50','YYYY-MM-DD HH24:MI:SS'),100,215306,201128,10)
;

-- Sep 13, 2022, 12:53:56 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201511,'f5afa74b-972f-4621-be96-84bce0bbc3ad',TO_TIMESTAMP('2022-09-13 12:53:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-13 12:53:56','YYYY-MM-DD HH24:MI:SS'),100,215308,201128,20)
;

-- Sep 13, 2022, 12:54:12 PM CEST
UPDATE AD_TableIndex SET IsKey='Y',Updated=TO_TIMESTAMP('2022-09-13 12:54:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201128
;

-- Sep 13, 2022, 1:00:00 PM CEST
ALTER TABLE AD_ChartDatasource_Trl ADD CONSTRAINT AD_ChartDatasource_Trl_pkey PRIMARY KEY (AD_ChartDatasource_ID,AD_Language)
;

