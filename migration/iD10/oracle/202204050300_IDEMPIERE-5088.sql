SELECT register_migration_script('202204050300_IDEMPIERE-5088.sql') FROM dual
;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 3, 2022 3:35:52 PM SGT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Table_UU,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,ReplicationType,AD_Org_ID,Updated,IsCentrallyMaintained,IsDeleteable,Description,TableName,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Processing,AD_Window_ID,EntityType,Created,LoadSeq) VALUES ('N','1','edbd089c-6396-4bb8-bda6-6ec9c1a80852',200246,'N','N','Y','L',0,TO_DATE('2022-04-03 15:36:01','YYYY-MM-DD HH24:MI:SS'),'Y','Y','Bank Transfer','C_BankTransfer','Bank Transfer','Y',100,100,0,'N',NULL,'D',TO_DATE('2022-04-03 15:36:01','YYYY-MM-DD HH24:MI:SS'),130)
;

-- Apr 3, 2022 3:36:02 PM SGT
INSERT INTO AD_Sequence (StartNewYear,AD_Sequence_ID,IsTableID,IsAudited,IsAutoSequence,AD_Org_ID,Description,Name,IncrementNo,AD_Sequence_UU,CreatedBy,Updated,IsActive,StartNo,AD_Client_ID,Created,UpdatedBy,CurrentNextSys,CurrentNext) VALUES ('N',200310,'Y','N','Y',0,'Table C_BankTransfer','C_BankTransfer',1,'ed113f92-24cd-49f6-97a0-ceff1f7d787d',100,TO_DATE('2022-04-03 15:36:01','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,0,TO_DATE('2022-04-03 15:36:01','YYYY-MM-DD HH24:MI:SS'),100,200000,1000000)
;

-- Apr 3, 2022 3:36:03 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203246,'C_BankTransfer_ID',TO_DATE('2022-04-03 15:36:02','YYYY-MM-DD HH24:MI:SS'),'Bank Transfer','Bank Transfer','Bank Transfer','78e34c62-2a4e-4d51-a970-9e698ced9f58','Y',TO_DATE('2022-04-03 15:36:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:03 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213645,0,'Y',0,'Y','N','N',0,'N',22,'N','Y','N','N','1d4018e8-8d28-4949-9be1-51fbfd0e452d',TO_DATE('2022-04-03 15:36:03','YYYY-MM-DD HH24:MI:SS'),'N','C_BankTransfer_ID','Bank Transfer','Bank Transfer','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:03','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203246,13,200246,'N')
;

-- Apr 3, 2022 3:36:03 PM SGT
CREATE TABLE C_BankTransfer (C_BankTransfer_ID NUMBER(10) NOT NULL, CONSTRAINT C_BankTransfer_Key PRIMARY KEY (C_BankTransfer_ID))
;

-- Apr 3, 2022 3:36:03 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID,IsToolbarButton) VALUES (213636,0,'Y',0,'Y','N','N',0,'N',22,'N','N','N','N','67979aa7-ab8a-46a3-af6b-ea09050018bb',TO_DATE('2022-04-03 15:36:03','YYYY-MM-DD HH24:MI:SS'),'N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:03','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',102,19,129,200246,'N')
;

-- Apr 3, 2022 3:36:03 PM SGT
ALTER TABLE C_BankTransfer ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:04 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Table_ID,IsToolbarButton) VALUES (213637,0,'Y',0,'Y','N','N',0,'N',22,'Y','N','N','N','3018fb45-79e7-4a91-8a5f-822a2adb2c33',TO_DATE('2022-04-03 15:36:04','YYYY-MM-DD HH24:MI:SS'),'N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:04','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',113,19,104,200246,'N')
;

-- Apr 3, 2022 3:36:04 PM SGT
ALTER TABLE C_BankTransfer ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:04 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213638,0,'Y',0,'Y','N','N',0,'N',7,'N','N','N','N','f1445de2-9323-4d56-901c-89b67585350c',TO_DATE('2022-04-03 15:36:04','YYYY-MM-DD HH24:MI:SS'),'N','Created','Date this record was created','SYSDATE','The Created field indicates the date that this record was created.','Created','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:04','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',245,16,200246,'N')
;

-- Apr 3, 2022 3:36:04 PM SGT
ALTER TABLE C_BankTransfer ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Apr 3, 2022 3:36:04 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213639,0,'Y',0,'Y','N','N',0,'N',22,'N','N','N','N','d2476072-951a-4285-9d7f-9d75f6fc262e',TO_DATE('2022-04-03 15:36:04','YYYY-MM-DD HH24:MI:SS'),'N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:04','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',246,18,110,200246,'N')
;

-- Apr 3, 2022 3:36:05 PM SGT
ALTER TABLE C_BankTransfer ADD CreatedBy NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:05 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213640,0,'Y',0,'N','N','N',0,'N',255,'Y','N','N','Y','9638902b-0d51-431a-9c38-6642710dac5e',TO_DATE('2022-04-03 15:36:05','YYYY-MM-DD HH24:MI:SS'),'Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:05','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',275,10,200246,'N')
;

-- Apr 3, 2022 3:36:05 PM SGT
ALTER TABLE C_BankTransfer ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Apr 3, 2022 3:36:05 PM SGT
INSERT INTO AD_Workflow (AD_Workflow_ID,Cost,WaitingTime,WorkingTime,AccessLevel,Duration,DurationUnit,IsDefault,IsValid,PublishStatus,Version,QtyBatchSize,IsBetaFunctionality,Yield,WorkflowType,Value,Name,Description,AD_Workflow_UU,Author,DocumentNo,AD_Org_ID,IsActive,AD_Client_ID,Created,Updated,CreatedBy,EntityType,AD_Table_ID,UpdatedBy) VALUES (200005,0,0,0,'1',1,'D','N','N','U',0,1,'N',100,'P','Process_BankTransfer','Process_BankTransfer','(Standard Process_BankTransfer)','3c870b75-e06a-4930-a466-401060f76b42','iDempiere, Inc.','10000000',0,'Y',0,TO_DATE('2022-04-03 15:36:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-04-03 15:36:05','YYYY-MM-DD HH24:MI:SS'),100,'D',200246,100)
;

-- Apr 3, 2022 3:36:06 PM SGT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,IsMilestone,WaitTime,IsSubcontracting,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,SplitElement,Action,AD_WF_Node_UU,Description,Value,Name,DynPriorityChange,Updated,IsActive,AD_Client_ID,AD_Org_ID,Created,UpdatedBy,CreatedBy,DocAction,EntityType,AD_Workflow_ID) VALUES (200023,0,0,0,0,100,'N',0,'N',0,0,'Y','X',0,0,0,0,'X','Z','f77f486f-2531-4f28-b8e8-deb314f2ad94','(Standard Node)','(Start)','(Start)',0,TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),'Y',0,0,TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),100,100,'CO','D',200005)
;

-- Apr 3, 2022 3:36:06 PM SGT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,IsMilestone,WaitTime,IsSubcontracting,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,SplitElement,Action,AD_WF_Node_UU,Description,Value,Name,DynPriorityChange,Updated,IsActive,AD_Client_ID,AD_Org_ID,Created,UpdatedBy,CreatedBy,DocAction,EntityType,AD_Workflow_ID) VALUES (200022,0,0,0,0,100,'N',0,'N',0,0,'Y','X',0,0,0,0,'X','D','3ea380f2-3a8c-4853-8588-f38a0a03d2be','(Standard Node)','(DocPrepare)','(DocPrepare)',0,TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),'Y',0,0,TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),100,100,'PR','D',200005)
;

-- Apr 3, 2022 3:36:07 PM SGT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,IsMilestone,WaitTime,IsSubcontracting,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,SplitElement,Action,AD_WF_Node_UU,Description,Value,Name,DynPriorityChange,Updated,IsActive,AD_Client_ID,AD_Org_ID,Created,UpdatedBy,CreatedBy,DocAction,EntityType,AD_Workflow_ID) VALUES (200021,0,0,0,0,100,'N',0,'N',0,0,'Y','X',0,0,0,0,'X','D','879e6adf-4644-4afe-950c-e6b7f2ffee9d','(Standard Node)','(DocComplete)','(DocComplete)',0,TO_DATE('2022-04-03 15:36:07','YYYY-MM-DD HH24:MI:SS'),'Y',0,0,TO_DATE('2022-04-03 15:36:07','YYYY-MM-DD HH24:MI:SS'),100,100,'CO','D',200005)
;

-- Apr 3, 2022 3:36:07 PM SGT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,IsMilestone,WaitTime,IsSubcontracting,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,SplitElement,Action,AD_WF_Node_UU,Description,Value,Name,DynPriorityChange,Updated,IsActive,AD_Client_ID,AD_Org_ID,Created,UpdatedBy,CreatedBy,DocAction,EntityType,AD_Workflow_ID) VALUES (200020,0,0,0,0,100,'N',0,'N',0,0,'Y','X',0,0,0,0,'X','D','217a4e7b-83c9-43e3-8f02-2e7c2d74684b','(Standard Node)','(DocAuto)','(DocAuto)',0,TO_DATE('2022-04-03 15:36:07','YYYY-MM-DD HH24:MI:SS'),'Y',0,0,TO_DATE('2022-04-03 15:36:07','YYYY-MM-DD HH24:MI:SS'),100,100,'--','D',200005)
;

-- Apr 3, 2022 3:36:06 PM SGT
INSERT INTO AD_WF_NodeNext (AD_WF_NodeNext_ID,SeqNo,IsStdUserWorkflow,AD_WF_Next_ID,AD_WF_NodeNext_UU,Description,IsActive,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,EntityType,AD_WF_Node_ID) VALUES (200019,10,'Y',200022,'0942689e-785b-4ba8-b975-4d1bb302b30e','(Standard Approval)','Y',0,0,TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),100,100,'D',200023)
;

