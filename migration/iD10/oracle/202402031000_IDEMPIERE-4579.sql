-- IDEMPIERE-4579 Function altercolumn fails when a role name has a dash
SELECT register_migration_script('202402031000_IDEMPIERE-4579.sql') FROM dual;

--PostgreSQL only
