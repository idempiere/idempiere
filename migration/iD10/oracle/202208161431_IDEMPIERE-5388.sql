-- IDEMPIERE-5388
SELECT register_migration_script('202208161431_IDEMPIERE-5388.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 16, 2022, 2:31:08 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203635,0,0,'Y',TO_TIMESTAMP('2022-08-16 14:31:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-16 14:31:08','YYYY-MM-DD HH24:MI:SS'),100,'LastRefreshDateColumn','Last Refresh Date Column','Last Refresh Date Column','D','3e3d956e-a4f2-47e1-886f-b0d29df8dba2')
;

-- Aug 16, 2022, 2:33:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215098,0,'Last Refresh Date Column',53282,'LastRefreshDateColumn',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-08-16 14:33:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-16 14:33:31','YYYY-MM-DD HH24:MI:SS'),100,203635,'Y','N','D','N','N','N','Y','9e2cc7ea-467d-4f70-a285-282c355b2906','Y',0,'N','N','N')
;

-- Aug 16, 2022, 2:33:37 PM CEST
ALTER TABLE AD_ChartDatasource ADD LastRefreshDateColumn VARCHAR2(60 CHAR) DEFAULT NULL 
;

-- Aug 16, 2022, 2:35:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207134,'Last Refresh Date Column',53340,215098,'Y',0,170,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-08-16 14:35:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-16 14:35:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','87ad673b-3742-49f2-8799-73b31bbc1692','Y',10,1,1,1,'N','N','N','N')
;

-- Aug 16, 2022, 2:36:19 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-16 14:36:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207134
;

-- Aug 16, 2022, 2:36:19 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-16 14:36:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59617
;

-- Aug 16, 2022, 2:36:19 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-16 14:36:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59612
;

-- Aug 16, 2022, 2:36:19 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-16 14:36:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=59604
;

-- Aug 16, 2022, 2:36:19 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-16 14:36:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204475
;

