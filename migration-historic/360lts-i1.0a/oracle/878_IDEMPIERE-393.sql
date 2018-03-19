-- Aug 16, 2012 4:41:38 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','2',0,200012,'N','N','N','Y','D','N','L','627cd49d-d311-4b47-8a01-f99992edbcd0','Y','Y','AD_WizardProcess','Wizard Process',0,'Y',0,100,TO_DATE('2012-08-16 16:41:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:41:37','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 16, 2012 4:41:38 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 16, 2012 4:41:38 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',50000,'Y',1000000,1000000,'N','Y',200011,'Table AD_WizardProcess','AD_WizardProcess',1,'3f66868f-2837-4ee1-9475-f36e101240da',0,0,TO_DATE('2012-08-16 16:41:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:41:38','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Aug 16, 2012 4:46:00 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200306,'D','Y','N','N',0,'N',22,'N',19,'N',129,'N',102,'N','Y','2c70ff3d-e64a-49c5-abeb-86054ec9d28c','N','N','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2012-08-16 16:45:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:45:59','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:00 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200306 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:01 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200307,'D','Y','N','N',0,'N',22,'N',19,'N',104,'N',113,'N','Y','b8b33d75-938f-473d-8a28-c7bf2bab2b4c','N','N','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2012-08-16 16:46:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:01','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:01 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200307 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:01 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200308,'D','Y','N','N',0,'N',7,'N',16,'N','N',245,'N','Y','08e46e32-da39-46e6-8607-9aab1470d76e','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2012-08-16 16:46:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:01','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200308 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:02 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200309,'D',110,'Y','N','N',0,'N',22,'N',18,'N','N',246,'N','Y','d4a465e3-103e-4aee-8f79-d273db5a37c7','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2012-08-16 16:46:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:02','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200309 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:02 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200310,'D','N','N','N',0,'N',255,'Y',10,'N','N',275,'N','Y','d3e69713-bb88-418f-bc56-4d4dfc601bae','N','Y','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_DATE('2012-08-16 16:46:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:02','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200310 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:03 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200311,'D','N','N','N',0,'N',2000,'N',14,'N','N',326,'N','Y','ea75b9e0-bfb4-48ae-917d-7d5037f2f038','N','Y','N','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',100,TO_DATE('2012-08-16 16:46:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:02','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200311 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:03 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200312,'D','Y','N','N',0,'N',1,'N',20,'N','N',348,'N','Y','b0f20af0-70b5-43db-8b69-060842f710f1','N','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2012-08-16 16:46:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200312 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:04 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_WizardProcess_ID',200092,'D','Wizard Process','Wizard Process','1eba27dc-0eab-4bd6-babc-6f02fd547439',0,TO_DATE('2012-08-16 16:46:03','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-16 16:46:03','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 16, 2012 4:46:04 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200092 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 16, 2012 4:46:04 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200313,'D','Y','N','N',0,'N',22,'N',13,'N','Y',200092,'N','Y','a9b20d20-3d44-4aa3-a8fb-85f335c090ac','N','N','N','AD_WizardProcess_ID','Wizard Process','N',100,TO_DATE('2012-08-16 16:46:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:03','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:05 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200313 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:05 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200012,200314,'D','N','N','N','N',36,'N',10,'N','N',55044,'N','Y','b0acec5a-e325-40ab-97f2-8d69f1c8a872','N','Y','N','M_RMAType_UU','M_RMAType_UU','N',100,TO_DATE('2012-08-16 16:46:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:05 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200314 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:05 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200315,'D','Y','N','Y',1,'N',60,'Y',10,'N','N',469,'N','Y','79f20c60-9c13-403a-bf9f-e31dca2c0bb3','N','Y','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_DATE('2012-08-16 16:46:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:05 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200315 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:06 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200316,'D','Y','N','N',0,'N',7,'N',16,'N','N',607,'N','Y','53214a14-26e9-4f6d-a177-be4a09395f61','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2012-08-16 16:46:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:06 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200316 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:46:06 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200012,200317,'D',110,'Y','N','N',0,'N',22,'N',18,'N','N',608,'N','Y','c9e90e19-7f6d-42da-ba22-695863800dad','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2012-08-16 16:46:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-16 16:46:06','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 16, 2012 4:46:06 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200317 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 16, 2012 4:47:33 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_WizardProcess_UU',200093,'D','AD_WizardProcess_UU','AD_WizardProcess_UU','07515fbf-92fa-4d3d-8cf7-77efb872944d',0,TO_DATE('2012-08-16 16:47:32','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-16 16:47:32','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 16, 2012 4:47:33 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200093 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 16, 2012 4:47:44 PM COT
UPDATE AD_Column SET AD_Element_ID=200093, ColumnName='AD_WizardProcess_UU', Description=NULL, Help=NULL, Name='AD_WizardProcess_UU',Updated=TO_DATE('2012-08-16 16:47:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200314
;

-- Aug 16, 2012 4:47:44 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200314
;

-- Aug 16, 2012 4:47:44 PM COT
UPDATE AD_Field SET Name='AD_WizardProcess_UU', Description=NULL, Help=NULL WHERE AD_Column_ID=200314 AND IsCentrallyMaintained='Y'
;

-- Aug 16, 2012 4:48:51 PM COT
UPDATE AD_Column SET IsIdentifier='N', SeqNo=0, IsParent='Y', FieldLength=10, AD_Reference_ID=30, AD_Element_ID=142, IsUpdateable='N', ColumnName='AD_WF_Node_ID', Description='Workflow Node (activity), step or process', Help='The Workflow Node indicates a unique step or process in a Workflow.', Name='Node',Updated=TO_DATE('2012-08-16 16:48:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200315
;

-- Aug 16, 2012 4:48:51 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200315
;

-- Aug 16, 2012 4:48:51 PM COT
UPDATE AD_Field SET Name='Node', Description='Workflow Node (activity), step or process', Help='The Workflow Node indicates a unique step or process in a Workflow.' WHERE AD_Column_ID=200315 AND IsCentrallyMaintained='Y'
;

-- Aug 16, 2012 4:49:35 PM COT
UPDATE AD_Column SET AD_Element_ID=1115, ColumnName='Note', Description='Optional additional user defined information', Help='The Note field allows for optional entry of user defined information regarding this record', Name='Note',Updated=TO_DATE('2012-08-16 16:49:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200311
;

-- Aug 16, 2012 4:49:35 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200311
;

-- Aug 16, 2012 4:49:35 PM COT
UPDATE AD_Field SET Name='Note', Description='Optional additional user defined information', Help='The Note field allows for optional entry of user defined information regarding this record' WHERE AD_Column_ID=200311 AND IsCentrallyMaintained='Y'
;

-- Aug 16, 2012 4:50:30 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('WizardStatus',200094,'D','Wizard Status','Wizard Status','06dab4e9-6080-40b5-a4a7-fa1d871ec058',0,TO_DATE('2012-08-16 16:50:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-16 16:50:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 16, 2012 4:50:30 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200094 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 16, 2012 4:53:33 PM COT
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200003,'AD_WizardProcess Status','D','2ecdcec7-e361-4926-a8f7-a2f72bfd12e5','N','L',0,0,100,TO_DATE('2012-08-16 16:53:27','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-08-16 16:53:27','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 16, 2012 4:53:33 PM COT
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200003 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Aug 16, 2012 4:55:01 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200008,200003,'D','New','dd3f4502-2914-44af-b66f-1620f64c50a3','N',TO_DATE('2012-08-16 16:55:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:55:00','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Aug 16, 2012 4:55:01 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Aug 16, 2012 4:55:11 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200009,200003,'D','Pending','00609fa8-5d40-4d42-ba37-b5919acdc782','P',TO_DATE('2012-08-16 16:55:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:55:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Aug 16, 2012 4:55:11 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Aug 16, 2012 4:55:23 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200010,200003,'D','Finished','9829c724-da26-4442-ba9d-2d93d6e7858f','F',TO_DATE('2012-08-16 16:55:22','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:55:22','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Aug 16, 2012 4:55:23 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Aug 16, 2012 4:55:34 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200011,200003,'D','In-Progress','c79db7f7-2646-483b-bb19-36164ffbabb9','I',TO_DATE('2012-08-16 16:55:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:55:33','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Aug 16, 2012 4:55:34 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200011 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Aug 16, 2012 4:55:45 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200012,200003,'D','Skipped','a3d49831-ba26-4f4b-91f4-24f44b09b812','S',TO_DATE('2012-08-16 16:55:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:55:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Aug 16, 2012 4:55:45 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Aug 16, 2012 4:55:54 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200013,200003,'D','Delayed','4e09d396-3fa6-461d-9cca-b2aede0c6e2a','D',TO_DATE('2012-08-16 16:55:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-16 16:55:53','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Aug 16, 2012 4:55:54 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Aug 16, 2012 4:56:29 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=200003, FieldLength=1, IsSelectionColumn='N', AD_Reference_ID=17, AD_Element_ID=200094, ColumnName='WizardStatus', Description=NULL, Help=NULL, Name='Wizard Status',Updated=TO_DATE('2012-08-16 16:56:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200310
;

-- Aug 16, 2012 4:56:29 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200310
;

-- Aug 16, 2012 4:56:29 PM COT
UPDATE AD_Field SET Name='Wizard Status', Description=NULL, Help=NULL WHERE AD_Column_ID=200310 AND IsCentrallyMaintained='Y'
;

-- Aug 16, 2012 4:57:28 PM COT
CREATE TABLE AD_WizardProcess (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_WF_Node_ID NUMBER(10) NOT NULL, AD_WizardProcess_ID NUMBER(10) NOT NULL, AD_WizardProcess_UU NVARCHAR2(36) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Note NVARCHAR2(2000) DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, WizardStatus CHAR(1) DEFAULT NULL , CONSTRAINT AD_WizardProcess_Key PRIMARY KEY (AD_WizardProcess_ID))
;

create unique index AD_WizardProcess_uu_idx on AD_WizardProcess(AD_WizardProcess_UU);

-- Aug 16, 2012 5:41:16 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_DATE('2012-08-16 17:41:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1206
;

-- Aug 16, 2012 5:41:20 PM COT
alter table AD_WF_Node add ( temp_column clob );

update AD_WF_Node set temp_column=Help, Help=null;

alter table AD_WF_Node drop column Help;

alter table AD_WF_Node rename column temp_column to Help;

-- Aug 16, 2012 5:42:15 PM COT
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_DATE('2012-08-16 17:42:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2290
;

-- Aug 16, 2012 5:42:18 PM COT
alter table AD_WF_Node_Trl add ( temp_column clob );

update AD_WF_Node_Trl set temp_column=Help, Help=null;

alter table AD_WF_Node_Trl drop column Help;

alter table AD_WF_Node_Trl rename column temp_column to Help;

-- Aug 16, 2012 6:47:08 PM COT
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_DATE('2012-08-16 18:47:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=238
;

-- Aug 16, 2012 6:47:14 PM COT
alter table AD_Workflow add ( temp_column clob );

update AD_Workflow set temp_column=Help, Help=null;

alter table AD_Workflow drop column Help;

alter table AD_Workflow rename column temp_column to Help;

-- Aug 16, 2012 6:47:35 PM COT
UPDATE AD_Column SET FieldLength=0, AD_Reference_ID=36,Updated=TO_DATE('2012-08-16 18:47:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=316
;

-- Aug 16, 2012 6:47:38 PM COT
alter table AD_Workflow_Trl add ( temp_column clob );

update AD_Workflow_Trl set temp_column=Help, Help=null;

alter table AD_Workflow_Trl drop column Help;

alter table AD_Workflow_Trl rename column temp_column to Help;

-- Aug 17, 2012 4:05:21 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Form (AccessLevel,Classname,AD_Form_ID,IsBetaFunctionality,EntityType,AD_Form_UU,Name,AD_Org_ID,UpdatedBy,CreatedBy,Updated,Created,AD_Client_ID,IsActive) VALUES ('2','org.compiere.apps.form.VSetupWizard',200000,'N','D','7df89045-cd20-46e3-94fb-e0b80e4084f8','Setup Wizard',0,100,100,TO_DATE('2012-08-17 16:05:20','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-17 16:05:20','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Aug 17, 2012 4:05:21 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Form_Trl (AD_Language,AD_Form_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Form_Trl_UU ) SELECT l.AD_Language,t.AD_Form_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Form t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Form_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Form_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Form_ID=t.AD_Form_ID)
;

-- Aug 17, 2012 4:05:37 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Form_ID,EntityType,IsCentrallyMaintained,Name,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200009,'N','N','N',200000,'D','Y','Setup Wizard','X','b733d9bd-95b2-4192-9668-59702307f624','Y',0,100,TO_DATE('2012-08-17 16:05:37','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-08-17 16:05:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 17, 2012 4:05:37 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Aug 17, 2012 4:05:37 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200009, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200009)
;

-- Aug 17, 2012 4:05:44 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_Preference SET Value='Y',Updated=TO_DATE('2012-08-17 16:05:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000009
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Aug 17, 2012 4:06:01 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Aug 17, 2012 4:06:48 PM COT
-- IDEMPIERE-393 Setup wizards
UPDATE AD_Preference SET Value='N',Updated=TO_DATE('2012-08-17 16:06:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000009
;

-- Aug 17, 2012 4:07:33 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200014,328,'D','Wizard','f1ffc07b-f822-4659-bdd7-e8dde31acac5','W',TO_DATE('2012-08-17 16:07:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-08-17 16:07:32','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Aug 17, 2012 4:07:33 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Aug 17, 2012 5:04:14 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Properties',200013,'D','d9f0db1a-5655-466c-8961-c1424b0ff275','Properties','Y',TO_DATE('2012-08-17 17:04:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-08-17 17:04:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 17, 2012 5:04:14 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Aug 20, 2012 3:51:46 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','{0} tasks completed from {1} ({2}% advance)',200014,'D','60c03fae-3b77-4307-8454-64690aacc517','SetupWizardProgress','Y',TO_DATE('2012-08-20 15:51:45','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-08-20 15:51:45','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 20, 2012 3:51:46 PM COT
-- IDEMPIERE-393 Setup wizards
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Set initial workflows on the wizard
UPDATE AD_Workflow SET WorkflowType='W', Priority=1 WHERE AD_Workflow_ID=104; -- Initial Client Setup Review

UPDATE AD_Workflow SET WorkflowType='W', Priority=2 WHERE AD_Workflow_ID=106; -- Business Partner Setup

UPDATE AD_Workflow SET WorkflowType='W', Priority=3 WHERE AD_Workflow_ID=107; -- Product Setup

UPDATE AD_Workflow SET WorkflowType='W', Priority=4 WHERE AD_Workflow_ID=111; -- Sales Setup

UPDATE AD_Workflow SET WorkflowType='W', Priority=5 WHERE AD_Workflow_ID=108; -- Price List Setup

UPDATE AD_Workflow SET WorkflowType='W', Priority=6 WHERE AD_Workflow_ID=110; -- Tax Setup

UPDATE AD_System
  SET LastMigrationScriptApplied='878_IDEMPIERE-393.sql'
WHERE LastMigrationScriptApplied<'878_IDEMPIERE-393.sql'
   OR LastMigrationScriptApplied IS NULL
;
