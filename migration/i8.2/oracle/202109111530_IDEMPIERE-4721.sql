SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4721
-- Sep 10, 2021, 3:34:07 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203533,0,0,'Y',TO_DATE('2021-09-10 15:34:07','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-10 15:34:07','YYYY-MM-DD HH24:MI:SS'),0,'ExcludeAdjustmentPeriods','Exclude Adjustment Periods','Exclude Adjustment Periods','D','67a3ab9c-51ab-4afd-b6d3-80294dafa526')
;

-- Sep 10, 2021, 3:34:51 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200198,'FinReport ExcludeAdjustmentPeriods','L',0,0,'Y',TO_DATE('2021-09-10 15:34:50','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-10 15:34:50','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','9a34172f-5f27-4819-84cc-7de43853e8c8')
;

-- Sep 10, 2021, 3:35:00 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200516,'No',200198,'0',0,0,'Y',TO_DATE('2021-09-10 15:35:00','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-10 15:35:00','YYYY-MM-DD HH24:MI:SS'),0,'D','f04dfda3-2f17-4d27-83d2-696941a8a181')
;

-- Sep 10, 2021, 3:35:07 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200517,'Only Report Period',200198,'1',0,0,'Y',TO_DATE('2021-09-10 15:35:07','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-10 15:35:07','YYYY-MM-DD HH24:MI:SS'),0,'D','540fdd4a-4c09-46ee-b1b1-92c6b79c2f76')
;

-- Sep 10, 2021, 3:35:16 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200518,'All Adjustment Periods',200198,'2',0,0,'Y',TO_DATE('2021-09-10 15:35:16','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-10 15:35:16','YYYY-MM-DD HH24:MI:SS'),0,'D','3b897a74-e4c7-4832-87ee-936bf71cf182')
;

-- Sep 10, 2021, 3:35:35 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214585,0,'Exclude Adjustment Periods',445,'ExcludeAdjustmentPeriods','1',1,'N','N','Y','N','N',0,'N',17,200198,0,0,'Y',TO_DATE('2021-09-10 15:35:35','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-10 15:35:35','YYYY-MM-DD HH24:MI:SS'),0,203533,'Y','N','D','N','N','N','Y','754c9256-e9c0-4096-99f2-a9cb4f4cec44','Y',0,'N','N','N','N')
;

-- Sep 10, 2021, 3:35:38 PM CEST
ALTER TABLE PA_Report ADD ExcludeAdjustmentPeriods CHAR(1) DEFAULT '1' NOT NULL
;

-- Sep 10, 2021, 3:35:48 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206747,'Exclude Adjustment Periods',372,214585,'Y',1,180,'N','N','N','N',0,0,'Y',TO_DATE('2021-09-10 15:35:48','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-10 15:35:48','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','7b4bcc01-71e2-4840-809e-5399e35f754e','Y',170,2)
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206747
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=54234
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=6268
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=6267
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=201867
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4737
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=6265
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=54235
;

-- Sep 10, 2021, 3:36:10 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-10 15:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=204992
;

SELECT register_migration_script('202109111530_IDEMPIERE-4721.sql') FROM dual
;
