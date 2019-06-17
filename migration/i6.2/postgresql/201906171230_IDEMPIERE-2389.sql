-- IDEMPIERE-2389
-- Jun 17, 2019, 12:28:14 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201072,'abd39a4e-0ebf-4708-bfe1-415abfc22bcd',TO_TIMESTAMP('2019-06-17 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_language_id_idx',TO_TIMESTAMP('2019-06-17 12:28:14','YYYY-MM-DD HH24:MI:SS'),100,111,'Y','Y','N','N','N')
;

-- Jun 17, 2019, 12:28:29 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201387,'0be76e53-2809-420c-bb7a-8c4b48edcc74',TO_TIMESTAMP('2019-06-17 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2019-06-17 12:28:29','YYYY-MM-DD HH24:MI:SS'),100,9622,201072,10)
;

-- Jun 17, 2019, 12:28:32 PM CEST
ALTER TABLE AD_Language ADD CONSTRAINT ad_language_id_idx UNIQUE (AD_Language_ID)
;

-- Jun 17, 2019, 12:29:47 PM CEST
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADPInstance', FKConstraintType='N',Updated=TO_TIMESTAMP('2019-06-17 12:29:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211868
;

-- Jun 17, 2019, 12:30:06 PM CEST
ALTER TABLE AD_PInstance ADD CONSTRAINT ADLanguage_ADPInstance FOREIGN KEY (AD_Language_ID) REFERENCES AD_Language (AD_Language_ID) DEFERRABLE INITIALLY DEFERRED
;

SELECT register_migration_script('201906171230_IDEMPIERE-2389.sql') FROM dual
;

