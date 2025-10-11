-- IDEMPIERE-6650 Performance - Implement support for using the uuid postgres datatype (FHCA-7074)
SELECT register_migration_script('202510101904_IDEMPIERE-6650-uuid-post.sql') FROM dual;

-- placeholder - this is needed just for postgresql
