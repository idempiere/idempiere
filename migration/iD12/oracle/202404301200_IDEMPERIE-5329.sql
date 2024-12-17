-- IDEMPIERE-5329 Multiple Payments against single Bank/Cash statement line
SELECT register_migration_script('202404301200_IDEMPERIE-5329.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 04-Jul-2022, 7:16:06 PM IST
UPDATE AD_Table SET AD_Window_ID=200031, AD_Val_Rule_ID=NULL, PO_Window_ID=NULL, Processing='N',Updated=TO_DATE('2022-07-04 19:16:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200056
;

-- Payment into Batch Info Window
-- 04-Jul-2022, 7:16:56 PM IST
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,OrderByClause,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200020,0,0,'Y',TO_DATE('2022-07-04 19:16:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:16:55','YYYY-MM-DD HH24:MI:SS'),100,'Payment Into Batch Info',200056,'D','C_DepositBatch a','N','7f250d6a-7f8d-4d49-86cd-25a6fb822568','N','N','a.DocumentNo DESC','Y',1760,'Y',0,'Y',0)
;

-- 04-Jul-2022, 7:16:57 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200228,0,0,'Y',TO_DATE('2022-07-04 19:16:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:16:56','YYYY-MM-DD HH24:MI:SS'),100,'Deposit Amount',200020,'D','a.DepositAmt',90,'Y','N',202198,12,'c41c9b30-aa8e-48f3-8b46-3874b2e89761','Y','DepositAmt','N',0,'N','N','Y')
;

-- 04-Jul-2022, 7:16:57 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200229,0,0,'Y',TO_DATE('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,'Deposit Batch',200020,'D','a.C_DepositBatch_ID',10,'N','N',202195,13,'27567c5a-4fba-4b88-98bb-48eb98e727e8','Y','C_DepositBatch_ID','N',0,'N','Y','Y')
;

-- 04-Jul-2022, 7:16:58 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200230,0,0,'Y',TO_DATE('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:16:57','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200020,'D','a.AD_Org_ID',20,'Y','N',113,19,'d0f2f031-c9b3-42a0-b59b-7f4fe6a01927',104,'Y','AD_Org_ID','N',0,'N','N','Y')
;

-- 04-Jul-2022, 7:16:59 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200231,0,0,'Y',TO_DATE('2022-07-04 19:16:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:16:58','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200020,'D','a.C_BankAccount_ID',30,'Y','N',836,19,'6f1fa8aa-551c-48b0-9b14-d04a1df6bae6','Y','C_BankAccount_ID','N',0,'N','N','Y')
;

-- 04-Jul-2022, 7:17:00 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200232,0,0,'Y',TO_DATE('2022-07-04 19:16:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:16:59','YYYY-MM-DD HH24:MI:SS'),100,'Deposit Date',200020,'D','a.DateDeposit',40,'Y','Y',202197,15,'f9df0759-b0b4-4f97-b792-d738507d5bdd','Y','DateDeposit','=','Trunc','Y',10,'N','N','Y')
;

-- 04-Jul-2022, 7:17:00 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200233,0,0,'Y',TO_DATE('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200020,'D','a.C_DocType_ID',50,'Y','N',196,19,'cfebd86d-1a33-40dd-899c-a61902785694',149,'Y','C_DocType_ID','N',0,'N','N','Y')
;

-- 04-Jul-2022, 7:17:01 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200234,0,0,'Y',TO_DATE('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:17:00','YYYY-MM-DD HH24:MI:SS'),100,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200020,'D','a.DocumentNo',60,'Y','Y',290,10,'af50b3a8-b062-428a-9855-81306b658141','Y','DocumentNo','Like','Upper','Y',20,'N','N','Y')
;

-- 04-Jul-2022, 7:17:02 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200235,0,0,'Y',TO_DATE('2022-07-04 19:17:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:17:01','YYYY-MM-DD HH24:MI:SS'),100,'Document Date','Date of the Document','The Document Date indicates the date the document was generated.  It may or may not be the same as the accounting date.',200020,'D','a.DateDoc',70,'Y','N',265,15,'b83406df-a8b2-47a9-8679-8ab09df77f14','Y','DateDoc','N',0,'N','N','Y')
;

-- 04-Jul-2022, 7:17:03 PM IST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) VALUES (200236,0,0,'Y',TO_DATE('2022-07-04 19:17:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:17:02','YYYY-MM-DD HH24:MI:SS'),100,'Description','Optional short description of the record','A description is limited to 255 characters.',200020,'D','a.Description',80,'Y','Y',275,10,'3e83eadb-739b-4567-8683-fa30f9186d4b','Y','Description','Like','Upper','N',30,'N','N','Y')
;

