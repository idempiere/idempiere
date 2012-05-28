-- You must activate the uuid-ossp extension before running this script.
-- For PostgreSQL 9.0 and earlier, run contrib/uuid-ossp.sql to activate the extension.
-- For Postgresql 9.1, run the CREATE EXTENSION "uuid-ossp" sql command t activate the extension.

-- May 28, 2012 02:05:39 PM MYT
-- IDEMPIERE-274 Database seed missing Generate_UUID function
CREATE OR REPLACE FUNCTION generate_uuid()
RETURNS char(36) AS $$
BEGIN
	return uuid_generate_v4()::char(36);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

UPDATE AD_System
  SET LastMigrationScriptApplied='840_IDEMPIERE-274.sql'
WHERE LastMigrationScriptApplied<'840_IDEMPIERE-274.sql'
   OR LastMigrationScriptApplied IS NULL
;
