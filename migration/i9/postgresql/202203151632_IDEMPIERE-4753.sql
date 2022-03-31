-- IDEMPIERE-4753

-- Jun 2, 2021, 12:04:43 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203512,0,0,'Y',TO_TIMESTAMP('2021-06-02 12:04:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-02 12:04:43','YYYY-MM-DD HH24:MI:SS'),100,'FileNamePattern','File Name Pattern','File Name Pattern','D','09e87361-0597-43b4-9378-8afa29bc83ed')
;

-- Jun 2, 2021, 12:10:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214497,0,'File Name Pattern',493,'FileNamePattern',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-06-02 12:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-02 12:10:55','YYYY-MM-DD HH24:MI:SS'),100,203512,'Y','N','D','N','N','N','Y','7bc2b0a2-c57f-41ae-b287-711dbeaa9192','Y',0,'N','N','N','N')
;

-- Jun 2, 2021, 12:10:59 PM CEST
ALTER TABLE AD_PrintFormat ADD COLUMN FileNamePattern VARCHAR(255) DEFAULT NULL 
;

-- Jun 2, 2021, 12:11:48 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214498,0,'File Name Pattern',284,'FileNamePattern',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-06-02 12:11:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-02 12:11:47','YYYY-MM-DD HH24:MI:SS'),100,203512,'Y','N','D','N','N','N','Y','b04cde1b-4791-4e5d-a270-ad1e526f77a0','Y',0,'N','N','N','N')
;

-- Jun 2, 2021, 12:11:51 PM CEST
ALTER TABLE AD_Process ADD COLUMN FileNamePattern VARCHAR(255) DEFAULT NULL 
;

-- Jun 2, 2021, 12:12:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206663,'File Name Pattern',425,214497,'Y',255,260,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-06-02 12:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-02 12:12:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0a554010-53a1-4b18-b66f-9333f72960f7','Y',260,5)
;

-- Jun 2, 2021, 12:13:21 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206664,'File Name Pattern',245,214498,'Y',255,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-06-02 12:13:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-06-02 12:13:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','79eafd94-0fa6-4419-908c-1781f5edea58','Y',250,5)
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3703
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2534
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10235
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56497
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3278
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3219
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5849
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206664
;

-- Mar 15, 2022, 4:32:32 PM CET
UPDATE AD_Column SET IsTranslated='Y',Updated=TO_TIMESTAMP('2022-03-15 16:32:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214497
;

-- Mar 15, 2022, 4:32:50 PM CET
INSERT INTO t_alter_column values('ad_printformat','FileNamePattern','VARCHAR(255)',null,'NULL')
;

-- Mar 15, 2022, 4:36:11 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214714,0,'File Name Pattern',200130,'FileNamePattern',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-03-15 16:36:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-15 16:36:11','YYYY-MM-DD HH24:MI:SS'),100,203512,'Y','Y','D','N','N','N','Y','b60bf16e-e25c-42cb-95ba-9fc88bd3eb0d','Y',10,'N','N','N','N')
;

-- Mar 16, 2022, 8:16:42 AM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206916,'File Name Pattern',200143,214714,'Y',0,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-03-16 08:16:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-16 08:16:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','269e9f00-8ed2-4887-afc0-aee484f4ade6','Y',80,1,1,1,'N','N','N','N')
;

-- Mar 16, 2022, 8:22:24 AM CET
ALTER TABLE AD_PrintFormat_Trl ADD COLUMN FileNamePattern VARCHAR(255) DEFAULT NULL 
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205584
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5762
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6503
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5657
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5661
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5654
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5658
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50179
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202368
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205242
;

-- Mar 31, 2022, 2:51:46 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:51:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206663
;

-- Mar 31, 2022, 2:52:31 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:52:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206916
;

-- Mar 31, 2022, 2:52:31 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:52:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203046
;

-- Mar 31, 2022, 2:52:31 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-03-31 14:52:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203047
;

SELECT register_migration_script('202203151632_IDEMPIERE-4753.sql') FROM dual;