-- Apr 3, 2022 3:36:06 PM SGT
INSERT INTO AD_WF_NodeNext (AD_WF_NodeNext_ID,SeqNo,IsStdUserWorkflow,AD_WF_Next_ID,AD_WF_NodeNext_UU,Description,IsActive,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,EntityType,AD_WF_Node_ID) VALUES (200020,100,'N',200020,'e1b58af1-5ff4-43f7-8da9-55efb0d6bb52','(Standard Transition)','Y',0,0,TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-04-03 15:36:06','YYYY-MM-DD HH24:MI:SS'),100,100,'D',200023)
;

-- Apr 3, 2022 3:36:07 PM SGT
INSERT INTO AD_WF_NodeNext (AD_WF_NodeNext_ID,SeqNo,IsStdUserWorkflow,AD_WF_Next_ID,AD_WF_NodeNext_UU,Description,IsActive,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,EntityType,AD_WF_Node_ID) VALUES (200022,100,'N',200021,'763e37fc-374a-40ef-9259-adda8ae4f48b','(Standard Transition)','Y',0,0,TO_DATE('2022-04-03 15:36:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-04-03 15:36:07','YYYY-MM-DD HH24:MI:SS'),100,100,'D',200022)
;

-- Apr 3, 2022 3:36:08 PM SGT
UPDATE AD_Workflow SET IsValid='Y', AD_WF_Node_ID=200023,Updated=TO_DATE('2022-04-03 15:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=200005
;

-- Apr 3, 2022 3:36:08 PM SGT
INSERT INTO AD_Process (AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Updated,IsActive,AD_Org_ID,UpdatedBy,Name,Value,Created,CreatedBy,AD_Client_ID,EntityType,AD_Workflow_ID) VALUES (200101,'N','N','a583c20e-f2df-4edd-af04-d8ab3ce689b7','1','N','N',0,0,'Y',TO_DATE('2022-04-03 15:36:08','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,'Process Bank Transfer','C_BankTransfer_Process',TO_DATE('2022-04-03 15:36:08','YYYY-MM-DD HH24:MI:SS'),100,0,'D',200005)
;

-- Apr 3, 2022 3:36:08 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213641,0,'Y',0,'Y','N','N',0,'N',2,'N','N',200101,'N','Y','05da015f-7fa4-4070-89df-a22ef5693b53',TO_DATE('2022-04-03 15:36:08','YYYY-MM-DD HH24:MI:SS'),'Y','DocAction','The targeted status of the document','CO','You find the current status in the Document Status field. The options are listed in a popup','Document Action','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:08','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',287,28,135,200246,'B')
;

-- Apr 3, 2022 3:36:08 PM SGT
ALTER TABLE C_BankTransfer ADD DocAction CHAR(2) DEFAULT 'CO' NOT NULL
;

-- Apr 3, 2022 3:36:09 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213642,0,'Y',0,'Y','N','N',0,'N',2,'N','N','N','Y','95f4253d-16b5-4486-b225-6ba220783c49',TO_DATE('2022-04-03 15:36:08','YYYY-MM-DD HH24:MI:SS'),'Y','DocStatus','The current status of the document','DR','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','Document Status','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:08','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',289,17,131,200246,'N')
;

-- Apr 3, 2022 3:36:09 PM SGT
ALTER TABLE C_BankTransfer ADD DocStatus CHAR(2) DEFAULT 'DR' NOT NULL
;

-- Apr 3, 2022 3:36:09 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213643,0,'Y',0,'Y','N','Y',0,'N',30,'Y','N','N','Y','8b6c681a-6c23-4177-a6e9-96eac1a7154f',TO_DATE('2022-04-03 15:36:09','YYYY-MM-DD HH24:MI:SS'),'Y','DocumentNo','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Document No','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:09','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',290,10,200246,'N')
;

-- Apr 3, 2022 3:36:09 PM SGT
ALTER TABLE C_BankTransfer ADD DocumentNo VARCHAR2(30 CHAR) NOT NULL
;

-- Apr 3, 2022 3:36:09 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213644,0,'Y',0,'Y','N','N',0,'N',1,'N','N','N','Y','f6485f4c-57a8-419e-a51b-57b69ce55da6',TO_DATE('2022-04-03 15:36:09','YYYY-MM-DD HH24:MI:SS'),'Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:09','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',348,20,200246,'N')
;

-- Apr 3, 2022 3:36:09 PM SGT
ALTER TABLE C_BankTransfer ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Apr 3, 2022 3:36:09 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203247,'C_BankTransfer_UU',TO_DATE('2022-04-03 15:36:09','YYYY-MM-DD HH24:MI:SS'),'C_BankTransfer_UU','C_BankTransfer_UU','54c6bd80-ad26-488c-91e3-0c12125bcb6a','Y',TO_DATE('2022-04-03 15:36:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:10 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213646,0,'Y',0,'N','N','N',0,'N',36,'N','N','N','Y','45a52ca9-a619-40f1-8524-c6a8cdccd900',TO_DATE('2022-04-03 15:36:10','YYYY-MM-DD HH24:MI:SS'),'Y','C_BankTransfer_UU','C_BankTransfer_UU','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:10','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203247,10,200246,'N')
;

-- Apr 3, 2022 3:36:10 PM SGT
ALTER TABLE C_BankTransfer ADD C_BankTransfer_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Apr 3, 2022 3:36:10 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT C_BankTransfer_UU_idx UNIQUE (C_BankTransfer_UU)
;

-- Apr 3, 2022 3:36:10 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213647,0,'Y',0,'Y','N','N',0,'N',1,'N','N','N','Y','1e4b5f33-7bd7-40d6-83d6-93fd537d2123',TO_DATE('2022-04-03 15:36:10','YYYY-MM-DD HH24:MI:SS'),'Y','Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.','Processed','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:10','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',1047,20,200246,'N')
;

-- Apr 3, 2022 3:36:10 PM SGT
ALTER TABLE C_BankTransfer ADD Processed CHAR(1) CHECK (Processed IN ('Y','N')) NOT NULL
;

-- Apr 3, 2022 3:36:10 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213648,0,'Y',0,'N','N','N',0,'N',1,'N','N','N','N','8b32694a-f2f6-4b3d-a8a1-f0fb6b49a554',TO_DATE('2022-04-03 15:36:10','YYYY-MM-DD HH24:MI:SS'),'Y','Processing','Process Now','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:10','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',524,20,200246,'N')
;

-- Apr 3, 2022 3:36:10 PM SGT
ALTER TABLE C_BankTransfer ADD Processing CHAR(1) DEFAULT NULL  CHECK (Processing IN ('Y','N'))
;

-- Apr 3, 2022 3:36:11 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213649,0,'Y',0,'Y','N','N',0,'N',7,'N','N','N','N','d26bbd4c-a217-4243-9b5d-8838d7dd1d6b',TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'N','Updated','Date this record was updated','SYSDATE','The Updated field indicates the date that this record was updated.','Updated','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',607,16,200246,'N')
;

-- Apr 3, 2022 3:36:11 PM SGT
ALTER TABLE C_BankTransfer ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Apr 3, 2022 3:36:11 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213650,0,'Y',0,'Y','N','N',0,'N',22,'N','N','N','N','cda9193e-66ce-4ecf-b541-cdeced4bc49d',TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'D','N','N','D',608,18,110,200246,'N')
;

-- Apr 3, 2022 3:36:11 PM SGT
ALTER TABLE C_BankTransfer ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:11 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213651,0,'Y',0,'Y','N','N',0,'N',7,'N','N','N','Y','229df983-4931-408a-9521-3a38d1b5824f',TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'Y','PayDate','Date Payment made','@#Date@','The Payment Date indicates the date the payment was made.','Payment date','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',1538,15,200246,'N')
;

-- Apr 3, 2022 3:36:11 PM SGT
ALTER TABLE C_BankTransfer ADD PayDate DATE NOT NULL
;

-- Apr 3, 2022 3:36:11 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203248,'From_C_BankAccount_ID',TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'From Bank Account','From Bank Account','ffae87c0-6a8c-4fea-b657-f3c8f7513e46','Y',TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:12 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,Callout,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213652,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','54bd3f1c-2829-4389-8e58-cdf4863892a9',TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'Y','org.compiere.model.CalloutBankTransfer.fromBankAccount','From_C_BankAccount_ID','From Bank Account','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:11','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','FromCBankAccount_CBankTransfer',203248,18,53283,200246,'N')
;

-- Apr 3, 2022 3:36:12 PM SGT
ALTER TABLE C_BankTransfer ADD From_C_BankAccount_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:12 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203250,'From_AD_Org_ID',TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),'From Organization','From Organization','9c178d7b-b7ab-4167-abd3-7163ef7c0e16','Y',TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:12 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213653,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','3aabcbff-584d-4c61-ad44-06bb1aabc8d1',TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),'Y','From_AD_Org_ID','From Organization','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','FromADOrg_CBankTransfer',203250,18,322,200246,'N')
;

-- Apr 3, 2022 3:36:12 PM SGT
ALTER TABLE C_BankTransfer ADD From_AD_Org_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:12 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203252,'From_C_Charge_ID',TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),'From Charge','From Charge','00cfaebd-7719-46c1-b0a6-a9cf74bc1d19','Y',TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:12 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213654,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','10339a06-940e-48d6-b64c-25c580230dc8',TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),'Y','From_C_Charge_ID','From Charge','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:12','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','FromCCharge_CBankTransfer',203252,18,200,200246,'N')
;

-- Apr 3, 2022 3:36:12 PM SGT
ALTER TABLE C_BankTransfer ADD From_C_Charge_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:13 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203255,'From_C_Currency_ID',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'From Bank Currency','From Bank Currency','ce1eaa3a-e011-4fdc-b00d-8a3c5d0a1bf1','Y',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:13 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213655,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','1e12368f-de2b-43a7-a04b-82bc889cee95',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'Y','From_C_Currency_ID','From Bank Currency','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','FromCCurrency_CBankTransfer',203255,18,112,200246,'N')
;

-- Apr 3, 2022 3:36:13 PM SGT
ALTER TABLE C_BankTransfer ADD From_C_Currency_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:13 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203256,'From_Amt',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'From Amount','From Amount','82313f14-1073-4d88-9aba-dfd310573c98','Y',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:13 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,Callout,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213656,0,'Y',0,'Y','N','N',0,'N',14,'N','N','N','Y','0f25fb34-c732-4e93-b58d-f6e7242a2dc4',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'Y','org.compiere.model.CalloutBankTransfer.rate','From_Amt','From Amount','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203256,12,200246,'N')
;

-- Apr 3, 2022 3:36:13 PM SGT
ALTER TABLE C_BankTransfer ADD From_Amt NUMBER NOT NULL
;

-- Apr 3, 2022 3:36:13 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203249,'To_C_BankAccount_ID',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'To Bank Account','To Bank Account','5c697abc-9ca1-4cc2-bb0a-7dee2c60d6d1','Y',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:13 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,Callout,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213657,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','d3cf8a23-d4f3-4b05-8236-d7a12d66a35f',TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'Y','org.compiere.model.CalloutBankTransfer.toBankAccount','To_C_BankAccount_ID','To Bank Account','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:13','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','ToCBankAccount_CBankTransfer',203249,18,53283,200246,'N')
;

-- Apr 3, 2022 3:36:14 PM SGT
ALTER TABLE C_BankTransfer ADD To_C_BankAccount_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:14 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203251,'To_AD_Org_ID',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),'To Organization','To Organization','82b558ac-8633-4f13-bf3d-b10bc08edf88','Y',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:14 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213658,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','4d793b89-195b-48e4-bf8c-ca14bfc4a3ac',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),'Y','To_AD_Org_ID','To Organization','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','ToADOrg_CBankTransfer',203251,18,322,200246,'N')
;

