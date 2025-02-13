-- IDEMPIERE-6321 Implement markdown and scope style suppot for Status Line widget
SELECT register_migration_script('202411281654_IDEMPIERE-6321.sql') FROM dual;

-- Nov 28, 2024, 4:54:30 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216924,0,'Style','CSS style for field and label',200107,'AD_Style_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-11-28 16:54:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-28 16:54:29','YYYY-MM-DD HH24:MI:SS'),100,203005,'Y','N','D','N','N','N','Y','c1215e17-25f1-441a-b94a-26affa533ecc','Y',0,'N','N','N','N','N')
;

-- Nov 28, 2024, 4:54:35 PM MYT
UPDATE AD_Column SET FKConstraintName='ADStyle_ADStatusLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-28 16:54:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216924
;

-- Nov 28, 2024, 4:54:35 PM MYT
ALTER TABLE AD_StatusLine ADD COLUMN AD_Style_ID NUMERIC(10) DEFAULT NULL 
;

-- Nov 28, 2024, 4:54:35 PM MYT
ALTER TABLE AD_StatusLine ADD CONSTRAINT ADStyle_ADStatusLine FOREIGN KEY (AD_Style_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 28, 2024, 5:00:58 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208547,'Style','CSS style for field and label',200114,216924,'Y',0,80,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-28 17:00:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-28 17:00:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','206d85e6-19d2-4e28-b138-ca921133175b','Y',60,1,2,1,'N','N','N','N','N')
;

-- Nov 28, 2024, 5:01:21 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2024-11-28 17:01:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208547
;

-- Nov 28, 2024, 5:01:21 PM MYT
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2024-11-28 17:01:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202566
;

-- Nov 28, 2024, 5:01:21 PM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2024-11-28 17:01:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202567
;

