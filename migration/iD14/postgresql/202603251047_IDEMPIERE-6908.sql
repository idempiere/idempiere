-- IDEMPIERE-6908 Implement iDempiere Extension Management
SELECT register_migration_script('202603251047_IDEMPIERE-6908.sql') FROM dual;

-- Mar 25, 2026, 10:47:27 AM GMT+08:00
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (209074,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200416,217470,'Y',0,70,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-03-25 10:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-03-25 10:47:24','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019d22e3-cba2-7223-ba99-a915a208d6b7','Y',60,1,2,1,'N','N','N','N','N')
;

-- Mar 25, 2026, 10:47:41 AM GMT+08:00
UPDATE AD_Field SET NumLines=15,Updated=TO_TIMESTAMP('2026-03-25 10:47:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209062
;

-- Mar 25, 2026, 10:48:02 AM GMT+08:00
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=10, XPosition=1,Updated=TO_TIMESTAMP('2026-03-25 10:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209074
;

-- Mar 25, 2026, 10:48:02 AM GMT+08:00
UPDATE AD_Field SET SeqNo=20,Updated=TO_TIMESTAMP('2026-03-25 10:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209060
;

-- Mar 25, 2026, 10:48:02 AM GMT+08:00
UPDATE AD_Field SET SeqNo=30,Updated=TO_TIMESTAMP('2026-03-25 10:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209059
;

-- Mar 25, 2026, 10:48:02 AM GMT+08:00
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2026-03-25 10:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209061
;

-- Mar 25, 2026, 10:48:02 AM GMT+08:00
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2026-03-25 10:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209062
;

-- Mar 25, 2026, 10:48:02 AM GMT+08:00
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2026-03-25 10:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209063
;

-- Mar 25, 2026, 10:48:02 AM GMT+08:00
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2026-03-25 10:48:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209065
;

-- Mar 25, 2026, 10:48:09 AM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2026-03-25 10:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209074
;

-- Mar 25, 2026, 10:48:09 AM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2026-03-25 10:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209060
;

-- Mar 25, 2026, 10:48:09 AM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2026-03-25 10:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209059
;

-- Mar 25, 2026, 10:48:09 AM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2026-03-25 10:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209061
;

-- Mar 25, 2026, 10:48:09 AM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2026-03-25 10:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209063
;

-- Mar 25, 2026, 10:48:09 AM GMT+08:00
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2026-03-25 10:48:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209065
;