-- Apr 3, 2022 3:36:14 PM SGT
ALTER TABLE C_BankTransfer ADD To_AD_Org_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:14 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203253,'To_C_Charge_ID',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),'To Charge','To Charge','048dd4f0-a55f-42f2-ac75-507f28c761d3','Y',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:14 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213659,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','d5f7be8b-1838-47f2-8dd0-2f1ab239e6ab',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),'Y','To_C_Charge_ID','To Charge','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','ToCCharge_CBankTransfer',203253,18,200,200246,'N')
;

-- Apr 3, 2022 3:36:14 PM SGT
ALTER TABLE C_BankTransfer ADD To_C_Charge_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:15 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203254,'To_C_Currency_ID',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),'To Bank Currency','To Bank Currency','40891c62-0944-4c81-921f-04de21297882','Y',TO_DATE('2022-04-03 15:36:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:15 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,IsToolbarButton) VALUES (213660,0,'Y',0,'Y','N','N',0,'N',10,'N','N','N','Y','7de3a796-6e6e-4181-8a67-8385e79468b9',TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'Y','To_C_Currency_ID','To Bank Currency','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','ToCCurrency_CBankTransfer',203254,18,112,200246,'N')
;

-- Apr 3, 2022 3:36:15 PM SGT
ALTER TABLE C_BankTransfer ADD To_C_Currency_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:15 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203257,'To_Amt',TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'To Amount','To Amount','0ca8d71b-eaf7-444d-b5d0-e23d79b96e30','Y',TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Apr 3, 2022 3:36:15 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,Callout,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213661,0,'Y',0,'Y','N','N',0,'N',14,'N','N','N','Y','5a5a3acf-d42d-4422-aab0-9d8480f9ade2',TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'Y','org.compiere.model.CalloutBankTransfer.rate','To_Amt','To Amount','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',203257,12,200246,'N')
;

-- Apr 3, 2022 3:36:15 PM SGT
ALTER TABLE C_BankTransfer ADD To_Amt NUMBER NOT NULL
;

-- Apr 3, 2022 3:36:15 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,Callout,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213662,0,'Y',0,'Y','N','N',0,'N',14,'N','N','N','Y','b51589b0-c7e6-4ccd-9321-3d978f1d5a83',TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'Y','org.compiere.model.CalloutBankTransfer.amount','Rate','Rate or Tax or Exchange','The Rate indicates the percentage to be multiplied by the source to arrive at the tax or exchange amount.','Rate','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N',534,22,200246,'N')
;

-- Apr 3, 2022 3:36:15 PM SGT
ALTER TABLE C_BankTransfer ADD Rate NUMBER NOT NULL
;

-- Apr 3, 2022 3:36:15 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213663,0,'Y',0,'Y','N','N',0,'N',22,'N','N','N','Y','f5db0837-7065-4a4b-983a-7623071658e6',TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'Y','C_BPartner_ID','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Business Partner ','N','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','CBPartner_CBankTransfer',187,30,200246,'N')
;

-- Apr 3, 2022 3:36:15 PM SGT
ALTER TABLE C_BankTransfer ADD C_BPartner_ID NUMBER(10) NOT NULL
;

-- Apr 3, 2022 3:36:15 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213665,0,'Y',0,'N','N','N',0,'N',22,'N','N','N','Y','b9ee8bb7-af77-4cb9-959a-3ca15082f390',TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'Y','C_BankTransfer_ID','Bank Transfer','Bank Transfer','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:15','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','CBankTransfer_CPayment',203246,19,335,'N')
;

-- Apr 3, 2022 3:36:16 PM SGT
ALTER TABLE C_Payment ADD C_BankTransfer_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 3, 2022 3:36:16 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,FKConstraintName,AD_Element_ID,AD_Reference_ID,AD_Table_ID,IsToolbarButton) VALUES (213666,0,'Y',0,'N','N','N',0,'N',22,'N','N','N','Y','ea162240-a0d3-450c-87c0-af7ca15e0194',TO_DATE('2022-04-03 15:36:16','YYYY-MM-DD HH24:MI:SS'),'Y','C_BankTransfer_ID','Bank Transfer','Bank Transfer','Y','Y',100,100,'N',0,0,TO_DATE('2022-04-03 15:36:16','YYYY-MM-DD HH24:MI:SS'),'D','N','N','N','CBankTransfer_CAllocationLine',203246,19,390,'N')
;

-- Apr 3, 2022 3:36:16 PM SGT
ALTER TABLE C_AllocationLine ADD C_BankTransfer_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 3, 2022 3:36:17 PM SGT
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,Processing,AD_Org_ID,Name,Description,AD_Window_ID,AD_Window_UU,IsActive,AD_Client_ID,Updated,CreatedBy,UpdatedBy,EntityType,Created) VALUES ('T','Y','N','N','N',0,'Bank Transfer','Manage Bank Transfer',200105,'51c0dab9-616d-4325-9fb6-172104069b8b','Y',0,TO_DATE('2022-04-03 15:36:17','YYYY-MM-DD HH24:MI:SS'),100,100,'D',TO_DATE('2022-04-03 15:36:17','YYYY-MM-DD HH24:MI:SS'))
;

UPDATE AD_Table SET AD_Window_ID = 200105 WHERE AD_Table_ID = 200246;

-- Apr 3, 2022 3:36:22 PM SGT
INSERT INTO AD_Tab (Processing,SeqNo,IsTranslationTab,IsSortTab,IsReadOnly,HasTree,IsInfoTab,AD_Tab_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,AD_Org_ID,Updated,Name,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,EntityType,AD_Column_ID,AD_Table_ID,TreeDisplayedOn,AD_Window_ID,IsSingleRow,ImportFields) VALUES ('N',30,'N','N','Y','N','N',200257,'N','N',1,'0a31d45f-3444-4272-a722-402008c7e8f2',0,TO_DATE('2022-04-03 15:36:22','YYYY-MM-DD HH24:MI:SS'),'Allocations',100,100,'Y',0,TO_DATE('2022-04-03 15:36:22','YYYY-MM-DD HH24:MI:SS'),'D',213666,390,'M',200105,'N','N')
;

-- Apr 3, 2022 3:36:23 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205707,'N',26,'N','N',0,'Y','N','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),'Identifies a Business Partner','Business Partner ','1b616b04-9bd1-4c17-9b1a-75be205708e4','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5494,'D',200257)
;

-- Apr 3, 2022 3:36:23 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205711,'N',1,'N','N',0,'Y','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),'The record is active in the system','Active','8fa65c8a-ef25-4c30-ac48-e6cd92c22b64','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4877,'D',200257)
;

-- Apr 3, 2022 3:36:23 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205723,'N',36,'N','N',0,'Y','N',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),'C_AllocationLine_UU','13730248-401c-49e5-b024-3b744c44fabd','N','N',100,100,'Y','N',1,'N',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',60596,'D',200257)
;

-- Apr 3, 2022 3:36:24 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205708,'N',14,'N','N',0,'Y','N','Allocation of Cash/Payment to Invoice',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),'Allocation Line','Allocation Line','593c12b3-0bbd-47cf-b4b0-ee8217f87457','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:23','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',12331,'D',200257)
;

-- Apr 3, 2022 3:36:24 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205709,'N',1,'N','N',0,'Y','N','The Manual check box indicates if the process will done manually.',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),'This is a manual process','Manual','88e94e4d-a4a8-4474-8660-7a1b2e67fab0','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5520,'D',200257)
;

-- Apr 3, 2022 3:36:24 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205710,'N',26,'N','N',0,'Y','N','The Cash Journal Line indicates a unique line in a cash journal.',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),'Cash Journal Line','Cash Journal Line','192ecdc3-7f62-4d62-9989-10e6fc31e8b4','N','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5210,'D',200257)
;

-- Apr 3, 2022 3:36:24 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205712,'N',14,'N','N',10,'Y','Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),'Client/Tenant for this installation.','Client','5429dc8c-3c76-4897-8c49-78167502182a','Y','N',100,100,'Y','N',10,1,'N',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4875,'D',200257)
;

-- Apr 3, 2022 3:36:24 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205713,'N',14,'Y','N',20,'Y','Y','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),'Organizational entity within client','Organization','66d63286-14f9-4a90-ac6f-f5f3a293fd9b','Y','N','Y',100,100,'Y','Y',20,4,'N',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4876,'D',200257)
;

-- Apr 3, 2022 3:36:25 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205725,'N',22,'N','N',30,'Y','N',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),'Bank Transfer','Bank Transfer','016667a8-04eb-4f7f-af3f-f9ab2be55b71','Y','N',100,100,'Y','Y',140,1,'N',0,TO_DATE('2022-04-03 15:36:24','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213666,'D',200257)
;

-- Apr 3, 2022 3:36:25 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205714,'N',26,'N','N',40,'Y','Y','The Payment is a unique identifier of this payment.',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),'Payment identifier','Payment','09ff16fa-ad75-4fa2-bac4-6160e306fc7f','Y','N','N',100,100,'Y','Y',30,1,'N',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4884,'D',200257)
;

-- Apr 3, 2022 3:36:25 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205724,'N',22,'N','N',50,'Y','N','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),'Additional document charges','Charge','7508db92-aa67-4231-bfb7-928648faa163','Y','N',100,100,'Y','Y',130,4,'N',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',61804,'D',200257)
;

-- Apr 3, 2022 3:36:25 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205715,'N',14,'N','N',60,'Y','Y',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),'Payment allocation','Allocation','e9c9edb9-0882-47d0-9c28-8f9f105af864','Y','N',100,100,'Y','Y',40,1,'N',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4874,'D',200257)
;

-- Apr 3, 2022 3:36:25 PM SGT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (1,205716,'N',14,'Y','N',70,'Y','Y','The Transaction Date indicates the date of the transaction.',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),'Transaction Date','Transaction Date','7527ef10-5256-4215-916f-639f165e607f','Y','N',100,100,'Y','Y',50,4,'N',0,TO_DATE('2022-04-03 15:36:25','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5519,'D',200257)
;

-- Apr 3, 2022 3:36:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205717,'N',26,'N','N',80,'Y','Y','The Invoice Document.',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),'Invoice Identifier','Invoice','2efb4f46-4ca2-4633-9d0e-6c8aa02ccb2a','Y','N',100,100,'Y','Y',60,1,'N',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4882,'D',200257)
;

-- Apr 3, 2022 3:36:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205718,'N',26,'Y','N',90,'Y','Y','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),'Order','Order','a09b8057-4077-44a3-8c24-f5f262b4137d','Y','N',100,100,'Y','Y',70,4,'N',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4883,'D',200257)
;

