-- IDEMPIERE-4763 Add IsDefault to AD_StorageProvider and use it when creating a new tenant (FHCA-1165)
-- Apr 16, 2021, 5:27:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214419,0,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200037,'IsDefault','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2021-04-16 17:27:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-16 17:27:16','YYYY-MM-DD HH24:MI:SS'),100,1103,'Y','N','D','N','N','N','Y','e07c06a3-aeda-45e2-9427-a147501cddb1','Y',0,'N','N','N')
;

-- Apr 16, 2021, 5:27:23 PM CEST
ALTER TABLE AD_StorageProvider ADD COLUMN IsDefault CHAR(1) DEFAULT 'N' CHECK (IsDefault IN ('Y','N')) NOT NULL
;

-- Apr 16, 2021, 5:27:48 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206603,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200032,214419,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-04-16 17:27:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-04-16 17:27:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15879e5e-dc83-421a-a21b-bb54d96a0cad','Y',100,2,2)
;

-- Apr 16, 2021, 5:28:43 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 17:28:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206603
;

-- Apr 16, 2021, 5:28:43 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-04-16 17:28:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200860
;

SELECT register_migration_script('202104161730_IDEMPIERE-4763.sql') FROM dual
;

