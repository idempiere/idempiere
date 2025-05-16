-- IDEMPIERE-6549 - Add option to Disable "Insufficient Inventory" Popup
SELECT register_migration_script('202505161145_IDEMPIERE-6549.sql') FROM dual;

-- May 16, 2025, 11:45:47 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204007,0,0,'Y',TO_TIMESTAMP('2025-05-16 11:45:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-16 11:45:47','YYYY-MM-DD HH24:MI:SS'),100,'IsDisableInventoryPopup','Disable Insufficient Inventory Popup','Disable Insufficient Inventory Popup','D','562efe6f-a1d7-4bee-8ba9-3c908905d26d')
;

-- May 16, 2025, 11:46:28 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217115,0,'Disable Insufficient Inventory Popup',190,'IsDisableInventoryPopup','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2025-05-16 11:46:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-16 11:46:27','YYYY-MM-DD HH24:MI:SS'),100,204007,'Y','N','D','N','N','N','Y','b2d7b19f-780b-4df9-b24f-f90f91929771','Y',0,'N','N','N','N')
;

-- May 16, 2025, 11:46:36 AM CEST
ALTER TABLE M_Warehouse ADD COLUMN IsDisableInventoryPopup CHAR(1) DEFAULT 'N' CHECK (IsDisableInventoryPopup IN ('Y','N')) NOT NULL
;

-- May 16, 2025, 11:47:44 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm,IsHtml) VALUES (208778,'Disable Insufficient Inventory Popup',177,217115,'Y',0,140,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-05-16 11:47:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-05-16 11:47:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6712b4d7-87a9-4a42-b488-4bb3d74883b7','Y',140,2,2,1,'N','N','N','N','N')
;

