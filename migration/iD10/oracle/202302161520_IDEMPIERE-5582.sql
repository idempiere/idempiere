-- IDEMPIERE-5582
SELECT register_migration_script('202302161520_IDEMPIERE-5582.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- That UPDATE removes all Default Values from Vitual Columns.
UPDATE AD_Column SET DefaultValue = NULL
WHERE ColumnSQL IS NOT NULL AND DefaultValue IS NOT NULL