-- IDEMPIERE-384 Problem with insertTranslations in multilanguage env caused by Generate_UUID
-- just for postgresql



UPDATE AD_System
  SET LastMigrationScriptApplied='874_IDEMPIERE-384.sql'
WHERE LastMigrationScriptApplied<'874_IDEMPIERE-384.sql'
   OR LastMigrationScriptApplied IS NULL
;