-- 04-Jul-2022, 7:17:09 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200161,'Deposit Batch (Proccsed)','S','C_DepositBatch.Processed= ''Y'' AND C_DepositBatch.AD_Org_ID = (SELECT AD_Org_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@ )',0,0,'Y',TO_DATE('2022-07-04 19:17:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:17:08','YYYY-MM-DD HH24:MI:SS'),100,'D','ff157c8d-0b2f-4a67-8495-ba65c4a6e92a')
;

-- 04-Jul-2022, 7:17:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Callout,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215034,0,'Deposit Batch',393,200161,'C_DepositBatch_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2022-07-04 19:17:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:17:09','YYYY-MM-DD HH24:MI:SS'),100,'org.compiere.model.CalloutBankStatement.paymentIntoBatch',202195,'Y','N','D','Y','N','N','Y','5f21b30b-379f-4a52-89b0-4d861efda1f8','Y',0,'N','N','CDepositBatch_CBankStatementLi','N','N')
;

-- 04-Jul-2022, 7:17:10 PM IST
ALTER TABLE C_BankStatementLine ADD C_DepositBatch_ID NUMBER(10) DEFAULT NULL 
;

-- 04-Jul-2022, 7:17:10 PM IST
UPDATE AD_Field SET SeqNo=105, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4122
;

-- 04-Jul-2022, 7:17:10 PM IST
UPDATE AD_Field SET AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, ReadOnlyLogic='@C_DepositBatch_ID@ > 0', IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4010
;

-- 04-Jul-2022, 7:17:11 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,ReadOnlyLogic,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207123,'Deposit Batch',329,215034,'Y',22,140,'N','N','N','N',0,0,'Y',TO_DATE('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-04 19:17:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cc246aa8-5d7a-4c0a-8d3a-59e020be60ca','Y',350,4,2,1,'N','@C_Payment_ID@ > 0 ','N','N','N')
;

