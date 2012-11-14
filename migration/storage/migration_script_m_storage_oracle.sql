-- Oct 16, 2012 11:14:31 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,IsCentrallyMaintained,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','3',145,200026,'N','N','N','U','Y','N','L','M_StorageOnHand','M_StorageOnHand',0,'Y',0,100,TO_DATE('2012-10-16 11:14:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-10-16 11:14:30','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 16, 2012 11:14:31 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Oct 16, 2012 11:14:34 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,CreatedBy,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive) VALUES (1,'N',200000,'Y',100,1000000,1000000,'N','Y',200026,'Table M_StorageOnHand','M_StorageOnHand',0,0,TO_DATE('2012-10-16 11:14:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-10-16 11:14:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 16, 2012 11:14:41 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (DefaultValue,AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@AD_Client_ID@',200026,200614,'U',1,'Y','N','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'N',129,'N',102,'N','Y','N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client','N',100,TO_DATE('2012-10-16 11:14:40','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:40','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:41 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200614 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:42 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (DefaultValue,AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@AD_Org_ID@',200026,200615,'U',1,'Y','N','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'N',130,'N',113,'N','Y','N','N','N','AD_Org_ID','Organizational entity within client','Organization','N',100,TO_DATE('2012-10-16 11:14:41','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:41','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:42 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200615 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:45 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200616,'U',1,'Y','N','N','The Created field indicates the date that this record was created.','N',7,'N',16,'N','N',245,'N','Y','N','N','N','Created','Date this record was created','Created','N',100,TO_DATE('2012-10-16 11:14:42','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:45 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200616 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:46 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200617,'U',1,110,'Y','N','N','The Created By field indicates the user who created this record.','N',22,'N',18,'N','N',246,'N','Y','N','N','N','CreatedBy','User who created this records','Created By','N',100,TO_DATE('2012-10-16 11:14:45','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:45','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:46 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200617 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:48 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200618,'U',1,'N','N','N','The Date Last Inventory Count indicates the last time an Inventory count was done.','N',7,'N',15,'N','N',1088,'N','Y','N','Y','N','DateLastInventory','Date of Last Inventory Count','Date last inventory count','Y',100,TO_DATE('2012-10-16 11:14:46','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:48 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200618 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:50 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (DefaultValue,AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200026,200619,'U',1,'Y','N','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'N','N',348,'N','Y','N','N','N','IsActive','The record is active in the system','Active','N',100,TO_DATE('2012-10-16 11:14:48','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:48','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:50 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200619 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:51 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200620,'U',1,'Y','N','N',0,'The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','Y',22,'N',35,'N','N',2019,'N','Y','N','N','N','M_AttributeSetInstance_ID','Product Attribute Set Instance','Attribute Set Instance','Y',100,TO_DATE('2012-10-16 11:14:50','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:50','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:51 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200620 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:52 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200621,'U',1,'Y','N','N','The Locator indicates where in a Warehouse a product is located.','Y',22,'N',31,'N','N',448,'N','Y','N','N','N','M_Locator_ID','Warehouse Locator','Locator','Y',100,TO_DATE('2012-10-16 11:14:51','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:51','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:52 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200621 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:52 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200622,'U',1,'Y','N','N','Identifies an item which is either purchased or sold in this organization.','Y',22,'N',30,'N',231,'N',454,'N','Y','N','N','N','M_Product_ID','Product, Service, Item','Product','Y',100,TO_DATE('2012-10-16 11:14:52','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:52 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200622 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:53 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200623,'U',1,'Y','N','N','The On Hand Quantity indicates the quantity of a product that is on hand in a warehouse.','N',22,'N',29,'N','N',530,'N','Y','N','N','N','QtyOnHand','On Hand Quantity','On Hand Quantity','Y',100,TO_DATE('2012-10-16 11:14:52','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:53 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200623 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:55 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200624,'U',1,'Y','N','N','The Ordered Quantity indicates the quantity of a product that was ordered.','N',22,'N',29,'N','N',531,'N','Y','N','N','N','QtyOrdered','Ordered Quantity','Ordered Quantity','Y',100,TO_DATE('2012-10-16 11:14:53','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:53','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:55 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200624 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:56 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200625,'U',1,'Y','N','N','The Reserved Quantity indicates the quantity of a product that is currently reserved.','N',22,'N',29,'N','N',532,'N','Y','N','N','N','QtyReserved','Reserved Quantity','Reserved Quantity','Y',100,TO_DATE('2012-10-16 11:14:55','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:56 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200625 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:56 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200626,'U',1,'Y','N','N','The Updated field indicates the date that this record was updated.','N',7,'N',16,'N','N',607,'N','Y','N','N','N','Updated','Date this record was updated','Updated','N',100,TO_DATE('2012-10-16 11:14:56','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:56 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200626 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:14:57 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200026,200627,'U',1,110,'Y','N','N','The Updated By field indicates the user who updated this record.','N',22,'N',18,'N','N',608,'N','Y','N','N','N','UpdatedBy','User who updated this records','Updated By','N',100,TO_DATE('2012-10-16 11:14:56','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:14:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:14:57 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200627 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:15:19 AM WIT
-- Resolve M_Storage locking and data consistency
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=200624
;

-- Oct 16, 2012 11:15:19 AM WIT
-- Resolve M_Storage locking and data consistency
DELETE FROM AD_Column WHERE AD_Column_ID=200624
;

-- Oct 16, 2012 11:15:19 AM WIT
-- Resolve M_Storage locking and data consistency
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=200625
;

-- Oct 16, 2012 11:15:19 AM WIT
-- Resolve M_Storage locking and data consistency
DELETE FROM AD_Column WHERE AD_Column_ID=200625
;

-- Oct 16, 2012 11:15:32 AM WIT
-- Resolve M_Storage locking and data consistency
CREATE TABLE M_StorageOnHand (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, DateLastInventory DATE DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, M_AttributeSetInstance_ID NUMBER(10) NOT NULL, M_Locator_ID NUMBER(10) NOT NULL, M_Product_ID NUMBER(10) NOT NULL, QtyOnHand NUMBER NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT M_StorageOnHand_Key PRIMARY KEY (M_AttributeSetInstance_ID, M_Locator_ID, M_Product_ID))
;

-- Oct 16, 2012 11:16:16 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,IsCentrallyMaintained,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','3',145,200027,'N','N','N','U','Y','N','L','M_StorageReservation','M_StorageReservation',0,'Y',0,100,TO_DATE('2012-10-16 11:16:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-10-16 11:16:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 16, 2012 11:16:16 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Oct 16, 2012 11:16:17 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,CreatedBy,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive) VALUES (1,'N',200000,'Y',100,1000000,1000000,'N','Y',200027,'Table M_StorageReservation','M_StorageReservation',0,0,TO_DATE('2012-10-16 11:16:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-10-16 11:16:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Oct 16, 2012 11:16:24 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (DefaultValue,AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@AD_Client_ID@',200027,200628,'U',1,'Y','N','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'N',129,'N',102,'N','Y','N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client','N',100,TO_DATE('2012-10-16 11:16:23','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:24 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200628 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:24 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (DefaultValue,AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@AD_Org_ID@',200027,200629,'U',1,'Y','N','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'N',130,'N',113,'N','Y','N','N','N','AD_Org_ID','Organizational entity within client','Organization','N',100,TO_DATE('2012-10-16 11:16:24','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:24 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200629 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:25 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200630,'U',1,'Y','N','N','The Created field indicates the date that this record was created.','N',7,'N',16,'N','N',245,'N','Y','N','N','N','Created','Date this record was created','Created','N',100,TO_DATE('2012-10-16 11:16:24','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:25 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200630 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:26 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200631,'U',1,110,'Y','N','N','The Created By field indicates the user who created this record.','N',22,'N',18,'N','N',246,'N','Y','N','N','N','CreatedBy','User who created this records','Created By','N',100,TO_DATE('2012-10-16 11:16:25','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:26 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200631 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:28 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200632,'U',1,'N','N','N','The Date Last Inventory Count indicates the last time an Inventory count was done.','N',7,'N',15,'N','N',1088,'N','Y','N','Y','N','DateLastInventory','Date of Last Inventory Count','Date last inventory count','Y',100,TO_DATE('2012-10-16 11:16:26','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:28 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200632 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:29 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (DefaultValue,AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200027,200633,'U',1,'Y','N','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'N','N',348,'N','Y','N','N','N','IsActive','The record is active in the system','Active','N',100,TO_DATE('2012-10-16 11:16:28','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:29 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200633 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:29 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200634,'U',1,'Y','N','N',0,'The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','Y',22,'N',35,'N','N',2019,'N','Y','N','N','N','M_AttributeSetInstance_ID','Product Attribute Set Instance','Attribute Set Instance','Y',100,TO_DATE('2012-10-16 11:16:29','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:29 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200634 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:30 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200635,'U',1,'Y','N','N','The Locator indicates where in a Warehouse a product is located.','Y',22,'N',31,'N','N',448,'N','Y','N','N','N','M_Locator_ID','Warehouse Locator','Locator','Y',100,TO_DATE('2012-10-16 11:16:29','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:30 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200635 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:31 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200636,'U',1,'Y','N','N','Identifies an item which is either purchased or sold in this organization.','Y',22,'N',30,'N',231,'N',454,'N','Y','N','N','N','M_Product_ID','Product, Service, Item','Product','Y',100,TO_DATE('2012-10-16 11:16:30','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:31 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200636 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:32 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200637,'U',1,'Y','N','N','The On Hand Quantity indicates the quantity of a product that is on hand in a warehouse.','N',22,'N',29,'N','N',530,'N','Y','N','N','N','QtyOnHand','On Hand Quantity','On Hand Quantity','Y',100,TO_DATE('2012-10-16 11:16:31','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:32 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200637 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:33 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200638,'U',1,'Y','N','N','The Updated field indicates the date that this record was updated.','N',7,'N',16,'N','N',607,'N','Y','N','N','N','Updated','Date this record was updated','Updated','N',100,TO_DATE('2012-10-16 11:16:32','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:33 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200638 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:16:33 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (AD_Table_ID,AD_Column_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200027,200639,'U',1,110,'Y','N','N','The Updated By field indicates the user who updated this record.','N',22,'N',18,'N','N',608,'N','Y','N','N','N','UpdatedBy','User who updated this records','Updated By','N',100,TO_DATE('2012-10-16 11:16:33','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:16:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:16:33 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200639 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:17:01 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Column SET Help='The Quantity indicates the number of a specific product or item for this document.', AD_Element_ID=526, ColumnName='Qty', Description='Quantity', Name='Quantity',Updated=TO_DATE('2012-10-16 11:17:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200637
;

-- Oct 16, 2012 11:17:01 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200637
;

-- Oct 16, 2012 11:17:01 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Field SET Name='Quantity', Description='Quantity', Help='The Quantity indicates the number of a specific product or item for this document.' WHERE AD_Column_ID=200637 AND IsCentrallyMaintained='Y'
;

-- Oct 16, 2012 11:17:12 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Column SET Help='The Warehouse identifies a unique Warehouse where products are stored or Services are provided.', AD_Element_ID=459, IsUpdateable='N', ColumnName='M_Warehouse_ID', Description='Storage Warehouse and Service Point', Name='Warehouse',Updated=TO_DATE('2012-10-16 11:17:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200635
;

-- Oct 16, 2012 11:17:12 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200635
;

-- Oct 16, 2012 11:17:12 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Field SET Name='Warehouse', Description='Storage Warehouse and Service Point', Help='The Warehouse identifies a unique Warehouse where products are stored or Services are provided.' WHERE AD_Column_ID=200635 AND IsCentrallyMaintained='Y'
;

-- Oct 16, 2012 11:17:20 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Column SET AD_Reference_ID=19, IsUpdateable='N',Updated=TO_DATE('2012-10-16 11:17:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200635
;

-- Oct 16, 2012 11:17:35 AM WIT
-- Resolve M_Storage locking and data consistency
UPDATE AD_Column SET AD_Val_Rule_ID=189, IsUpdateable='N',Updated=TO_DATE('2012-10-16 11:17:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200635
;

-- Oct 16, 2012 11:18:05 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column (DefaultValue,AD_Table_ID,AD_Column_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200027,200640,'U',0,'N','N','N',0,'The Sales Transaction checkbox indicates if this item is a Sales Transaction.','N',1,'N',20,'N','N',1106,'N','Y','N','Y','N','IsSOTrx','This is a Sales Transaction','Sales Transaction','Y',100,TO_DATE('2012-10-16 11:18:04','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-10-16 11:18:04','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Oct 16, 2012 11:18:05 AM WIT
-- Resolve M_Storage locking and data consistency
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200640 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 16, 2012 11:18:28 AM WIT
-- Resolve M_Storage locking and data consistency
CREATE TABLE M_StorageReservation (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, DateLastInventory DATE DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsSOTrx CHAR(1) DEFAULT 'Y' CHECK (IsSOTrx IN ('Y','N')), M_AttributeSetInstance_ID NUMBER(10) NOT NULL, M_Product_ID NUMBER(10) NOT NULL, M_Warehouse_ID NUMBER(10) NOT NULL, Qty NUMBER NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT M_StorageReservation_Key PRIMARY KEY (M_AttributeSetInstance_ID, M_Product_ID, M_Warehouse_ID))
;

