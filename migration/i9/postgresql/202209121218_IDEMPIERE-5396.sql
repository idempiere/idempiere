-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209121218_IDEMPIERE-5396.sql') FROM dual;

-- Sep 12, 2022, 12:18:19 PM SGT
UPDATE AD_InfoColumn SET SelectClause='COALESCE(v.M_Locator_ID,@M_Locator_ID@)', IsQueryCriteria='Y', AD_Reference_ID=31, QueryFunction=NULL, SeqNoSelection=70, IsMandatory='Y',Updated=TO_TIMESTAMP('2022-09-12 12:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200248
;

-- Sep 12, 2022, 12:23:36 PM SGT
UPDATE AD_Process_Para SET IsActive='N',Updated=TO_TIMESTAMP('2022-09-12 12:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200406
;

-- Sep 12, 2022, 12:25:15 PM SGT
UPDATE AD_InfoColumn SET SeqNoSelection=70,Updated=TO_TIMESTAMP('2022-09-12 12:25:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200258
;

-- Sep 12, 2022, 12:28:18 PM SGT
UPDATE AD_InfoColumn SET SeqNoSelection=40, DefaultValue='@SQL=SELECT MAX(M_Locator_ID) FROM M_Locator WHERE M_Warehouse_ID=@M_Warehouse_ID@',Updated=TO_TIMESTAMP('2022-09-12 12:28:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200248
;

-- Sep 12, 2022, 2:23:57 PM SGT
UPDATE AD_InfoColumn SET IsReadOnly='N',Updated=TO_TIMESTAMP('2022-09-12 14:23:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200248
;

