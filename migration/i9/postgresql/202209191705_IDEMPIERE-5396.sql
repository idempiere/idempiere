-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209191705_IDEMPIERE-5396.sql') FROM dual;

-- Sep 19, 2022, 5:05:47 PM SGT
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-19 17:05:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207237
;

