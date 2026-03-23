-- IDEMPIERE-6706 Error installing 2Pack using ALL-CLIENTS approach
SELECT register_migration_script('202510271512_IDEMPIERE-6706.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 27, 2025, 3:12:50 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204020,0,0,'Y',TO_TIMESTAMP('2025-10-27 15:12:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-27 15:12:49','YYYY-MM-DD HH24:MI:SS'),100,'IsIncludeOrganizationId','Include Organization Id','Y/N field. When set to Y, include organization id reference in exported data.','Include Organization Id','D','019a2483-36d7-7bca-bf7a-29cb56f43812')
;

-- Oct 27, 2025, 3:13:44 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217164,0,'Include Organization Id','Y/N field. When set to Y, include organization id reference in exported data.',50005,'IsIncludeOrganizationId','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-10-27 15:13:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-27 15:13:43','YYYY-MM-DD HH24:MI:SS'),100,204020,'Y','N','D','N','N','N','Y','019a2484-08d6-79b6-b2bd-dc56935bed69','Y',0,'N','N','N','N')
;

-- Oct 27, 2025, 3:14:32 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208976,'Include Organization Id','Y/N field. When set to Y, include organization id reference in exported data.',50005,217164,'Y','@#AD_Client_ID@>0',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-10-27 15:14:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-27 15:14:31','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019a2484-c4d8-7569-b0d6-1c4525125ebe','Y',110,1,1,1,'N','N','N','N','N')
;

-- Oct 27, 2025, 3:15:00 PM MYT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=2, ColumnSpan=2,Updated=TO_TIMESTAMP('2025-10-27 15:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208976
;

-- Oct 27, 2025, 3:15:00 PM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2025-10-27 15:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50085
;

-- Oct 27, 2025, 3:15:00 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-10-27 15:15:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204546
;

-- Oct 27, 2025, 3:50:17 PM MYT
ALTER TABLE AD_Package_Exp ADD IsIncludeOrganizationId CHAR(1) DEFAULT 'Y' CHECK (IsIncludeOrganizationId IN ('Y','N')) NOT NULL
;
