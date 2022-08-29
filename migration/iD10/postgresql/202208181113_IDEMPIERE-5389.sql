-- IDEMPIERE-5389
SELECT register_migration_script('202208181113_IDEMPIERE-5389.sql') FROM dual;

-- Aug 16, 2022, 4:52:58 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200203,0,0,TO_TIMESTAMP('2022-08-16 16:52:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2022-08-16 16:52:58','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','DASHBOARD_LAYOUT_ORIENTATION','R','C - columns (vertical layout) / R - rows (horizontal layout)','D','C','4de26350-c352-4552-87be-44abe331f821')
;

-- Aug 23, 2022, 4:20:08 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203636,0,0,'Y',TO_TIMESTAMP('2022-08-23 16:20:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-23 16:20:08','YYYY-MM-DD HH24:MI:SS'),100,'FlexGrow','Flex Grow','This defines the ability for a flex item to grow if necessary. It accepts a unitless value that serves as a proportion. It dictates what amount of the available space inside the flex container the item should take up.','Flex Grow','D','8e8273ad-4c34-4f21-bc01-a8b621bf3c38')
;

-- Aug 23, 2022, 4:20:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215100,0,'Flex Grow','This defines the ability for a flex item to grow if necessary. It accepts a unitless value that serves as a proportion. It dictates what amount of the available space inside the flex container the item should take up.',200013,'FlexGrow','1',14,'N','N','Y','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2022-08-24 14:02:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-24 14:02:11','YYYY-MM-DD HH24:MI:SS'),100,203636,'Y','N','D','N','N','N','Y','5de27289-cab8-4533-9639-9eb66cd84c7f','Y',0,'N','N','N')
;

-- Aug 23, 2022, 4:20:44 PM CEST
ALTER TABLE PA_DashboardPreference ADD COLUMN FlexGrow NUMERIC(10) DEFAULT '1' NOT NULL
;

-- Aug 23, 2022, 4:21:32 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207136,'Flex Grow','This defines the ability for a flex item to grow if necessary. It accepts a unitless value that serves as a proportion. It dictates what amount of the available space inside the flex container the item should take up.',200011,215100,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-08-23 16:21:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-23 16:21:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7bf531c3-d79b-493c-b3ec-84160feb5927','Y',110,1,1,1,'N','N','N','N')
;

-- Aug 23, 2022, 4:21:54 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-23 16:21:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207136
;

-- Aug 23, 2022, 4:21:54 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-23 16:21:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200300
;

-- Aug 23, 2022, 4:21:54 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-23 16:21:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200307
;

-- Aug 23, 2022, 4:21:54 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-23 16:21:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200303
;

-- Aug 23, 2022, 4:21:54 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-23 16:21:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204983
;