-- 04-Jul-2022, 7:17:11 PM IST
ALTER TABLE C_BankStatementLine ADD CONSTRAINT CDepositBatch_CBankStatementLi FOREIGN KEY (C_DepositBatch_ID) REFERENCES c_depositbatch(c_depositbatch_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 6, 2022, 4:28:40 PM IST
UPDATE AD_Val_Rule SET Name='C_DepositBatch not in BankStatement', Code='NOT EXISTS (SELECT * FROM C_BankStatementLine bsl INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE bsl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus NOT IN (''VO'')) AND C_DepositBatch.processed = ''Y'' AND (C_DepositBatch.AD_Org_ID, C_DepositBatch.C_BankAccount_ID) = (SELECT AD_Org_ID, C_BankAccount_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@)',Updated=TO_DATE('2022-07-06 16:28:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200161
;

-- Jul 6, 2022, 4:28:52 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Payment and Deposit Batch both should not be entered',0,0,'Y',TO_DATE('2022-07-06 16:28:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-06 16:28:51','YYYY-MM-DD HH24:MI:SS'),100,200769,'EitherPaymentOrDepositBatch','D','9812b0ad-d789-46dd-8090-4978666c6b8a')
;

-- Jul 6, 2022, 4:28:53 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Deposit Batch is not Processed',0,0,'Y',TO_DATE('2022-07-06 16:28:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-06 16:28:52','YYYY-MM-DD HH24:MI:SS'),100,200770,'DepositBatchIsNotProcessed','D','c3985aca-0da4-4bbf-b48b-035a4c9ed823')
;

-- Jul 6, 2022, 4:28:54 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Fail to get Payments Into Batch amount',0,0,'Y',TO_DATE('2022-07-06 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-06 16:43:29','YYYY-MM-DD HH24:MI:SS'),100,200772,'MissingPaymentIntoBatch','D','78f49a7e-e646-48b8-a325-a834b1ba1ed1')
;

-- 07-Jul-2022, 6:18:54 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Payment is already Reconciled ',0,0,'Y',TO_DATE('2022-07-07 18:18:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2022-07-07 18:18:53','YYYY-MM-DD HH24:MI:SS'),100,200773,'PaymentIsAlreadyReconciled','D','7b7ac70e-21fd-49a3-81c8-395cae858331')
;

-- DocAction on Payments into Batch
-- Jan 10, 2023, 5:40:55 PM IST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,AD_Process_UU) VALUES (200148,0,0,'Y',TO_DATE('2023-01-10 17:40:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:54','YYYY-MM-DD HH24:MI:SS'),100,'Process Deposit Batch','N','C_DepositBatch_Process','N','1','D',0,0,'N','N','Y','e0b1e41b-3df9-4ad2-8651-19831e5a8c88')
;

-- Jan 10, 2023, 5:40:56 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215739,0,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',200056,'DocAction','CO',2,'N','N','N','N','N',0,'N',28,135,0,0,'Y',TO_DATE('2023-01-10 17:40:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:55','YYYY-MM-DD HH24:MI:SS'),100,287,'Y',200148,'N','D','Y','N','N','Y','4ebc56d7-9ec7-403b-b420-41601d596703','Y',0,'B','N','N','N')
;

-- Jan 10, 2023, 5:40:56 PM IST
ALTER TABLE C_DepositBatch ADD DocAction CHAR(2) DEFAULT 'CO'
;

-- Jan 10, 2023, 5:40:56 PM IST
UPDATE AD_Field SET Name='Deposit Batch Close', IsDisplayed='N', DisplayLogic='@DepositAmt@!0', SeqNo=0, IsCentrallyMaintained='Y', AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, XPosition=1, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201705
;

-- Jan 10, 2023, 5:40:56 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, IsReadOnly='Y', AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsAllowCopy='N', IsDisplayedGrid='Y', XPosition=4, ColumnSpan=2, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201702
;

-- Jan 10, 2023, 5:40:56 PM IST
UPDATE AD_Field SET SeqNo=120, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201692
;

-- Jan 10, 2023, 5:40:57 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207524,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',200067,215739,'Y',0,130,0,'N','N','N','N',0,0,'Y',TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6c80ff6d-aef6-47cc-af76-24bbb214672f','Y',140,5,2,1,'N','N','N','N')
;

-- Jan 10, 2023, 5:40:57 PM IST
UPDATE AD_Field SET SeqNo=140, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-01-10 17:40:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201706
;

-- Jan 10, 2023, 5:40:58 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Can not reactivate reconciled Payment.',0,0,'Y',TO_DATE('2023-01-10 17:40:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 17:40:57','YYYY-MM-DD HH24:MI:SS'),100,200815,'NotAllowReActivationOfReconciledPaymentsIntoBatch','D','81de985a-e9f0-42a3-9546-d837058f5144')
;

-- Jan 10, 2023, 5:40:58 PM IST
update c_depositbatch set docstatus = 'CO', docaction = 'CL' where processed = 'Y'
;

-- Jan 10, 2023, 5:40:58 PM IST
UPDATE AD_Val_Rule SET Code='NOT EXISTS (SELECT * FROM C_BankStatementLine bsl INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE bsl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus NOT IN (''VO'')) AND C_DepositBatch.processed = ''Y'' AND C_DepositBatch.docstatus NOT IN (''VO'') AND (C_DepositBatch.AD_Org_ID, C_DepositBatch.C_BankAccount_ID) = (SELECT AD_Org_ID, C_BankAccount_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@)',Updated=TO_DATE('2023-01-11 11:30:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200161
;

-- 10-Jan-2023, 7:25:59 PM IST
INSERT INTO AD_Workflow (Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AccessLevel,EntityType,Author,WorkingTime,Duration,Version,Cost,DurationUnit,WaitingTime,PublishStatus,IsDefault,AD_Table_ID,Value,WorkflowType,IsValid,DocumentNo,QtyBatchSize,IsBetaFunctionality,Yield,AD_Workflow_UU) VALUES ('Process_DepositBatch','(Standard Process Deposit Batch)',200012,0,0,'Y',TO_DATE('2023-01-10 19:25:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:25:58','YYYY-MM-DD HH24:MI:SS'),100,'1','D','Logilite',0,1,0,0,'D',0,'R','N',200056,'Process_DepositBatch','P','N','10000000',1,'N',100,'d82b7be1-3e7c-454f-a575-36e93dc871bd')
;

-- 10-Jan-2023, 7:26:00 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID) VALUES (200033,'(Start)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:25:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:25:59','YYYY-MM-DD HH24:MI:SS'),100,'Z','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'CO','(Start)',0,'N','N',0,0,100,'e14fa3f8-11c7-4487-b238-24b778cfd6a0',200002)
;

