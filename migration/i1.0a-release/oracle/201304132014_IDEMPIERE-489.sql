-- Apr 13, 2013 8:13:48 PM COT
-- IDEMPIERE-489 Make use of AD_Language configuration
UPDATE AD_Column SET AD_Reference_Value_ID=NULL, AD_Reference_ID=20, Updated=TO_DATE('2013-04-13 20:13:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13080
;

SELECT register_migration_script('201304132014_IDEMPIERE-489.sql') FROM dual
;

