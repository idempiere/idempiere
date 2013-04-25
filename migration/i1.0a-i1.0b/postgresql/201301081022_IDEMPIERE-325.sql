-- Jan 7, 2013 2:25:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200061,'InfoQueryOperators','D','70b95984-eab9-42f1-a9f1-24fd94265597','N','Operator list for info query criteria','L',0,0,100,TO_TIMESTAMP('2013-01-07 14:25:02','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2013-01-07 14:25:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 7, 2013 2:25:39 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200112,200061,'D','Like','cd02fd21-8913-4bc7-9ef4-a405069f8665','Like',TO_TIMESTAMP('2013-01-07 14:25:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 14:25:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 2:25:55 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200113,200061,'D','=','1e99d0eb-d4ba-46ad-98be-1e9f0a20d387','=',TO_TIMESTAMP('2013-01-07 14:25:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 14:25:54','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 2:26:18 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200114,200061,'D','>','da5910a0-4b7a-4986-ada4-ecba7eb953ad','>',TO_TIMESTAMP('2013-01-07 14:26:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 14:26:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 2:26:30 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200115,200061,'D','>=','653d78b9-8a2b-40cd-a0f1-c7e8bf5cea1c','>=',TO_TIMESTAMP('2013-01-07 14:26:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 14:26:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 2:26:38 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200116,200061,'D','<','2673aa9f-3efc-4625-9659-9242f8140d8c','<',TO_TIMESTAMP('2013-01-07 14:26:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 14:26:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 2:26:47 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200117,200061,'D','<=','dc557f72-fae9-463f-86ab-7d078eef739f','<=',TO_TIMESTAMP('2013-01-07 14:26:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 14:26:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 2:26:57 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200118,200061,'D','!=','bc2fee0b-7738-4d57-9d12-e60d55ff2256','!=',TO_TIMESTAMP('2013-01-07 14:26:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 14:26:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 2:28:53 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('QueryOperator',202188,'D','Query Operator','Operator for database query','Query Operator','72ef789a-7846-4647-9776-f92242f850dc',0,TO_TIMESTAMP('2013-01-07 14:28:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-07 14:28:51','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 7, 2013 2:35:44 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('QueryFunction',202189,'Database function for user query. If the database function takes more than just the column name parameter, use ? to indicate where the column name should goes to. E.g: Upper, Trunc and To_Char(?,''MM'')','D','Query Function','Database function for query','Query Function','141c4ef1-fa75-41cb-a2ae-ed7695ad3842',0,TO_TIMESTAMP('2013-01-07 14:35:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-07 14:35:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 7, 2013 2:40:06 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',1,897,208363,'D','N','N','N',0,'N',10,'N',10,'N',202188,'N','Y','@IsQueryCriteria@=Y','729dbd59-fbf2-4f8e-ad73-0e42da64cfab','Y','QueryOperator','Operator for database query','Query Operator','Y',TO_TIMESTAMP('2013-01-07 14:40:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-07 14:40:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 7, 2013 2:41:20 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',1,897,208364,'D','N','N','N',0,'N',255,'N',10,'N',202189,'N','Y','108f7521-1a09-4b26-aa34-c67fd09e2f55','Y','QueryFunction','Database function for query','Database function for user query. If the database function takes more than just the column name parameter, use ? to indicate where the column name should goes to. E.g: Upper, Trunc and To_Char(?,''MM'')','Query Function','Y',TO_TIMESTAMP('2013-01-07 14:41:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-07 14:41:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 7, 2013 2:41:44 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
ALTER TABLE AD_InfoColumn ADD COLUMN QueryOperator VARCHAR(10) DEFAULT NULL 
;

-- Jan 7, 2013 2:42:03 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
ALTER TABLE AD_InfoColumn ADD COLUMN QueryFunction VARCHAR(255) DEFAULT NULL 
;

-- Jan 7, 2013 2:43:46 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,DefaultValue,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',844,0,'N','N',208363,200,'Y',201635,'N','D','Operator for database query','Query Operator','Y','N','9c9b2e2f-911e-4d00-bec3-38b018973ad4','@IsQueryCriteria@=Y',100,0,TO_TIMESTAMP('2013-01-07 14:43:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-07 14:43:45','YYYY-MM-DD HH24:MI:SS'),'Y','N',110,1,'N')
;

-- Jan 7, 2013 2:44:25 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (5,1,0,'N',844,0,'N','N',208364,210,'Y',201636,'N','Database function for user query. If the database function takes more than just the column name parameter, use ? to indicate where the column name should goes to. E.g: Upper, Trunc and To_Char(?,''MM'')','@IsQueryCriteria@=Y','D','Database function for query','Query Function','Y','N','8e514e55-3297-4c61-9ded-d7e4c33919ac',100,0,TO_TIMESTAMP('2013-01-07 14:44:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-07 14:44:24','YYYY-MM-DD HH24:MI:SS'),'Y','N',120,1,'N')
;

-- Jan 7, 2013 2:45:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-01-07 14:45:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Jan 7, 2013 2:45:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=170, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-01-07 14:45:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Jan 7, 2013 2:45:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2013-01-07 14:45:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Jan 7, 2013 2:45:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2013-01-07 14:45:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Jan 7, 2013 2:45:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2013-01-07 14:45:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Jan 7, 2013 2:45:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2013-01-07 14:45:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Jan 7, 2013 6:13:01 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Ref_List SET IsActive='N',Updated=TO_TIMESTAMP('2013-01-07 18:13:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=486
;

-- Jan 7, 2013 6:13:41 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Description,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200119,104,'D','Info Window','Info','5484a32f-202c-4316-9ae7-c295ed508aee','I',TO_TIMESTAMP('2013-01-07 18:13:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-07 18:13:38','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Jan 7, 2013 6:14:17 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2013-01-07 18:14:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6297
;

-- Jan 7, 2013 6:15:32 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',1,116,208365,'D','N','N','N',0,'N',10,'N',19,'N',3068,'N','Y','@Action@=I','ad570436-9ec8-447c-9a0e-ee95d33d0cf5','Y','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y',TO_TIMESTAMP('2013-01-07 18:15:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-07 18:15:31','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 7, 2013 6:17:08 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET IsDisplayed='N', IsActive='N', IsDisplayedGrid='N',Updated=TO_TIMESTAMP('2013-01-07 18:17:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4944
;

-- Jan 7, 2013 6:18:46 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',110,0,'N','N',208365,180,'Y',201638,'N','The Info window is used to search and select records as well as display information relevant to the selection.','@Action@=I','D','Info and search/select Window','Info Window','Y','N','c885c7d6-4ea3-418a-9548-6547646e8ecf',100,0,TO_TIMESTAMP('2013-01-07 18:18:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-07 18:18:45','YYYY-MM-DD HH24:MI:SS'),'Y','Y',180,1,'N')
;

-- Jan 7, 2013 6:23:35 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
ALTER TABLE AD_Menu ADD COLUMN AD_InfoWindow_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 7, 2013 11:45:54 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Column SET AD_Reference_Value_ID=200061, AD_Reference_ID=17,Updated=TO_TIMESTAMP('2013-01-07 23:45:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208363
;

-- Jan 7, 2013 11:48:11 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET DisplayLogic='@IsQueryCriteria@=Y',Updated=TO_TIMESTAMP('2013-01-07 23:48:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Jan 8, 2013 3:50:56 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2013-01-08 15:50:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208351
;

-- Jan 8, 2013 3:55:24 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',1,895,208366,'D','Y','N','N',0,'N',1,'N',20,'N',2002,'N','Y','bd41e247-9cd9-4eaf-81ba-a98b34d2ecc0','Y','IsValid','Element is valid','N','The element passed the validation check','Valid','N',TO_TIMESTAMP('2013-01-08 15:55:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 15:55:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 3:55:30 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
ALTER TABLE AD_InfoWindow ADD COLUMN IsValid CHAR(1) DEFAULT 'N' CHECK (IsValid IN ('Y','N')) NOT NULL
;

-- Jan 8, 2013 3:56:20 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',842,0,'N','N',208366,160,'Y',201639,'N','The element passed the validation check','D','Element is valid','Valid','Y','N','fb3dfc55-0eac-4eb9-bde2-81df3662a8af',100,0,TO_TIMESTAMP('2013-01-08 15:56:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-08 15:56:19','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,1,'N')
;

-- Jan 8, 2013 3:57:11 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=150, IsDisplayed='Y', XPosition=3,Updated=TO_TIMESTAMP('2013-01-08 15:57:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201628
;

-- Jan 8, 2013 3:57:11 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=160, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-01-08 15:57:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201639
;

-- Jan 8, 2013 4:35:44 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','N','N','6',0,200054,'N','N','N','D','L','3bd37917-909f-457e-892f-0bb9416af9a0','Y','Y','AD_InfoWindow_Access','Info Window Access',0,'Y',0,100,TO_TIMESTAMP('2013-01-08 16:35:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-08 16:35:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Jan 8, 2013 4:36:04 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,200054,208367,'D','Y','N','N','N',22,'N',19,129,'N',102,'N','Y','44f1a48e-c732-43a7-953a-910d601741d0','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-01-08 16:36:03','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:36:04 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,200054,208368,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','daafd18d-41eb-4ec3-a866-1db36ca31f2f','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-01-08 16:36:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:36:05 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,200054,208369,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','1e86c85f-353d-41b6-9b9c-f8241166ba7c','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-01-08 16:36:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:36:06 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,200054,208370,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','65952c45-d736-479a-93da-6a2c20a0ab31','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-01-08 16:36:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:36:07 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,200054,208371,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','68d59bbf-a3bc-4467-b49d-433ba81e97e2','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-01-08 16:36:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:06','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:36:09 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_InfoWindow_Access_UU',202191,'D','AD_InfoWindow_Access_UU','AD_InfoWindow_Access_UU','c711fc3d-f204-4018-95fa-260105f4a829',0,TO_TIMESTAMP('2013-01-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 8, 2013 4:36:10 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1.00,200054,208373,'D','N','N','N','N',36,'N',10,'N',202191,'N','Y','8f7de6f9-9a2b-44fe-bb85-b286fb50cb02','Y','AD_InfoWindow_Access_UU','AD_InfoWindow_Access_UU','N',TO_TIMESTAMP('2013-01-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:36:11 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,200054,208374,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','9fb38f84-8045-4098-8c29-2a6b3655cc30','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-01-08 16:36:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:10','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:36:12 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES ('N','N',1,200054,208375,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','d3d63740-11cd-4d46-9e67-fa7387de5539','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-01-08 16:36:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:36:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:37:49 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',1,200054,208376,'D','Y','N','N',0,'Y',10,'N',19,'N',123,'N','Y','7f58fd78-7dc3-4cf5-afb7-7d69a5f4a83f','N','AD_Role_ID','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.','Role','Y',TO_TIMESTAMP('2013-01-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:37:48','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:38:51 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',1,200054,208377,'D','Y','N','N',0,'Y',10,'N',19,'N',3068,'N','Y','947b4792-bd5b-405e-bc1c-18d122e22e67','N','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y',TO_TIMESTAMP('2013-01-08 16:38:50','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-08 16:38:50','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 8, 2013 4:39:57 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
CREATE TABLE AD_InfoWindow_Access (AD_Client_ID NUMERIC(10) NOT NULL, AD_InfoWindow_Access_UU VARCHAR(36) DEFAULT NULL , AD_InfoWindow_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Role_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_InfoWindow_Access_Key PRIMARY KEY (AD_Role_ID, AD_InfoWindow_ID))
;

-- Jan 8, 2013 4:42:28 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,AD_Column_ID,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N','N','N',111,65,'N','N',200054,'N',208376,'N','N','Y','N',1,'56ad707e-3224-4705-93b6-e890862d6836','D','Info Window Access',200064,0,0,TO_TIMESTAMP('2013-01-08 16:42:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-08 16:42:27','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 8, 2013 4:42:58 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200064,1,'N','N',208371,'Y',201640,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','Y','N','19fbfbe9-9921-4e32-9797-8c29e79b688f',100,0,TO_TIMESTAMP('2013-01-08 16:42:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-08 16:42:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 8, 2013 4:42:59 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200064,36,'N','N',208373,'Y',201641,'N','D','AD_InfoWindow_Access_UU','Y','N','2e4da5d9-19c1-4fd3-9373-ad0fb7195ab7',100,0,TO_TIMESTAMP('2013-01-08 16:42:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-08 16:42:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 8, 2013 4:43:00 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200064,22,'N','N',208367,'Y',201642,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','Y','N','bfd467d8-8b5f-47eb-9d8b-8e3391f2e5f6',100,0,TO_TIMESTAMP('2013-01-08 16:42:59','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-08 16:42:59','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 8, 2013 4:43:01 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200064,10,'N','N',208377,'Y',201643,'N','The Info window is used to search and select records as well as display information relevant to the selection.','D','Info and search/select Window','Info Window','Y','N','c282dcec-f3b2-4690-9d8c-c5e5800496ea',100,0,TO_TIMESTAMP('2013-01-08 16:43:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-08 16:43:00','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 8, 2013 4:43:02 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200064,22,'N','N',208368,'Y',201645,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','Y','N','f1b10a76-8ca1-47eb-adad-34e76e15863a',100,0,TO_TIMESTAMP('2013-01-08 16:43:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-08 16:43:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 8, 2013 4:43:03 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200064,10,'N','N',208376,'Y',201646,'N','The Role determines security and access a user who has this Role will have in the System.','D','Responsibility Role','Role','Y','N','69a2be8a-c03a-4c0e-88fc-7558647097a3',100,0,TO_TIMESTAMP('2013-01-08 16:43:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-08 16:43:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 8, 2013 4:45:56 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET ColumnSpan=2, SeqNo=10,Updated=TO_TIMESTAMP('2013-01-08 16:45:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201642
;

-- Jan 8, 2013 4:45:57 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET ColumnSpan=2, SeqNo=20, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-01-08 16:45:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201645
;

-- Jan 8, 2013 4:45:57 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET ColumnSpan=2, SeqNo=30,Updated=TO_TIMESTAMP('2013-01-08 16:45:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201643
;

-- Jan 8, 2013 4:45:57 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET ColumnSpan=2, SeqNo=40, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2013-01-08 16:45:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201646
;

-- Jan 8, 2013 4:45:57 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-01-08 16:45:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201640
;

-- Jan 8, 2013 4:45:57 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=0, IsDisplayed='N', XPosition=1,Updated=TO_TIMESTAMP('2013-01-08 16:45:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201641
;

-- Jan 8, 2013 4:46:24 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201641
;

-- Jan 8, 2013 4:46:24 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201642
;

-- Jan 8, 2013 4:46:24 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201645
;

-- Jan 8, 2013 4:46:24 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201646
;

-- Jan 8, 2013 4:46:24 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201643
;

-- Jan 8, 2013 4:46:24 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201640
;

-- Jan 8, 2013 4:46:33 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201646
;

-- Jan 8, 2013 4:46:33 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201643
;

-- Jan 8, 2013 5:11:23 PM MYT
-- IDEMPIERE-325 AD_InfoWindow
UPDATE AD_Tab SET Name='Info Access',Updated=TO_TIMESTAMP('2013-01-08 17:11:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200064
;

CREATE UNIQUE INDEX AD_InfoWindow_Unique_Name ON AD_InfoWindow (AD_Client_ID, Name)
;

SELECT register_migration_script('201301081022_IDEMPIERE-325.sql') FROM dual
;


