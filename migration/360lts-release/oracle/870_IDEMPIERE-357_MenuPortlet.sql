-- Aug 8, 2012 6:41:15 PM SGT
-- Move the Menu to be a Portlet
UPDATE PA_DashboardContent SET IsActive='N',Updated=TO_DATE('2012-08-08 18:41:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200001
;

-- Aug 8, 2012 6:41:47 PM SGT
-- Move the Menu to be a Portlet
UPDATE PA_DashboardContent SET IsShowInDashboard='N',Updated=TO_DATE('2012-08-08 18:41:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=50001
;

-- Aug 8, 2012 6:42:03 PM SGT
-- Move the Menu to be a Portlet
UPDATE PA_DashboardContent SET Line=2.000000000000, ColumnNo=0, IsShowInDashboard='N',Updated=TO_DATE('2012-08-08 18:42:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200000
;

UPDATE AD_System
  SET LastMigrationScriptApplied='870_IDEMPIERE-357_MenuPortlet.sql'
WHERE LastMigrationScriptApplied<'870_IDEMPIERE-357_MenuPortlet.sql'
   OR LastMigrationScriptApplied IS NULL
;