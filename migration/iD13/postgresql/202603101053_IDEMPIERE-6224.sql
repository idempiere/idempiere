-- IDEMPIERE-6224 Replace unique index on Import Format Row with beforeSave implementation
SELECT register_migration_script('202603101053_IDEMPIERE-6224.sql') FROM dual;

-- Drop AD_IndexColumn entries for ad_impformat_row_ad_column (AD_TableIndex_ID=201260)
DELETE FROM AD_IndexColumn WHERE AD_TableIndex_ID=201260
;

-- Drop AD_TableIndex entry for ad_impformat_row_ad_column
DELETE FROM AD_TableIndex WHERE AD_TableIndex_ID=201260
;

-- Drop the physical unique index
DROP INDEX ad_impformat_row_ad_column
;

-- Sep 25, 2026, 1:59:07 PM UTC
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Disallowed duplicate entry for: ','An entry exists in AD_ImpFormat_Row that is incompatible with one being attempted to save.',0,0,'Y',TO_TIMESTAMP('2026-09-25 13:59:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-25 13:59:01','YYYY-MM-DD HH24:MI:SS'),100,201069,'DuplicateImpFormatRow','D','fdbc5c57-f46d-45b8-b5f5-3b2d152f5bcf')
;