-- Apr 3, 2022 3:36:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205719,'N',26,'N','N',100,'Y','Y','The Amount indicates the amount for this document line.',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),'Amount in a defined currency','Amount','26f7185d-3b5c-4e04-83e8-d12ab7d7682f','Y','N',100,100,'Y','Y',80,1,'N',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4885,'D',200257)
;

-- Apr 3, 2022 3:36:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205720,'N',26,'N','N',110,'Y','Y','The Discount Amount indicates the discount amount for a document or line.',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),'Calculated amount of discount','Discount Amount','6407bfbd-52ae-435a-bd54-d4c135831a1e','Y','N',100,100,'Y','Y',100,1,'N',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4886,'D',200257)
;

-- Apr 3, 2022 3:36:26 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205721,'N',26,'Y','N',120,'Y','Y','The Write Off Amount indicates the amount to be written off as uncollectible.',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),'Amount to write-off','Write-off Amount','701b7647-7cab-4524-a247-ced60c52858f','Y','N',100,100,'Y','Y',110,4,'N',0,TO_DATE('2022-04-03 15:36:26','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',4887,'D',200257)
;

-- Apr 3, 2022 3:36:27 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205722,'N',26,'N','N',130,'Y','Y','Overpayments (negative) are unallocated amounts and allow you to receive money for more than the particular invoice. 
Underpayments (positive) is a partial payment for the invoice. You do not write off the unpaid amount.',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),'Over-Payment (unallocated) or Under-Payment (partial payment) Amount','Over/Under Payment','fdc223d8-e079-40cd-ad00-29f8feff7749','Y','N',100,100,'Y','Y',120,1,'N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',10762,'D',200257)
;

-- Apr 3, 2022 3:36:27 PM SGT
INSERT INTO AD_Tab (Processing,SeqNo,IsTranslationTab,IsSortTab,IsReadOnly,HasTree,IsInfoTab,AD_Tab_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,AD_Org_ID,Updated,Name,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,EntityType,AD_Table_ID,TreeDisplayedOn,AD_Window_ID,IsSingleRow,ImportFields) VALUES ('N',10,'N','N','N','N','N',200255,'Y','N',0,'9dd2bf7d-8e81-4936-ab6c-a362001c930e',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),'Bank Transfer',100,100,'Y',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),'D',200246,'M',200105,'Y','N')
;

-- Apr 3, 2022 3:36:27 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205691,'N',1,'N','N',0,'Y','N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),'Process Now','f50e1505-fb8f-4aa0-83d9-2a452e09d3ef','N','N',100,100,'Y','Y',70,2,'N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213648,'D',200255)
;

-- Apr 3, 2022 3:36:27 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205704,'N',1,'N','N',0,'Y','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),'The record is active in the system','Active','4ed4b81d-d24c-435d-b4f7-62d74b818ced','N','N',100,100,'Y','Y',200,1,'N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213644,'D',200255)
;

-- Apr 3, 2022 3:36:27 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205688,'N',22,'N','N',0,'Y','N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),'Bank Transfer','Bank Transfer','1bf7d0cd-a8b9-4da5-b09b-dfc5bd79de92','N','N',100,100,'Y','N',1,'N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213645,'D',200255)
;

-- Apr 3, 2022 3:36:27 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205689,'N',36,'N','N',0,'Y','N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),'C_BankTransfer_UU','3e79a568-aa12-43d7-88fa-0360c65a15c4','N','N',100,100,'Y','N',1,'N',0,TO_DATE('2022-04-03 15:36:27','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213646,'D',200255)
;

-- Apr 3, 2022 3:36:28 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205682,'N',22,'N','N',10,'Y','Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),'Client/Tenant for this installation.','Client','5e32c284-6469-4b70-ba06-508f809276aa','Y','N',100,100,'Y','N',1,'N',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213636,'D',200255)
;

-- Apr 3, 2022 3:36:28 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205683,'N',22,'N','N',20,'Y','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),'Organizational entity within client','Organization','33429a36-1d79-44a4-88a2-5b29ad22dba5','Y','N','Y',100,100,'Y','Y',10,4,'N',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213637,'D',200255)
;

-- Apr 3, 2022 3:36:28 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205687,'N',30,'N','N',30,'Y','N','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),'Document sequence number of the document','Document No','ebc1f40f-d4f0-4403-96ed-8c9dd5fd0592','Y','N',100,100,'Y','Y',50,1,'N',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213643,'D',200255)
;

-- Apr 3, 2022 3:36:28 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205684,'N',255,'N','N',40,'Y','N','A description is limited to 255 characters.',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),'Optional short description of the record','Description','aa264b84-eae8-40cf-8455-3bc7aa87ba81','Y','N',100,100,'Y','Y',20,1,'N',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',213640,'D',200255)
;

-- Apr 3, 2022 3:36:28 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205692,'N',7,'N','N',50,'Y','N','The Payment Date indicates the date the payment was made.',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),'Date Payment made','Payment date','016bfc6f-fbc1-4098-9832-b5cb089d7e28','Y','N',100,100,'Y','Y',80,1,'N',0,TO_DATE('2022-04-03 15:36:28','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213651,'D',200255)
;

-- Apr 3, 2022 3:36:29 PM SGT
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,FieldGroupType,EntityType,IsCollapsedByDefault,Updated,Name,AD_FieldGroup_UU,AD_Org_ID,IsActive,UpdatedBy,Created,CreatedBy,AD_Client_ID) VALUES (200024,'C','D','N',TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),'FROM BANK ACCOUNT','b47fea5a-49a3-4834-843f-9b3b7fa46ba5',0,'Y',100,TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Apr 3, 2022 3:36:29 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205693,'N',10,'N','N',60,'Y','N',0,TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),'From Bank Account','415e93c7-762f-4f75-8c81-e5e2e26c76ee','Y','N',100,100,'Y','Y',90,1,'N',0,TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213652,200024,'D',200255)
;

-- Apr 3, 2022 3:36:29 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205694,'N',10,'N','N',70,'Y','N',0,TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),'From Organization','3cf6e977-2189-4c18-b9b8-e527cb69300a','Y','N',100,100,'Y','Y',100,1,'N',0,TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213653,200024,'D',200255)
;

-- Apr 3, 2022 3:36:29 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205695,'N',10,'N','N',80,'Y','N',0,TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),'From Charge','59cb6f01-be29-40e9-95a0-7ce28fd467c3','Y','N',100,100,'Y','Y',110,1,'N',0,TO_DATE('2022-04-03 15:36:29','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213654,200024,'D',200255)
;

-- Apr 3, 2022 3:36:30 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205696,'N',10,'N','N',90,'Y','Y',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),'From Bank Currency','a71a693c-6888-496f-bf82-3df8d12ae999','Y','N',100,100,'Y','Y',120,1,'N',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213655,200024,'D',200255)
;

-- Apr 3, 2022 3:36:30 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205697,'N',14,'N','N',100,'Y','N',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),'From Amount','062aead2-ed82-4430-b9a1-62ecf989c1b3','Y','N',100,100,'Y','Y',130,1,'N',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213656,200024,'D',200255)
;

-- Apr 3, 2022 3:36:30 PM SGT
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,FieldGroupType,EntityType,IsCollapsedByDefault,Updated,Name,AD_FieldGroup_UU,AD_Org_ID,IsActive,UpdatedBy,Created,CreatedBy,AD_Client_ID) VALUES (200025,'C','D','N',TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),'TO BANK ACCOUNT','970e0fcc-13e4-4221-87ed-3ada04c7edb3',0,'Y',100,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Apr 3, 2022 3:36:30 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205698,'N',10,'N','N',110,'Y','N',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),'To Bank Account','d75e5a5a-4aa3-4ce3-a6b8-2ac97531bdb4','Y','N',100,100,'Y','Y',140,1,'N',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213657,200025,'D',200255)
;

-- Apr 3, 2022 3:36:30 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205699,'N',10,'N','N',120,'Y','Y',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),'To Organization','955136a8-f1fb-47ab-848c-36ae66c6b3e0','Y','N',100,100,'Y','Y',150,1,'N',0,TO_DATE('2022-04-03 15:36:30','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213658,200025,'D',200255)
;

-- Apr 3, 2022 3:36:31 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205705,'N',22,'N','N',130,'N','Y','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),'Identifies a Business Partner','To Business Partner ','310bf51e-563c-4d52-a82c-e787bc5d7000','Y','N',100,100,'Y','Y',210,1,'N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213663,200025,'D',200255)
;

-- Apr 3, 2022 3:36:31 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205700,'N',10,'N','N',140,'Y','N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),'To Charge','58afaf8b-0154-421d-a319-00d0a03ec16e','Y','N',100,100,'Y','Y',160,1,'N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213659,200025,'D',200255)
;

-- Apr 3, 2022 3:36:31 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205701,'N',10,'N','N',150,'Y','Y',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),'To Bank Currency','9f956150-709f-459d-9450-396a304d1374','Y','N',100,100,'Y','Y',170,1,'N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213660,200025,'D',200255)
;

-- Apr 3, 2022 3:36:31 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205702,'N',14,'N','N',160,'Y','N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),'To Amount','520c57e3-1ebd-4686-bba3-bef0ff24dc6b','Y','N',100,100,'Y','Y',180,1,'N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213661,200025,'D',200255)
;

-- Apr 3, 2022 3:36:31 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205703,'N',14,'N','N',170,'Y','N','The Rate indicates the percentage to be multiplied by the source to arrive at the tax or exchange amount.',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),'Rate or Tax or Exchange','Rate','09223247-62cd-4e66-b29b-920676ca1f55','Y','N',100,100,'Y','Y',190,1,'N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213662,200025,'D',200255)
;

-- Apr 3, 2022 3:36:31 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205686,'N',2,'N','N',180,'Y','Y','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),'The current status of the document','Document Status','312deb12-129a-4779-b9e2-230b7b0053d7','Y','N',100,100,'Y','Y',40,1,'N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213642,101,'D',200255)
;

-- Apr 3, 2022 3:36:31 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205685,'N',2,'N','N',190,'Y','N','You find the current status in the Document Status field. The options are listed in a popup',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),'The targeted status of the document','Document Action','28c1ecc8-8452-416e-94b5-b06fa620bf9b','Y','N',100,100,'Y','Y',30,5,'N',0,TO_DATE('2022-04-03 15:36:31','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213641,101,'D',200255)
;

-- Apr 3, 2022 3:36:32 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205690,'N',1,'N','N',200,'Y','Y','The Processed checkbox indicates that a document has been processed.',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),'The document has been processed','Processed','d2b11e69-0495-4fa1-9e33-0cd6faa20fc0','Y','N',100,100,'Y','Y',60,2,'N',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213647,101,'D',200255)
;