-- 10-Jan-2023, 7:26:01 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID) VALUES (200034,'(DocPrepare)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:26:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,'X','X',0,'PR','(DocPrepare)',0,'N','N',0,0,100,'1d45b0f0-df4a-40ee-b2d3-6e0a70eec66f',200002)
;

-- 10-Jan-2023, 7:26:02 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID) VALUES (200035,'(DocComplete)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:26:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'CO','(DocComplete)',0,'N','N',0,0,100,'67dd1b28-ec9a-445b-9430-7ef6ffa8317f',200002)
;

-- 10-Jan-2023, 7:26:03 PM IST
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Name,Description,AD_Workflow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Action,IsCentrallyMaintained,YPosition,EntityType,XPosition,Limit,Duration,Cost,WaitingTime,WorkingTime,Priority,JoinElement,SplitElement,WaitTime,DocAction,Value,DynPriorityChange,IsMilestone,IsSubcontracting,UnitsCycles,OverlapUnits,Yield,AD_WF_Node_UU,AD_InfoWindow_ID) VALUES (200036,'(DocAuto)','(Standard Node)',200012,0,0,'Y',TO_DATE('2023-01-10 19:26:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:02','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',0,'D',0,0,0,0,0,0,0,'X','X',0,'--','(DocAuto)',0,'N','N',0,0,100,'159a3542-64ea-475e-a9c2-6feadac39b7f',200002)
;

-- 10-Jan-2023, 7:26:03 PM IST
UPDATE AD_Workflow SET AD_WF_Node_ID=200033, IsValid='Y',Updated=TO_DATE('2023-01-10 19:26:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=200012
;

-- 10-Jan-2023, 7:26:04 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200033,'Y',TO_DATE('2023-01-10 19:26:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:03','YYYY-MM-DD HH24:MI:SS'),100,0,0,200034,'D',10,'(Standard Approval)',200031,'Y','d7b15e20-ef42-4ab6-9960-1a366ee8d102')
;

-- 10-Jan-2023, 7:26:04 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200033,'Y',TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,0,0,200036,'D',100,'(Standard Transition)',200032,'N','e32796ad-f155-4af8-9723-f1002fdd9691')
;

