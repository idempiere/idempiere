-- IDEMPIERE-6793 - Move Accounting Implementation Classes to org.idempiere.acct
SELECT register_migration_script('202603231437_IDEMPIERE-6793.sql') FROM dual;

-- Mar 23, 2026, 2:37:50 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.report.TrialBalance',Updated=TO_TIMESTAMP('2026-03-23 14:37:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=310
;

-- Mar 23, 2026, 2:38:03 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.report.FinStatement',Updated=TO_TIMESTAMP('2026-03-23 14:38:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=204
;

-- Mar 23, 2026, 2:38:21 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.report.FinReportJasper',Updated=TO_TIMESTAMP('2026-03-23 14:38:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53063
;

-- Mar 23, 2026, 2:38:39 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.report.FinReport',Updated=TO_TIMESTAMP('2026-03-23 14:38:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=202
;

-- Mar 23, 2026, 2:40:08 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.report.BankRegister',Updated=TO_TIMESTAMP('2026-03-23 14:40:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200035
;

-- Mar 23, 2026, 2:40:26 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.AcctSchemaCopyAcct',Updated=TO_TIMESTAMP('2026-03-23 14:40:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=338
;

-- Mar 23, 2026, 2:40:40 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.AcctSchemaDefaultCopy',Updated=TO_TIMESTAMP('2026-03-23 14:40:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=108
;

-- Mar 23, 2026, 2:40:52 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.BPGroupAcctCopy',Updated=TO_TIMESTAMP('2026-03-23 14:40:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=112
;

-- Mar 23, 2026, 2:41:05 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.ClientAcctProcessor',Updated=TO_TIMESTAMP('2026-03-23 14:41:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53187
;

-- Mar 23, 2026, 2:41:17 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.CopyFromJournal',Updated=TO_TIMESTAMP('2026-03-23 14:41:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=214
;

-- Mar 23, 2026, 2:41:31 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.CopyFromJournalDoc',Updated=TO_TIMESTAMP('2026-03-23 14:41:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200005
;

-- Mar 23, 2026, 2:41:43 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.CostAdjustmentLineRefreshCost',Updated=TO_TIMESTAMP('2026-03-23 14:41:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200059
;

-- Mar 23, 2026, 2:41:55 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.CostCreate',Updated=TO_TIMESTAMP('2026-03-23 14:41:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=335
;

-- Mar 23, 2026, 2:42:33 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.CostUpdate',Updated=TO_TIMESTAMP('2026-03-23 14:42:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=182
;

-- Mar 23, 2026, 2:42:44 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.DistributionVerify',Updated=TO_TIMESTAMP('2026-03-23 14:42:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=299
;

-- Mar 23, 2026, 2:42:55 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.FactAcctReset',Updated=TO_TIMESTAMP('2026-03-23 14:42:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=175
;

-- Mar 23, 2026, 2:43:06 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.FactAcctSummary',Updated=TO_TIMESTAMP('2026-03-23 14:43:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53166
;

-- Mar 23, 2026, 2:43:17 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.FactReconcile',Updated=TO_TIMESTAMP('2026-03-23 14:43:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53221
;

-- Mar 23, 2026, 2:43:30 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.FactReconciliation',Updated=TO_TIMESTAMP('2026-03-23 14:43:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53220
;

-- Mar 23, 2026, 2:43:42 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.GLJournalGenerate',Updated=TO_TIMESTAMP('2026-03-23 14:43:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200010
;

-- Mar 23, 2026, 2:43:55 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.ImportAccount',Updated=TO_TIMESTAMP('2026-03-23 14:43:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=197
;

-- Mar 23, 2026, 2:44:07 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.ImportGLJournal',Updated=TO_TIMESTAMP('2026-03-23 14:44:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=220
;

-- Mar 23, 2026, 2:44:16 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.ImportReportLine',Updated=TO_TIMESTAMP('2026-03-23 14:44:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=198
;

-- Mar 23, 2026, 2:44:28 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.InvoiceNGL',Updated=TO_TIMESTAMP('2026-03-23 14:44:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=326
;

-- Mar 23, 2026, 2:44:40 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.LandedCostDistribute',Updated=TO_TIMESTAMP('2026-03-23 14:44:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=332
;

-- Mar 23, 2026, 2:45:06 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.ProductCategoryAcctCopy',Updated=TO_TIMESTAMP('2026-03-23 14:45:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=140
;

-- Mar 23, 2026, 2:45:17 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.ReportColumnSet_Copy',Updated=TO_TIMESTAMP('2026-03-23 14:45:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=189
;

-- Mar 23, 2026, 2:45:28 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.ReportLineSet_Copy',Updated=TO_TIMESTAMP('2026-03-23 14:45:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=190
;

-- Mar 23, 2026, 2:45:38 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.RevenueRecognition',Updated=TO_TIMESTAMP('2026-03-23 14:45:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=53710
;

-- Mar 23, 2026, 2:45:47 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.TaxDeclarationCreate',Updated=TO_TIMESTAMP('2026-03-23 14:45:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=336
;

-- Mar 23, 2026, 2:46:52 PM CET
UPDATE AD_Form SET Classname='org.idempiere.acct.form.WCharge',Updated=TO_TIMESTAMP('2026-03-23 14:46:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=105
;

-- Mar 23, 2026, 2:47:08 PM CET
UPDATE AD_Form SET Classname='org.idempiere.acct.form.WFactReconcile',Updated=TO_TIMESTAMP('2026-03-23 14:47:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=53016
;

-- Mar 23, 2026, 3:01:01 PM CET
UPDATE AD_Process SET Classname='org.idempiere.acct.process.FactAcctReset',Updated=TO_TIMESTAMP('2026-03-23 15:01:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=176
;
