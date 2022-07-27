-- IDEMPIERE-5342
SELECT register_migration_script('202207121657_IDEMPIERE-5342.sql') FROM dual;

-- Jul 12, 2022, 4:57:32 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203626,0,0,'Y',TO_TIMESTAMP('2022-07-12 16:57:32','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-07-12 16:57:32','YYYY-MM-DD HH24:MI:SS'),0,'IsShowTitle','Show Title','Show Title','D','bf9b4ad5-68c4-4836-8af0-c4ca689bcc05')
;

-- Jul 12, 2022, 4:58:05 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215037,0,'Show Title',50010,'IsShowTitle','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-07-12 16:58:04','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-07-12 16:58:04','YYYY-MM-DD HH24:MI:SS'),0,203626,'Y','N','D','N','N','N','Y','425d1cae-6c95-4eef-a27b-eef7e9106e48','Y',0,'N','N','N','N')
;

-- Jul 12, 2022, 4:58:09 PM CEST
ALTER TABLE PA_DashboardContent ADD COLUMN IsShowTitle CHAR(1) DEFAULT 'Y' CHECK (IsShowTitle IN ('Y','N')) NOT NULL
;

-- Jul 12, 2022, 4:58:20 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207125,'Show Title',50010,215037,'Y',1,210,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-12 16:58:20','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2022-07-12 16:58:20','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','d0316669-2559-4a19-9eb9-0f2a5c704c6e','Y',200,2,2)
;

-- Jul 12, 2022, 4:58:32 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-12 16:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=207125
;

-- Jul 12, 2022, 4:58:32 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-12 16:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=56504
;

-- Jul 12, 2022, 4:58:32 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-12 16:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200268
;

-- Jul 12, 2022, 4:58:32 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-12 16:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200260
;

-- Jul 12, 2022, 4:58:32 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-12 16:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=202286
;

-- Jul 12, 2022, 4:59:01 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Chart_ID@ > 0', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-12 16:59:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=207125
;

