-- Oct 9, 2013 4:44:19 PM MYT
-- 1003322 2Pack enhancement for Extension Development
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsExportDictionaryEntity',202618,'Export Dictionary Entity','Export Dictionary Entity','3d4310f3-fec3-4e92-9c4b-c8febabce9e6',TO_TIMESTAMP('2013-10-09 16:44:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-09 16:44:16','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Oct 9, 2013 4:44:53 PM MYT
-- 1003322 2Pack enhancement for Extension Development
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,50005,210878,'Y','N','N',0,'N',1,'N',20,'N','N','Y','d4142a11-aa11-404f-864c-d6ec13f036c6','Y','IsExportDictionaryEntity','N','Export Dictionary Entity','Y',TO_TIMESTAMP('2013-10-09 16:44:52','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-10-09 16:44:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202618,'N')
;

-- Oct 9, 2013 4:44:59 PM MYT
-- 1003322 2Pack enhancement for Extension Development
ALTER TABLE AD_Package_Exp ADD COLUMN IsExportDictionaryEntity CHAR(1) DEFAULT 'N' CHECK (IsExportDictionaryEntity IN ('Y','N')) NOT NULL
;

-- Oct 9, 2013 4:46:02 PM MYT
-- 1003322 2Pack enhancement for Extension Development
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,IsAdvancedField) VALUES (0,'N',50005,0,'N','N',210878,100,'Y',202525,'N','D','Export Dictionary Entity','1b303e2f-6aad-4a7e-a5e9-61430a74f821','Y','N',100,0,TO_TIMESTAMP('2013-10-09 16:46:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-09 16:46:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,2,'N',0,2,1,'N')
;

-- Oct 9, 2013 4:47:05 PM MYT
-- 1003322 2Pack enhancement for Extension Development
UPDATE AD_Field SET SeqNo=100, SeqNoGrid=100, XPosition=2,Updated=TO_TIMESTAMP('2013-10-09 16:47:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50085
;

-- Oct 9, 2013 4:47:22 PM MYT
-- 1003322 2Pack enhancement for Extension Development
UPDATE AD_Field SET SeqNo=90, SeqNoGrid=90, XPosition=5,Updated=TO_TIMESTAMP('2013-10-09 16:47:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202525
;

-- Oct 9, 2013 5:59:32 PM MYT
-- 1003322 2Pack enhancement for Extension Development
UPDATE AD_Field SET DisplayLogic='@AD_Client_ID@=0',Updated=TO_TIMESTAMP('2013-10-09 17:59:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202525
;

SELECT register_migration_script('201310090926_1003322.sql') FROM dual
;

