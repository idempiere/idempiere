-- Jul 3, 2013 5:16:26 PM COT
-- IDEMPIERE-1123 Unnecessary showing user security fields
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-07-03 17:16:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200473
;

-- Jul 3, 2013 5:16:32 PM COT
-- IDEMPIERE-1123 Unnecessary showing user security fields
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-07-03 17:16:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200475
;

SELECT register_migration_script('20130603172740_IDEMPIERE-1123.sql') FROM dual
;

