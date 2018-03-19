SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 6, 2013 11:59:02 PM MYT
-- IDEMPIERE-583 Delete Selection Panel improvement.
UPDATE AD_ToolBarButton SET IsActive='N',Updated=TO_DATE('2013-11-06 23:59:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200034
;

SELECT register_migration_script('201311061603_IDEMPIERE-583.sql') FROM dual
;

