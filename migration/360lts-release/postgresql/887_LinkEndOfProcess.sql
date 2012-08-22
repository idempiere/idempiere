-- Aug 19, 2012 3:40:16 PM IST

-- Link end-of-process to next window
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,578,200320,'U','N','N','N',0,'N',14,'N',19,'N','N',126,'N','Y','f0b8be7d-2a2a-4c1e-a4b6-d6fe23e4c771','N','Y','N','AD_Table_ID','Database Table information','The Database Table provides the information of the table definition','Table','Y',100,TO_TIMESTAMP('2012-08-19 15:41:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-19 15:41:44','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 19, 2012 3:41:46 PM IST
-- Link end-of-process to next window
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200320 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2012 3:42:25 PM IST
-- Link end-of-process to next window
ALTER TABLE AD_PInstance_Log ADD COLUMN AD_Table_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 19, 2012 3:44:14 PM IST
-- Link end-of-process to next window
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,578,200321,'U','N','N','N',0,'N',14,'N',11,'N','N',538,'N','Y','dcf3a178-7018-4e7d-b449-cf852fb97390','N','Y','N','Record_ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','Record ID','Y',100,TO_TIMESTAMP('2012-08-19 15:44:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-19 15:44:13','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 19, 2012 3:44:14 PM IST
-- Link end-of-process to next window
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200321 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2012 3:45:16 PM IST
-- Link end-of-process to next window
ALTER TABLE AD_PInstance_Log ADD COLUMN Record_ID NUMERIC(10) DEFAULT NULL 
;


UPDATE AD_System
  SET LastMigrationScriptApplied='887_LinkEndOfProcess.sql'
WHERE LastMigrationScriptApplied<'887_LinkEndOfProcess.sql'
   OR LastMigrationScriptApplied IS NULL
;