-- 10-Jan-2023, 7:26:05 PM IST
INSERT INTO AD_WF_NodeNext (AD_WF_Node_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Client_ID,AD_Org_ID,AD_WF_Next_ID,EntityType,SeqNo,Description,AD_WF_NodeNext_ID,IsStdUserWorkflow,AD_WF_NodeNext_UU) VALUES (200034,'Y',TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2023-01-10 19:26:04','YYYY-MM-DD HH24:MI:SS'),100,0,0,200035,'D',10,'(Standard Transition)',200033,'N','bad45235-9dfc-4ba0-b04e-be6bae193884')
;

-- 10-Jan-2023, 7:56:14 PM IST
UPDATE AD_Process SET AD_Workflow_ID=200012,Updated=TO_DATE('2023-01-10 19:56:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200148
;

-- * org must not allowed in deposit batch
-- Feb 8, 2023, 6:32:32 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=130, ColumnName='AD_Org_ID', AD_Reference_Value_ID=NULL, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2023-02-08 18:32:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208399
;

-- Adding C_DepositBatch_ID column on C_Payment_v view
-- Apr 30, 2024, 4:42:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216591,0.0,'Deposit Batch',554,'C_DepositBatch_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_DATE('2024-04-30 16:42:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-30 16:42:57','YYYY-MM-DD HH24:MI:SS'),100,202195,'N','N','D','Y','N','N','Y','d7bec526-2235-40f0-90f0-306876842ca4','Y','N','N','N','N')
;

-- Jul 4, 2023, 5:49:39 PM IST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217705,'42f92d96-2ce3-47cc-bdc6-d02c82a9aefc',TO_TIMESTAMP('2023-07-04 17:49:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-07-04 17:49:38','YYYY-MM-DD HH24:MI:SS'),100,200006,'c_depositbatch_id','c_payment.c_depositbatch_id',820)
;

-- Jul 4, 2023, 5:52:38 PM IST
CREATE OR REPLACE VIEW C_Payment_v(c_payment_id, ad_client_id, ad_org_id, isactive, created, createdby, updated, updatedby, documentno, datetrx, isreceipt, c_doctype_id, trxtype, c_bankaccount_id, c_bpartner_id, c_invoice_id, c_bp_bankaccount_id, c_paymentbatch_id, tendertype, creditcardtype, creditcardnumber, creditcardvv, creditcardexpmm, creditcardexpyy, micr, routingno, accountno, checkno, a_name, a_street, a_city, a_state, a_zip, a_ident_dl, a_ident_ssn, a_email, voiceauthcode, orig_trxid, ponum, c_currency_id, c_conversiontype_id, payamt, discountamt, writeoffamt, taxamt, overunderamt, multiplierap, isoverunderpayment, isapproved, r_pnref, r_result, r_respmsg, r_authcode, r_avsaddr, r_avszip, r_info, processing, oprocessing, docstatus, docaction, isprepayment, c_charge_id, isreconciled, isallocated, isonline, processed, posted, c_campaign_id, c_project_id, c_activity_id, ad_orgtrx_id, chargeamt, c_order_id, dateacct, description, isselfservice, processedon, reversal_id, currencyrate, convertedamt, isoverridecurrencyrate, c_depositbatch_id) AS SELECT c_payment.c_payment_id AS c_payment_id, c_payment.ad_client_id AS ad_client_id, c_payment.ad_org_id AS ad_org_id, c_payment.isactive AS isactive, c_payment.created AS created, c_payment.createdby AS createdby, c_payment.updated AS updated, c_payment.updatedby AS updatedby, c_payment.documentno AS documentno, c_payment.datetrx AS datetrx, c_payment.isreceipt AS isreceipt, c_payment.c_doctype_id AS c_doctype_id, c_payment.trxtype AS trxtype, c_payment.c_bankaccount_id AS c_bankaccount_id, c_payment.c_bpartner_id AS c_bpartner_id, c_payment.c_invoice_id AS c_invoice_id, c_payment.c_bp_bankaccount_id AS c_bp_bankaccount_id, c_payment.c_paymentbatch_id AS c_paymentbatch_id, c_payment.tendertype AS tendertype, c_payment.creditcardtype AS creditcardtype, c_payment.creditcardnumber AS creditcardnumber, c_payment.creditcardvv AS creditcardvv, c_payment.creditcardexpmm AS creditcardexpmm, c_payment.creditcardexpyy AS creditcardexpyy,
c_payment.micr AS micr, c_payment.routingno AS routingno, c_payment.accountno AS accountno, c_payment.checkno AS checkno, c_payment.a_name AS a_name, c_payment.a_street AS a_street, c_payment.a_city AS a_city, c_payment.a_state AS a_state, c_payment.a_zip AS a_zip, c_payment.a_ident_dl AS a_ident_dl, c_payment.a_ident_ssn AS a_ident_ssn, c_payment.a_email AS a_email, c_payment.voiceauthcode AS voiceauthcode, c_payment.orig_trxid AS orig_trxid, c_payment.ponum AS ponum, c_payment.c_currency_id AS c_currency_id, c_payment.c_conversiontype_id AS c_conversiontype_id, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.payamt ELSE c_payment.payamt * (-1) END AS payamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.discountamt ELSE c_payment.discountamt * (-1) END AS discountamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.writeoffamt ELSE c_payment.writeoffamt * (-1) END AS writeoffamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.taxamt ELSE c_payment.taxamt * (-1) END AS taxamt, CASE c_payment.isreceipt WHEN 'Y' THEN c_payment.overunderamt ELSE c_payment.overunderamt * (-1) END AS overunderamt, CASE c_payment.isreceipt WHEN 'Y' THEN 1 ELSE (-1) END AS multiplierap, c_payment.isoverunderpayment AS isoverunderpayment, c_payment.isapproved AS isapproved, c_payment.r_pnref AS r_pnref, c_payment.r_result AS r_result, c_payment.r_respmsg AS r_respmsg, c_payment.r_authcode AS r_authcode, c_payment.r_avsaddr AS r_avsaddr, c_payment.r_avszip AS r_avszip, c_payment.r_info AS r_info, c_payment.processing AS processing, c_payment.oprocessing AS oprocessing, c_payment.docstatus AS docstatus, c_payment.docaction AS docaction, c_payment.isprepayment AS isprepayment, c_payment.c_charge_id AS c_charge_id, c_payment.isreconciled AS isreconciled, c_payment.isallocated AS isallocated, c_payment.isonline AS isonline, c_payment.processed AS processed, c_payment.posted AS posted, c_payment.c_campaign_id AS c_campaign_id, c_payment.c_project_id AS c_project_id,
c_payment.c_activity_id AS c_activity_id, c_payment.ad_orgtrx_id AS ad_orgtrx_id, c_payment.chargeamt AS chargeamt, c_payment.c_order_id AS c_order_id, c_payment.dateacct AS dateacct, c_payment.description AS description, c_payment.isselfservice AS isselfservice, c_payment.processedon AS processedon, c_payment.reversal_id AS reversal_id, c_payment.currencyrate AS currencyrate, c_payment.convertedamt AS convertedamt, c_payment.isoverridecurrencyrate AS isoverridecurrencyrate, c_payment.c_depositbatch_id AS c_depositbatch_id FROM c_payment
;

-- Adding Currency field on Deposit batch window
-- Apr 4, 2024, 6:01:37 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='C_BankAccount_ID', AD_Reference_Value_ID=NULL, Callout='org.compiere.model.CalloutDepositBatch.bankAccount', AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208412
;

-- Apr 4, 2024, 6:01:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (216588,0,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200056,'C_Currency_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2024-04-04 18:01:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:01:37','YYYY-MM-DD HH24:MI:SS'),100,193,'Y','N','D','Y','N','N','Y','0cec46ff-7504-42bf-a823-90399ce75d81','Y',0,'N','N','CCurrency_CDepositBatch','N','N')
;

