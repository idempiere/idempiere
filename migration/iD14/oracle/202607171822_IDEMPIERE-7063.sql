-- IDEMPIERE-7063
SELECT register_migration_script('202607171822_IDEMPIERE-7063.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 17, 2026, 6:22:22 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204118,0,0,'Y',TO_TIMESTAMP('2026-07-17 18:22:22','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-07-17 18:22:22','YYYY-MM-DD HH24:MI:SS'),10,'IsDisplayedGridInDetail','Open in Grid Mode when tab is detail','Open in Grid Mode when tab is detail','D','019f70e2-d95d-7863-bcee-c2a5cc125f7a')
;

-- Jul 17, 2026, 6:22:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217652,0,'Open in Grid Mode when tab is detail',200008,'IsDisplayedGridInDetail',1,'N','N','N','N','N',0,'N',17,319,0,0,'Y',TO_TIMESTAMP('2026-07-17 18:22:56','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-07-17 18:22:56','YYYY-MM-DD HH24:MI:SS'),10,204118,'Y','N','D','N','N','N','Y','019f70e3-5c2c-777f-99ba-979c0f8d9ad6','Y',0,'N','N','N','N')
;

-- Jul 17, 2026, 6:22:57 PM CEST
ALTER TABLE AD_Tab_Customization ADD IsDisplayedGridInDetail CHAR(1) DEFAULT NULL 
;

