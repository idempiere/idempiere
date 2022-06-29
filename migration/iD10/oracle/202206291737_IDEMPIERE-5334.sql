-- IDEMPIERE-5334 Restore revenue/expense accounts in charges
SELECT register_migration_script('202206291737_IDEMPIERE-5334.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 29, 2022, 5:37:03 PM CEST
UPDATE AD_Element SET Name='Charge Revenue',Updated=TO_TIMESTAMP('2022-06-29 17:37:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1388
;

-- Jun 29, 2022, 5:37:03 PM CEST
UPDATE AD_Column SET ColumnName='Ch_Revenue_Acct', Name='Charge Revenue', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.', Placeholder=NULL WHERE AD_Element_ID=1388
;

-- Jun 29, 2022, 5:37:03 PM CEST
UPDATE AD_Process_Para SET ColumnName='Ch_Revenue_Acct', Name='Charge Revenue', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.', AD_Element_ID=1388 WHERE UPPER(ColumnName)='CH_REVENUE_ACCT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jun 29, 2022, 5:37:03 PM CEST
UPDATE AD_Process_Para SET ColumnName='Ch_Revenue_Acct', Name='Charge Revenue', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.', Placeholder=NULL WHERE AD_Element_ID=1388 AND IsCentrallyMaintained='Y'
;

-- Jun 29, 2022, 5:37:03 PM CEST
UPDATE AD_InfoColumn SET ColumnName='Ch_Revenue_Acct', Name='Charge Revenue', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.', Placeholder=NULL WHERE AD_Element_ID=1388 AND IsCentrallyMaintained='Y'
;

-- Jun 29, 2022, 5:37:03 PM CEST
UPDATE AD_Field SET Name='Charge Revenue', Description='Charge Revenue Account', Help='The Charge Revenue Account identifies the account to use when recording charges paid by customers.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1388) AND IsCentrallyMaintained='Y'
;

-- Jun 29, 2022, 5:37:03 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Charge Revenue', Name='Charge Revenue' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1388)
;

-- Jun 29, 2022, 5:39:58 PM CEST
UPDATE AD_Element SET Name='Charge Expense', Description='Charge Expense Account', Help='The Charge Expense Account identifies the account to use when recording charges paid to vendors.', PrintName='Charge Expense',Updated=TO_TIMESTAMP('2022-06-29 17:39:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1387
;

-- Jun 29, 2022, 5:39:58 PM CEST
UPDATE AD_Column SET ColumnName='Ch_Expense_Acct', Name='Charge Expense', Description='Charge Expense Account', Help='The Charge Expense Account identifies the account to use when recording charges paid to vendors.', Placeholder=NULL WHERE AD_Element_ID=1387
;

-- Jun 29, 2022, 5:39:58 PM CEST
UPDATE AD_Process_Para SET ColumnName='Ch_Expense_Acct', Name='Charge Expense', Description='Charge Expense Account', Help='The Charge Expense Account identifies the account to use when recording charges paid to vendors.', AD_Element_ID=1387 WHERE UPPER(ColumnName)='CH_EXPENSE_ACCT' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jun 29, 2022, 5:39:58 PM CEST
UPDATE AD_Process_Para SET ColumnName='Ch_Expense_Acct', Name='Charge Expense', Description='Charge Expense Account', Help='The Charge Expense Account identifies the account to use when recording charges paid to vendors.', Placeholder=NULL WHERE AD_Element_ID=1387 AND IsCentrallyMaintained='Y'
;

-- Jun 29, 2022, 5:39:58 PM CEST
UPDATE AD_InfoColumn SET ColumnName='Ch_Expense_Acct', Name='Charge Expense', Description='Charge Expense Account', Help='The Charge Expense Account identifies the account to use when recording charges paid to vendors.', Placeholder=NULL WHERE AD_Element_ID=1387 AND IsCentrallyMaintained='Y'
;

-- Jun 29, 2022, 5:39:58 PM CEST
UPDATE AD_Field SET Name='Charge Expense', Description='Charge Expense Account', Help='The Charge Expense Account identifies the account to use when recording charges paid to vendors.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1387) AND IsCentrallyMaintained='Y'
;

-- Jun 29, 2022, 5:39:58 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Charge Expense', Name='Charge Expense' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=1387)
;

-- Jun 29, 2022, 5:42:51 PM CEST
UPDATE AD_Column SET IsActive='Y',Updated=TO_TIMESTAMP('2022-06-29 17:42:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4871
;

-- Jun 29, 2022, 5:44:37 PM CEST
UPDATE AD_Field SET IsActive='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:44:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3852
;

-- Jun 29, 2022, 5:45:16 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=410, AD_FieldGroup_ID=200009, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:45:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3852
;

-- Jun 29, 2022, 5:45:16 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:45:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2654
;

-- Jun 29, 2022, 5:45:16 PM CEST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:45:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3835
;

-- Jun 29, 2022, 5:45:16 PM CEST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:45:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3823
;

-- Jun 29, 2022, 5:45:17 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:45:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204659
;

-- Jun 29, 2022, 5:46:02 PM CEST
UPDATE AD_Column SET IsActive='Y',Updated=TO_TIMESTAMP('2022-06-29 17:46:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5013
;

-- Jun 29, 2022, 5:46:43 PM CEST
UPDATE AD_Field SET IsActive='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:46:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4064
;

-- Jun 29, 2022, 5:46:57 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:46:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4064
;

-- Jun 29, 2022, 5:46:57 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-29 17:46:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204695
;

UPDATE C_AcctSchema_Default SET CH_Revenue_Acct=CH_Expense_Acct WHERE CH_Revenue_Acct IS NULL
;

UPDATE C_Charge_Acct SET CH_Revenue_Acct=CH_Expense_Acct WHERE CH_Revenue_Acct IS NULL
;

-- Jun 29, 2022, 5:49:38 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-06-29 17:49:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4871
;

-- Jun 29, 2022, 5:49:42 PM CEST
ALTER TABLE C_AcctSchema_Default MODIFY Ch_Revenue_Acct NUMBER(10)
;

-- Jun 29, 2022, 5:49:42 PM CEST
ALTER TABLE C_AcctSchema_Default MODIFY Ch_Revenue_Acct NOT NULL
;

-- Jun 29, 2022, 5:50:37 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2022-06-29 17:50:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5013
;

-- Jun 29, 2022, 5:50:38 PM CEST
ALTER TABLE C_Charge_Acct MODIFY Ch_Revenue_Acct NUMBER(10)
;

-- Jun 29, 2022, 5:50:38 PM CEST
ALTER TABLE C_Charge_Acct MODIFY Ch_Revenue_Acct NOT NULL
;

