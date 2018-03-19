-- Jan 11, 2015 6:38:54 PM COT
-- IDEMPIERE-1425 Account element improvements
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (202809,0,0,'Y',TO_TIMESTAMP('2015-01-11 18:38:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-01-11 18:38:53','YYYY-MM-DD HH24:MI:SS'),100,'IsTreeDrivenByValue','Driven By Search Key','Defines if the tree is driven by the Search Key column','D','9ff38eb0-bbe7-4584-8682-f82f5cf9152b')
;

-- Jan 11, 2015 6:39:16 PM COT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (211812,0,'Driven By Search Key',288,'IsTreeDrivenByValue','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2015-01-11 18:39:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-01-11 18:39:16','YYYY-MM-DD HH24:MI:SS'),100,202809,'Y','N','U','N','N','N','Y','a55184b0-1acc-433e-8df2-cd00b8aa77a3','Y',0,'N','N')
;

-- Jan 11, 2015 6:39:17 PM COT
ALTER TABLE AD_Tree ADD COLUMN IsTreeDrivenByValue CHAR(1) DEFAULT 'N' CHECK (IsTreeDrivenByValue IN ('Y','N')) NOT NULL
;

-- Jan 11, 2015 6:39:32 PM COT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (203480,'Driven By Search Key',243,211812,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2015-01-11 18:39:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2015-01-11 18:39:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','ac15015d-0eef-4e66-b2fb-6a2fa0f60a1f','Y',100,2,2)
;

-- Jan 11, 2015 6:39:47 PM COT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, XPosition=5,Updated=TO_TIMESTAMP('2015-01-11 18:39:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203480
;

-- Jan 11, 2015 6:39:47 PM COT
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2015-01-11 18:39:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5228
;

-- Jan 11, 2015 6:39:47 PM COT
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2015-01-11 18:39:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12421
;

-- Jan 11, 2015 6:39:47 PM COT
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2015-01-11 18:39:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8371
;

-- Jan 11, 2015 6:39:56 PM COT
UPDATE AD_Element SET Name='Driven by Search Key',Updated=TO_TIMESTAMP('2015-01-11 18:39:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202809
;

-- Jan 11, 2015 6:39:56 PM COT
UPDATE AD_Column SET ColumnName='IsTreeDrivenByValue', Name='Driven by Search Key', Description=NULL, Help=NULL WHERE AD_Element_ID=202809
;

-- Jan 11, 2015 6:39:56 PM COT
UPDATE AD_Process_Para SET ColumnName='IsTreeDrivenByValue', Name='Driven by Search Key', Description=NULL, Help=NULL, AD_Element_ID=202809 WHERE UPPER(ColumnName)='ISTREEDRIVENBYVALUE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 11, 2015 6:39:56 PM COT
UPDATE AD_Process_Para SET ColumnName='IsTreeDrivenByValue', Name='Driven by Search Key', Description=NULL, Help=NULL WHERE AD_Element_ID=202809 AND IsCentrallyMaintained='Y'
;

-- Jan 11, 2015 6:39:56 PM COT
UPDATE AD_InfoColumn SET ColumnName='IsTreeDrivenByValue', Name='Driven by Search Key', Description=NULL, Help=NULL WHERE AD_Element_ID=202809 AND IsCentrallyMaintained='Y'
;

-- Jan 11, 2015 6:39:56 PM COT
UPDATE AD_Field SET Name='Driven by Search Key', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202809) AND IsCentrallyMaintained='Y'
;

-- Jan 11, 2015 6:39:56 PM COT
UPDATE AD_PrintFormatItem SET PrintName='Defines if the tree is driven by the Search Key column', Name='Driven by Search Key' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202809)
;

SELECT register_migration_script('201501111840_IDEMPIERE-1425.sql') FROM dual
;

