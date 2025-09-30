-- IDEMPIERE-6253 Allow Define Document  Global search result layout with custom html layout
SELECT register_migration_script('202411081638_IDEMPIERE-6253.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 8, 2024, 4:38:43 PM MYT
UPDATE AD_Field SET NumLines=3,Updated=TO_TIMESTAMP('2024-11-08 16:38:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204208
;

-- Nov 8, 2024, 4:40:10 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216893,0,'Style','CSS style for field and label',53169,'AD_Style_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-11-08 16:40:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-08 16:40:09','YYYY-MM-DD HH24:MI:SS'),100,203005,'Y','N','D','N','N','N','Y','02d19328-e20a-4f6f-9222-59778a992d03','Y',0,'N','N','N','N','N')
;

-- Nov 8, 2024, 4:40:42 PM MYT
UPDATE AD_Column SET FKConstraintName='ADStyle_ADSearchDefinition', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-11-08 16:40:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216893
;

-- Nov 8, 2024, 4:40:42 PM MYT
ALTER TABLE AD_SearchDefinition ADD AD_Style_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 8, 2024, 4:40:42 PM MYT
ALTER TABLE AD_SearchDefinition ADD CONSTRAINT ADStyle_ADSearchDefinition FOREIGN KEY (AD_Style_ID) REFERENCES ad_style(ad_style_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 8, 2024, 4:43:38 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208525,'Style','CSS style for field and label',53193,216893,'Y','@SearchType@=Q & @AD_Message_ID:0@>0',0,170,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-11-08 16:43:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-08 16:43:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b342c21c-e78d-4f02-beaf-37f656db9fa5','Y',170,1,2,1,'N','N','N','N','N')
;

-- Nov 8, 2024, 4:44:01 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, XPosition=1,Updated=TO_TIMESTAMP('2024-11-08 16:44:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208525
;

-- Nov 8, 2024, 4:44:01 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2024-11-08 16:44:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56714
;

-- Nov 8, 2024, 4:44:01 PM MYT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2024-11-08 16:44:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56717
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56709
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56704
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56713
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56708
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56707
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56702
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56718
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56711
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=70,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56712
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=80,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56705
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=90,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56710
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=100,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56706
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=110,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208524
;

-- Nov 8, 2024, 4:44:33 PM MYT
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=120,Updated=TO_TIMESTAMP('2024-11-08 16:44:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208525
;

