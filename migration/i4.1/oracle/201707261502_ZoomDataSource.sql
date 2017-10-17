-- Jul 26, 2017 3:01:47 PM CEST
-- IDEMPIERE-1157 Adding functionality to add charts on the standard windows
UPDATE AD_Table SET AD_Window_ID=53124,Updated=TO_DATE('2017-07-26 15:01:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=53282
;

SELECT register_migration_script('201707261502_ZoomDataSource.sql') FROM dual
;

