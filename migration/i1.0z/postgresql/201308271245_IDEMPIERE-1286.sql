-- Aug 19, 2013 1:45:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing) VALUES ('N','N','N','4',0,200100,'N','N','N','D','L','c0eeead8-4b45-4ba9-9795-30ddafa8d62f','Y','Y','C_AddressValidationCfg','Address Validation Configuration','Y',0,100,TO_TIMESTAMP('2013-08-19 13:45:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:45:41','YYYY-MM-DD HH24:MI:SS'),0,'N')
;

-- Aug 19, 2013 1:45:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200100 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 19, 2013 1:45:44 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200137,'Table C_AddressValidationCfg','C_AddressValidationCfg',1,'075713d4-df1d-4260-b328-f6897257719a',0,TO_TIMESTAMP('2013-08-19 13:45:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:45:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 19, 2013 1:46:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210733,'Y','N','N','N',22,'N',19,129,'N','N','Y','348c44ed-c67f-4b18-bda9-767e56fc7664','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-08-19 13:46:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 19, 2013 1:46:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210733 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210734,'Y','N','N','N',22,'N',19,104,'N','N','Y','9c9ec043-7867-49ee-abea-01d0b7103b8e','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-08-19 13:46:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 19, 2013 1:46:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210734 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210735,'Y','N','N','N',7,'N',16,'N','N','Y','5aec3aef-69b8-4571-9ce5-1619aad79125','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-08-19 13:46:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 19, 2013 1:46:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210735 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210736,110,'Y','N','N','N',22,'N',18,'N','N','Y','d7fcce77-1937-44c9-835f-6f28388b3d38','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-08-19 13:46:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 19, 2013 1:46:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210736 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210737,'N','N','N','N',255,'Y',10,'N','N','Y','f161c36e-89f6-4661-a416-8c1368341ee9','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2013-08-19 13:46:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275,'N')
;

