-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209061745_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 6, 2022, 5:45:00 PM SGT
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 17:45:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207138
;

-- Sep 6, 2022, 5:45:48 PM SGT
UPDATE AD_Field SET DisplayLogic=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 17:45:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207141
;

