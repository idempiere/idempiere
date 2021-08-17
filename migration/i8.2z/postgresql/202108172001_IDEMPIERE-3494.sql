-- IDEMPIERE-3494 Implement DocStatus/DocAction for Project Issue
-- Aug 17, 2021, 4:14:00 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214575,0.0,'Approved','Indicates if this document requires approval','The Approved checkbox indicates if this document requires approval before it can be processed.',623,'IsApproved','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2021-08-17 16:13:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 16:13:59','YYYY-MM-DD HH24:MI:SS'),100,351,'Y','N','D','N','e9809c24-128d-4f73-960f-4930cb0451ed','N')
;

-- Aug 17, 2021, 4:14:01 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214576,0.0,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',623,'DocAction','CO',2,'N','N','Y','N','N','N',28,135,0,0,'Y',TO_TIMESTAMP('2021-08-17 16:14:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 16:14:00','YYYY-MM-DD HH24:MI:SS'),100,287,'Y','N','D','N','67095868-e746-46fb-9666-fd3a655bee1c','N')
;

-- Aug 17, 2021, 4:14:01 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214577,0.0,'Document Status','The current status of the document','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field',623,'DocStatus','DR',2,'N','N','Y','N','N','N',17,131,0,0,'Y',TO_TIMESTAMP('2021-08-17 16:14:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 16:14:01','YYYY-MM-DD HH24:MI:SS'),100,289,'Y','N','D','N','46e6517e-eec1-46c2-9220-064929e4e921','N')
;

-- Aug 17, 2021, 4:16:23 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214578,0,'Reversal ID','ID of document reversal',623,'Reversal_ID',10,'N','N','N','N','N',0,'N',30,200060,0,0,'Y',TO_TIMESTAMP('2021-08-17 16:16:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 16:16:22','YYYY-MM-DD HH24:MI:SS'),100,53457,'N','N','D','N','N','N','Y','0ae65bfe-c3e1-4402-885d-34ccbe5dcf43','N',0,'N','N','N')
;

