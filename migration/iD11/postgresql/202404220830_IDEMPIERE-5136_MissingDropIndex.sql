-- IDEMPIERE-5136
SELECT register_migration_script('202404220830_IDEMPIERE-5136_MissingDropIndex.sql') FROM dual;

-- only for Oracle as there was a missing DROP INDEX instruction
