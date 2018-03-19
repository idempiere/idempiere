-- IDEMPIERE-384 Problem with insertTranslations in multilanguage env caused by Generate_UUID
CREATE OR REPLACE FUNCTION generate_uuid()
RETURNS char(36) AS $$
BEGIN
	return uuid_generate_v4()::char(36);
END;
$$ LANGUAGE plpgsql;

UPDATE AD_System
  SET LastMigrationScriptApplied='874_IDEMPIERE-384.sql'
WHERE LastMigrationScriptApplied<'874_IDEMPIERE-384.sql'
   OR LastMigrationScriptApplied IS NULL
;
