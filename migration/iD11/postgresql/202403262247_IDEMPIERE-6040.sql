-- IDEMPIERE-6040 Improvements for CSV import template
SELECT register_migration_script('202403262247_IDEMPIERE-6040.sql') FROM dual;

-- Mar 26, 2024, 10:47:25 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216584,0,'Separator Character',200153,'SeparatorChar',',',1,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-03-26 22:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:47:24','YYYY-MM-DD HH24:MI:SS'),100,54158,'Y','N','D','N','N','N','Y','3083364e-7dac-4ee2-8fa9-7ffe047b0461','Y',0,'N','N','N','N')
;

-- Mar 26, 2024, 10:47:28 PM CET
ALTER TABLE AD_ImportTemplate ADD COLUMN SeparatorChar VARCHAR(1) DEFAULT ',' NOT NULL
;

-- Mar 26, 2024, 10:48:07 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203928,0,0,'Y',TO_TIMESTAMP('2024-03-26 22:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:47:56','YYYY-MM-DD HH24:MI:SS'),100,'QuoteChar','Quote Char',NULL,NULL,'Quote Char','D','9bdf8508-f83b-46bc-baca-c27d5b1fac5e')
;

-- Mar 26, 2024, 10:48:24 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216585,0,'Quote Char',200153,'QuoteChar','"',1,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-03-26 22:48:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:48:23','YYYY-MM-DD HH24:MI:SS'),100,203928,'Y','N','D','N','N','N','Y','9b51ff6c-2c9c-4f1b-ad66-a8fa4e0b1f1b','Y',0,'N','N','N','N')
;

-- Mar 26, 2024, 10:48:27 PM CET
ALTER TABLE AD_ImportTemplate ADD COLUMN QuoteChar VARCHAR(1) DEFAULT '"' NOT NULL
;

-- Mar 26, 2024, 10:48:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208474,'Separator Character',200167,216584,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-03-26 22:48:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:48:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ada7dc92-28b4-4887-a577-d49226450b6c','Y',110,2)
;

-- Mar 26, 2024, 10:48:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208475,'Quote Char',200167,216585,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-03-26 22:48:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:48:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6f9a0de7-2df9-46b2-a491-a450f61d594e','Y',120,2)
;

-- Mar 26, 2024, 10:49:29 PM CET
UPDATE AD_Field SET SeqNo=70, ColumnSpan=1,Updated=TO_TIMESTAMP('2024-03-26 22:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203455
;

-- Mar 26, 2024, 10:49:29 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=3, ColumnSpan=1,Updated=TO_TIMESTAMP('2024-03-26 22:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208474
;

-- Mar 26, 2024, 10:49:29 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=5, ColumnSpan=1,Updated=TO_TIMESTAMP('2024-03-26 22:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208475
;

-- Mar 26, 2024, 10:49:29 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2024-03-26 22:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203456
;

-- Mar 26, 2024, 10:49:29 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2024-03-26 22:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203457
;

-- Mar 26, 2024, 10:49:29 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2024-03-26 22:49:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203458
;

-- Mar 26, 2024, 10:53:52 PM CET
UPDATE AD_Field SET DefaultValue='@SQL=SELECT '','' FROM Dual',Updated=TO_TIMESTAMP('2024-03-26 22:53:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208474
;

-- Mar 27, 2024, 12:23:08 PM CET
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200268,'ImportTemplateType','L',0,0,'Y',TO_TIMESTAMP('2024-03-27 12:23:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:23:08','YYYY-MM-DD HH24:MI:SS'),100,'D','N','7926c8b4-2e48-4dd3-9054-8e26245c8128','N')
;

-- Mar 27, 2024, 12:23:20 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200704,'CSV',200268,'CSV',0,0,'Y',TO_TIMESTAMP('2024-03-27 12:23:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:23:20','YYYY-MM-DD HH24:MI:SS'),100,'D','7259e211-5477-4f1b-b2a3-1ce67f919749')
;

-- Mar 27, 2024, 12:23:26 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200705,'XLS',200268,'XLS',0,0,'Y',TO_TIMESTAMP('2024-03-27 12:23:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:23:26','YYYY-MM-DD HH24:MI:SS'),100,'D','4c979a06-6550-4763-9cd2-066c0d897b9c')
;

-- Mar 27, 2024, 12:23:34 PM CET
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200706,'XLSX',200268,'XLSX',0,0,'Y',TO_TIMESTAMP('2024-03-27 12:23:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:23:33','YYYY-MM-DD HH24:MI:SS'),100,'D','0f46a993-00ac-4572-935c-0590629d092b')
;

-- Mar 27, 2024, 12:23:54 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203929,0,0,'Y',TO_TIMESTAMP('2024-03-27 12:23:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:23:42','YYYY-MM-DD HH24:MI:SS'),100,'ImportTemplateType','Import Template Type',NULL,NULL,'Import Template Type','D','6855e8ac-5c66-428f-84e9-dd81002aa03e')
;

-- Mar 27, 2024, 12:24:26 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216586,0,'Import Template Type',200153,'ImportTemplateType','CSV',4,'N','N','Y','N','N',0,'N',17,200268,0,0,'Y',TO_TIMESTAMP('2024-03-27 12:24:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:24:26','YYYY-MM-DD HH24:MI:SS'),100,203929,'Y','N','D','N','N','N','Y','4a5dce57-eb09-4bbc-b2d7-1e09d49eb7f3','Y',0,'N','N','N','N')
;

-- Mar 27, 2024, 12:24:30 PM CET
ALTER TABLE AD_ImportTemplate ADD COLUMN ImportTemplateType VARCHAR(4) DEFAULT 'CSV' NOT NULL
;

-- Mar 27, 2024, 12:24:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208476,'Import Template Type',200167,216586,'Y',4,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-03-27 12:24:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:24:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','88a997fd-241c-429c-a5fe-9f64d71c2a3a','Y',130,2)
;

-- Mar 27, 2024, 12:25:34 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=1, ColumnSpan=1,Updated=TO_TIMESTAMP('2024-03-27 12:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208476
;

-- Mar 27, 2024, 12:25:34 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, XPosition=5,Updated=TO_TIMESTAMP('2024-03-27 12:25:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203458
;

-- Mar 27, 2024, 12:26:14 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','There was an error converting the Excel file to CSV',0,0,'Y',TO_TIMESTAMP('2024-03-27 12:26:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 12:26:13','YYYY-MM-DD HH24:MI:SS'),100,200878,'ErrorConvertingXlsToCsv','D','e36c4d43-93f8-4b45-bfcc-ec4e7fba72cd')
;

-- Mar 27, 2024, 9:44:59 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','CSV Header Column not found -> {0}',0,0,'Y',TO_TIMESTAMP('2024-03-27 21:44:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-27 21:44:59','YYYY-MM-DD HH24:MI:SS'),100,200879,'CSVHeaderColumnNotFound','D','f3fdb148-1a0a-4c62-b8fa-55ab40e0e434')
;

