-- Dec 27, 2012 4:09:41 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-12-27 16:09:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54358
;

-- Dec 27, 2012 4:10:13 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-12-27 16:10:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=54359
;

-- Dec 27, 2012 4:11:59 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET IsDisplayedGrid='N', IsDisplayed='N', IsActive='N',Updated=TO_DATE('2012-12-27 16:11:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200275
;

-- Dec 27, 2012 4:14:32 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET IsDisplayedGrid='N', IsDisplayed='N', IsActive='N',Updated=TO_DATE('2012-12-27 16:14:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54403
;

-- Dec 28, 2012 7:46:43 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,Updated,UpdatedBy,EntityType,Name,AD_Val_Rule_UU,Type,CreatedBy,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_InfoWindow.AD_Table_ID=@AD_Table_ID@',200019,TO_DATE('2012-12-28 07:46:39','YYYY-MM-DD HH24:MI:SS'),100,'U','AD_InfoWindow of Table','e9d81675-ce1f-4d7c-9354-9b8d5a23ced9','S',100,TO_DATE('2012-12-28 07:46:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Dec 28, 2012 7:47:24 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,103,'U','N','N','N',0,'N',10,'N',19,200019,'N',3068,TO_DATE('2012-12-28 07:47:23','YYYY-MM-DD HH24:MI:SS'),'N','Y','069cc811-f05e-4d64-9d22-322f6a15a7b5','Y','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y','Y',100,TO_DATE('2012-12-28 07:47:23','YYYY-MM-DD HH24:MI:SS'),0,100,0,208343,'N',0)
;

-- Dec 28, 2012 7:47:34 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_Ref_Table ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 28, 2012 8:15:11 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,895,'U','N','N','N',0,'N',2000,'N',14,'N',630,TO_DATE('2012-12-28 08:15:10','YYYY-MM-DD HH24:MI:SS'),'N','Y','23771259-ec7c-4111-b0d1-64d90bfe3242','Y','WhereClause','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".','Sql WHERE','Y','Y',100,TO_DATE('2012-12-28 08:15:10','YYYY-MM-DD HH24:MI:SS'),0,100,0,208344,'N',0)
;

-- Dec 28, 2012 8:16:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoWindow ADD WhereClause NVARCHAR2(2000) DEFAULT NULL 
;

-- Dec 28, 2012 8:23:46 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,897,'D',53330,'N','N','N',0,'N',10,'N',18,115,'N',121,TO_DATE('2012-12-28 08:23:45','YYYY-MM-DD HH24:MI:SS'),'N','Y','65aee3e9-d2d5-4993-8815-2166a5942bb2','Y','AD_Reference_Value_ID','Required to specify, if data type is Table or List','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ','Reference Key','Y','Y',100,TO_DATE('2012-12-28 08:23:45','YYYY-MM-DD HH24:MI:SS'),0,100,0,208346,'N',0)
;

-- Dec 28, 2012 8:24:35 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET AD_Reference_Value_ID=4,Updated=TO_DATE('2012-12-28 08:24:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208346
;

-- Dec 28, 2012 8:24:39 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoColumn ADD AD_Reference_Value_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 28, 2012 8:25:27 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-12-28 08:25:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208345
;

-- Dec 28, 2012 8:25:36 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-12-28 08:25:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208344
;

-- Dec 28, 2012 8:32:22 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,897,'D','N','N','N',0,'N',10,'N',19,'N',139,TO_DATE('2012-12-28 08:32:20','YYYY-MM-DD HH24:MI:SS'),'N','Y','49a4d4cd-7fa4-437e-80c1-1f05513d5b23','Y','AD_Val_Rule_ID','Dynamic Validation Rule','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.','Dynamic Validation','Y','Y',100,TO_DATE('2012-12-28 08:32:20','YYYY-MM-DD HH24:MI:SS'),0,100,0,208347,'N',0)
;

-- Dec 28, 2012 8:32:29 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoColumn ADD AD_Val_Rule_ID NUMBER(10) DEFAULT NULL 
;

