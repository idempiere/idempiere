-- Jun 4, 2014 6:03:55 PM COT
-- IDEMPIERE-1792 Info Window - Default Logic missing
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y',Updated=TO_TIMESTAMP('2014-06-04 18:03:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203048
;

SELECT register_migration_script('201406041804_IDEMPIERE-1792.sql') FROM dual
;

