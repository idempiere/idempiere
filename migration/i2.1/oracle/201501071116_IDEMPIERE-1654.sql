SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 2, 2014 3:03:27 PM ICT
-- IDEMPIERE-1654 IsInsertRecord = 'Y' for Organization Info Tab on Organization Window
UPDATE AD_Table SET IsDeleteable='N',Updated=TO_DATE('2015-01-07 11:03:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=227
;

-- Jan 2, 2014 3:07:18 PM ICT
UPDATE AD_Tab SET IsInsertRecord='N',Updated=TO_DATE('2015-01-07 11:07:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=170
;

SELECT register_migration_script('201501071116_IDEMPIERE-1654.sql') FROM dual
;
