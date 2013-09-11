SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 14, 2013 12:01:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing) VALUES ('N','N','N','4',0,200098,'N','N','N','D','L','b0b557e6-2f49-4925-8e75-3fbaad903e25','Y','Y','C_TaxProviderCfg','Tax Provider Configuration','Y',0,100,TO_DATE('2013-08-14 12:01:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:01:42','YYYY-MM-DD HH24:MI:SS'),0,'N')
;

-- Aug 14, 2013 12:01:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200098 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 14, 2013 12:01:45 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200135,'Table C_TaxProviderCfg','C_TaxProviderCfg',1,'c8ca2ec7-5fed-4d7d-a57c-2fba7e66ec55',0,TO_DATE('2013-08-14 12:01:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:01:44','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 14, 2013 12:02:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210691,'Y','N','N','N',22,'N',19,129,'N','N','Y','4768edef-4d8c-45de-8b7f-9a79be749771','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2013-08-14 12:02:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 14, 2013 12:02:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210691 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:23 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_TaxProviderCfg_ID',202579,'Tax Provider Configuration','Tax Provider Configuration','986ef918-5f25-4a3b-98ff-b88be437dfa0',TO_DATE('2013-08-14 12:02:22','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 12:02:22','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 14, 2013 12:02:23 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202579 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2013 12:02:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210692,'Y','N','N',0,'N',22,'N',13,'Y','N','Y','97928a53-f1b8-4dc5-b462-758503b88a68','N','C_TaxProviderCfg_ID','Tax Provider Configuration','N',TO_DATE('2013-08-14 12:02:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202579,'N')
;

-- Aug 14, 2013 12:02:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210692 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_TaxProviderCfg_UU',202580,'C_TaxProviderCfg_UU','C_TaxProviderCfg_UU','633093d9-d9fb-422e-ba06-9470612b2aab',TO_DATE('2013-08-14 12:02:24','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 12:02:24','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 14, 2013 12:02:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202580 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2013 12:02:26 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1.00,200098,210693,'N','N','N','N',36,'N',10,'N','N','Y','b85cd33b-6256-415d-afb4-1caf6f167e86','Y','C_TaxProviderCfg_UU','C_TaxProviderCfg_UU','N',TO_DATE('2013-08-14 12:02:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202580,'N')
;

-- Aug 14, 2013 12:02:26 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210693 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:27 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210694,'Y','N','N','N',22,'N',19,104,'N','N','Y','3dd3a5e0-9880-45b8-991d-a087ee033a38','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2013-08-14 12:02:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 14, 2013 12:02:27 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210694 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:28 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210695,'Y','N','N','N',7,'N',16,'N','N','Y','c4fa831f-a75e-4b6f-970d-42fb139a2f86','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2013-08-14 12:02:27','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 14, 2013 12:02:28 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210695 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210696,110,'Y','N','N','N',22,'N',18,'N','N','Y','238c34e0-4439-4a01-88a8-db8377703cc3','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2013-08-14 12:02:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 14, 2013 12:02:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210696 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200098,210697,200064,'N','N','N',0,'N',1,'N',17,'N','N','Y','cd2d8bc3-b93c-4722-910d-619d69d12b12','Y','CtxType','Type of Context Help','The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as','Context Type','Y',TO_DATE('2013-08-14 12:02:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202214,'N')
;

-- Aug 14, 2013 12:02:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210697 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200098,210698,'N','N','N',0,'N',255,'N',14,'N','N','Y','112470b5-a000-4bf4-acb1-84817dcf662e','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_DATE('2013-08-14 12:02:30','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:30','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275,'N')
;

-- Aug 14, 2013 12:02:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210698 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210699,'Y','N','N','N',1,'N',20,'N','N','Y','d4a72732-8617-4913-810b-23334042cbbe','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2013-08-14 12:02:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 14, 2013 12:02:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210699 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200098,210700,'Y','N','Y',0,'N',120,'N',10,'N','N','Y','c28d0a04-c4bc-4e5b-8773-40a3779e64e4','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2013-08-14 12:02:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469,'N')
;

-- Aug 14, 2013 12:02:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210700 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:33 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210701,'Y','N','N','N',7,'N',16,'N','N','Y','be288981-a86a-4374-bb28-28a0825d5d80','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2013-08-14 12:02:32','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 14, 2013 12:02:33 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210701 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200098,210702,110,'Y','N','N','N',22,'N',18,'N','N','Y','108d76f1-da5f-4ca2-9b41-3e56ded6a582','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2013-08-14 12:02:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:02:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 14, 2013 12:02:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210702 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:02:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=210697
;

-- Aug 14, 2013 12:02:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210697
;

-- Aug 14, 2013 12:03:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('TaxProviderClass',202581,'Tax Provider Class','Tax Provider Class','421dad35-44ce-4b79-8ed3-6708f1261754',TO_DATE('2013-08-14 12:03:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 12:03:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 14, 2013 12:03:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202581 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2013 12:03:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200098,210703,'N','N','N',0,'N',60,'N',10,'N','N','Y','77be1109-54e8-4b19-be00-1c7a2845e820','Y','TaxProviderClass','Tax Provider Class','Y',TO_DATE('2013-08-14 12:03:58','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 12:03:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202581,'N')
;

-- Aug 14, 2013 12:03:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210703 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 12:04:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
CREATE TABLE C_TaxProviderCfg (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_TaxProviderCfg_ID NUMBER(10) NOT NULL, C_TaxProviderCfg_UU NVARCHAR2(36) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description NVARCHAR2(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name NVARCHAR2(120) NOT NULL, TaxProviderClass NVARCHAR2(60) DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT C_TaxProviderCfg_Key PRIMARY KEY (C_TaxProviderCfg_ID), CONSTRAINT C_TaxProviderCfg_UU_idx UNIQUE (C_TaxProviderCfg_UU))
;

-- Aug 14, 2013 12:04:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProviderCfg ADD CONSTRAINT ADClient_ADTaxProvider FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id)
;

-- Aug 14, 2013 12:04:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProviderCfg ADD CONSTRAINT ADOrg_ADTaxProvider FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id)
;

