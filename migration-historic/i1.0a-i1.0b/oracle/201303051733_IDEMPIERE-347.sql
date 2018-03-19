-- Mar 5, 2013 5:32:43 PM COT
-- IDEMPIERE-347 passwords hash
UPDATE AD_User SET EMailVerifyDate=NULL, EMail='webservice @ gardenworld.com',Updated=TO_DATE('2013-03-05 17:32:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_User_ID=50001
;

SELECT register_migration_script('201303051733_IDEMPIERE-347.sql') FROM dual
;

