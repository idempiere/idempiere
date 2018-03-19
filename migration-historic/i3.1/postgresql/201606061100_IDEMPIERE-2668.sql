-- Jun 6, 2016 10:53:34 AM SGT
-- IDEMPIERE-2668 Exclude Locators for Demand Operations
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_TIMESTAMP('2016-06-06 10:53:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200649
;

SELECT register_migration_script('201606061100_IDEMPIERE-2668.sql') FROM dual
;
