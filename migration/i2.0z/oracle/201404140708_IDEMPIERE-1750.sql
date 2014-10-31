SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 18, 2014 2:46:09 PM MYT
-- IDEMPIERE-1715 Implement revert action for Production (Single Product)
INSERT INTO AD_Workflow (ValidateWorkflow,Cost,WaitingTime,WorkingTime,AccessLevel,Duration,DurationUnit,IsDefault,IsValid,Limit,Priority,PublishStatus,Version,SetupTime,QtyBatchSize,MovingTime,IsBetaFunctionality,OverlapUnits,UnitsCycles,Yield,QueuingTime,WorkflowType,Value,Name,AD_Workflow_UU,Author,DocumentNo,AD_Workflow_ID,UpdatedBy,Updated,Created,CreatedBy,IsActive,AD_Client_ID,EntityType,AD_Table_ID,AD_Org_ID) VALUES ('N',0,0,0,'1',0,'D','N','N',0,0,'R',0,0,1,0,'N',0,0,100,0,'P','Process_Production','Process_Production','cc9a6ab7-ff24-4c88-b35e-6a67dd76f405','iDempiere','10000000',200002,100,TO_DATE('2014-03-18 14:46:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-18 14:46:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,'D',325,0)
;

-- Mar 18, 2014 2:46:11 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,WaitTime,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,IsMilestone,IsSubcontracting,SplitElement,Action,Description,Value,Name,AD_WF_Node_UU,DynPriorityChange,AD_Workflow_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,DocAction,AD_Client_ID,EntityType,AD_Org_ID) VALUES (200008,0,0,0,0,100,0,0,0,'Y','X',0,0,0,0,'N','N','X','D','(Standard Node)','(DocAuto)','(DocAuto)','a483ae3a-dc85-46e4-a384-a10e7ace85d2',0,200002,TO_DATE('2014-03-18 14:46:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-18 14:46:10','YYYY-MM-DD HH24:MI:SS'),100,'Y','--',0,'D',0)
;

-- Mar 18, 2014 2:46:12 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,WaitTime,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,IsMilestone,IsSubcontracting,SplitElement,Action,Description,Value,Name,AD_WF_Node_UU,DynPriorityChange,AD_Workflow_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,DocAction,AD_Client_ID,EntityType,AD_Org_ID) VALUES (200009,0,0,0,0,100,0,0,0,'Y','X',0,0,0,0,'N','N','X','D','(Standard Node)','(DocComplete)','(DocComplete)','20f82106-add0-454b-8179-5328c1707720',0,200002,TO_DATE('2014-03-18 14:46:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-18 14:46:11','YYYY-MM-DD HH24:MI:SS'),100,'Y','CO',0,'D',0)
;

-- Mar 18, 2014 2:46:13 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,WaitTime,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,IsMilestone,IsSubcontracting,SplitElement,Action,Description,Value,Name,AD_WF_Node_UU,DynPriorityChange,AD_Workflow_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,DocAction,AD_Client_ID,EntityType,AD_Org_ID) VALUES (200010,0,0,0,0,100,0,0,0,'Y','X',0,0,0,0,'N','N','X','D','(Standard Node)','(DocPrepare)','(DocPrepare)','011830f3-4834-4bb1-bebd-5e8d77ca8b5f',0,200002,TO_DATE('2014-03-18 14:46:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-18 14:46:12','YYYY-MM-DD HH24:MI:SS'),100,'Y','PR',0,'D',0)
;

-- Mar 18, 2014 2:46:14 PM MYT
INSERT INTO AD_WF_NodeNext (SeqNo,IsStdUserWorkflow,AD_WF_NodeNext_ID,AD_WF_Node_ID,AD_WF_Next_ID,EntityType,AD_WF_NodeNext_UU,UpdatedBy,CreatedBy,Updated,AD_Org_ID,Created,IsActive,AD_Client_ID) VALUES (10,'N',200007,200010,200009,'D','f765b061-046e-4b00-ad53-db41b8e1d268',100,100,TO_DATE('2014-03-18 14:46:13','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2014-03-18 14:46:13','YYYY-MM-DD HH24:MI:SS'),'N',0)
;

