-- IDEMPIERE-6576 System configuration as context variable
SELECT register_migration_script('202506181034_IDEMPIERE-6576.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 18, 2025, 10:34:29 AM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Help,PrintName,EntityType,AD_Element_UU) VALUES (204011,0,0,'Y',TO_TIMESTAMP('2025-06-18 10:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 10:34:28','YYYY-MM-DD HH24:MI:SS'),100,'IsLoadAsContext','Load as Context','If set to true, the system configuration will be loaded in the global context.','Load as Context','D','421488a4-8ed2-4462-b269-cb61ffefc422')
;

-- Jun 18, 2025, 10:34:30 AM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217131,0,'Load as Context','If set to true, the system configuration will be loaded in the global context.',50009,'IsLoadAsContext','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-06-18 10:34:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 10:34:29','YYYY-MM-DD HH24:MI:SS'),100,204011,'Y','N','D','Y','N','N','Y','9347b4c9-84ee-4a16-865c-1280fc53720a','Y',0,'N','N','N','N','N')
;

-- Jun 18, 2025, 11:16:45 AM IST
ALTER TABLE AD_SysConfig ADD IsLoadAsContext CHAR(1) DEFAULT 'N' CHECK (IsLoadAsContext IN ('Y','N')) NOT NULL
;

-- Jun 18, 2025, 10:34:30 AM IST
UPDATE AD_SysConfig SET IsLoadAsContext='N' WHERE IsLoadAsContext IS NULL
;

-- Jun 18, 2025, 10:34:31 AM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,DisplayLogic,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208794,'Load as Context','If set to true, the system configuration will be loaded in the global context.',50009,217131,'Y',1,90,'N','N','N','@#AD_Client_ID@=0','N',0,0,'Y',TO_TIMESTAMP('2025-06-18 10:34:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-06-18 10:34:30','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0f5c357f-7cdf-43d5-b41a-296624a3ff5e','Y',90,5,2,1,'N','N','N','N')
;
