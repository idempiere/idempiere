-- IDEMPIERE-6905 Enhanced Context Parsing for Related Info and Parameters in the Info Window
SELECT register_migration_script('202603161107_IDEMPIERE-6905.sql') FROM dual;

-- Mar 16, 2026, 11:07:11 AM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204040,0,0,'Y',TO_TIMESTAMP('2026-03-16 11:07:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-16 11:07:10','YYYY-MM-DD HH24:MI:SS'),100,'Is_FilterOnlyInfoRelated','Filter Only Related Info','Filter Only Related Info','D','019cf6f8-dea2-7620-92cf-8de4a3d8dd58')
;

-- Mar 16, 2026, 11:08:11 AM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217406,0,'Filter Only Related Info',897,'Is_FilterOnlyInfoRelated','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-03-16 11:08:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-16 11:08:10','YYYY-MM-DD HH24:MI:SS'),100,204040,'Y','N','D','N','N','N','Y','019cf6f9-cac0-73b7-ae39-ec811bfc9d11','Y',0,'N','N','N','N')
;

-- Mar 16, 2026, 11:10:26 AM BRT
ALTER TABLE AD_InfoColumn ADD COLUMN Is_FilterOnlyInfoRelated CHAR(1) DEFAULT 'N' CHECK (Is_FilterOnlyInfoRelated IN ('Y','N')) NOT NULL
;

-- Mar 16, 2026, 11:11:28 AM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209027,'Filter Only Related Info',844,217406,'Y',1,360,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-16 11:11:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-16 11:11:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019cf6fc-cbb1-7856-920c-640e6a53b49c','Y',230,2,2)
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, XPosition=6,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209027
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203829
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201719
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203471
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201720
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203048
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207409
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207411
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207412
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205588
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206178
;

-- Mar 16, 2026, 11:11:50 AM BRT
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2026-03-16 11:11:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206409
;

