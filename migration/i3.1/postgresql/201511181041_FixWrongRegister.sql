update ad_migrationscript set name='201507140000_FixWrongNameScripts.sql' where name='201510161110_FixWrongNameScripts.sql'
;

SELECT register_migration_script('201511181041_FixWrongRegister.sql') FROM dual
;

