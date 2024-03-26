-- IDEMPIERE-6040 Improvements for CSV import template
SELECT register_migration_script('202403262247_IDEMPIERE-6040.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 26, 2024, 10:47:25 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216584,0,'Separator Character',200153,'SeparatorChar',',',1,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-03-26 22:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:47:24','YYYY-MM-DD HH24:MI:SS'),100,54158,'Y','N','D','N','N','N','Y','3083364e-7dac-4ee2-8fa9-7ffe047b0461','Y',0,'N','N','N','N')
;

-- Mar 26, 2024, 10:47:28 PM CET
ALTER TABLE AD_ImportTemplate ADD SeparatorChar VARCHAR2(1 CHAR) DEFAULT ',' NOT NULL
;

-- Mar 26, 2024, 10:48:07 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203928,0,0,'Y',TO_TIMESTAMP('2024-03-26 22:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:47:56','YYYY-MM-DD HH24:MI:SS'),100,'QuoteChar','Quote Char',NULL,NULL,'Quote Char','D','9bdf8508-f83b-46bc-baca-c27d5b1fac5e')
;

-- Mar 26, 2024, 10:48:24 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216585,0,'Quote Char',200153,'QuoteChar','"',1,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-03-26 22:48:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-03-26 22:48:23','YYYY-MM-DD HH24:MI:SS'),100,203928,'Y','N','D','N','N','N','Y','9b51ff6c-2c9c-4f1b-ad66-a8fa4e0b1f1b','Y',0,'N','N','N','N')
;

-- Mar 26, 2024, 10:48:27 PM CET
ALTER TABLE AD_ImportTemplate ADD QuoteChar VARCHAR2(1 CHAR) DEFAULT '"' NOT NULL
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

