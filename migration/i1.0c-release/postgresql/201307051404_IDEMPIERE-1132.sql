-- Jul 3, 2013 6:53:04 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Table_UU,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID) VALUES ('N','4','c89ccd3a-3fb0-426d-802c-b4e621c7df5f',55,100,200085,'N','N','Y','D','L','Y','Y','AD_TableIndex','Index definition for table','Table Index','Y',0,100,TO_TIMESTAMP('2013-07-03 18:53:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-03 18:53:00','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 3, 2013 6:53:04 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200085 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Jul 3, 2013 6:58:42 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210512,'Y','N','N','N',10,'N',19,129,'N','N','Y','21b0f765-a7da-4572-ad41-50a85e88c263','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-07-03 18:58:41','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102)
;

-- Jul 3, 2013 6:58:42 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210512 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210513,'Y','N','N','N',10,'N',19,'N','N','Y','1916264e-841b-46d8-be38-66d3ac675281','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-07-03 18:58:42','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:42','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113)
;

-- Jul 3, 2013 6:58:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210513 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_TableIndex_ID',202542,'Table Index','Table Index','862b5a22-d46a-4e74-acd8-c7981e44db88',TO_TIMESTAMP('2013-07-03 18:58:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 18:58:44','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 6:58:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202542 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 6:58:46 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210514,'Y','N','N','N',10,'N',13,'Y','N','Y','603543fc-ff15-4411-b5d8-3922b07037f9','N','AD_TableIndex_ID','Table Index','N',TO_TIMESTAMP('2013-07-03 18:58:43','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:43','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202542)
;

-- Jul 3, 2013 6:58:46 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210514 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_TableIndex_UU',202543,'AD_TableIndex_UU','AD_TableIndex_UU','cf2a95ef-c462-46c9-90c1-6c6439f97c92',TO_TIMESTAMP('2013-07-03 18:58:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 18:58:46','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 6:58:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202543 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 6:58:48 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.00,200085,210515,'N','N','N','N',36,'N',10,'N','N','Y','69c905af-a257-4e8f-91df-b72ebcfd4f36','Y','AD_TableIndex_UU','AD_TableIndex_UU','N',TO_TIMESTAMP('2013-07-03 18:58:46','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202543)
;

-- Jul 3, 2013 6:58:48 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210515 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210516,53222,'N','N','N',0,'N',1,'N',17,'N','N','Y','934a25af-c8b5-4dc8-944d-2d44017871fa','Y','ConfigurationLevel','Configuration Level for this parameter','S','Configuration Level for this parameter
S - just allowed system configuration
C - client configurable parameter
O - org configurable parameter','Configuration Level','Y',TO_TIMESTAMP('2013-07-03 18:58:48','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',53229)
;

-- Jul 3, 2013 6:58:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210516 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210517,'Y','N','N','N',7,'N',16,'N','N','Y','d90e944c-a771-4b39-add2-7ddf36776f7d','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-07-03 18:58:49','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245)
;

-- Jul 3, 2013 6:58:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210517 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210518,110,'Y','N','N','N',10,'N',18,'N','N','Y','c93581a4-96ce-45f7-af1a-ba3e7cd57d4c','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-07-03 18:58:50','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246)
;

-- Jul 3, 2013 6:58:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210518 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210519,'N','N','N','N',255,'Y',10,'N','N','Y','9a6dadf3-71fb-4796-a5bd-835768bc388c','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2013-07-03 18:58:51','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:51','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275)
;

-- Jul 3, 2013 6:58:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210519 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.000000000000,200085,210520,389,'Y','N','N',0,'N',40,'N',18,'N','@EntityType@=D','N','Y','0fc3aef4-eb58-4fe8-9402-a8ba7fb58871','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','U','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',TO_TIMESTAMP('2013-07-03 18:58:52','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1682)
;

-- Jul 3, 2013 6:58:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210520 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210521,'Y','N','N','N',1,'N',20,'N','N','Y','8560d0b3-56ff-4429-b972-d70978d16423','Y','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-07-03 18:58:53','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:53','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348)
;

-- Jul 3, 2013 6:58:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210521 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210522,'Y','N','Y',1,'N',50,'Y',10,'N','N','Y','1a9d667d-6db0-4e3d-a878-b6ef76be0415','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2013-07-03 18:58:54','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:54','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469)
;

-- Jul 3, 2013 6:58:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210522 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210523,'Y','N','N','N',7,'N',16,'N','N','Y','6715646e-5b5e-466f-900d-9419010113cd','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-07-03 18:58:55','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:55','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607)
;

-- Jul 3, 2013 6:58:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210523 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210524,110,'Y','N','N','N',10,'N',18,'N','N','Y','76a3d4ac-b5d7-4f4b-a82a-ace273f13058','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-07-03 18:58:56','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:56','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608)
;

-- Jul 3, 2013 6:58:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210524 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:58:58 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200085,210525,'Y','N','N','N',255,'Y',10,'N','N','Y','4f73a9a9-0eb9-4b57-a62f-2a75886e9286','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',TO_TIMESTAMP('2013-07-03 18:58:57','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 18:58:57','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',620)
;

-- Jul 3, 2013 6:58:58 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210525 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 6:59:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210516
;

-- Jul 3, 2013 6:59:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210516
;

-- Jul 3, 2013 6:59:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210525
;

-- Jul 3, 2013 6:59:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210525
;

-- Jul 3, 2013 7:00:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200085,210526,'Y','N','N',0,'Y',22,'N',19,'N','N','Y','34c8ec21-088d-4a68-8004-8c288705fafe','N','AD_Table_ID','Database Table information','The Database Table provides the information of the table definition','Table','Y',TO_TIMESTAMP('2013-07-03 19:00:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:00:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',126)
;

-- Jul 3, 2013 7:00:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210526 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:01:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200085,210527,'N','N','N',0,'N',2000,'N',14,'N','N','Y','053e9a0c-0549-4219-b638-ef4f7e8d81c5','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',TO_TIMESTAMP('2013-07-03 19:01:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:01:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',326)
;

-- Jul 3, 2013 7:01:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210527 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:01:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsCreateConstraint',202544,'Create Constraint','Create Constraint','4a7b0544-3615-45c5-8de8-6eadc30afb55',TO_TIMESTAMP('2013-07-03 19:01:55','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:01:55','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:01:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202544 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:03:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200085,210528,'Y','N','N',0,'N',1,'N',20,'N','N','Y','40964cdd-d92a-4594-aa4a-a809ee6d149e','Y','IsCreateConstraint','N','Create Constraint','Y',TO_TIMESTAMP('2013-07-03 19:03:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:03:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202544)
;

-- Jul 3, 2013 7:03:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210528 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:03:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsUnique',202545,'Unique','Unique','b4bb80ec-0a48-4576-8cba-79ccf2c9d778',TO_TIMESTAMP('2013-07-03 19:03:37','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:03:37','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:03:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202545 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:03:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200085,210529,'Y','N','N',0,'N',1,'N',20,'N','N','Y','1c0df81e-2164-4e68-a9de-3278c77aac70','Y','IsUnique','N','Unique','Y',TO_TIMESTAMP('2013-07-03 19:03:48','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:03:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202545)
;

-- Jul 3, 2013 7:03:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210529 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:04:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200085,210530,'N','N','N',0,'N',1,'N',28,'N','N','Y','6d83088c-45f3-4a63-9667-7124feb4bff7','Y','Processing','Process Now','N',TO_TIMESTAMP('2013-07-03 19:04:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:04:20','YYYY-MM-DD HH24:MI:SS'),100,'Y','N',0,'D','N',524)
;

-- Jul 3, 2013 7:04:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210530 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:04:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
CREATE TABLE AD_TableIndex (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Table_ID NUMERIC(10) NOT NULL, AD_TableIndex_ID NUMERIC(10) NOT NULL, AD_TableIndex_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , EntityType VARCHAR(40) DEFAULT 'U' NOT NULL, Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL, IsCreateConstraint CHAR(1) DEFAULT 'N' CHECK (IsCreateConstraint IN ('Y','N')) NOT NULL, IsUnique CHAR(1) DEFAULT 'N' CHECK (IsUnique IN ('Y','N')) NOT NULL, Name VARCHAR(50) NOT NULL, Processing CHAR(1) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_TableIndex_Key PRIMARY KEY (AD_TableIndex_ID), CONSTRAINT AD_TableIndex_UU_idx UNIQUE (AD_TableIndex_UU))
;

-- Jul 3, 2013 7:05:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Table_UU,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID) VALUES ('N','4','76a1578c-f93b-43b0-90e8-459f1b275cbd',55,100,200086,'N','N','Y','D','L','Y','Y','AD_IndexColumn','Index definition for column','Table Index Column','Y',0,100,TO_TIMESTAMP('2013-07-03 19:05:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-03 19:05:51','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 3, 2013 7:05:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200086 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

/*-- Jul 3, 2013 7:05:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Sequence (StartNewYear,IsTableID,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,UpdatedBy,Updated,IsActive,StartNo,CurrentNextSys,CurrentNext,AD_Client_ID) VALUES ('N','Y','N','Y',200084,'Table AD_IndexColumn','AD_IndexColumn',1,'27cb5ee0-fd88-49df-9b2f-130df6edf7a9',0,TO_TIMESTAMP('2013-07-03 19:05:52','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-03 19:05:52','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,200000,1000000,0)
;

-- Jul 3, 2013 7:05:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
CREATE SEQUENCE AD_INDEXCOLUMN_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;*/

-- Jul 3, 2013 7:06:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210531,'Y','N','N','N',10,'N',19,129,'N','N','Y','68bb6535-69c1-4fdb-9547-972db5e0f151','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-07-03 19:06:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102)
;

-- Jul 3, 2013 7:06:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210531 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210532,'Y','N','N','N',10,'N',19,'N','N','Y','84c0705e-bd01-43ce-8d29-d8d30a234a48','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-07-03 19:06:15','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113)
;

-- Jul 3, 2013 7:06:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210532 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_IndexColumn_ID',202546,'Table Index Column','Table Index Column','b24beb2f-d6b9-4072-ab82-d43e012cece1',TO_TIMESTAMP('2013-07-03 19:06:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:06:16','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:06:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202546 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210533,'Y','N','N','N',10,'N',13,'Y','N','Y','6d99ad79-3b0c-4c78-96fa-1215cfbaff26','N','AD_IndexColumn_ID','Table Index Column','N',TO_TIMESTAMP('2013-07-03 19:06:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202546)
;

-- Jul 3, 2013 7:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210533 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_IndexColumn_UU',202547,'AD_IndexColumn_UU','AD_IndexColumn_UU','9bacc713-94c5-4113-a24f-d64c888208bb',TO_TIMESTAMP('2013-07-03 19:06:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:06:18','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:06:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202547 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:06:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.00,200086,210534,'N','N','N','N',36,'N',10,'N','N','Y','71a6ed2c-7d27-4011-8eeb-50f3efaceeed','Y','AD_IndexColumn_UU','AD_IndexColumn_UU','N',TO_TIMESTAMP('2013-07-03 19:06:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202547)
;

-- Jul 3, 2013 7:06:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210534 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210535,53222,'N','N','N',0,'N',1,'N',17,'N','N','Y','18aedcc5-752f-42d6-a7ed-a559e7f3eb03','Y','ConfigurationLevel','Configuration Level for this parameter','S','Configuration Level for this parameter
S - just allowed system configuration
C - client configurable parameter
O - org configurable parameter','Configuration Level','Y',TO_TIMESTAMP('2013-07-03 19:06:20','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:20','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',53229)
;

-- Jul 3, 2013 7:06:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210535 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210536,'Y','N','N','N',7,'N',16,'N','N','Y','8822100b-5efc-43ce-b691-51a7da7fd236','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-07-03 19:06:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245)
;

-- Jul 3, 2013 7:06:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210536 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210537,110,'Y','N','N','N',10,'N',18,'N','N','Y','ad56469f-ba68-4c78-884d-5e0caefab100','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-07-03 19:06:22','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:22','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246)
;

-- Jul 3, 2013 7:06:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210537 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210538,'N','N','N','N',255,'Y',10,'N','N','Y','9d2b6b14-6b61-4818-83bf-88b6d19084e9','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2013-07-03 19:06:23','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:23','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275)
;

-- Jul 3, 2013 7:06:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210538 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.000000000000,200086,210539,389,'Y','N','N',0,'N',40,'N',18,'N','@EntityType@=D','N','Y','3ad40197-d654-4c07-8aa3-9c5ad252c0c3','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','U','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',TO_TIMESTAMP('2013-07-03 19:06:24','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:24','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1682)
;

-- Jul 3, 2013 7:06:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210539 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210540,'Y','N','N','N',1,'N',20,'N','N','Y','dd0ab746-552e-44f7-bbb5-5058da7ed707','Y','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-07-03 19:06:25','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:25','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348)
;

-- Jul 3, 2013 7:06:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210540 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210541,'Y','N','Y',1,'N',50,'Y',10,'N','N','Y','d60acaf9-9742-4d16-b9e0-e7b9a22ccae5','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2013-07-03 19:06:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:26','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469)
;

-- Jul 3, 2013 7:06:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210541 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210542,'Y','N','N','N',7,'N',16,'N','N','Y','9fc65a0c-d8d4-4ff1-9f47-c17cf919f3bd','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-07-03 19:06:27','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607)
;

-- Jul 3, 2013 7:06:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210542 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210543,110,'Y','N','N','N',10,'N',18,'N','N','Y','f2abf5e6-b75d-45fd-ba8b-3e996a980cfd','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-07-03 19:06:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608)
;

-- Jul 3, 2013 7:06:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210543 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200086,210544,'Y','N','N','N',255,'Y',10,'N','N','Y','d0068aa5-3761-4a68-b758-3792f6f05ae5','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',TO_TIMESTAMP('2013-07-03 19:06:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:06:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',620)
;

-- Jul 3, 2013 7:06:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210544 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:06:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210535
;

-- Jul 3, 2013 7:06:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210535
;

-- Jul 3, 2013 7:06:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210538
;

-- Jul 3, 2013 7:06:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210538
;

-- Jul 3, 2013 7:06:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210541
;

-- Jul 3, 2013 7:06:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210541
;

-- Jul 3, 2013 7:06:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210544
;

-- Jul 3, 2013 7:06:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210544
;

-- Jul 3, 2013 7:07:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200086,210545,'Y','N','N',0,'Y',22,'N',19,100,'N','N','Y','559557d9-3df4-4a49-a127-bd0f9af04dff','N','AD_Column_ID','Column in the table','Link to the database column of the table','Column','Y',TO_TIMESTAMP('2013-07-03 19:07:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:07:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',104)
;

-- Jul 3, 2013 7:07:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210545 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:08:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET IsParent='N',Updated=TO_TIMESTAMP('2013-07-03 19:08:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210545
;

-- Jul 3, 2013 7:08:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200086,210546,'Y','N','N',0,'Y',10,'N',19,'N','N','Y','acf67ad3-8ad7-4843-bb18-805f10efc6b8','N','AD_TableIndex_ID','Table Index','Y',TO_TIMESTAMP('2013-07-03 19:08:40','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:08:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202542)
;

-- Jul 3, 2013 7:08:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210546 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:08:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200086,210547,'N','N','N',0,'N',255,'N',10,'N','N','Y','cf641b8b-2221-4904-bf42-1b5376398ed6','Y','ColumnSQL','Virtual Column (r/o)','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days','Column SQL','Y',TO_TIMESTAMP('2013-07-03 19:08:54','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:08:54','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2699)
;

-- Jul 3, 2013 7:08:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210547 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:09:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200086,210548,'N','N','N',0,'N',22,'N',11,'N','N','Y','03852aaf-50be-4c82-b1a6-e2a29e3ca9b9','Y','SeqNo','Method of ordering records; lowest number comes first','The Sequence indicates the order of records','Sequence','Y',TO_TIMESTAMP('2013-07-03 19:09:43','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:09:43','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',566)
;

-- Jul 3, 2013 7:09:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210548 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:09:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
CREATE TABLE AD_IndexColumn (AD_Client_ID NUMERIC(10) NOT NULL, AD_Column_ID NUMERIC(10) NOT NULL, AD_IndexColumn_ID NUMERIC(10) NOT NULL, AD_IndexColumn_UU VARCHAR(36) DEFAULT NULL , AD_Org_ID NUMERIC(10) NOT NULL, AD_TableIndex_ID NUMERIC(10) NOT NULL, ColumnSQL VARCHAR(255) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, EntityType VARCHAR(40) DEFAULT 'U' NOT NULL, IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL, SeqNo NUMERIC(10) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_IndexColumn_Key PRIMARY KEY (AD_IndexColumn_ID), CONSTRAINT AD_IndexColumn_UU_idx UNIQUE (AD_IndexColumn_UU))
;

-- Jul 3, 2013 7:10:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Table_UU,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID) VALUES ('N','4','9562e6b3-63d2-4f97-8586-c21fee0f96dd',55,100,200087,'N','N','Y','D','L','Y','Y','AD_ViewComponent',NULL,'Database View Component','Y',0,100,TO_TIMESTAMP('2013-07-03 19:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-03 19:10:55','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 3, 2013 7:10:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200087 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

/*-- Jul 3, 2013 7:10:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Sequence (StartNewYear,IsTableID,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,UpdatedBy,Updated,IsActive,StartNo,CurrentNextSys,CurrentNext,AD_Client_ID) VALUES ('N','Y','N','Y',200085,'Table AD_ViewComponent','AD_ViewComponent',1,'726b9fac-628f-4312-8c27-1f334e16511f',0,TO_TIMESTAMP('2013-07-03 19:10:56','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-03 19:10:56','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,200000,1000000,0)
;

-- Jul 3, 2013 7:10:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
CREATE SEQUENCE AD_VIEWCOMPONENT_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;*/

-- Jul 3, 2013 7:11:05 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210549,'Y','N','N','N',10,'N',19,129,'N','N','Y','3defad9b-113a-420a-a789-e712f37994d1','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-07-03 19:11:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102)
;

-- Jul 3, 2013 7:11:05 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210549 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210550,'Y','N','N','N',10,'N',19,'N','N','Y','23d2d3ee-9f79-4498-9ba2-46caaa040f50','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-07-03 19:11:05','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113)
;

-- Jul 3, 2013 7:11:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210550 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_ViewComponent_ID',202548,'Database View Component','Database View Component','78aa8c6b-40ae-4afe-8e83-350231ad2270',TO_TIMESTAMP('2013-07-03 19:11:06','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:11:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:11:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202548 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:11:08 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210551,'Y','N','N','N',10,'N',13,'Y','N','Y','70e76a1c-33bf-4cd2-911c-586962795ff4','N','AD_ViewComponent_ID','Database View Component','N',TO_TIMESTAMP('2013-07-03 19:11:06','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202548)
;

-- Jul 3, 2013 7:11:08 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210551 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:09 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_ViewComponent_UU',202549,'AD_ViewComponent_UU','AD_ViewComponent_UU','ed3f3503-4481-4932-acdb-2c83e31d5e05',TO_TIMESTAMP('2013-07-03 19:11:08','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:11:08','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:11:09 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202549 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:11:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.00,200087,210552,'N','N','N','N',36,'N',10,'N','N','Y','8699a93b-91a5-423c-92f3-7921c56cece3','Y','AD_ViewComponent_UU','AD_ViewComponent_UU','N',TO_TIMESTAMP('2013-07-03 19:11:08','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:08','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202549)
;

-- Jul 3, 2013 7:11:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210552 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210553,53222,'N','N','N',0,'N',1,'N',17,'N','N','Y','b0f0f103-90e9-49ea-8e7f-4dc8a55d13a0','Y','ConfigurationLevel','Configuration Level for this parameter','S','Configuration Level for this parameter
S - just allowed system configuration
C - client configurable parameter
O - org configurable parameter','Configuration Level','Y',TO_TIMESTAMP('2013-07-03 19:11:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',53229)
;

-- Jul 3, 2013 7:11:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210553 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:12 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210554,'Y','N','N','N',7,'N',16,'N','N','Y','bfe21c8c-2773-4122-a358-4aacdabcdc9c','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-07-03 19:11:11','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:11','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245)
;

-- Jul 3, 2013 7:11:12 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210554 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210555,110,'Y','N','N','N',10,'N',18,'N','N','Y','e4e184cb-55ac-4653-bed9-c12444557a29','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-07-03 19:11:12','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:12','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246)
;

-- Jul 3, 2013 7:11:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210555 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210556,'N','N','N','N',255,'Y',10,'N','N','Y','3c95235c-064a-4e60-a808-8fb68b7fbbe9','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2013-07-03 19:11:13','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:13','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275)
;

-- Jul 3, 2013 7:11:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210556 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.000000000000,200087,210557,389,'Y','N','N',0,'N',40,'N',18,'N','@EntityType@=D','N','Y','2c5540c2-f38e-47d8-8c78-b85294981c08','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','U','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',TO_TIMESTAMP('2013-07-03 19:11:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1682)
;

-- Jul 3, 2013 7:11:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210557 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210558,'Y','N','N','N',1,'N',20,'N','N','Y','7081420e-1b11-41c9-bd59-3d5a37f921e5','Y','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-07-03 19:11:15','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348)
;

-- Jul 3, 2013 7:11:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210558 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210559,'Y','N','Y',1,'N',50,'Y',10,'N','N','Y','0de7e965-9ad4-43ac-bb17-55d4af26c27c','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2013-07-03 19:11:16','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:16','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469)
;

-- Jul 3, 2013 7:11:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210559 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210560,'Y','N','N','N',7,'N',16,'N','N','Y','4e14741d-8cbf-4cba-9dc2-7fdbf36f2d28','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-07-03 19:11:17','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:17','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607)
;

-- Jul 3, 2013 7:11:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210560 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210561,110,'Y','N','N','N',10,'N',18,'N','N','Y','6a777b92-100b-4bf9-9efe-824b6e780da1','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-07-03 19:11:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608)
;

-- Jul 3, 2013 7:11:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210561 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200087,210562,'Y','N','N','N',255,'Y',10,'N','N','Y','5bff915c-a679-4c73-a55b-38987f0bb52f','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',TO_TIMESTAMP('2013-07-03 19:11:18','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:11:18','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',620)
;

-- Jul 3, 2013 7:11:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210562 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:11:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210553
;

-- Jul 3, 2013 7:11:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210553
;

-- Jul 3, 2013 7:11:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210562
;

-- Jul 3, 2013 7:11:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210562
;

-- Jul 3, 2013 7:12:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210563,'Y','N','N',0,'Y',22,'N',19,'N','N','Y','3098139e-c0f6-4155-85de-cba585caaa3f','N','AD_Table_ID','Database Table information','The Database Table provides the information of the table definition','Table','Y',TO_TIMESTAMP('2013-07-03 19:12:01','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:12:01','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',126)
;

-- Jul 3, 2013 7:12:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210563 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:12:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210564,'N','N','N',0,'N',2000,'N',14,'N','N','Y','7dd25cf6-7ee1-4024-8469-8b83e17c3f44','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',TO_TIMESTAMP('2013-07-03 19:12:14','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:12:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',326)
;

-- Jul 3, 2013 7:12:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210564 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:12:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210565,'N','N','N',0,'N',2000,'N',14,'N','N','Y','7401a1bb-6efe-44c7-ae9a-9ae596593123','Y','OtherClause','Other SQL Clause','Any other complete clause like GROUP BY, HAVING, ORDER BY, etc. after WHERE clause.','Other SQL Clause','Y',TO_TIMESTAMP('2013-07-03 19:12:49','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:12:49','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2642)
;

-- Jul 3, 2013 7:12:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210565 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:13:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('Referenced_Table_ID',202550,'Referenced Table','Referenced Table','5891573c-1dd8-4cb9-a5cd-3e83a69db8ee',TO_TIMESTAMP('2013-07-03 19:13:18','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:13:18','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:13:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202550 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:13:40 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210566,53290,'N','N','N',0,'N',10,'N',18,'N','N','Y','84d5e699-596f-4e0b-b8bc-900e70632a94','Y','Referenced_Table_ID','Referenced Table','Y',TO_TIMESTAMP('2013-07-03 19:13:40','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:13:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202550)
;

-- Jul 3, 2013 7:13:40 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210566 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:13:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210567,'N','N','N',0,'N',22,'N',11,'N','N','Y','7af1b351-f155-4f36-bc25-fa301d23a62c','Y','SeqNo','Method of ordering records; lowest number comes first','The Sequence indicates the order of records','Sequence','Y',TO_TIMESTAMP('2013-07-03 19:13:48','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:13:48','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',566)
;

-- Jul 3, 2013 7:13:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210567 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:14:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210568,'N','N','N',0,'N',2000,'N',14,'N','N','Y','c599559e-b0eb-451e-bbaf-ecb66c06bb8e','Y','WhereClause','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".','Sql WHERE','Y',TO_TIMESTAMP('2013-07-03 19:13:59','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:13:59','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',630)
;

-- Jul 3, 2013 7:14:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210568 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:14:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210569,'N','N','N',0,'N',2000,'N',14,'N','N','Y','afd5acbd-0e28-4491-9674-eb15aa81a784','Y','FromClause','SQL FROM clause','The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses. Do not include the FROM itself.','Sql FROM','Y',TO_TIMESTAMP('2013-07-03 19:14:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:14:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2101)
;

-- Jul 3, 2013 7:14:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210569 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:14:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
CREATE TABLE AD_ViewComponent (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Table_ID NUMERIC(10) NOT NULL, AD_ViewComponent_ID NUMERIC(10) NOT NULL, AD_ViewComponent_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , EntityType VARCHAR(40) DEFAULT 'U' NOT NULL, FromClause VARCHAR(2000) DEFAULT NULL , Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(50) NOT NULL, OtherClause VARCHAR(2000) DEFAULT NULL , Referenced_Table_ID NUMERIC(10) DEFAULT NULL , SeqNo NUMERIC(10) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, WhereClause VARCHAR(2000) DEFAULT NULL , CONSTRAINT AD_ViewComponent_Key PRIMARY KEY (AD_ViewComponent_ID), CONSTRAINT AD_ViewComponent_UU_idx UNIQUE (AD_ViewComponent_UU))
;

-- Jul 3, 2013 7:15:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Table_UU,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,IsCentrallyMaintained,IsDeleteable,TableName,Name,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created,AD_Client_ID) VALUES ('N','4','2935adf3-6380-4faf-9a50-671fa508ae30',55,100,200088,'N','N','Y','D','L','Y','Y','AD_ViewColumn','Database View Column','Y',0,100,TO_TIMESTAMP('2013-07-03 19:15:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-03 19:15:18','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 3, 2013 7:15:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200088 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

/*-- Jul 3, 2013 7:15:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Sequence (StartNewYear,IsTableID,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,Created,CreatedBy,UpdatedBy,Updated,IsActive,StartNo,CurrentNextSys,CurrentNext,AD_Client_ID) VALUES ('N','Y','N','Y',200086,'Table AD_ViewColumn','AD_ViewColumn',1,'4b0c63f9-5963-42dc-877b-90c33342e867',0,TO_TIMESTAMP('2013-07-03 19:15:19','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-03 19:15:19','YYYY-MM-DD HH24:MI:SS'),'Y',1000000,200000,1000000,0)
;

-- Jul 3, 2013 7:15:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
CREATE SEQUENCE AD_VIEWCOLUMN_SQ INCREMENT 1 MINVALUE 1000000 MAXVALUE 2147483647 START 1000000
;*/

-- Jul 3, 2013 7:15:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210570,'Y','N','N','N',10,'N',19,129,'N','N','Y','dc75ca98-f7df-44e8-b13a-a63ccd49ff6b','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',TO_TIMESTAMP('2013-07-03 19:15:27','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',102)
;

-- Jul 3, 2013 7:15:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210570 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210571,'Y','N','N','N',10,'N',19,'N','N','Y','e02bbee2-27b1-43ae-b7e1-6939a6b192d7','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',TO_TIMESTAMP('2013-07-03 19:15:28','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:28','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',113)
;

-- Jul 3, 2013 7:15:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210571 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_ViewColumn_ID',202551,'Database View Column','Database View Column','8f61b373-3c0b-4ac5-928d-4de6289d33f5',TO_TIMESTAMP('2013-07-03 19:15:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:15:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:15:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202551 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:15:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210572,'Y','N','N','N',10,'N',13,'Y','N','Y','c302370a-ab11-4a10-857c-5d1f2f48a6f9','N','AD_ViewColumn_ID','Database View Column','N',TO_TIMESTAMP('2013-07-03 19:15:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202551)
;

-- Jul 3, 2013 7:15:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210572 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('AD_ViewColumn_UU',202552,'AD_ViewColumn_UU','AD_ViewColumn_UU','138fac42-e724-4637-8064-24b811f33e49',TO_TIMESTAMP('2013-07-03 19:15:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:15:31','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:15:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202552 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:15:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.00,200088,210573,'N','N','N','N',36,'N',10,'N','N','Y','3c56994d-7121-41d8-a08f-8cf19d8d8a61','Y','AD_ViewColumn_UU','AD_ViewColumn_UU','N',TO_TIMESTAMP('2013-07-03 19:15:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202552)
;

-- Jul 3, 2013 7:15:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210573 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:33 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210574,53222,'N','N','N',0,'N',1,'N',17,'N','N','Y','abb33d78-99c2-4acd-986e-b90616296e9d','Y','ConfigurationLevel','Configuration Level for this parameter','S','Configuration Level for this parameter
S - just allowed system configuration
C - client configurable parameter
O - org configurable parameter','Configuration Level','Y',TO_TIMESTAMP('2013-07-03 19:15:32','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:32','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',53229)
;

-- Jul 3, 2013 7:15:33 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210574 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210575,'Y','N','N','N',7,'N',16,'N','N','Y','a5ebf6f3-1231-4b02-8672-827ef5dd03a9','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',TO_TIMESTAMP('2013-07-03 19:15:33','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:33','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',245)
;

-- Jul 3, 2013 7:15:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210575 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210576,110,'Y','N','N','N',10,'N',18,'N','N','Y','7edda7bd-722c-49a2-96fc-61baee3cb98c','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',TO_TIMESTAMP('2013-07-03 19:15:35','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:35','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',246)
;

-- Jul 3, 2013 7:15:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210576 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210577,'N','N','N','N',255,'Y',10,'N','N','Y','084c2669-a6aa-46f7-81a0-7c2f5ff062eb','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',TO_TIMESTAMP('2013-07-03 19:15:36','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:36','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',275)
;

-- Jul 3, 2013 7:15:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210577 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',1.000000000000,200088,210578,389,'Y','N','N',0,'N',40,'N',18,'N','@EntityType@=D','N','Y','31bf3f2b-d0ce-456a-93cb-ff857569fec3','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','U','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',TO_TIMESTAMP('2013-07-03 19:15:37','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:37','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1682)
;

-- Jul 3, 2013 7:15:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210578 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210579,'Y','N','N','N',1,'N',20,'N','N','Y','ae609f7b-598c-464a-8fac-12156892c15e','Y','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',TO_TIMESTAMP('2013-07-03 19:15:37','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:37','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',348)
;

-- Jul 3, 2013 7:15:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210579 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:39 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210580,'Y','N','Y',1,'N',50,'Y',10,'N','N','Y','cedf8d05-1580-4528-b126-7d1ba5faeb12','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_TIMESTAMP('2013-07-03 19:15:38','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469)
;

-- Jul 3, 2013 7:15:39 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210580 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:40 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210581,'Y','N','N','N',7,'N',16,'N','N','Y','d4b07f69-7785-4f19-bb48-4bbc0a3f106f','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',TO_TIMESTAMP('2013-07-03 19:15:39','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:39','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',607)
;

-- Jul 3, 2013 7:15:40 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210581 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:41 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210582,110,'Y','N','N','N',10,'N',18,'N','N','Y','28247fc0-72a8-4bc4-97cb-6e458a1f4d66','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',TO_TIMESTAMP('2013-07-03 19:15:40','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:40','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',608)
;

-- Jul 3, 2013 7:15:41 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210582 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:15:42 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES ('N',0,200088,210583,'Y','N','N','N',255,'Y',10,'N','N','Y','83ab8685-90cd-4a0e-bfd4-33321881a5eb','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',TO_TIMESTAMP('2013-07-03 19:15:42','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:15:42','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',620)
;

-- Jul 3, 2013 7:15:42 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210583 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:16:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210574
;

-- Jul 3, 2013 7:16:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210574
;

-- Jul 3, 2013 7:16:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210580
;

-- Jul 3, 2013 7:16:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210580
;

-- Jul 3, 2013 7:16:03 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210583
;

-- Jul 3, 2013 7:16:03 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210583
;

-- Jul 3, 2013 7:16:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200088,210584,'Y','N','N',0,'Y',10,'N',19,'N','N','Y','dac5a3a6-52b1-4dfa-8032-38707b765d94','N','AD_ViewComponent_ID','Database View Component','Y',TO_TIMESTAMP('2013-07-03 19:16:31','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:16:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202548)
;

-- Jul 3, 2013 7:16:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210584 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:17:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200088,210585,'N','N','N',0,'N',30,'Y',10,'N','N','Y','14ce970a-593a-4263-aa73-623d207133fd','Y','ColumnName','Name of the column in the database','The Column Name indicates the name of a column on a table as defined in the database.','DB Column Name','Y',TO_TIMESTAMP('2013-07-03 19:17:29','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:17:29','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',228)
;

-- Jul 3, 2013 7:17:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210585 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:17:40 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200088,210586,'N','N','N',0,'N',255,'N',10,'N','N','Y','b76c8658-020a-4b4a-a3ed-5a270c29af9e','Y','ColumnSQL','Virtual Column (r/o)','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days','Column SQL','Y',TO_TIMESTAMP('2013-07-03 19:17:39','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:17:39','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',2699)
;

-- Jul 3, 2013 7:17:40 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210586 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:18:04 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200088,210587,'N','N','N',0,'N',2000,'N',14,'N','N','Y','db94c9e1-7eab-4544-a37d-56865484be28','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',TO_TIMESTAMP('2013-07-03 19:18:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:18:04','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',326)
;

-- Jul 3, 2013 7:18:04 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210587 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:18:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('DBDataType',202553,'Database Data Type','Database Data Type','a6f57a7e-3ae4-497e-a599-c5741c0bd4bd',TO_TIMESTAMP('2013-07-03 19:18:29','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:18:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Jul 3, 2013 7:18:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202553 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 3, 2013 7:19:34 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy,AD_Client_ID,EntityType) VALUES (200070,'Database Data Type','838bdb4e-d888-46f6-a611-cd4f5cedb31c','N','L',0,100,TO_TIMESTAMP('2013-07-03 19:19:33','YYYY-MM-DD HH24:MI:SS'),'Y',TO_TIMESTAMP('2013-07-03 19:19:33','YYYY-MM-DD HH24:MI:SS'),100,0,'D')
;

-- Jul 3, 2013 7:19:34 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Jul 3, 2013 7:20:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200142,200070,'da6b3cf4-f719-418f-b395-bbf193b703fa','Binary LOB','BinaryLOB',100,TO_TIMESTAMP('2013-07-03 19:20:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:20:16','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:20:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200142 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:20:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200143,200070,'7db6163c-92ac-4f63-b81f-63277341e5ff','Character Fixed','CharacterFixed',100,TO_TIMESTAMP('2013-07-03 19:20:27','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:20:27','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:20:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200143 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:20:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200144,200070,'7ffa55a1-6089-45c9-9fbd-9132c134bd18','Decimal','Decimal',100,TO_TIMESTAMP('2013-07-03 19:20:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:20:34','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:20:35 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200144 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:20:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200145,200070,'1eb7b0f8-23f3-4622-a890-a93410bd0d80','Integer','Integer',100,TO_TIMESTAMP('2013-07-03 19:20:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:20:43','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:20:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200145 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:20:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200146,200070,'3c799a29-5017-4fc2-9402-0fbf55b198cd','Character LOB','CharacterLOB',100,TO_TIMESTAMP('2013-07-03 19:20:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:20:52','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:20:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200146 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:21:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200147,200070,'7bd0bc54-a940-4afd-98ab-a3011ace6b3f','Number','Number',100,TO_TIMESTAMP('2013-07-03 19:20:59','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:20:59','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:21:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200147 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:21:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200148,200070,'363a5407-0f48-443b-8b78-626ac45b6590','Timestamp','Timestamp',100,TO_TIMESTAMP('2013-07-03 19:21:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:21:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:21:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200148 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:21:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,AD_Ref_List_UU,Name,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID,EntityType) VALUES (200149,200070,'ab034a7b-aeba-4bd9-b621-620d67dca79e','Character Variable','CharacterVariable',100,TO_TIMESTAMP('2013-07-03 19:21:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-07-03 19:21:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0,'D')
;

-- Jul 3, 2013 7:21:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200149 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Jul 3, 2013 7:21:41 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='B',Updated=TO_TIMESTAMP('2013-07-03 19:21:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200142
;

-- Jul 3, 2013 7:21:46 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='C',Updated=TO_TIMESTAMP('2013-07-03 19:21:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200143
;

-- Jul 3, 2013 7:21:48 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='D',Updated=TO_TIMESTAMP('2013-07-03 19:21:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200144
;

-- Jul 3, 2013 7:21:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='I',Updated=TO_TIMESTAMP('2013-07-03 19:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200145
;

-- Jul 3, 2013 7:21:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='L',Updated=TO_TIMESTAMP('2013-07-03 19:21:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200146
;

-- Jul 3, 2013 7:21:58 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='N',Updated=TO_TIMESTAMP('2013-07-03 19:21:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200147
;

-- Jul 3, 2013 7:22:01 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='T',Updated=TO_TIMESTAMP('2013-07-03 19:22:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200148
;

-- Jul 3, 2013 7:22:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Ref_List SET Value='V',Updated=TO_TIMESTAMP('2013-07-03 19:22:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200149
;

-- Jul 3, 2013 7:22:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200088,210588,200070,'N','N','N',0,'N',1,'N',17,'N','N','Y','da572b1d-90e6-405e-a039-d7ed9be9ca0a','Y','DBDataType','Database Data Type','Y',TO_TIMESTAMP('2013-07-03 19:22:38','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-03 19:22:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202553)
;

-- Jul 3, 2013 7:22:38 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210588 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 3, 2013 7:23:04 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
CREATE TABLE AD_ViewColumn (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_ViewColumn_ID NUMERIC(10) NOT NULL, AD_ViewColumn_UU VARCHAR(36) DEFAULT NULL , AD_ViewComponent_ID NUMERIC(10) NOT NULL, ColumnName VARCHAR(30) DEFAULT NULL , ColumnSQL VARCHAR(255) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, DBDataType CHAR(1) DEFAULT NULL , Description VARCHAR(255) DEFAULT NULL , EntityType VARCHAR(40) DEFAULT 'U' NOT NULL, Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_ViewColumn_Key PRIMARY KEY (AD_ViewColumn_ID), CONSTRAINT AD_ViewColumn_UU_idx UNIQUE (AD_ViewColumn_UU))
;

-- Jul 4, 2013 2:30:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab (Processing,ImportFields,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,AD_Column_ID,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('N','N','N',100,70,'N','N',200085,'N',210526,'N','N','Y','N',1,'fba100de-536e-40cf-8c1b-72c2d063ee37','Table Index',200096,0,TO_TIMESTAMP('2013-07-04 14:30:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:30:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,'D')
;

-- Jul 4, 2013 2:30:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200096 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 4, 2013 2:31:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Tab SET DisplayLogic='@IsView@!''Y''',Updated=TO_TIMESTAMP('2013-07-04 14:31:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200096
;

-- Jul 4, 2013 2:31:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,10,'N','N',210512,10,'Y',202199,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','dab0b3f7-c047-4d36-b50d-4c3ad89385ea','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:18','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:31:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202199 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,10,'N','N',210513,20,'Y',202200,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','faa64c77-3910-4525-80c3-dae89e4573e3','Y','N','Y',100,0,TO_TIMESTAMP('2013-07-04 14:31:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:19','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,0,2,'D')
;

-- Jul 4, 2013 2:31:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202200 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,50,'N','N',210522,30,'Y',202201,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','4ee65b4b-c3e0-4036-936e-9aec22477d5c','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:20','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:31:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202201 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,255,'N','N',210519,40,'Y',202202,'N','A description is limited to 255 characters.','Optional short description of the record','Description','9739d4d2-c42a-4043-914e-fb237aa67c16','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:21','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,'D')
;

-- Jul 4, 2013 2:31:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202202 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines,EntityType) VALUES ('N',200096,2000,'N','N',210527,50,'Y',202203,'N','The Help field contains a hint, comment or help about the use of this item.','Comment or Hint','Comment/Help','ffff9420-a25e-4e6a-94c9-b2f281fe67a7','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:22','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3,'D')
;

-- Jul 4, 2013 2:31:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202203 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,10,'N','N',210514,60,'Y',202204,'N','Table Index','4f57e56e-a4f0-4c02-b291-5834fc7b5739','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:22','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:31:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202204 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,36,'N','N',210515,70,'Y',202205,'N','AD_TableIndex_UU','fff46bb7-edae-43d0-a320-9957f21b6b85','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:23','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:31:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202205 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,40,'N','N',210520,80,'Y',202206,'N','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Dictionary Entity Type; Determines ownership and synchronization','Entity Type','37636e1f-39bf-4766-b744-c76298bee216','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:24','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:31:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202206 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,22,'N','N',210526,90,'Y',202207,'N','The Database Table provides the information of the table definition','Database Table information','Table','86b551bf-3a4c-4508-849b-09c3edb0f78d','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:25','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:31:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202207 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,1,'N','N',210528,100,'Y',202208,'N','Create Constraint','bf6dab2e-856d-4876-a559-ba03fa4d374c','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:26','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:31:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202208 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,1,'N','N',210529,110,'Y',202209,'N','Unique','96251cc7-ada2-486d-a96a-cdc0180e29ca','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:27','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:31:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202209 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,1,'N','N',210530,120,'Y',202210,'N','Process Now','b1e96405-1014-4d1a-8a39-faf9728266fa','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:27','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:31:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202210 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:31:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,1,'N','N',210521,130,'Y',202211,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','0a59f8b2-1b91-4079-bd67-89f6c5d7d0c0','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:31:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:31:28','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:31:29 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202211 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202205
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202204
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202207
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202201
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202202
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202203
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202211
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202208
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202209
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202206
;

-- Jul 4, 2013 2:37:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202210
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202207
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202211
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202203
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202208
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202202
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202206
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202201
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202210
;

-- Jul 4, 2013 2:38:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202209
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202201
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202202
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202203
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202211
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202208
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202209
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202206
;

-- Jul 4, 2013 2:38:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202210
;

-- Jul 4, 2013 2:38:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 14:38:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202200
;

-- Jul 4, 2013 2:38:59 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 14:38:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202209
;

-- Jul 4, 2013 2:39:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 14:39:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202210
;

-- Jul 4, 2013 2:39:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2013-07-04 14:39:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202209
;

-- Jul 4, 2013 2:39:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET XPosition=5,Updated=TO_TIMESTAMP('2013-07-04 14:39:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202210
;

-- Jul 4, 2013 2:41:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab (Processing,ImportFields,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,AD_Column_ID,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,DisplayLogic,TabLevel,AD_Tab_UU,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('N','N','N',100,80,'N','N',200086,'N',210546,'N','N','Y','N','@IsView@!''Y''',2,'43eb960b-f992-42b5-9463-8a658cc387ab','Index Column',200097,0,TO_TIMESTAMP('2013-07-04 14:41:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:07','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,'D')
;

-- Jul 4, 2013 2:41:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200097 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 4, 2013 2:41:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,10,'N','N',210531,10,'Y',202212,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','ec3e9dc5-1bdc-4585-8d1e-4228218ca3da','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:14','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:41:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202212 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,10,'N','N',210532,20,'Y',202213,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','c1037c89-3666-413c-a7b5-4aac9797c2fb','Y','N','Y',100,0,TO_TIMESTAMP('2013-07-04 14:41:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,0,2,'D')
;

-- Jul 4, 2013 2:41:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202213 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,10,'N','N',210533,30,'Y',202214,'N','Table Index Column','09705adc-f0a5-48d2-8d11-6d3edc443ace','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:16','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:41:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202214 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,36,'N','N',210534,40,'Y',202215,'N','AD_IndexColumn_UU','36243c1e-ac92-4668-81a8-617740fa3c52','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:16','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:41:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202215 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,40,'N','N',210539,50,'Y',202216,'N','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Dictionary Entity Type; Determines ownership and synchronization','Entity Type','ecf03e56-2f7a-4ffe-8526-3930d26e854e','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:17','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:41:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202216 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,22,'N','N',210545,60,'Y',202217,'N','Link to the database column of the table','Column in the table','Column','be7b08a8-cb12-4541-b188-84be9527caae','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:18','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:41:19 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202217 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,10,'N','N',210546,70,'Y',202218,'N','Table Index','80f87fc4-76c5-4f79-99da-a1301599ca74','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:19','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:41:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202218 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,255,'N','N',210547,80,'Y',202219,'N','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days','Virtual Column (r/o)','Column SQL','2a1cce4b-e50e-4004-8cfa-c7a59ed1864c','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:20','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,'D')
;

-- Jul 4, 2013 2:41:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202219 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,22,'N','N',210548,90,'Y',202220,'N','The Sequence indicates the order of records','Method of ordering records; lowest number comes first','Sequence','04fd3f6c-330c-4b0a-a682-3c232ef0552f','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:20','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:41:21 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202220 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:41:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200097,1,'N','N',210540,100,'Y',202221,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','ec136162-f1cc-4d3e-9853-37c8eea8faa6','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:41:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:41:21','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:41:22 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202221 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202215
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202214
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202218
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202217
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202219
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202221
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202220
;

-- Jul 4, 2013 2:43:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202216
;

-- Jul 4, 2013 2:43:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202218
;

-- Jul 4, 2013 2:43:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202217
;

-- Jul 4, 2013 2:43:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202219
;

-- Jul 4, 2013 2:43:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202221
;

-- Jul 4, 2013 2:43:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202220
;

-- Jul 4, 2013 2:43:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202216
;

-- Jul 4, 2013 2:43:58 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 14:43:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202213
;

-- Jul 4, 2013 2:44:59 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=22, IsSameLine='Y', XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-07-04 14:44:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202219
;

-- Jul 4, 2013 2:45:06 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-04 14:45:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202220
;

-- Jul 4, 2013 2:45:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab (Processing,ImportFields,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,DisplayLogic,TabLevel,AD_Tab_UU,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('N','N','N',100,90,'N','N',200087,'N','N','N','Y','N','@IsView@=''Y''',1,'d7a184b5-75e6-416e-a20e-ed741b94d0ed','View Component',200098,0,TO_TIMESTAMP('2013-07-04 14:45:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:42','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,'D')
;

-- Jul 4, 2013 2:45:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200098 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 4, 2013 2:45:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,10,'N','N',210549,10,'Y',202222,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','e43c2a8e-bfb0-418e-99f8-017eab58319e','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:45','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:45:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202222 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:46 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,10,'N','N',210550,20,'Y',202223,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','0ff3ff92-156e-4489-b3ed-90a887fb78a2','Y','N','Y',100,0,TO_TIMESTAMP('2013-07-04 14:45:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:45','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,0,2,'D')
;

-- Jul 4, 2013 2:45:46 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202223 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,50,'N','N',210559,30,'Y',202224,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Alphanumeric identifier of the entity','Name','f2b9c63b-75c4-4d12-ab38-7d7dccc39072','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:46','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:45:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202224 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:48 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,255,'N','N',210556,40,'Y',202225,'N','A description is limited to 255 characters.','Optional short description of the record','Description','414e3fe8-b602-4261-8d23-47f471d5fc0a','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:47','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,'D')
;

-- Jul 4, 2013 2:45:48 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202225 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines,EntityType) VALUES ('N',200098,2000,'N','N',210564,50,'Y',202226,'N','The Help field contains a hint, comment or help about the use of this item.','Comment or Hint','Comment/Help','d15638c9-a90a-4505-b37f-a46d8c45f8b6','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:48','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3,'D')
;

-- Jul 4, 2013 2:45:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202226 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,10,'N','N',210551,60,'Y',202227,'N','Database View Component','28fb5093-92ef-47b9-a005-ee1ff3f3a1ec','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:49','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:45:49 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202227 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,36,'N','N',210552,70,'Y',202228,'N','AD_ViewComponent_UU','4b5bdd59-db40-4ea7-ac22-8353ee8600fa','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:49','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:45:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202228 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,40,'N','N',210557,80,'Y',202229,'N','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Dictionary Entity Type; Determines ownership and synchronization','Entity Type','28945a60-4ac3-4172-ade3-d6984657a46f','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:50','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:45:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202229 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,22,'N','N',210563,90,'Y',202230,'N','The Database Table provides the information of the table definition','Database Table information','Table','5ad7a626-5ee1-4d80-afa1-0e45d81a55e7','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:51','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:45:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202230 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines,EntityType) VALUES ('N',200098,2000,'N','N',210565,100,'Y',202231,'N','Any other complete clause like GROUP BY, HAVING, ORDER BY, etc. after WHERE clause.','Other SQL Clause','Other SQL Clause','b2c3cf3b-a075-4e81-9298-755c61995155','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:52','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3,'D')
;

-- Jul 4, 2013 2:45:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202231 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,10,'N','N',210566,110,'Y',202232,'N','Referenced Table','675a739a-a525-476e-a457-9823381024ff','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:53','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:45:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202232 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,22,'N','N',210567,120,'Y',202233,'N','The Sequence indicates the order of records','Method of ordering records; lowest number comes first','Sequence','2c261cbb-bf1e-4001-bfb4-71cec49e172f','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:54','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:45:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202233 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines,EntityType) VALUES ('N',200098,2000,'N','N',210568,130,'Y',202234,'N','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".','Fully qualified SQL WHERE clause','Sql WHERE','bf3c78cc-f1db-4ef1-9e42-e9b052a37565','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:54','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3,'D')
;

-- Jul 4, 2013 2:45:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202234 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines,EntityType) VALUES ('N',200098,2000,'N','N',210569,140,'Y',202235,'N','The Select Clause indicates the SQL FROM clause to use for selecting the record for a measure calculation. It can have JOIN clauses. Do not include the FROM itself.','SQL FROM clause','Sql FROM','fbcae622-5e2a-48f9-91dc-2d35ac34f01e','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:55','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3,'D')
;

-- Jul 4, 2013 2:45:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202235 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:45:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,1,'N','N',210558,150,'Y',202236,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','baabcb3b-c9f9-4cd4-b579-67f7e7e8a610','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:45:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:45:56','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:45:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202236 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:46:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200087,210589,'N','N','N',0,'N',1,'N',28,'N','N','Y','a77c432c-7114-4fc6-9270-2210e7bab9bb','Y','Processing','Process Now','N',TO_TIMESTAMP('2013-07-04 14:46:50','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-04 14:46:50','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',524)
;

-- Jul 4, 2013 2:46:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210589 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 4, 2013 2:46:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
ALTER TABLE AD_ViewComponent ADD COLUMN Processing CHAR(1) DEFAULT NULL 
;

-- Jul 4, 2013 2:47:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET IsToolbarButton='N',Updated=TO_TIMESTAMP('2013-07-04 14:47:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210530
;

-- Jul 4, 2013 2:47:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200098,1,'N','N',210589,160,'Y',202237,'N','Process Now','02f4ba23-e03f-4aeb-ade4-3509b07be3eb','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:47:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:47:24','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:47:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202237 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202228
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202227
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202230
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202232
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202224
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202225
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202226
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202236
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202233
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202235
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202234
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202231
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202229
;

-- Jul 4, 2013 2:49:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=202237
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202230
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202232
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202224
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202225
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202226
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202236
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202233
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202235
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202234
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202231
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202229
;

-- Jul 4, 2013 2:50:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=202237
;

-- Jul 4, 2013 2:51:25 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 14:51:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202223
;

-- Jul 4, 2013 2:51:37 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-04 14:51:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202232
;

-- Jul 4, 2013 2:51:52 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-04 14:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202233
;

-- Jul 4, 2013 2:52:01 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y', XPosition=5,Updated=TO_TIMESTAMP('2013-07-04 14:52:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202237
;

-- Jul 4, 2013 2:52:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-07-04 14:52:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202229
;

-- Jul 4, 2013 2:53:03 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-07-04 14:53:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202224
;

-- Jul 4, 2013 2:55:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab (Processing,ImportFields,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,DisplayLogic,TabLevel,AD_Tab_UU,Name,AD_Tab_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('N','N','N',100,100,'N','N',200088,'N','N','N','Y','N','@IsView@=''Y''',2,'6266242f-3394-4b97-9366-f7215b259c74','View Column',200099,0,TO_TIMESTAMP('2013-07-04 14:55:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:55:46','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,'D')
;

-- Jul 4, 2013 2:55:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200099 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jul 4, 2013 2:56:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Tab SET AD_Column_ID=210584,Updated=TO_TIMESTAMP('2013-07-04 14:56:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200099
;

-- Jul 4, 2013 2:56:09 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,10,'N','N',210570,10,'Y',202238,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client/Tenant for this installation.','Client','ecdb057b-cce9-455f-9d2e-06880e677f81','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:09','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:56:09 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202238 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,IsAllowCopy,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,10,'N','N',210571,20,'Y',202239,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organizational entity within client','Organization','0efaea72-112a-4f78-bb07-51cad50340ff','Y','N','Y',100,0,TO_TIMESTAMP('2013-07-04 14:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:09','YYYY-MM-DD HH24:MI:SS'),'Y','N',4,0,2,'D')
;

-- Jul 4, 2013 2:56:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202239 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,255,'N','N',210577,30,'Y',202240,'N','A description is limited to 255 characters.','Optional short description of the record','Description','a49f4aba-a1f6-44d1-9669-a5631ef48e2e','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:10','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,'D')
;

-- Jul 4, 2013 2:56:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202240 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:12 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,NumLines,EntityType) VALUES ('N',200099,2000,'N','N',210587,40,'Y',202241,'N','The Help field contains a hint, comment or help about the use of this item.','Comment or Hint','Comment/Help','57112491-b212-4672-b16b-72359e4f4b6c','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:11','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,3,'D')
;

-- Jul 4, 2013 2:56:12 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202241 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,10,'N','N',210572,50,'Y',202242,'N','Database View Column','52208dbb-d7d5-4869-90b2-c6e3b8984894','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:12','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:56:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202242 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,36,'N','N',210573,60,'Y',202243,'N','AD_ViewColumn_UU','fbcc57be-6805-4eb7-95d3-bb706049807f','N','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:13','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 2:56:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202243 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,40,'N','N',210578,70,'Y',202244,'N','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Dictionary Entity Type; Determines ownership and synchronization','Entity Type','80a15d70-4808-4eff-8ff3-abc5a36150b8','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:13','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:56:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202244 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,10,'N','N',210584,80,'Y',202245,'N','Database View Component','302f0439-5fea-44b7-b67d-669a693044cb','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:14','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:56:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202245 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,30,'N','N',210585,90,'Y',202246,'N','The Column Name indicates the name of a column on a table as defined in the database.','Name of the column in the database','DB Column Name','3a5c8bce-3a0a-495a-a258-67e88a4241fc','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:15','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:56:16 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202246 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,255,'N','N',210586,100,'Y',202247,'N','You can define virtual columns (not stored in the database). If defined, the Column name is the synonym of the SQL expression defined here. The SQL expression must be valid.<br>
Example: "Updated-Created" would list the age of the entry in days','Virtual Column (r/o)','Column SQL','59d3843d-328b-4d30-8804-3f9ffc923529','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:16','YYYY-MM-DD HH24:MI:SS'),'Y',0,5,'D')
;

-- Jul 4, 2013 2:56:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202247 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,1,'N','N',210588,110,'Y',202248,'N','Database Data Type','f916fe88-ad43-47d9-9f31-1d95970b2dba','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:17','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 2:56:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202248 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:56:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200099,1,'N','N',210579,120,'Y',202249,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','The record is active in the system','Active','352abd0a-16f1-4e8d-884b-708172fc88b8','Y','N',100,0,TO_TIMESTAMP('2013-07-04 14:56:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 14:56:17','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 2:56:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202249 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202243
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202242
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=202245
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202246
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202247
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202240
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202241
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202249
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202244
;

-- Jul 4, 2013 2:57:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202248
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=202245
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202246
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202247
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202240
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202241
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202249
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202248
;

-- Jul 4, 2013 2:57:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202244
;

-- Jul 4, 2013 2:57:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202244
;

-- Jul 4, 2013 2:57:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202248
;

-- Jul 4, 2013 2:58:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 14:58:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202239
;

-- Jul 4, 2013 2:58:42 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=22, IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 14:58:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202247
;

-- Jul 4, 2013 2:58:43 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-07-04 14:58:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202246
;

-- Jul 4, 2013 2:59:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-07-04 14:59:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202247
;

-- Jul 4, 2013 2:59:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-07-04 14:59:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202244
;

-- Jul 4, 2013 2:59:56 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Tab SET AD_Column_ID=210563,Updated=TO_TIMESTAMP('2013-07-04 14:59:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200098
;

-- Jul 4, 2013 3:04:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process (Help,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,Description,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Value,Name,Classname,AD_Client_ID,EntityType) VALUES (NULL,200055,'N','N','29b63e30-e25b-49af-8d37-25dddf8ce4ac','4','N','N',9,7,'Y',NULL,0,TO_TIMESTAMP('2013-07-04 15:03:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 15:03:59','YYYY-MM-DD HH24:MI:SS'),'Y',100,'AD_TableIndex Validate','Index Validate','org.adempiere.process.IndexValidate',0,'D')
;

-- Jul 4, 2013 3:04:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200055 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jul 4, 2013 3:04:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process (AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Value,Name,Classname,AD_Client_ID,EntityType) VALUES (200056,'N','N','67e62e7b-2f5e-49b2-ae7d-234e42d4074f','4','N','N',9,7,'Y',0,TO_TIMESTAMP('2013-07-04 15:04:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 15:04:31','YYYY-MM-DD HH24:MI:SS'),'Y',100,'AD_ViewComponent Validate','View Validate','org.adempiere.process.ViewValidate',0,'D')
;

-- Jul 4, 2013 3:04:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200056 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jul 4, 2013 3:04:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET AD_Process_ID=200055,Updated=TO_TIMESTAMP('2013-07-04 15:04:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210530
;

-- Jul 4, 2013 3:05:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET AD_Process_ID=200056,Updated=TO_TIMESTAMP('2013-07-04 15:05:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210589
;

-- Jul 4, 2013 3:06:24 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process SET Classname='org.adempiere.process.DatabaseViewValidate',Updated=TO_TIMESTAMP('2013-07-04 15:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200056
;

-- Jul 4, 2013 3:06:34 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process SET Classname='org.adempiere.process.TableIndexValidate',Updated=TO_TIMESTAMP('2013-07-04 15:06:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200055
;

-- Jul 4, 2013 3:21:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200085,210590,'N','N','N',0,'N',22,'N',19,'N','N','Y','3eba565e-3cf6-4a25-9e8b-bdc6cc2dfa43','Y','AD_Message_ID','System Message','Information and Error messages','Message','Y',TO_TIMESTAMP('2013-07-04 15:21:09','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-04 15:21:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',1752)
;

-- Jul 4, 2013 3:21:11 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210590 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 4, 2013 3:21:14 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
ALTER TABLE AD_TableIndex ADD COLUMN AD_Message_ID NUMERIC(10) DEFAULT NULL 
;

-- Jul 4, 2013 3:21:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',200096,22,'N','N',210590,120,'Y',202250,'N','Information and Error messages','System Message','Message','333130b2-d182-4838-b16a-7465c925f944','Y','N',100,0,TO_TIMESTAMP('2013-07-04 15:21:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 15:21:25','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,'D')
;

-- Jul 4, 2013 3:21:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202250 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 3:21:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202250
;

-- Jul 4, 2013 3:21:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202206
;

-- Jul 4, 2013 3:21:31 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202210
;

-- Jul 4, 2013 3:21:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202250
;

-- Jul 4, 2013 3:21:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202206
;

-- Jul 4, 2013 3:21:36 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202210
;

-- Jul 4, 2013 3:21:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-07-04 15:21:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202250
;

-- Jul 4, 2013 3:21:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-07-04 15:21:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202209
;

-- Jul 4, 2013 3:21:59 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2013-07-04 15:21:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202250
;

-- Jul 4, 2013 3:22:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2013-07-04 15:22:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202209
;

-- Jul 4, 2013 3:23:05 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLogic='@IsUnique@=''Y''',Updated=TO_TIMESTAMP('2013-07-04 15:23:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202250
;

-- Jul 4, 2013 3:31:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-07-04 15:31:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202201
;

-- Jul 4, 2013 3:37:10 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-07-04 15:37:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202224
;

-- Jul 4, 2013 3:39:13 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=50,Updated=TO_TIMESTAMP('2013-07-04 15:39:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202224
;

-- Jul 4, 2013 3:39:59 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-07-04 15:39:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202216
;

-- Jul 4, 2013 5:02:08 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=202237
;

-- Jul 4, 2013 5:02:09 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Field WHERE AD_Field_ID=202237
;

-- Jul 4, 2013 5:02:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=210589
;

-- Jul 4, 2013 5:02:30 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
DELETE FROM AD_Column WHERE AD_Column_ID=210589
;

ALTER TABLE AD_ViewComponent DROP COLUMN Processing;

-- Jul 4, 2013 5:03:54 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Process_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,100,210591,'N','N','N',0,'N',1,'N',28,'N',200056,'N','Y','7b16c295-4c32-4812-955e-695a99d8724f','Y','Processing','Process Now','N',TO_TIMESTAMP('2013-07-04 17:03:53','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-07-04 17:03:53','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',524)
;

-- Jul 4, 2013 5:03:55 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210591 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 4, 2013 5:04:00 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
ALTER TABLE AD_Table ADD COLUMN Processing CHAR(1) DEFAULT NULL 
;

-- Jul 4, 2013 5:04:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',100,36,'N','N',60505,210,'Y',202251,'N','AD_Table_UU','ed7578a5-9743-4186-8e95-7b2f648cf9d9','N','N',100,0,TO_TIMESTAMP('2013-07-04 17:04:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 17:04:31','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,'D')
;

-- Jul 4, 2013 5:04:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202251 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 5:04:33 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,EntityType) VALUES ('N',100,1,'N','N',210591,220,'Y',202252,'N','Process Now','3c4978cb-1aaa-4d14-9f23-5d1b68e8e4ca','Y','N',100,0,TO_TIMESTAMP('2013-07-04 17:04:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-07-04 17:04:32','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,'D')
;

-- Jul 4, 2013 5:04:33 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202252 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 4, 2013 5:06:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202251
;

-- Jul 4, 2013 5:06:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=202252
;

-- Jul 4, 2013 5:06:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=251
;

-- Jul 4, 2013 5:06:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2004
;

-- Jul 4, 2013 5:06:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=149
;

-- Jul 4, 2013 5:06:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=143
;

-- Jul 4, 2013 5:06:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=144
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=145
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=246
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=4874
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=249
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=6554
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=7530
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=147
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=7531
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=253
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=3207
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=5125
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=5126
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=50157
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=58844
;

-- Jul 4, 2013 5:06:18 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=202252
;

-- Jul 4, 2013 5:06:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET DisplayLogic='@IsView@=''Y''',Updated=TO_TIMESTAMP('2013-07-04 17:06:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202252
;

-- Jul 4, 2013 5:08:41 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsCentrallyMaintained='N', Name='View Validate',Updated=TO_TIMESTAMP('2013-07-04 17:08:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202252
;

-- Jul 4, 2013 5:08:57 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsCentrallyMaintained='N', Name='Index Validate',Updated=TO_TIMESTAMP('2013-07-04 17:08:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202210
;

-- Jul 5, 2013 11:30:17 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field_Trl SET Name='View Validate',Updated=TO_TIMESTAMP('2013-07-05 11:30:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202252 AND AD_Language='en_US'
;

-- Jul 5, 2013 11:31:34 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field_Trl SET Name='View Validate',Updated=TO_TIMESTAMP('2013-07-05 11:31:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202252 AND AD_Language='es_CO'
;

-- Jul 5, 2013 11:32:05 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field_Trl SET Name='Index Validate',Updated=TO_TIMESTAMP('2013-07-05 11:32:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202210 AND AD_Language='es_CO'
;

-- Jul 5, 2013 11:32:08 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field_Trl SET Name='Index Validate',Updated=TO_TIMESTAMP('2013-07-05 11:32:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202210 AND AD_Language='en_US'
;

-- Jul 5, 2013 11:36:26 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:36:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202199
;

-- Jul 5, 2013 11:36:30 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:36:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202200
;

-- Jul 5, 2013 11:38:08 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:38:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202212
;

-- Jul 5, 2013 11:38:11 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:38:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202213
;

-- Jul 5, 2013 11:41:26 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:41:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202222
;

-- Jul 5, 2013 11:41:28 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:41:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202223
;

-- Jul 5, 2013 11:41:33 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:41:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202238
;

-- Jul 5, 2013 11:41:35 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2013-07-05 11:41:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202239
;

-- Jul 5, 2013 11:44:36 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process SET Classname='org.compiere.process.TableIndexValidate',Updated=TO_TIMESTAMP('2013-07-05 11:44:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200055
;

-- Jul 5, 2013 11:44:54 AM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Process SET Classname='org.compiere.process.DatabaseViewValidate',Updated=TO_TIMESTAMP('2013-07-05 11:44:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200056
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=202224
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=202225
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=202226
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=202236
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=202233
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=202235
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=202234
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202231
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202229
;

-- Jul 5, 2013 12:19:20 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=202232
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=202224
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=202225
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=202226
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=202236
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=202233
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=202235
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=202234
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=202231
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=202229
;

-- Jul 5, 2013 12:19:27 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202232
;

-- Jul 5, 2013 12:22:03 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-07-05 12:22:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210569
;

-- Jul 5, 2013 12:22:08 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO t_alter_column values('ad_viewcomponent','FromClause','VARCHAR(2000)',null,null)
;

-- Jul 5, 2013 12:22:09 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO t_alter_column values('ad_viewcomponent','FromClause',null,'NOT NULL',null)
;

-- Jul 5, 2013 12:27:50 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2013-07-05 12:27:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210585
;

-- Jul 5, 2013 12:27:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO t_alter_column values('ad_viewcolumn','ColumnName','VARCHAR(30)',null,null)
;

-- Jul 5, 2013 12:27:53 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO t_alter_column values('ad_viewcolumn','ColumnName',null,'NOT NULL',null)
;

-- Jul 5, 2013 12:34:32 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-07-05 12:34:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202248
;

-- Jul 5, 2013 1:47:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','Neither index nor unique constraint with {0}',200187,'db0b6f21-0857-4be3-b0fa-456c92576ce5','NeitherTableIndexNorUniqueConstraint','Y',TO_TIMESTAMP('2013-07-05 13:47:43','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:47:43','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:47:45 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200187 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:49:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','Not an active database view',200188,'c677c807-5716-4c60-bd5b-2e09e610ac2e','NotActiveDatabaseView','Y',TO_TIMESTAMP('2013-07-05 13:49:14','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:49:14','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:49:15 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200188 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:50:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','No view components specified',200189,'cca691b2-4cfc-449f-9d0d-ab62645a79f0','NoViewComponentsSpecified','Y',TO_TIMESTAMP('2013-07-05 13:50:06','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:50:06','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:50:07 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200189 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:50:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','No view columns specified',200190,'7a091fa4-b7ab-4efa-9818-42603f6a085e','NoViewColumnsSpecified','Y',TO_TIMESTAMP('2013-07-05 13:50:43','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:50:43','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:50:44 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200190 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:51:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','Failed to create or replace view',200191,'3bd592bb-6282-407c-b27b-d310ecfb2ca1','FailedCreateOrReplaceView','Y',TO_TIMESTAMP('2013-07-05 13:51:22','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:51:22','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:51:23 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200191 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:52:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('I','Created or replaced view successfully',200192,'cacc12a6-47ff-4fe8-b249-e4f0e919cc9e','CreatedOrReplacedViewSuccess','Y',TO_TIMESTAMP('2013-07-05 13:52:01','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:52:01','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:52:02 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200192 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:52:59 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','No index columns specified',200194,'2e33e1e8-ce51-482b-b843-c89b4dab1ef9','NoIndexColumnsSpecified','Y',TO_TIMESTAMP('2013-07-05 13:52:59','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:52:59','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:52:59 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200194 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:55:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','Failed to create index',200195,'dc4a13c5-1636-4053-9706-cf16f51127eb','FailedCreateIndex','Y',TO_TIMESTAMP('2013-07-05 13:55:46','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:55:46','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:55:47 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200195 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:56:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('I','Created index succesfully',200196,'ffd25dfd-2529-4383-a6ac-1d244b720abe','CreatedIndexSuccess','Y',TO_TIMESTAMP('2013-07-05 13:56:25','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:56:25','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:56:26 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200196 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:57:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('E','Failed to modify index',200197,'2412e6f5-f640-40e5-98e8-7a0cfc3d1470','FailedModifyIndex','Y',TO_TIMESTAMP('2013-07-05 13:57:16','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:57:16','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:57:17 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200197 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:57:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('I','Modified index successfully',200198,'40f6581e-afa2-4361-8c90-c76ccb31b76d','ModifiedIndexSuccess','Y',TO_TIMESTAMP('2013-07-05 13:57:51','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:57:51','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:57:51 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200198 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 5, 2013 1:58:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,AD_Org_ID,AD_Client_ID,EntityType) VALUES ('I','No changes to the index',200199,'8d81c780-91b3-46a8-99c3-055a81b0ae15','NoChangesToIndex','Y',TO_TIMESTAMP('2013-07-05 13:58:28','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-07-05 13:58:28','YYYY-MM-DD HH24:MI:SS'),0,0,'D')
;

-- Jul 5, 2013 1:58:28 PM SGT
-- IDEMPIERE-1132 Improve AD_Index; AD_View; foreign keys management
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200199 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201307051404_IDEMPIERE-1132.sql') FROM dual
;
