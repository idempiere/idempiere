-- IDEMPIERE-6293
SELECT register_migration_script('202411251514_IDEMPIERE-6293.sql') FROM dual;

-- Nov 25, 2024, 3:14:26 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201279,'2a6dafd2-4e1c-467e-8bc0-11ba5a489c64',TO_TIMESTAMP('2024-11-25 15:14:26','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','AD_UserDef_Theme_Unique',TO_TIMESTAMP('2024-11-25 15:14:26','YYYY-MM-DD HH24:MI:SS'),10,200421,'N','Y','N','N')
;

-- Nov 25, 2024, 3:14:39 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201739,'55002991-4046-4dd9-bc68-2c1c2327b74b',TO_TIMESTAMP('2024-11-25 15:14:38','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2024-11-25 15:14:38','YYYY-MM-DD HH24:MI:SS'),10,216908,201279,10)
;

-- Nov 25, 2024, 3:14:42 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201740,'42cb178a-6f82-446e-bf44-ae8f9fc2ef89',TO_TIMESTAMP('2024-11-25 15:14:41','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2024-11-25 15:14:41','YYYY-MM-DD HH24:MI:SS'),10,216894,201279,20)
;

-- Nov 25, 2024, 3:14:45 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201741,'db0447ef-42b5-4cdb-8d0c-d239485560eb',TO_TIMESTAMP('2024-11-25 15:14:45','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2024-11-25 15:14:45','YYYY-MM-DD HH24:MI:SS'),10,216895,201279,30)
;

-- Nov 25, 2024, 3:15:01 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201742,'eedc69c4-1954-417d-bbb5-1f5f42fc5dd9',TO_TIMESTAMP('2024-11-25 15:15:01','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2024-11-25 15:15:01','YYYY-MM-DD HH24:MI:SS'),10,216906,201279,'COALESCE(AD_User_ID, 0)',40)
;

-- Nov 25, 2024, 3:15:11 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201743,'1669effe-c58b-489a-8b98-d0f701de40f6',TO_TIMESTAMP('2024-11-25 15:15:11','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2024-11-25 15:15:11','YYYY-MM-DD HH24:MI:SS'),10,216905,201279,'COALESCE(AD_Role_ID, 0)',40)
;

-- Nov 25, 2024, 3:15:16 PM CET
UPDATE AD_IndexColumn SET SeqNo=50,Updated=TO_TIMESTAMP('2024-11-25 15:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_IndexColumn_ID=201743
;

-- Nov 25, 2024, 3:15:20 PM CET
CREATE UNIQUE INDEX AD_UserDef_Theme_Unique ON AD_UserDef_Theme (Theme,AD_Client_ID,AD_Org_ID,COALESCE(AD_User_ID, 0),COALESCE(AD_Role_ID, 0))
;