-- Aug 14, 2013 12:04:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProviderCfg ADD CONSTRAINT CreatedBy_ADTaxProvider FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 14, 2013 12:04:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProviderCfg ADD CONSTRAINT UpdatedBy_ADTaxProvider FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 14, 2013 12:04:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID) VALUES ('N','M','Y','N','N',0,0,'D','Tax Provider Configuration',200044,'6ea06f7d-be54-41f9-b0eb-494cd4676ecc',TO_DATE('2013-08-14 12:04:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 12:04:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0)
;

-- Aug 14, 2013 12:04:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200044 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Aug 14, 2013 12:05:21 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','N',200044,10,'N','N',200098,'N','N','N','Y','N',0,'df2892cf-66eb-465e-91d8-c146c8a45ce5','D','Tax Provider Configuration',200105,0,TO_DATE('2013-08-14 12:05:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Aug 14, 2013 12:05:21 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200105 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 14, 2013 12:05:28 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200105,22,'N','N',210691,10,'Y',202369,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','4e1097ac-517e-4fe2-b333-0925a8407639','Y','N',100,0,TO_DATE('2013-08-14 12:05:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:28','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 14, 2013 12:05:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202369 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200105,22,'N','N',210694,20,'Y',202370,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','d9d37c4d-a26a-4d82-a34e-a554b20be01d','Y','N','Y',100,0,TO_DATE('2013-08-14 12:05:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:29','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,0,2)
;

-- Aug 14, 2013 12:05:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202370 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200105,120,'N','N',210700,30,'Y',202371,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','28449996-628b-4b60-b48f-dcecf0812752','Y','N',100,0,TO_DATE('2013-08-14 12:05:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:30','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 14, 2013 12:05:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202371 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines) VALUES ('N',200105,255,'N','N',210698,40,'Y',202372,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','9ec3439a-f3b8-4800-ba3a-d44dff67e46c','Y','N',100,0,TO_DATE('2013-08-14 12:05:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:30','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3)
;

