-- Jul 4, 2012 11:26:24 AM CEST
-- TGI
INSERT INTO t_alter_column values('ad_userdef_field','DefaultValue','VARCHAR(2000)',null,'NULL')
;

-- Jul 4, 2012 11:26:26 AM CEST
-- TGI
INSERT INTO t_alter_column values('ad_userdef_field','DefaultValue',null,'NULL',null)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='850_IDEMPIERE-328.sql'
WHERE LastMigrationScriptApplied<'850_IDEMPIERE-328.sql'
   OR LastMigrationScriptApplied IS NULL
;