-- Aug 17, 2021, 4:16:46 PM MYT
UPDATE AD_Column SET FKConstraintName='Reversal_CProjectIssue', FKConstraintType='N',Updated=TO_TIMESTAMP('2021-08-17 16:16:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214578
;

-- Aug 17, 2021, 4:16:46 PM MYT
ALTER TABLE C_ProjectIssue ADD COLUMN Reversal_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 17, 2021, 4:16:46 PM MYT
ALTER TABLE C_ProjectIssue ADD CONSTRAINT Reversal_CProjectIssue FOREIGN KEY (Reversal_ID) REFERENCES c_projectissue(c_projectissue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 17, 2021, 4:20:24 PM MYT
UPDATE AD_Column SET IsAllowCopy='N', IsToolbarButton='B',Updated=TO_TIMESTAMP('2021-08-17 16:20:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214576
;

-- Aug 17, 2021, 4:20:36 PM MYT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2021-08-17 16:20:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214577
;

-- Aug 17, 2021, 4:27:31 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206738,'Document Status','The current status of the document','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field',558,214577,'Y',0,180,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-08-17 16:27:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 16:27:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2eca16e7-28bd-481c-98f8-433039f657e4','Y',180,1,2,1,'N','N','N','N')
;

-- Aug 17, 2021, 4:28:54 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206739,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',558,214576,'Y',0,190,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-08-17 16:28:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 16:28:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7e84f0d4-4b70-48bd-b1ab-2e90ffc04d6b','Y',190,5,2,1,'N','N','N','N')
;

-- Aug 17, 2021, 4:29:18 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8347
;

-- Aug 17, 2021, 4:29:18 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8222
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8213
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8221
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8214
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8220
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8224
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8229
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8223
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8217
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8225
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8218
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8216
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8236
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8235
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206738
;

-- Aug 17, 2021, 4:29:19 PM MYT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206739
;

-- Aug 17, 2021, 4:30:16 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206740,'Reversal ID','ID of document reversal',558,214578,'Y',0,180,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-08-17 16:30:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 16:30:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e439e95a-906b-431d-a36f-77eb3583027a','Y',200,1,2,1,'N','N','N','N')
;

-- Aug 17, 2021, 4:30:23 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206740
;

-- Aug 17, 2021, 4:31:18 PM MYT
UPDATE AD_Field SET AD_FieldGroup_ID=101, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-08-17 16:31:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206738
;

-- Aug 17, 2021, 6:08:04 PM MYT
ALTER TABLE C_ProjectIssue ADD COLUMN IsApproved CHAR(1) DEFAULT 'N' CHECK (IsApproved IN ('Y','N')) NOT NULL
;

-- Aug 17, 2021, 6:08:04 PM MYT
ALTER TABLE C_ProjectIssue ADD COLUMN DocAction CHAR(2) DEFAULT 'CO' NOT NULL
;

-- Aug 17, 2021, 6:08:04 PM MYT
ALTER TABLE C_ProjectIssue ADD COLUMN DocStatus VARCHAR(2) DEFAULT 'DR' NOT NULL
;

-- Aug 17, 2021, 6:08:04 PM MYT
INSERT INTO t_alter_column values('c_projectissue','Reversal_ID','NUMERIC(10)',null,'NULL')
;

-- Aug 17, 2021, 6:10:48 PM MYT
INSERT INTO AD_Workflow (Name,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AccessLevel,EntityType,Author,WorkingTime,Duration,Version,Cost,DurationUnit,WaitingTime,PublishStatus,IsDefault,AD_Table_ID,Value,WorkflowType,IsValid,DocumentNo,IsBetaFunctionality,AD_Workflow_UU) VALUES ('Process_C_ProjectIssue',200007,0,0,'Y',TO_TIMESTAMP('2021-08-17 18:10:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:47','YYYY-MM-DD HH24:MI:SS'),100,'1','D','iDempiere',0,1,0,0.0,'D',0,'D','N',623,'Process_C_ProjectIssue','P','N','10000000','N','8ffb218e-e2b9-4375-87ec-11ca5d648283')
;

-- Aug 17, 2021, 6:10:49 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,JoinElement,SplitElement,DocAction,Value,AD_WF_Node_UU) VALUES (200028,'(DocAuto)','(Standard Node)',200007,0,0,'Y',TO_TIMESTAMP('2021-08-17 18:10:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0.0,0,'X','X','--','(DocAuto)','3ae63237-fa0f-4b96-900b-77f814d31304')
;

-- Aug 17, 2021, 6:10:50 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,JoinElement,SplitElement,DocAction,Value,AD_WF_Node_UU) VALUES (200029,'(DocComplete)','(Standard Node)',200007,0,0,'Y',TO_TIMESTAMP('2021-08-17 18:10:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0.0,0,'X','X','CO','(DocComplete)','e7b1f604-2233-45e2-9f99-ac4f27392edb')
;

-- Aug 17, 2021, 6:10:50 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,JoinElement,SplitElement,DocAction,Value,AD_WF_Node_UU) VALUES (200030,'(DocPrepare)','(Standard Node)',200007,0,0,'Y',TO_TIMESTAMP('2021-08-17 18:10:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0.0,0,'X','X','PR','(DocPrepare)','be9ed2b0-f470-48d7-a83a-b37cc1c3a074')
;

-- Aug 17, 2021, 6:10:51 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,"action",IsCentrallyMaintained,YPosition,EntityType,XPosition,"limit",Duration,Cost,WaitingTime,JoinElement,SplitElement,Value,AD_WF_Node_UU) VALUES (200031,'(Start)','(Standard Node)',200007,0,0,'Y',TO_TIMESTAMP('2021-08-17 18:10:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:50','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',0,'D',0,0,0,0.0,0,'X','X','(Start)','274360c6-7c88-4e4d-9887-0042fd8f38af')
;

-- Aug 17, 2021, 6:10:51 PM MYT
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200031,'Y',TO_TIMESTAMP('2021-08-17 18:10:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:51','YYYY-MM-DD HH24:MI:SS'),100,0,0,200030,'D',10,'(Standard Approval)',200028,'Y','b27ec4a5-b18e-4eec-8aa9-cc1903554e74')
;

-- Aug 17, 2021, 6:10:52 PM MYT
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200031,'Y',TO_TIMESTAMP('2021-08-17 18:10:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:51','YYYY-MM-DD HH24:MI:SS'),100,0,0,200028,'D',100,'(Standard Transition)',200029,'N','8f0f7d9b-c4d1-4b80-8b77-e78ac4918de2')
;

-- Aug 17, 2021, 6:10:53 PM MYT
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200030,'Y',TO_TIMESTAMP('2021-08-17 18:10:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:52','YYYY-MM-DD HH24:MI:SS'),100,0,0,200029,'D',100,'(Standard Transition)',200030,'N','e993246e-21ae-496f-857f-9d30c2f486ba')
;

-- Aug 17, 2021, 6:10:53 PM MYT
UPDATE AD_Workflow SET AD_WF_Node_ID=200031, IsValid='Y',Updated=TO_TIMESTAMP('2021-08-17 18:10:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=200007
;

-- Aug 17, 2021, 6:10:53 PM MYT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,AccessLevel,EntityType,AD_Workflow_ID,IsBetaFunctionality,AD_Process_UU) VALUES (200135,0,0,'Y',TO_TIMESTAMP('2021-08-17 18:10:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-08-17 18:10:53','YYYY-MM-DD HH24:MI:SS'),100,'Process Project Issue','N','C_ProjectIssue Process','3','D',200007,'N','10c5f71a-c84d-43df-87bd-29a4778351ef')
;

-- Aug 17, 2021, 6:10:53 PM MYT
UPDATE AD_Column SET AD_Process_ID=200135,Updated=TO_TIMESTAMP('2021-08-17 18:10:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214576
;

-- Aug 17, 2021, 6:56:43 PM MYT
UPDATE AD_Tab SET IsReadOnly='N',Updated=TO_TIMESTAMP('2021-08-17 18:56:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=558
;

SELECT register_migration_script('202108172001_IDEMPIERE-3494.sql') FROM dual
;

