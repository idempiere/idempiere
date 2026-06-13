-- IDEMPIERE-6224 Replace unique index on Import Format Row with beforeSave implementation
SELECT register_migration_script('202603101053_IDEMPIERE-6224.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Drop AD_IndexColumn entries for ad_impformat_row_ad_column (AD_TableIndex_ID=201260)
DELETE FROM AD_IndexColumn WHERE AD_TableIndex_ID=201260
;

-- Drop AD_TableIndex entry for ad_impformat_row_ad_column
DELETE FROM AD_TableIndex WHERE AD_TableIndex_ID=201260
;

-- Drop the physical unique index
DROP INDEX ad_impformat_row_ad_column
;