-- Apr 3, 2022 3:36:32 PM SGT
INSERT INTO AD_Tab (Processing,SeqNo,IsTranslationTab,IsSortTab,IsReadOnly,HasTree,IsInfoTab,AD_Tab_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,AD_Org_ID,Updated,Name,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,Created,EntityType,AD_Column_ID,AD_Table_ID,TreeDisplayedOn,AD_Window_ID,IsSingleRow,ImportFields) VALUES ('N',20,'N','N','Y','N','N',200256,'N','N',1,'653ad893-32d4-4c8f-b7a8-d86b269922fe',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),'Payments',100,100,'Y',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),'D',213665,335,'M',200105,'N','N')
;

-- Apr 3, 2022 3:36:32 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205768,'N',40,'N','N',0,'Y','N','Account Country Name',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),'Country','Account Country','6c82f7e8-2c92-4d36-9374-a2502bab55f4','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',8213,'D',200256)
;

-- Apr 3, 2022 3:36:32 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205749,'N',23,'N','N',0,'Y','N','You find the current status in the Document Status field. The options are listed in a popup',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),'The targeted status of the document','Document Action','608df134-1a0a-4f4e-aa89-18f4b0f674fc','N','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5497,'D',200256)
;

-- Apr 3, 2022 3:36:32 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205741,'N',1,'N','N',0,'Y','N',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),'This is a sales transaction (receipt)','Receipt','c85085b6-7d16-48f0-ad57-20e39e6e9367','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:32','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',6216,'D',200256)
;

-- Apr 3, 2022 3:36:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205781,'N',26,'N','N',0,'Y','N','Overpayments (negative) are unallocated amounts and allow you to receive money for more than the particular invoice. 
Underpayments (positive) is a partial payment for the invoice. You do not write off the unpaid amount.',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Over-Payment (unallocated) or Under-Payment (partial payment) Amount','Over/Under Payment','5d8c65fc-61ce-48ed-aee7-329980773c14','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',7034,'D',200256)
;

-- Apr 3, 2022 3:36:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205742,'N',1,'N','N',0,'Y','N','Overpayments (negative) are unallocated amounts and allow you to receive money for more than the particular invoice. 
Underpayments (positive) is a partial payment for the invoice. You do not write off the unpaid amount.',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Over-Payment (unallocated) or Under-Payment (partial payment)','Over/Under Payment','a785661c-a10d-466f-ba8a-d29e63a917bb','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',7035,'D',200256)
;

-- Apr 3, 2022 3:36:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205737,'N',14,'N','N',0,'Y','N','A Project allows you to track and control internal or external activities.',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Financial Project','Project','217a99c9-1c7e-4d33-a7c7-f46c47f148a1','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8554,'D',200256)
;

-- Apr 3, 2022 3:36:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205785,'N',11,'N','N',0,'Y','N','The Charge Amount indicates the amount for an additional charge.',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Charge Amount','Charge amount','8854eb7d-c74e-44dc-8b44-451960e8014b','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8980,'D',200256)
;

-- Apr 3, 2022 3:36:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205727,'N',20,'N','N',0,'Y','N','The Authorization Code indicates the code returned from the electronic transmission.',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Authorization Code Delayed Capture returned','Authorization Code (DC)','c80e2a2e-a1d4-4630-b274-c7f3a1897380','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8981,'D',200256)
;

-- Apr 3, 2022 3:36:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205748,'N',1,'N','N',0,'Y','N','The Credit Card Verification Code was matched',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Credit Card Verification Code Match','CVV Match','68a7a46a-99ba-4a94-9b41-ca27c35d3c6d','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8982,'D',200256)
;

-- Apr 3, 2022 3:36:33 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205786,'N',20,'N','N',0,'Y','N','The Payment Reference indicates the reference returned from the Credit Card Company for a payment',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Payment Reference Delayed Capture','Reference (DC)','ae5036a8-11f7-40e0-8da1-5a55f4efb2a8','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8983,'D',200256)
;

-- Apr 3, 2022 3:36:34 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205750,'N',60,'N','N',0,'Y','N','Swiped information for Credit Card Presence Transactions',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),'Track 1 and 2 of the Credit Card','Swipe','9030f33b-30c1-4315-a00f-7864a5b46653','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:33','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',8985,'D',200256)
;

-- Apr 3, 2022 3:36:34 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205726,'N',14,'N','N',0,'Y','N','The user defined element displays the optional elements that have been defined for this account combination.',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),'User defined list element #1','User Element List 1','513d84f6-da49-4fec-afb5-09ee6a9b2876','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',9563,'D',200256)
;

-- Apr 3, 2022 3:36:34 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205759,'N',14,'N','N',0,'Y','N','The Campaign defines a unique marketing program.  Projects can be associated with a pre defined Marketing Campaign.  You can then report based on a specific Campaign.',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),'Marketing Campaign','Campaign','d82657e3-6800-4b30-9a4f-a943660bd8c5','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',9564,'D',200256)
;

-- Apr 3, 2022 3:36:34 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205777,'N',14,'N','N',0,'Y','N','The organization which performs or initiates this transaction (for another organization).  The owning Organization may not be the transaction organization in a service bureau environment, with centralized services, and inter-organization transactions.',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),'Performing or initiating organization','Trx Organization','5254cf54-4c29-4e22-8da0-ff957891f504','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',9565,'D',200256)
;

-- Apr 3, 2022 3:36:34 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205732,'N',14,'N','N',0,'Y','N','Activities indicate tasks that are performed and used to utilize Activity based Costing',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),'Business Activity','Activity','6b8c3d7b-4805-487d-9bbb-e0087e48fa1c','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',9566,'D',200256)
;

-- Apr 3, 2022 3:36:34 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205746,'N',14,'N','N',0,'Y','N','The user defined element displays the optional elements that have been defined for this account combination.',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),'User defined list element #2','User Element List 2','6deff4c1-e1de-46b5-a86c-c9325e9fe9b5','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',9567,'D',200256)
;

-- Apr 3, 2022 3:36:34 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205784,'N',14,'N','N',0,'Y','N','The Currency Conversion Rate Type lets you define different type of rates, e.g. Spot, Corporate and/or Sell/Buy rates.',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),'Currency Conversion Rate Type','Currency Type','54a9730f-aaff-4894-8759-c3286bfac890','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:34','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',10265,'D',200256)
;

-- Apr 3, 2022 3:36:35 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205764,'N',60,'N','N',0,'Y','N','A description is limited to 255 characters.',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),'Optional short description of the record','Description','ef9907b3-d041-47ae-8568-3aeafe99674f','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',12127,'D',200256)
;

-- Apr 3, 2022 3:36:35 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205762,'N',14,'N','N',0,'Y','N','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),'Accounting Date','Account Date','a84bf55c-053b-4b76-93fe-6dc74cee1764','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',12128,'D',200256)
;

-- Apr 3, 2022 3:36:35 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205734,'N',26,'N','N',0,'Y','N','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),'Order','Order','702d31fd-8a72-432a-b165-40f16743c0ff','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',12925,'D',200256)
;

-- Apr 3, 2022 3:36:35 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205740,'N',1,'N','N',0,'Y','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),'The record is active in the system','Active','4c6c513f-d16c-464a-9215-d37a51d5b48d','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3864,'D',200256)
;

-- Apr 3, 2022 3:36:35 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205780,'N',14,'N','N',0,'Y','N','The Credit Card drop down list box is used for selecting the type of Credit Card presented for payment.',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),'Credit Card (Visa, MC, AmEx)','Credit Card','55ace314-5aab-41be-8095-fe55f548482f','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3869,'D',200256)
;

-- Apr 3, 2022 3:36:35 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205728,'N',20,'N','N',0,'Y','N','The Credit Card number indicates the number on the credit card, without blanks or spaces.',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),'Credit Card Number ','Number','a8054e21-5a65-4d52-a85a-82cb17701133','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3870,'D',200256)
;

-- Apr 3, 2022 3:36:36 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205730,'N',11,'N','N',0,'Y','N','The Expiry Month indicates the expiry month for this credit card.',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),'Expiry Month','Exp. Month','a2429bca-2d39-410e-8f89-71a94dcfa29a','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:35','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3871,'D',200256)
;

-- Apr 3, 2022 3:36:36 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205739,'N',11,'N','N',0,'Y','N','The Expiry Year indicates the expiry year for this credit card.',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),'Expiry Year','Exp. Year','eedc8e0f-6c7b-494c-ac91-759534191c42','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3872,'D',200256)
;

-- Apr 3, 2022 3:36:36 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205733,'N',20,'N','N',0,'Y','N','The Bank Routing Number (ABA Number) identifies a legal Bank.  It is used in routing checks and electronic transactions.',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),'Bank Routing Number','Routing No','a3da052d-37b6-4bc5-a07b-3635bb2d92c8','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3873,'D',200256)
;

-- Apr 3, 2022 3:36:36 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205776,'N',20,'N','N',0,'Y','N','The Account Number indicates the Number assigned to this bank account. ',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),'Account Number','Account No','06c51ffc-7266-474d-aeb8-a7ff3be74392','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3874,'D',200256)
;

-- Apr 3, 2022 3:36:36 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205743,'N',1,'N','N',0,'Y','N','The Approved checkbox indicates if this document requires approval before it can be processed.',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),'Indicates if this document requires approval','Approved','c7b1d733-6ce8-47b2-baa2-a881aa3aab04','N','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3875,'D',200256)
;

-- Apr 3, 2022 3:36:36 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205747,'N',23,'N','N',0,'Y','N',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),'Process Now','0a2579e2-2924-4852-8e80-13c021f4d29a','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3877,'D',200256)
;

-- Apr 3, 2022 3:36:36 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205765,'N',1,'N','N',0,'Y','N','The Processed checkbox indicates that a document has been processed.',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),'The document has been processed','Processed','52ef28c6-7b5b-4a24-b152-2f9646c5ba56','N','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:36','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3878,'D',200256)
;

-- Apr 3, 2022 3:36:37 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205767,'N',1,'N','N',0,'Y','N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Payment is reconciled with bank statement','Reconciled','208151ad-143d-4cdf-a20e-66ccf445e1bf','N','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3879,'D',200256)
;

-- Apr 3, 2022 3:36:37 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205760,'N',20,'N','N',0,'Y','N','The Zip Code of the Credit Card or Account Holder.',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Zip Code of the Credit Card or Account Holder','Account Zip/Postal','09a5d3f4-c168-4fcf-b034-e444aca91e2c','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5026,'D',200256)
;

-- Apr 3, 2022 3:36:37 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205778,'N',20,'N','N',0,'Y','N','The Driver''s License being used as identification.',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Payment Identification - Driver License','Driver License','d629b0e2-6fef-4fde-9627-90867f1d1811','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5027,'D',200256)
;

