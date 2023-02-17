-- IDEMPIERE-5507
SELECT register_migration_script('202212020949_IDEMPIERE-5507.sql') FROM dual;

-- Dec 2, 2022, 9:49:26 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203740,0,0,'Y',TO_TIMESTAMP('2022-12-02 09:49:26','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:49:26','YYYY-MM-DD HH24:MI:SS'),10,'Source','Source','Source','D','0c6a3546-aede-4714-9007-c0d0c64f6abd')
;

-- Dec 2, 2022, 9:50:21 AM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200227,'PrintFormatItemSync Source','L',0,0,'Y',TO_TIMESTAMP('2022-12-02 09:50:20','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:50:20','YYYY-MM-DD HH24:MI:SS'),10,'D','N','85f03455-8e85-4a2c-bfd8-34e71ff29458')
;

-- Dec 2, 2022, 9:50:30 AM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200620,'Table',200227,'1',0,0,'Y',TO_TIMESTAMP('2022-12-02 09:50:30','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:50:30','YYYY-MM-DD HH24:MI:SS'),10,'D','426df964-3b06-4e6e-b79d-561e33eeffd3')
;

-- Dec 2, 2022, 9:50:52 AM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200621,'ReportView Column',200227,'2',0,0,'Y',TO_TIMESTAMP('2022-12-02 09:50:52','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:50:52','YYYY-MM-DD HH24:MI:SS'),10,'D','88ad19f5-aeca-420f-8710-0cfdb6ea2c1d')
;

-- Dec 2, 2022, 9:52:36 AM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200146,0,0,'Y',TO_TIMESTAMP('2022-12-02 09:52:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:52:36','YYYY-MM-DD HH24:MI:SS'),10,'Synchronize Print Format Items','N','PrintFormatItemSync','N','org.idempiere.process.PrintFormatItemSync','7','D',0,0,'N','Y','N','30fc78bd-0748-45f5-b74c-72230b9ec89d','P')
;

-- Dec 2, 2022, 9:53:07 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200414,0,0,'Y',TO_TIMESTAMP('2022-12-02 09:53:07','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:53:07','YYYY-MM-DD HH24:MI:SS'),10,'Source',200146,10,17,200227,'N',0,'Y','Source','Y','D',203740,'26e7c8d1-4fa7-4ee6-9ced-337bef3b57bc','N','N')
;

-- Dec 2, 2022, 9:53:28 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200415,0,0,'Y',TO_TIMESTAMP('2022-12-02 09:53:27','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:53:27','YYYY-MM-DD HH24:MI:SS'),10,'Report View','View used to generate this report','The Report View indicates the view used to generate this report.',200146,20,19,'N',22,'Y','AD_ReportView_ID','Y','D',1252,'6e2d3940-eebf-4652-aac8-2d15308b64e5','N','N')
;

-- Dec 2, 2022, 9:53:41 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200416,0,0,'Y',TO_TIMESTAMP('2022-12-02 09:53:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:53:40','YYYY-MM-DD HH24:MI:SS'),10,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200146,30,19,'N',0,'N','AD_PrintFormat_ID','Y','D',1790,'566062b7-d296-4d1a-b388-a9edccbcd484','N','N')
;

-- Dec 2, 2022, 9:53:59 AM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200417,0,0,'Y',TO_TIMESTAMP('2022-12-02 09:53:59','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:53:59','YYYY-MM-DD HH24:MI:SS'),10,'AD_Language',200146,40,18,327,'N',6,'Y','@SQL=SELECT AD_Language FROM AD_Client WHERE AD_Client_ID = @#AD_Client_ID@','AD_Language','N','D','133dccfd-5437-4d7a-bb6f-78521535f5c0','N','N')
;

-- Dec 2, 2022, 9:54:36 AM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200220,'Synchronize Print Format Items','P',0,0,'Y',TO_TIMESTAMP('2022-12-02 09:54:36','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2022-12-02 09:54:36','YYYY-MM-DD HH24:MI:SS'),10,'N',200146,'Y','N','D','Y','f0f49a8a-cb37-457a-b9e6-275d026798a9')
;

-- Dec 2, 2022, 9:54:36 AM CET
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 10, statement_timestamp(), 10,t.AD_Tree_ID, 200220, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200220)
;

-- Dec 2, 2022, 9:57:09 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=326, SeqNo=6,Updated=TO_TIMESTAMP('2022-12-02 09:57:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200220
;

-- Dec 2, 2022, 9:57:09 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=326, SeqNo=7,Updated=TO_TIMESTAMP('2022-12-02 09:57:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=293
;

-- Dec 2, 2022, 9:57:09 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=326, SeqNo=8,Updated=TO_TIMESTAMP('2022-12-02 09:57:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=408
;

-- Dec 2, 2022, 9:57:09 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=326, SeqNo=9,Updated=TO_TIMESTAMP('2022-12-02 09:57:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=365
;

-- Dec 2, 2022, 9:57:09 AM CET
UPDATE AD_TreeNodeMM SET Parent_ID=326, SeqNo=10,Updated=TO_TIMESTAMP('2022-12-02 09:57:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200156
;

