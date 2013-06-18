-- Jun 18, 2013 9:32:05 AM COT
-- IDEMPIERE-234 Configure Toolbar by User, by Window, by Tab and configure new buttons and new toolbars
UPDATE AD_Val_Rule SET Code='AD_ToolbarButton.Action=''''@Action@'''' AND (AD_ToolbarButton.AD_Tab_ID IS NULL OR AD_ToolbarButton.AD_Tab_ID=@AD_Tab_ID@)',Updated=TO_TIMESTAMP('2013-06-18 09:32:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200011
;

SELECT register_migration_script('201306180932_IDEMPIERE-234.sql') FROM dual
;