-- Apr 3, 2022 3:36:37 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205729,'N',20,'N','N',0,'Y','N','The Social Security number being used as identification.',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Payment Identification - Social Security No','Social Security No','d445c769-c379-41bf-8156-829aa1deb228','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5028,'D',200256)
;

-- Apr 3, 2022 3:36:37 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205770,'N',40,'N','N',0,'Y','N','The EMail Address indicates the EMail address off the Credit Card or Account holder.',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Email Address','Account EMail','d3045ae3-54ad-458a-acbe-fbb1b61ed6d8','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5029,'D',200256)
;

-- Apr 3, 2022 3:36:37 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205736,'N',20,'N','N',0,'Y','N','The Voice Authorization Code indicates the code received from the Credit Card Company.',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Voice Authorization Code from credit card company','Voice authorization code','d0044758-49f8-4e6c-8ba3-1d666735cf50','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5030,'D',200256)
;

-- Apr 3, 2022 3:36:37 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205774,'N',20,'N','N',0,'Y','N','The Original Transaction ID is used for reversing transactions and indicates the transaction that has been reversed.',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Original Transaction ID','Original Transaction ID','ba1cfd1d-3d4d-4c46-be48-d0195bc22be2','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5031,'D',200256)
;

-- Apr 3, 2022 3:36:38 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205772,'N',60,'N','N',0,'Y','N','The PO Number indicates the number assigned to a purchase order',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),'Purchase Order Number','PO Number','04f3a27d-c383-4cf3-a1f2-027ae1a88396','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:37','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5032,'D',200256)
;

-- Apr 3, 2022 3:36:38 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205752,'N',26,'N','N',0,'Y','N','The Tax Amount displays the total tax amount for a document.',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),'Tax Amount for a document','Tax Amount','021438af-aa77-4b6f-b9a7-551a8ccffb63','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5034,'D',200256)
;

-- Apr 3, 2022 3:36:38 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205779,'N',20,'N','N',0,'Y','N','The Payment Reference indicates the reference returned from the Credit Card Company for a payment',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),'Payment reference','Reference','672498b6-a544-4283-958c-f789fe028cff','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5035,'D',200256)
;

-- Apr 3, 2022 3:36:38 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205754,'N',20,'N','N',0,'Y','N','The Response Result indicates the result of the transmission to the Credit Card Company.',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),'Result of transmission','Result','542bc75b-f709-457c-af2d-00c7f4e554a7','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5036,'D',200256)
;

-- Apr 3, 2022 3:36:38 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205773,'N',60,'N','N',0,'Y','N','The Response Message indicates the message returned from the Credit Card Company as the result of a transmission',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),'Response message','Response Message','d8a5f4e4-be8f-45d4-9ea2-b95a400e70b3','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5037,'D',200256)
;

-- Apr 3, 2022 3:36:38 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205787,'N',20,'N','N',0,'Y','N','The Authorization Code indicates the code returned from the electronic transmission.',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),'Authorization Code returned','Authorization Code','3b8c15bd-4c87-4d55-a411-98b532d8da13','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5038,'D',200256)
;

-- Apr 3, 2022 3:36:39 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205751,'N',14,'N','N',0,'Y','N','The Address Verified indicates if the address has been verified by the Credit Card Company.',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),'This address has been verified','Address verified','a54b8a40-b8cb-49ba-ab2a-597c279f32dc','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:38','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5039,'D',200256)
;

-- Apr 3, 2022 3:36:39 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205758,'N',14,'N','N',0,'Y','N','The Zip Verified indicates if the zip code has been verified by the Credit Card Company.',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),'The Zip Code has been verified','Zip verified','490d8382-6b0a-4efa-a15b-1ae27354f1a3','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5040,'D',200256)
;

-- Apr 3, 2022 3:36:39 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205753,'N',60,'N','N',0,'Y','N','The Info indicates any response information returned from the Credit Card Company.',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),'Response info','Info','7ae317cd-e561-455f-8b25-ee2826eb4068','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5041,'D',200256)
;

-- Apr 3, 2022 3:36:39 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205766,'N',23,'N','N',0,'Y','N','The Posted field indicates the status of the Generation of General Ledger Accounting Lines ',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),'Posting status','Posted','9066ba6a-d4ae-421b-a918-45006dfee177','N','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5042,'D',200256)
;

-- Apr 3, 2022 3:36:39 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205738,'N',14,'N','N',0,'Y','N','The Transaction Type indicates the type of transaction to be submitted to the Credit Card Company.',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),'Type of credit card transaction','Transaction Type','fb95adc2-4bd3-474b-9417-278baa31cf8f','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5044,'D',200256)
;

-- Apr 3, 2022 3:36:39 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205735,'N',14,'N','N',0,'Y','N','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),'Method of Payment','Tender type','8838975a-c7bc-41a1-9910-df82dbc10dae','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:39','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5046,'D',200256)
;

-- Apr 3, 2022 3:36:40 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205756,'N',5,'N','N',0,'Y','N','The Credit Card Verification indicates the verification code on the credit card (AMEX 4 digits on front; MC,Visa 3 digits back)',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),'Credit Card Verification code on credit card','Verification Code','d8d28658-e60a-46c7-a601-d23c623fa3f7','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5047,'D',200256)
;

-- Apr 3, 2022 3:36:40 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205763,'N',20,'N','N',0,'Y','N','The Micr number is the combination of the bank routing number, account number and check number',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),'Combination of routing no, account and check no','Micr','697ad970-8d4d-46cc-82d5-2a67e55f9cf5','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5048,'D',200256)
;

-- Apr 3, 2022 3:36:40 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205731,'N',20,'N','N',0,'Y','N','The Check Number indicates the number on the check.',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),'Check Number','Check No','05b3a699-ffae-488b-a8fc-3cfc928a4049','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5049,'D',200256)
;

-- Apr 3, 2022 3:36:40 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205771,'N',60,'N','N',0,'Y','N','The Name of the Credit Card or Account holder.',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),'Name on Credit Card or Account holder','Account Name','f19bdcde-1175-42b4-8e1a-44e87cc5442c','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5050,'D',200256)
;

-- Apr 3, 2022 3:36:40 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205761,'N',60,'N','N',0,'Y','N','The Street Address of the Credit Card or Account holder.',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),'Street address of the Credit Card or Account holder','Account Street','6401dfba-6063-49f6-98c6-bfc63150d426','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:40','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5051,'D',200256)
;

-- Apr 3, 2022 3:36:41 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205769,'N',60,'N','N',0,'Y','N','The Account City indicates the City of the Credit Card or Account holder',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),'City or the Credit Card or Account Holder','Account City','f47a060a-39f5-406b-bc1e-a84e068f18f7','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5052,'D',200256)
;

-- Apr 3, 2022 3:36:41 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205755,'N',40,'N','N',0,'Y','N','The State of the Credit Card or Account holder',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),'State of the Credit Card or Account holder','Account State','9168fbe7-2a3e-44ab-95f7-c62cfe23e890','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),5,1,'N','N',5053,'D',200256)
;

-- Apr 3, 2022 3:36:41 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205782,'N',14,'N','N',0,'Y','N','The Partner Bank Account identifies the bank account to be used for this Business Partner',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),'Bank Account of the Business Partner','Partner Bank Account','3345fb12-aa35-4135-a982-79e0a75da22b','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5298,'D',200256)
;

-- Apr 3, 2022 3:36:41 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205757,'N',14,'N','N',0,'Y','N','Electronic Fund Transfer Payment Batch.',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),'Payment batch for EFT','Payment Batch','29f32565-a880-48a2-bc2f-456a2df048ee','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5300,'D',200256)
;

-- Apr 3, 2022 3:36:41 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205745,'N',23,'N','N',0,'Y','N','The Online Processing indicates if the payment can be processed online.',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),'This payment can be processed online','Online Processing','60846af7-7fee-4e20-a9a5-2a8e36a5cb11','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5356,'D',200256)
;

-- Apr 3, 2022 3:36:42 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205783,'N',26,'N','N',0,'Y','N','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),'Identifies a Business Partner','Business Partner ','3ac1b29b-0a9a-4d13-aa1d-09daf9e220f3','N','N',100,100,'Y','N',0,1,'N',0,TO_DATE('2022-04-03 15:36:41','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5398,'D',200256)
;

-- Apr 3, 2022 3:36:42 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205744,'N',1,'N','N',0,'Y','N','The Allocated checkbox indicates if a payment has been allocated or associated with an invoice or invoices.',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),'Indicates if the payment has been allocated','Allocated','5b94a691-7754-4d8a-96b6-a04d829f335e','N','N','N',100,100,'Y','N',0,2,'N',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5400,'D',200256)
;

-- Apr 3, 2022 3:36:42 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205789,'N',14,'N','N',10,'Y','Y','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),'Client/Tenant for this installation.','Client','c2086938-8d0c-4b81-b350-1b9ca2245f4b','Y','N',100,100,'Y','N',10,1,'N',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3862,'D',200256)
;

-- Apr 3, 2022 3:36:42 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205790,'N',14,'Y','N',20,'Y','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),'Organizational entity within client','Organization','0ccb8e64-cecc-4746-906b-0e3e34ac3960','Y','N','Y',100,100,'Y','Y',20,4,'N',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3863,'D',200256)
;

-- Apr 3, 2022 3:36:42 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205805,'N',22,'N','N',30,'Y','N',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),'Bank Transfer','Bank Transfer','5442de08-5247-4674-9878-443e70da4c93','Y','N',100,100,'Y','Y',30,1,'N',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213665,'D',200256)
;

-- Apr 3, 2022 3:36:42 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Reference_ID,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205804,'N',14,'N','N',40,'Y','N','The Payment is a unique identifier of this payment.',19,0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),'Payment identifier','Payment','e7fe9d2c-1e8f-44cd-8ae4-23c85c1a3296','Y','N',100,100,'Y','Y',40,1,'N',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5043,'D',200256)
;

-- Apr 3, 2022 3:36:43 PM SGT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (1,205791,'N',14,'N','N',50,'Y','N','The Document Type determines document sequence and processing rules',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),'Document type or rules','Document Type','619d60ea-1e02-482d-ae5a-f0f6786d2785','Y','N',100,100,'Y','Y',50,1,'N',0,TO_DATE('2022-04-03 15:36:42','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5302,'D',200256)
;

-- Apr 3, 2022 3:36:43 PM SGT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (2,205792,'N',20,'Y','N',60,'Y','N','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),'Document sequence number of the document','Document No','6e977e87-4de5-4f03-9724-c3f413a23de9','Y','N','N',100,100,'Y','Y',60,4,'N',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5401,'D',200256)
;

-- Apr 3, 2022 3:36:43 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205793,'N',14,'N','N',70,'Y','N','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),'The current status of the document','Document Status','630976ef-1e8b-4518-b7fa-c32e6aa219d7','Y','N','N',100,100,'Y','Y',70,1,'N',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5496,'D',200256)
;

-- Apr 3, 2022 3:36:43 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205794,'N',1,'Y','N',80,'Y','N','Self-Service allows users to enter data or update their data.  The flag indicates, that this record was entered or created via Self-Service or that the user can change it via the Self-Service functionality.',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),'This is a Self-Service entry or this entry can be changed via Self-Service','Self-Service','ee319c28-e36b-4903-8c05-4adbb405f747','Y','N','N',100,100,'Y','Y',80,5,'N',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8775,'D',200256)
;

