-- Jun 13, 2013 1:55:56 PM COT
-- IDEMPIERE-975 Issue in populating BP location for new sales order
UPDATE AD_Message SET MsgText='Please fill in required data for:', Value='FillMinimumInfo',Updated=TO_DATE('2013-06-13 13:55:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200180
;

SELECT register_migration_script('201306131356_IDEMPIERE-974.sql') FROM dual
;

