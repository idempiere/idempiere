-- Nov 9, 2012 1:28:45 PM COT
-- Last migration script not being set
UPDATE AD_System SET LastMigrationScriptApplied=NULL WHERE AD_System_ID=0
;

SELECT register_migration_script('201211091328_LastMigrationNotSet.sql') FROM dual
;

