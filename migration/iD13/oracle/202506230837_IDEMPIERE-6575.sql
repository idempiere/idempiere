-- IDEMPIERE-6575
SELECT register_migration_script('202506230837_IDEMPIERE-6575.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 23, 2025, 8:37:21 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201764,'4d8306ee-88ba-4d06-a037-4c517597eeb2',TO_TIMESTAMP('2025-06-23 08:37:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-06-23 08:37:20','YYYY-MM-DD HH24:MI:SS'),100,1197,201289,5)
;

-- Jun 23, 2025, 8:37:24 AM CEST
ALTER TABLE AD_Sequence_No DROP CONSTRAINT ad_sequence_no_ad_org_sequencekey CASCADE
;

-- Jun 23, 2025, 8:37:24 AM CEST
ALTER TABLE AD_Sequence_No ADD CONSTRAINT ad_sequence_no_ad_org_sequencekey UNIQUE (AD_Sequence_ID,AD_Org_ID,SequenceKey)
;

