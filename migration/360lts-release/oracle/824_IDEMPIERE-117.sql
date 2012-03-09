-- Mar 8, 2012 7:18:59 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Table (TableName,Description,AccessLevel,LoadSeq,Name,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CreatedBy,Updated,UpdatedBy,CopyColumnsFromTable,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,ReplicationType,AD_Client_ID,IsSecurityEnabled,IsActive,Created,AD_Org_ID,AD_Table_ID) VALUES ('M_CostHistory','Movement history for M_Cost','3',0,'Cost History','N','N','N','N','D',100,TO_DATE('2012-03-08 07:18:58','YYYY-MM-DD HH24:MI:SS'),100,'N','8c8d6676-6538-44f1-abf8-e480da7250b2','Y','Y','L',0,'N','Y',TO_DATE('2012-03-08 07:18:58','YYYY-MM-DD HH24:MI:SS'),0,200001)
;

-- Mar 8, 2012 7:18:59 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 8, 2012 7:21:39 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,DefaultValue,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client',10,19,129,'N',102,'1bbcd29a-4935-4908-bea6-4f8dc313d501','Y','N','AD_Client_ID','N','N','N',100,TO_DATE('2012-03-08 07:21:38','YYYY-MM-DD HH24:MI:SS'),'@#AD_Client_ID@','N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:21:38','YYYY-MM-DD HH24:MI:SS'),100,200020)
;

-- Mar 8, 2012 7:21:39 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:23:05 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,DefaultValue,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization',10,19,104,'N',113,'45063c04-4fb3-46a6-b1e1-828ac5ce614c','Y','N','AD_Org_ID','N','N','N',100,TO_DATE('2012-03-08 07:23:04','YYYY-MM-DD HH24:MI:SS'),'@#AD_Org_ID@','N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:23:04','YYYY-MM-DD HH24:MI:SS'),100,200021)
;

-- Mar 8, 2012 7:23:05 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:24:12 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'The Created field indicates the date that this record was created.','Date this record was created','Created',7,16,'N',245,'e32147f8-ad0d-41a9-afc6-ad70da9ddd5f','Y','N','Created','N','N','N',100,TO_DATE('2012-03-08 07:24:11','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:24:11','YYYY-MM-DD HH24:MI:SS'),100,200022)
;

-- Mar 8, 2012 7:24:12 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:25:06 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,110,'Y','N','N',0,'The Created By field indicates the user who created this record.','User who created this records','Created By',10,18,'N',246,'6ff59e2a-33cd-4e8a-b9cd-8a377978f53c','Y','N','CreatedBy','N','N','N',100,TO_DATE('2012-03-08 07:25:05','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:25:05','YYYY-MM-DD HH24:MI:SS'),100,200023)
;

-- Mar 8, 2012 7:25:06 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:26:57 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,DefaultValue,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active',1,20,'N',348,'2e7271de-7b31-4b10-8ffc-983789141192','Y','N','IsActive','Y','N','N',100,TO_DATE('2012-03-08 07:26:56','YYYY-MM-DD HH24:MI:SS'),'Y','N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:26:56','YYYY-MM-DD HH24:MI:SS'),100,200024)
;

-- Mar 8, 2012 7:26:57 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200024 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:30:20 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','Product Attribute Set Instance','Attribute Set Instance',10,35,'N',2019,'4af1df12-baec-453a-bec9-bec84e71617e','Y','N','M_AttributeSetInstance_ID','N','Y','N',100,TO_DATE('2012-03-08 07:30:19','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:30:19','YYYY-MM-DD HH24:MI:SS'),100,200025)
;

-- Mar 8, 2012 7:30:20 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:31:16 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'Cost Detail Information','Cost Detail',10,19,'N',2817,'1232b0fb-6166-4ecf-a172-02dde4c7256a','Y','N','M_CostDetail_ID','N','Y','N',100,TO_DATE('2012-03-08 07:31:15','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:31:15','YYYY-MM-DD HH24:MI:SS'),100,200026)
;

-- Mar 8, 2012 7:31:16 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:32:16 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'Product Cost Element','Cost Element',10,19,'N',2700,'b9ea7299-e3d8-4ab1-9ff4-332e8ed562d6','Y','N','M_CostElement_ID','N','Y','N',100,TO_DATE('2012-03-08 07:32:14','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:32:14','YYYY-MM-DD HH24:MI:SS'),100,200027)
;

