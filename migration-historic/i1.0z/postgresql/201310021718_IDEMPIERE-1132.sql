-- Oct 1, 2013 6:48:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('FKConstraintName',202612,'Constraint Name','Constraint Name','9927b271-3c97-46dc-93fc-043546b66484',TO_TIMESTAMP('2013-10-01 18:48:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-01 18:48:25','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Oct 1, 2013 6:48:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('FKConstraintType',202613,'Constraint Type','Constraint Type','8cb693d1-8944-4e2d-9d9b-98699d9716ec',TO_TIMESTAMP('2013-10-01 18:48:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-01 18:48:37','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'U')
;

-- Oct 1, 2013 6:48:42 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Element SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-01 18:48:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202613
;

-- Oct 1, 2013 6:49:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,101,210871,'N','N','N',0,'N',30,'Y',10,'N','N','Y','27ff3582-9db8-40d3-869f-9ea75b4dd281','Y','FKConstraintName','Constraint Name','Y',TO_TIMESTAMP('2013-10-01 18:49:25','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-10-01 18:49:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202612,'N')
;

-- Oct 1, 2013 6:50:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
ALTER TABLE AD_Column ADD COLUMN FKConstraintName VARCHAR(30) DEFAULT NULL 
;

-- Oct 1, 2013 6:51:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (200075,'Foreign Key Constraint Type','D','f5f359ae-d6a9-43fa-a1c6-119ed6c1f201','N','L',0,100,TO_TIMESTAMP('2013-10-01 18:51:20','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2013-10-01 18:51:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Oct 1, 2013 6:52:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200161,200075,'Do Not Create','ad2bedf7-814f-4b7d-ae4e-dac0a8a406f6','D',TO_TIMESTAMP('2013-10-01 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:52:31','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Oct 1, 2013 6:53:12 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200162,200075,'No Action','49ed557e-0170-4594-a65d-fae6e895ffde','N',TO_TIMESTAMP('2013-10-01 18:53:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:53:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'U')
;

-- Oct 1, 2013 6:53:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-01 18:53:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200162
;

-- Oct 1, 2013 6:53:33 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200163,200075,'Cascade','e3ef6ea1-87c4-4141-9f5a-882741a167cd','C',TO_TIMESTAMP('2013-10-01 18:53:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:53:32','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Oct 1, 2013 6:53:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200164,200075,'Set Null','324b9a18-fc1f-44ba-a1ce-c83e63c7b63b','S',TO_TIMESTAMP('2013-10-01 18:53:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:53:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Oct 1, 2013 6:54:05 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,101,210872,200075,'N','N','N',0,'N',1,'N',17,'N','N','Y','5eb50488-f159-46d9-b6e3-aa83ef44fc6d','Y','FKConstraintType','Constraint Type','Y',TO_TIMESTAMP('2013-10-01 18:54:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-10-01 18:54:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'U','N',202613,'N')
;

-- Oct 1, 2013 6:54:09 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-01 18:54:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210872
;

-- Oct 1, 2013 6:54:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
ALTER TABLE AD_Column ADD COLUMN FKConstraintType CHAR(1) DEFAULT NULL 
;

-- Oct 1, 2013 6:54:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',101,36,'N','N',60388,440,'Y',202517,'N','D','AD_Column_UU','e9b392b1-3b5a-41c4-a7b7-4c67a425a034','N','N',100,0,TO_TIMESTAMP('2013-10-01 18:54:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:54:53','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Oct 1, 2013 6:54:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',101,30,'N','N',210871,450,'Y',202518,'N','D','Constraint Name','5ffe89f8-a171-45d6-88f7-8169918ae4c2','Y','N',100,0,TO_TIMESTAMP('2013-10-01 18:54:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:54:54','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Oct 1, 2013 6:54:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',101,1,'N','N',210872,460,'Y',202519,'N','D','Constraint Type','10745686-bf57-4d98-bd86-52b134ec6b99','Y','N',100,0,TO_TIMESTAMP('2013-10-01 18:54:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:54:55','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Oct 1, 2013 6:55:41 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=460,Updated=TO_TIMESTAMP('2013-10-01 18:55:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- Oct 1, 2013 6:56:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_FieldGroup (FieldGroupType,EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_UU,AD_FieldGroup_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID) VALUES ('C','D','Y','Foreign Key','c1abd52c-f048-4007-9536-dc09e4c74fed',200016,TO_TIMESTAMP('2013-10-01 18:56:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-01 18:56:15','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',0)
;

-- Oct 1, 2013 6:56:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET AD_FieldGroup_ID=200016, SeqNoGrid=450,Updated=TO_TIMESTAMP('2013-10-01 18:56:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

-- Oct 1, 2013 6:56:39 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y', AD_FieldGroup_ID=200016, XPosition=4,Updated=TO_TIMESTAMP('2013-10-01 18:56:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202517
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=54403
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=2574
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=2573
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=160
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=161
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=162
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=166
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=202257
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=2370
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=169
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=10128
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=4941
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=50188
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=168
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=159
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=825
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=4940
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=167
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=5121
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=200288
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=56317
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=62467
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=202518
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=202519
;

-- Oct 2, 2013 4:42:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=5122
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=255
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=54403
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=1984
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=157
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=156
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=11264
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=1345
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=152
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=153
;

-- Oct 2, 2013 4:42:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=154
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=250
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=155
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=158
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=170
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=172
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=310
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=56279
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=56374
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=2526
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200648
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=171
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=2574
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=2573
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=160
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=161
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=162
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=166
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=2370
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=169
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=10128
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=4941
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=50188
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=168
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=159
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=825
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=4940
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=167
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=5121
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=56317
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=62467
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=202518
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=202519
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y' WHERE AD_Field_ID=5122
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y' WHERE AD_Field_ID=200288
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=420,IsDisplayedGrid='Y' WHERE AD_Field_ID=202257
;

-- Oct 2, 2013 4:42:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=430,IsDisplayedGrid='Y' WHERE AD_Field_ID=59619
;

-- Oct 2, 2013 4:44:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET DefaultValue='N',Updated=TO_TIMESTAMP('2013-10-02 16:44:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210872
;

-- Oct 2, 2013 4:45:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO t_alter_column values('ad_column','FKConstraintType','CHAR(1)',null,'N')
;

-- Oct 2, 2013 4:45:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET AD_FieldGroup_ID=NULL,Updated=TO_TIMESTAMP('2013-10-02 16:45:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

-- Oct 2, 2013 4:45:34 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET AD_FieldGroup_ID=NULL,Updated=TO_TIMESTAMP('2013-10-02 16:45:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- Oct 2, 2013 4:51:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=27 | @AD_Reference_ID@=53370',Updated=TO_TIMESTAMP('2013-10-02 16:51:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

-- Oct 2, 2013 4:51:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=27 | @AD_Reference_ID@=53370',Updated=TO_TIMESTAMP('2013-10-02 16:51:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

-- Oct 2, 2013 4:53:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=20,Updated=TO_TIMESTAMP('2013-10-02 16:53:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

SELECT register_migration_script('201310021718_IDEMPIERE-1132.sql') FROM dual
;