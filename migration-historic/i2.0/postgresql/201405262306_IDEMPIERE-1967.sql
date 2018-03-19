-- May 26, 2014 11:06:10 PM COT
-- IDEMPIERE-1967 Bank transfer process should allow for document number to be optional
UPDATE AD_Process_Para SET IsMandatory='N',Updated=TO_TIMESTAMP('2014-05-26 22:47:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53251
;

SELECT register_migration_script('201405262306_IDEMPIERE-1967.sql') FROM dual
;
