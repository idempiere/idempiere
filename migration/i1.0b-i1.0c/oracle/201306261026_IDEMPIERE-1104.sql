-- Jun 26, 2013 10:11:04 AM COT
-- IDEMPIERE-1104 Payments all get the same accounting date as the reconciling bank statement regardless of transaction date
UPDATE AD_Window SET Name='Bank/Cash Statement',Updated=TO_DATE('2013-06-26 10:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=194
;

-- Jun 26, 2013 10:11:04 AM COT
UPDATE AD_Menu SET Name='Bank/Cash Statement', Description='Process Bank Statements', IsActive='Y',Updated=TO_DATE('2013-06-26 10:11:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=234
;

-- Jun 26, 2013 10:20:39 AM COT
UPDATE AD_Field SET IsCentrallyMaintained='N', IsReadOnly='N', Help='The Accounting Date on Bank/Cash Statement Line is used for currency conversion and reporting purposes, the accounting is posted using the header date account.', Description='Accounting Conversion Date', Name='Account Conversion Date',Updated=TO_DATE('2013-06-26 10:20:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4121
;

-- Jun 26, 2013 10:21:25 AM COT
UPDATE AD_Tab SET Help='The Bank/Cash Statement Tab defines the Bank/Cash Statement to be reconciled.', Name='Bank/Cash Statement', Description='Bank/Cash Statement',Updated=TO_DATE('2013-06-26 10:21:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=328
;

SELECT register_migration_script('201306261026_IDEMPIERE-1104.sql') FROM dual
;

