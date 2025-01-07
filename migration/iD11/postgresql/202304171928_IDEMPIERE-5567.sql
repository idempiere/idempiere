-- IDEMPIERE-5567 Support of UUID on Search (FHCA-4195)
SELECT register_migration_script('202304171928_IDEMPIERE-5567.sql') FROM dual;

ALTER TABLE t_selection ALTER COLUMN t_selection_uu SET DEFAULT ' ';

ALTER TABLE t_selection_infowindow ALTER COLUMN t_selection_uu SET DEFAULT ' ';

