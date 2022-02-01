SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5170
-- Jan 27, 2022, 3:32:46 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203554,0,0,'Y',TO_DATE('2022-01-27 15:32:45','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-27 15:32:45','YYYY-MM-DD HH24:MI:SS'),0,'ReversePreparePayment','Reverse Prepare Payment','Reverse Prepare Payment','D','05fcf0df-deca-4ae9-852e-557d0d4a03eb')
;

-- Jan 27, 2022, 3:33:17 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200136,0,0,'Y',TO_DATE('2022-01-27 15:33:17','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-27 15:33:17','YYYY-MM-DD HH24:MI:SS'),0,'Reverse Prepare Payment','Reverse what Prepare Payment process did','Delete prepared payments and allow to add/remove invoices','N','ReversePreparePayment','N','org.compiere.process.PaySelectionCheckReverse','3','D',0,0,'N','Y','N','4f38ecc2-c3d9-4a10-8f42-3e0a69b29f59','P')
;

-- Jan 27, 2022, 3:33:53 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,AD_Process_ID,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214665,0,'Reverse Prepare Payment',426,'ReversePreparePayment',1,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_DATE('2022-01-27 15:33:53','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-27 15:33:53','YYYY-MM-DD HH24:MI:SS'),0,203554,'Y',200136,'N','D','N','Y','N','Y','122d6120-4348-42c7-92c3-081965c2bab4','Y',0,'Y','N','N','N')
;

-- Jan 27, 2022, 3:33:55 PM CET
ALTER TABLE C_PaySelection ADD ReversePreparePayment CHAR(1) DEFAULT NULL 
;

-- Jan 27, 2022, 3:34:06 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206837,'Reverse Prepare Payment',352,214665,'Y',1,140,'N','N','N','N',0,0,'Y',TO_DATE('2022-01-27 15:34:06','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-01-27 15:34:06','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','2b55c47a-fd43-4dd2-9896-3b9d17f9f5a4','Y',150,2,2)
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4402
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4403
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4411
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4407
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4409
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4413
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=205900
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4435
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4414
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206837
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=204778
;

-- Jan 27, 2022, 3:34:36 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4406
;

-- Jan 27, 2022, 3:34:49 PM CET
UPDATE AD_Field SET DisplayLogic='@SQL=!SELECT 1 FROM C_PaySelectionCheck WHERE C_PaySelection_ID = @C_PaySelection_ID:0@', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4414
;

-- Jan 27, 2022, 3:34:54 PM CET
UPDATE AD_Field SET DisplayLogic='@Processed@=Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:34:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206837
;

-- Jan 27, 2022, 3:39:44 PM CET
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-01-27 15:39:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=4413
;

SELECT register_migration_script('202201271530_IDEMPIERE-5170.sql') FROM dual
;