-- Dec 28, 2012 8:34:33 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,DefaultValue,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,897,'D','Y','N','N',0,'N',1,'N',20,'N',362,TO_DATE('2012-12-28 08:34:32','YYYY-MM-DD HH24:MI:SS'),'N','Y','ffddca95-c0ec-430d-be98-035ac95d35df','Y','Y','IsCentrallyMaintained','Information maintained in System Element table','The Centrally Maintained checkbox indicates if the Name, Description and Help maintained in ''System Element'' table  or ''Window'' table.','Centrally maintained','Y','Y',100,TO_DATE('2012-12-28 08:34:32','YYYY-MM-DD HH24:MI:SS'),0,100,0,208348,'N',0)
;

-- Dec 28, 2012 8:34:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoColumn ADD IsCentrallyMaintained CHAR(1) DEFAULT 'Y' CHECK (IsCentrallyMaintained IN ('Y','N')) NOT NULL
;

-- Dec 28, 2012 8:36:34 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,897,'D','N','N','N',0,'N',2000,'N',14,'N',283,TO_DATE('2012-12-28 08:36:33','YYYY-MM-DD HH24:MI:SS'),'N','Y','ed45c16a-6427-4fb9-b68f-7cf64b1546a7','Y','DisplayLogic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)','Display Logic','Y','Y',100,TO_DATE('2012-12-28 08:36:33','YYYY-MM-DD HH24:MI:SS'),0,100,0,208349,'N',0)
;

-- Dec 28, 2012 8:36:46 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoColumn ADD DisplayLogic NVARCHAR2(2000) DEFAULT NULL 
;

-- Dec 28, 2012 8:40:39 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive,XPosition) VALUES (2,1,'N',0,'N',103,'N','N',208343,130,'Y',201620,'N','The Info window is used to search and select records as well as display information relevant to the selection.',0,TO_DATE('2012-12-28 08:40:38','YYYY-MM-DD HH24:MI:SS'),'N',130,'D',0,'Info and search/select Window','Y','N','823993ba-87be-430e-b4a8-19c4e0061b3d',100,TO_DATE('2012-12-28 08:40:38','YYYY-MM-DD HH24:MI:SS'),0,'Info Window',100,'Y',1)
;

-- Dec 28, 2012 8:45:00 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive,XPosition) VALUES (5,3,'N',0,'N',842,'N','N',208344,95,'Y',201621,'N','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".',0,TO_DATE('2012-12-28 08:44:59','YYYY-MM-DD HH24:MI:SS'),'N',95,'D',0,'Fully qualified SQL WHERE clause','Y','N','8e6453b7-db4b-42d7-ac6a-76f9ee34de63',100,TO_DATE('2012-12-28 08:44:59','YYYY-MM-DD HH24:MI:SS'),0,'Sql WHERE',100,'Y',1)
;

-- Dec 31, 2012 11:42:23 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,897,'D','Y','N','N',0,'N',30,'N',10,'N',228,TO_DATE('2012-12-31 23:42:20','YYYY-MM-DD HH24:MI:SS'),'N','Y','07a7935b-2a59-48e3-a80a-f11b785afed3','Y','ColumnName','Name of the column in the database','The Column Name indicates the name of a column on a table as defined in the database.','DB Column Name','Y','Y',100,TO_DATE('2012-12-31 23:42:20','YYYY-MM-DD HH24:MI:SS'),0,100,0,208350,'N',0)
;

-- Dec 31, 2012 11:42:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoColumn ADD ColumnName NVARCHAR2(30) NOT NULL
;

-- Dec 31, 2012 11:46:58 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,DisplayLogic,Name,UpdatedBy,IsActive,XPosition) VALUES (1,1,'N',0,'N',844,'N','N',208346,150,'Y',201622,'N','The Reference Value indicates where the reference values are stored.  It must be specified if the data type is Table or List.  ',0,TO_DATE('2012-12-31 23:46:56','YYYY-MM-DD HH24:MI:SS'),'Y',150,'D',0,'Required to specify, if data type is Table or List','Y','N','e4bcdb5e-998d-43b1-84f3-46ade9370a71',100,TO_DATE('2012-12-31 23:46:56','YYYY-MM-DD HH24:MI:SS'),0,'@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=30 | @AD_Reference_ID@=28','Reference Key',100,'Y',1)
;

