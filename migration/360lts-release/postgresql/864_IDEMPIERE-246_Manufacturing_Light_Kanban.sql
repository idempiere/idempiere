-- Aug 6, 2012 12:16:06 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para SET AD_Reference_ID=17, AD_Reference_Value_ID=319, ColumnName='IsKanban', EntityType='D', IsCentrallyMaintained='N', Name='Is Kanban',Updated=TO_TIMESTAMP('2012-08-06 12:16:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53526
;

-- Aug 6, 2012 12:16:06 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para_Trl SET IsTranslated='N' WHERE AD_Process_Para_ID=53526
;

-- Aug 6, 2012 12:16:49 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-06 12:16:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53527
;

-- Aug 6, 2012 12:17:10 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-06 12:17:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53528
;

-- Aug 6, 2012 12:17:28 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-06 12:17:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53525
;

-- Aug 6, 2012 12:17:49 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-06 12:17:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53524
;

-- Aug 6, 2012 12:18:09 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-06 12:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53523
;

-- Aug 6, 2012 12:20:29 PM CEST
-- IDEMPIERE-246 Manufacturing Light
UPDATE AD_Process_Para SET EntityType='D',Updated=TO_TIMESTAMP('2012-08-06 12:20:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53267
;

UPDATE AD_System
  SET LastMigrationScriptApplied='863_IDEMPIERE-246_Manufacturing_Light.sql'
WHERE LastMigrationScriptApplied<'863_IDEMPIERE-246_Manufacturing_Light.sql'
   OR LastMigrationScriptApplied IS NULL
;
