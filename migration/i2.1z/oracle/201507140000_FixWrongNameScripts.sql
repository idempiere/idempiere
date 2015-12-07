update ad_migrationscript set name='201507141982-IDEMPIERE-1846.sql' where name='201514071982-IDEMPIERE-1846.sql'
;

update ad_migrationscript set name='201508141982-IDEMPIERE-2230.sql' where name='201514081982-IDEMPIERE-2230.sql'
;

update ad_migrationscript set name='201509280947_IDEMPIERE-1820.sql' where name='210509280947_IDEMPIERE-1820.sql'
;
   
update ad_system set lastmigrationscriptapplied='201509280947_IDEMPIERE-1820.sql' where lastmigrationscriptapplied='210509280947_IDEMPIERE-1820.sql'
;
SELECT register_migration_script('201507140000_FixWrongNameScripts.sql') FROM dual
;

