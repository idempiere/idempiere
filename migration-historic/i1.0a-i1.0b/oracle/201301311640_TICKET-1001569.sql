-- Jan 30, 2013 3:35:24 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Form (Name,AccessLevel,Classname,AD_Form_ID,IsBetaFunctionality,EntityType,AD_Form_UU,AD_Org_ID,UpdatedBy,CreatedBy,Updated,Created,AD_Client_ID,IsActive) VALUES ('VCreateFromBatchStatementUI','3','org.compiere.apps.form.VCreateFromBatchStatementUI',200006,'N','D','f7ea6003-2e6b-4873-9e0b-a8c18ec2ee6d',0,100,100,TO_DATE('2013-01-30 15:35:23','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-30 15:35:23','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Jan 30, 2013 3:35:24 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Form_Trl (AD_Language,AD_Form_ID, Name,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Form_Trl_UU ) SELECT l.AD_Language,t.AD_Form_ID, t.Name,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Form t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Form_ID=200006 AND NOT EXISTS (SELECT * FROM AD_Form_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Form_ID=t.AD_Form_ID)
;

-- Jan 30, 2013 3:36:19 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Form SET Name='Bank Statement Create From Batch',Updated=TO_DATE('2013-01-30 15:36:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=200006
;

-- Jan 30, 2013 3:36:19 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Form_Trl SET IsTranslated='N' WHERE AD_Form_ID=200006
;

-- Jan 30, 2013 3:37:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,AD_Form_ID,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',200032,'N','N','986e4432-909a-4ca4-a838-0868f7d022a7','3','N','N',0,0,'Y','D',200006,'Bank Statement Create From Batch','C_BankStatement X_CreateFromBatch',0,0,TO_DATE('2013-01-30 15:37:04','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-30 15:37:04','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Jan 30, 2013 3:37:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200032 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jan 30, 2013 3:37:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Column SET AD_Process_ID=200032,Updated=TO_DATE('2013-01-30 15:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208442
;

-- Jan 30, 2013 3:59:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Form SET Classname='org.compiere.apps.form.VStatementCreateFromBatch',Updated=TO_DATE('2013-01-30 15:59:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=200006
;

SELECT register_migration_script('201301311640_TICKET-1001569.sql') FROM dual
;