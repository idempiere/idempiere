SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 23, 2014 11:08:01 PM COT
-- IDEMPIERE-2370 SaaS Generate on menu option
UPDATE AD_Process_Para SET AD_Reference_Value_ID=NULL,Updated=TO_DATE('2014-12-23 23:08:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53128
;

-- Dec 23, 2014 11:24:40 PM COT
UPDATE AD_Process_Para SET IsMandatory='Y',Updated=TO_DATE('2014-12-23 23:24:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=53128
;

SELECT register_migration_script('201412232308_SaaSMenu.sql') FROM dual
;

