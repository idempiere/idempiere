-- IDEMPIERE-6129
SELECT register_migration_script('202404261129_IDEMPIERE-6129.sql') FROM dual;

ALTER TABLE t_selection_infowindow ALTER COLUMN value_string TYPE VARCHAR(4000);
