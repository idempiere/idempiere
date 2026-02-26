-- Add DisplaySQL And DisplayIdentifier Columns In AD_Ref_Table.
-- Mar 26, 2019 4:53:29 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203310,0,0,'Y',TO_TIMESTAMP('2019-03-26 16:53:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-26 16:53:29','YYYY-MM-DD HH24:MI:SS'),100,'DisplaySQL','Display SQL','SQL for display of lookup value','Fully qualified subquery SQL','Display SQL','D','c96835c1-3b33-4cde-b19d-14c9eae7161a')
;

-- Mar 26, 2019 4:54:03 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203311,0,0,'Y',TO_TIMESTAMP('2019-03-26 16:54:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-26 16:54:02','YYYY-MM-DD HH24:MI:SS'),100,'IsDisplayIdentifier','Display Identifier','Display the record identifier','Display the columns that are marked as part of the identifier for this table.','Display Identifier','D','4511d2ef-c258-4b34-9fed-8aa66c42f6ce')
;

-- Mar 26, 2019 4:56:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213865,0,'Display SQL','SQL for display of lookup value','Fully qualified subquery SQL',103,'DisplaySQL',999999,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2019-03-26 16:56:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-26 16:56:16','YYYY-MM-DD HH24:MI:SS'),100,203310,'Y','N','D','N','N','N','Y','380ecb40-7cce-4543-ba73-ae54b67b22a7','Y',0,'N','N')
;

-- Mar 26, 2019 4:57:38 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213866,0,'Display Identifier','Display the record identifier','Display the columns that are marked as part of the identifier for this table.',103,'IsDisplayIdentifier','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2019-03-26 16:57:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-26 16:57:37','YYYY-MM-DD HH24:MI:SS'),100,203311,'Y','N','D','N','N','N','Y','04f94e76-2a50-4e70-95ce-3b54fd14ddf6','Y',0,'N','N')
;

-- Mar 26, 2019 4:57:45 PM IST
ALTER TABLE AD_Ref_Table ADD COLUMN IsDisplayIdentifier CHAR(1) DEFAULT 'N' CHECK (IsDisplayIdentifier IN ('Y','N')) NOT NULL
;

-- Mar 26, 2019 4:58:01 PM IST
ALTER TABLE AD_Ref_Table ADD COLUMN DisplaySQL VARCHAR(4000) DEFAULT NULL 
;

-- Mar 26, 2019 5:00:05 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205956,'Display SQL','SQL for display of lookup value','Fully qualified subquery SQL',103,213865,'Y','@IsDisplayIdentifier@=N',0,75,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-03-26 17:00:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-26 17:00:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9deb050e-ebc4-4a0c-918a-594df1b83053','Y',75,1,5,1,'N','N','N','N')
;

-- Mar 26, 2019 5:02:23 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (205957,'Display Identifier','Display the record identifier','Display the columns that are marked as part of the identifier for this table.',103,213866,'Y',0,55,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-03-26 17:02:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-26 17:02:22','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4034459f-9c1a-474a-b4ba-3cc941c0e3c3','Y',55,2,2,1,'N','N','N','N')
;

-- Mar 26, 2019 5:02:51 PM IST
UPDATE AD_Field SET DisplayLogic='@IsDisplayIdentifier@=N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-26 17:02:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1266
;

SELECT register_migration_script('202406060655_IDEMPIERE-6163.sql') FROM dual
;
