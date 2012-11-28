-- Nov 23, 2012 6:06:09 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','N','N','3',0,200037,'N','N','N','D','L','3aa0dee7-006f-4e64-b7d4-e361a62736d6','Y','Y','AD_StorageProvider','AD_StorageProvider',0,'Y',0,100,TO_DATE('2012-11-23 18:06:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-23 18:06:09','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 23, 2012 6:06:09 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200037 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Nov 23, 2012 6:06:10 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo) VALUES ('N',200000,'Y',1000000,'N','Y',200033,'Table AD_StorageProvider','AD_StorageProvider',1,'e83a2dbe-f8e8-4dfd-be2f-dff711fb8513',0,0,TO_DATE('2012-11-23 18:06:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-23 18:06:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000)
;

-- Nov 23, 2012 6:07:04 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_StorageProvider_ID',200238,'D','AD_StorageProvider_ID','AD_StorageProvider_ID','ba365847-2f59-4e6b-b0e0-ccdcf24039fe',0,TO_DATE('2012-11-23 18:07:02','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-23 18:07:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 23, 2012 6:07:04 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200238 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 23, 2012 6:07:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200961,'D','N','N','N',0,'N',22,'N',13,'N',200238,'N','Y','88580a3a-b7a8-4e65-a94e-0608c96e9b90','Y','N','AD_StorageProvider_ID','AD_StorageProvider_ID','Y',TO_DATE('2012-11-23 18:07:53','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:07:53','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:07:54 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200961 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:09:12 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200962,'D','N','N','N',0,'N',22,'N',19,'N',102,'N','Y','a44813a8-a8b0-41b1-b88e-ed7fbc9a0cc1','Y','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2012-11-23 18:09:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:09:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:09:12 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200962 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:10:45 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200963,'D','N','N','N',0,'N',22,'N',19,'N',113,'N','Y','63422271-d59a-4917-b4e1-4abf845e7596','Y','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2012-11-23 18:10:44','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:10:44','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:10:45 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200963 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:12:12 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200964,'D','N','N','N',0,'N',7,'N',16,'N',245,'N','Y','0f56c969-9ba2-4eee-b903-127a78204259','Y','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2012-11-23 18:12:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:12:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:12:12 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200964 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:13:10 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200965,'D',110,'N','N','N',0,'N',22,'N',18,'N',246,'N','Y','dd621b78-2934-427d-bf2f-04935cb7f71f','Y','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2012-11-23 18:13:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:13:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:13:10 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200965 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:13:59 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200966,'D','N','N','N',0,'N',7,'N',16,'N',607,'N','Y','b6b79bc1-90f2-4656-bd23-c269bcb7836f','Y','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2012-11-23 18:13:58','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:13:58','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:13:59 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200966 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:14:38 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200967,'U',110,'N','N','N',0,'N',22,'N',18,'N',608,'N','Y','ca82ad38-95d9-4b19-b817-983664a8d448','Y','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2012-11-23 18:14:37','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:14:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:14:38 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200967 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:15:19 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200968,'D','N','N','N',0,'N',1,'N',20,'N',348,'N','Y','8a3bef85-7886-4415-9721-1276a2d4ddf8','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2012-11-23 18:15:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:15:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:15:19 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200968 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:17:09 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200969,'D','N','N','N',0,'N',60,'Y',10,'N',469,'N','Y','0f1f3927-5c86-414a-b973-6c9505d1a62e','Y','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2012-11-23 18:17:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:17:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:17:09 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200969 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:17:45 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Method',200239,'D','Method','Method','acaddc54-113d-4603-a94f-8c2f6beb5310',0,TO_DATE('2012-11-23 18:17:45','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-23 18:17:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 23, 2012 6:17:45 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200239 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 23, 2012 6:18:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200970,'D','N','N','N',0,'N',60,'N',10,'N',200239,'N','Y','14790a4c-b78f-42f4-b7f8-13f63cffcdbe','Y','N','Method','Method','Y',TO_DATE('2012-11-23 18:18:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:18:14','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:18:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200970 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:19:00 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200971,'D','N','N','N',0,'N',225,'N',10,'N',983,'N','Y','9a741611-a86a-4360-81b2-7b8f618ba941','Y','N','URL','Full URL address - e.g. http://www.idempiere.org','The URL defines an fully qualified web address like http://www.idempiere.org','URL','Y',TO_DATE('2012-11-23 18:18:59','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:18:59','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:19:00 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200971 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:19:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200972,'D','N','N','N',0,'N',255,'N',10,'N',3012,'N','Y','45e0f607-c654-456b-84df-066c2d229a18','Y','N','Folder','A folder on a local or remote system to store data into','We store files in folders, especially media files.','Folder','Y',TO_DATE('2012-11-23 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:19:38','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:19:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200972 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:21:23 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200973,'D','N','N','N',0,'N',60,'Y',10,'N',1903,'N','Y','2081bd64-ca7b-4bbf-8a30-a3229f2e9ef4','Y','N','UserName','Email of the responsible for the System','Email of the responsible person for the system (registered in WebStore)','Registered EMail','Y',TO_DATE('2012-11-23 18:21:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:21:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:21:23 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200973 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:22:06 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200974,'D','N','N','N',0,'N',255,'N',10,'N',498,'N','Y','8db1ec5a-9c4f-44ed-bd78-efdf84114534','Y','N','Password','Password of any length (case sensitive)','The Password for this User.  Passwords are required to identify authorized users.  For Adempiere Users, you can change the password via the Process "Reset Password".','Password','Y',TO_DATE('2012-11-23 18:22:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:22:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:22:06 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200974 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:22:33 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-11-23 18:22:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200967
;

-- Nov 23, 2012 6:23:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200019,'StorageProvider','D','b4cb87d1-d08f-4987-8f66-9f923d68ec2f','N','StorageProvider','L',0,0,100,TO_DATE('2012-11-23 18:23:38','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-11-23 18:23:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 23, 2012 6:23:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200019 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Nov 23, 2012 6:24:04 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200043,200019,'D','File System','826c7b7b-8412-4b36-a912-dcf4ae56c9c0','FileSystem',TO_DATE('2012-11-23 18:24:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-23 18:24:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 23, 2012 6:24:04 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200043 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 23, 2012 6:24:20 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200044,200019,'D','Database','f84a4deb-5b8b-4951-86af-3b0ae957ca9b','DB',TO_DATE('2012-11-23 18:24:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-23 18:24:19','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Nov 23, 2012 6:24:20 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200044 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Nov 23, 2012 6:24:40 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET AD_Reference_Value_ID=200019, AD_Reference_ID=17,Updated=TO_DATE('2012-11-23 18:24:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200970
;

-- Nov 23, 2012 6:25:36 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET AD_Reference_ID=40,Updated=TO_DATE('2012-11-23 18:25:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200971
;

-- Nov 23, 2012 6:26:11 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('N','M','N','N','N',0,0,'D','Storage Provider',200022,'18bd7875-684e-495f-8ecc-0faba7a6ff01',TO_DATE('2012-11-23 18:26:10','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-23 18:26:10','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Nov 23, 2012 6:26:11 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Nov 23, 2012 6:27:00 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N','N','N',200022,10,'N','N',200037,'N','N','N','Y','N',0,'fc14e1ae-e9b0-40ad-b9f0-d6b7c179762e','D','Storage Provider','Storage Provider',200032,0,0,TO_DATE('2012-11-23 18:26:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-23 18:26:59','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Nov 23, 2012 6:27:00 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200032 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Nov 23, 2012 6:27:12 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,1,'N','N',200968,'Y',200860,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','92044da6-5e3a-4f05-bd2e-d29cad8240c5','Y','N',100,0,TO_DATE('2012-11-23 18:27:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:12 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200860 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:13 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,22,'N','N',200961,'Y',200861,'N','D','AD_StorageProvider_ID','46651fa8-435c-4dcf-b4cf-349bb5febf6d','Y','N',100,0,TO_DATE('2012-11-23 18:27:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:13 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200861 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,22,'N','N',200962,'Y',200862,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','a5cc7cd7-d787-43d9-92bc-15a491b94685','Y','N',100,0,TO_DATE('2012-11-23 18:27:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:13','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200862 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,255,'N','N',200972,'Y',200863,'N','We store files in folders, especially media files.','D','A folder on a local or remote system to store data into','Folder','a315f114-eb88-449c-873b-59a516f4948a','Y','N',100,0,TO_DATE('2012-11-23 18:27:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200863 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:15 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,60,'N','N',200970,'Y',200864,'N','D','Method','cbbd3c67-480e-4ae4-b1f8-328d00fc8568','Y','N',100,0,TO_DATE('2012-11-23 18:27:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:14','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:15 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200864 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:15 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,60,'N','N',200969,'Y',200865,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','ebf98b82-d1a9-42d3-a4df-df1b4d5aaf70','Y','N',100,0,TO_DATE('2012-11-23 18:27:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:15 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200865 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,22,'N','N',200963,'Y',200866,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','3f002c70-92be-4ac1-a4d5-2ae2d3abb581','Y','N',100,0,TO_DATE('2012-11-23 18:27:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:15','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200866 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,255,'N','N',200974,'Y',200867,'N','The Password for this User.  Passwords are required to identify authorized users.  For Adempiere Users, you can change the password via the Process "Reset Password".','D','Password of any length (case sensitive)','Password','ca62493a-2f21-4060-9fc4-d063d64284ef','Y','N',100,0,TO_DATE('2012-11-23 18:27:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200867 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,60,'N','N',200973,'Y',200868,'N','Email of the responsible person for the system (registered in WebStore)','D','Email of the responsible for the System','Registered EMail','cf69a0b9-3b07-48a3-b432-903b08604fe3','Y','N',100,0,TO_DATE('2012-11-23 18:27:16','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:16','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200868 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:27:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,225,'N','N',200971,'Y',200869,'N','The URL defines an fully qualified web address like http://www.idempiere.org','D','Full URL address - e.g. http://www.idempiere.org','URL','d7b49310-21f9-41f2-9a1c-ea54246cf267','Y','N',100,0,TO_DATE('2012-11-23 18:27:17','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:27:17','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:27:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200869 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:28:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_StorageProvider_UU',200240,'D','AD_StorageProvider_UU','AD_StorageProvider_UU','fb335dc9-54b3-44d7-8ab3-6e8d5957925d',0,TO_DATE('2012-11-23 18:28:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-23 18:28:25','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 23, 2012 6:28:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200240 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 23, 2012 6:30:50 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,200037,200975,'U','N','N','N',0,'N',36,'N',10,'N',200240,'N','Y','e81e7f51-02b1-4bf7-9707-a01194b3741b','Y','N','AD_StorageProvider_UU','AD_StorageProvider_UU','N',TO_DATE('2012-11-23 18:30:49','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 18:30:49','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 6:30:50 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200975 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 6:31:07 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-11-23 18:31:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200975
;

-- Nov 23, 2012 6:31:23 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200032,36,'N','N',200975,'Y',200870,'N','D','AD_StorageProvider_UU','d3873062-f913-423a-b7c7-486178e007cb','Y','N',100,0,TO_DATE('2012-11-23 18:31:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 18:31:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Nov 23, 2012 6:31:23 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200870 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200861
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200870
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200862
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200866
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200865
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200864
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200869
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200863
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200868
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200867
;

-- Nov 23, 2012 6:32:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200860
;

-- Nov 23, 2012 6:34:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-11-23 18:34:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200862
;

-- Nov 23, 2012 6:34:39 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=2, XPosition=4,Updated=TO_DATE('2012-11-23 18:34:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200866
;

-- Nov 23, 2012 6:35:01 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-11-23 18:35:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200865
;

-- Nov 23, 2012 6:36:40 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=2, SeqNo=40, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-23 18:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200864
;

-- Nov 23, 2012 6:36:40 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=5, SeqNo=50,Updated=TO_DATE('2012-11-23 18:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200869
;

-- Nov 23, 2012 6:36:40 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=5, SeqNo=60,Updated=TO_DATE('2012-11-23 18:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200863
;

-- Nov 23, 2012 6:36:40 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET ColumnSpan=2, SeqNo=70,Updated=TO_DATE('2012-11-23 18:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200868
;

-- Nov 23, 2012 6:36:40 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=80, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-23 18:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200867
;

-- Nov 23, 2012 6:36:40 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=90, XPosition=4,Updated=TO_DATE('2012-11-23 18:36:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200860
;

-- Nov 23, 2012 6:40:53 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
CREATE TABLE AD_StorageProvider (AD_Client_ID NUMBER(10) DEFAULT NULL , AD_Org_ID NUMBER(10) DEFAULT NULL , AD_StorageProvider_ID NUMBER(10) DEFAULT NULL , AD_StorageProvider_UU NVARCHAR2(36) DEFAULT NULL , Created DATE DEFAULT NULL , CreatedBy NUMBER(10) DEFAULT NULL , Folder NVARCHAR2(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), Method NVARCHAR2(60) DEFAULT NULL , Name NVARCHAR2(60) DEFAULT NULL , Password NVARCHAR2(255) DEFAULT NULL , Updated DATE DEFAULT NULL , UpdatedBy NUMBER(10) DEFAULT NULL , URL NVARCHAR2(225) DEFAULT NULL , UserName NVARCHAR2(60) DEFAULT NULL )
;


-- Nov 23, 2012 7:05:25 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200022,200027,'N','N','N','D','Y','Storage Provider','Storage Provider','W','4b3344c7-7f1b-445d-8b1d-28774d15c361','Y',0,100,TO_DATE('2012-11-23 19:05:24','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-11-23 19:05:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Nov 23, 2012 7:05:25 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Nov 23, 2012 7:05:25 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200027, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200027)
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=519
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=518
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200024
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Nov 23, 2012 7:05:57 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50158
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50160
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=50159
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200594
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200595
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=5161
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=5162
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=5163
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=5164
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=12099
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=12098
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=11024
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=50184
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=50185
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=50186
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=54238
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=54680
;

-- Nov 23, 2012 7:17:26 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200096
;

-- Nov 23, 2012 7:18:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-11-23 19:18:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50184
;

-- Nov 23, 2012 7:18:27 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-11-23 19:18:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50186
;

-- Nov 23, 2012 7:18:46 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-11-23 19:18:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=50185
;

-- Nov 23, 2012 7:20:00 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AttachmentMethod',200241,'D','AttachmentMethod','Attachment Method','7f8bcec7-f364-4767-9ed6-a2600ef13530',0,TO_DATE('2012-11-23 19:19:59','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-23 19:19:59','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 23, 2012 7:20:00 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200241 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 23, 2012 7:20:55 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,112,200976,'U','N','N','N',0,'N',22,'N',18,'N',200241,'N','Y','5a753477-c244-4624-a325-47647a5552b2','Y','N','AttachmentMethod','AttachmentMethod','Y',TO_DATE('2012-11-23 19:20:54','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-23 19:20:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 23, 2012 7:20:55 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200976 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 23, 2012 7:23:58 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET EntityType='D', AD_Reference_ID=19, AD_Element_ID=200238, ColumnName='AD_StorageProvider_ID', Description=NULL, Help=NULL, Name='AD_StorageProvider_ID',Updated=TO_DATE('2012-11-23 19:23:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200976
;

-- Nov 23, 2012 7:23:58 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200976
;

-- Nov 23, 2012 7:23:58 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET Name='AD_StorageProvider_ID', Description=NULL, Help=NULL WHERE AD_Column_ID=200976 AND IsCentrallyMaintained='Y'
;

-- Nov 23, 2012 7:27:30 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',145,0,'N','N',200976,270,'Y',200871,'N','D','AD_StorageProvider_ID','5f2578c0-0f8c-4278-8a02-574af285a1a9','Y','N',100,0,TO_DATE('2012-11-23 19:27:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-23 19:27:29','YYYY-MM-DD HH24:MI:SS'),'Y','Y',270,1,'N')
;

-- Nov 23, 2012 7:27:30 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200871 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 23, 2012 7:28:02 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200871
;

-- Nov 23, 2012 7:28:02 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=50184
;

-- Nov 23, 2012 7:28:03 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=50185
;

-- Nov 23, 2012 7:28:03 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=50186
;

-- Nov 23, 2012 7:28:03 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=54238
;

-- Nov 23, 2012 7:28:03 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=54680
;

-- Nov 23, 2012 7:28:03 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=200096
;


-- Nov 26, 2012 3:25:14 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Table SET AccessLevel='7', AD_Window_ID=200022, Name='Storage Provider',Updated=TO_DATE('2012-11-26 15:25:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200037
;

-- Nov 27, 2012 11:30:00 AM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton) VALUES (0,'N','N',0,227,201006,'D','N','N','N',0,'N',22,'N',19,'N',200238,'N','Y','0ae144df-50d5-4eb3-aff5-d613a6bbf30d','Y','N','AD_StorageProvider_ID','AD_StorageProvider_ID','Y',TO_DATE('2012-11-27 11:29:58','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2012-11-27 11:29:58','YYYY-MM-DD HH24:MI:SS'),100,0,'N')
;

-- Nov 27, 2012 11:30:00 AM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=201006 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Nov 27, 2012 11:31:30 AM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',169,0,'N','N',201006,310,'Y',200948,'N','D','AD_StorageProvider_ID','2dfa64e4-aa94-471a-b764-c7bb88f8a684','Y','N',100,0,TO_DATE('2012-11-27 11:31:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-11-27 11:31:29','YYYY-MM-DD HH24:MI:SS'),'Y','Y',310,1,'N')
;

-- Nov 27, 2012 11:31:30 AM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200948 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Nov 27, 2012 11:43:35 AM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
ALTER TABLE AD_ClientInfo ADD AD_StorageProvider_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2012 3:31:15 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-11-27 15:31:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200969
;

-- Nov 27, 2012 3:31:38 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
ALTER TABLE AD_StorageProvider MODIFY Name NVARCHAR2(60)
;

-- Nov 27, 2012 3:31:38 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
ALTER TABLE AD_StorageProvider MODIFY Name NOT NULL
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=10,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=904
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=20,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5346
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=30,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4727
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=905
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1309
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1310
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1311
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1312
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3052
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=4,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200948
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=110,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3054
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=120,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9201
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=130,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1564
;

-- Nov 27, 2012 3:40:16 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=140,Updated=TO_DATE('2012-11-27 15:40:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1563
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=150,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1562
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=160,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1565
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=170,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1566
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=180,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1567
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=190,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10319
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=200,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10320
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=210,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57531
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=220,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57534
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=230,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57535
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=910
;

-- Nov 27, 2012 3:40:17 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2012-11-27 15:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=911
;

-- Nov 27, 2012 3:41:55 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Table SET AccessLevel='6',Updated=TO_DATE('2012-11-27 15:41:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200037
;

-- Nov 27, 2012 3:42:34 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Element SET PrintName='Storage Provider',Updated=TO_DATE('2012-11-27 15:42:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200238
;

-- Nov 27, 2012 3:42:34 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200238
;

-- Nov 27, 2012 3:42:34 PM COT
-- IDEMPIERE-390 Attachments/archives on load balancer scenario
UPDATE AD_PrintFormatItem pi SET PrintName='Storage Provider', Name='AD_StorageProvider_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200238)
;

INSERT INTO ad_storageprovider
            (ad_client_id,
             ad_org_id,
             ad_storageprovider_id,
             ad_storageprovider_uu,
             created,
             createdby,
             folder,
             isactive,
             method,
             name,
             password,
             updated,
             updatedby,
             url,
             username)
SELECT 
             ad_client_id,
             0,
             nextidfunc(200033,'N'),
             generate_uuid(),
             now(),
             100,
             coalesce(windowsattachmentpath, unixattachmentpath),
             'Y',
             'FileSystem',
             'Folder',
             null,
             now(),
             100,
             null,
             null
FROM ad_client
WHERE storeattachmentsonfilesystem='Y' AND (windowsattachmentpath is not null or unixattachmentpath is not null)
;

UPDATE ad_clientinfo
   SET ad_storageprovider_id = (SELECT ad_storageprovider_id FROM ad_storageprovider WHERE ad_storageprovider.ad_client_id=ad_clientinfo.ad_client_id)
FROM ad_storageprovider
WHERE ad_clientinfo.ad_client_id IN
  (SELECT ad_client_id FROM ad_client WHERE storeattachmentsonfilesystem='Y' AND (windowsattachmentpath is not null or unixattachmentpath is not null))
;

SELECT register_migration_script('201211281100IDEMPIERE_390.sql') FROM dual
;
