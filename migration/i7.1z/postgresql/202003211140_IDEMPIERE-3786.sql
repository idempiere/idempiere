-- IDEMPIERE-3786 Number of records in detail grid must not be hardcoded
-- Mar 21, 2020, 11:37:03 AM CET
UPDATE AD_SysConfig SET Description='Default paging size for detail grid view in zk webui. It can be a single integer, or a list of components separated by semicolon (;). First component is the default, further components are exceptions as pair of [AD_Tab_ID|AD_Tab_UU|AD_TableName]:[size]',Updated=TO_TIMESTAMP('2020-03-21 11:37:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200143
;

SELECT register_migration_script('202003211140_IDEMPIERE-3786.sql') FROM dual
;