-- Dec 31, 2012 11:48:15 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,DisplayLogic,Name,UpdatedBy,IsActive,XPosition) VALUES (1,1,'N',0,'N',844,'N','N',208347,160,'Y',201623,'N','These rules define how an entry is determined to valid. You can use variables for dynamic (context sensitive) validation.',0,TO_DATE('2012-12-31 23:48:14','YYYY-MM-DD HH24:MI:SS'),'N',160,'D',0,'Dynamic Validation Rule','Y','N','6de8a2af-30ec-452b-8420-050fb5c39fb1',100,TO_DATE('2012-12-31 23:48:14','YYYY-MM-DD HH24:MI:SS'),0,'@AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=28 | @AD_Reference_ID@=30 | @AD_Reference_ID@=200012','Dynamic Validation',100,'Y',1)
;

-- Dec 31, 2012 11:48:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive,XPosition) VALUES (1,1,'N',0,'N',844,'N','N',208350,170,'Y',201624,'N','The Column Name indicates the name of a column on a table as defined in the database.',0,TO_DATE('2012-12-31 23:48:36','YYYY-MM-DD HH24:MI:SS'),'Y',170,'U',0,'Name of the column in the database','Y','N','03b13bf8-d2f8-4d2d-b3a5-68a9ef3df63c',100,TO_DATE('2012-12-31 23:48:36','YYYY-MM-DD HH24:MI:SS'),0,'DB Column Name',100,'Y',1)
;

-- Dec 31, 2012 11:52:45 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive,XPosition) VALUES (1,1,'N',0,'N',844,'N','N',208349,180,'Y',201625,'N','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',0,TO_DATE('2012-12-31 23:52:44','YYYY-MM-DD HH24:MI:SS'),'N',180,'D',0,'If the Field is displayed, the result determines if the field is actually displayed','Y','N','538692f6-ff16-4157-ac9e-df7beca9eecb',100,TO_DATE('2012-12-31 23:52:44','YYYY-MM-DD HH24:MI:SS'),0,'Display Logic',100,'Y',1)
;

