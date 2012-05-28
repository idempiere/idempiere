-- May 28, 2012 02:05:39 PM MYT
-- IDEMPIERE-274 Database seed missing Generate_UUID function
create or replace function generate_uuid return varchar as
guid varchar(32);
uuid varchar(36);
begin
	guid := lower(sys_guid());
	uuid := substr(guid, 1, 8) || '-' || substr(guid, 9, 4) || '-' || substr(guid, 13, 4) || '-' || substr(guid, 17, 4) || '-' || substr(guid, 21, 12);
	return uuid;
end;

UPDATE AD_System
  SET LastMigrationScriptApplied='840_IDEMPIERE-274.sql'
WHERE LastMigrationScriptApplied<'840_IDEMPIERE-274.sql'
   OR LastMigrationScriptApplied IS NULL
;
