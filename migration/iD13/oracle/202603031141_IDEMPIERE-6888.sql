-- IDEMPIERE-6888
SELECT register_migration_script('202603031141_IDEMPIERE-6888.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 3, 2026, 11:41:46 AM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201298,'019cb34a-229e-73b5-b506-8f93fcb1ce56',TO_TIMESTAMP('2026-03-03 11:41:45','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','pa_dashboardpreference_unique',TO_TIMESTAMP('2026-03-03 11:41:45','YYYY-MM-DD HH24:MI:SS'),10,200013,'N','Y','N','N')
;

-- Mar 3, 2026, 11:41:57 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201781,'019cb34a-4ddd-78a5-9fe8-25f5ae3b1000',TO_TIMESTAMP('2026-03-03 11:41:56','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-03 11:41:56','YYYY-MM-DD HH24:MI:SS'),10,200350,201298,10)
;

-- Mar 3, 2026, 11:42:01 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201782,'019cb34a-5d64-7be7-8a44-9371a7b2bc7f',TO_TIMESTAMP('2026-03-03 11:42:00','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-03 11:42:00','YYYY-MM-DD HH24:MI:SS'),10,200328,201298,20)
;

-- Mar 3, 2026, 11:42:03 AM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201783,'019cb34a-6607-7534-9f53-23c15dbf9988',TO_TIMESTAMP('2026-03-03 11:42:03','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-03-03 11:42:03','YYYY-MM-DD HH24:MI:SS'),10,200327,201298,30)
;

-- Mar 3, 2026, 11:42:06 AM CET
CREATE UNIQUE INDEX pa_dashboardpreference_unique ON PA_DashboardPreference (PA_DashboardContent_ID,AD_User_ID,AD_Role_ID)
;

