SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4753
-- Jun 2, 2021, 12:04:43 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203512,0,0,'Y',TO_DATE('2021-06-02 12:04:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-02 12:04:43','YYYY-MM-DD HH24:MI:SS'),100,'FileNamePattern','File Name Pattern','File Name Pattern','D','09e87361-0597-43b4-9378-8afa29bc83ed')
;

-- Jun 2, 2021, 12:10:55 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214497,0,'File Name Pattern',493,'FileNamePattern',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-06-02 12:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-02 12:10:55','YYYY-MM-DD HH24:MI:SS'),100,203512,'Y','N','D','N','N','N','Y','7bc2b0a2-c57f-41ae-b287-711dbeaa9192','Y',0,'N','N','N','N')
;

-- Jun 2, 2021, 12:10:59 PM CEST
ALTER TABLE AD_PrintFormat ADD FileNamePattern VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jun 2, 2021, 12:11:48 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214498,0,'File Name Pattern',284,'FileNamePattern',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-06-02 12:11:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-02 12:11:47','YYYY-MM-DD HH24:MI:SS'),100,203512,'Y','N','D','N','N','N','Y','b04cde1b-4791-4e5d-a270-ad1e526f77a0','Y',0,'N','N','N','N')
;

-- Jun 2, 2021, 12:11:51 PM CEST
ALTER TABLE AD_Process ADD FileNamePattern VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jun 2, 2021, 12:12:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206663,'File Name Pattern',425,214497,'Y',255,260,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-02 12:12:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-02 12:12:26','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0a554010-53a1-4b18-b66f-9333f72960f7','Y',260,5)
;

-- Jun 2, 2021, 12:13:21 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206664,'File Name Pattern',245,214498,'Y',255,280,'N','N','N','N',0,0,'Y',TO_DATE('2021-06-02 12:13:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-06-02 12:13:21','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','79eafd94-0fa6-4419-908c-1781f5edea58','Y',250,5)
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3703
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2534
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10235
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56497
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3278
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3219
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5849
;

-- Jun 2, 2021, 12:13:59 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-06-02 12:13:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206664
;

SELECT register_migration_script('202106021214_IDEMPIERE-4753.sql') FROM dual
;
