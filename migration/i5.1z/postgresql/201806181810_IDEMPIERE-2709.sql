-- InfoWindow selection editable fields
-- 18-giu-2018 16.11.33 CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203216,0,0,'Y',TO_TIMESTAMP('2018-06-18 16:11:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-06-18 16:11:32','YYYY-MM-DD HH24:MI:SS'),100,'InputFieldValidation','Input field validation','Input field validaton query','Input field validaton query','Input field validation','D','b457c250-ced2-415f-aaae-9bc7e545cb01')
;

-- 18-giu-2018 16.12.33 CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213525,0,'Input field validation','Input field validaton query','Input field validaton query',897,'InputFieldValidation',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2018-06-18 16:12:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-06-18 16:12:33','YYYY-MM-DD HH24:MI:SS'),100,203216,'Y','N','D','N','N','N','Y','d0a5e559-7621-496c-9269-715b1040395b','Y',0,'N','N')
;

-- 18-giu-2018 16.12.49 CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2018-06-18 16:12:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213525
;

-- 18-giu-2018 16.21.51 CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205588,'Input field validation','Input field validaton query','Input field validaton query',844,213525,'Y',0,280,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-06-18 16:21:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-06-18 16:21:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','26da27d1-b040-49dc-a3e6-ecd9f273636f','Y',190,1,1,1,'N','N','N')
;

-- 18-giu-2018 16.22.23 CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-06-18 16:22:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- 18-giu-2018 16.24.44 CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=5, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-06-18 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- 18-giu-2018 16.25.24 CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-06-18 16:25:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- 18-giu-2018 16.26.02 CEST
ALTER TABLE AD_InfoColumn ADD COLUMN InputFieldValidation VARCHAR(2000) DEFAULT NULL 
;

-- 18-giu-2018 17.39.36 CEST
UPDATE AD_Field SET DisplayLogic='@IsReadOnly@=N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-06-18 17:39:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- 18-giu-2018 18.00.13 CEST
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2018-06-18 18:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212216
;

-- 18-giu-2018 18.04.58 CEST
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-06-18 18:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203829
;

-- 18-giu-2018 18.05.07 CEST
UPDATE AD_Column SET Help='Input field validaton query. If this query returns at least a row, an error will be displayed and the new value will be refused. The query can use all the fields in row as context fields (using the usual @...@ syntax). The error messages is composed appending the first column of every rows of the result, and its then translated, so the message can contains traslatable parts in the form @<MessageValue>@ and/or @<ElementValue>@',Updated=TO_TIMESTAMP('2018-06-18 18:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213525
;

SELECT register_migration_script('201806181810_IDEMPIERE-2709.sql') FROM dual
;
