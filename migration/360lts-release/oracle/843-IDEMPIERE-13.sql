-- May 28, 2012 3:21:04 PM MYT
-- IDEMPIERE-13 Workflows not appearing
UPDATE AD_WF_Node Set XPosition=0, YPosition=0;

UPDATE AD_System
  SET LastMigrationScriptApplied='843_IDEMPIERE-13.sql'
WHERE LastMigrationScriptApplied<'843_IDEMPIERE-13.sql'
   OR LastMigrationScriptApplied IS NULL
;

