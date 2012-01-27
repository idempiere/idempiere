-- Jan 27, 2012 3:19:59 PM COT
-- IDEMPIERE-127 Implement Recent Items dashboard
INSERT INTO AD_Element (AD_Element_ID,PrintName,EntityType,ColumnName,Name,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200000,'Recent Item','D','AD_RecentItem_ID','Recent Item',0,TO_TIMESTAMP('2012-01-27 15:19:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-01-27 15:19:57','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Jan 27, 2012 3:19:59 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, PrintName,Help,PO_Description,PO_Help,Name,Description,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.PrintName,t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 27, 2012 3:20:26 PM COT
UPDATE AD_Element_Trl SET IsTranslated='Y',Name='Registro Reciente',PrintName='Registro Reciente',Updated=TO_TIMESTAMP('2012-01-27 15:20:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200000 AND AD_Language LIKE 'es_%'
;

-- Jan 27, 2012 3:21:36 PM COT
INSERT INTO AD_Table (IsSecurityEnabled,ImportTable,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsChangeLog,IsView,CopyColumnsFromTable,EntityType,IsCentrallyMaintained,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','N','7',0,200000,'N','N','N','N','D','Y','Y','L','AD_RecentItem','Recent Item',0,'Y',0,100,TO_TIMESTAMP('2012-01-27 15:21:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-01-27 15:21:35','YYYY-MM-DD HH24:MI:SS'))
;

-- Jan 27, 2012 3:21:36 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Jan 27, 2012 3:21:37 PM COT
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,CreatedBy,IsActive) VALUES (1,'N',50000,'Y',1000000,1000000,'N','Y',200000,'Table AD_RecentItem','AD_RecentItem',0,0,TO_TIMESTAMP('2012-01-27 15:21:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-01-27 15:21:36','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 27, 2012 3:22:36 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Client_ID@',200000,200000,'D',0,'Y','N','N',0,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'N','N',102,'N','Y','N','Y','N','AD_Client_ID','Client/Tenant for this installation.','Client','N',100,TO_TIMESTAMP('2012-01-27 15:22:35','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:22:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:22:36 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:25:24 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Org_ID@',200001,200000,'D',0,'Y','N','N',0,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'N',104,'N',113,'N','Y','N','N','N','AD_Org_ID','Organizational entity within client','Organization','N',100,TO_TIMESTAMP('2012-01-27 15:25:23','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:25:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:25:24 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:25:54 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200002,200000,'D',0,'Y','N','N',0,'N',22,'N',13,'N','Y',200000,'N','Y','N','N','N','AD_RecentItem_ID','Recent Item','N',100,TO_TIMESTAMP('2012-01-27 15:25:54','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:25:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:25:54 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:26:23 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200003,200000,'D',0,'Y','N','N',0,'The Role determines security and access a user who has this Role will have in the System.','N',10,'N',19,'N','N',123,'N','Y','N','Y','N','AD_Role_ID','Responsibility Role','Role','Y',100,TO_TIMESTAMP('2012-01-27 15:26:22','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:26:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:26:23 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200003 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:26:50 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200004,200000,'D',0,'N','N','N',0,'The Tab indicates a tab that displays within a window.','N',10,'N',19,'N','N',125,'N','Y','N','Y','N','AD_Tab_ID','Tab within a Window','Tab','Y',100,TO_TIMESTAMP('2012-01-27 15:26:49','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:26:49','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:26:50 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200004 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:27:15 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200005,200000,'D',0,'Y','N','N',0,'The Database Table provides the information of the table definition','N',10,'N',19,'N','N',126,'N','Y','N','Y','N','AD_Table_ID','Database Table information','Table','Y',100,TO_TIMESTAMP('2012-01-27 15:27:14','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:27:14','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:27:15 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:27:34 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200006,200000,'D',0,'N','N','N',0,'The User identifies a unique user in the system. This could be an internal user or a business partner contact','N',10,'N',30,'N','N',138,'N','Y','N','Y','N','AD_User_ID','User within the system - Internal or Business Partner Contact','User/Contact','Y',100,TO_TIMESTAMP('2012-01-27 15:27:34','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:27:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:27:34 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200006 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:28:00 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200007,200000,'D',0,'N','N','N',0,'The Window field identifies a unique Window in the system.','N',10,'N',19,'N','N',143,'N','Y','N','Y','N','AD_Window_ID','Data entry or display window','Window','Y',100,TO_TIMESTAMP('2012-01-27 15:27:59','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:27:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:28:00 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:28:26 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200008,200000,'D',0,'Y','N','N',0,'The Created field indicates the date that this record was created.','N',7,'N',16,'N','N',245,'N','Y','N','N','N','Created','Date this record was created','Created','N',100,TO_TIMESTAMP('2012-01-27 15:28:26','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:28:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:28:26 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:28:56 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200009,200000,'D',0,110,'Y','N','N',0,'The Created By field indicates the user who created this record.','N',22,'N',18,'N','N',246,'N','Y','N','N','N','CreatedBy','User who created this records','Created By','N',100,TO_TIMESTAMP('2012-01-27 15:28:55','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:28:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:28:56 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:30:02 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200010,200000,'D',0,'Y','N','N',0,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'N','N',348,'N','Y','N','Y','N','IsActive','The record is active in the system','Active','N',100,TO_TIMESTAMP('2012-01-27 15:30:01','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:30:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:30:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:30:47 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200011,200000,'D',0,'Y','N','N',0,'The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.','N',10,'N',28,'N','N',538,'N','Y','N','Y','N','Record_ID','Direct internal record ID','Record ID','Y',100,TO_TIMESTAMP('2012-01-27 15:30:47','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:30:47','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:30:47 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200011 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:31:12 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200012,200000,'D',0,'Y','N','N',0,'The Updated field indicates the date that this record was updated.','N',7,'N',16,'N','N',607,'N','Y','N','Y','N','Updated','Date this record was updated','Updated','N',100,TO_TIMESTAMP('2012-01-27 15:31:11','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:31:11','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:31:12 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:31:43 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200013,200000,'D',0,110,'Y','N','N',0,'The Updated By field indicates the user who updated this record.','N',22,'N',18,'N','N',608,'N','Y','N','N','N','UpdatedBy','User who updated this records','Updated By','N',100,TO_TIMESTAMP('2012-01-27 15:31:42','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_TIMESTAMP('2012-01-27 15:31:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 27, 2012 3:31:43 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 27, 2012 3:31:53 PM COT
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2012-01-27 15:31:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200012
;

-- Jan 27, 2012 3:33:15 PM COT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2012-01-27 15:33:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200000
;

-- Jan 27, 2012 3:33:21 PM COT
CREATE TABLE AD_RecentItem (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_RecentItem_ID NUMERIC(10) NOT NULL, AD_Role_ID NUMERIC(10) NOT NULL, AD_Tab_ID NUMERIC(10) DEFAULT NULL , AD_Table_ID NUMERIC(10) NOT NULL, AD_User_ID NUMERIC(10) DEFAULT NULL , AD_Window_ID NUMERIC(10) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Record_ID NUMERIC(10) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_RecentItem_Key PRIMARY KEY (AD_RecentItem_ID))
;

-- Jan 27, 2012 3:34:35 PM COT
INSERT INTO PA_DashboardContent (Line,Description,PA_DashboardContent_ID,ZulFilePath,ColumnNo,IsCollapsible,GoalDisplay,Name,Created,CreatedBy,UpdatedBy,Updated,AD_Client_ID,IsActive,AD_Org_ID) VALUES (0,'Recent items',200000,'/zul/recentItems.zul',1,'Y','T','Recent Items',TO_TIMESTAMP('2012-01-27 15:34:34','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2012-01-27 15:34:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Jan 27, 2012 3:34:35 PM COT
INSERT INTO PA_DashboardContent_Trl (AD_Language,PA_DashboardContent_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.PA_DashboardContent_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, PA_DashboardContent t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.PA_DashboardContent_ID=200000 AND NOT EXISTS (SELECT * FROM PA_DashboardContent_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.PA_DashboardContent_ID=t.PA_DashboardContent_ID)
;

-- Jan 27, 2012 3:35:09 PM COT
UPDATE PA_DashboardContent_Trl SET IsTranslated='Y',Name='Registros recientes',Description='Registros recientes',Updated=TO_TIMESTAMP('2012-01-27 15:35:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE PA_DashboardContent_ID=200000 AND AD_Language LIKE 'es_%'
;

-- Jan 27, 2012 3:36:24 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,EntityType,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200000,'C','D','RecentItems_MaxShown','10','Max number of records to show on recent items dashboard',0,0,TO_TIMESTAMP('2012-01-27 15:36:23','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-01-27 15:36:23','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Jan 27, 2012 3:37:11 PM COT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,EntityType,Name,Value,Description,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive) VALUES (200001,'C','D','RecentItems_MaxSaved','50','Max number of records to save on recent items table per user',0,0,TO_TIMESTAMP('2012-01-27 15:37:11','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-01-27 15:37:11','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Jan 27, 2012 3:37:22 PM COT
UPDATE AD_SysConfig SET Description='Max number of records to save on recent items table per user/client',Updated=TO_TIMESTAMP('2012-01-27 15:37:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200001
;