-- Apr 4, 2024, 6:01:38 PM IST
ALTER TABLE C_DepositBatch ADD C_Currency_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 4, 2024, 6:01:38 PM IST
UPDATE AD_Field SET SeqNo=0, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201697
;

-- Apr 4, 2024, 6:01:39 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208478,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200067,216588,'Y',22,80,'N','N','N','N',0,0,'Y',TO_DATE('2024-04-04 18:01:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:01:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e4cf1144-8ef6-4fa0-a6c8-942cde6ac240','Y',150,4,2,1,'N','N','N','N')
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=90, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201699
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=100, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201696
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=110, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201695
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=120, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201702
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=130, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201692
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=140, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207524
;

-- Apr 4, 2024, 6:01:39 PM IST
UPDATE AD_Field SET SeqNo=150, AD_FieldGroup_ID=NULL, AD_Reference_ID=NULL, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, Included_Tab_ID=NULL, IsToolbarButton=NULL, AD_LabelStyle_ID=NULL, AD_FieldStyle_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201706
;

-- Apr 4, 2024, 6:01:39 PM IST
ALTER TABLE C_DepositBatch ADD CONSTRAINT CCurrency_CDepositBatch FOREIGN KEY (C_Currency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 4, 2024, 6:01:44 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Could not modify the currency once batch line has been added',0,0,'Y',TO_DATE('2024-04-04 18:01:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:01:43','YYYY-MM-DD HH24:MI:SS'),100,200883,'ErrorCurrencyCouldNotModify','D','364c0fa3-a697-4fab-b978-aa52ede0e591')
;

-- Apr 4, 2024, 6:01:44 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Multiple currency payments are not allowed in a single batch. All batch line payments must be in the {0} currency',0,0,'Y',TO_DATE('2024-04-04 18:01:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2024-04-04 18:01:44','YYYY-MM-DD HH24:MI:SS'),100,200884,'ErrorMultipleCurrencyPaymentsRestricted','D','d9a2d982-22d8-4c26-b820-e0894411da3b')
;

-- Apr 4, 2024, 6:01:48 PM IST
UPDATE C_DepositBatch SET C_Currency_ID = (SELECT C_Currency_ID FROM C_BankAccount WHERE C_BankAccount_ID = C_DepositBatch.C_BankAccount_ID AND C_DepositBatch.C_Currency_ID IS NULL) 
;

-- Apr 4, 2024, 6:01:48 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='C_Currency_ID', IsMandatory='Y', AD_Reference_Value_ID=NULL, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_DATE('2024-04-04 18:01:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216588
;

-- Apr 4, 2024, 6:01:48 PM IST
ALTER TABLE C_DepositBatch MODIFY C_Currency_ID NUMBER(10)
;

-- Apr 4, 2024, 6:01:49 PM IST
ALTER TABLE C_DepositBatch MODIFY C_Currency_ID NOT NULL
;

-- May 20, 2024, 11:18:41 AM IST
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2024-05-20 11:18:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201705
;

-- May 20, 2024, 11:18:48 AM IST
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2024-05-20 11:18:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208421
;

-- May 20, 2024, 11:18:58 AM IST
UPDATE AD_Process SET IsActive='N',Updated=TO_TIMESTAMP('2024-05-20 11:18:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200031
;

-- Nov 21, 2024, 9:34:08 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Deposit Batch is Processed: ',0,0,'Y',TO_TIMESTAMP('2024-11-21 21:34:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-21 21:34:07','YYYY-MM-DD HH24:MI:SS'),100,200913,'DepositBatchProcessed','D','eba95ca0-4549-4094-8297-262c591bcdce')
;

-- Dec 16, 2024, 2:16:35 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Create Line Per Payment',0,0,'Y',TO_TIMESTAMP('2024-12-16 14:16:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 14:16:34','YYYY-MM-DD HH24:MI:SS'),100,200919,'CreateLinePerPayment','D','f0a3b8c0-f6d6-4900-a952-576a9da068cc')
;

-- Dec 16, 2024, 2:16:36 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate deposit batch: deposit batch is used on a bank statement line',0,0,'Y',TO_TIMESTAMP('2024-12-16 14:16:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 14:16:35','YYYY-MM-DD HH24:MI:SS'),100,200920,'DepositBatchReactivationFailedBankStatementLine','D','ad7c18ca-4354-49de-a9f7-ea55ce4e970c')
;

-- Dec 16, 2024, 2:16:36 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not void deposit batch: deposit batch is used on a bank statement line',0,0,'Y',TO_TIMESTAMP('2024-12-16 14:16:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-16 14:16:36','YYYY-MM-DD HH24:MI:SS'),100,200921,'DepositBatchVoidFailedBankStatementLine','D','2cd760c5-5ce1-47d0-8c51-387eebe0b953')
;

-- Dec 16, 2024, 2:16:57 PM IST
UPDATE AD_Val_Rule SET Code='NOT EXISTS (SELECT * FROM C_BankStatementLine bsl INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE bsl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus <>''VO'') AND NOT EXISTS (SELECT * FROM C_DepositBatchLine dbl INNER JOIN C_BankStatementLine bsl ON (dbl.C_Payment_ID = bsl.C_Payment_ID) INNER JOIN C_BankStatement bs ON (bsl.C_BankStatement_ID = bs.C_BankStatement_ID) WHERE dbl.C_DepositBatch_ID = C_DepositBatch.C_DepositBatch_ID AND bs.docstatus <> ''VO'') AND C_DepositBatch.processed = ''Y'' AND C_DepositBatch.docstatus IN (''CO'',''CL'') AND (C_DepositBatch.AD_Org_ID, C_DepositBatch.C_BankAccount_ID) = (SELECT AD_Org_ID, C_BankAccount_ID FROM C_BankStatement WHERE C_BankStatement_ID = @C_BankStatement_ID@)',Updated=TO_TIMESTAMP('2024-12-17 12:37:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200161
;