-- Aug 14, 2013 12:05:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202372 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200105,22,'N','N',210692,50,'Y',202373,'N','D','Tax Provider Configuration','54e4368c-7aec-458d-907f-7bbf97a97965','N','N',100,0,TO_DATE('2013-08-14 12:05:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:31','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 14, 2013 12:05:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202373 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200105,36,'N','N',210693,60,'Y',202374,'N','D','C_TaxProviderCfg_UU','3ab945f7-f986-4837-bdef-6f42dc6e1019','N','N',100,0,TO_DATE('2013-08-14 12:05:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:32','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 14, 2013 12:05:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202374 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:33 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200105,60,'N','N',210703,70,'Y',202375,'N','D','Tax Provider Class','c176c9f6-d57d-4eb3-89d2-7ed042f01131','Y','N',100,0,TO_DATE('2013-08-14 12:05:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:32','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 14, 2013 12:05:33 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202375 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200105,1,'N','N',210699,80,'Y',202376,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','6e04e370-5935-4ec3-a10a-b9ea828369c6','Y','N',100,0,TO_DATE('2013-08-14 12:05:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 12:05:33','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 14, 2013 12:05:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202376 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 12:05:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202371
;

-- Aug 14, 2013 12:05:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202372
;

-- Aug 14, 2013 12:05:54 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202376
;

-- Aug 14, 2013 12:05:54 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202375
;

-- Aug 14, 2013 12:05:58 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202374
;

-- Aug 14, 2013 12:05:58 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202373
;

-- Aug 14, 2013 12:05:58 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202376
;

-- Aug 14, 2013 12:05:58 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202375
;

-- Aug 14, 2013 12:06:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-08-14 12:06:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202370
;

-- Aug 14, 2013 12:07:00 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Table SET AD_Window_ID=200044,Updated=TO_DATE('2013-08-14 12:07:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200098
;

-- Aug 14, 2013 12:07:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,Action,IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200044,200067,'N','N','N','D','Y','Tax Provider Configuration','8680672e-e432-40b0-8c13-8a8767a0361f','W','Y',100,TO_DATE('2013-08-14 12:07:38','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-08-14 12:07:38','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2013 12:07:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Aug 14, 2013 12:07:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200067, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200067)
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200067
;

-- Aug 14, 2013 12:08:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200067
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200067
;

-- Aug 14, 2013 12:08:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Aug 14, 2013 2:23:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200098,210704,'N','N','N',0,'N',120,'N',40,'N','N','Y','108a746c-627f-440d-a049-2b7e3eb3da18','N','URL','Full URL address - e.g. http://www.idempiere.org','The URL defines an fully qualified web address like http://www.idempiere.org','URL','Y',TO_DATE('2013-08-14 14:23:45','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:23:45','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',983,'N')
;

-- Aug 14, 2013 2:23:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210704 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:23:49 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProviderCfg ADD URL NVARCHAR2(120) DEFAULT NULL 
;

-- Aug 14, 2013 2:24:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200098,210705,'N','N','N',0,'N',22,'N',19,'N','N','Y','9e1e3e57-3816-453b-a7b7-e6c99c71e8f4','N','C_Country_ID','Country ','The Country defines a Country.  Each Country must be defined before it can be used in any document.','Country','Y',TO_DATE('2013-08-14 14:24:58','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:24:58','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',192,'N')
;

-- Aug 14, 2013 2:24:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210705 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:25:02 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProviderCfg ADD C_Country_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 14, 2013 2:25:02 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProviderCfg ADD CONSTRAINT CCountry_ADTaxProviderCfg FOREIGN KEY (C_Country_ID) REFERENCES c_country(c_country_id)
;

-- Aug 14, 2013 2:26:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200105,120,'N','N',210704,70,'Y',202377,'N','The URL defines an fully qualified web address like http://www.idempiere.org','D','Full URL address - e.g. http://www.idempiere.org','URL','8a02a243-a977-49dc-924e-12f655ac895e','Y','N',100,0,TO_DATE('2013-08-14 14:26:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:26:06','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 14, 2013 2:26:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202377 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:26:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200105,22,'N','N',210705,80,'Y',202378,'N','The Country defines a Country.  Each Country must be defined before it can be used in any document.','D','Country ','Country','92dd972f-7fb8-422b-8ef3-a14f12f30849','Y','N',100,0,TO_DATE('2013-08-14 14:26:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:26:07','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 14, 2013 2:26:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202378 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:26:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202377
;

-- Aug 14, 2013 2:26:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202378
;

-- Aug 14, 2013 2:26:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202375
;

-- Aug 14, 2013 2:26:42 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202377
;

-- Aug 14, 2013 2:26:42 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202378
;

-- Aug 14, 2013 2:26:42 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202375
;

-- Aug 14, 2013 2:28:02 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2013-08-14 14:28:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202378
;

-- Aug 14, 2013 2:28:09 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET DisplayLength=22, ColumnSpan=2,Updated=TO_DATE('2013-08-14 14:28:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202377
;

-- Aug 14, 2013 2:28:11 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-08-14 14:28:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202378
;

-- Aug 14, 2013 2:44:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID,Processing) VALUES ('N','N','N','3',0,200099,'N','N','N','D','L','42b9556a-c230-42ae-9aea-d0c3ebaef591','Y','Y','C_TaxProvider','Tax Provider','Y',0,100,TO_DATE('2013-08-14 14:44:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:44:30','YYYY-MM-DD HH24:MI:SS'),0,'N')
;

-- Aug 14, 2013 2:44:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200099 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 14, 2013 2:44:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,StartNo,AD_Client_ID) VALUES ('N',200000,'Y',1000000,'N','Y',200136,'Table C_TaxProvider','C_TaxProvider',1,'61883219-5ee7-4366-bff7-c31b36902a35',0,TO_DATE('2013-08-14 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:44:31','YYYY-MM-DD HH24:MI:SS'),100,'Y',1000000,0)
;

-- Aug 14, 2013 2:45:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210706,'Y','N','N','N',22,'N',19,129,'N','N','Y','e99759d7-4f25-4018-ae37-115fe0338cb3','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_DATE('2013-08-14 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102,'N')
;

-- Aug 14, 2013 2:45:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210706 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_TaxProvider_ID',202582,'Tax Provider','Tax Provider','f96ee65a-3084-48e6-b379-336e0e2d70b3',TO_DATE('2013-08-14 14:45:12','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 14:45:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 14, 2013 2:45:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202582 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2013 2:45:14 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210707,'Y','N','N',0,'N',22,'N',13,'Y','N','Y','d18d31ce-a2ba-4443-bc9d-7d57ba60dd3b','N','C_TaxProvider_ID','Tax Provider','N',TO_DATE('2013-08-14 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202582,'N')
;

-- Aug 14, 2013 2:45:14 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210707 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:15 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('C_TaxProvider_UU',202583,'C_TaxProvider_UU','C_TaxProvider_UU','b09915cd-aa63-4fad-ab21-7862f64aaacd',TO_DATE('2013-08-14 14:45:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 14:45:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 14, 2013 2:45:15 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202583 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2013 2:45:16 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1.00,200099,210708,'N','N','N','N',36,'N',10,'N','N','Y','bdb70917-4d39-4bf2-bb88-b4fb9098a56f','Y','C_TaxProvider_UU','C_TaxProvider_UU','N',TO_DATE('2013-08-14 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202583,'N')
;

-- Aug 14, 2013 2:45:16 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210708 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:16 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210709,'Y','N','N','N',22,'N',19,104,'N','N','Y','0feb79ee-d2b5-4d9b-9d18-588fc59ba8cd','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_DATE('2013-08-14 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113,'N')
;

-- Aug 14, 2013 2:45:16 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210709 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:17 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210710,'Y','N','N','N',7,'N',16,'N','N','Y','6161d2f2-73e9-4e58-b7de-bd3ad8522478','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_DATE('2013-08-14 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245,'N')
;

-- Aug 14, 2013 2:45:17 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210710 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210711,110,'Y','N','N','N',22,'N',18,'N','N','Y','bd06cec7-a3aa-4045-9bd0-b312c5a22ec8','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_DATE('2013-08-14 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246,'N')
;

-- Aug 14, 2013 2:45:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210711 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:19 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210712,200064,'N','N','N',0,'N',1,'N',17,'N','N','Y','bde8fd57-0231-4043-a965-6e553dcc1dc5','Y','CtxType','Type of Context Help','The Context Type field indicates the type of context help (tab, process, form etc) this context help is defined as','Context Type','Y',TO_DATE('2013-08-14 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202214,'N')
;

-- Aug 14, 2013 2:45:19 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210712 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:20 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210713,'N','N','N',0,'N',255,'N',14,'N','N','Y','3fabb198-00d3-46f7-86c2-54a033b41011','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_DATE('2013-08-14 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:19','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275,'N')
;

-- Aug 14, 2013 2:45:20 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210713 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:21 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210714,'Y','N','N','N',1,'N',20,'N','N','Y','1ce40427-cf9d-416e-89b9-bee062451eef','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_DATE('2013-08-14 14:45:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348,'N')
;

-- Aug 14, 2013 2:45:21 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210714 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210715,'Y','N','Y',0,'N',120,'N',10,'N','N','Y','e60dbffe-3f8a-4a1c-ae3b-bbd0a1192681','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2013-08-14 14:45:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469,'N')
;

-- Aug 14, 2013 2:45:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210715 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:23 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210716,'Y','N','N','N',7,'N',16,'N','N','Y','29f728eb-3f6b-41b6-9b4d-7fc80a09bd04','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_DATE('2013-08-14 14:45:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607,'N')
;

-- Aug 14, 2013 2:45:23 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210716 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,200099,210717,110,'Y','N','N','N',22,'N',18,'N','N','Y','d5d62391-e424-41ac-b9be-85c4787a55cb','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_DATE('2013-08-14 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:45:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608,'N')
;

