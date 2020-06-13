-- IDEMPIERE-4335  AD_EntityType_ID is not defined as unique
-- Jun 13, 2020, 6:52:19 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201079,'af119c28-4093-4f93-ac5d-a0c5f698c8ae',TO_TIMESTAMP('2020-06-13 18:52:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_entitytype_id_unq',TO_TIMESTAMP('2020-06-13 18:52:19','YYYY-MM-DD HH24:MI:SS'),100,882,'Y','Y','N','N')
;

-- Jun 13, 2020, 6:52:31 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201396,'da339f55-24aa-4232-904a-0efe0ba4fa16',TO_TIMESTAMP('2020-06-13 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2020-06-13 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,15595,201079,0)
;

-- Jun 13, 2020, 6:52:36 PM CEST
ALTER TABLE AD_EntityType ADD CONSTRAINT ad_entitytype_id_unq UNIQUE (AD_EntityType_ID)
;

ALTER TABLE AD_Package_Exp_Detail ADD CONSTRAINT ADEntityType_ADPackageExpDetai FOREIGN KEY (AD_EntityType_ID) REFERENCES AD_EntityType(AD_EntityType_ID) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('202006131853_IDEMPIERE-4335.sql') FROM dual
;