-- Aug 19, 2013 1:46:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210737 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210738,'Y','N','N',0,'N',60,'N',10,'N','N','Y','23090a37-4ee4-497f-8073-2e47dc67f3af','Y','HostAddress','Host Address URL or DNS','The Host Address identifies the URL or DNS of the target host','Host Address','Y',TO_TIMESTAMP('2013-08-19 13:46:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1398,'Y')
;

-- Aug 19, 2013 1:46:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210738 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:11 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210739,'Y','N','N',0,'N',14,'N',11,'N','N','Y','e1ae26c3-47d8-4aeb-94ff-5c2f3b21b6b1','Y','HostPort','Host Communication Port','The Host Port identifies the port to communicate with the host.','Host port','Y',TO_TIMESTAMP('2013-08-19 13:46:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1399,'N')
;

-- Aug 19, 2013 1:46:11 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210739 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210740,'Y','N','N','N',1,'N',20,'N','N','Y','8bac6d4c-55bb-430d-b710-ae6ec0f56cd5','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-08-19 13:46:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 19, 2013 1:46:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210740 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_AddressValidationCfg_ID',202588,'Address Validation Configuration','Address Validation Configuration','ee108d77-11b3-4dc8-bf07-ee9ec19b5822',TO_TIMESTAMP('2013-08-19 13:46:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 13:46:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 1:46:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202588 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 1:46:14 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210741,'Y','N','N','N',22,'N',13,'Y','N','Y','3ab80905-c92a-4112-886e-8fd3bb83c06e','N','C_AddressValidationCfg_ID','Address Validation Configuration','N',TO_TIMESTAMP('2013-08-19 13:46:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202588,'N')
;

-- Aug 19, 2013 1:46:14 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210741 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_AddressValidationCfg_UU',202589,'C_AddressValidationCfg_UU','C_AddressValidationCfg_UU','707bd6a2-7c15-48fd-b59a-96ecce955285',TO_TIMESTAMP('2013-08-19 13:46:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 13:46:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 1:46:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202589 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 1:46:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1.00,200100,210742,'N','N','N','N',36,'N',10,'N','N','Y','9d579914-3db9-4ac4-a172-c7a31b766738','Y','C_AddressValidationCfg_UU','C_AddressValidationCfg_UU','N',TO_TIMESTAMP('2013-08-19 13:46:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202589,'N')
;

-- Aug 19, 2013 1:46:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210742 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210743,'Y','N','Y',1,'N',60,'Y',10,'N','N','Y','2d1fbbcb-9ba5-4157-8221-30cd0f75dad3','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2013-08-19 13:46:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469,'N')
;

-- Aug 19, 2013 1:46:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210743 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210744,'N','N','N',0,'N',60,'N',10,'N','N','Y','de6aa024-0ae9-47f9-b039-034d7910ca90','Y','ProxyAddress',' Address of your proxy server','The Proxy Address must be defined if you must pass through a firewall to access your payment processor. ','Proxy address','Y',TO_TIMESTAMP('2013-08-19 13:46:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1418,'Y')
;

-- Aug 19, 2013 1:46:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210744 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210745,'N','N','N',0,'N',60,'N',10,'N','N','Y','1274a5fd-98de-4703-bab7-18c1ace0c214','Y','ProxyLogon','Logon of your proxy server','The Proxy Logon identifies the Logon ID for your proxy server.','Proxy logon','Y',TO_TIMESTAMP('2013-08-19 13:46:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1419,'Y')
;

-- Aug 19, 2013 1:46:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210745 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210746,'N','N','N',0,'N',60,'N',10,'N','N','Y','0e0dcf2d-2a45-41eb-8725-06d0c849bb1f','Y','ProxyPassword','Password of your proxy server','The Proxy Password identifies the password for your proxy server.','Proxy password','Y',TO_TIMESTAMP('2013-08-19 13:46:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1420,'Y')
;

-- Aug 19, 2013 1:46:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210746 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210747,'N','N','N',0,'N',14,'N',11,'N','N','Y','0f6b43b1-e249-4bcb-be62-2c2f4d3b63ed','Y','ProxyPort','Port of your proxy server','The Proxy Port identifies the port of your proxy server.','Proxy port','Y',TO_TIMESTAMP('2013-08-19 13:46:19','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1421,'N')
;

-- Aug 19, 2013 1:46:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210747 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210748,'N','N','N',0,'N',60,'N',10,'N','N','Y','8e1b6a48-07c2-452a-8761-a117bd4a946a','Y','ServicePath','Service Path','Y',TO_TIMESTAMP('2013-08-19 13:46:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200263,'N')
;

-- Aug 19, 2013 1:46:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210748 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210749,'N','N','N',0,'N',60,'N',10,'N','N','Y','2799153f-63dd-4c8f-ad49-8becebf3e56c','Y','ShippingProcessorClass','Shipping Processor Class','Y',TO_TIMESTAMP('2013-08-19 13:46:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200264,'N')
;

-- Aug 19, 2013 1:46:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210749 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210750,'Y','N','N','N',7,'N',16,'N','N','Y','4b77a749-f6f9-44bd-9f96-db2d9a5acd36','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-08-19 13:46:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 19, 2013 1:46:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210750 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200100,210751,110,'Y','N','N','N',22,'N',18,'N','N','Y','06ba41e2-cd15-464d-b859-c6670fdd599c','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-08-19 13:46:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:46:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 19, 2013 1:46:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210751 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:46:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210749
;

-- Aug 19, 2013 1:46:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210749
;

-- Aug 19, 2013 1:47:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AddressValidationClass',202590,'Address Validation Class','Address Validation Class','0dab0331-32c6-46e7-8ee3-1d32b2f00910',TO_TIMESTAMP('2013-08-19 13:47:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 13:47:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 1:47:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202590 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 1:47:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200100,210752,'N','N','N',0,'N',60,'N',10,'N','N','Y','9fa5de01-2212-48c0-831b-34ebfef3eec7','Y','AddressValidationClass','Address Validation Class','Y',TO_TIMESTAMP('2013-08-19 13:47:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:47:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202590,'N')
;

-- Aug 19, 2013 1:47:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210752 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:47:40 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
CREATE TABLE C_AddressValidationCfg (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AddressValidationClass VARCHAR(60) DEFAULT NULL , C_AddressValidationCfg_ID NUMERIC(10) NOT NULL, C_AddressValidationCfg_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , HostAddress VARCHAR(60) NOT NULL, HostPort NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, ProxyAddress VARCHAR(60) DEFAULT NULL , ProxyLogon VARCHAR(60) DEFAULT NULL , ProxyPassword VARCHAR(60) DEFAULT NULL , ProxyPort NUMERIC(10) DEFAULT NULL , ServicePath VARCHAR(60) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_AddressValidationCfg_Key PRIMARY KEY (C_AddressValidationCfg_ID), CONSTRAINT C_AddressValidationCfg_UU_idx UNIQUE (C_AddressValidationCfg_UU))
;

-- Aug 19, 2013 1:47:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidationCfg ADD CONSTRAINT ADClient_CAddressValidationCfg FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id)
;

-- Aug 19, 2013 1:47:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidationCfg ADD CONSTRAINT ADOrg_CAddressValidationCfg FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id)
;

-- Aug 19, 2013 1:47:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidationCfg ADD CONSTRAINT CreatedBy_CAddressValidationCf FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 19, 2013 1:47:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidationCfg ADD CONSTRAINT UpdatedBy_CAddressValidationCf FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 19, 2013 1:48:57 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing) VALUES ('N','N','N','4',0,200101,'N','N','N','D','L','ced5b088-35ab-491e-bdb2-21b5a7d3cdb6','Y','Y','C_AddressValidation','Address Validation','Y',0,100,TO_TIMESTAMP('2013-08-19 13:48:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:48:57','YYYY-MM-DD HH24:MI:SS'),0,'N')
;

-- Aug 19, 2013 1:48:57 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200101 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 19, 2013 1:48:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200138,'Table C_AddressValidation','C_AddressValidation',1,'4537338e-0ddc-44a3-a833-51750e080d42',0,TO_TIMESTAMP('2013-08-19 13:48:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:48:57','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 19, 2013 1:49:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210753,'Y','N','N','N',22,'N',19,129,'N','N','Y','7665d505-4a9c-4ac2-b239-d61fbeb11ec0','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-08-19 13:49:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 19, 2013 1:49:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210753 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210754,'Y','N','N','N',22,'N',19,104,'N','N','Y','271538e4-0781-4eab-9cba-ff4583d44fcd','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-08-19 13:49:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 19, 2013 1:49:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210754 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210755,'N','N','N',0,'N',60,'N',10,'N','N','Y','37229256-040b-4a85-83e7-968b296211ef','Y','ConnectionKey','Connection Key','Y',TO_TIMESTAMP('2013-08-19 13:49:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200261,'Y')
;

-- Aug 19, 2013 1:49:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210755 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210756,'Y','N','N',0,'N',60,'N',10,'N','N','Y','b050144d-7e57-4aad-a1fb-c8efb1ead44b','Y','ConnectionPassword','Connection Password','Y',TO_TIMESTAMP('2013-08-19 13:49:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200262,'Y')
;

-- Aug 19, 2013 1:49:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210756 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210757,'Y','N','N','N',7,'N',16,'N','N','Y','4d8e304f-44fd-465e-a919-494da15bbdd4','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-08-19 13:49:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 19, 2013 1:49:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210757 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:11 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210758,110,'Y','N','N','N',22,'N',18,'N','N','Y','3258d6ed-4afa-4beb-bfd0-2af1d4ed64f8','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-08-19 13:49:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 19, 2013 1:49:11 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210758 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210759,'Y','N','N','N',1,'N',20,'N','N','Y','83dce411-b8bb-4809-ac60-6c91954f938d','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-08-19 13:49:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 19, 2013 1:49:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210759 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_AddressValidation_ID',202591,'Address Validation','Address Validation','1c1cfd5a-de13-4cb4-95e7-a110b5f9d2ac',TO_TIMESTAMP('2013-08-19 13:49:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 13:49:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 1:49:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202591 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 1:49:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210760,'Y','N','N','N',22,'N',13,'Y','N','Y','5985d6f8-58a7-4af6-b8ef-554dcb634a85','N','C_AddressValidation_ID','Address Validation','N',TO_TIMESTAMP('2013-08-19 13:49:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202591,'N')
;

-- Aug 19, 2013 1:49:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210760 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:14 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_AddressValidation_UU',202592,'C_AddressValidation_UU','C_AddressValidation_UU','63b5954f-5ad3-466e-acf3-303cde57966a',TO_TIMESTAMP('2013-08-19 13:49:13','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 13:49:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 1:49:14 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202592 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 1:49:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1.00,200101,210761,'N','N','N','N',36,'N',10,'N','N','Y','f6a8a5c2-a30d-4b55-ac1b-051754084852','Y','C_AddressValidation_UU','C_AddressValidation_UU','N',TO_TIMESTAMP('2013-08-19 13:49:13','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202592,'N')
;

-- Aug 19, 2013 1:49:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210761 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,Callout,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210762,'Y','N','N',0,'N',10,'N',19,'N','N','Y','9ccdeb41-0355-46af-a7c6-1e7bc97b9716','Y','org.compiere.model.CalloutShippingProcessor.shippingProcessor','M_ShippingProcessorCfg_ID','Shipping Processor Configuration','Y',TO_TIMESTAMP('2013-08-19 13:49:15','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200599,'N')
;

-- Aug 19, 2013 1:49:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210762 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210763,'Y','N','Y',0,'N',60,'Y',10,'N','N','Y','27edd98b-8390-4f5a-8247-d1a48b93a475','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','N',TO_TIMESTAMP('2013-08-19 13:49:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469,'N')
;

-- Aug 19, 2013 1:49:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210763 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210764,'Y','N','N','N',7,'N',16,'N','N','Y','47f46b7d-a3c4-489b-a28e-38604f5cd4d4','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-08-19 13:49:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 19, 2013 1:49:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210764 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('Y',1,200101,210765,110,'Y','N','N','N',22,'N',18,'N','N','Y','e2755153-f541-4560-adf6-701e763f7c3e','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-08-19 13:49:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 19, 2013 1:49:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210765 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210766,'Y','N','N',0,'N',60,'N',10,'N','N','Y','8f806c31-f76c-403b-b345-094255f9bd33','Y','UserID','User ID or account number','The User ID identifies a user and allows access to records or processes.','User ID','Y',TO_TIMESTAMP('2013-08-19 13:49:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 13:49:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1444,'Y')
;

-- Aug 19, 2013 1:49:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210766 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 1:49:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-08-19 13:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200101
;

-- Aug 19, 2013 1:49:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Column SET FieldLength=22, IsUpdateable='N', ColumnName='C_AddressValidationCfg_ID', Description=NULL, Help=NULL, Name='Address Validation Configuration', AD_Element_ID=202588,Updated=TO_TIMESTAMP('2013-08-19 13:49:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210762
;

-- Aug 19, 2013 1:49:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET Name='Address Validation Configuration', Description=NULL, Help=NULL WHERE AD_Column_ID=210762 AND IsCentrallyMaintained='Y'
;

-- Aug 19, 2013 1:50:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Column SET Callout='org.compiere.model.CalloutAddressValidation.addressValidation',Updated=TO_TIMESTAMP('2013-08-19 13:50:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210762
;

-- Aug 19, 2013 1:51:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
CREATE TABLE C_AddressValidation (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_AddressValidation_ID NUMERIC(10) NOT NULL, C_AddressValidation_UU VARCHAR(36) DEFAULT NULL , C_AddressValidationCfg_ID NUMERIC(10) NOT NULL, ConnectionKey VARCHAR(60) DEFAULT NULL , ConnectionPassword VARCHAR(60) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, UserID VARCHAR(60) NOT NULL, CONSTRAINT C_AddressValidation_Key PRIMARY KEY (C_AddressValidation_ID), CONSTRAINT C_AddressValidation_UU_idx UNIQUE (C_AddressValidation_UU))
;

-- Aug 19, 2013 1:51:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD CONSTRAINT ADClient_CAddressValidation FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id)
;

-- Aug 19, 2013 1:51:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD CONSTRAINT ADOrg_CAddressValidation FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id)
;

-- Aug 19, 2013 1:51:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD CONSTRAINT CAddressValidationCfg_CAddress FOREIGN KEY (C_AddressValidationCfg_ID) REFERENCES c_addressvalidationcfg(c_addressvalidationcfg_id)
;

-- Aug 19, 2013 1:51:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD CONSTRAINT CreatedBy_CAddressValidation FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 19, 2013 1:51:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD CONSTRAINT UpdatedBy_CAddressValidation FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 19, 2013 1:53:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID) VALUES ('N','M','Y','N','N',0,0,'D','Address Validation Configuration',200046,'286349c9-b98f-4fca-b325-f50c47ee9e9d',TO_TIMESTAMP('2013-08-19 13:53:57','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 13:53:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0)
;

-- Aug 19, 2013 1:53:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200046 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Aug 19, 2013 1:54:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','Y',200046,10,'N','N',200100,'N','N','N','Y','N',0,'ed765b32-b284-4052-9179-45246f613eea','D','Address Validation',200107,0,TO_TIMESTAMP('2013-08-19 13:54:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:54:47','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Aug 19, 2013 1:54:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200107 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 19, 2013 1:54:57 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200107,22,'N','N',210733,10,'Y',202404,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','4715d30f-86a9-42d2-bdca-ccfb0d1aa4cb','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:54:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:54:56','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 1:54:57 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202404 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:54:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200107,22,'N','N',210734,20,'Y',202405,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','9b13a824-0000-4f69-86e1-2774c5c6499b','Y','N','Y',100,0,TO_TIMESTAMP('2013-08-19 13:54:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:54:57','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,0,2)
;

-- Aug 19, 2013 1:54:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202405 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:54:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,60,'N','N',210743,30,'Y',202406,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','fd420737-2515-4cae-9dad-3ba79d8321c5','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:54:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:54:58','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:54:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202406 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:54:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,255,'N','N',210737,40,'Y',202407,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','b44280c5-581b-4fd2-bb12-e5b3f910e5f3','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:54:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:54:59','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:54:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202407 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:00 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,60,'N','N',210738,50,'Y',202408,'N','The Host Address identifies the URL or DNS of the target host','D','Host Address URL or DNS','Host Address','72ac66ae-de28-4f07-a1f4-6a0682e0dae1','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:54:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:54:59','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:55:00 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202408 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,14,'N','N',210739,60,'Y',202409,'N','The Host Port identifies the port to communicate with the host.','D','Host Communication Port','Host port','f2bd94e6-f23e-413d-99cb-7d69b0bb3cac','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:00','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 1:55:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202409 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200107,22,'N','N',210741,70,'Y',202410,'N','D','Address Validation Configuration','e998f089-3dfe-4eb2-91f3-4f42c826ff8c','N','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:01','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 1:55:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202410 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200107,36,'N','N',210742,80,'Y',202411,'N','D','C_AddressValidationCfg_UU','9bea7b2b-bb38-4227-8b86-2f14a9432311','N','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:02','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 1:55:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202411 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:03 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,60,'N','N',210744,90,'Y',202412,'N','The Proxy Address must be defined if you must pass through a firewall to access your payment processor. ','D',' Address of your proxy server','Proxy address','842d6e4c-5511-4ef2-9034-a32624a208aa','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:02','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:55:03 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202412 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,60,'N','N',210745,100,'Y',202413,'N','The Proxy Logon identifies the Logon ID for your proxy server.','D','Logon of your proxy server','Proxy logon','42c4f20e-5706-4bae-a927-adce5e83e4be','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:03','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:55:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202413 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,60,'N','N',210746,110,'Y',202414,'N','The Proxy Password identifies the password for your proxy server.','D','Password of your proxy server','Proxy password','4fbed116-25c6-4327-b69b-5a20299201ab','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:04','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:55:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202414 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,14,'N','N',210747,120,'Y',202415,'N','The Proxy Port identifies the port of your proxy server.','D','Port of your proxy server','Proxy port','6497d6b3-40f5-4c23-988a-ffc500ae9dcc','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:05','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 1:55:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202415 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,60,'N','N',210748,130,'Y',202416,'N','D','Service Path','88b8a5fe-d573-4fd3-8eb6-8dba8e593ed2','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:05','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:55:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202416 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200107,60,'N','N',210752,140,'Y',202417,'N','D','Address Validation Class','7ce64bbc-2f26-482a-9e98-e306e50a31fc','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:06','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:55:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202417 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200107,1,'N','N',210740,150,'Y',202418,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','f835f3bc-5131-43a1-8477-ec91cd40e918','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:55:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:55:07','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 19, 2013 1:55:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202418 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202410
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202411
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202418
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202408
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202409
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202412
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202415
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202416
;

-- Aug 19, 2013 1:55:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202417
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202404
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202405
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202406
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202407
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202418
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202408
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202409
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202412
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202415
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202413
;

-- Aug 19, 2013 1:56:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202414
;

-- Aug 19, 2013 1:56:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=202416
;

-- Aug 19, 2013 1:56:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=202417
;

-- Aug 19, 2013 1:57:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-08-19 13:57:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202404
;

-- Aug 19, 2013 1:57:11 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2013-08-19 13:57:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202409
;

-- Aug 19, 2013 1:57:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 13:57:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202408
;

-- Aug 19, 2013 1:57:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 13:57:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202412
;

-- Aug 19, 2013 1:57:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2013-08-19 13:57:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202415
;

-- Aug 19, 2013 1:57:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 13:57:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202413
;

-- Aug 19, 2013 1:57:26 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 13:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202414
;

-- Aug 19, 2013 1:57:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 13:57:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202416
;

-- Aug 19, 2013 1:57:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 13:57:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202405
;

-- Aug 19, 2013 1:57:44 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 13:57:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202409
;

-- Aug 19, 2013 1:57:45 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 13:57:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202415
;

-- Aug 19, 2013 1:57:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 13:57:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202412
;

-- Aug 19, 2013 1:57:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 13:57:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202414
;

-- Aug 19, 2013 1:57:49 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 13:57:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202413
;

-- Aug 19, 2013 1:57:50 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 13:57:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202414
;

-- Aug 19, 2013 1:57:51 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 13:57:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202416
;

-- Aug 19, 2013 1:58:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID) VALUES ('N','M','Y','N','N',0,0,'D','Address Validation',200047,'7b972bb9-66f5-4b54-a1eb-d5b5ab857b5e',TO_TIMESTAMP('2013-08-19 13:58:28','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 13:58:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0)
;

-- Aug 19, 2013 1:58:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200047 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Aug 19, 2013 1:58:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','Y',200047,10,'N','N',200101,'N','N','N','Y','N',0,'1014db9b-eb91-4776-b376-2db648f326d3','D','Address Validation',200108,0,TO_TIMESTAMP('2013-08-19 13:58:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:58:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Aug 19, 2013 1:58:48 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200108 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 19, 2013 1:58:57 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200108,22,'N','N',210753,10,'Y',202419,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','ceb9a7ca-a168-4c8b-a336-05149e51ee80','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:58:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:58:56','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 1:58:57 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202419 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:58:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200108,22,'N','N',210754,20,'Y',202420,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','af13f435-23cf-41de-8cb2-49c3d00268b8','Y','N','Y',100,0,TO_TIMESTAMP('2013-08-19 13:58:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:58:57','YYYY-MM-DD HH24:MI:SS'),'Y',4,0,2)
;

-- Aug 19, 2013 1:58:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202420 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:58:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,60,'N','N',210763,30,'Y',202421,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','f1992da2-3cf3-4ed8-a712-50b1e24bff60','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:58:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:58:58','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:58:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202421 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:58:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,60,'N','N',210755,40,'Y',202422,'N','D','Connection Key','a4a95cde-f24a-46a9-be42-e7fcb71e6777','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:58:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:58:59','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:58:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202422 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:59:00 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,60,'N','N',210756,50,'Y',202423,'N','D','Connection Password','0b887207-baca-4512-b990-314bf247515f','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:58:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:58:59','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:59:00 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202423 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:59:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200108,22,'N','N',210760,60,'Y',202424,'N','D','Address Validation','4fe62ed8-b83c-4624-8d42-ffc3569314de','N','N',100,0,TO_TIMESTAMP('2013-08-19 13:59:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:59:00','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 1:59:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202424 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:59:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200108,36,'N','N',210761,70,'Y',202425,'N','D','C_AddressValidation_UU','521c7e83-8d5c-40e9-9ee0-26be916b6675','N','N',100,0,TO_TIMESTAMP('2013-08-19 13:59:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:59:01','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 1:59:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202425 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:59:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,22,'N','N',210762,80,'Y',202426,'N','D','Address Validation Configuration','28bb5a8e-4c6a-423f-bfaf-49c62db557b0','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:59:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:59:02','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 1:59:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202426 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:59:03 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,60,'N','N',210766,90,'Y',202427,'N','The User ID identifies a user and allows access to records or processes.','D','User ID or account number','User ID','b7fd977d-48b7-4e89-947b-15b98eeae697','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:59:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:59:02','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 1:59:03 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202427 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:59:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200108,1,'N','N',210759,100,'Y',202428,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','0fa73081-e4bf-4610-bc96-ac8c54015d5a','Y','N',100,0,TO_TIMESTAMP('2013-08-19 13:59:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 13:59:03','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 19, 2013 1:59:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202428 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202424
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202425
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202426
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202421
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202428
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202427
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202422
;

-- Aug 19, 2013 1:59:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202423
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202419
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202420
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202426
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202421
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202428
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202427
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202422
;

-- Aug 19, 2013 1:59:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202423
;

-- Aug 19, 2013 2:00:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-08-19 14:00:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202419
;

-- Aug 19, 2013 2:00:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:00:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202422
;

-- Aug 19, 2013 2:00:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202427
;

-- Aug 19, 2013 2:00:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:00:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202423
;

-- Aug 19, 2013 2:00:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 14:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202420
;

-- Aug 19, 2013 2:00:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 14:00:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202422
;

-- Aug 19, 2013 2:00:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:00:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202427
;

-- Aug 19, 2013 2:00:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:00:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202422
;

-- Aug 19, 2013 2:00:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:00:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202423
;

-- Aug 19, 2013 2:02:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,"action",IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200046,200069,'N','N','N','D','Y','Address Validation Configuration','d813de03-f531-464d-8942-a06be55cc529','W','Y',100,TO_TIMESTAMP('2013-08-19 14:02:12','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-08-19 14:02:12','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 19, 2013 2:02:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Aug 19, 2013 2:02:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200069, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200069)
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200069
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200067
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Aug 19, 2013 2:02:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Aug 19, 2013 2:02:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,"action",IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200047,200070,'N','N','N','D','Y','Address Validation','4b63c92f-0a30-4a00-9d68-059afa53bcf2','W','Y',100,TO_TIMESTAMP('2013-08-19 14:02:59','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-08-19 14:02:59','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 19, 2013 2:02:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Aug 19, 2013 2:02:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200070, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200070)
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200069
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200070
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200067
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=14, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Aug 19, 2013 2:03:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=15, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Aug 19, 2013 2:18:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing) VALUES ('N','N','N','6',0,200102,'N','N','Y','D','L','7745191a-cf0c-4235-87bc-c274faaafd9c','Y','Y','C_AddressTransaction','Address Transaction','Y',0,100,TO_TIMESTAMP('2013-08-19 14:18:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:18:28','YYYY-MM-DD HH24:MI:SS'),0,'N')
;

-- Aug 19, 2013 2:18:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200102 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 19, 2013 2:18:30 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200139,'Table C_AddressTransaction','C_AddressTransaction',1,'f25c8a36-07b9-4807-b39e-c9479eebbba8',0,TO_TIMESTAMP('2013-08-19 14:18:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:18:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 19, 2013 2:18:40 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Table SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-08-19 14:18:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200102
;

-- Aug 19, 2013 2:19:03 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210767,'Y','N','N','N',22,'N',19,129,'N','N','Y','e3de01c6-c2aa-4003-b03e-edc7c0247a6a','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-08-19 14:19:02','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 19, 2013 2:19:03 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210767 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210768,'Y','N','N','N',22,'N',19,104,'N','N','Y','74c93dd7-320a-4353-b313-478cf3b38ae1','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-08-19 14:19:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 19, 2013 2:19:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210768 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210769,'N','N','N','N',60,'N',10,'N','N','Y','913cd541-b2ab-47e1-91d9-574654344c3e','Y','Address1','Address line 1 for this location','The Address 1 identifies the address for an entity''s location','Address 1','Y',TO_TIMESTAMP('2013-08-19 14:19:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',156,'N')
;

-- Aug 19, 2013 2:19:05 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210769 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210770,'N','N','N','N',60,'N',10,'N','N','Y','d244edd1-f156-40c3-a7d0-06689d8a54ac','Y','Address2','Address line 2 for this location','The Address 2 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','Address 2','Y',TO_TIMESTAMP('2013-08-19 14:19:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',157,'N')
;

-- Aug 19, 2013 2:19:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210770 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210771,'N','N','N',0,'N',60,'N',10,'N','N','Y','f5c469c8-1f60-4622-a043-8ebbfbf580c2','Y','Address3','Address Line 3 for the location','The Address 2 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','Address 3','Y',TO_TIMESTAMP('2013-08-19 14:19:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2555,'N')
;

-- Aug 19, 2013 2:19:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210771 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210772,'N','N','N',0,'N',60,'N',10,'N','N','Y','62ead9f5-1066-4e2a-8acf-d7d49ac27e7d','Y','Address4','Address Line 4 for the location','The Address 4 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','Address 4','Y',TO_TIMESTAMP('2013-08-19 14:19:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2556,'N')
;

-- Aug 19, 2013 2:19:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210772 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210773,'N','N','N',0,'N',22,'N',30,'N','N','Y','00c52fc1-618c-4a6c-91c6-6db5aa71bae2','Y','C_City_ID','City','City in a country','City','Y',TO_TIMESTAMP('2013-08-19 14:19:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1830,'N')
;

-- Aug 19, 2013 2:19:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210773 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210774,'Y','N','N','N',22,'N',19,'N','N','Y','613eabc2-b08f-4cb7-83fd-a808c382390d','Y','C_Country_ID','Country ','The Country defines a Country.  Each Country must be defined before it can be used in any document.','Country','Y',TO_TIMESTAMP('2013-08-19 14:19:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',192,'N')
;

-- Aug 19, 2013 2:19:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210774 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:11 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_AddressTransaction_ID',202593,'Address Transaction','Address Transaction','528275b9-b385-481b-b63b-a1ce56c59aed',TO_TIMESTAMP('2013-08-19 14:19:10','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 14:19:10','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 2:19:11 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202593 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 2:19:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210775,'Y','N','N','N',22,'N',13,'Y','N','Y','2b15a546-5e46-4cd2-a0fa-13e7323a7a00','N','C_AddressTransaction_ID','Address Transaction','N',TO_TIMESTAMP('2013-08-19 14:19:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202593,'N')
;

-- Aug 19, 2013 2:19:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210775 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_AddressTransaction_UU',202594,'C_AddressTransaction_UU','C_AddressTransaction_UU','31c1279e-22c7-4416-8a3b-f590708f95c0',TO_TIMESTAMP('2013-08-19 14:19:12','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 14:19:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 2:19:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202594 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 2:19:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1.00,200102,210776,'N','N','N','N',36,'N',10,'N','N','Y','368d57d7-adf3-4530-b1ab-2f667ed68f71','Y','C_AddressTransaction_UU','C_AddressTransaction_UU','N',TO_TIMESTAMP('2013-08-19 14:19:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202594,'N')
;

-- Aug 19, 2013 2:19:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210776 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:14 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210777,'N','N','N','N',22,'N',19,153,'N','N','Y','09216e07-ae23-4244-857e-d08b7a8641fa','Y','C_Region_ID','Identifies a geographical Region','The Region identifies a unique Region for this Country.','Region','Y',TO_TIMESTAMP('2013-08-19 14:19:13','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',209,'N')
;

-- Aug 19, 2013 2:19:14 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210777 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210778,'N','N','Y',1,'N',60,'N',10,'N','N','Y','3bfe7a08-6441-4a62-b466-0de957051ac2','Y','City','Identifies a City','The City identifies a unique City for this Country or Region.','City','Y',TO_TIMESTAMP('2013-08-19 14:19:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',225,'N')
;

-- Aug 19, 2013 2:19:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210778 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210779,'Y','N','N','N',7,'N',16,'N','N','Y','21c6c193-f3c1-4749-b46e-029bde1571ab','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-08-19 14:19:15','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 19, 2013 2:19:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210779 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210780,110,'Y','N','N','N',22,'N',18,'N','N','Y','f1c5b47f-611c-485b-adf4-dff995b395a4','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-08-19 14:19:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 19, 2013 2:19:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210780 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210781,'Y','N','N','N',1,'N',20,'N','N','Y','1c882737-b5c7-4e31-a5db-3b9703ff6be5','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-08-19 14:19:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 19, 2013 2:19:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210781 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210782,'N','N','N','N',10,'N',10,'N','N','Y','591572bc-0383-4727-a24c-4f35bda1991a','Y','Postal','Postal code','The Postal Code or ZIP identifies the postal code for this entity''s address.','ZIP','Y',TO_TIMESTAMP('2013-08-19 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',512,'N')
;

-- Aug 19, 2013 2:19:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210782 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210783,'N','N','N','N',10,'N',10,'N','N','Y','7754ef22-c2c5-47c0-ba4e-41d430a70ee5','Y','Postal_Add','Additional ZIP or Postal code','The Additional ZIP or Postal Code identifies, if appropriate, any additional Postal Code information.','Additional Zip','Y',TO_TIMESTAMP('2013-08-19 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',513,'N')
;

-- Aug 19, 2013 2:19:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210783 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',0,200102,210784,'N','N','N',0,'N',40,'Y',10,'N','N','Y','897dcb83-fe0e-439b-ad37-16650f8efdca','Y','RegionName','Name of the Region','The Region Name defines the name that will print when this region is used in a document.','Region','Y',TO_TIMESTAMP('2013-08-19 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',541,'N')
;

-- Aug 19, 2013 2:19:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210784 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210785,'Y','N','N','N',7,'N',16,'N','N','Y','b913fc91-2b54-4d8c-88b9-1d5e21710a86','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-08-19 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 19, 2013 2:19:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210785 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200102,210786,110,'Y','N','N','N',22,'N',18,'N','N','Y','d2442e56-9901-4bd8-9e35-6fa2580d0446','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-08-19 14:19:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:19:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 19, 2013 2:19:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210786 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:19:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210783
;

-- Aug 19, 2013 2:19:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210783
;

-- Aug 19, 2013 2:20:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210784
;

-- Aug 19, 2013 2:20:10 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210784
;

-- Aug 19, 2013 2:21:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200102,210814,'N','N','N',0,'N',60,'N',10,'N','N','Y','bcadd89a-e95f-4d88-ac63-5c2e5cb19ec7','N','Region','Region','Y',TO_TIMESTAMP('2013-08-19 14:21:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:21:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202243,'N')
;

-- Aug 19, 2013 2:21:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210814 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:21:52 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200102,210819,'N','N','N',0,'N',22,'N',21,'N','N','Y','d8d38009-85e3-4f1f-9d45-003720515d1d','Y','C_Location_ID','Location or Address','The Location / Address field defines the location of an entity.','Address','Y',TO_TIMESTAMP('2013-08-19 14:21:51','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:21:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202,'N')
;

-- Aug 19, 2013 2:21:52 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210819 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:22:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200102,210820,'Y','N','N',0,'N',1,'N',20,'N','N','Y','1dc3e6d9-4ddf-4fe0-9526-96083442190e','Y','Processed','The document has been processed','N','The Processed checkbox indicates that a document has been processed.','Processed','Y',TO_TIMESTAMP('2013-08-19 14:22:30','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:22:30','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1047,'N')
;

-- Aug 19, 2013 2:22:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210820 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:23:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200102,210821,'Y','N','N',0,'N',1,'N',20,'N','N','Y','41484f90-06c0-4aa0-b5ca-bff5442773c6','Y','IsValid','Element is valid','N','The element passed the validation check','Valid','Y',TO_TIMESTAMP('2013-08-19 14:23:01','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:23:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2002,'N')
;

-- Aug 19, 2013 2:23:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210821 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:23:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200102,210822,'N','N','N',0,'N',2000,'N',14,'N','N','Y','d48c97d3-b88f-4315-9c25-9516fa671b0d','N','Result','Result of the action taken','The Result indicates the result of any action taken on this request.','Result','Y',TO_TIMESTAMP('2013-08-19 14:23:42','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:23:42','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',546,'N')
;

-- Aug 19, 2013 2:23:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210822 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:24:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200102,210823,'Y','N','N',0,'N',22,'N',19,'N','N','Y','39cb8f7e-0d61-4357-84cf-781ebcf75a7d','N','C_AddressValidation_ID','Address Validation','Y',TO_TIMESTAMP('2013-08-19 14:24:07','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:24:07','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202591,'N')
;

-- Aug 19, 2013 2:24:08 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210823 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:24:30 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
CREATE TABLE C_AddressTransaction (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Address1 VARCHAR(60) DEFAULT NULL , Address2 VARCHAR(60) DEFAULT NULL , Address3 VARCHAR(60) DEFAULT NULL , Address4 VARCHAR(60) DEFAULT NULL , C_AddressTransaction_ID NUMERIC(10) NOT NULL, C_AddressTransaction_UU VARCHAR(36) DEFAULT NULL , C_AddressValidation_ID NUMERIC(10) NOT NULL, C_City_ID NUMERIC(10) DEFAULT NULL , C_Country_ID NUMERIC(10) NOT NULL, C_Location_ID NUMERIC(10) DEFAULT NULL , C_Region_ID NUMERIC(10) DEFAULT NULL , City VARCHAR(60) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsValid CHAR(1) DEFAULT 'N' CHECK (IsValid IN ('Y','N')) NOT NULL, Postal VARCHAR(10) DEFAULT NULL , Processed CHAR(1) DEFAULT 'N' CHECK (Processed IN ('Y','N')) NOT NULL, Region VARCHAR(60) DEFAULT NULL , Result VARCHAR(2000) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_AddressTransaction_Key PRIMARY KEY (C_AddressTransaction_ID), CONSTRAINT C_AddressTransaction_UU_idx UNIQUE (C_AddressTransaction_UU))
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT ADClient_CAddressTransaction FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT ADOrg_CAddressTransaction FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT CAddressValidation_CAddressTra FOREIGN KEY (C_AddressValidation_ID) REFERENCES c_addressvalidation(c_addressvalidation_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT CCity_CAddressTransaction FOREIGN KEY (C_City_ID) REFERENCES c_city(c_city_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT CCountry_CAddressTransaction FOREIGN KEY (C_Country_ID) REFERENCES c_country(c_country_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT CLocation_CAddressTransaction FOREIGN KEY (C_Location_ID) REFERENCES c_location(c_location_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT CRegion_CAddressTransaction FOREIGN KEY (C_Region_ID) REFERENCES c_region(c_region_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT CreatedBy_CAddressTransaction FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 19, 2013 2:24:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD CONSTRAINT UpdatedBy_CAddressTransaction FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 19, 2013 2:25:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Table SET AD_Window_ID=200047,Updated=TO_TIMESTAMP('2013-08-19 14:25:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200101
;

-- Aug 19, 2013 2:26:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Table SET AD_Window_ID=200046,Updated=TO_TIMESTAMP('2013-08-19 14:26:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200100
;

-- Aug 19, 2013 2:26:45 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID) VALUES ('N','T','Y','N','N',0,0,'D','Address Transaction',200048,'b1370b79-bf18-4ee5-9b2f-569e5f10a1ec',TO_TIMESTAMP('2013-08-19 14:26:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 14:26:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0)
;

-- Aug 19, 2013 2:26:45 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200048 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Aug 19, 2013 2:27:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','Y',200048,10,'N','N',200102,'N','N','Y','N','N',0,'99d6131c-09f2-4c56-833f-c29433651b6c','D','Address Transaction',200111,0,TO_TIMESTAMP('2013-08-19 14:27:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Aug 19, 2013 2:27:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200111 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 19, 2013 2:27:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210767,10,'Y',202447,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','dd15f7f1-255d-44da-8377-f4dae0f58695','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:20','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 2:27:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202447 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210768,20,'Y',202448,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','0b2bb022-e4cd-4dc1-8dcc-65e793438610','Y','N','Y',100,0,TO_TIMESTAMP('2013-08-19 14:27:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:20','YYYY-MM-DD HH24:MI:SS'),'Y',4,0,2)
;

-- Aug 19, 2013 2:27:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202448 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,60,'N','N',210769,30,'Y',202449,'N','The Address 1 identifies the address for an entity''s location','D','Address line 1 for this location','Address 1','f6e861ef-0e22-4b75-a771-e3bffc87540e','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:21','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 2:27:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202449 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,60,'N','N',210770,40,'Y',202450,'N','The Address 2 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','D','Address line 2 for this location','Address 2','35d03911-57fb-4f32-83aa-6b8cdb46f21b','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:22','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 2:27:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202450 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,60,'N','N',210771,50,'Y',202451,'N','The Address 2 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','D','Address Line 3 for the location','Address 3','c8625cb5-b37c-4080-acc4-a8aa21834e17','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:23','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 2:27:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202451 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,60,'N','N',210772,60,'Y',202452,'N','The Address 4 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','D','Address Line 4 for the location','Address 4','922023cd-5f58-4fc8-8ee2-1109a945787f','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:23','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 2:27:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202452 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:25 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210773,70,'Y',202453,'N','City in a country','D','City','City','c822c75f-848d-4d52-a667-9bd7064e6d2c','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:24','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 2:27:25 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202453 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:26 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210774,80,'Y',202454,'N','The Country defines a Country.  Each Country must be defined before it can be used in any document.','D','Country ','Country','6f2d4eb4-7217-4e1f-836a-c1d90ce66706','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:25','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 2:27:26 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202454 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:26 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210775,90,'Y',202455,'N','D','Address Transaction','5ba1722b-6665-451b-8ce5-ba2cf1260022','N','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:26','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 2:27:26 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202455 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:27 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200111,36,'N','N',210776,100,'Y',202456,'N','D','C_AddressTransaction_UU','e515f485-a158-4fda-b850-857f8e48f27d','N','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:26','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 2:27:27 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202456 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210777,110,'Y',202457,'N','The Region identifies a unique Region for this Country.','D','Identifies a geographical Region','Region','186114b7-d746-4639-bb9d-ad493af09577','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:27','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 2:27:28 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202457 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,60,'N','N',210778,120,'Y',202458,'N','The City identifies a unique City for this Country or Region.','D','Identifies a City','City','1fba25b2-cf76-41a0-bb22-02286ca69b88','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:28','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 2:27:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202458 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,10,'N','N',210782,130,'Y',202459,'N','The Postal Code or ZIP identifies the postal code for this entity''s address.','D','Postal code','ZIP','6c249b41-8111-422f-beb9-50402a70cf46','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:29','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 2:27:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202459 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:30 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,60,'N','N',210814,140,'Y',202460,'N','D','Region','a3dacba2-b8ed-49a6-99b4-4cfd5e89c5e8','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:29','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 2:27:30 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202460 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210819,150,'Y',202461,'N','The Location / Address field defines the location of an entity.','D','Location or Address','Address','6f9846e9-e837-42de-860b-43159d8b095a','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:30','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 2:27:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202461 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:32 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200111,1,'N','N',210820,160,'Y',202462,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','7b56578c-68ed-4d52-bf42-e779bccf9868','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:31','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 19, 2013 2:27:32 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202462 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:32 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200111,1,'N','N',210821,170,'Y',202463,'N','The element passed the validation check','D','Element is valid','Valid','c4a3bba4-7571-4388-bf1e-d6296655c5fa','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:32','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 19, 2013 2:27:32 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202463 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:33 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200111,2000,'N','N',210822,180,'Y',202464,'N','The Result indicates the result of any action taken on this request.','D','Result of the action taken','Result','dfacf861-676e-46f4-a8db-0c26fb2e02c2','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:32','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3)
;

-- Aug 19, 2013 2:27:33 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202464 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:34 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,22,'N','N',210823,190,'Y',202465,'N','D','Address Validation','52ad08c3-298e-485d-8c33-5e577be9c8ce','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:33','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 2:27:34 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202465 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:27:34 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200111,1,'N','N',210781,200,'Y',202466,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','39ad4f6f-3ea6-49d6-8b39-8b4605f08602','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:27:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:27:34','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 19, 2013 2:27:34 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202466 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:29:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202466
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202455
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202456
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202461
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202449
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202450
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202451
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202452
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202453
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202458
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202457
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202460
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202459
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202454
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=202464
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=202463
;

-- Aug 19, 2013 2:29:22 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=202462
;

-- Aug 19, 2013 2:30:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=202453
;

-- Aug 19, 2013 2:30:20 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Field WHERE AD_Field_ID=202453
;

-- Aug 19, 2013 2:30:25 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=202457
;

-- Aug 19, 2013 2:30:25 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Field WHERE AD_Field_ID=202457
;

-- Aug 19, 2013 2:30:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=202454
;

-- Aug 19, 2013 2:30:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Field WHERE AD_Field_ID=202454
;

-- Aug 19, 2013 2:31:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202458
;

-- Aug 19, 2013 2:31:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202460
;

-- Aug 19, 2013 2:31:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202459
;

-- Aug 19, 2013 2:31:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 2:31:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202464
;

-- Aug 19, 2013 2:31:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202463
;

-- Aug 19, 2013 2:31:02 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=202462
;

-- Aug 19, 2013 2:32:00 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210773
;

-- Aug 19, 2013 2:32:00 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210773
;

-- Aug 19, 2013 2:32:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210774
;

-- Aug 19, 2013 2:32:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210774
;

-- Aug 19, 2013 2:32:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210777
;

-- Aug 19, 2013 2:32:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210777
;

-- Aug 19, 2013 2:32:44 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200102,210824,'N','N','N',0,'N',60,'N',10,'N','N','Y','d573d520-92a6-42d7-8c97-1cee87615181','N','Country','Country','Y',TO_TIMESTAMP('2013-08-19 14:32:43','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 14:32:43','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202245,'N')
;

-- Aug 19, 2013 2:32:44 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210824 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 2:32:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressTransaction ADD COLUMN Country VARCHAR(60) DEFAULT NULL 
;

-- Aug 19, 2013 2:32:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200111,60,'N','N',210824,150,'Y',202468,'N','D','Country','105aa698-be59-4a20-b5c2-7138f3e9058c','Y','N',100,0,TO_TIMESTAMP('2013-08-19 14:32:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 14:32:57','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 2:32:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202468 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 2:33:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202468
;

-- Aug 19, 2013 2:33:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 2:33:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202464
;

-- Aug 19, 2013 2:33:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=202463
;

-- Aug 19, 2013 2:33:13 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=202462
;

-- Aug 19, 2013 2:33:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=202466
;

-- Aug 19, 2013 2:33:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202447
;

-- Aug 19, 2013 2:33:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202448
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202461
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202449
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202450
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202451
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202452
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202458
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202460
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202459
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202468
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=202464
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=202463
;

-- Aug 19, 2013 2:33:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=202462
;

-- Aug 19, 2013 2:34:25 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 14:34:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202448
;

-- Aug 19, 2013 2:34:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=5,Updated=TO_TIMESTAMP('2013-08-19 14:34:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202462
;

-- Aug 19, 2013 2:36:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:36:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202460
;

-- Aug 19, 2013 2:36:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-08-19 14:36:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202459
;

-- Aug 19, 2013 2:36:34 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:36:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202460
;

-- Aug 19, 2013 2:36:46 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:36:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202468
;

-- Aug 19, 2013 2:36:50 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:36:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202449
;

-- Aug 19, 2013 2:36:51 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:36:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202450
;

-- Aug 19, 2013 2:36:51 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:36:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202451
;

-- Aug 19, 2013 2:36:52 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202452
;

-- Aug 19, 2013 2:36:54 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 14:36:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202458
;

-- Aug 19, 2013 2:36:55 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:36:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202449
;

-- Aug 19, 2013 2:36:56 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202450
;

-- Aug 19, 2013 2:36:57 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:36:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202451
;

-- Aug 19, 2013 2:36:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:36:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202452
;

-- Aug 19, 2013 2:37:35 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 14:37:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202458
;

-- Aug 19, 2013 2:38:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Table SET AD_Window_ID=200048,Updated=TO_TIMESTAMP('2013-08-19 14:38:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200102
;

ALTER TABLE C_AddressTransaction DROP COLUMN C_City_ID;
ALTER TABLE C_AddressTransaction DROP COLUMN C_Region_ID;
ALTER TABLE C_AddressTransaction DROP COLUMN C_Country_ID;
-- Aug 19, 2013 2:43:36 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,"action",IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200048,200071,'N','Y','N','D','Y','Address Transaction','9a34e6d7-303c-49fc-9d8b-fd7e43a72751','W','Y',100,TO_TIMESTAMP('2013-08-19 14:43:35','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-08-19 14:43:35','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 19, 2013 2:43:36 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200071 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Aug 19, 2013 2:43:36 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200071, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200071)
;

-- Aug 19, 2013 2:43:53 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=114
;

-- Aug 19, 2013 2:43:53 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=108
;

-- Aug 19, 2013 2:43:53 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200071
;

-- Aug 19, 2013 2:43:53 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=115
;

-- Aug 19, 2013 2:43:53 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53225
;

-- Aug 19, 2013 2:43:53 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=159, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53226
;

-- Aug 19, 2013 4:34:35 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210825,'N','N','N',0,'N',40,'N',10,'N','N','Y','3101436b-c33b-4477-8e15-f14559a07c23','Y','ShipperAccount','Shipper Account Number','Y',TO_TIMESTAMP('2013-08-19 16:34:34','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 16:34:34','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200309,'N')
;

-- Aug 19, 2013 4:34:35 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210825 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 4:34:39 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD COLUMN ShipperAccount VARCHAR(40) DEFAULT NULL 
;

-- Aug 19, 2013 4:34:52 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210826,'N','N','N',0,'N',255,'N',10,'N','N','Y','b2fea795-7e1f-4663-a31c-93ec14b16c33','Y','ShipperMeter','Shipper Meter','Y',TO_TIMESTAMP('2013-08-19 16:34:51','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 16:34:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',200310,'N')
;

-- Aug 19, 2013 4:34:52 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210826 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 4:34:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD COLUMN ShipperMeter VARCHAR(255) DEFAULT NULL 
;

-- Aug 19, 2013 4:35:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,40,'N','N',210825,90,'Y',202470,'N','D','Shipper Account Number','f2215d5d-8c19-46d4-b713-be90d8d727de','Y','N',100,0,TO_TIMESTAMP('2013-08-19 16:35:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:35:20','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 4:35:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202470 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 4:35:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,255,'N','N',210826,100,'Y',202471,'N','D','Shipper Meter','a0ae8d66-868f-47cf-9968-aeae7a0ad03e','Y','N',100,0,TO_TIMESTAMP('2013-08-19 16:35:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:35:21','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 19, 2013 4:35:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202471 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 4:35:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET Name='Account Number',Updated=TO_TIMESTAMP('2013-08-19 16:35:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202470
;

-- Aug 19, 2013 4:35:44 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET Name='Meter Number',Updated=TO_TIMESTAMP('2013-08-19 16:35:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202471
;

-- Aug 19, 2013 4:35:56 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field_Trl SET Name='Account Number',Updated=TO_TIMESTAMP('2013-08-19 16:35:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202470 AND AD_Language='es_CO'
;

-- Aug 19, 2013 4:36:12 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=90,Updated=TO_TIMESTAMP('2013-08-19 16:36:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202470
;

-- Aug 19, 2013 4:36:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22, IsSameLine='Y', SeqNoGrid=100, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-08-19 16:36:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202471
;

-- Aug 19, 2013 4:36:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 16:36:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202470
;

-- Aug 19, 2013 4:36:41 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 16:36:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202423
;

-- Aug 19, 2013 4:36:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-08-19 16:36:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202422
;

-- Aug 19, 2013 4:36:47 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2013-08-19 16:36:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202423
;

-- Aug 19, 2013 4:36:55 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2013-08-19 16:36:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202422
;

-- Aug 19, 2013 4:46:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('ValidateAddress',202599,'Validate Address','Validate Address','87439a40-1d25-468f-a026-2101cd854552',TO_TIMESTAMP('2013-08-19 16:46:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-19 16:46:16','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 19, 2013 4:46:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202599 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 19, 2013 4:47:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value,AD_Client_ID) VALUES ('N',200061,'N','N','229ecec4-5f94-4df1-9670-b8b8a64c257f','7','N','N',0,0,'Y','D','Validate Address',0,TO_TIMESTAMP('2013-08-19 16:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:47:57','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.adempiere.process.ValidateAddressProcess','ValidateAddressProcess',0)
;

-- Aug 19, 2013 4:47:58 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200061 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Aug 19, 2013 4:48:06 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Process SET AccessLevel='3',Updated=TO_TIMESTAMP('2013-08-19 16:48:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200061
;

-- Aug 19, 2013 4:50:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,IsEncrypted,AD_Client_ID) VALUES ('N',202591,200072,'224a0411-6678-41e0-801a-73229472e715',200061,19,'Y','D','Address Validation','C_AddressValidation_ID',0,'Y',10,'@C_AddressValidation_ID@','Y',100,TO_TIMESTAMP('2013-08-19 16:50:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:50:36','YYYY-MM-DD HH24:MI:SS'),0,'N',0)
;

-- Aug 19, 2013 4:50:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200072 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Aug 19, 2013 4:50:54 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,162,210827,'N','N','N',0,'N',1,'N',28,'N',200061,'N','Y','478d8cab-296b-41b3-acee-9dcf59f586f9','Y','ValidateAddress','Validate Address','Y',TO_TIMESTAMP('2013-08-19 16:50:53','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 16:50:53','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',0,'D','N',202599,'N')
;

-- Aug 19, 2013 4:50:54 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210827 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 4:51:01 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_Location ADD COLUMN ValidateAddress CHAR(1) DEFAULT NULL 
;

-- Aug 19, 2013 4:52:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,162,210828,'N','N','N',0,'N',2000,'N',14,'N','N','Y','2d358ee6-f317-49db-bfd9-48ed42d382ab','N','Result','Result of the action taken','The Result indicates the result of any action taken on this request.','Result','Y',TO_TIMESTAMP('2013-08-19 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 16:52:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',546,'N')
;

-- Aug 19, 2013 4:52:24 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210828 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 4:52:27 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_Location ADD COLUMN Result VARCHAR(2000) DEFAULT NULL 
;

-- Aug 19, 2013 4:52:54 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,162,210829,'N','N','N',0,'N',1,'N',20,'N','N','Y','de4dead6-07ed-4c13-846d-b8cb10f2900c','Y','IsValid','Element is valid','N','The element passed the validation check','Valid','Y',TO_TIMESTAMP('2013-08-19 16:52:53','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 16:52:53','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2002,'N')
;

-- Aug 19, 2013 4:52:54 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210829 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 4:52:56 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_Location ADD COLUMN IsValid CHAR(1) DEFAULT 'N' CHECK (IsValid IN ('Y','N'))
;

-- Aug 19, 2013 4:53:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',154,36,'N','N',60675,150,'Y',202472,'N','D','C_Location_UU','27e78c12-93e6-490e-ae27-0d7ef368356b','N','N',100,0,TO_TIMESTAMP('2013-08-19 16:53:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:53:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 19, 2013 4:53:15 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202472 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 4:53:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',154,1,'N','N',210827,160,'Y',202473,'N','D','Validate Address','06616ed8-695b-4abf-a0f3-afd23146474f','Y','N',100,0,TO_TIMESTAMP('2013-08-19 16:53:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:53:15','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 19, 2013 4:53:16 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202473 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 4:53:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',154,2000,'N','N',210828,170,'Y',202474,'N','The Result indicates the result of any action taken on this request.','D','Result of the action taken','Result','d18983d0-7484-4270-977a-85cfb5f414b1','Y','N',100,0,TO_TIMESTAMP('2013-08-19 16:53:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:53:16','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3)
;

-- Aug 19, 2013 4:53:17 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202474 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 4:53:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',154,1,'N','N',210829,180,'Y',202475,'N','The element passed the validation check','D','Element is valid','Valid','a0649bbf-e1bf-4f67-a1dd-e32590fba5bc','Y','N',100,0,TO_TIMESTAMP('2013-08-19 16:53:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 16:53:17','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 19, 2013 4:53:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202475 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 4:53:38 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202472
;

-- Aug 19, 2013 4:53:38 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=202473
;

-- Aug 19, 2013 4:53:38 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=202475
;

-- Aug 19, 2013 4:53:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=202473
;

-- Aug 19, 2013 4:53:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=202475
;

-- Aug 19, 2013 4:53:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=202474
;

-- Aug 19, 2013 5:04:52 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,162,210830,'N','N','N',0,'N',22,'N',19,'N','N','Y','fcda0526-9e7d-4af0-8c6b-a1c2977d02df','N','C_AddressValidation_ID','Address Validation','Y',TO_TIMESTAMP('2013-08-19 17:04:52','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-19 17:04:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202591,'N')
;

-- Aug 19, 2013 5:04:52 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210830 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 19, 2013 5:04:55 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_Location ADD COLUMN C_AddressValidation_ID NUMERIC(10) DEFAULT NULL 
;

-- Aug 19, 2013 5:04:56 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_Location ADD CONSTRAINT CAddressValidation_CLocation FOREIGN KEY (C_AddressValidation_ID) REFERENCES c_addressvalidation(c_addressvalidation_id)
;

-- Aug 19, 2013 5:05:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',154,22,'N','N',210830,180,'Y',202476,'N','D','Address Validation','11d3453c-86f6-4118-a6a5-565acf72c55e','Y','N',100,0,TO_TIMESTAMP('2013-08-19 17:05:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-19 17:05:08','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 19, 2013 5:05:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202476 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 19, 2013 5:05:39 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=202476
;

-- Aug 19, 2013 5:05:39 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=202475
;

-- Aug 19, 2013 5:05:39 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=202474
;

-- Aug 19, 2013 5:05:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=202476
;

-- Aug 19, 2013 5:05:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=202475
;

-- Aug 19, 2013 5:05:42 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=202474
;

-- Aug 19, 2013 5:06:23 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2013-08-19 17:06:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210829
;

-- Aug 19, 2013 5:13:37 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-08-19 17:13:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202408
;

-- Aug 19, 2013 5:16:38 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=202476
;

-- Aug 19, 2013 5:16:38 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=202474
;

-- Aug 19, 2013 5:16:38 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=202473
;

-- Aug 19, 2013 5:16:45 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=202474
;

-- Aug 19, 2013 5:16:45 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=202476
;

-- Aug 19, 2013 5:16:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=202473
;

-- Aug 19, 2013 5:16:59 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=202476
;

-- Aug 19, 2013 5:17:19 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-08-19 17:17:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202476
;

-- Aug 19, 2013 5:19:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202464
;

-- Aug 19, 2013 5:19:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202463
;

-- Aug 19, 2013 5:19:18 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 5:19:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=202464
;

-- Aug 19, 2013 5:19:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=202463
;

-- Aug 19, 2013 5:19:21 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 5:19:29 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-08-19 17:19:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 5:19:31 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-08-19 17:19:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202462
;

-- Aug 19, 2013 5:19:36 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2013-08-19 17:19:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202465
;

-- Aug 19, 2013 5:19:40 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2013-08-19 17:19:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202462
;

-- Aug 19, 2013 5:20:43 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2013-08-19 17:20:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200100
;

-- Aug 19, 2013 5:35:04 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Column SET FieldLength=100,Updated=TO_TIMESTAMP('2013-08-19 17:35:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210752
;

-- Aug 19, 2013 5:35:07 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO t_alter_column values('c_addressvalidationcfg','AddressValidationClass','VARCHAR(100)',null,'NULL')
;

-- Aug 20, 2013 11:44:19 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200101,210831,'Y','N','N',0,'N',22,'N',11,'N','N','Y','b8393e5c-73df-41fd-b6b1-2de446d63df9','Y','SeqNo','Method of ordering records; lowest number comes first','The Sequence indicates the order of records','Sequence','Y',TO_TIMESTAMP('2013-08-20 11:44:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-08-20 11:44:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',566,'N')
;

-- Aug 20, 2013 11:44:19 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210831 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 20, 2013 11:44:28 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
ALTER TABLE C_AddressValidation ADD COLUMN SeqNo NUMERIC(10) NOT NULL
;

-- Aug 20, 2013 11:45:19 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200108,22,'N','N',210831,110,'Y',202477,'N','The Sequence indicates the order of records','D','Method of ordering records; lowest number comes first','Sequence','278a6eaa-b9bb-4ee5-84ac-fac55ee22a8b','Y','N',100,0,TO_TIMESTAMP('2013-08-20 11:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-08-20 11:45:18','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 20, 2013 11:45:19 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202477 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 20, 2013 11:46:02 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202477
;

-- Aug 20, 2013 11:46:02 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202427
;

-- Aug 20, 2013 11:46:02 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202422
;

-- Aug 20, 2013 11:46:02 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202423
;

-- Aug 20, 2013 11:46:02 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202470
;

-- Aug 20, 2013 11:46:02 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202471
;

-- Aug 20, 2013 11:46:06 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202477
;

-- Aug 20, 2013 11:46:06 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202427
;

-- Aug 20, 2013 11:46:06 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202422
;

-- Aug 20, 2013 11:46:06 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202423
;

-- Aug 20, 2013 11:46:06 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202470
;

-- Aug 20, 2013 11:46:06 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202471
;

-- Aug 20, 2013 11:46:30 AM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-08-20 11:46:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202477
;

-- Aug 22, 2013 6:42:26 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200033,'C','N','Enable address validation','1177c897-f05f-422e-9799-a1bf3394bc63',TO_TIMESTAMP('2013-08-22 18:42:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-08-22 18:42:25','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'ADDRESS_VALIDATION',0,'D')
;

-- Aug 27, 2013 12:41:09 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','No address validation',200222,'D','010e9f21-5eed-4ca5-9db6-f3a9ca844f07','AddressNoValidation','Y',TO_TIMESTAMP('2013-08-27 12:41:09','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-08-27 12:41:09','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Aug 27, 2013 12:41:35 PM SGT
-- IDEMPIERE-1286 Improve address validation configuration to support external services
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','Address not processed',200223,'D','29ff8957-3f99-4589-b526-af78bc473861','AddressNotProcessed','Y',TO_TIMESTAMP('2013-08-27 12:41:34','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-08-27 12:41:34','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201308271245_IDEMPIERE-1286.sql') FROM dual
;