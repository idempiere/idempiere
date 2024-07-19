-- IDEMPIERE-5409
SELECT register_migration_script('202209061547_IDEMPIERE-5409.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 6, 2022, 3:47:13 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203651,0,0,'Y',TO_TIMESTAMP('2022-09-06 15:47:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 15:47:13','YYYY-MM-DD HH24:MI:SS'),100,'IsMaximizable','Is Maximizable','Is Maximizable','D','250c4f55-23e9-48d7-b5b4-0154ecf8b52a')
;

-- Sep 6, 2022, 3:48:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215283,0,'Is Maximizable',50010,'IsMaximizable','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-09-06 15:48:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 15:48:40','YYYY-MM-DD HH24:MI:SS'),100,203651,'Y','N','D','N','N','N','Y','afa27a31-f8f8-4bc4-a734-b136e430793a','Y',0,'N','N','N','N')
;

-- Sep 6, 2022, 3:50:01 PM CEST
ALTER TABLE PA_DashboardContent ADD IsMaximizable CHAR(1) DEFAULT 'Y' CHECK (IsMaximizable IN ('Y','N')) NOT NULL
;

-- Sep 6, 2022, 3:50:30 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207187,'Is Maximizable',50010,215283,'Y',0,230,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-06 15:50:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 15:50:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9e4cf3b1-6063-45be-af56-40a8fb1a4a4f','Y',220,1,1,1,'N','N','N','N')
;

-- Sep 6, 2022, 3:51:26 PM CEST
UPDATE AD_Element SET Name='Maximizable', PrintName='Maximizable',Updated=TO_TIMESTAMP('2022-09-06 15:51:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203651
;

-- Sep 6, 2022, 3:51:26 PM CEST
UPDATE AD_Column SET ColumnName='IsMaximizable', Name='Maximizable', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203651
;

-- Sep 6, 2022, 3:51:26 PM CEST
UPDATE AD_Process_Para SET ColumnName='IsMaximizable', Name='Maximizable', Description=NULL, Help=NULL, AD_Element_ID=203651 WHERE UPPER(ColumnName)='ISMAXIMIZABLE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 6, 2022, 3:51:26 PM CEST
UPDATE AD_Process_Para SET ColumnName='IsMaximizable', Name='Maximizable', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203651 AND IsCentrallyMaintained='Y'
;

-- Sep 6, 2022, 3:51:26 PM CEST
UPDATE AD_InfoColumn SET ColumnName='IsMaximizable', Name='Maximizable', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203651 AND IsCentrallyMaintained='Y'
;

-- Sep 6, 2022, 3:51:26 PM CEST
UPDATE AD_Field SET Name='Maximizable', Description=NULL, Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203651) AND IsCentrallyMaintained='Y'
;

-- Sep 6, 2022, 3:51:26 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Maximizable', Name='Maximizable' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203651)
;

-- Sep 6, 2022, 3:52:43 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 15:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207187
;

-- Sep 6, 2022, 3:52:43 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 15:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200260
;

-- Sep 6, 2022, 3:52:43 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 15:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202286
;

