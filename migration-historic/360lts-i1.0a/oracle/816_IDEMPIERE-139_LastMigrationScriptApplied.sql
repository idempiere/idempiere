-- Feb 8, 2012 5:46:45 PM COT
-- IDEMPIERE-139 Store the last migration script applied
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,EntityType,Name,Description,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200002,'LastMigrationScriptApplied',NULL,'D','Last Migration Script Applied','Register of the filename for the last migration script applied on this database','Last Migration Script Applied',0,TO_DATE('2012-02-08 17:46:44','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-02-08 17:46:44','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Feb 8, 2012 5:46:45 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 8, 2012 5:48:50 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200015,531,'D',0,'N','N','N',0,'N',255,'N',10,'N','N',200002,'N','Y','N','Y','N','LastMigrationScriptApplied','Register of the filename for the last migration script applied on this database','Last Migration Script Applied','Y',100,TO_DATE('2012-02-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-02-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 8, 2012 5:48:50 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200015 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 8, 2012 5:49:09 PM COT
ALTER TABLE AD_System ADD LastMigrationScriptApplied NVARCHAR2(255) DEFAULT NULL 
;

-- Feb 8, 2012 5:51:34 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,'N',40,'Y','N','N',200015,'N',290,'Y',440,200000,'N','D','Register of the filename for the last migration script applied on this database','Last Migration Script Applied',100,0,'Y',TO_DATE('2012-02-08 17:51:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-02-08 17:51:34','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 8, 2012 5:51:34 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='816_IDEMPIERE-139_LastMigrationScriptApplied.sql'
WHERE LastMigrationScriptApplied<'816_IDEMPIERE-139_LastMigrationScriptApplied.sql'
   OR LastMigrationScriptApplied IS NULL
;
