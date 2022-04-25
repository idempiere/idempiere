-- Financial Report Header Print Format - Related Period To
-- Oct 14, 2019 4:05:49 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203370,0,0,'Y',TO_TIMESTAMP('2019-10-14 16:05:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-14 16:05:49','YYYY-MM-DD HH24:MI:SS'),100,'RelativePeriodTo','Relative Period To','Period offset (0 is current)','Relative Period To','D','30311109-8745-48d7-825f-a562fefe4c98')
;

-- Oct 14, 2019 4:06:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (214087,0,'Relative Period To','Period offset (0 is current)',446,'RelativePeriodTo','NULL',22,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2019-10-14 16:06:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-14 16:06:50','YYYY-MM-DD HH24:MI:SS'),100,203370,'Y','N','D','N','N','N','Y','48d4dd26-197e-4a9a-add3-f2e1d5ed0e22','Y',0,'N','N')
;

-- Oct 14, 2019 4:44:49 PM IST
ALTER TABLE PA_ReportColumn ADD COLUMN RelativePeriodTo NUMERIC DEFAULT NULL 
;

-- Oct 14, 2019 4:09:10 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206213,'Relative Period To','Period offset (0 is current)',374,214087,'Y','@ColumnType@=R',26,145,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-10-14 16:09:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-14 16:09:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ebe78b9f-d030-46fa-b1c0-eaafe2521d3a','Y',145,4,2,1,'N','N','N')
;

-- Nov 27, 2019 4:51:42 PM IST
UPDATE AD_Field SET DisplayLogic='@ColumnType@=R | @ColumnType@=S', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-11-27 16:51:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4757
;

-- Nov 27, 2019 4:51:47 PM IST
UPDATE AD_Field SET DisplayLogic='@ColumnType@=R | @ColumnType@=S', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-11-27 16:51:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206213
;

SELECT register_migration_script('201912301730_IDEMPIERE-4066.sql') FROM dual
;
