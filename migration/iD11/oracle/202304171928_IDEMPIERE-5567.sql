-- IDEMPIERE-5567 Support of UUID on Search (FHCA-4195)
SELECT register_migration_script('202304171928_IDEMPIERE-5567.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

ALTER TABLE t_selection MODIFY t_selection_uu DEFAULT ' ';

ALTER TABLE t_selection_infowindow MODIFY t_selection_uu DEFAULT ' ';

