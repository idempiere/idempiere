-- IDEMPIERE-5967 Release 11 Synergy
SELECT register_migration_script('202312221238_IDEMPIERE-5346.sql') FROM dual;

-- Dec 22, 2023, 12:38:27 PM CET
UPDATE AD_Field SET IsDisplayedGrid='N',Updated=TO_TIMESTAMP('2023-12-22 12:38:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207195
;

-- Dec 22, 2023, 12:41:31 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201268,'506ca7db-3b3d-4169-b633-d9acf12944cc',TO_TIMESTAMP('2023-12-22 12:41:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','sso_principalconfig_uu_idx',TO_TIMESTAMP('2023-12-22 12:41:30','YYYY-MM-DD HH24:MI:SS'),100,200360,'Y','Y','N','N','N')
;

-- Dec 22, 2023, 12:41:57 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201720,'6d1f7676-69c4-4893-b9e7-6f1c7820e0eb',TO_TIMESTAMP('2023-12-22 12:41:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-12-22 12:41:56','YYYY-MM-DD HH24:MI:SS'),100,215294,201268,10)
;

-- Dec 22, 2023, 12:43:58 PM CET
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2023-12-22 12:43:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215290
;

-- Dec 22, 2023, 12:44:15 PM CET
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_TIMESTAMP('2023-12-22 12:44:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215292
;

-- Dec 22, 2023, 12:48:32 PM CET
ALTER TABLE SSO_PrincipalConfig DROP CONSTRAINT sso_principalconfig_uu_idx CASCADE
;

-- Dec 22, 2023, 12:48:39 PM CET
ALTER TABLE SSO_PrincipalConfig ADD CONSTRAINT sso_principalconfig_uu_idx UNIQUE (SSO_PrincipalConfig_UU)
;