-- Apr 3, 2022 3:36:43 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205795,'N',14,'N','N',90,'Y','N','The Transaction Date indicates the date of the transaction.',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),'Transaction Date','Transaction Date','f41ec72a-752f-44f3-978f-e8b68d50cd1b','Y','N',100,100,'Y','Y',90,1,'N',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5399,'D',200256)
;

-- Apr 3, 2022 3:36:43 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205796,'N',14,'N','N',100,'Y','N','The Bank Account identifies an account at this Bank.',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),'Account at the Bank','Bank Account','5c33d659-8621-4399-9c32-f2f686c68797','Y','N',100,100,'Y','Y',100,1,'N',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',3880,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205797,'N',1,'Y','N',110,'Y','N','The Online Access check box indicates if the application can be accessed via the web. ',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),'Can be accessed online ','Online Access','c63ff3d4-8b9e-497c-b8c3-959f9baddf90','Y','N',100,100,'Y','Y',110,5,'N',0,TO_DATE('2022-04-03 15:36:43','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5495,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205798,'N',14,'N','N',120,'Y','N','Indicates the Currency to be used when processing or reporting on this record',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),'The Currency for this record','Currency','1b5d6316-d711-4830-85d7-4c1a447b4765','Y','N',100,100,'Y','Y',120,1,'N',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5299,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205799,'N',26,'Y','N',130,'Y','N','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),'Amount being paid','Payment amount','2035e35b-fda1-44e6-814b-b8a245f5b4b3','Y','N',100,100,'Y','Y',130,4,'N',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5303,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205800,'N',26,'N','N',140,'Y','N','The Discount Amount indicates the discount amount for a document or line.',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),'Calculated amount of discount','Discount Amount','3f9dfbf6-5f1e-45fe-9966-816f08c0ada2','Y','N',100,100,'Y','Y',140,1,'N',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5301,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205801,'N',26,'Y','N',150,'Y','N','The Write Off Amount indicates the amount to be written off as uncollectible.',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),'Amount to write-off','Write-off Amount','2b23d79d-9cb2-425b-b977-27c0e16b2851','Y','N',100,100,'Y','Y',150,4,'N',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',6475,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205788,'N',1,'N','N',160,'Y','N','Payments not allocated to an invoice with a charge are posted to Unallocated Payments. When setting this flag, the payment is posted to the Customer or Vendor Prepayment account.',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),'The Payment/Receipt is a Prepayment','Prepayment','8a6d8465-103a-412a-8d89-47e8ca0ed449','Y','N',100,100,'Y','Y',160,2,'N',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',13045,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205802,'N',1,'N','N',170,'Y','N','Delayed Capture is required, if you ship products.  The first credit card transaction is the Authorization, the second is the actual transaction after the shipment of the product.',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),'Charge after Shipment','Delayed Capture','745e5274-dee3-4fdc-8a23-70b0686ca1d5','Y','N',100,100,'Y','Y',170,2,'N',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8979,'D',200256)
;

-- Apr 3, 2022 3:36:44 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID) VALUES (205803,'N',26,'N','N',180,'Y','N','The Invoice Document.',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),'Invoice Identifier','Invoice','d91602a6-db35-4ad1-8c8e-720810ba9111','Y','N',100,100,'Y','Y',180,1,'N',0,TO_DATE('2022-04-03 15:36:44','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',5355,104,'D',200256)
;

-- Apr 3, 2022 3:36:45 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205775,'N',14,'N','N',190,'Y','N','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',0,TO_DATE('2022-04-03 15:36:45','YYYY-MM-DD HH24:MI:SS'),'Additional document charges','Charge','b6397959-a7d5-4084-bd3f-cc067bc4bf50','Y','N',100,100,'Y','Y',190,4,'N',0,TO_DATE('2022-04-03 15:36:45','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',8984,'D',200256)
;

