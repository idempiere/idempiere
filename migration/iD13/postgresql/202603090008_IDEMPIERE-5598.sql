-- IDEMPIERE-5598 IDEMPIERE-4224 Missing UUID indexes
SELECT register_migration_script('202603090008_IDEMPIERE-5598.sql') FROM dual;

-- Mar 9, 2026, 12:08:17 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201301,'019ccfb5-6345-7c78-bae5-4edc1e04a789',TO_TIMESTAMP('2026-03-09 00:08:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_tableattribute_uu_idx',TO_TIMESTAMP('2026-03-09 00:08:16','YYYY-MM-DD HH24:MI:SS'),100,200390,'Y','Y','N','N','N')
;

-- Mar 9, 2026, 12:08:32 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201791,'019ccfb5-a077-7d0f-9415-7373ffc18bb6',TO_TIMESTAMP('2026-03-09 00:08:32','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-09 00:08:32','YYYY-MM-DD HH24:MI:SS'),100,215932,201301,10)
;

-- Mar 9, 2026, 12:09:21 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201302,'019ccfb6-5f5a-7d07-bde7-3559d51560ef',TO_TIMESTAMP('2026-03-09 00:09:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','c_costcenter_uu_idx',TO_TIMESTAMP('2026-03-09 00:09:21','YYYY-MM-DD HH24:MI:SS'),100,200414,'Y','Y','N','N','N')
;

-- Mar 9, 2026, 12:09:27 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201792,'019ccfb6-75f3-797b-9423-fcf11afa4f7c',TO_TIMESTAMP('2026-03-09 00:09:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-09 00:09:27','YYYY-MM-DD HH24:MI:SS'),100,216361,201302,10)
;

-- Mar 9, 2026, 12:09:49 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201303,'019ccfb6-cad5-799e-8c30-536e764ca32a',TO_TIMESTAMP('2026-03-09 00:09:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','c_department_uu_idx',TO_TIMESTAMP('2026-03-09 00:09:48','YYYY-MM-DD HH24:MI:SS'),100,200413,'Y','Y','N','N','N')
;

-- Mar 9, 2026, 12:10:00 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201793,'019ccfb6-f748-7fbb-a295-5f1f7b30e205',TO_TIMESTAMP('2026-03-09 00:10:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-03-09 00:10:00','YYYY-MM-DD HH24:MI:SS'),100,216353,201303,10)
;

