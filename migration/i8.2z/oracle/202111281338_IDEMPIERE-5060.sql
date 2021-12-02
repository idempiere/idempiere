SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5060 iDempiere dictionary view doesn't support UNION ALL
-- Nov 28, 2021, 1:34:11 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203549,0,0,'Y',TO_DATE('2021-11-28 13:33:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-28 13:33:31','YYYY-MM-DD HH24:MI:SS'),100,'IsUnionAll','Is UNION ALL','The component view is UNION ALL','When this is set the component view is joined to the others using UNION ALL, otherwise just UNION','Is UNION ALL','D','ab8f8c93-aa6e-4f1a-85e2-79a05d07a811')
;

-- Nov 28, 2021, 1:34:24 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214651,0,'Is UNION ALL','The component view is UNION ALL','When this is set the component view is joined to the others using UNION ALL, otherwise just UNION',200087,'IsUnionAll','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-11-28 13:34:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-28 13:34:24','YYYY-MM-DD HH24:MI:SS'),100,203549,'Y','N','D','N','N','N','Y','f2332b5c-30ac-48c4-95df-6bc6e32743af','Y',0,'N','N','N','N')
;

-- Nov 28, 2021, 1:34:26 PM CET
ALTER TABLE AD_ViewComponent ADD IsUnionAll CHAR(1) DEFAULT 'N' CHECK (IsUnionAll IN ('Y','N')) NOT NULL
;

-- Nov 28, 2021, 1:34:47 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206814,'Is UNION ALL','The component view is UNION ALL','When this is set the component view is joined to the others using UNION ALL, otherwise just UNION',200098,214651,'Y',1,140,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-28 13:34:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-28 13:34:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','abcfef41-97ad-45d4-911a-c05b893300d6','Y',120,2,2)
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202236
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202224
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202225
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202226
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202233
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206814
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202235
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202234
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202231
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202229
;

-- Nov 28, 2021, 1:36:14 PM CET
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-28 13:36:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202232
;

SELECT register_migration_script('202111281338_IDEMPIERE-5060.sql') FROM dual
;

