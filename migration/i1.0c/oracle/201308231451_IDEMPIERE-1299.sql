-- Aug 23, 2013 2:49:42 PM COT
-- IDEMPIERE-1299 Requisition Lines can be deleted on completed Requisitions
UPDATE AD_Tab SET ReadOnlyLogic='@Processed@=Y',Updated=TO_DATE('2013-08-23 14:49:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=642
;

SELECT register_migration_script('201308231451_IDEMPIERE-1299.sql') FROM dual
;

