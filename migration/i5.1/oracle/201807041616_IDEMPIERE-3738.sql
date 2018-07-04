SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3738 Reference Color broken
-- Jul 4, 2018 4:02:49 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203229,0,0,'Y',TO_DATE('2018-07-04 16:02:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-07-04 16:02:37','YYYY-MM-DD HH24:MI:SS'),100,'Color','Color',NULL,NULL,'Color','D','c43cfcc2-2c92-4e91-88b8-88947297184d')
;

-- Jul 4, 2018 4:03:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213570,0,'Color',135,'Color',7,'N','N','N','N','N',0,'N',27,0,0,'Y',TO_DATE('2018-07-04 16:03:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-07-04 16:03:02','YYYY-MM-DD HH24:MI:SS'),100,203229,'Y','N','D','N','N','N','Y','46472ac6-1648-48d8-b0bd-aef0d61a447f','Y',0,'N','N')
;

-- Jul 4, 2018 4:03:03 PM CEST
ALTER TABLE Test ADD Color VARCHAR2(7) DEFAULT NULL 
;

-- Jul 4, 2018 4:03:17 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205590,'Color',152,213570,'Y',7,260,'N','N','N','N',0,0,'Y',TO_DATE('2018-07-04 16:03:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-07-04 16:03:16','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dc447e1a-b62a-4a90-92db-17203eb7d6ac','Y',260,2)
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=415
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2024
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=417
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=418
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=419
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=420
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=423
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=424
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_FieldGroup_ID=103, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=421
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_FieldGroup_ID=103, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=422
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3059
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3062
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_FieldGroup_ID=50003, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=425
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_FieldGroup_ID=50003, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=426
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_FieldGroup_ID=200016, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3209
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3902
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3210
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4251
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3057
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3056
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_FieldGroup_ID=123, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205590
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=416
;

-- Jul 4, 2018 4:07:48 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205058
;

-- Jul 4, 2018 4:08:25 PM CEST
UPDATE Test SET Color='#bfca3f',Updated=TO_DATE('2018-07-04 16:08:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE Test_ID=103
;

-- Jul 4, 2018 4:09:13 PM CEST
UPDATE AD_Menu SET IsActive='N',Updated=TO_DATE('2018-07-04 16:09:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=294
;

-- Jul 4, 2018 4:09:21 PM CEST
UPDATE AD_Window SET IsActive='N',Updated=TO_DATE('2018-07-04 16:09:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=225
;

-- Jul 4, 2018 4:13:03 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=53370', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:13:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202518
;

-- Jul 4, 2018 4:13:12 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=19 | @AD_Reference_ID@=30 | @AD_Reference_ID@=18 | @AD_Reference_ID@=21 | @AD_Reference_ID@=25 | @AD_Reference_ID@=31 | @AD_Reference_ID@=35 | @AD_Reference_ID@=33 | @AD_Reference_ID@=32 | @AD_Reference_ID@=53370', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-07-04 16:13:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202519
;

SELECT register_migration_script('201807041616_IDEMPIERE-3738.sql') FROM dual
;

