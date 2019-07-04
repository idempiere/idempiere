-- Oct 4, 2017 12:52:05 PM SGT
-- IDEMPIERE-4000 Form Print Format: Make page break per row configurable
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Updated,Name,PrintName,AD_Element_UU,IsActive,Created,AD_Org_ID,CreatedBy,UpdatedBy,AD_Client_ID,EntityType) VALUES (203140,'IsBreakPagePerRecord',TO_TIMESTAMP('2017-10-04 12:52:04','YYYY-MM-DD HH24:MI:SS'),'Break page per record','Break page per record','a6f85751-0e20-4884-9847-dac86dcf68ee','Y',TO_TIMESTAMP('2017-10-04 12:52:04','YYYY-MM-DD HH24:MI:SS'),0,100,100,0,'D')
;

-- Oct 4, 2017 12:52:43 PM SGT
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton) VALUES (213255,0,'N',0,'Y','N','N',0,'N',1,'N','N','N','Y','c1b2233f-0644-43c2-ac69-612786eff16e',TO_TIMESTAMP('2017-10-04 12:52:43','YYYY-MM-DD HH24:MI:SS'),'Y','IsBreakPagePerRecord','N','Break page per record','Y','Y',100,100,'N',0,0,TO_TIMESTAMP('2017-10-04 12:52:43','YYYY-MM-DD HH24:MI:SS'),'U','N','N','N',203140,493,20,'N')
;

-- Oct 4, 2017 12:52:48 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200009, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200009)
;

-- Oct 4, 2017 12:52:48 PM SGT
ALTER TABLE AD_PrintFormat ADD COLUMN IsBreakPagePerRecord CHAR(1) DEFAULT 'Y' CHECK (IsBreakPagePerRecord IN ('Y','N')) NOT NULL
;

-- Oct 4, 2017 12:52:56 PM SGT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2017-10-04 12:52:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213255
;

-- Oct 4, 2017 12:53:20 PM SGT
INSERT INTO AD_TreeNode (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNode_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200010, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='TL' AND t.AD_Table_ID=282 AND NOT EXISTS (SELECT * FROM AD_TreeNode e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200010)
;

-- Oct 4, 2017 12:53:21 PM SGT
INSERT INTO AD_Field (AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,AD_Org_ID,Updated,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,AD_Client_ID,Created,ColumnSpan,AD_Column_ID,EntityType,AD_Tab_ID) VALUES (205242,'N',1,'N','N',250,'Y','N',0,TO_TIMESTAMP('2017-10-04 12:53:20','YYYY-MM-DD HH24:MI:SS'),'Break page per record','52295b98-6531-4988-9c17-4766618d1239','Y','N',100,100,'Y','Y',250,2,0,TO_TIMESTAMP('2017-10-04 12:53:20','YYYY-MM-DD HH24:MI:SS'),2,213255,'D',425)
;

-- Oct 4, 2017 12:54:13 PM SGT
UPDATE AD_Field SET DisplayLogic='@IsForm@=Y', AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-10-04 12:54:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205242
;

-- IDEMPIERE-4000 Form Print Format: Make page break per row configurable
-- Jul 4, 2019, 4:56:29 PM MYT
UPDATE AD_Element SET Name='Page break per record', Description='Page Break after each record', PrintName='Page break per record',Updated=TO_TIMESTAMP('2019-07-04 16:56:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203140
;

-- Jul 4, 2019, 4:56:30 PM MYT
UPDATE AD_Column SET ColumnName='IsBreakPagePerRecord', Name='Page break per record', Description='Page Break after each record', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203140
;

-- Jul 4, 2019, 4:56:30 PM MYT
UPDATE AD_Process_Para SET ColumnName='IsBreakPagePerRecord', Name='Page break per record', Description='Page Break after each record', Help=NULL, AD_Element_ID=203140 WHERE UPPER(ColumnName)='ISBREAKPAGEPERRECORD' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jul 4, 2019, 4:56:30 PM MYT
UPDATE AD_Process_Para SET ColumnName='IsBreakPagePerRecord', Name='Page break per record', Description='Page Break after each record', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203140 AND IsCentrallyMaintained='Y'
;

-- Jul 4, 2019, 4:56:30 PM MYT
UPDATE AD_InfoColumn SET ColumnName='IsBreakPagePerRecord', Name='Page break per record', Description='Page Break after each record', Help=NULL, Placeholder=NULL WHERE AD_Element_ID=203140 AND IsCentrallyMaintained='Y'
;

-- Jul 4, 2019, 4:56:30 PM MYT
UPDATE AD_Field SET Name='Page break per record', Description='Page Break after each record', Help=NULL, Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203140) AND IsCentrallyMaintained='Y'
;

-- Jul 4, 2019, 4:56:30 PM MYT
UPDATE AD_PrintFormatItem SET PrintName='Page break per record', Name='Page break per record' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203140)
;

SELECT register_migration_script('201907041543_IDEMPIERE-4000.sql') FROM dual
;
