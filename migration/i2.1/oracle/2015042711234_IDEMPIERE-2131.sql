SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE 2131 - List Validation allow same Name
-- Apr 27, 2015 12:23:21 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201034,'6ce794ab-6190-4691-a97c-a76abf645e23',TO_DATE('2015-04-27 12:23:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_ref_list_name',TO_DATE('2015-04-27 12:23:20','YYYY-MM-DD HH24:MI:SS'),100,104,'N','Y','N','N','N')
;

-- Apr 27, 2015 12:23:36 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201260,'815e5b09-1d18-40a4-8318-0f61812aa56b',TO_DATE('2015-04-27 12:23:36','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_DATE('2015-04-27 12:23:36','YYYY-MM-DD HH24:MI:SS'),100,151,201034,10)
;

-- Apr 27, 2015 12:23:42 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201261,'d4fb4782-2768-4897-b0b4-e8daee756311',TO_DATE('2015-04-27 12:23:41','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_DATE('2015-04-27 12:23:41','YYYY-MM-DD HH24:MI:SS'),100,149,201034,20)
;

-- Apr 27, 2015 12:24:37 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201035,'2b1a6eed-7a54-44ef-85a7-c5f40836db2d',TO_DATE('2015-04-27 12:24:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_ref_list_trl_name',TO_DATE('2015-04-27 12:24:37','YYYY-MM-DD HH24:MI:SS'),100,136,'N','Y','N','N','N')
;

-- Apr 27, 2015 12:24:48 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201262,'72671b8e-722e-4f2a-9788-ea3cfd90adaa',TO_DATE('2015-04-27 12:24:48','YYYY-MM-DD HH24:MI:SS'),100,'U','Y',TO_DATE('2015-04-27 12:24:48','YYYY-MM-DD HH24:MI:SS'),100,336,201035,10)
;

-- Apr 27, 2015 12:24:57 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201263,'c8f21da7-96f7-4daf-8c2b-a935c67deadb',TO_DATE('2015-04-27 12:24:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2015-04-27 12:24:56','YYYY-MM-DD HH24:MI:SS'),100,337,201035,20)
;

-- Apr 27, 2015 12:25:04 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201264,'c33d3433-8fd7-44a2-b5a8-ccac81357cb4',TO_DATE('2015-04-27 12:25:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2015-04-27 12:25:03','YYYY-MM-DD HH24:MI:SS'),100,338,201035,30)
;

-- Apr 27, 2015 12:25:07 PM CEST
UPDATE AD_IndexColumn SET EntityType='D',Updated=TO_DATE('2015-04-27 12:25:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201262
;

-- Apr 27, 2015 12:29:37 PM CEST
UPDATE AD_IndexColumn SET EntityType='D',Updated=TO_DATE('2015-04-27 12:29:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201260
;

-- Apr 27, 2015 12:29:40 PM CEST
UPDATE AD_IndexColumn SET EntityType='D',Updated=TO_DATE('2015-04-27 12:29:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_IndexColumn_ID=201261
;

SELECT register_migration_script('2015042711234_IDEMPIERE-2131.sql') FROM dual
;