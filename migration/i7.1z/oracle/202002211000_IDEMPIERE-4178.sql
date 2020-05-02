SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4178 Replace NVL with Coalesce
-- PostgreSQL only
SELECT register_migration_script('202002211000_IDEMPIERE-4178.sql') FROM dual
;
