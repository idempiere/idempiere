SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1540 Autocomplete for field type "Search"
-- May 21, 2020, 10:15:20 PM MYT
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-05-21 22:15:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56279
;

-- May 22, 2020, 11:34:12 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214201,0,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',464,'IsAutocomplete',NULL,1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2020-05-22 23:34:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-22 23:34:11','YYYY-MM-DD HH24:MI:SS'),100,53655,'Y','N','D','N','N','N','Y','1254c9c5-43a3-45a2-9dff-a80df5aa89d7','N',0,'N','N','N')
;

-- May 22, 2020, 11:34:17 PM MYT
ALTER TABLE AD_UserDef_Field ADD IsAutocomplete CHAR(1) DEFAULT NULL  CHECK (IsAutocomplete IN ('Y','N'))
;

-- May 22, 2020, 11:37:48 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206408,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',395,214201,'Y','@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30',0,330,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-05-22 23:37:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-22 23:37:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','37df68ac-aafb-458e-878c-efb421b9a129','Y',330,2,2,1,'N','N','N','N')
;

-- May 22, 2020, 11:39:28 PM MYT
UPDATE AD_Field SET SeqNo=305, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=305, IsToolbarButton=NULL,Updated=TO_DATE('2020-05-22 23:39:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206408
;

-- May 22, 2020, 11:39:43 PM MYT
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-05-22 23:39:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5057
;

-- May 22, 2020, 11:39:50 PM MYT
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-05-22 23:39:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5051
;

-- May 22, 2020, 11:40:05 PM MYT
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=310, IsToolbarButton=NULL,Updated=TO_DATE('2020-05-22 23:40:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206408
;

-- May 22, 2020, 11:42:22 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214202,0,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',897,'IsAutocomplete','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2020-05-22 23:42:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-22 23:42:21','YYYY-MM-DD HH24:MI:SS'),100,53655,'Y','N','D','N','N','N','Y','1fc6ddb8-4449-46ab-a54e-418260e069cf','N',0,'N','N','N')
;

-- May 22, 2020, 11:42:29 PM MYT
ALTER TABLE AD_InfoColumn ADD IsAutocomplete CHAR(1) DEFAULT 'N' CHECK (IsAutocomplete IN ('Y','N')) NOT NULL
;

-- May 22, 2020, 11:45:54 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206409,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',844,214202,'Y','@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30',0,320,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-05-22 23:45:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-22 23:45:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','49343858-2e9b-437b-9131-d10e069674bb','Y',320,2,2,1,'N','N','N','N')
;

-- May 22, 2020, 11:47:35 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214203,0,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',285,'IsAutocomplete','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2020-05-22 23:47:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-22 23:47:35','YYYY-MM-DD HH24:MI:SS'),100,53655,'Y','N','D','N','N','N','Y','2594d121-f632-44b5-b79e-d630ed950a70','Y',0,'N','N','N','N')
;

-- May 22, 2020, 11:47:38 PM MYT
ALTER TABLE AD_Process_Para ADD IsAutocomplete CHAR(1) DEFAULT 'N' CHECK (IsAutocomplete IN ('Y','N')) NOT NULL
;

-- May 22, 2020, 11:49:01 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206410,'Autocomplete','Automatic completion for textfields','The autocompletion uses all existing values (from the same client and organization) of the field.',246,214203,'Y','@AD_Reference_ID@=10 | @AD_Reference_ID@=17 | @AD_Reference_ID@=18 | @AD_Reference_ID@=19 | @AD_Reference_ID@=30',0,300,0,'N','N','N','N',0,0,'Y',TO_DATE('2020-05-22 23:49:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-22 23:49:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8e6fd1fe-8d03-4105-a76f-b563e8ba9637','Y',280,2,2,1,'N','N','N','N')
;

-- May 27, 2020, 10:03:39 AM MYT
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2020-05-27 10:03:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214201
;

SELECT register_migration_script('202005272300_IDEMPIERE-1540.sql') FROM dual
;

