-- May 10, 2013 10:43:39 AM COT
-- IDEMPIERE-919 Values for "Partner Location & User / Contact", no changes when value changed business partner
UPDATE AD_Column SET AD_Reference_Value_ID=NULL, AD_Reference_ID=19, AD_Val_Rule_ID=123, DefaultValue='-1',Updated=TO_TIMESTAMP('2013-05-10 10:43:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53973
;

-- May 10, 2013 10:44:19 AM COT
-- IDEMPIERE-919 Values for "Partner Location & User / Contact", no changes when value changed business partner
UPDATE AD_Column SET AD_Reference_ID=19, AD_Val_Rule_ID=167,Updated=TO_TIMESTAMP('2013-05-10 10:44:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=53975
;

SELECT register_migration_script('201305101047_IDEMPIERE-919.sql') FROM dual;

