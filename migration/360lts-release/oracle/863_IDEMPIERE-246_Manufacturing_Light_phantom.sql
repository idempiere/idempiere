-- Aug 7, 2012 12:09:22 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200241,53243,0,29,249,'QtyBatchSize',TO_DATE('2012-08-07 12:09:20','YYYY-MM-DD HH24:MI:SS'),100,'D',10,'Y','Y','Y','N','N','N','N','N','N','N','N','N','N','Y','Qty Batch Size',0,TO_DATE('2012-08-07 12:09:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;


-- Aug 7, 2012 12:10:25 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200241 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 7, 2012 12:21:48 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200241,200257,0,182,TO_DATE('2012-08-07 12:21:48','YYYY-MM-DD HH24:MI:SS'),100,10,'D','Y','Y','Y','N','N','N','N','N','Qty Batch Size',110,0,TO_DATE('2012-08-07 12:21:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 7, 2012 12:22:10 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200257 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 7, 2012 12:24:48 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsTranslated,IsUpdateable,Name,SeqNo,Updated,UpdatedBy,Version) VALUES (0,200242,2788,0,20,208,'IsPhantom',TO_DATE('2012-08-07 12:24:48','YYYY-MM-DD HH24:MI:SS'),100,'N','D',1,'Y','Y','Y','N','N','N','N','N','Y','N','N','N','N','Y','Phantom',0,TO_DATE('2012-08-07 12:24:48','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 7, 2012 12:24:48 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200242 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 7, 2012 12:25:44 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,SeqNo,SortNo,Updated,UpdatedBy) VALUES (0,200242,200258,0,53346,TO_DATE('2012-08-07 12:25:44','YYYY-MM-DD HH24:MI:SS'),100,'Phantom Component',1,'D','Phantom Component are not stored and produced with the product. This is an option to avoid maintaining an Engineering and Manufacturing Bill of Materials.','Y','Y','Y','N','N','N','N','Y','Phantom',205,0,TO_DATE('2012-08-07 12:25:44','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 7, 2012 12:25:55 PM CEST
-- Manufacturing Light phantom
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200258 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 7, 2012 12:50:26 PM CEST
-- Manufacturing Light phantom
UPDATE AD_Field SET IsSameLine='N',Updated=TO_DATE('2012-08-07 12:50:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=62007
;

UPDATE AD_System
  SET LastMigrationScriptApplied='863_IDEMPIERE-246_Manufacturing_Light_phantom.sql'
WHERE LastMigrationScriptApplied<'863_IDEMPIERE-246_Manufacturing_Light_phantom.sql'
   OR LastMigrationScriptApplied IS NULL
;
