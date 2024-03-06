-- IDEMPIERE-5859
SELECT register_migration_script('202402261025_IDEMPIERE-5859.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 26, 2024, 10:25:31 AM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203923,0,0,'Y',TO_TIMESTAMP('2024-02-26 10:25:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-26 10:25:31','YYYY-MM-DD HH24:MI:SS'),100,'ValueMultipleSelection','Value Multiple Selection','Comma separated values.','Value Multiple Selection','D','524cf798-efaf-44ee-8f3e-93967440c5e8')
;

-- Feb 26, 2024, 10:26:30 AM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216569,0,'Value Multiple Selection','Comma separated values.',561,'ValueMultipleSelection',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-02-26 10:26:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-26 10:26:30','YYYY-MM-DD HH24:MI:SS'),100,203923,'Y','N','D','N','N','N','Y','af13db33-37fb-44a5-a312-7398fca10f9d','Y',0,'N','N','N','N')
;

-- Feb 26, 2024, 10:26:37 AM CET
ALTER TABLE M_AttributeInstance ADD ValueMultipleSelection VARCHAR2(255 CHAR) DEFAULT NULL 
;

