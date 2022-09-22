-- IDEMPIERE-5408 Allow or enforce login with specific tenant (FHCA-3823)
SELECT register_migration_script('202209221920_IDEMPIERE-5408.sql') FROM dual;

-- Sep 22, 2022, 7:20:41 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203679,0,0,'Y',TO_TIMESTAMP('2022-09-22 19:20:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-22 19:20:28','YYYY-MM-DD HH24:MI:SS'),100,'LoginPrefix','Login Prefix',NULL,NULL,'Login Prefix','D','2b343447-35fc-4aeb-865d-035d3e9dd74f')
;

-- Sep 22, 2022, 7:21:50 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,AD_InfoWindow_ID) VALUES (215385,0,'Login Prefix',112,'LoginPrefix',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-22 19:21:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-22 19:21:49','YYYY-MM-DD HH24:MI:SS'),100,203679,'Y','N','D','N','N','N','Y','813befa6-0922-4583-b673-c965dbc925f8','Y',0,'N','N','N','N',200000)
;

-- Sep 22, 2022, 7:22:04 PM CEST
ALTER TABLE AD_Client ADD COLUMN LoginPrefix VARCHAR(40) DEFAULT NULL 
;

-- Sep 22, 2022, 7:22:50 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201131,'3c2eaaa6-51d6-4f44-8652-bd904f70d1a8',TO_TIMESTAMP('2022-09-22 19:22:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_client_loginprefix',TO_TIMESTAMP('2022-09-22 19:22:50','YYYY-MM-DD HH24:MI:SS'),100,112,'N','Y','N','N')
;

-- Sep 22, 2022, 7:23:03 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201516,'5f8ecb6c-5116-40ec-bdc8-e1d9d9df5fbb',TO_TIMESTAMP('2022-09-22 19:23:03','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-09-22 19:23:03','YYYY-MM-DD HH24:MI:SS'),100,215385,201131,10)
;

-- Sep 22, 2022, 7:23:14 PM CEST
CREATE UNIQUE INDEX ad_client_loginprefix ON AD_Client (LoginPrefix)
;

-- Sep 22, 2022, 7:23:31 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207264,'Login Prefix',145,215385,'Y',40,240,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-22 19:23:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-22 19:23:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','79f147fc-77ac-4a37-bd49-ed05ea6461c4','Y',270,2)
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207264
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=317
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=318
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=319
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10318
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5160
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5759
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11025
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11205
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3813
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5887
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200594
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200595
;

-- Sep 22, 2022, 7:24:07 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5161
;

-- Sep 22, 2022, 7:24:08 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5162
;

-- Sep 22, 2022, 7:24:08 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5163
;

-- Sep 22, 2022, 7:24:08 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5164
;

-- Sep 22, 2022, 7:24:08 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-22 19:24:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204476
;