-- Mar 18, 2014 2:46:15 PM MYT
INSERT INTO AD_WF_Node (AD_WF_Node_ID,Cost,YPosition,OverlapUnits,UnitsCycles,Yield,WaitTime,Priority,Duration,IsCentrallyMaintained,JoinElement,Limit,WorkingTime,XPosition,WaitingTime,IsMilestone,IsSubcontracting,SplitElement,Action,Description,Value,Name,AD_WF_Node_UU,DynPriorityChange,AD_Workflow_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,DocAction,AD_Client_ID,EntityType,AD_Org_ID) VALUES (200011,0,0,0,0,100,0,0,0,'Y','X',0,0,0,0,'N','N','X','Z','(Standard Node)','(Start)','(Start)','86125a0c-d0f4-4d26-8ebc-50455547cc87',0,200002,TO_DATE('2014-03-18 14:46:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-18 14:46:14','YYYY-MM-DD HH24:MI:SS'),100,'Y','CO',0,'D',0)
;

-- Mar 18, 2014 2:46:16 PM MYT
INSERT INTO AD_WF_NodeNext (SeqNo,IsStdUserWorkflow,AD_WF_NodeNext_ID,AD_WF_Node_ID,AD_WF_Next_ID,EntityType,AD_WF_NodeNext_UU,UpdatedBy,CreatedBy,Updated,AD_Org_ID,Created,IsActive,AD_Client_ID) VALUES (100,'N',200008,200011,200008,'D','ef08df1e-2dd3-4a68-ae89-c8964c885d90',100,100,TO_DATE('2014-03-18 14:46:15','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2014-03-18 14:46:15','YYYY-MM-DD HH24:MI:SS'),'Y',0)
;

-- Mar 18, 2014 2:46:16 PM MYT
UPDATE AD_Workflow SET IsValid='Y', AD_WF_Node_ID=200011,Updated=TO_DATE('2014-03-18 14:46:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Workflow_ID=200002
;

-- Mar 18, 2014 2:46:20 PM MYT
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,AD_Workflow_ID,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Value,AD_Client_ID) VALUES ('N',200068,'N','N','6ce10946-4f1c-4781-b03a-9da4c7a35faf','1','N','N',0,0,'Y','D','Process Production',200002,0,TO_DATE('2014-03-18 14:46:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-18 14:46:19','YYYY-MM-DD HH24:MI:SS'),'Y',100,'M_Production Process',0)
;

