-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
SELECT register_migration_script('202510101902_IDEMPIERE-6650-uuid.sql') FROM dual;

-- set as UUID all _UU columns that were defined previously as String (for example by 2Packs)
UPDATE ad_column
SET ad_reference_id = 200231
WHERE ad_column_id IN (
  SELECT c.ad_column_id
    FROM ad_column c
      JOIN ad_table t USING (ad_table_id)
    WHERE AD_Reference_ID != 200231 AND 
      ColumnName = substr(t.tablename, 0, 27) || '_UU'
);

-- placeholder - the rest of the script is needed just for postgresql

