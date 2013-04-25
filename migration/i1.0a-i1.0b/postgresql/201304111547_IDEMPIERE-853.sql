-- Apr 11, 2013 11:39:53 AM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
INSERT INTO AD_Val_Rule (AD_Client_ID,Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,IsActive,AD_Org_ID) VALUES (0,'C_DocType.DocBaseType IN (''ARR'')  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',200038,'D','C_DocType Receipts','S','d8daa96e-1130-47a2-8a1e-780910ecca50',100,100,TO_TIMESTAMP('2013-04-11 11:39:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-04-11 11:39:52','YYYY-MM-DD HH24:MI:SS'),'Y',0)
;

-- Apr 11, 2013 11:40:04 AM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Column SET AD_Val_Rule_ID=200038,Updated=TO_TIMESTAMP('2013-04-11 11:40:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208413
;

-- Apr 11, 2013 11:54:06 AM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
INSERT INTO AD_Val_Rule (AD_Client_ID,Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,IsActive,AD_Org_ID) VALUES (0,'C_Payment.IsReconciled=''N'' AND C_Payment.IsReceipt = ''Y'' AND C_Payment.TrxType <> ''X'' AND (C_Payment.C_DepositBatch_ID = 0 OR C_Payment.C_DepositBatch_ID IS NULL)',200039,'D','C_DepositBatchLine C_Payment_ID','S','1c7fa24b-df83-46c8-a455-913dd7690bbc',100,100,TO_TIMESTAMP('2013-04-11 11:54:05','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-04-11 11:54:05','YYYY-MM-DD HH24:MI:SS'),'Y',0)
;

-- Apr 11, 2013 11:54:15 AM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Column SET AD_Val_Rule_ID=200039,Updated=TO_TIMESTAMP('2013-04-11 11:54:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208437
;

-- Apr 11, 2013 12:03:49 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-04-11 12:03:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208421
;

-- Apr 11, 2013 2:59:46 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Column SET AD_Val_Rule_ID=149,Updated=TO_TIMESTAMP('2013-04-11 14:59:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208413
;

-- Apr 11, 2013 3:00:38 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Window SET Help='The Process Payments Window allows you to enter payments for invoices.  If the payment is for a single invoice then it can be processed here.', Name='Payments into Batch', Description='Process Payments',Updated=TO_TIMESTAMP('2013-04-11 15:00:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200031
;

-- Apr 11, 2013 3:00:38 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Menu SET Name='Payments into Batch', Description='Process Payments', IsActive='Y',Updated=TO_TIMESTAMP('2013-04-11 15:00:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200035
;

-- Apr 11, 2013 3:07:06 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Process SET Value='C_BankStatement CreateFromBatch',Updated=TO_TIMESTAMP('2013-04-11 15:07:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200032
;

-- Apr 11, 2013 3:07:20 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Element SET ColumnName='CreateFromBatch',Updated=TO_TIMESTAMP('2013-04-11 15:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202201
;

-- Apr 11, 2013 3:07:21 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Column SET ColumnName='CreateFromBatch', Name='Create From Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202201
;

-- Apr 11, 2013 3:07:22 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Process_Para SET ColumnName='CreateFromBatch', Name='Create From Batch', Description=NULL, Help=NULL, AD_Element_ID=202201 WHERE UPPER(ColumnName)='CREATEFROMBATCH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Apr 11, 2013 3:07:22 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Process_Para SET ColumnName='CreateFromBatch', Name='Create From Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202201 AND IsCentrallyMaintained='Y'
;

-- Apr 11, 2013 3:07:22 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_InfoColumn SET ColumnName='CreateFromBatch', Name='Create From Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202201 AND IsCentrallyMaintained='Y'
;

-- Apr 11, 2013 3:07:45 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
ALTER TABLE C_BankStatement ADD COLUMN CreateFromBatch CHAR(1) DEFAULT NULL 
;

-- Apr 11, 2013 3:09:19 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Val_Rule SET Code='C_Payment.IsReconciled=''N'' AND C_Payment.TrxType <> ''X'' AND (C_Payment.C_DepositBatch_ID = 0 OR C_Payment.C_DepositBatch_ID IS NULL)',Updated=TO_TIMESTAMP('2013-04-11 15:09:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200039
;

-- Apr 11, 2013 3:21:20 PM SGT
-- IDEMPIERE-853 Improvement to Deposit Batch functionality
UPDATE AD_Val_Rule SET Code='C_Payment.IsReconciled=''N'' AND C_Payment.TrxType <> ''X'' AND (C_Payment.C_DepositBatch_ID = 0 OR C_Payment.C_DepositBatch_ID IS NULL) AND C_Payment.C_DocType_ID=@C_DocType_ID@',Updated=TO_TIMESTAMP('2013-04-11 15:21:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200039
;

ALTER TABLE C_BankStatement DROP COLUMN X_CreateFromBatch;

SELECT register_migration_script('201304111547_IDEMPIERE-853.sql') FROM dual
;