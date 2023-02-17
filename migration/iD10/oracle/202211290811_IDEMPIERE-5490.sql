-- IDEMPIERE-5490
SELECT register_migration_script('202211290811_IDEMPIERE-5490.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 29, 2022, 8:11:25 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215651,0,'Print Format','Data Print Format','The print format determines how data is rendered for print.',50010,'AD_PrintFormat_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-11-29 08:11:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-29 08:11:24','YYYY-MM-DD HH24:MI:SS'),100,1790,'Y','N','D','N','N','N','Y','220f22c5-c44c-4be3-9585-34865be85329','Y',0,'N','N','N','N')
;

-- Nov 29, 2022, 8:11:26 AM CET
UPDATE AD_Column SET FKConstraintName='ADPrintFormat_PADashboardConte', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-11-29 08:11:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215651
;

-- Nov 29, 2022, 8:11:26 AM CET
ALTER TABLE PA_DashboardContent ADD AD_PrintFormat_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 29, 2022, 8:11:26 AM CET
ALTER TABLE PA_DashboardContent ADD CONSTRAINT ADPrintFormat_PADashboardConte FOREIGN KEY (AD_PrintFormat_ID) REFERENCES ad_printformat(ad_printformat_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 29, 2022, 8:12:18 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207428,'Print Format','Data Print Format','The print format determines how data is rendered for print.',50010,215651,'Y','@AD_Process_ID@>0',0,250,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-29 08:12:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-29 08:12:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a79096d1-5cbd-416c-bf98-6180d39dc6af','Y',240,1,1,1,'N','N','N','N')
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207428
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207135
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207187
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207125
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56504
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200268
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200260
;

-- Nov 29, 2022, 8:13:36 AM CET
UPDATE AD_Field SET SeqNo=250,Updated=TO_TIMESTAMP('2022-11-29 08:13:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202286
;

-- Nov 29, 2022, 8:35:24 AM CET
UPDATE AD_Column SET AD_Val_Rule_ID=200135,Updated=TO_TIMESTAMP('2022-11-29 08:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215651
;

