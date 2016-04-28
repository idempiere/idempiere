-- IDEMPIERE-2405 Implement SaaS support for Setup Wizard
-- Apr 28, 2016 4:58:48 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-04-28 16:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4997
;

-- Apr 28, 2016 4:58:57 PM COT
INSERT INTO t_alter_column values('c_bp_group_acct','UnEarnedRevenue_Acct','NUMERIC(10)',null,'NULL')
;

-- Apr 28, 2016 4:58:57 PM COT
INSERT INTO t_alter_column values('c_bp_group_acct','UnEarnedRevenue_Acct',null,'NULL',null)
;

-- Apr 28, 2016 5:03:12 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-04-28 17:03:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5279
;

-- Apr 28, 2016 5:03:21 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Asset_Acct','NUMERIC(10)',null,'NULL')
;

-- Apr 28, 2016 5:03:21 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Asset_Acct',null,'NULL',null)
;

-- Apr 28, 2016 5:05:19 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-04-28 17:05:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6496
;

-- Apr 28, 2016 5:05:24 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_CashTransfer_Acct','NUMERIC(10)',null,'NULL')
;

-- Apr 28, 2016 5:05:24 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_CashTransfer_Acct',null,'NULL',null)
;

-- Apr 28, 2016 5:07:35 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-04-28 17:07:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5280
;

-- Apr 28, 2016 5:07:41 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Differences_Acct','NUMERIC(10)',null,'NULL')
;

-- Apr 28, 2016 5:07:41 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Differences_Acct',null,'NULL',null)
;

-- Apr 28, 2016 5:09:12 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-04-28 17:09:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5281
;

-- Apr 28, 2016 5:09:17 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Expense_Acct','NUMERIC(10)',null,'NULL')
;

-- Apr 28, 2016 5:09:17 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Expense_Acct',null,'NULL',null)
;

-- Apr 28, 2016 5:10:45 PM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2016-04-28 17:10:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5282
;

-- Apr 28, 2016 5:10:50 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Receipt_Acct','NUMERIC(10)',null,'NULL')
;

-- Apr 28, 2016 5:10:50 PM COT
INSERT INTO t_alter_column values('c_cashbook_acct','CB_Receipt_Acct',null,'NULL',null)
;

SELECT register_migration_script('201604281559_IDEMPIERE-3087.sql') FROM dual
;

