-- Aug 23, 2013 6:09:08 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID) VALUES ('N','N','N','2',0,200105,'Y','N','N','D','L','af0292e5-c824-47c2-b0cd-99ec92b9fc02','Y','Y','AD_Package_UUID_Map','UUID Mapping between client','UUID Mapping','Y',0,100,TO_TIMESTAMP('2013-08-23 18:09:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-23 18:09:02','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Aug 23, 2013 6:09:08 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200105 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 23, 2013 6:09:09 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Sequence_UU,IncrementNo,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200153,'Table AD_Package_UUID_Map','AD_Package_UUID_Map','9948e67a-a19d-4dfe-9228-a214e1c93e1e',1,0,TO_TIMESTAMP('2013-08-23 18:09:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-23 18:09:08','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 23, 2013 6:10:25 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210832,'Y','N','N',0,'N',22,'N',19,129,'N','N','Y','add3d617-c9de-4c23-9867-0d6074f70ad3','Y','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-08-23 18:10:13','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:10:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 23, 2013 6:10:25 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210832 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:11:04 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210833,'Y','N','N',0,'N',22,'N',19,104,'N','N','Y','38aa87a9-c67a-4351-a18c-52469ea72657','Y','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-08-23 18:11:01','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:11:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 23, 2013 6:11:04 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210833 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:12:04 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,Description,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_Package_UUID_Map_ID',202600,'UUID Mapping','UUID Mapping between client','UUID Mapping','cf8700a9-65fc-4e1b-afd6-46ed72ca43f1',TO_TIMESTAMP('2013-08-23 18:11:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-23 18:11:52','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 23, 2013 6:12:04 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202600 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 23, 2013 6:12:53 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210834,'Y','N','N',0,'N',22,'N',13,'Y','N','Y','bd0090c4-a751-4eb0-8e4c-0bbc50a28df0','N','AD_Package_UUID_Map_ID','UUID Mapping between client','UUID Mapping','N',TO_TIMESTAMP('2013-08-23 18:12:50','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:12:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202600,'N')
;

-- Aug 23, 2013 6:12:53 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210834 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:13:54 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_Package_UUID_Map_UU',202601,'AD_Package_UUID_Map_UU','AD_Package_UUID_Map_UU','f1a4bfdf-04f0-4aa5-b802-8c3d4cf87341',TO_TIMESTAMP('2013-08-23 18:13:53','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-23 18:13:53','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 23, 2013 6:13:54 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202601 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 23, 2013 6:14:40 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210835,'Y','N','N',0,'N',36,'N',10,'Y','N','Y','52880297-49ce-4540-ade6-e478aa5d3076','N','AD_Package_UUID_Map_UU','AD_Package_UUID_Map_UU','N',TO_TIMESTAMP('2013-08-23 18:14:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:14:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202601,'N')
;

-- Aug 23, 2013 6:14:40 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210835 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:16:23 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210837,'Y','N','N',0,'N',7,'N',16,'N','N','Y','e88a593c-9947-4093-9fa7-9bc3e345f9b5','Y','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-08-23 18:16:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:16:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 23, 2013 6:16:23 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210837 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:16:57 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210838,110,'Y','N','N',0,'N',22,'N',18,'N','N','Y','f630df83-a88f-42cb-a60f-6756bde50649','Y','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-08-23 18:16:56','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:16:56','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 23, 2013 6:16:57 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210838 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:17:43 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210839,'Y','N','N',0,'N',1,'N',20,'N','N','Y','7549ea93-ce4e-4ea8-b830-736f7f9827c6','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-08-23 18:17:42','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:17:42','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 23, 2013 6:17:43 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210839 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:18:23 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210840,'Y','N','N',0,'N',7,'N',16,'N','N','Y','fd68c9c1-769f-4d4d-909e-f6a0d4d3cb7b','Y','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-08-23 18:18:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:18:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 23, 2013 6:18:23 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210840 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:18:52 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210841,110,'Y','N','N',0,'N',22,'N',18,'N','N','Y','637cd467-7d2e-49ee-bffe-998b9f5accad','Y','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-08-23 18:18:51','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:18:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 23, 2013 6:18:52 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210841 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:20:17 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,Description,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('Source_UUID',202602,'Source UUID','UUID from the source client','Source UUID','336c16a3-9fea-48c1-a566-86f477383069',TO_TIMESTAMP('2013-08-23 18:20:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-23 18:20:16','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 23, 2013 6:20:17 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202602 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 23, 2013 6:22:35 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,Description,PrintName,AD_Element_UU,Created,Updated,CreatedBy,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('Target_UUID',202603,'Target UUID','New UUID created by the pack in client','Target UUID','6f1310ba-bbd7-4338-ac10-34fd8f2fe3b7',TO_TIMESTAMP('2013-08-23 18:22:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-23 18:22:34','YYYY-MM-DD HH24:MI:SS'),100,0,100,'Y',0,'D')
;

-- Aug 23, 2013 6:22:35 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202603 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 23, 2013 6:24:27 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (1,'N',1,200105,210842,'Y','N','Y',1,'N',36,'Y',10,'N','N','Y','b9230f9c-dd53-4a68-905b-f218b0a72eac','N','Source_UUID','UUID from the source client','Source UUID','N',TO_TIMESTAMP('2013-08-23 18:24:25','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:24:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202602,'N')
;

-- Aug 23, 2013 6:24:27 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210842 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:25:09 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (2,'N',1,200105,210843,'Y','N','Y',2,'N',36,'Y',10,'N','N','Y','eaaaf750-9b4c-46d1-8bd1-e6bd2d7ae4a6','N','Target_UUID','New UUID created by the pack in client','Target UUID','N',TO_TIMESTAMP('2013-08-23 18:25:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:25:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202603,'N')
;

-- Aug 23, 2013 6:25:10 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210843 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:27:00 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',1,200105,210844,'Y','N','Y',0,'N',22,'Y',19,'N','N','Y','ab0a41c6-0721-4847-abc3-6c485177a043','N','AD_Table_ID','Database Table information','The Database Table provides the information of the table definition','Table','N',TO_TIMESTAMP('2013-08-23 18:26:58','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-23 18:26:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',126,'N')
;

-- Aug 23, 2013 6:27:00 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210844 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 23, 2013 6:27:55 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
UPDATE AD_Column SET IsKey='N',Updated=TO_TIMESTAMP('2013-08-23 18:27:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210835
;

-- Aug 23, 2013 6:27:59 PM MYT
-- IDEMPIERE-1298 2Pack: Support copying of data from one client to another
CREATE TABLE AD_Package_UUID_Map (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Package_UUID_Map_ID NUMERIC(10) NOT NULL, AD_Package_UUID_Map_UU VARCHAR(36) NOT NULL, AD_Table_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Source_UUID VARCHAR(36) NOT NULL, Target_UUID VARCHAR(36) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_Package_UUID_Map_Key PRIMARY KEY (AD_Package_UUID_Map_ID), CONSTRAINT AD_Package_UUID_Map_UU_idx UNIQUE (AD_Package_UUID_Map_UU))
;

ALTER TABLE AD_Package_UUID_Map ADD CONSTRAINT AD_Package_UUID_Map_CTST_Idx UNIQUE ( AD_Client_ID, AD_Table_ID, Source_UUID, Target_UUID )
;

SELECT register_migration_script('201308260558_IDEMPIERE-1298.sql') FROM dual
;

