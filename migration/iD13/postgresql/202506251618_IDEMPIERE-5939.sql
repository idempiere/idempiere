-- IDEMPIERE-5939 If Financial report marked as List Source and List Transactions both with Report cube, it throw SQL exceptions
SELECT register_migration_script('202506251725_IDEMPIERE-5939.sql') FROM dual;

-- Jun 25, 2025, 5:20:07 PM IST
UPDATE AD_Field SET DisplayLogic='@ListSources@=Y&@PA_ReportCube_ID@=0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-25 17:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6267
;

-- Jun 25, 2025, 5:20:27 PM IST
UPDATE AD_Field SET DisplayLogic='@ListTrx@=N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2025-06-25 17:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57034
;

-- Jun 25, 2025, 5:20:42 PM IST
UPDATE AD_Process_Para SET ReadOnlyLogic='@ListTrx@=Y',Updated=TO_TIMESTAMP('2025-06-25 17:19:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53313
;
