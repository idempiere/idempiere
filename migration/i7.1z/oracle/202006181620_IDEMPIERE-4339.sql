SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4339
-- Jun 18, 2020, 4:13:12 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200138,'AD_Column in AD_Table (not present in WS_WebServiceFieldIn)','S','AD_Column.AD_Table_ID=@AD_Table_ID@ AND AD_Column.AD_Column_ID NOT IN (SELECT AD_Column_ID FROM WS_WebServiceFieldInput WHERE WS_WebServiceType_ID = @WS_WebServiceType_ID@)',0,0,'Y',TO_DATE('2020-06-18 16:13:12','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-06-18 16:13:12','YYYY-MM-DD HH24:MI:SS'),0,'D','d9ec441e-4653-45ba-8413-488cf9cfb4dd')
;

-- Jun 18, 2020, 4:13:34 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200139,'AD_Column in AD_Table (not present in WS_WebServiceFieldOut)','S','AD_Column.AD_Table_ID=@AD_Table_ID@ AND AD_Column.AD_Column_ID NOT IN (SELECT AD_Column_ID FROM WS_WebServiceFieldOutput WHERE WS_WebServiceType_ID = @WS_WebServiceType_ID@)',0,0,'Y',TO_DATE('2020-06-18 16:13:34','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-06-18 16:13:34','YYYY-MM-DD HH24:MI:SS'),0,'D','fde75581-b497-4ceb-8bff-eed0012a8a48')
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56645
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56649
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56653
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56654
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56652
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56648
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56647
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=205067
;

-- Jun 18, 2020, 4:14:02 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-18 16:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56655
;

-- Jun 18, 2020, 4:14:19 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_DATE('2020-06-18 16:14:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53188
;

-- Jun 18, 2020, 4:14:24 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_DATE('2020-06-18 16:14:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53189
;

-- Jun 18, 2020, 4:14:36 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_DATE('2020-06-18 16:14:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53190
;

-- Jun 18, 2020, 4:15:37 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200138, IsToolbarButton='N',Updated=TO_DATE('2020-06-18 16:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=56755
;

-- Jun 18, 2020, 4:15:52 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200139, IsToolbarButton='N',Updated=TO_DATE('2020-06-18 16:15:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=56757
;

-- Jun 18, 2020, 4:15:52 PM CEST
UPDATE AD_Tab SET IsSingleRow='N',Updated=TO_DATE('2020-06-18 16:14:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53191
;

-- Jun 24, 2020, 5:06:03 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200119,0,0,'Y',TO_DATE('2020-06-24 17:06:02','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-06-24 17:06:02','YYYY-MM-DD HH24:MI:SS'),0,'Insert Parameters','This process will add required parameters for current web service type','N','WebServiceTypeCreateParameters','N','org.idempiere.webservices.process.WebServiceTypeCreateParameters','6','D',0,0,'N','N','S','N','2b94e537-3bb4-4e25-8277-13c16061e3a6','P')
;

-- Jun 24, 2020, 5:06:24 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203423,0,0,'Y',TO_DATE('2020-06-24 17:06:24','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-06-24 17:06:24','YYYY-MM-DD HH24:MI:SS'),0,'InsertParameters','Insert Parameters','Insert Parameters','D','c17747f6-5197-4b15-ac86-3195429c240a')
;

-- Jun 24, 2020, 5:07:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214212,0,'Insert Parameters',53164,'InsertParameters',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_DATE('2020-06-24 17:07:08','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-06-24 17:07:08','YYYY-MM-DD HH24:MI:SS'),0,203423,'Y',200119,'N','D','N','N','N','Y','6ae6d84f-72e6-4f70-8ae4-3bf471190c2d','N',0,'N','N','N','N')
;

-- Jun 24, 2020, 5:07:10 PM CEST
ALTER TABLE WS_WebServiceType ADD InsertParameters CHAR(1) DEFAULT NULL 
;

-- Jun 24, 2020, 5:07:27 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206417,'Insert Parameters',53187,214212,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2020-06-24 17:07:26','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2020-06-24 17:07:26','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','3abfcdc4-0795-4aa7-b825-667b19c6cc50','Y',110,2,2)
;

-- Jun 24, 2020, 5:07:48 PM CEST
UPDATE AD_Field SET DisplayLogic='@SQL=!SELECT 1 FROM WS_WebService_Para WHERE WS_WebServiceType_ID = @WS_WebServiceType_ID:0@', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-24 17:07:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206417
;

SELECT register_migration_script('202006181620_IDEMPIERE-4339.sql') FROM dual
;