-- Aug 14, 2013 2:45:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210717 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:45:42 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=210712
;

-- Aug 14, 2013 2:45:42 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210712
;

-- Aug 14, 2013 2:45:50 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=210713
;

-- Aug 14, 2013 2:45:50 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210713
;

-- Aug 14, 2013 2:46:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210718,'Y','N','N',0,'N',22,'N',19,'N','N','Y','94f8407e-8842-476a-b0cf-4fbbe2a81faa','N','C_TaxProviderCfg_ID','Tax Provider Configuration','Y',TO_DATE('2013-08-14 14:46:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:46:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202579,'N')
;

-- Aug 14, 2013 2:46:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210718 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:47:41 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210719,'N','N','N',0,'N',60,'N',10,'N','N','Y','cab9b90c-582e-45e9-9359-609013f66281','Y','Account','Account','Y',TO_DATE('2013-08-14 14:47:40','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:47:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',53376,'N')
;

-- Aug 14, 2013 2:47:41 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210719 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:48:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('CompanyCode',202584,'Company Code','Company Code','bdcc3d39-ef1b-4def-9d35-cad0d492832d',TO_DATE('2013-08-14 14:48:12','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 14:48:12','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 14, 2013 2:48:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202584 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2013 2:48:26 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210720,'N','N','N',0,'N',60,'N',10,'N','N','Y','a9ab22a0-d3e3-46de-9d02-abb5f62eb907','Y','CompanyCode','Company Code','Y',TO_DATE('2013-08-14 14:48:25','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:48:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202584,'N')
;

-- Aug 14, 2013 2:48:26 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210720 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:48:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('License',202585,'License','License','4ea438b3-6f1c-4f39-981e-f8720e2c11b7',TO_DATE('2013-08-14 14:48:52','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 14:48:52','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 14, 2013 2:48:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202585 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 14, 2013 2:49:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210721,'N','N','N',0,'N',60,'N',10,'N','N','Y','ba9a71ad-e4a4-4f18-ba63-dbce0669d3e0','Y','License','License','Y',TO_DATE('2013-08-14 14:49:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-14 14:49:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202585,'N')
;

-- Aug 14, 2013 2:49:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210721 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 14, 2013 2:49:37 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
CREATE TABLE C_TaxProvider (Account NVARCHAR2(60) DEFAULT NULL , AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_TaxProvider_ID NUMBER(10) NOT NULL, C_TaxProvider_UU NVARCHAR2(36) DEFAULT NULL , C_TaxProviderCfg_ID NUMBER(10) NOT NULL, CompanyCode NVARCHAR2(60) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, License NVARCHAR2(60) DEFAULT NULL , Name NVARCHAR2(120) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT C_TaxProvider_Key PRIMARY KEY (C_TaxProvider_ID), CONSTRAINT C_TaxProvider_UU_idx UNIQUE (C_TaxProvider_UU))
;

-- Aug 14, 2013 2:49:38 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProvider ADD CONSTRAINT ADClient_CTaxProvider FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id)
;

-- Aug 14, 2013 2:49:38 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProvider ADD CONSTRAINT ADOrg_CTaxProvider FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id)
;

-- Aug 14, 2013 2:49:38 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProvider ADD CONSTRAINT CTaxProviderCfg_CTaxProvider FOREIGN KEY (C_TaxProviderCfg_ID) REFERENCES c_taxprovidercfg(c_taxprovidercfg_id)
;

-- Aug 14, 2013 2:49:38 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProvider ADD CONSTRAINT CreatedBy_CTaxProvider FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 14, 2013 2:49:38 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProvider ADD CONSTRAINT UpdatedBy_CTaxProvider FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id)
;

