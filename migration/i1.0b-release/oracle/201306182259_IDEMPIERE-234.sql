-- Jun 18, 2013 10:56:36 PM COT
-- IDEMPIERE-234 Configure Toolbar by User, by Window, by Tab and configure new buttons and new toolbars
UPDATE AD_Val_Rule SET Code='(((AD_ToolbarButton.Action=''@Action@'') OR (AD_ToolbarButton.Action||''@Action@''=''RW'' )) AND (AD_ToolbarButton.AD_Tab_ID IS NULL OR COALESCE(AD_ToolbarButton.AD_Tab_ID,0)=@AD_Tab_ID:0@))',Updated=TO_DATE('2013-06-18 22:56:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200011
;

SELECT register_migration_script('201306182259_IDEMPIERE-234.sql') FROM dual
;

