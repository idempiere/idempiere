-- IDEMPIERE-6575
SELECT register_migration_script('202506201409_IDEMPIERE-6575.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 20, 2025, 2:09:12 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201289,'7a1ba3b0-fcef-466c-adf0-e7301337464a',TO_TIMESTAMP('2025-06-20 14:09:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_sequence_no_ad_org_sequencekey',TO_TIMESTAMP('2025-06-20 14:09:11','YYYY-MM-DD HH24:MI:SS'),100,122,'Y','Y','N','N')
;

-- Jun 20, 2025, 2:09:52 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201762,'bcc86c03-2b40-4bad-9fb3-c3edc44da760',TO_TIMESTAMP('2025-06-20 14:09:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-06-20 14:09:52','YYYY-MM-DD HH24:MI:SS'),100,749,201289,10)
;

-- Jun 20, 2025, 2:10:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201763,'bf557da7-d608-456d-a31a-ea6639c9f8af',TO_TIMESTAMP('2025-06-20 14:10:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-06-20 14:10:21','YYYY-MM-DD HH24:MI:SS'),100,262,201289,20)
;

-- Jun 23, 2025, 8:37:21 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201764,'4d8306ee-88ba-4d06-a037-4c517597eeb2',TO_TIMESTAMP('2025-06-23 08:37:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-06-23 08:37:20','YYYY-MM-DD HH24:MI:SS'),100,1197,201289,5)
;

-- Jun 23, 2025, 8:37:24 AM CEST
ALTER TABLE AD_Sequence_No ADD CONSTRAINT ad_sequence_no_ad_org_sequencekey UNIQUE (AD_Sequence_ID,AD_Org_ID,SequenceKey)
;

