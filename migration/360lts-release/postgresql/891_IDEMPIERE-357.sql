-- Aug 22, 2012 9:41:18 PM COT
-- IDEMPIERE-377 Improve current search dialog box
UPDATE PA_DashboardContent SET Description='Request Calendar',Updated=TO_TIMESTAMP('2012-08-22 21:41:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=50004
;

-- Aug 22, 2012 9:41:18 PM COT
UPDATE PA_DashboardContent_Trl SET Description='Request Calendar',Name='Calendar',IsTranslated='Y' WHERE PA_DashboardContent_ID=50004
;

UPDATE AD_System
  SET LastMigrationScriptApplied='891_IDEMPIERE-357.sql'
WHERE LastMigrationScriptApplied<'891_IDEMPIERE-357.sql'
   OR LastMigrationScriptApplied IS NULL
;
