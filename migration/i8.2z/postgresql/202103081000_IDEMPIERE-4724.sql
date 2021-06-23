-- Add column to allow concatenation on import
-- Mar 7, 2021, 9:03:37 PM UTC
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203480,0,0,'Y',TO_TIMESTAMP('2021-03-07 21:03:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-07 21:03:31','YYYY-MM-DD HH24:MI:SS'),100,'ImportPrefix','Import prefix','This prefix will be added in front of import string if they are not empty','Use it e.g. when concatening input fields into one import field to add a blank','Import prefix','D','a7213dfc-f1fc-49f5-b15a-9e66a49b74dc')
;

-- Mar 7, 2021, 9:05:04 PM UTC
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214417,0,'Import prefix','This prefix will be added in front of import string if they are not empty','Use it e.g. when concatening input fields into one import field to add a blank',382,'ImportPrefix',20,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-03-07 21:04:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-07 21:04:58','YYYY-MM-DD HH24:MI:SS'),100,203480,'Y','N','D','N','N','N','Y','cf947051-dad5-4143-8988-275cb457689c','Y',0,'N','N','N','N')
;

-- Mar 7, 2021, 9:07:31 PM UTC
ALTER TABLE AD_ImpFormat_Row ADD COLUMN ImportPrefix VARCHAR(20) DEFAULT NULL
;

-- Mar 7, 2021, 9:08:09 PM UTC
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206602,'Import prefix','This prefix will be added in front of import string if they are not empty','Use it e.g. when concatening input fields into one import field to add a blank',316,214417,'Y',20,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-03-07 21:08:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-03-07 21:08:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','62227bb3-45fc-447f-a6f1-e9d724a40880','Y',180,2)
;

-- Mar 7, 2021, 9:08:39 PM UTC
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206602
;

-- Mar 7, 2021, 9:08:39 PM UTC
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3734
;

-- Mar 7, 2021, 9:08:39 PM UTC
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3735
;

-- Mar 7, 2021, 9:08:39 PM UTC
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3740
;

-- Mar 7, 2021, 9:08:40 PM UTC
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=3741
;

-- Mar 7, 2021, 9:08:40 PM UTC
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=5324
;

-- Mar 7, 2021, 9:09:10 PM UTC
UPDATE AD_Field SET DisplayLogic='@DataType@=S', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-03-07 21:09:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206602
;

SELECT register_migration_script('202103081000_IDEMPIERE-4724.sql') FROM dual
;


