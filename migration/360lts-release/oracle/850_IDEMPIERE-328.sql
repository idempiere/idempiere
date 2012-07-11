-- Jul 4, 2012 11:26:24 AM CEST
-- TGI
ALTER TABLE AD_UserDef_Field MODIFY DefaultValue NVARCHAR2(2000) DEFAULT NULL 
;

-- Jul 4, 2012 11:26:26 AM CEST
-- TGI
ALTER TABLE AD_UserDef_Field MODIFY DefaultValue NULL
;

UPDATE AD_System
  SET LastMigrationScriptApplied='850_IDEMPIERE-328.sql'
WHERE LastMigrationScriptApplied<'850_IDEMPIERE-328.sql'
   OR LastMigrationScriptApplied IS NULL
;

