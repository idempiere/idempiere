-- IDEMPIERE-2296 Value Preference should have precedence over Default Value of field
-- Oct 25, 2015 12:10:37 PM COT
UPDATE AD_SysConfig SET Value='623',Updated=TO_TIMESTAMP('2015-10-25 12:10:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200065
;

SELECT register_migration_script('201510251210_IDEMPIERE-2296.sql') FROM dual
;

