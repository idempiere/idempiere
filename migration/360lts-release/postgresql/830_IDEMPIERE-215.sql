-- Apr 4, 2012 10:57:20 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Tab_Trl WHERE AD_Tab_ID=254
;

-- Apr 4, 2012 10:57:20 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Tab WHERE AD_Tab_ID=254
;

-- Apr 4, 2012 10:58:04 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Table_Trl WHERE AD_Table_ID=327
;

-- Apr 4, 2012 10:58:04 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Table WHERE AD_Table_ID=327
;

-- Apr 4, 2012 11:04:34 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Menu_Trl WHERE AD_Menu_ID=314
;

-- Apr 4, 2012 11:04:34 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Menu WHERE AD_Menu_ID=314
;

-- Apr 4, 2012 11:04:34 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_TreeNodeMM WHERE Node_ID=314 AND EXISTS (SELECT * FROM AD_Tree t WHERE t.AD_Tree_ID=AD_TreeNodeMM.AD_Tree_ID AND t.TreeType='MM')
;

-- Apr 4, 2012 11:04:48 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Process_Trl WHERE AD_Process_ID=183
;

-- Apr 4, 2012 11:04:48 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Process WHERE AD_Process_ID=183
;

-- Apr 4, 2012 11:04:55 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_ReportView WHERE AD_ReportView_ID=125
;

-- Apr 4, 2012 11:05:21 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Table_Trl WHERE AD_Table_ID=479
;

-- Apr 4, 2012 11:05:22 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DELETE FROM AD_Table WHERE AD_Table_ID=479
;

-- Apr 4, 2012 11:05:22 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DROP VIEW RV_Product_Costing;

-- Apr 4, 2012 11:05:22 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
DROP TABLE M_Product_Costing;

-- Apr 4, 2012 11:05:22 AM MYT
-- IDEMPIERE-215 Costing: Remove M_Product_Costing
UPDATE AD_System
  SET LastMigrationScriptApplied='830_IDEMPIERE-215.sql'
WHERE LastMigrationScriptApplied<'830_IDEMPIERE-215.sql'
   OR LastMigrationScriptApplied IS NULL
;