-- Dec 31, 2012 11:58:10 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET DisplayLogic='@IsDisplayed@=Y',Updated=TO_DATE('2012-12-31 23:58:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Jan 1, 2013 9:14:55 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_DATE('2013-01-01 09:14:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15788
;

-- Jan 1, 2013 9:15:11 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET DefaultValue='Y',Updated=TO_DATE('2013-01-01 09:15:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15776
;

-- Jan 1, 2013 9:15:49 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET AD_Reference_ID=30,Updated=TO_DATE('2013-01-01 09:15:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15790
;

-- Jan 1, 2013 9:30:54 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive,XPosition) VALUES (1,1,'N',0,'N',844,'N','N',208348,190,'Y',201626,'N','The Centrally Maintained checkbox indicates if the Name, Description and Help maintained in ''System Element'' table  or ''Window'' table.',0,TO_DATE('2013-01-01 09:30:52','YYYY-MM-DD HH24:MI:SS'),'Y',190,'D',0,'Information maintained in System Element table','Y','N','ae37e609-8640-453f-b1be-e2bfcbd099cc',100,TO_DATE('2013-01-01 09:30:52','YYYY-MM-DD HH24:MI:SS'),0,'Centrally maintained',100,'Y',1)
;

-- Jan 1, 2013 9:35:57 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET DefaultValue='@SQL=SELECT NVL(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_InfoColumn WHERE AD_InfoWindow_ID=@AD_InfoWindow_ID@',Updated=TO_DATE('2013-01-01 09:35:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=15787
;

-- Jan 1, 2013 12:11:44 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Tab SET SeqNo=40,Updated=TO_DATE('2013-01-01 00:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=843
;

-- Jan 1, 2013 12:12:02 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Tab SET SeqNo=20,Updated=TO_DATE('2013-01-01 00:12:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=844
;

-- Jan 1, 2013 12:12:10 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Tab SET SeqNo=30,Updated=TO_DATE('2013-01-01 00:12:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=845
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=10, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13599
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=20, XPosition=4,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13593
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=30, XPosition=7,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13601
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=5, SeqNo=40, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13600
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=50, XPosition=7,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13604
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=5, SeqNo=60, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13595
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=5, SeqNo=70, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13594
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=80, XPosition=2,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13592
;

-- Jan 2, 2013 8:30:41 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=2, SeqNo=90, XPosition=3,Updated=TO_DATE('2013-01-02 08:30:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13596
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=5, SeqNo=100, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=5, SeqNo=110, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13605
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=120, XPosition=8,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13602
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=130, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201624
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=140, XPosition=4,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13606
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=150, XPosition=8,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201626
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=160, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=170, XPosition=4,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=180, XPosition=7,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Jan 2, 2013 8:30:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=190, XPosition=1,Updated=TO_DATE('2013-01-02 08:30:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Jan 2, 2013 8:34:15 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=5,Updated=TO_DATE('2013-01-02 08:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13602
;

-- Jan 2, 2013 8:34:15 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2013-01-02 08:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Jan 2, 2013 8:34:15 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2013-01-02 08:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13605
;

-- Jan 2, 2013 8:34:15 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=150, IsDisplayed='Y', XPosition=7,Updated=TO_DATE('2013-01-02 08:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201626
;

-- Jan 2, 2013 8:35:46 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=2, SeqNo=80,Updated=TO_DATE('2013-01-02 08:35:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13592
;

-- Jan 2, 2013 8:35:46 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=90, XPosition=4,Updated=TO_DATE('2013-01-02 08:35:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13596
;

-- Jan 2, 2013 8:35:46 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=100, XPosition=6,Updated=TO_DATE('2013-01-02 08:35:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13602
;

-- Jan 4, 2013 10:03:29 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,DefaultValue,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,895,'D','Y','N','N',0,'N',1,'N',20,'N',1103,TO_DATE('2013-01-04 10:03:27','YYYY-MM-DD HH24:MI:SS'),'N','Y','34ce8949-69ce-49f3-add5-9a4b073e9abb','N','Y','IsDefault','Default value','The Default Checkbox indicates if this record will be used as a default value.','Default','Y','Y',100,TO_DATE('2013-01-04 10:03:27','YYYY-MM-DD HH24:MI:SS'),0,100,0,208351,'N',0)
;

-- Jan 4, 2013 10:03:35 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoWindow ADD IsDefault CHAR(1) DEFAULT 'N' CHECK (IsDefault IN ('Y','N')) NOT NULL
;

-- Jan 4, 2013 10:05:30 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Element (AD_Element_UU,EntityType,ColumnName,Name,Description,PrintName,Created,CreatedBy,UpdatedBy,AD_Org_ID,AD_Element_ID,AD_Client_ID,Updated,IsActive) VALUES ('f201cb26-043b-42c3-8e46-847801008534','D','IsDistinct','Distinct','Select Distinct','Distinct',TO_DATE('2013-01-04 10:05:28','YYYY-MM-DD HH24:MI:SS'),100,100,0,202186,0,TO_DATE('2013-01-04 10:05:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 4, 2013 10:06:11 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (IsSyncDatabase,IsAlwaysUpdateable,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,DefaultValue,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N','N',1,895,'U','Y','N','N',0,'N',1,'N',20,'N',202186,TO_DATE('2013-01-04 10:06:10','YYYY-MM-DD HH24:MI:SS'),'N','Y','773fd373-deca-44a4-bbdf-5f9c07d16c9f','N','Y','IsDistinct','Select Distinct','Distinct','Y','Y',100,TO_DATE('2013-01-04 10:06:10','YYYY-MM-DD HH24:MI:SS'),0,100,0,208352,'N',0)
;

-- Jan 4, 2013 10:06:15 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoWindow ADD IsDistinct CHAR(1) DEFAULT 'N' CHECK (IsDistinct IN ('Y','N')) NOT NULL
;

-- Jan 4, 2013 10:07:12 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive,XPosition) VALUES (1,1,'N',0,'N',842,'N','N',208352,120,'Y',201627,'N',0,TO_DATE('2013-01-04 10:07:10','YYYY-MM-DD HH24:MI:SS'),'N',120,'D',0,'Select Distinct','Y','N','b7862f66-669e-49a4-8c5d-73b1f0962ed1',100,TO_DATE('2013-01-04 10:07:10','YYYY-MM-DD HH24:MI:SS'),0,'Distinct',100,'Y',1)
;

-- Jan 4, 2013 10:07:28 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,IsQuickEntry,SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive,XPosition) VALUES (1,1,'N',0,'N',842,'N','N',208351,130,'Y',201628,'N','The Default Checkbox indicates if this record will be used as a default value.',0,TO_DATE('2013-01-04 10:07:27','YYYY-MM-DD HH24:MI:SS'),'Y',130,'D',0,'Default value','Y','N','b938a746-41d4-4f3e-9e35-2fefa5461cee',100,TO_DATE('2013-01-04 10:07:27','YYYY-MM-DD HH24:MI:SS'),0,'Default',100,'Y',1)
;

-- Jan 4, 2013 10:07:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2013-01-04 10:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201621
;

-- Jan 4, 2013 10:07:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2013-01-04 10:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13579
;

-- Jan 4, 2013 10:07:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2013-01-04 10:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13580
;

-- Jan 4, 2013 10:07:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=130, IsDisplayed='Y', XPosition=2,Updated=TO_DATE('2013-01-04 10:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201627
;

-- Jan 4, 2013 10:07:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=140, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2013-01-04 10:07:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201628
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13606
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201624
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=7,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13604
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13605
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13600
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13595
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=100,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13594
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13592
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13596
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13602
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201626
;

-- Jan 4, 2013 10:11:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2013-01-04 10:11:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Jan 4, 2013 1:36:51 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Tab SET IsSingleRow='Y',Updated=TO_DATE('2013-01-04 13:36:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=842
;

-- Jan 4, 2013 3:34:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=2, SeqNo=50,Updated=TO_DATE('2013-01-04 15:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201624
;

-- Jan 4, 2013 3:34:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=2, SeqNo=140, IsDisplayed='Y', XPosition=8,Updated=TO_DATE('2013-01-04 15:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201626
;

-- Jan 4, 2013 3:34:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=2, SeqNo=170,Updated=TO_DATE('2013-01-04 15:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Jan 4, 2013 3:34:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=2, SeqNo=180,Updated=TO_DATE('2013-01-04 15:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Jan 4, 2013 3:35:26 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
DELETE  FROM  AD_InfoWindow_Trl WHERE AD_InfoWindow_ID=1000000
;

-- Jan 4, 2013 3:35:26 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
DELETE FROM AD_InfoWindow WHERE AD_InfoWindow_ID=1000000
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13572
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201627
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13575
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13578
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13579
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13581
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201621
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13580
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=13577
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=13574
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=13573
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=13582
;

-- Jan 4, 2013 3:37:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201628
;

-- Jan 4, 2013 3:42:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201626
;

-- Jan 4, 2013 3:42:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13593
;

-- Jan 4, 2013 3:42:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13594
;

-- Jan 4, 2013 3:42:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13595
;

-- Jan 4, 2013 3:42:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201625
;

-- Jan 4, 2013 3:42:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201623
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13597
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=13601
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201622
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=13599
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=13604
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=13600
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=13606
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201624
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=13605
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=13603
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=13596
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=13602
;

-- Jan 4, 2013 3:42:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=13592
;

-- Jan 4, 2013 4:37:01 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=13580
;

SELECT register_migration_script('201301040851_IDEMPIERE-325.sql') FROM dual
;