-- Apr 3, 2022 3:36:47 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromCBankAccount_CBankTransfer FOREIGN KEY (From_C_BankAccount_ID) REFERENCES c_bankaccount(c_bankaccount_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:47 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromADOrg_CBankTransfer FOREIGN KEY (From_AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:47 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromCCharge_CBankTransfer FOREIGN KEY (From_C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:47 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromCCurrency_CBankTransfer FOREIGN KEY (From_C_Currency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:47 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToCBankAccount_CBankTransfer FOREIGN KEY (To_C_BankAccount_ID) REFERENCES c_bankaccount(c_bankaccount_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:47 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToADOrg_CBankTransfer FOREIGN KEY (To_AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:48 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToCCharge_CBankTransfer FOREIGN KEY (To_C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:48 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToCCurrency_CBankTransfer FOREIGN KEY (To_C_Currency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:48 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT CBPartner_CBankTransfer FOREIGN KEY (C_BPartner_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:48 PM SGT
ALTER TABLE C_Payment ADD CONSTRAINT CBankTransfer_CPayment FOREIGN KEY (C_BankTransfer_ID) REFERENCES c_banktransfer(c_banktransfer_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:36:48 PM SGT
ALTER TABLE C_AllocationLine ADD CONSTRAINT CBankTransfer_CAllocationLine FOREIGN KEY (C_BankTransfer_ID) REFERENCES c_banktransfer(c_banktransfer_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 3, 2022 3:53:21 PM SGT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,AD_Menu_UU,IsSOTrx,IsReadOnly,IsCentrallyMaintained,Name,Description,Action,IsActive,CreatedBy,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,EntityType,AD_Window_ID) VALUES (200160,'N','35705ef9-32eb-4e8a-9795-aef3671b86e4','N','N','Y','Bank Transfer','Bank Transfer let money tranfer between Banks','W','Y',100,0,0,TO_DATE('2022-04-03 15:53:21','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2022-04-03 15:53:21','YYYY-MM-DD HH24:MI:SS'),100,'D',200105)
;

-- Apr 3, 2022 3:53:22 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200160, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=116 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200160)
;

-- Apr 3, 2022 3:53:22 PM SGT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200160, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200160)
;

-- Apr 3, 2022 3:53:44 PM SGT
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200160
;

-- Apr 4, 2022 12:40:52 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203259,'From_TenderType',TO_DATE('2022-04-04 12:40:50','YYYY-MM-DD HH24:MI:SS'),'From Tender Type','From Tender Type','28da5896-63bc-4920-8699-6af5f7acf863','Y',TO_DATE('2022-04-04 12:40:50','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Apr 4, 2022 12:41:05 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203260,'To_TenderType',TO_DATE('2022-04-04 12:41:04','YYYY-MM-DD HH24:MI:SS'),'To Tender Type','To Tender Type','efb5c729-345a-46f2-aaf4-7d3cedc5c3cd','Y',TO_DATE('2022-04-04 12:41:04','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Apr 4, 2022 12:41:36 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213674,0,'N',0,'N','N','N',0,'N',1,'N','N','N','Y','e1154748-dc84-4fd6-b460-369541a6326f',TO_DATE('2022-04-04 12:41:35','YYYY-MM-DD HH24:MI:SS'),'Y','From_TenderType','From Tender Type','Y','Y',100,100,'N',0,TO_DATE('2022-04-04 12:41:35','YYYY-MM-DD HH24:MI:SS'),'N','D','N',203259,214,200246,17,'N',0,'N')
;

-- Apr 4, 2022 12:41:46 PM SGT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2022-04-04 12:41:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213674
;

-- Apr 4, 2022 12:41:49 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200035, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200035)
;

-- Apr 4, 2022 12:42:23 PM SGT
UPDATE AD_Column SET DefaultValue='A',Updated=TO_DATE('2022-04-04 12:42:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213674
;

-- Apr 4, 2022 12:42:26 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200036, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200036)
;

-- Apr 4, 2022 12:42:26 PM SGT
ALTER TABLE C_BankTransfer ADD From_TenderType CHAR(1) DEFAULT 'A' NOT NULL
;

-- Apr 4, 2022 12:42:40 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintType,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213675,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','246cf8c2-bfc0-4176-b36e-5fad9ae50ab4',TO_DATE('2022-04-04 12:42:39','YYYY-MM-DD HH24:MI:SS'),'Y','To_TenderType','D','To Tender Type','Y','Y',100,100,'N',0,TO_DATE('2022-04-04 12:42:39','YYYY-MM-DD HH24:MI:SS'),'N','D','N','N',203260,214,200246,17,'N',0,'N')
;

-- Apr 4, 2022 12:42:49 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200037, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200037)
;

-- Apr 4, 2022 12:42:49 PM SGT
ALTER TABLE C_BankTransfer ADD To_TenderType CHAR(1) DEFAULT 'D' NOT NULL
;

-- Apr 4, 2022 12:43:00 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200038, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200038)
;

-- Apr 4, 2022 12:43:02 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (205810,'N',1,'N','N',210,'Y','N',TO_DATE('2022-04-04 12:43:01','YYYY-MM-DD HH24:MI:SS'),'From Tender Type','cd3dc72c-f932-4e99-976a-396f54cff2d8','Y','N',100,100,'Y','Y',220,0,TO_DATE('2022-04-04 12:43:01','YYYY-MM-DD HH24:MI:SS'),2,213674,'D',200255,0)
;

-- Apr 4, 2022 12:43:02 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (205811,'N',1,'N','N',220,'Y','N',TO_DATE('2022-04-04 12:43:02','YYYY-MM-DD HH24:MI:SS'),'To Tender Type','522939ca-ba14-4bfd-9982-4f0c8a80d82b','Y','N',100,100,'Y','Y',230,0,TO_DATE('2022-04-04 12:43:02','YYYY-MM-DD HH24:MI:SS'),2,213675,'D',200255,0)
;

-- Apr 4, 2022 12:45:14 PM SGT
UPDATE AD_Field SET SeqNo=105, AD_Val_Rule_ID=NULL, SeqNoGrid=135, AD_FieldGroup_ID=200024, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 12:45:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205810
;

-- Apr 4, 2022 12:45:41 PM SGT
UPDATE AD_Field SET SeqNo=175, AD_Val_Rule_ID=NULL, SeqNoGrid=195, AD_FieldGroup_ID=200025, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 12:45:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205811
;

-- Apr 4, 2022 1:20:46 PM SGT
UPDATE AD_Tab SET IsActive='N',Updated=TO_DATE('2022-04-04 13:20:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200257
;

-- Apr 4, 2022 1:22:32 PM SGT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205735
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205784
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205799
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205800
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205801
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205788
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205802
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205803
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205775
;

-- Apr 4, 2022 1:28:34 PM SGT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205735
;

-- Apr 4, 2022 1:28:50 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200039, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200039)
;

-- Apr 4, 2022 1:28:52 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (205812,'N',1,'N','N',220,'Y','N',TO_DATE('2022-04-04 13:28:51','YYYY-MM-DD HH24:MI:SS'),'Override Currency Conversion Rate','Override Currency Conversion Rate','80b1df0f-16ca-4aec-8aa3-9717d3795791','Y','N',100,100,'Y','Y',200,2,0,TO_DATE('2022-04-04 13:28:51','YYYY-MM-DD HH24:MI:SS'),2,213664,'D',200256,0)
;

-- Apr 4, 2022 1:29:59 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200040, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200040)
;

-- Apr 4, 2022 1:30:00 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (205813,'N',22,'N','N',230,'Y','N','The Currency Conversion Rate indicates the rate to use when converting the source currency to the accounting currency',TO_DATE('2022-04-04 13:29:59','YYYY-MM-DD HH24:MI:SS'),'Currency Conversion Rate','Rate','cfdc123c-89a7-4b6d-9b81-582084db2f34','Y','N',100,100,'Y','Y',210,0,TO_DATE('2022-04-04 13:29:59','YYYY-MM-DD HH24:MI:SS'),2,213623,'D',200256,0)
;

-- Apr 4, 2022 1:30:01 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (205814,'N',22,'N','N',240,'Y','N','The Converted Amount is the result of multiplying the Source Amount by the Conversion Rate for this target currency.',TO_DATE('2022-04-04 13:30:00','YYYY-MM-DD HH24:MI:SS'),'Converted Amount','Converted Amount','5943174a-86c5-43f0-ae20-35229f410562','Y','N',100,100,'Y','Y',220,0,TO_DATE('2022-04-04 13:30:00','YYYY-MM-DD HH24:MI:SS'),2,213624,'D',200256,0)
;

-- Apr 4, 2022 1:33:02 PM SGT
UPDATE AD_Field SET SeqNo=130, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205799
;

-- Apr 4, 2022 1:33:02 PM SGT
UPDATE AD_Field SET SeqNo=140, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=1, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205784
;

-- Apr 4, 2022 1:33:03 PM SGT
UPDATE AD_Field SET SeqNo=150, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=2, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205812
;

-- Apr 4, 2022 1:33:03 PM SGT
UPDATE AD_Field SET SeqNo=160, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=1, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205813
;

-- Apr 4, 2022 1:33:03 PM SGT
UPDATE AD_Field SET SeqNo=170, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=4, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205814
;

-- Apr 4, 2022 1:33:03 PM SGT
UPDATE AD_Field SET SeqNo=180, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205800
;

-- Apr 4, 2022 1:33:03 PM SGT
UPDATE AD_Field SET SeqNo=190, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205801
;

-- Apr 4, 2022 1:33:04 PM SGT
UPDATE AD_Field SET SeqNo=200, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=1, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205735
;

-- Apr 4, 2022 1:33:04 PM SGT
UPDATE AD_Field SET SeqNo=210, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205788
;

-- Apr 4, 2022 1:33:04 PM SGT
UPDATE AD_Field SET SeqNo=220, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205802
;

-- Apr 4, 2022 1:33:04 PM SGT
UPDATE AD_Field SET SeqNo=230, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205803
;

-- Apr 4, 2022 1:33:04 PM SGT
UPDATE AD_Field SET SeqNo=240, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205775
;

-- Apr 4, 2022 1:33:31 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=140, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205784
;

-- Apr 4, 2022 1:33:36 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=150, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205812
;

-- Apr 4, 2022 1:33:43 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=160, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205813
;

-- Apr 4, 2022 1:33:48 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=170, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205814
;

-- Apr 4, 2022 1:33:53 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=180, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205800
;

-- Apr 4, 2022 1:33:58 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=190, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:33:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205801
;

-- Apr 4, 2022 1:34:04 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=200, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:34:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205735
;

-- Apr 4, 2022 1:34:09 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=210, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:34:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205788
;

-- Apr 4, 2022 1:34:13 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=220, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:34:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205802
;

-- Apr 4, 2022 1:34:17 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=230, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:34:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205803
;

-- Apr 4, 2022 1:34:23 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, SeqNoGrid=240, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 13:34:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205775
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205784
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205789
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205735
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205790
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205805
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205804
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205791
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205792
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205793
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205794
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205795
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205796
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205797
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205798
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205799
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205812
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205813
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205814
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205800
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205801
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205788
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205802
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205803
;

-- Apr 4, 2022 1:34:37 PM SGT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=SYSDATE, UpdatedBy=100 WHERE AD_Field_ID=205775
;

-- Apr 4, 2022 4:08:27 PM SGT
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:08:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205784
;

-- Apr 4, 2022 4:08:33 PM SGT
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:08:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205812
;

-- Apr 4, 2022 4:08:42 PM SGT
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRate@=Y', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:08:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205813
;

-- Apr 4, 2022 4:08:59 PM SGT
UPDATE AD_Field SET DisplayLogic='@C_Currency_ID@!@$C_Currency_ID@ & @IsOverrideCurrencyRate@=Y', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:08:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205814
;

-- Apr 4, 2022 4:09:14 PM SGT
UPDATE AD_Field SET DisplayLogic='@C_Invoice_ID@^''''', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:09:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205800
;

-- Apr 4, 2022 4:09:21 PM SGT
UPDATE AD_Field SET DisplayLogic='@C_Invoice_ID@^''''', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:09:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205801
;

-- Apr 4, 2022 4:12:01 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, ReadOnlyLogic='@From_Currency_ID@=@To_Currency_ID@', AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:12:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 4, 2022 4:14:00 PM SGT
UPDATE AD_Field SET AD_Val_Rule_ID=NULL, ReadOnlyLogic='@From_C_Currency_ID@=@To_C_Currency_ID@', AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-04-04 16:14:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205703
;

-- Apr 5, 2022 12:44:15 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200048, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200048)
;

-- Apr 5, 2022 12:44:16 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203262,'To_C_BPartner_ID','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',TO_DATE('2022-04-05 12:44:16','YYYY-MM-DD HH24:MI:SS'),'To Business Partner ','Identifies a Business Partner','To Business Partner ','f2bea13f-c82a-45cc-b832-bb7e5c724bc1','Y',TO_DATE('2022-04-05 12:44:16','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Apr 5, 2022 12:44:17 PM SGT
UPDATE AD_Column SET IsSyncDatabase='Y', IsMandatory='N', AD_Process_ID=NULL, ColumnName='To_C_BPartner_ID', Description='Identifies a Business Partner', Help='A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson', Name='To Business Partner ', AD_Chart_ID=NULL, FKConstraintName='ToCBPartner_CBankTransfer', AD_Element_ID=203262, AD_Reference_Value_ID=138, AD_Val_Rule_ID=NULL, PA_DashboardContent_ID=NULL,Updated=TO_DATE('2022-04-05 12:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213663
;

-- Apr 5, 2022 12:44:17 PM SGT
ALTER TABLE C_BankTransfer ADD To_C_BPartner_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 5, 2022 12:44:18 PM SGT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203261,'From_C_BPartner_ID','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',TO_DATE('2022-04-05 12:44:18','YYYY-MM-DD HH24:MI:SS'),'From Business Partner ','Identifies a Business Partner','From Business Partner ','615fc9a3-5c6e-4f49-b57c-799aafac78ca','Y',TO_DATE('2022-04-05 12:44:18','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Apr 5, 2022 12:44:18 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,FKConstraintName,FKConstraintType,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID,IsHtml) VALUES (213676,0,'Y',0,'N','N','N',0,'N',22,'N','N','N','Y','3d00ab13-44c1-40b8-9c66-c988679e5f7a',TO_DATE('2022-04-05 12:44:18','YYYY-MM-DD HH24:MI:SS'),'Y','From_C_BPartner_ID','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','From Business Partner ','N','Y',100,100,'N',0,TO_DATE('2022-04-05 12:44:18','YYYY-MM-DD HH24:MI:SS'),'N','D','N','FromCBPartner_CBankTransfer','N',203261,138,200246,30,'N',0,'N')
;

-- Apr 5, 2022 12:44:18 PM SGT
ALTER TABLE C_BankTransfer ADD From_C_BPartner_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 5, 2022 12:44:18 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,AD_FieldGroup_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (205817,'N',22,'N','N',75,'Y','Y','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',TO_DATE('2022-04-05 12:44:18','YYYY-MM-DD HH24:MI:SS'),'Identifies a Business Partner','From Business Partner ','a852480e-d4f5-49da-adc7-947bf88edc1d','Y','N',100,100,'Y','Y',75,1,'N',0,TO_DATE('2022-04-05 12:44:18','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213676,200024,'D',200255,0)
;

-- Apr 5, 2022 12:44:19 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT ToCBPartner_CBankTransfer FOREIGN KEY (To_C_BPartner_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 5, 2022 12:44:19 PM SGT
ALTER TABLE C_BankTransfer ADD CONSTRAINT FromCBPartner_CBankTransfer FOREIGN KEY (From_C_BPartner_ID) REFERENCES c_bpartner(c_bpartner_id) DEFERRABLE INITIALLY DEFERRED
;

UPDATE C_BankTransfer SET From_C_BPartner_ID=C_BPartner_ID, To_C_BPartner_ID=C_BPartner_ID WHERE From_C_BPartner_ID IS NULL AND To_C_BPartner_ID IS NULL;

ALTER TABLE C_BankTransfer DROP COLUMN C_BPartner_ID;

-- Apr 5, 2022 12:50:45 PM SGT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2022-04-05 12:50:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213676
;

-- Apr 5, 2022 12:50:49 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200049, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200049)
;

-- Apr 5, 2022 12:50:49 PM SGT
ALTER TABLE C_BankTransfer MODIFY From_C_BPartner_ID NUMBER(10)
;

-- Apr 5, 2022 12:50:49 PM SGT
ALTER TABLE C_BankTransfer MODIFY From_C_BPartner_ID NOT NULL
;

-- Apr 5, 2022 12:52:41 PM SGT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2022-04-05 12:52:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213663
;

-- Apr 5, 2022 12:52:44 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200050, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200050)
;

-- Apr 5, 2022 12:52:44 PM SGT
ALTER TABLE C_BankTransfer MODIFY To_C_BPartner_ID NUMBER(10)
;

-- Apr 5, 2022 12:52:44 PM SGT
ALTER TABLE C_BankTransfer MODIFY To_C_BPartner_ID NOT NULL
;