-- Mar 18, 2014 2:46:22 PM MYT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Process_ID) VALUES (0,'Y',0,210983,'N','N','N',0,'N',2,'N','N','N','Y','d94f85cc-ad66-4265-8f6b-6e5818ac0932','Y','DocAction','The targeted status of the document','CO','You find the current status in the Document Status field. The options are listed in a popup','Document Action','Y',TO_DATE('2014-03-18 14:46:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-03-18 14:46:21','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',0,'D','N','N','N',287,28,135,325,200068)
;

-- Mar 18, 2014 2:46:24 PM MYT
ALTER TABLE M_Production ADD (DocAction CHAR(2) DEFAULT 'CO' NOT NULL)
;

-- Mar 18, 2014 2:46:29 PM MYT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,'Y',0,210984,'N','N','N',0,'N',2,'N','N','N','Y','cd901157-2d1c-4fbf-a943-7e64d7f79361','Y','DocStatus','The current status of the document','DR','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','Document Status','Y',TO_DATE('2014-03-18 14:46:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-03-18 14:46:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N','N',289,17,131,325)
;

-- Mar 18, 2014 2:46:29 PM MYT
ALTER TABLE M_Production ADD (DocStatus VARCHAR2(2) DEFAULT 'DR' NOT NULL)
;

UPDATE M_Production set DocAction='CL', DocStatus='CO' WHERE IsCreated='Y' AND Processed='Y'
;

ALTER TABLE M_Production MODIFY M_Locator_ID NUMBER(10) DEFAULT NULL 
;

ALTER TABLE M_Production MODIFY M_Product_ID NUMBER(10) DEFAULT NULL 
;

ALTER TABLE M_ProductionLine MODIFY M_Production_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 14, 2014 3:19:08 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',319,0,'N','N',61943,220,'Y',202849,'N','The Create From process will create a new document based on information in an existing document selected by the user.','D','Process which will generate a new document lines based on an existing document','Create lines from','ee659ab5-c6b5-4057-a00d-f19b72977ca1','Y','N',100,0,TO_DATE('2014-04-14 15:19:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-14 15:19:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',220,2,'N',0,2,1,'N','N')
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=10,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3783
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=20,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3784
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3786
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3787
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3785
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3788
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7817
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7820
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7821
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7818
;

-- Apr 14, 2014 3:20:05 PM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2014-04-14 15:20:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7822
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7819
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3790
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202849
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3791
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5145
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3789
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3782
;

-- Apr 14, 2014 3:20:06 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-04-14 15:20:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202628
;

-- Apr 14, 2014 3:21:19 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',319,0,'N','N',210983,170,'Y',202850,'N','You find the current status in the Document Status field. The options are listed in a popup','D','The targeted status of the document','Document Action','1fc40e46-cfdf-48f1-88da-72e130c33c43','Y','N',100,0,TO_DATE('2014-04-14 15:21:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-14 15:21:13','YYYY-MM-DD HH24:MI:SS'),'Y','Y',230,2,'N',0,2,1,'N','N')
;

-- Apr 14, 2014 3:23:04 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',319,0,'N','N',210984,180,'Y',202851,'Y','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','D','The current status of the document','Document Status','38c5f024-275c-455e-9587-7c9d8da0b031','Y','N',100,0,TO_DATE('2014-04-14 15:22:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-14 15:22:58','YYYY-MM-DD HH24:MI:SS'),'Y','Y',240,4,'N',0,2,1,'N','N')
;

-- Apr 14, 2014 3:29:04 PM MYT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=202850
;

-- Apr 14, 2014 3:29:04 PM MYT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=202851
;

-- Apr 14, 2014 3:29:04 PM MYT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=5145
;

-- Apr 14, 2014 3:30:48 PM MYT
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_DATE('2014-04-14 15:30:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210983
;

-- Apr 14, 2014 3:35:45 PM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2014-04-14 15:35:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59963
;

-- Apr 14, 2014 3:36:36 PM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2014-04-14 15:36:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59962
;

-- Apr 14, 2014 3:38:30 PM MYT
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_DATE('2014-04-14 15:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59752
;

-- Apr 14, 2014 3:38:48 PM MYT
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_DATE('2014-04-14 15:38:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59743
;

-- Apr 14, 2014 3:41:35 PM MYT
UPDATE AD_Column SET AD_Reference_ID=20,Updated=TO_DATE('2014-04-14 15:41:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=61940
;

-- Apr 14, 2014 3:42:07 PM MYT
UPDATE AD_Field SET IsDisplayed='N',Updated=TO_DATE('2014-04-14 15:42:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62016
;

-- Apr 14, 2014 3:42:45 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',53344,0,'N','N',210983,120,'Y',202852,'N','You find the current status in the Document Status field. The options are listed in a popup','D','The targeted status of the document','Document Action','38c18801-8280-447b-a676-f979d35f0e9d','Y','N',100,0,TO_DATE('2014-04-14 15:42:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-14 15:42:38','YYYY-MM-DD HH24:MI:SS'),'Y','Y',130,2,'N',0,2,1,'N','N')
;

-- Apr 14, 2014 3:43:04 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',53344,0,'N','N',210984,260,'Y',202853,'Y','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','D','The current status of the document','Document Status','4dc496c8-6969-4c9d-b94f-63b876ce1999','Y','N',100,0,TO_DATE('2014-04-14 15:43:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-14 15:43:03','YYYY-MM-DD HH24:MI:SS'),'Y','Y',220,1,'N',0,1,1,'N','N')
;

-- Apr 14, 2014 3:43:10 PM MYT
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2014-04-14 15:43:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202853
;

-- Apr 14, 2014 4:26:11 PM MYT
-- IDEMPIERE-1715 Implement revert action for Production (Single Product)
UPDATE AD_Field SET SeqNo=120, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-04-14 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59756
;

-- Apr 14, 2014 4:26:11 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2014-04-14 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202852
;

-- Apr 14, 2014 4:26:11 PM MYT
UPDATE AD_Field SET SeqNo=230, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2014-04-14 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202853
;

-- Apr 14, 2014 4:26:11 PM MYT
UPDATE AD_Field SET SeqNo=240,Updated=TO_DATE('2014-04-14 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59749
;

-- Apr 14, 2014 4:26:11 PM MYT
UPDATE AD_Field SET SeqNo=250,Updated=TO_DATE('2014-04-14 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59748
;

-- Apr 14, 2014 4:26:11 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-04-14 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62016
;

-- Apr 14, 2014 4:26:11 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2014-04-14 16:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202629
;

-- Apr 14, 2014 4:27:56 PM MYT
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2014-04-14 16:27:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202849
;

-- Apr 14, 2014 4:27:56 PM MYT
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-04-14 16:27:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3791
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=90, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202850
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7817
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7820
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7821
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7818
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7822
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7819
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3790
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=170, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202851
;

-- Apr 14, 2014 4:27:57 PM MYT
UPDATE AD_Field SET SeqNo=180, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2014-04-14 16:27:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5145
;

-- Apr 14, 2014 4:28:14 PM MYT
UPDATE AD_Field SET AD_FieldGroup_ID=101,Updated=TO_DATE('2014-04-14 16:28:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202851
;

-- Apr 14, 2014 4:28:25 PM MYT
UPDATE AD_Field SET AD_FieldGroup_ID=101,Updated=TO_DATE('2014-04-14 16:28:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5145
;

-- Apr 14, 2014 4:29:31 PM MYT
UPDATE AD_Field SET AD_FieldGroup_ID=101,Updated=TO_DATE('2014-04-14 16:29:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202853
;

-- Apr 14, 2014 4:34:59 PM MYT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,EntityType) VALUES (0,'N',319,0,'N','N',59961,190,'Y',202854,'N','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Document sequence number of the document','Document No','d4f0dde6-f83a-4fa1-9645-b769c2fc9b0e','Y','N',100,0,TO_DATE('2014-04-14 16:34:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-04-14 16:34:53','YYYY-MM-DD HH24:MI:SS'),'Y','Y',250,1,'N',0,2,1,'N','N','D')
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202854
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3786
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3787
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3785
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3788
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202849
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3791
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202850
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7817
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7820
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7821
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7818
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7822
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7819
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3790
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=180,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202851
;

-- Apr 14, 2014 4:35:41 PM MYT
UPDATE AD_Field SET SeqNo=190, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2014-04-14 16:35:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5145
;

-- Apr 14, 2014 4:40:26 PM MYT
UPDATE AD_Window SET IsActive='N',Updated=TO_DATE('2014-04-14 16:40:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=191
;

-- Apr 14, 2014 4:40:26 PM MYT
UPDATE AD_Menu SET Name='Production', Description='Production based on Bill of Materials', IsActive='N',Updated=TO_DATE('2014-04-14 16:40:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=228
;

-- Apr 14, 2014 4:45:18 PM MYT
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (200080,'M_Production','D','25b245ad-6b82-42c5-a1dd-bea8fb43556b','N','T',0,100,TO_DATE('2014-04-14 16:45:12','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2014-04-14 16:45:12','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Apr 14, 2014 4:45:47 PM MYT
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Ref_Table_UU,CreatedBy,Updated,Created,UpdatedBy,AD_Org_ID,IsActive,AD_Client_ID,EntityType,AD_Display,AD_Key,AD_Reference_ID,AD_Table_ID) VALUES ('N','ba10e596-5065-48e6-932c-337e19726661',100,TO_DATE('2014-04-14 16:45:47','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-04-14 16:45:47','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0,'D',59961,3596,200080,325)
;

-- Apr 14, 2014 4:46:17 PM MYT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID) VALUES (0,'N',1,211207,'N','N','N',0,'N',10,'N',18,'N','N','Y','e2c52b19-8de8-40cd-8738-283bd9f1f351','N','Reversal_ID','ID of document reversal','Reversal ID','Y',TO_DATE('2014-04-14 16:46:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-04-14 16:46:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N','N',53457,200080,325)
;

-- Apr 15, 2014 12:13:29 AM MYT
-- IDEMPIERE-1715 Implement revert action for Production (Single Product)
UPDATE AD_Column SET FKConstraintName='Reversal_MProduction', FKConstraintType='N',Updated=TO_DATE('2014-04-15 00:13:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211207
;

-- Apr 15, 2014 12:13:29 AM MYT
ALTER TABLE M_Production ADD Reversal_ID NUMBER(10) DEFAULT NULL 
;

-- Apr 15, 2014 12:13:30 AM MYT
ALTER TABLE M_Production ADD CONSTRAINT Reversal_MProduction FOREIGN KEY (Reversal_ID) REFERENCES m_production(m_production_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2014 12:14:43 AM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2014-04-15 00:14:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59960
;

-- Apr 15, 2014 12:15:32 AM MYT
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_DATE('2014-04-15 00:15:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59770
;

-- Apr 15, 2014 12:16:37 AM MYT
UPDATE AD_Field SET IsMandatory='Y',Updated=TO_DATE('2014-04-15 00:16:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3809
;

-- Apr 15, 2014 12:36:25 PM MYT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2014-04-15 12:36:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211207
;

SELECT register_migration_script('201404140708_IDEMPIERE-1750.sql') FROM dual
;

