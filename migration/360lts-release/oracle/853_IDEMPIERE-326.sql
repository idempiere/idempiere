-- Oracle procedure T_InventoryValue_Create is no longer used, can be deleted
drop procedure "T_INVENTORYVALUE_CREATE";

UPDATE AD_System
  SET LastMigrationScriptApplied='853_IDEMPIERE-326.sql'
WHERE LastMigrationScriptApplied<'853_IDEMPIERE-326.sql'
   OR LastMigrationScriptApplied IS NULL
;