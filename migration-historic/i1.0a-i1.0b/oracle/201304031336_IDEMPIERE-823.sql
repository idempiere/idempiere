-- Apr 3, 2013 1:25:07 PM COT
-- IDEMPIERE-823 Can not create a new Expenses
UPDATE AD_Tab SET IsReadOnly='Y', IsInsertRecord='N',Updated=TO_DATE('2013-04-03 13:25:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=456
;

-- Apr 3, 2013 1:26:25 PM COT
UPDATE AD_Tab SET IsReadOnly='Y', IsInsertRecord='N',Updated=TO_DATE('2013-04-03 13:26:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=431
;

SELECT register_migration_script('201304031336_IDEMPIERE-823.sql') FROM dual
;

