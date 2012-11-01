-- Aug 16, 2012 11:44:05 AM COT
-- IDEMPIERE-879 Change to one account
UPDATE AD_Element SET Name='Charge Revenue (Deprecated)',Updated=TO_TIMESTAMP('2012-08-16 11:44:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Element_ID=1388
;

-- Aug 16, 2012 11:44:05 AM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=1388
;

-- Aug 16, 2012 11:44:05 AM COT
UPDATE AD_Column SET ColumnName='Ch_Revenue_Acct', Name='Charge Revenue (Deprecated)', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.' WHERE AD_Element_ID=1388
;

-- Aug 16, 2012 11:44:05 AM COT
UPDATE AD_Process_Para SET ColumnName='Ch_Revenue_Acct', Name='Charge Revenue (Deprecated)', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.', AD_Element_ID=1388 WHERE UPPER(ColumnName)='CH_REVENUE_ACCT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 16, 2012 11:44:05 AM COT
UPDATE AD_Process_Para SET ColumnName='Ch_Revenue_Acct', Name='Charge Revenue (Deprecated)', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.' WHERE AD_Element_ID=1388 AND IsCentrallyMaintained='Y'
;

-- Aug 16, 2012 11:44:05 AM COT
UPDATE AD_Field SET Name='Charge Revenue (Deprecated)', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1388) AND IsCentrallyMaintained='Y'
;

-- Aug 16, 2012 11:44:05 AM COT
UPDATE AD_PrintFormatItem SET PrintName='Charge Revenue', Name='Charge Revenue (Deprecated)' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1388)
;

-- Aug 17, 2012 9:37:01 AM COT
UPDATE AD_Element SET Help='The Charge Account identifies the account to use when recording charges', Name='Charge Account', Description='Charge Account', PrintName='Charge Account',Updated=TO_TIMESTAMP('2012-08-17 09:37:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1387
;

-- Aug 17, 2012 9:37:02 AM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=1387
;

-- Aug 17, 2012 9:37:02 AM COT
UPDATE AD_Column SET ColumnName='Ch_Expense_Acct', Name='Charge Account', Description='Charge Account', Help='The Charge Account identifies the account to use when recording charges' WHERE AD_Element_ID=1387
;

-- Aug 17, 2012 9:37:02 AM COT
UPDATE AD_Process_Para SET ColumnName='Ch_Expense_Acct', Name='Charge Account', Description='Charge Account', Help='The Charge Account identifies the account to use when recording charges', AD_Element_ID=1387 WHERE UPPER(ColumnName)='CH_EXPENSE_ACCT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 17, 2012 9:37:02 AM COT
UPDATE AD_Process_Para SET ColumnName='Ch_Expense_Acct', Name='Charge Account', Description='Charge Account', Help='The Charge Account identifies the account to use when recording charges' WHERE AD_Element_ID=1387 AND IsCentrallyMaintained='Y'
;

-- Aug 17, 2012 9:37:02 AM COT
UPDATE AD_Field SET Name='Charge Account', Description='Charge Account', Help='The Charge Account identifies the account to use when recording charges' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1387) AND IsCentrallyMaintained='Y'
;

-- Aug 17, 2012 9:37:02 AM COT
UPDATE AD_PrintFormatItem SET PrintName='Charge Account', Name='Charge Account' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1387)
;

-- Aug 17, 2012 9:39:00 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-08-17 09:39:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4871
;

-- Aug 17, 2012 9:39:05 AM COT
INSERT INTO t_alter_column values('c_acctschema_default','Ch_Revenue_Acct','NUMERIC(10)',null,'NULL')
;

-- Aug 17, 2012 9:39:05 AM COT
INSERT INTO t_alter_column values('c_acctschema_default','Ch_Revenue_Acct',null,'NULL',null)
;

-- Aug 17, 2012 9:39:11 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2012-08-17 09:39:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4871
;

-- Aug 17, 2012 9:39:47 AM COT
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2012-08-17 09:39:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3852
;

-- Aug 17, 2012 9:40:09 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_TIMESTAMP('2012-08-17 09:40:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5013
;

-- Aug 17, 2012 9:40:13 AM COT
INSERT INTO t_alter_column values('c_charge_acct','Ch_Revenue_Acct','NUMERIC(10)',null,'NULL')
;

-- Aug 17, 2012 9:40:13 AM COT
INSERT INTO t_alter_column values('c_charge_acct','Ch_Revenue_Acct',null,'NULL',null)
;

-- Aug 17, 2012 9:40:18 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2012-08-17 09:40:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5013
;

-- Aug 17, 2012 9:40:38 AM COT
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2012-08-17 09:40:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4064
;

update c_charge_acct set ch_revenue_acct=NULL WHERE AD_Client_ID=11;

update c_acctschema_default set ch_revenue_acct=NULL WHERE AD_Client_ID=11;

ALTER TABLE c_charge_acct DROP CONSTRAINT vc_chrevenue_ccharge;

ALTER TABLE c_acctschema_default DROP CONSTRAINT vc_chrevenue_cschemadefault;

UPDATE AD_System
  SET LastMigrationScriptApplied='879_IDEMPIERE-376.sql'
WHERE LastMigrationScriptApplied<'879_IDEMPIERE-376.sql'
   OR LastMigrationScriptApplied IS NULL
;
