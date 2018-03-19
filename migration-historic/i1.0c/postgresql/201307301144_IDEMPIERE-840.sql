-- Jul 30, 2013 11:49:17 AM SGT
-- IDEMPIERE-840 Improvement to Request model class	
UPDATE AD_ModelValidator SET IsActive='N',Updated=TO_TIMESTAMP('2013-07-30 11:49:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ModelValidator_ID=200003
;

SELECT register_migration_script('201307301144_IDEMPIERE-840.sql') FROM dual
;