-- Aug 14, 2013 2:50:03 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Org_ID,IsActive,UpdatedBy,CreatedBy,AD_Client_ID) VALUES ('N','M','Y','N','N',0,0,'D','Tax Provider',200045,'64fc1373-7a5e-480a-9a40-e1c473b697ef',TO_DATE('2013-08-14 14:50:03','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-14 14:50:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',100,100,0)
;

-- Aug 14, 2013 2:50:03 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200045 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Aug 14, 2013 2:50:20 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID) VALUES ('N','N','N',200045,10,'N','N',200099,'N','N','N','Y','N',0,'d7c5527f-ef8f-4c2b-b7c2-e245285bba45','D','Tax Provider',200106,0,TO_DATE('2013-08-14 14:50:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Aug 14, 2013 2:50:20 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200106 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Aug 14, 2013 2:50:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200106,22,'N','N',210706,10,'Y',202379,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','f59ca308-6c56-4908-881b-e0361619e0ba','Y','N',100,0,TO_DATE('2013-08-14 14:50:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:24','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 14, 2013 2:50:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202379 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200106,22,'N','N',210709,20,'Y',202380,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','d45c887e-d184-4745-b060-901db08cc552','Y','N','Y',100,0,TO_DATE('2013-08-14 14:50:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:24','YYYY-MM-DD HH24:MI:SS'),'Y',4,0,2)
;

-- Aug 14, 2013 2:50:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202380 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:26 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200106,120,'N','N',210715,30,'Y',202381,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','91501a7e-e650-4983-96cd-c176543ec157','Y','N',100,0,TO_DATE('2013-08-14 14:50:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:25','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 14, 2013 2:50:26 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202381 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:27 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200106,22,'N','N',210707,40,'Y',202382,'N','D','Tax Provider','d906719c-d785-4e8c-b0bf-a7ec9c736b7c','N','N',100,0,TO_DATE('2013-08-14 14:50:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:26','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 14, 2013 2:50:27 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202382 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:27 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',200106,36,'N','N',210708,50,'Y',202383,'N','D','C_TaxProvider_UU','3ed947f6-12c8-4b40-9e5f-3ce62b145c8d','N','N',100,0,TO_DATE('2013-08-14 14:50:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:27','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 14, 2013 2:50:28 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202383 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:28 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200106,22,'N','N',210718,60,'Y',202384,'N','D','Tax Provider Configuration','4bd42c37-46d6-4c07-b1f8-71ca1239d27f','Y','N',100,0,TO_DATE('2013-08-14 14:50:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:28','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 14, 2013 2:50:28 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202384 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200106,60,'N','N',210719,70,'Y',202385,'N','D','Account','f82fc6d6-6ee7-4d10-9d6a-fa569548171f','Y','N',100,0,TO_DATE('2013-08-14 14:50:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:28','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 14, 2013 2:50:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202385 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200106,60,'N','N',210720,80,'Y',202386,'N','D','Company Code','8f0ff3ab-0f15-475b-893c-a0024428fa69','Y','N',100,0,TO_DATE('2013-08-14 14:50:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:29','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 14, 2013 2:50:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202386 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200106,60,'N','N',210721,90,'Y',202387,'N','D','License','79190bb3-7289-423d-8b71-4219ff9bcb57','Y','N',100,0,TO_DATE('2013-08-14 14:50:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:30','YYYY-MM-DD HH24:MI:SS'),'Y',0,5)
;

-- Aug 14, 2013 2:50:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202387 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:50:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200106,1,'N','N',210714,100,'Y',202388,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','a09ccb76-c3da-4926-9eb8-2e7c9a195b08','Y','N',100,0,TO_DATE('2013-08-14 14:50:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-14 14:50:31','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 14, 2013 2:50:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202388 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 14, 2013 2:52:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202383
;

-- Aug 14, 2013 2:52:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202382
;

-- Aug 14, 2013 2:52:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202384
;

-- Aug 14, 2013 2:52:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202381
;

-- Aug 14, 2013 2:52:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202388
;

-- Aug 14, 2013 2:52:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202385
;

-- Aug 14, 2013 2:52:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202386
;

-- Aug 14, 2013 2:52:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202387
;

-- Aug 14, 2013 2:52:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202380
;

-- Aug 14, 2013 2:52:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202384
;

-- Aug 14, 2013 2:52:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202381
;

-- Aug 14, 2013 2:52:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202388
;

-- Aug 14, 2013 2:52:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202385
;

-- Aug 14, 2013 2:52:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202386
;

-- Aug 14, 2013 2:52:44 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202387
;

-- Aug 14, 2013 2:53:04 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-08-14 14:53:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202380
;

-- Aug 14, 2013 2:53:28 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_DATE('2013-08-14 14:53:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202385
;

-- Aug 14, 2013 2:53:29 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_DATE('2013-08-14 14:53:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202386
;

-- Aug 14, 2013 2:53:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET DisplayLength=22,Updated=TO_DATE('2013-08-14 14:53:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202387
;

-- Aug 14, 2013 2:53:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-08-14 14:53:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202386
;

-- Aug 14, 2013 2:53:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-08-14 14:53:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202385
;

-- Aug 14, 2013 2:53:52 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-08-14 14:53:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202386
;

-- Aug 14, 2013 2:54:04 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-08-14 14:54:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202387
;

-- Aug 14, 2013 2:54:27 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Table SET AD_Window_ID=200045,Updated=TO_DATE('2013-08-14 14:54:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200099
;

-- Aug 14, 2013 2:55:04 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,AD_Menu_UU,Action,IsActive,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy,AD_Client_ID) VALUES (200045,200068,'N','N','N','D','Y','Tax Provider','5bf12847-7753-4015-a6e7-1e58a8b3097b','W','Y',100,TO_DATE('2013-08-14 14:55:04','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-08-14 14:55:04','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 14, 2013 2:55:04 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Aug 14, 2013 2:55:04 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200068, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200068)
;

-- Aug 14, 2013 2:55:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Aug 14, 2013 2:55:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53092
;

-- Aug 14, 2013 2:55:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53096
;

-- Aug 14, 2013 2:55:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53097
;

-- Aug 14, 2013 2:55:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53095
;

-- Aug 14, 2013 2:55:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53094
;

-- Aug 14, 2013 2:55:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Aug 14, 2013 2:55:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53092
;

-- Aug 14, 2013 2:55:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53096
;

-- Aug 14, 2013 2:55:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53097
;

-- Aug 14, 2013 2:55:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53095
;

-- Aug 14, 2013 2:55:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Aug 14, 2013 2:55:46 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53094
;

-- Aug 14, 2013 2:55:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53092
;

-- Aug 14, 2013 2:55:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53096
;

-- Aug 14, 2013 2:55:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53097
;

-- Aug 14, 2013 2:55:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53095
;

-- Aug 14, 2013 2:55:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53094
;

-- Aug 14, 2013 2:55:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Aug 14, 2013 2:55:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=53091, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53094
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200067
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200068
;

-- Aug 14, 2013 2:56:57 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Aug 14, 2013 4:14:16 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Column SET Callout='org.compiere.model.CalloutTaxProvider.taxProvider',Updated=TO_DATE('2013-08-14 16:14:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210718
;

-- Aug 15, 2013 3:55:52 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210722,'N','N','N',0,'N',22,'N',11,'N','N','Y','5c37d52a-162e-442b-835d-6b962b0a4995','Y','SeqNo','Method of ordering records; lowest number comes first','The Sequence indicates the order of records','Sequence','Y',TO_DATE('2013-08-15 15:55:51','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-15 15:55:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',566,'N')
;

-- Aug 15, 2013 3:55:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210722 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 15, 2013 3:58:04 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Column SET IsMandatory='Y', DefaultValue='0',Updated=TO_DATE('2013-08-15 15:58:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210722
;

-- Aug 15, 2013 3:58:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProvider ADD SeqNo NUMBER(10) DEFAULT 0 NOT NULL
;

-- Aug 15, 2013 3:58:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200106,22,'N','N',210722,90,'Y',202389,'N','The Sequence indicates the order of records','D','Method of ordering records; lowest number comes first','Sequence','c914b9ca-320d-4546-beb9-fa6e165fcf2a','Y','N',100,0,TO_DATE('2013-08-15 15:58:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 15:58:35','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 3:58:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202389 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 4:59:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('ValidateConnection',202586,'Validate Connection','Validate Connection','e4b2e924-2a5b-4dc9-92ff-24ae6752ba1c',TO_DATE('2013-08-15 16:59:09','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-15 16:59:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Aug 15, 2013 4:59:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202586 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 15, 2013 5:01:00 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value,AD_Client_ID) VALUES ('N',200060,'N','N','3bfaa349-780c-4fdd-96c1-0e7fa276abc0','3','N','N',0,0,'Y','D','Validate Connection',0,TO_DATE('2013-08-15 17:00:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:00:59','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.adempiere.process.ValidateTaxProviderConnection','ValidateTaxProviderConnection',0)
;

-- Aug 15, 2013 5:01:00 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200060 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Aug 15, 2013 5:01:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200099,210723,'N','N','N',0,'N',1,'N',28,'N',200060,'N','Y','cb29d431-0ce5-4a04-9f6d-5fb7ef4bb893','Y','ValidateConnection','Validate Connection','Y',TO_DATE('2013-08-15 17:01:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-15 17:01:11','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',0,'D','N',202586,'N')
;

-- Aug 15, 2013 5:01:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210723 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 15, 2013 5:01:17 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_TaxProvider ADD ValidateConnection CHAR(1) DEFAULT NULL 
;

-- Aug 15, 2013 5:01:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan) VALUES ('N',200106,1,'N','N',210723,100,'Y',202390,'N','D','Validate Connection','76811589-1cae-4920-9a15-329dd9cc5af9','Y','N',100,0,TO_DATE('2013-08-15 17:01:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:01:31','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2)
;

-- Aug 15, 2013 5:01:32 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202390 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:01:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=5,Updated=TO_DATE('2013-08-15 17:01:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202390
;

-- Aug 15, 2013 5:05:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,261,210724,'N','N','N',0,'N',22,'N',19,'N','N','Y','abb95da2-127a-4aae-b147-368c5e022b1d','N','C_TaxProvider_ID','Tax Provider','Y',TO_DATE('2013-08-15 17:05:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-15 17:05:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202582,'N')
;

-- Aug 15, 2013 5:05:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210724 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 15, 2013 5:06:21 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_Tax ADD C_TaxProvider_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 15, 2013 5:06:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_Tax ADD CONSTRAINT CTaxProvider_CTax FOREIGN KEY (C_TaxProvider_ID) REFERENCES c_taxprovider(c_taxprovider_id)
;

-- Aug 15, 2013 5:06:49 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,314,210725,'N','N','N',0,'N',22,'N',19,'N','N','Y','a145d153-fa77-41f5-9e36-0556c1729baa','N','C_TaxProvider_ID','Tax Provider','Y',TO_DATE('2013-08-15 17:06:48','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-15 17:06:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202582,'N')
;

-- Aug 15, 2013 5:06:49 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210725 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 15, 2013 5:06:52 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_OrderTax ADD C_TaxProvider_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 15, 2013 5:06:52 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_OrderTax ADD CONSTRAINT CTaxProvider_COrderTax FOREIGN KEY (C_TaxProvider_ID) REFERENCES c_taxprovider(c_taxprovider_id)
;

-- Aug 15, 2013 5:07:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,334,210726,'N','N','N',0,'N',22,'N',19,'N','N','Y','b0364294-7c76-4a2b-a4d9-41c447310e99','N','C_TaxProvider_ID','Tax Provider','Y',TO_DATE('2013-08-15 17:07:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-15 17:07:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202582,'N')
;

-- Aug 15, 2013 5:07:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210726 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 15, 2013 5:07:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_InvoiceTax ADD C_TaxProvider_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 15, 2013 5:07:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE C_InvoiceTax ADD CONSTRAINT CTaxProvider_CInvoiceTax FOREIGN KEY (C_TaxProvider_ID) REFERENCES c_taxprovider(c_taxprovider_id)
;

-- Aug 15, 2013 5:08:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES (0,'N',0,200055,210727,'N','N','N',0,'N',22,'N',19,'N','N','Y','b0887ac0-cfb7-4f1c-aaae-f5b623e6f6c4','N','C_TaxProvider_ID','Tax Provider','Y',TO_DATE('2013-08-15 17:08:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-08-15 17:08:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202582,'N')
;

-- Aug 15, 2013 5:08:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210727 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 15, 2013 5:08:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE M_RMATax ADD C_TaxProvider_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 15, 2013 5:08:22 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
ALTER TABLE M_RMATax ADD CONSTRAINT CTaxProvider_MRMATax FOREIGN KEY (C_TaxProvider_ID) REFERENCES c_taxprovider(c_taxprovider_id)
;

-- Aug 15, 2013 5:10:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200065,22,'N','N',210727,80,'Y',202391,'N','D','Tax Provider','b3e7e9e5-0027-4050-9c84-883a5b0d8184','Y','N',100,0,TO_DATE('2013-08-15 17:10:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:10:24','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 5:10:24 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202391 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:11:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202391
;

-- Aug 15, 2013 5:11:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201672
;

-- Aug 15, 2013 5:11:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201673
;

-- Aug 15, 2013 5:11:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201668
;

-- Aug 15, 2013 5:11:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202391
;

-- Aug 15, 2013 5:11:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201672
;

-- Aug 15, 2013 5:11:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201673
;

-- Aug 15, 2013 5:11:10 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201668
;

-- Aug 15, 2013 5:11:27 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2013-08-15 17:11:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202391
;

-- Aug 15, 2013 5:11:43 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',200066,22,'N','N',210727,80,'Y',202392,'N','D','Tax Provider','efbedc72-5d7c-41b0-b1ca-d7e5cbd2a870','Y','N',100,0,TO_DATE('2013-08-15 17:11:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:11:42','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 5:11:43 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202392 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:11:48 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202392
;

-- Aug 15, 2013 5:11:48 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201685
;

-- Aug 15, 2013 5:11:48 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201686
;

-- Aug 15, 2013 5:11:48 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201687
;

-- Aug 15, 2013 5:11:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202392
;

-- Aug 15, 2013 5:11:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201685
;

-- Aug 15, 2013 5:11:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201686
;

-- Aug 15, 2013 5:11:51 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201687
;

-- Aug 15, 2013 5:13:35 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2013-08-15 17:13:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202392
;

-- Aug 15, 2013 5:13:54 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',236,36,'N','N',60719,80,'Y',202393,'N','D','C_OrderTax_UU','cc2ac293-d41d-459f-8bc3-aaa5e1caf534','N','N',100,0,TO_DATE('2013-08-15 17:13:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:13:53','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 15, 2013 5:13:54 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202393 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:13:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',236,22,'N','N',210725,90,'Y',202394,'N','D','Tax Provider','0f1a6f8c-e83f-43f9-9d89-737cc78196ef','Y','N',100,0,TO_DATE('2013-08-15 17:13:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:13:54','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 5:13:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202394 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:14:03 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202393
;

-- Aug 15, 2013 5:14:03 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202394
;

-- Aug 15, 2013 5:14:03 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=2894
;

-- Aug 15, 2013 5:14:03 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=2895
;

-- Aug 15, 2013 5:14:03 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=11011
;

-- Aug 15, 2013 5:14:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2275
;

-- Aug 15, 2013 5:14:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2276
;

-- Aug 15, 2013 5:14:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=2279
;

-- Aug 15, 2013 5:14:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=2277
;

-- Aug 15, 2013 5:14:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202394
;

-- Aug 15, 2013 5:14:23 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2013-08-15 17:14:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202394
;

-- Aug 15, 2013 5:14:35 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',295,36,'N','N',60719,80,'Y',202395,'N','D','C_OrderTax_UU','3a9417e2-8075-4c34-aeb6-c8c2942f77a2','N','N',100,0,TO_DATE('2013-08-15 17:14:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:14:34','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 15, 2013 5:14:35 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202395 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:14:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',295,22,'N','N',210725,90,'Y',202396,'N','D','Tax Provider','72718830-7a73-4535-8760-d810037bea00','Y','N',100,0,TO_DATE('2013-08-15 17:14:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:14:35','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 5:14:36 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202396 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:14:47 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202395
;

-- Aug 15, 2013 5:14:47 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202396
;

-- Aug 15, 2013 5:14:47 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=3472
;

-- Aug 15, 2013 5:14:47 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=3473
;

-- Aug 15, 2013 5:14:47 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=3474
;

-- Aug 15, 2013 5:14:47 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=11010
;

-- Aug 15, 2013 5:15:09 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=3468
;

-- Aug 15, 2013 5:15:09 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=3469
;

-- Aug 15, 2013 5:15:09 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=3472
;

-- Aug 15, 2013 5:15:09 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202396
;

-- Aug 15, 2013 5:15:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=3472
;

-- Aug 15, 2013 5:15:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=3470
;

-- Aug 15, 2013 5:15:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202396
;

-- Aug 15, 2013 5:15:35 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2013-08-15 17:15:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202396
;

-- Aug 15, 2013 5:15:50 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',271,36,'N','N',60668,80,'Y',202397,'N','D','C_InvoiceTax_UU','49ed2365-7491-4de6-b5a6-99ae75c81ed7','N','N',100,0,TO_DATE('2013-08-15 17:15:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:15:49','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 15, 2013 5:15:50 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202397 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:15:50 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',271,22,'N','N',210726,90,'Y',202398,'N','D','Tax Provider','77c5d833-aafe-4a0f-898e-5b3fd2c163e8','Y','N',100,0,TO_DATE('2013-08-15 17:15:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:15:50','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 5:15:50 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202398 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:15:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202397
;

-- Aug 15, 2013 5:15:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202398
;

-- Aug 15, 2013 5:15:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=3005
;

-- Aug 15, 2013 5:15:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=3006
;

-- Aug 15, 2013 5:15:55 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=11008
;

-- Aug 15, 2013 5:15:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=3000
;

-- Aug 15, 2013 5:15:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=3001
;

-- Aug 15, 2013 5:15:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=3002
;

-- Aug 15, 2013 5:15:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=3003
;

-- Aug 15, 2013 5:15:59 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202398
;

-- Aug 15, 2013 5:16:12 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2013-08-15 17:16:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202398
;

-- Aug 15, 2013 5:16:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',292,36,'N','N',60668,80,'Y',202399,'N','D','C_InvoiceTax_UU','68f5c46b-a8a5-4e5f-a50e-488c57f0694c','N','N',100,0,TO_DATE('2013-08-15 17:16:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:16:24','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 15, 2013 5:16:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202399 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:16:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',292,22,'N','N',210726,90,'Y',202400,'N','D','Tax Provider','1b775dc7-92e3-4808-8e8a-3773417c3e0a','Y','N',100,0,TO_DATE('2013-08-15 17:16:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:16:25','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 5:16:25 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202400 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:16:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202399
;

-- Aug 15, 2013 5:16:30 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202400
;

-- Aug 15, 2013 5:16:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=3380
;

-- Aug 15, 2013 5:16:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=3381
;

-- Aug 15, 2013 5:16:31 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=11009
;

-- Aug 15, 2013 5:16:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=3376
;

-- Aug 15, 2013 5:16:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=3377
;

-- Aug 15, 2013 5:16:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=3382
;

-- Aug 15, 2013 5:16:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=3378
;

-- Aug 15, 2013 5:16:34 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202400
;

-- Aug 15, 2013 5:16:43 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2013-08-15 17:16:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202400
;

-- Aug 15, 2013 5:20:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan) VALUES ('N',174,36,'N','N',60769,230,'Y',202401,'N','D','C_Tax_UU','ec0ea715-c026-43ef-90f4-130436592d4b','N','N',100,0,TO_DATE('2013-08-15 17:20:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:20:17','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2)
;

-- Aug 15, 2013 5:20:18 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202401 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:20:19 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan) VALUES ('N',174,22,'N','N',210724,240,'Y',202402,'N','D','Tax Provider','97bd93b1-2053-4ebe-8358-f46b0b6ecad8','Y','N',100,0,TO_DATE('2013-08-15 17:20:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-08-15 17:20:18','YYYY-MM-DD HH24:MI:SS'),'Y',0,2)
;

-- Aug 15, 2013 5:20:19 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202402 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 15, 2013 5:22:23 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2013-08-15 17:22:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210724
;

-- Aug 15, 2013 5:24:17 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2013-08-15 17:24:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210718
;

-- Aug 20, 2013 4:21:21 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Table SET AccessLevel='6',Updated=TO_DATE('2013-08-20 16:21:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200098
;

-- Aug 20, 2013 4:21:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=202378
;

-- Aug 20, 2013 4:21:53 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE FROM AD_Field WHERE AD_Field_ID=202378
;

-- Aug 20, 2013 4:22:07 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=210705
;

-- Aug 20, 2013 4:22:08 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
DELETE FROM AD_Column WHERE AD_Column_ID=210705
;

ALTER TABLE C_TaxProviderCfg DROP COLUMN C_Country_ID;

-- Aug 20, 2013 4:24:13 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_DATE('2013-08-20 16:24:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210704
;

-- Aug 23, 2013 4:25:39 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Created,Updated,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200034,'S','N','0fd186f4-07c7-4c9f-9f61-bdc5b8785b39',TO_DATE('2013-08-23 16:25:36','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-08-23 16:25:36','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'TAX_SAVE_REQUEST_RESPONSE_LOG',0,'D')
;

-- Aug 27, 2013 12:37:40 PM SGT
-- IDEMPIERE-1269 Improve tax configuration to support external services
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('E','No tax provider',200221,'D','0f9d414b-293f-4aa0-97df-d93966b0a55f','TaxNoProvider','Y',TO_DATE('2013-08-27 12:37:37','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-08-27 12:37:37','YYYY-MM-DD HH24:MI:SS'),0)
;

SELECT register_migration_script('201308271243_IDEMPIERE-1269.sql') FROM dual
;