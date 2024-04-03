-- IDEMPIERE-6086 Missing UUID indexes
SELECT register_migration_script('202404031429_IDEMPIERE-6086.sql') FROM dual;

-- Apr 3, 2024, 2:29:09 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201272,'1a2b9516-779f-4c9f-b85d-a19322dcef44',TO_TIMESTAMP('2024-04-03 14:29:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TablePartition_UU_idx',TO_TIMESTAMP('2024-04-03 14:29:08','YYYY-MM-DD HH24:MI:SS'),100,200411,'N','Y','N','N','N')
;

-- Apr 3, 2024, 2:29:15 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201728,'c19faac9-1253-41e8-b0bd-54f5324d6e5c',TO_TIMESTAMP('2024-04-03 14:29:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-04-03 14:29:14','YYYY-MM-DD HH24:MI:SS'),100,216291,201272,10)
;

-- Apr 3, 2024, 2:33:17 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201275,'ecfdea4f-546a-4cc2-8824-6de8ddd42853',TO_TIMESTAMP('2024-04-03 14:33:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','TestUU_Trl_UU_idx',TO_TIMESTAMP('2024-04-03 14:33:16','YYYY-MM-DD HH24:MI:SS'),100,200401,'N','Y','N','N','N')
;

-- Apr 3, 2024, 2:33:45 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201731,'bfca313e-4c52-4c16-aada-279d92b91b9b',TO_TIMESTAMP('2024-04-03 14:33:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-04-03 14:33:44','YYYY-MM-DD HH24:MI:SS'),100,216123,201275,10)
;

-- Apr 3, 2024, 2:39:52 PM CEST
UPDATE AD_TableIndex SET Name='ad_modelgeneratortemplateuuidx',Updated=TO_TIMESTAMP('2024-04-03 14:39:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201256
;

-- Apr 3, 2024, 2:40:24 PM CEST
UPDATE AD_TableIndex SET Name='ad_process_drillrule_parauuidx',Updated=TO_TIMESTAMP('2024-04-03 14:40:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201126
;

-- Apr 3, 2024, 2:43:47 PM CEST
CREATE INDEX pp_product_bom_product_id_idx ON PP_Product_BOM (M_Product_ID)
;

-- Apr 3, 2024, 2:57:16 PM CEST
UPDATE AD_TableIndex SET Name='pp_product_bom_key', IsCreateConstraint='Y', IsUnique='Y', IsKey='Y',Updated=TO_TIMESTAMP('2024-04-03 14:57:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_TableIndex_ID=201098
;

