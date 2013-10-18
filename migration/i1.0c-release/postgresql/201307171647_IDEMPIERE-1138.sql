-- Fix wrong name on migration script as reported at https://www.facebook.com/groups/idempiere/permalink/631456976906219/
update ad_migrationscript set name = '20130717164800_IDEMPIERE-1138.sql', filename = 'postgresql/20130717164800_IDEMPIERE-1138.sql' where name = '20131707164800_IDEMPIERE-1138.sql'
;

SELECT register_migration_script('201307171647_IDEMPIERE-1138.sql') FROM dual
;

