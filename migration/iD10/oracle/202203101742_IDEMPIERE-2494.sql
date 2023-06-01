-- IDEMPIERE-2494  Attribute Value allowing duplicated values
SELECT register_migration_script('202203101742_IDEMPIERE-2494.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 10, 2022, 5:45:09 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201102,'7fbbb629-7d69-4dff-94e0-69581f3fba2b',TO_TIMESTAMP('2022-03-10 17:45:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','m_attributevalue_value_attribute_idx',TO_TIMESTAMP('2022-03-10 17:45:08','YYYY-MM-DD HH24:MI:SS'),100,558,'N','Y','N','N','N')
;

-- Mar 10, 2022, 5:45:27 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201453,'1759824b-4acc-4c08-a100-359e43aaa401',TO_TIMESTAMP('2022-03-10 17:45:27','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-10 17:45:27','YYYY-MM-DD HH24:MI:SS'),100,8464,201102,10)
;

-- Mar 10, 2022, 5:45:49 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201454,'0ee8184c-e7a6-4923-8141-713b206ac265',TO_TIMESTAMP('2022-03-10 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-10 17:45:48','YYYY-MM-DD HH24:MI:SS'),100,8466,201102,20)
;

-- Mar 10, 2022, 5:46:00 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201455,'37c8351f-4d05-4a2d-9e3e-064523e7651b',TO_TIMESTAMP('2022-03-10 17:46:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-03-10 17:46:00','YYYY-MM-DD HH24:MI:SS'),100,8459,201102,30)
;

-- Mar 10, 2022, 5:48:18 PM CET
CREATE UNIQUE INDEX m_attributevalue_value_attribute_idx ON M_AttributeValue (AD_Client_ID,M_Attribute_ID,Value)
;

