-- Mar 19, 2012 8:33:59 PM MYT
-- IDEMPIERE-118 Average Costing: Negative Inventory
UPDATE AD_Column SET ReadOnlyLogic=NULL,Updated=TO_DATE('2012-03-19 20:33:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13455
;

UPDATE AD_System
  SET LastMigrationScriptApplied='826_IDEMPIERE-118.sql'
WHERE LastMigrationScriptApplied<'826_IDEMPIERE-118.sql'
   OR LastMigrationScriptApplied IS NULL
;