-- Mar 8, 2012 7:32:16 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:33:37 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('M_CostHistory_ID','Cost History','Cost History','58eb631b-8cb1-4bab-93d0-bf9f51accd2e','D',0,200005,'Movement history for M_Cost',TO_DATE('2012-03-08 07:33:36','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 07:33:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 7:33:37 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 7:35:27 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'Movement history for M_Cost','Cost History',10,13,'Y',200005,'30905aed-94c4-4e8c-b2ce-de9aa41b1586','Y','N','M_CostHistory_ID','N','N','N',100,TO_DATE('2012-03-08 07:35:26','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:35:26','YYYY-MM-DD HH24:MI:SS'),100,200028)
;

-- Mar 8, 2012 7:35:27 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:36:44 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('M_CostHistory_UU','Cost History UUID','Cost History UUID','c6a0fa10-0414-4257-9990-5fcb38a91ef3','D',0,200006,TO_DATE('2012-03-08 07:36:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 07:36:43','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 7:36:44 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200006 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 7:38:16 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'Cost History UUID',36,10,'N',200006,'f2d3a898-4321-4a39-a8f6-f29f9daed67b','Y','N','M_CostHistory_UU','N','N','N',100,TO_DATE('2012-03-08 07:38:15','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:38:15','YYYY-MM-DD HH24:MI:SS'),100,200029)
;

-- Mar 8, 2012 7:38:16 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200029 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 7:41:00 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('NewCAmt','New Accumulated Amt','New Accumulated Amt','069a7d89-cfe4-4f89-9f32-919b7caef225','D',0,200007,'Accumulated Amt after processing of M_CostDetail',TO_DATE('2012-03-08 07:40:59','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 07:40:59','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 7:41:00 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 7:41:53 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'N','N','N',0,'Accumulated Amt after processing of M_CostDetail','New Accumulated Amt',22,12,'N',200007,'03a9f86d-8d7f-424b-ac2d-06b0390263e5','Y','N','NewCAmt','N','Y','N',100,TO_DATE('2012-03-08 07:41:52','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 07:41:52','YYYY-MM-DD HH24:MI:SS'),100,200030)
;

-- Mar 8, 2012 7:41:53 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200030 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 10:46:17 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'You can define multiple cost types. A cost type selected in an Accounting Schema is used for accounting.','Type of Cost (e.g. Current, Plan, Future)','Cost Type',10,19,'N',2071,'453e63fd-79ec-4453-be2a-61a90cd3847d','Y','N','M_CostType_ID','N','Y','N',100,TO_DATE('2012-03-08 10:46:16','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 10:46:16','YYYY-MM-DD HH24:MI:SS'),100,200031)
;

-- Mar 8, 2012 10:46:17 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200031 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 10:47:58 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('NewCostPrice','New Cost Price','New Cost Price','f0219a4d-ea25-473c-896a-1fe5dc6c25b8','D',0,200008,'New current cost price after processing of M_CostDetail',TO_DATE('2012-03-08 10:47:57','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 10:47:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 10:47:58 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 10:49:07 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'New current cost price after processing of M_CostDetail','New Cost Price',22,37,'N',200008,'8440b8a0-7a07-48cd-92f2-8a72cd8afd50','Y','N','NewCostPrice','Y','Y','N',100,TO_DATE('2012-03-08 10:49:06','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 10:49:06','YYYY-MM-DD HH24:MI:SS'),100,200032)
;

-- Mar 8, 2012 10:49:07 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200032 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 10:54:07 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('NewCQty','New Accumulated Qty','New Accumulated Qty','f2bfdcd4-9015-4135-b738-189f96469f03','D',0,200009,'New Accumulated Qty after processing of M_CostDetail',TO_DATE('2012-03-08 10:54:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 10:54:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 10:54:07 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 10:54:52 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'N','N','N',0,'New Accumulated Qty after processing of M_CostDetail','New Accumulated Qty',22,29,'N',200009,'1b12534a-0973-4a1e-97e2-58bcc4478a10','Y','N','NewCQty','N','Y','N',100,TO_DATE('2012-03-08 10:54:51','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 10:54:51','YYYY-MM-DD HH24:MI:SS'),100,200033)
;

-- Mar 8, 2012 10:54:52 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200033 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 10:55:53 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('NewQty','New Current Quantity','New Current Quantity','8f1543e0-6597-48bc-b0b0-1817bac20415','D',0,200010,'New current quantity after processing of M_CostDetail',TO_DATE('2012-03-08 10:55:52','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 10:55:52','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 10:55:53 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 10:56:45 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'New current quantity after processing of M_CostDetail','New Current Quantity',22,29,'N',200010,'58ee58db-f841-4965-8af5-13ff54068f4e','Y','N','NewQty','Y','Y','N',100,TO_DATE('2012-03-08 10:56:44','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 10:56:44','YYYY-MM-DD HH24:MI:SS'),100,200034)
;

-- Mar 8, 2012 10:56:45 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200034 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 10:59:06 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('OldCAmt','Old Accumulated Amt','Old Accumulated Amt','de1b3615-148c-4cb1-9897-7fd0b5188320','D',0,200011,'Old accumulated amt before the processing of M_CostDetail',TO_DATE('2012-03-08 10:59:04','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 10:59:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 10:59:06 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200011 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 11:00:00 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'N','N','N',0,'Old accumulated amt before the processing of M_CostDetail','Old Accumulated Amt',22,12,'N',200011,'9129c55a-0a13-4db7-b64d-bdc9fc740a4b','Y','N','OldCAmt','N','Y','N',100,TO_DATE('2012-03-08 10:59:59','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 10:59:59','YYYY-MM-DD HH24:MI:SS'),100,200035)
;

-- Mar 8, 2012 11:00:00 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200035 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 11:00:49 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('OldCostPrice','Old Current Cost Price','Old Current Cost Price','13f4a559-a32b-4118-a89b-b61d826bec35','D',0,200012,'Old current cost price before the processing of M_CostDetail',TO_DATE('2012-03-08 11:00:48','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 11:00:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 11:00:49 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 11:02:02 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'Old current cost price before the processing of M_CostDetail','Old Current Cost Price',22,37,'N',200012,'56e4fd27-9418-4104-823c-7c7ebd7d0e91','Y','N','OldCostPrice','N','Y','N',100,TO_DATE('2012-03-08 11:02:01','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 11:02:01','YYYY-MM-DD HH24:MI:SS'),100,200036)
;

-- Mar 8, 2012 11:02:02 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200036 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 11:03:02 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('OldCQty','Old Accumulated Qty','Old Accumulated Qty','c556911d-90fa-4e52-a569-92588720cc6c','D',0,200013,'Old accumulated qty before the processing of M_CostDetail',TO_DATE('2012-03-08 11:03:01','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 11:03:01','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 11:03:02 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 11:03:55 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'U',1,'N','N','N',0,'Old accumulated qty before the processing of M_CostDetail','Old Accumulated Qty',22,29,'N',200013,'a6ff1e46-b660-4ca5-8b55-f831e2633b94','Y','N','OldCQty','N','Y','N',100,TO_DATE('2012-03-08 11:03:54','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 11:03:54','YYYY-MM-DD HH24:MI:SS'),100,200037)
;

-- Mar 8, 2012 11:03:55 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200037 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 11:04:54 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element (ColumnName,Name,PrintName,AD_Element_UU,EntityType,AD_Client_ID,AD_Element_ID,Description,Updated,AD_Org_ID,CreatedBy,UpdatedBy,Created,IsActive) VALUES ('OldQty','Old Current Quantity','Old Current Quantity','ddc61868-2b75-49d8-a117-4d7460c09647','D',0,200014,'Old current quantity before the processing of M_CostDetail',TO_DATE('2012-03-08 11:04:53','YYYY-MM-DD HH24:MI:SS'),0,100,100,TO_DATE('2012-03-08 11:04:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Mar 8, 2012 11:04:54 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,PrintName,PO_PrintName,PO_Description,PO_Name,PO_Help,Help,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.PrintName,t.PO_PrintName,t.PO_Description,t.PO_Name,t.PO_Help,t.Help,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 8, 2012 11:05:51 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'Old current quantity before the processing of M_CostDetail','Old Current Quantity',22,29,'N',200014,'a4bf053d-8778-4f9a-a9ed-3063d27e729b','Y','N','OldQty','N','Y','N',100,TO_DATE('2012-03-08 11:05:50','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 11:05:50','YYYY-MM-DD HH24:MI:SS'),100,200038)
;

-- Mar 8, 2012 11:05:51 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200038 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 11:06:52 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,'Y','N','N',0,'The Updated field indicates the date that this record was updated.','Date this record was updated','Updated',7,16,'N',607,'f44e0d81-fb24-414e-8f8b-b818a9fbb408','Y','N','Updated','N','N','N',100,TO_DATE('2012-03-08 11:06:51','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 11:06:51','YYYY-MM-DD HH24:MI:SS'),100,200039)
;

-- Mar 8, 2012 11:06:52 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200039 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 11:07:34 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsAllowLogging,IsAutocomplete,ColumnName,IsUpdateable,IsAllowCopy,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsSyncDatabase,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200001,'D',1,110,'Y','N','N',0,'The Updated By field indicates the user who updated this record.','User who updated this records','Updated By',10,18,'N',608,'717ff97a-bdbf-4cd0-9499-33446a8e17fd','Y','N','UpdatedBy','N','N','N',100,TO_DATE('2012-03-08 11:07:33','YYYY-MM-DD HH24:MI:SS'),'N','N','N','N',0,0,'Y',TO_DATE('2012-03-08 11:07:33','YYYY-MM-DD HH24:MI:SS'),100,200040)
;

-- Mar 8, 2012 11:07:34 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200040 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 11:08:01 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2012-03-08 11:08:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200034
;

-- Mar 8, 2012 11:08:07 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2012-03-08 11:08:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200032
;

-- Mar 8, 2012 11:10:51 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-03-08 11:10:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200037
;

-- Mar 8, 2012 11:12:23 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-08 11:12:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200025
;

-- Mar 8, 2012 11:12:31 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-08 11:12:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200026
;

-- Mar 8, 2012 11:14:07 AM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
CREATE TABLE M_CostHistory (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, M_AttributeSetInstance_ID NUMBER(10) NOT NULL, M_CostDetail_ID NUMBER(10) NOT NULL, M_CostElement_ID NUMBER(10) NOT NULL, M_CostHistory_ID NUMBER(10) NOT NULL, M_CostHistory_UU NVARCHAR2(36) NOT NULL, M_CostType_ID NUMBER(10) NOT NULL, NewCAmt NUMBER, NewCostPrice NUMBER NOT NULL, NewCQty NUMBER , NewQty NUMBER NOT NULL, OldCAmt NUMBER , OldCostPrice NUMBER NOT NULL, OldCQty NUMBER, OldQty NUMBER NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT M_CostHistory_Key PRIMARY KEY (M_CostHistory_ID))
;

-- Mar 8, 2012 3:16:37 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Table (TableName,Description,AccessLevel,LoadSeq,Name,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CreatedBy,Updated,UpdatedBy,CopyColumnsFromTable,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,ReplicationType,AD_Client_ID,IsSecurityEnabled,IsActive,Created,AD_Org_ID,AD_Table_ID) VALUES ('M_CostMovement_v','Cost movement for M_Cost','3',0,'Cost Movement','N','N','Y','N','D',100,TO_DATE('2012-03-08 15:16:35','YYYY-MM-DD HH24:MI:SS'),100,'N','0ec6736e-94ff-4ff4-ae56-c3be505e1e00','Y','N','L',0,'N','Y',TO_DATE('2012-03-08 15:16:35','YYYY-MM-DD HH24:MI:SS'),0,200002)
;

-- Mar 8, 2012 3:16:37 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 8, 2012 3:16:39 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Sequence (StartNewYear,Updated,CurrentNextSys,UpdatedBy,Description,Name,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,IncrementNo,IsTableID,StartNo,CurrentNext,Created,CreatedBy,IsActive) VALUES ('N',TO_DATE('2012-03-08 15:16:38','YYYY-MM-DD HH24:MI:SS'),50000,100,'Table M_CostMovement_v','M_CostMovement_v','N','Y',200001,'9e99f812-6480-4053-94d9-d987b2f28665',0,0,1,'Y',1000000,1000000,TO_DATE('2012-03-08 15:16:38','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Mar 8, 2012 3:18:00 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client',10,19,'N',102,'6997dbc7-f6c2-4575-8fe6-c560c881c1ee','AD_Client_ID','N','N',100,TO_DATE('2012-03-08 15:17:59','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:17:59','YYYY-MM-DD HH24:MI:SS'),100,200041)
;

-- Mar 8, 2012 3:18:00 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200041 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:01 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization',10,19,'N',113,'06443f4d-f34c-40ed-91f1-f68f2099d770','AD_Org_ID','N','N',100,TO_DATE('2012-03-08 15:18:00','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:00','YYYY-MM-DD HH24:MI:SS'),100,200042)
;

-- Mar 8, 2012 3:18:01 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200042 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:02 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar','Rules for accounting','Accounting Schema',10,19,'N',181,'fc5b5b47-8f8c-4c72-b2d7-ec0da9186030','C_AcctSchema_ID','N','N',100,TO_DATE('2012-03-08 15:18:01','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:01','YYYY-MM-DD HH24:MI:SS'),100,200043)
;

-- Mar 8, 2012 3:18:02 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200043 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:02 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Movement history for M_Cost','Cost History',10,19,'N',200005,'7522bd43-da4f-40d7-bdd0-1d9ef2b37d4b','M_CostHistory_ID','N','N',100,TO_DATE('2012-03-08 15:18:02','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:02','YYYY-MM-DD HH24:MI:SS'),100,200044)
;

-- Mar 8, 2012 3:18:02 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200044 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:03 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','You can define multiple cost types. A cost type selected in an Accounting Schema is used for accounting.','Type of Cost (e.g. Current, Plan, Future)','Cost Type',10,19,'N',2071,'7874a621-6c70-476c-96e8-abba949270e2','M_CostType_ID','N','N',100,TO_DATE('2012-03-08 15:18:02','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:02','YYYY-MM-DD HH24:MI:SS'),100,200045)
;

-- Mar 8, 2012 3:18:03 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200045 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:04 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Product Cost Element','Cost Element',10,19,'N',2700,'9718d2ad-1e01-49b7-b7c7-0ddf78925b67','M_CostElement_ID','N','N',100,TO_DATE('2012-03-08 15:18:03','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:03','YYYY-MM-DD HH24:MI:SS'),100,200046)
;

-- Mar 8, 2012 3:18:04 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200046 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:05 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','Product Attribute Set Instance','Attribute Set Instance',10,35,'N',2019,'c29855c1-dcc7-403c-86f6-30efb29e54a5','M_AttributeSetInstance_ID','N','N',100,TO_DATE('2012-03-08 15:18:04','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:04','YYYY-MM-DD HH24:MI:SS'),100,200047)
;

-- Mar 8, 2012 3:18:05 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200047 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:06 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Identifies an item which is either purchased or sold in this organization.','Product, Service, Item','Product',10,19,'N',454,'1e1dd8bc-358c-4b4c-b6b6-b6c496cd7d9e','M_Product_ID','N','N',100,TO_DATE('2012-03-08 15:18:05','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:05','YYYY-MM-DD HH24:MI:SS'),100,200048)
;

-- Mar 8, 2012 3:18:06 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200048 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:07 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Old current quantity before the processing of M_CostDetail','Old Current Quantity',131089,29,'N',200014,'0a26379d-e54f-434e-a570-38cd58176542','OldQty','N','N',100,TO_DATE('2012-03-08 15:18:06','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:06','YYYY-MM-DD HH24:MI:SS'),100,200049)
;

-- Mar 8, 2012 3:18:07 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200049 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:07 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','New current quantity after processing of M_CostDetail','New Current Quantity',131089,29,'N',200010,'33f411f6-b519-410d-a2c5-cfdad5a0520c','NewQty','N','N',100,TO_DATE('2012-03-08 15:18:07','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:07','YYYY-MM-DD HH24:MI:SS'),100,200050)
;

-- Mar 8, 2012 3:18:07 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200050 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:08 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Old current cost price before the processing of M_CostDetail','Old Current Cost Price',131089,22,'N',200012,'77b74eff-9785-4985-9d6a-0c2e02e4c41a','OldCostPrice','N','N',100,TO_DATE('2012-03-08 15:18:07','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:07','YYYY-MM-DD HH24:MI:SS'),100,200051)
;

-- Mar 8, 2012 3:18:08 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200051 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:09 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','New current cost price after processing of M_CostDetail','New Cost Price',131089,22,'N',200008,'02aeafef-79ef-43af-b76c-02cb5d92aea7','NewCostPrice','N','N',100,TO_DATE('2012-03-08 15:18:08','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:08','YYYY-MM-DD HH24:MI:SS'),100,200052)
;

-- Mar 8, 2012 3:18:09 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200052 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:10 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Old accumulated qty before the processing of M_CostDetail','Old Accumulated Qty',131089,29,'N',200013,'707ef80f-74d9-42ab-a507-ea0b9b87ef24','OldCQty','N','N',100,TO_DATE('2012-03-08 15:18:09','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:09','YYYY-MM-DD HH24:MI:SS'),100,200053)
;

-- Mar 8, 2012 3:18:10 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200053 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:11 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','New Accumulated Qty after processing of M_CostDetail','New Accumulated Qty',131089,29,'N',200009,'3f6af769-b634-43a5-9889-20ff0480f371','NewCQty','N','N',100,TO_DATE('2012-03-08 15:18:10','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:10','YYYY-MM-DD HH24:MI:SS'),100,200054)
;

-- Mar 8, 2012 3:18:11 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200054 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:11 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Old accumulated amt before the processing of M_CostDetail','Old Accumulated Amt',131089,12,'N',200011,'c28a3f40-c3a8-446e-83eb-9b461c458236','OldCAmt','N','N',100,TO_DATE('2012-03-08 15:18:11','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:11','YYYY-MM-DD HH24:MI:SS'),100,200055)
;

-- Mar 8, 2012 3:18:11 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200055 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:12 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Accumulated Amt after processing of M_CostDetail','New Accumulated Amt',131089,12,'N',200007,'7c0e70c0-32a6-49c4-bf9c-f1a0746c8b02','NewCAmt','N','N',100,TO_DATE('2012-03-08 15:18:11','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:11','YYYY-MM-DD HH24:MI:SS'),100,200056)
;

-- Mar 8, 2012 3:18:12 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200056 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:13 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Quantity indicates the number of a specific product or item for this document.','Quantity','Quantity',131089,29,'N',526,'f76c1c40-dbe9-42ee-9edd-9430d6b70fae','Qty','N','N',100,TO_DATE('2012-03-08 15:18:12','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:12','YYYY-MM-DD HH24:MI:SS'),100,200057)
;

-- Mar 8, 2012 3:18:13 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200057 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:14 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Amount','Amount','Amount',131089,12,'N',160,'419e470f-e2ee-4ce8-8460-1500140d71cc','Amt','N','N',100,TO_DATE('2012-03-08 15:18:13','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:13','YYYY-MM-DD HH24:MI:SS'),100,200058)
;

-- Mar 8, 2012 3:18:14 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200058 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:15 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Quantity Difference','Delta Quantity',131089,29,'N',2841,'159d2c37-c8ca-46bd-8cdb-e1c3abf3008e','DeltaQty','N','N',100,TO_DATE('2012-03-08 15:18:14','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:14','YYYY-MM-DD HH24:MI:SS'),100,200059)
;

-- Mar 8, 2012 3:18:15 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200059 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:16 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Difference Amount','Delta Amount',131089,12,'N',2840,'aeaf777e-3671-4498-aaec-4dbc37163906','DeltaAmt','N','N',100,TO_DATE('2012-03-08 15:18:15','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:15','YYYY-MM-DD HH24:MI:SS'),100,200060)
;

-- Mar 8, 2012 3:18:16 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200060 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:17 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Sales Order Line is a unique identifier for a line in an order.','Sales Order Line','Sales Order Line',10,19,'N',561,'992335c0-322b-4c02-b749-135e28931bfd','C_OrderLine_ID','N','N',100,TO_DATE('2012-03-08 15:18:16','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:16','YYYY-MM-DD HH24:MI:SS'),100,200061)
;

-- Mar 8, 2012 3:18:17 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200061 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:17 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document','Line on Shipment or Receipt document','Shipment/Receipt Line',10,19,'N',1026,'c06c3c93-eaa1-4564-a778-42b10f5539c1','M_InOutLine_ID','N','N',100,TO_DATE('2012-03-08 15:18:17','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:17','YYYY-MM-DD HH24:MI:SS'),100,200062)
;

-- Mar 8, 2012 3:18:17 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200062 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:18 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Invoice Line uniquely identifies a single line of an Invoice.','Invoice Detail Line','Invoice Line',10,19,'N',1076,'7fbdb857-e16e-4d2d-836b-0251d935723b','C_InvoiceLine_ID','N','N',100,TO_DATE('2012-03-08 15:18:17','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:17','YYYY-MM-DD HH24:MI:SS'),100,200063)
;

-- Mar 8, 2012 3:18:18 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200063 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:19 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Movement Line indicates the inventory movement document line (if applicable) for this transaction','Inventory Move document Line','Move Line',10,19,'N',1031,'62a08e0b-de59-4e0f-8324-ff590b150536','M_MovementLine_ID','N','N',100,TO_DATE('2012-03-08 15:18:18','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:18','YYYY-MM-DD HH24:MI:SS'),100,200064)
;

-- Mar 8, 2012 3:18:19 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200064 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:20 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Physical Inventory Line indicates the inventory document line (if applicable) for this transaction','Unique line in an Inventory document','Phys.Inventory Line',10,19,'N',1028,'03ef993c-e33c-4f88-b9ba-431fc0c1449c','M_InventoryLine_ID','N','N',100,TO_DATE('2012-03-08 15:18:19','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:19','YYYY-MM-DD HH24:MI:SS'),100,200065)
;

-- Mar 8, 2012 3:18:20 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:21 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Production Line indicates the production document line (if applicable) for this transaction','Document Line representing a production','Production Line',10,19,'N',1033,'72698e67-0526-41cd-990a-dcfebf24d73e','M_ProductionLine_ID','N','N',100,TO_DATE('2012-03-08 15:18:20','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:20','YYYY-MM-DD HH24:MI:SS'),100,200066)
;

-- Mar 8, 2012 3:18:21 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:22 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Issues to the project initiated by the "Issue to Project" process. You can issue Receipts, Time and Expenses, or Stock.','Project Issues (Material, Labor)','Project Issue',10,19,'N',2178,'a8e3de0a-07e2-493a-a7ac-429a41a47bb3','C_ProjectIssue_ID','N','N',100,TO_DATE('2012-03-08 15:18:21','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:21','YYYY-MM-DD HH24:MI:SS'),100,200067)
;

-- Mar 8, 2012 3:18:22 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:23 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','Cost Detail Information','Cost Detail',10,19,'N',2817,'c1026223-a57e-4e18-9dd4-bcaa5c283649','M_CostDetail_ID','N','N',100,TO_DATE('2012-03-08 15:18:22','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:22','YYYY-MM-DD HH24:MI:SS'),100,200068)
;

-- Mar 8, 2012 3:18:23 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:24 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','A description is limited to 255 characters.','Optional short description of the record','Description',255,10,'N',275,'b94aa816-9576-476e-99b9-258e40883b28','Description','N','N',100,TO_DATE('2012-03-08 15:18:23','YYYY-MM-DD HH24:MI:SS'),'N','Y','N',0,0,'Y',TO_DATE('2012-03-08 15:18:23','YYYY-MM-DD HH24:MI:SS'),100,200069)
;

-- Mar 8, 2012 3:18:24 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:24 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Created field indicates the date that this record was created.','Date this record was created','Created',29,16,'N',245,'2795cb3f-08f5-416a-a413-cac3cc614b9a','Created','N','N',100,TO_DATE('2012-03-08 15:18:24','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:24','YYYY-MM-DD HH24:MI:SS'),100,200070)
;

-- Mar 8, 2012 3:18:25 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:25 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,110,'N','N','N','The Created By field indicates the user who created this record.','User who created this records','Created By',10,18,'N',246,'68702b21-9a7f-42d1-8d00-430c3c42a335','CreatedBy','N','N',100,TO_DATE('2012-03-08 15:18:25','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:25','YYYY-MM-DD HH24:MI:SS'),100,200071)
;

-- Mar 8, 2012 3:18:25 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200071 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:26 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','The Updated field indicates the date that this record was updated.','Date this record was updated','Updated',29,16,'N',607,'9923bd35-b9e1-493e-9b85-7812447c65f3','Updated','N','N',100,TO_DATE('2012-03-08 15:18:25','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:25','YYYY-MM-DD HH24:MI:SS'),100,200072)
;

-- Mar 8, 2012 3:18:26 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200072 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:27 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,110,'N','N','N','The Updated By field indicates the user who updated this record.','User who updated this records','Updated By',10,18,'N',608,'bb6bf453-b9b7-4145-b9e2-5e0b2c3fb058','UpdatedBy','N','N',100,TO_DATE('2012-03-08 15:18:26','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:26','YYYY-MM-DD HH24:MI:SS'),100,200073)
;

-- Mar 8, 2012 3:18:27 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200073 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:18:28 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column (AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,Description,Name,FieldLength,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,ColumnName,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,IsParent,IsSelectionColumn,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Column_ID) VALUES (200002,'D',0,'N','N','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active',1,20,'N',348,'21e576f8-bcef-4acf-8668-198189e3d8ad','IsActive','N','N',100,TO_DATE('2012-03-08 15:18:27','YYYY-MM-DD HH24:MI:SS'),'N','N','N',0,0,'Y',TO_DATE('2012-03-08 15:18:27','YYYY-MM-DD HH24:MI:SS'),100,200074)
;

-- Mar 8, 2012 3:18:28 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200074 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 8, 2012 3:23:58 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:23:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200058
;

-- Mar 8, 2012 3:24:11 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=7, IsAllowCopy='N',Updated=TO_DATE('2012-03-08 15:24:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200070
;

-- Mar 8, 2012 3:24:21 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:24:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200060
;

-- Mar 8, 2012 3:24:31 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:24:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200059
;

-- Mar 8, 2012 3:25:02 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:25:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200056
;

-- Mar 8, 2012 3:25:18 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22, AD_Reference_ID=37,Updated=TO_DATE('2012-03-08 15:25:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200052
;

-- Mar 8, 2012 3:26:01 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:26:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200054
;

-- Mar 8, 2012 3:26:11 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:26:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200050
;

-- Mar 8, 2012 3:26:23 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:26:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200055
;

-- Mar 8, 2012 3:26:33 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22, AD_Reference_ID=37,Updated=TO_DATE('2012-03-08 15:26:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200051
;

-- Mar 8, 2012 3:26:41 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:26:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200053
;

-- Mar 8, 2012 3:26:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:26:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200049
;

-- Mar 8, 2012 3:26:56 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=22,Updated=TO_DATE('2012-03-08 15:26:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200057
;

-- Mar 8, 2012 3:27:06 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Column SET FieldLength=7, IsAllowCopy='N',Updated=TO_DATE('2012-03-08 15:27:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200072
;

-- Mar 8, 2012 3:39:44 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Tab SET SeqNo=50,Updated=TO_DATE('2012-03-08 15:39:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=762
;

-- Mar 8, 2012 3:39:53 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Tab SET SeqNo=40,Updated=TO_DATE('2012-03-08 15:39:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=748
;

-- Mar 8, 2012 3:44:42 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,Name,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,WhereClause,IsReadOnly,IsInsertRecord,IsAdvancedTab,EntityType,AD_Tab_UU,Description,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,TabLevel,IsInfoTab,UpdatedBy,Processing,IsActive,AD_Tab_ID) VALUES ('N',344,'Cost Movement',30,'N','N',200002,'N','N','M_CostMovement_v.AD_Client_ID=@AD_Client_ID@ AND M_CostMovement_v.AD_Org_ID=@AD_Org_ID@ AND M_CostMovement_v.M_Product_ID=@M_Product_ID@ AND M_CostMovement_v.M_CostType_ID=@M_CostType_ID@ AND M_CostMovement_v.C_AcctSchema_ID=@C_AcctSchema_ID@ AND M_CostMovement_v.M_CostElement_ID=@M_CostElement_ID@ AND M_CostMovement_v.M_AttributeSetInstance_ID=@M_AttributeSetInstance_ID@','Y','N','N','D','834474e3-50d5-41d4-a707-ca6363f19427','Show movement of cost by transaction',0,0,TO_DATE('2012-03-08 15:44:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-08 15:44:41','YYYY-MM-DD HH24:MI:SS'),2,'N',100,'N','Y',200000)
;

-- Mar 8, 2012 3:44:42 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Name,Help,CommitWarning,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Tab_ID, t.Name,t.Help,t.CommitWarning,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Mar 8, 2012 3:45:13 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Rules for accounting',200005,'Y','N',200043,'N','Y','N','8b6b26dc-1c4b-4db8-b09e-a756d8128dd6','D',100,'Accounting Schema',100,0,TO_DATE('2012-03-08 15:45:12','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:12','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar','Y')
;

-- Mar 8, 2012 3:45:13 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:15 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('The record is active in the system',200006,'Y','N',200074,'N','Y','N','73f9fbe4-fe30-48b3-b790-6581a4e61370','D',100,'Active',100,0,TO_DATE('2012-03-08 15:45:14','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:14','YYYY-MM-DD HH24:MI:SS'),'N',200000,1,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y')
;

-- Mar 8, 2012 3:45:15 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200006 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:16 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Amount',200007,'Y','N',200058,'N','Y','N','d7e2508d-3eeb-43b7-bbee-234fed237065','D',100,'Amount',100,0,TO_DATE('2012-03-08 15:45:15','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:15','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Amount','Y')
;

-- Mar 8, 2012 3:45:16 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:17 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Product Attribute Set Instance',200008,'Y','N',200047,'N','Y','N','66f09047-e4cb-4b09-bcc0-6cdc109a60d6','D',100,'Attribute Set Instance',100,0,TO_DATE('2012-03-08 15:45:16','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:16','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.','Y')
;

-- Mar 8, 2012 3:45:17 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:18 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Client/Tenant for this installation.',200009,'Y','N',200041,'N','Y','N','65399c71-c4b2-4cab-90e0-7d61204e98da','D',100,'Client',100,0,TO_DATE('2012-03-08 15:45:17','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:17','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y')
;

-- Mar 8, 2012 3:45:18 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:19 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Cost Detail Information',200010,'Y','N',200068,'N','Y','N','65779cfa-bc31-413a-8e0c-4ef258a1b0f8','D',100,'Cost Detail',100,0,TO_DATE('2012-03-08 15:45:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:18','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','Y')
;

-- Mar 8, 2012 3:45:19 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:19 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Product Cost Element',200011,'Y','N',200046,'N','Y','N','8bcb338d-e86f-488d-aaf5-98d8e2c9dca2','D',100,'Cost Element',100,0,TO_DATE('2012-03-08 15:45:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:19','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','Y')
;

-- Mar 8, 2012 3:45:19 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200011 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:20 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Movement history for M_Cost',200012,'Y','N',200044,'N','Y','N','39f40544-5bb5-4bdb-ba4a-85b64905ad51','D',100,'Cost History',100,0,TO_DATE('2012-03-08 15:45:19','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:19','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','Y')
;

-- Mar 8, 2012 3:45:20 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:21 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Type of Cost (e.g. Current, Plan, Future)',200013,'Y','N',200045,'N','Y','N','8bf1fec8-10b3-46ab-93d2-73e688fe5296','D',100,'Cost Type',100,0,TO_DATE('2012-03-08 15:45:20','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:20','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','You can define multiple cost types. A cost type selected in an Accounting Schema is used for accounting.','Y')
;

-- Mar 8, 2012 3:45:21 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:22 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Difference Amount',200014,'Y','N',200060,'N','Y','N','a7e2ad58-1b58-486f-8f49-38ca9bb28208','D',100,'Delta Amount',100,0,TO_DATE('2012-03-08 15:45:21','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:21','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:22 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:23 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Quantity Difference',200015,'Y','N',200059,'N','Y','N','f7b15a16-dc17-486e-b19e-f9045e1be9af','D',100,'Delta Quantity',100,0,TO_DATE('2012-03-08 15:45:22','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:22','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:23 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200015 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:23 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Optional short description of the record',200016,'Y','N',200069,'N','Y','N','6597ecd8-91a1-4b3a-acaa-4bb2fc3d0122','D',100,'Description',100,0,TO_DATE('2012-03-08 15:45:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:23','YYYY-MM-DD HH24:MI:SS'),'N',200000,255,'N','A description is limited to 255 characters.','Y')
;

-- Mar 8, 2012 3:45:23 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200016 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:24 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Invoice Detail Line',200017,'Y','N',200063,'N','Y','N','5223bee9-051a-4811-904d-58ddad14eac2','D',100,'Invoice Line',100,0,TO_DATE('2012-03-08 15:45:23','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:23','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','The Invoice Line uniquely identifies a single line of an Invoice.','Y')
;

-- Mar 8, 2012 3:45:24 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200017 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:25 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Inventory Move document Line',200018,'Y','N',200064,'N','Y','N','32104954-503b-455d-bdf6-f0bd8b1168a1','D',100,'Move Line',100,0,TO_DATE('2012-03-08 15:45:24','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:24','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','The Movement Line indicates the inventory movement document line (if applicable) for this transaction','Y')
;

-- Mar 8, 2012 3:45:25 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200018 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:26 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Accumulated Amt after processing of M_CostDetail',200019,'Y','N',200056,'N','Y','N','78928c1f-21bd-4fc1-bdc8-4a5145a445e0','D',100,'New Accumulated Amt',100,0,TO_DATE('2012-03-08 15:45:25','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:25','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:26 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200019 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:27 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('New Accumulated Qty after processing of M_CostDetail',200020,'Y','N',200054,'N','Y','N','86dcee6e-9d39-473b-8580-847c4fc8b37f','D',100,'New Accumulated Qty',100,0,TO_DATE('2012-03-08 15:45:26','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:26','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:27 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:28 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('New current cost price after processing of M_CostDetail',200021,'Y','N',200052,'N','Y','N','b8569191-fc3c-4c49-a95d-d0f36b02ae34','D',100,'New Cost Price',100,0,TO_DATE('2012-03-08 15:45:27','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:27','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:28 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:28 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('New current quantity after processing of M_CostDetail',200022,'Y','N',200050,'N','Y','N','3464b90f-85cc-4d1a-bad2-00a16ac0597d','D',100,'New Current Quantity',100,0,TO_DATE('2012-03-08 15:45:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:28','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:28 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:29 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Old accumulated amt before the processing of M_CostDetail',200023,'Y','N',200055,'N','Y','N','0f1102a0-ef80-4fb5-b68b-34103fdf5f64','D',100,'Old Accumulated Amt',100,0,TO_DATE('2012-03-08 15:45:28','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:28','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:29 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:30 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Old accumulated qty before the processing of M_CostDetail',200024,'Y','N',200053,'N','Y','N','d13f478d-3408-43e5-851b-396c060f5278','D',100,'Old Accumulated Qty',100,0,TO_DATE('2012-03-08 15:45:29','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:29','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:30 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200024 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:31 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Old current cost price before the processing of M_CostDetail',200025,'Y','N',200051,'N','Y','N','31c9b27e-53d7-47d2-95f0-f2fe497ad44c','D',100,'Old Current Cost Price',100,0,TO_DATE('2012-03-08 15:45:30','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:30','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:31 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:32 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,IsActive) VALUES ('Old current quantity before the processing of M_CostDetail',200026,'Y','N',200049,'N','Y','N','a9e57492-bda2-463d-8081-d76255673b56','D',100,'Old Current Quantity',100,0,TO_DATE('2012-03-08 15:45:31','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:31','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','Y')
;

-- Mar 8, 2012 3:45:32 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:32 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Organizational entity within client',200027,'Y','N',200042,'N','Y','N','0d987f31-d5df-4efc-8cb6-d70a7dc3d433','D',100,'Organization',100,0,TO_DATE('2012-03-08 15:45:32','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:32','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y')
;

-- Mar 8, 2012 3:45:32 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:33 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Unique line in an Inventory document',200028,'Y','N',200065,'N','Y','N','faf7306c-9429-4840-a5df-9de9748ec660','D',100,'Phys.Inventory Line',100,0,TO_DATE('2012-03-08 15:45:32','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:32','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','The Physical Inventory Line indicates the inventory document line (if applicable) for this transaction','Y')
;

-- Mar 8, 2012 3:45:33 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:34 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Product, Service, Item',200029,'Y','N',200048,'N','Y','N','cd3d0301-7559-4cb9-8883-aa7f2c9184b9','D',100,'Product',100,0,TO_DATE('2012-03-08 15:45:33','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:33','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','Identifies an item which is either purchased or sold in this organization.','Y')
;

-- Mar 8, 2012 3:45:34 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200029 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:35 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Document Line representing a production',200030,'Y','N',200066,'N','Y','N','c1fe07ef-477e-4370-9583-2a24aa086316','D',100,'Production Line',100,0,TO_DATE('2012-03-08 15:45:34','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:34','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','The Production Line indicates the production document line (if applicable) for this transaction','Y')
;

-- Mar 8, 2012 3:45:35 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200030 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:36 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Project Issues (Material, Labor)',200031,'Y','N',200067,'N','Y','N','3022e456-5a80-448d-81ce-837ccd8a7488','D',100,'Project Issue',100,0,TO_DATE('2012-03-08 15:45:35','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:35','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','Issues to the project initiated by the "Issue to Project" process. You can issue Receipts, Time and Expenses, or Stock.','Y')
;

-- Mar 8, 2012 3:45:36 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200031 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:37 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Quantity',200032,'Y','N',200057,'N','Y','N','f67d0bc4-3239-49bd-a00e-47125316dc54','D',100,'Quantity',100,0,TO_DATE('2012-03-08 15:45:36','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:36','YYYY-MM-DD HH24:MI:SS'),'N',200000,22,'N','The Quantity indicates the number of a specific product or item for this document.','Y')
;

-- Mar 8, 2012 3:45:37 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200032 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:38 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Sales Order Line',200033,'Y','N',200061,'N','Y','N','99e6a7fa-b939-481d-942c-0ea8fc936630','D',100,'Sales Order Line',100,0,TO_DATE('2012-03-08 15:45:37','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:37','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','The Sales Order Line is a unique identifier for a line in an order.','Y')
;

-- Mar 8, 2012 3:45:38 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200033 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:45:38 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field (Description,AD_Field_ID,IsDisplayed,IsSameLine,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,IsReadOnly,AD_Field_UU,EntityType,UpdatedBy,Name,CreatedBy,AD_Org_ID,Created,AD_Client_ID,Updated,IsEncrypted,AD_Tab_ID,DisplayLength,IsHeading,Help,IsActive) VALUES ('Line on Shipment or Receipt document',200034,'Y','N',200062,'N','Y','N','945e92e7-d23f-407d-88e2-741216b30bb1','D',100,'Shipment/Receipt Line',100,0,TO_DATE('2012-03-08 15:45:38','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-03-08 15:45:38','YYYY-MM-DD HH24:MI:SS'),'N',200000,10,'N','The Shipment/Receipt Line indicates a unique line in a Shipment/Receipt document','Y')
;

-- Mar 8, 2012 3:45:38 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200034 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200006
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200009
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200012
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200027
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200005
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200013
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200011
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200010
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200029
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200008
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200032
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200007
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200014
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200015
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200026
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200025
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200024
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200023
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200022
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200021
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200020
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200019
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200016
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200018
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200017
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200028
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=200030
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=200031
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=200033
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=200034
;

-- Mar 8, 2012 3:49:48 PM MYT
-- IDEMPIERE-117 Add cost history table and cost movement view
CREATE OR REPLACE VIEW m_costmovement_v AS 
SELECT a.ad_client_id, a.ad_org_id, b.c_acctschema_id, a.m_costhistory_id, a.m_costtype_id, a.m_costelement_id, a.m_attributesetinstance_id, b.m_product_id, a.oldqty, a.newqty, a.oldcostprice, a.newcostprice, a.oldcqty, a.newcqty, a.oldcamt, a.newcamt, b.qty, b.amt, b.deltaqty, b.deltaamt, b.c_orderline_id, b.m_inoutline_id, b.c_invoiceline_id, b.m_movementline_id, b.m_inventoryline_id, b.m_productionline_id, b.c_projectissue_id, a.m_costdetail_id, b.description, a.created, a.createdby, a.updated, a.updatedby, a.isactive
   FROM m_costhistory a
   JOIN m_costdetail b ON a.m_costdetail_id = b.m_costdetail_id
   ORDER BY a.m_costhistory_id
;

