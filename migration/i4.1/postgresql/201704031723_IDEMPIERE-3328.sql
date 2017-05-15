-- IDEMPIERE-3328
-- Apr 3, 2017 5:18:41 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203064,0,0,'Y',TO_TIMESTAMP('2017-04-03 17:18:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-03 17:18:40','YYYY-MM-DD HH24:MI:SS'),100,'IsLoadAllNodesImmediately','Loads directly all nodes','If checked, all nodes are loaded before tree is displayed','Loads directly all nodes','D','decd8ab6-f0dd-441a-8842-25d9cb9e3b3f')
;

-- Apr 3, 2017 5:19:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (212971,0,'Loads directly all nodes','If checked, all nodes are loaded before tree is displayed',288,'IsLoadAllNodesImmediately','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2017-04-03 17:19:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-03 17:19:13','YYYY-MM-DD HH24:MI:SS'),100,203064,'Y','N','D','N','N','N','Y','692e44f6-4653-4a06-b68e-05fa3382202d','N',0,'N','N')
;

-- May 3, 2017 5:34:24 PM CEST
ALTER TABLE AD_Tree ADD COLUMN IsLoadAllNodesImmediately CHAR(1) DEFAULT 'Y' CHECK (IsLoadAllNodesImmediately IN ('Y','N')) NOT NULL
;

-- Apr 3, 2017 5:19:18 PM CEST
INSERT INTO t_alter_column values('ad_tree','IsLoadAllNodesImmediately','CHAR(1)',null,'Y')
;

-- Apr 3, 2017 5:19:18 PM CEST
UPDATE AD_Tree SET IsLoadAllNodesImmediately='Y' WHERE IsLoadAllNodesImmediately IS NULL
;

-- Apr 3, 2017 5:19:47 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (204379,'Loads directly all nodes','If checked, all nodes are loaded before tree is displayed',243,212971,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-04-03 17:19:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-04-03 17:19:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c66c870e-2b9a-41cb-86f8-74c7b9e4b538','Y',110,2,2)
;

-- Apr 3, 2017 5:20:08 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-03 17:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203826
;

-- Apr 3, 2017 5:20:08 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-03 17:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5228
;

-- Apr 3, 2017 5:20:08 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-03 17:20:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12421
;

-- Apr 3, 2017 5:20:09 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-04-03 17:20:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8371
;

SELECT register_migration_script('201704031723_IDEMPIERE-3328.sql') FROM dual
;
