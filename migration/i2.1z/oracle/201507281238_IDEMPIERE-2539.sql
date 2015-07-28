SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2539 Do not set table print format border stroke below 2
-- Jul 28, 2015 12:36:00 PM COT
UPDATE AD_PrintTableFormat SET HdrStroke=2, LineStroke=1,Updated=TO_DATE('2015-07-28 12:36:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintTableFormat_ID=100
;

SELECT register_migration_script('201507281238_IDEMPIERE-2539.sql') FROM dual
;

