SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE 2131 - List Validation allow same Name
-- Apr 27, 2015 12:23:21 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201034,'6ce794ab-6190-4691-a97c-a76abf645e23',TO_DATE('2015-04-27 12:23:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_ref_list_name',TO_DATE('2015-04-27 12:23:20','YYYY-MM-DD HH24:MI:SS'),100,104,'N','Y','N','N','N')
;

-- Apr 27, 2015 12:23:36 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201260,'815e5b09-1d18-40a4-8318-0f61812aa56b',TO_DATE('2015-04-27 12:23:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2015-04-27 12:23:36','YYYY-MM-DD HH24:MI:SS'),100,151,201034,10)
;

-- Apr 27, 2015 12:23:42 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201261,'d4fb4782-2768-4897-b0b4-e8daee756311',TO_DATE('2015-04-27 12:23:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_DATE('2015-04-27 12:23:41','YYYY-MM-DD HH24:MI:SS'),100,149,201034,20)
;

-- Apr 27, 2015 2:24:31 PM COT
CREATE UNIQUE INDEX ad_ref_list_name ON AD_Ref_List (AD_Reference_ID,Name)
;

SELECT register_migration_script('2015042711234_IDEMPIERE-2131.sql') FROM dual
;
