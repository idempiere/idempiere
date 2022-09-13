-- IDEMPIERE-5421
SELECT register_migration_script('202209131234_IDEMPIERE-5421.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 13, 2022, 9:32:52 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215319,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',53282,'SeqNo','@SQL=SELECT COALESCE(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_ChartDatasource WHERE AD_Chart_ID=@AD_Chart_ID@',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2022-09-13 09:32:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-13 09:32:52','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','aacde4aa-46e1-4093-9a8d-c9accf21a64c','Y',0,'N','N','N')
;

-- Sep 13, 2022, 9:36:00 AM CEST
UPDATE AD_Column SET FieldLength=255, IsToolbarButton='N',Updated=TO_TIMESTAMP('2022-09-13 09:36:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59700
;

-- Sep 13, 2022, 9:36:14 AM CEST
ALTER TABLE AD_ChartDatasource MODIFY ValueColumn VARCHAR2(255 CHAR)
;

-- Sep 13, 2022, 9:36:30 AM CEST
ALTER TABLE AD_ChartDatasource ADD SeqNo NUMBER(10) DEFAULT NULL 
;

-- Sep 13, 2022, 12:34:33 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207218,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',53340,215319,'Y',22,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-13 12:34:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-13 12:34:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b447ba08-b2f8-449e-9f8b-64b8069246e4','Y',10,2)
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207218
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59613
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59610
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59611
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59615
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59616
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202285
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59605
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59609
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59678
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59618
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59617
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59612
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59604
;

-- Sep 13, 2022, 12:34:48 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-13 12:34:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204475
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59611
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59607
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59606
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59608
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59616
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59614
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59613
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59604
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59615
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59605
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59609
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59610
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59612
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=202285
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59617
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59678
;

-- Sep 13, 2022, 12:36:10 PM CEST
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=59618
;

