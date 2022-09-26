-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202209141237_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 14, 2022, 12:37:25 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203668,0,0,'Y',TO_TIMESTAMP('2022-09-14 12:37:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-14 12:37:25','YYYY-MM-DD HH24:MI:SS'),100,'IsQueryAfterChange','Query After Change','Issues a query request after the user has made changes to the field','Query After Change','D','c10d5544-b8ae-4651-b392-db238086d756')
;

-- Sep 14, 2022, 12:38:13 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,AD_InfoWindow_ID) VALUES (215350,0,'Query After Change','Issues a query request after the user has made changes to the field',897,'IsQueryAfterChange','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-09-14 12:38:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-14 12:38:12','YYYY-MM-DD HH24:MI:SS'),100,203668,'Y','N','D','N','N','N','Y','5ab0c11c-7199-4eef-9e1f-8142e62447bb','N',0,'N','N','N','N',200000)
;

-- Sep 14, 2022, 12:38:22 PM MYT
ALTER TABLE AD_InfoColumn ADD IsQueryAfterChange CHAR(1) DEFAULT 'N' CHECK (IsQueryAfterChange IN ('Y','N')) NOT NULL
;

-- Sep 14, 2022, 12:40:30 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207237,'Query After Change','Issues a query request after the user has made changes to the field',844,215350,'Y',0,330,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-14 12:40:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-14 12:40:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c452868d-2a9e-43be-8116-00333a98d392','Y',10290,4,2,1,'N','N','N','N')
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207237
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203829
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201719
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203471
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201720
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203048
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Sep 14, 2022, 12:40:55 PM MYT
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 12:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- Sep 14, 2022, 1:26:13 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,AD_InfoWindow_ID) VALUES (215351,0,'Query After Change','Issues a query request after the user has made changes to the field',200268,'IsQueryAfterChange',NULL,1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_TIMESTAMP('2022-09-14 13:26:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-14 13:26:11','YYYY-MM-DD HH24:MI:SS'),100,203668,'Y','N','D','N','N','N','Y','6e2b6d1b-d852-4a30-896c-9496fd250903','N',0,'N','N','N','N',200000)
;

-- Sep 14, 2022, 1:26:24 PM MYT
ALTER TABLE AD_UserDef_Info_Column ADD IsQueryAfterChange CHAR(1) DEFAULT NULL 
;

-- Sep 14, 2022, 1:26:52 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207238,'Query After Change','Issues a query request after the user has made changes to the field',200279,215351,'Y',0,260,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-14 13:26:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-14 13:26:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3b47ffdc-f75b-42f9-aeba-cdc94e433308','Y',380,1,2,1,'N','N','N','N')
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207238
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206450
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206460
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206467
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206465
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206445
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206448
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206447
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206453
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206452
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206469
;

-- Sep 14, 2022, 1:27:20 PM MYT
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-14 13:27:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206466
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=203049
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=207237
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=13592
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=201719
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=201720
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=203048
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=203471
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206409
;

-- Sep 14, 2022, 1:28:55 PM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206178
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206441
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206442
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206443
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206462
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=207238
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206445
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206447
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206448
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206450
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206452
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206453
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206455
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206460
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206464
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206465
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206466
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206467
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206469
;

-- Sep 14, 2022, 1:29:33 PM MYT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206506
;

-- Sep 14, 2022, 1:32:58 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:32:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200275
;

-- Sep 14, 2022, 1:33:01 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:33:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200276
;

-- Sep 14, 2022, 1:33:05 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200277
;

-- Sep 14, 2022, 1:33:12 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:33:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200278
;

-- Sep 14, 2022, 1:33:42 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:33:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200267
;

-- Sep 14, 2022, 1:34:01 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:34:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200253
;

-- Sep 14, 2022, 1:34:04 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:34:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200254
;

-- Sep 14, 2022, 1:34:06 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:34:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200255
;

-- Sep 14, 2022, 1:34:09 PM MYT
UPDATE AD_InfoColumn SET IsQueryAfterChange='Y',Updated=TO_TIMESTAMP('2022-09-14 13:34:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200256
;
