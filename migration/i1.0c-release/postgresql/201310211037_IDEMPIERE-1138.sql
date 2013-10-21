-- Fix wrong name on migration script - one last loose end
update ad_system set lastmigrationscriptapplied='20130717164800_IDEMPIERE-1138.sql' where lastmigrationscriptapplied='20131707164800_IDEMPIERE-1138.sql'
;
SELECT register_migration_script('201310211037_IDEMPIERE-1138.sql') FROM dual
;

