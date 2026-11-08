-- IDEMPIERE-7157 Add AD_SysConfig option for the rendering of report parameters in Excel format
SELECT register_migration_script('202610271213_IDEMPIERE-7157.sql') FROM dual;

-- Oct 27, 2026, 12:13:40 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204133,0,0,'Y',TO_TIMESTAMP('2026-10-27 12:13:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-27 12:13:40','YYYY-MM-DD HH24:MI:SS'),100,'IsExcelExportWithParameters','Excel Export with Parameters','Flag (Y/N) to include or exclude report parameters in the Excel export header.','A boolean flag (Y/N) that determines whether the applied filter criteria and report parameters are rendered in the header section of an exported Excel file. Leave blank to default to the SHOW_REPORT_PARAMETER_IN_XLS_REPORT System Configurator setting.','Excel Export with Parameters','D','01a17b90-5c6f-7001-9481-9453ef89a091')
;

-- Oct 27, 2026, 12:18:51 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217670,0,'Excel Export with Parameters','Flag (Y/N) to include or exclude report parameters in the Excel export header.','A boolean flag (Y/N) that determines whether the applied filter criteria and report parameters are rendered in the header section of an exported Excel file. Leave blank to default to the SHOW_REPORT_PARAMETER_IN_XLS_REPORT System Configurator setting.',200174,'IsExcelExportWithParameters',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_TIMESTAMP('2026-10-27 12:18:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-27 12:18:51','YYYY-MM-DD HH24:MI:SS'),100,204133,'Y','N','D','N','N','N','Y','01a17b95-1b10-782e-8759-32d4252d1a9d','Y',0,'N','N','N','N')
;

-- Oct 27, 2026, 12:19:07 PM MYT
ALTER TABLE AD_UserPreference ADD COLUMN IsExcelExportWithParameters CHAR(1) DEFAULT NULL 
;

-- Oct 27, 2026, 12:25:25 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (209254,'Excel Export with Parameters','Flag (Y/N) to include or exclude report parameters in the Excel export header.','A boolean flag (Y/N) that determines whether the applied filter criteria and report parameters are rendered in the header section of an exported Excel file. Leave blank to default to the SHOW_REPORT_PARAMETER_IN_XLS_REPORT System Configurator setting.',200189,217670,'Y',0,170,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-10-27 12:25:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-27 12:25:25','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a17b9b-1e82-7eb9-afa8-09fcfebde75c','Y',180,1,2,1,'N','N','N','N','N')
;

