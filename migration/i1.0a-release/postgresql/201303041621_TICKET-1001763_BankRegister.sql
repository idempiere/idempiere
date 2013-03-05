-- Mar 1, 2013 12:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','4',0,200070,'N','N','N','D','L','056ac053-9bfe-418e-b853-c5bc786bb13d','Y','Y','T_BankRegister','Bank Register',0,'Y',0,TO_TIMESTAMP('2013-03-01 12:13:23','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-03-01 12:13:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 1, 2013 12:13:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 1, 2013 12:13:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200065,'0fa01ed9-afaa-495b-bfad-0b07a31c5ef1','Table T_BankRegister','T_BankRegister',1,0,0,TO_TIMESTAMP('2013-03-01 12:13:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-01 12:13:27','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Mar 1, 2013 12:14:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208705,'D','Y','N','N','N',22,'N',19,129,'N',102,'N','Y','d8581197-a7d9-4b73-87b8-eb9d9e13412d','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2013-03-01 12:13:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:13:59','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208705 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208706,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','fcc8b867-b51d-443d-8547-5c23c16d49b3','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2013-03-01 12:14:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:01','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208706 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('T_BankRegister_ID',202252,'D','Bank Register','Bank Register','73b6821f-cacd-4b95-8989-fdd4db810c18',0,TO_TIMESTAMP('2013-03-01 12:14:02','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-01 12:14:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 12:14:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202252 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 12:14:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208707,'D','Y','N','N','N',22,'N',13,'Y',202252,'N','Y','380a9f61-f43d-47d9-ba43-c363c3bd7190','N','T_BankRegister_ID','Bank Register','N',100,TO_TIMESTAMP('2013-03-01 12:14:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:02','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208707 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('T_BankRegister_UU',202253,'D','T_BankRegister_UU','T_BankRegister_UU','dd68c280-981a-47fa-9d3f-e1bda934a2f7',0,TO_TIMESTAMP('2013-03-01 12:14:04','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-01 12:14:04','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 12:14:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202253 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 12:14:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1.00,'N',200070,208708,'D','N','N','N','N',36,'N',10,'N',202253,'N','Y','3f3a42a2-2ad2-4756-afcd-2993c96e7987','Y','T_BankRegister_UU','T_BankRegister_UU','N',100,TO_TIMESTAMP('2013-03-01 12:14:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208708 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208709,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','a1b905d6-7cd8-4ed0-8a59-3ec5d3d35b58','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2013-03-01 12:14:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208709 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208710,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','d1335a32-f622-4024-a68e-6e641b241f62','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2013-03-01 12:14:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:06','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208710 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208711,'D','N','N','N','N',255,'Y',10,'N',275,'N','Y','d1490e91-db2d-49c9-8cd8-1297bed95ac5','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_TIMESTAMP('2013-03-01 12:14:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208711 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208712,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','94491fa5-7db6-4dec-b314-a9688bee7448','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2013-03-01 12:14:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208712 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208713,'D','Y','N','Y',1,'N',60,'Y',10,'N',469,'N','Y','b564aaea-00f3-4e95-8b54-92fc429773fa','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_TIMESTAMP('2013-03-01 12:14:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208713 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208714,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','f48e0d0d-f6b6-4480-9c9f-d0c23b0c444f','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2013-03-01 12:14:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208714 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:14:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200070,208715,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','0d92d81c-275b-4a41-850e-9cc0de1fcb6e','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2013-03-01 12:14:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:14:10','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 1, 2013 12:14:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208715 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:15:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208709
;

-- Mar 1, 2013 12:15:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208709
;

-- Mar 1, 2013 12:15:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208710
;

-- Mar 1, 2013 12:15:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208710
;

-- Mar 1, 2013 12:15:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208711
;

-- Mar 1, 2013 12:15:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208711
;

-- Mar 1, 2013 12:15:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208712
;

-- Mar 1, 2013 12:15:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208712
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208713
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208713
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208707
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208707
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208708
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208708
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208714
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208714
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208715
;

-- Mar 1, 2013 12:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208715
;

-- Mar 1, 2013 12:16:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208716,'D','N','N','N',0,'N',255,'N',10,'N',53376,'N','Y','e49931b5-c130-4b1f-a8be-e565ea53bd02','Y','Account','Account','Y',100,TO_TIMESTAMP('2013-03-01 12:16:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:16:06','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:16:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208716 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:16:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208717,'D','Y','N','N',0,'N',10,'N',19,'N',114,'N','Y','b9c60eff-b0e6-4a78-80f8-df80af14022b','Y','AD_PInstance_ID','Instance of the process','Process Instance','Y',100,TO_TIMESTAMP('2013-03-01 12:16:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:16:56','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:16:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208717 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:17:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208718,'D','N','N','N',0,'N',14,'N',12,'N',161,'N','Y','a228827f-3770-488c-80e3-1ab73c5734e5','Y','AmtAcctCr','Accounted Credit Amount','The Account Credit Amount indicates the transaction amount converted to this organization''s accounting currency','Accounted Credit','Y',100,TO_TIMESTAMP('2013-03-01 12:17:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:17:28','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:17:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208718 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:17:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208719,'D','N','N','N',0,'N',14,'N',12,'N',162,'N','Y','bc3f8bdc-d233-4544-a3fc-c8bf0d046e6e','Y','AmtAcctDr','Accounted Debit Amount','The Account Debit Amount indicates the transaction amount converted to this organization''s accounting currency','Accounted Debit','Y',100,TO_TIMESTAMP('2013-03-01 12:17:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:17:55','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:17:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208719 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:18:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208720,'D','N','N','N',0,'N',14,'N',22,'N',1986,'N','Y','8ef7f56e-284e-4fc7-91e1-301f759eb235','Y','Balance','Balance','Y',100,TO_TIMESTAMP('2013-03-01 12:18:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:18:36','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:18:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208720 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:19:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208721,'D','N','N','N',0,'N',255,'N',10,'N',52002,'N','Y','ed795859-4509-41fa-92c0-fae0c18c3030','Y','BankName','Bank Name','Y',100,TO_TIMESTAMP('2013-03-01 12:19:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:19:08','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:19:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208721 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:19:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('BPartner',202254,'D','Business Partner','Business Partner','c8d7e6c2-0b7c-466d-a99d-9f4597270888',0,TO_TIMESTAMP('2013-03-01 12:19:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-01 12:19:44','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Mar 1, 2013 12:19:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202254 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 1, 2013 12:20:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208722,'D','N','N','N',0,'N',255,'N',10,'N',202254,'N','Y','5e301a06-906c-40f0-8eac-e17b3cdda13a','Y','BPartner','Business Partner','Y',100,TO_TIMESTAMP('2013-03-01 12:20:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:20:05','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:20:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208722 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:20:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208723,'D','N','N','N',0,'N',10,'N',19,'N',835,'N','Y','fe2c8b78-da6b-4092-8339-d52696c932e4','Y','C_Bank_ID','Bank','The Bank is a unique identifier of a Bank for this Organization or for a Business Partner with whom this Organization transacts.','Bank','Y',100,TO_TIMESTAMP('2013-03-01 12:20:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:20:38','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:20:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208723 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:21:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208724,'D','N','N','N',0,'N',10,'N',19,'N',187,'N','Y','599f8306-bea2-41ff-984e-d3a438e44122','Y','C_BPartner_ID','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Business Partner ','Y',100,TO_TIMESTAMP('2013-03-01 12:21:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:21:08','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:21:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208724 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:21:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208725,'D','N','N','N',0,'N',7,'N',15,'N',263,'N','Y','f8998d88-9970-48df-9cb1-3d1292a9b4c5','Y','DateAcct','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.','Account Date','Y',100,TO_TIMESTAMP('2013-03-01 12:21:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:21:32','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:21:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208725 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:22:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200070,208726,'D','N','N','N',0,'N',255,'N',10,'N',290,'N','Y','69152f34-2da2-4cc0-862f-7c4189e77d8f','Y','DocumentNo','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Document No','Y',100,TO_TIMESTAMP('2013-03-01 12:22:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-03-01 12:22:11','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Mar 1, 2013 12:22:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208726 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 1, 2013 12:26:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
CREATE TABLE T_BankRegister (Account VARCHAR(255) DEFAULT NULL , AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_PInstance_ID NUMERIC(10) NOT NULL, AmtAcctCr NUMERIC DEFAULT NULL , AmtAcctDr NUMERIC DEFAULT NULL , Balance NUMERIC DEFAULT NULL , BankName VARCHAR(255) DEFAULT NULL , BPartner VARCHAR(255) DEFAULT NULL , C_Bank_ID NUMERIC(10) DEFAULT NULL , C_BPartner_ID NUMERIC(10) DEFAULT NULL , DateAcct TIMESTAMP DEFAULT NULL , DocumentNo VARCHAR(255) DEFAULT NULL )
;

-- Mar 1, 2013 12:27:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormat (CreateCopy,IsForm,IsDefault,AD_PrintFormat_ID,IsStandardHeaderFooter,AD_PrintPaper_ID,AD_PrintColor_ID,AD_PrintTableFormat_ID,IsTableBased,AD_Table_ID,HeaderMargin,AD_PrintFont_ID,AD_PrintFormat_UU,FooterMargin,Name,Updated,CreatedBy,Created,UpdatedBy,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('N','N','N',200003,'Y',100,100,100,'Y',200070,0,130,'ae17352f-3b58-4771-837a-40f87d88c0ca',0,'Bank Register Report',TO_TIMESTAMP('2013-03-01 12:27:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-01 12:27:10','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0)
;

-- Mar 1, 2013 12:27:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET AD_PrintPaper_ID=100, AD_PrintColor_ID=100, AD_Table_ID=200070, AD_PrintFont_ID=130, Name='Bank Register_2',Updated=TO_TIMESTAMP('2013-03-01 12:27:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200003
;

-- Mar 1, 2013 12:27:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account',0,'N','Y','C',200003,'N',0,'F','N',1,208716,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Account',0,'N','113ed988-6424-4f34-a72c-30d1e340c40e',0,200126,'N',0,TO_TIMESTAMP('2013-03-01 12:27:23','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:23','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200126 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208716) WHERE AD_PrintFormatItem_ID = 200126 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208716 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200126) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Account Date',0,'N','Y','C',200003,'N',0,'F','N',2,208725,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Acct Date',0,'N','18b91a0a-1335-460b-9cdf-4530451e41ca',0,200127,'N',0,TO_TIMESTAMP('2013-03-01 12:27:25','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:25','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200127 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208725) WHERE AD_PrintFormatItem_ID = 200127 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208725 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200127) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Accounted Credit',0,'N','Y','C',200003,'N',0,'F','N',3,208718,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Acct Credit',0,'N','d3b49d5b-c669-4337-adc5-79a8ebc2301d',0,200128,'N',0,TO_TIMESTAMP('2013-03-01 12:27:27','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:27','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200128 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208718) WHERE AD_PrintFormatItem_ID = 200128 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208718 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200128) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Accounted Debit',0,'N','Y','C',200003,'N',0,'F','N',4,208719,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Acct Debit',0,'N','208fb750-11ec-4190-b718-e93d1c8061e5',0,200129,'N',0,TO_TIMESTAMP('2013-03-01 12:27:28','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:28','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200129 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208719) WHERE AD_PrintFormatItem_ID = 200129 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208719 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200129) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Balance',0,'N','Y','C',200003,'N',0,'F','N',5,208720,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Balance',0,'N','2e94bab6-2aeb-40f0-92d7-a884411cdb9f',0,200130,'N',0,TO_TIMESTAMP('2013-03-01 12:27:29','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:29','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200130 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208720) WHERE AD_PrintFormatItem_ID = 200130 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208720 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200130) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Bank',0,'N','Y','C',200003,'N',0,'F','N',6,208723,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Bank',0,'N','141eccb4-5315-4762-bd58-b4a5fdb48e74',0,200131,'N',0,TO_TIMESTAMP('2013-03-01 12:27:30','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:30','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200131 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208723) WHERE AD_PrintFormatItem_ID = 200131 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208723 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200131) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Bank Name',0,'N','Y','C',200003,'N',0,'F','N',7,208721,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Bank Name',0,'N','fc869b0c-2dab-4ac6-aed7-121ca9b62cad',0,200132,'N',0,TO_TIMESTAMP('2013-03-01 12:27:30','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:30','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200132 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208721) WHERE AD_PrintFormatItem_ID = 200132 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208721 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200132) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Business Partner',0,'N','Y','C',200003,'N',0,'F','N',8,208722,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Business Partner',0,'N','2ad953c8-379a-4d99-9bae-b50c09b3499e',0,200133,'N',0,TO_TIMESTAMP('2013-03-01 12:27:31','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:31','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200133 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208722) WHERE AD_PrintFormatItem_ID = 200133 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208722 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200133) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Business Partner ',0,'N','Y','C',200003,'N',0,'F','N',9,208724,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Business Partner ',0,'N','860444b7-8b81-432e-b6d8-cfdaa6ce70bf',0,200134,'N',0,TO_TIMESTAMP('2013-03-01 12:27:32','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:32','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200134 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208724) WHERE AD_PrintFormatItem_ID = 200134 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208724 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200134) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Document No',0,'N','Y','C',200003,'N',0,'F','N',10,208726,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Document No',0,'N','ad917736-2b40-4ae6-90a8-4f782c9d1930',0,200135,'N',0,TO_TIMESTAMP('2013-03-01 12:27:33','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:33','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200135 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208726) WHERE AD_PrintFormatItem_ID = 200135 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208726 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200135) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Process Instance',0,'N','Y','C',200003,'N',0,'F','N',11,208717,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Process Instance',0,'N','78a7220b-696f-4551-9418-642636ff89c2',0,200136,'N',0,TO_TIMESTAMP('2013-03-01 12:27:34','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:34','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200136 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208717) WHERE AD_PrintFormatItem_ID = 200136 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208717 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200136) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Client',0,'N','N','C',200003,'N',0,'F','N',0,208705,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Client',0,'N','f8bdb97d-daa7-4e33-9876-436d55127902',0,200137,'N',0,TO_TIMESTAMP('2013-03-01 12:27:34','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:34','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200137 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208705) WHERE AD_PrintFormatItem_ID = 200137 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208705 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200137) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Organization',0,'N','N','C',200003,'N',0,'F','N',0,208706,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Organization',0,'N','3fed5bed-5483-4587-8317-8611da138896',0,200138,'N',0,TO_TIMESTAMP('2013-03-01 12:27:35','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:27:35','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Mar 1, 2013 12:27:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200138 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:27:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208706) WHERE AD_PrintFormatItem_ID = 200138 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208706 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200138) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:27:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET Name='Bank Register Report',Updated=TO_TIMESTAMP('2013-03-01 12:27:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200003
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200126
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200131
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200136
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=10,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200132
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=20,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200133
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=30,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200134
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=40,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200135
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=50,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200127
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=60,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200128
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=70,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200129
;

-- Mar 1, 2013 12:28:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=80,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200130
;

-- Mar 1, 2013 12:28:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200134
;

-- Mar 1, 2013 12:28:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=30,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200135
;

-- Mar 1, 2013 12:28:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=40,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200127
;

-- Mar 1, 2013 12:28:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=50,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200128
;

-- Mar 1, 2013 12:28:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=60,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200129
;

-- Mar 1, 2013 12:28:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=70,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200130
;

-- Mar 1, 2013 12:29:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SortNo=10,IsOrderBy='Y' WHERE AD_PrintFormatItem_ID=200127
;

-- Mar 1, 2013 12:29:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SortNo=20,IsOrderBy='Y' WHERE AD_PrintFormatItem_ID=200135
;

-- Mar 1, 2013 12:29:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, MaxWidth=144,Updated=TO_TIMESTAMP('2013-03-01 12:29:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200133
;

-- Mar 1, 2013 12:29:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, YPosition=0, MaxWidth=108,Updated=TO_TIMESTAMP('2013-03-01 12:29:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200135
;

-- Mar 1, 2013 12:29:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSummarized='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-03-01 12:29:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200130
;

-- Mar 1, 2013 12:29:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSummarized='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-03-01 12:29:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200129
;

-- Mar 1, 2013 12:30:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSummarized='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-03-01 12:30:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200128
;

-- Mar 1, 2013 12:31:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_ReportView (AD_ReportView_UU,AD_Table_ID,AD_ReportView_ID,EntityType,Name,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Org_ID,IsActive) VALUES ('863599ca-4cb8-4e07-b76e-db54f4ed5a8d',200070,200001,'D','T_BankRegister',0,TO_TIMESTAMP('2013-03-01 12:31:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-01 12:31:57','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Mar 1, 2013 12:33:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormat (CreateCopy,IsForm,IsDefault,AD_PrintFormat_ID,IsStandardHeaderFooter,AD_ReportView_ID,AD_PrintPaper_ID,AD_PrintColor_ID,AD_PrintTableFormat_ID,IsTableBased,AD_Table_ID,HeaderMargin,AD_PrintFont_ID,AD_PrintFormat_UU,FooterMargin,Name,Updated,CreatedBy,Created,UpdatedBy,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('N','N','N',200005,'Y',200001,100,100,100,'Y',200070,0,130,'b94fc032-5fd2-44e8-a425-d1a141bf685c',0,'Bank Register Report 2',TO_TIMESTAMP('2013-03-01 12:33:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-01 12:33:44','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0)
;

-- Mar 1, 2013 12:33:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET CreateCopy='N', IsForm='N', IsDefault='N', IsStandardHeaderFooter='Y', AD_PrintPaper_ID=100, AD_PrintColor_ID=100, AD_PrintTableFormat_ID=100, IsTableBased='Y', AD_Table_ID=200070, HeaderMargin=0, AD_PrintFont_ID=130, FooterMargin=0, Name='Bank Register Report &Copy Record 42',Updated=TO_TIMESTAMP('2013-03-01 12:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200005
;

-- Mar 1, 2013 12:33:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Organization',0,'N','N','C',200005,'N',0,'F','N',0,208706,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Organization',0,'N','ef9c141e-8d3d-43a7-8b53-2c067733137c',0,200139,'N',0,TO_TIMESTAMP('2013-03-01 12:33:54','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:33:54','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:33:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200139 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:33:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208706) WHERE AD_PrintFormatItem_ID = 200139 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208706 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200139) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:33:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Client',0,'N','N','C',200005,'N',0,'F','N',0,208705,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Client',0,'N','d3964417-c89f-480f-94b8-ff16526175f3',0,200140,'N',0,TO_TIMESTAMP('2013-03-01 12:33:55','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:33:55','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:33:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200140 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:33:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208705) WHERE AD_PrintFormatItem_ID = 200140 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208705 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200140) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Process Instance',0,'N','N','C',200005,'N',0,'F','N',0,208717,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Process Instance',0,'N','28f3334d-99bd-49b8-9686-1c6520b5c6ee',0,200141,'N',0,TO_TIMESTAMP('2013-03-01 12:33:56','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:33:56','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200141 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208717) WHERE AD_PrintFormatItem_ID = 200141 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208717 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200141) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Business Partner ',0,'N','N','C',200005,'N',0,'F','N',0,208724,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Business Partner ',0,'N','b7ba8149-8503-45d0-8d9f-0bc0bf462551',0,200142,'N',0,TO_TIMESTAMP('2013-03-01 12:33:57','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:33:57','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200142 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208724) WHERE AD_PrintFormatItem_ID = 200142 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208724 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200142) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Bank',0,'N','N','C',200005,'N',0,'F','N',0,208723,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Bank',0,'N','ea6c446a-99ff-436c-a78c-aecc28721c33',0,200143,'N',0,TO_TIMESTAMP('2013-03-01 12:33:57','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:33:57','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200143 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208723) WHERE AD_PrintFormatItem_ID = 200143 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208723 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200143) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:33:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Account',0,'N','N','C',200005,'N',0,'F','N',0,208716,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Account',0,'N','d77d51c3-ae0a-47a3-b2e8-39b6aec5c74c',0,200144,'N',0,TO_TIMESTAMP('2013-03-01 12:33:58','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:33:58','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200144 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208716) WHERE AD_PrintFormatItem_ID = 200144 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208716 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200144) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Bank Name',0,'N','Y','C',200005,'N',0,'F','N',10,208721,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Bank Name',0,'N','84424a2f-f767-4a62-b508-c604f5ec8d66',0,200145,'N',0,TO_TIMESTAMP('2013-03-01 12:34:01','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:34:01','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200145 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208721) WHERE AD_PrintFormatItem_ID = 200145 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208721 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200145) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Business Partner',0,'N','Y','C',200005,'N',0,'F','N',20,208722,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Business Partner',0,'N','01e59d1e-abf6-4f49-8166-c5930874d34f',0,200146,'N',144,TO_TIMESTAMP('2013-03-01 12:34:01','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:34:01','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200146 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208722) WHERE AD_PrintFormatItem_ID = 200146 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208722 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200146) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Document No',0,'Y','Y','C',200005,'N',0,'F','N',30,208726,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Document No',20,'N','46ead6ea-1925-43ac-8b06-dc8862e32dc4',0,200147,'N',108,TO_TIMESTAMP('2013-03-01 12:34:02','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:34:02','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200147 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208726) WHERE AD_PrintFormatItem_ID = 200147 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208726 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200147) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Account Date',0,'Y','Y','C',200005,'N',0,'F','N',40,208725,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','N','Acct Date',10,'N','1d6d09e4-47fa-4cf8-8e18-37daae4d7639',0,200148,'N',0,TO_TIMESTAMP('2013-03-01 12:34:03','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:34:03','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200148 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208725) WHERE AD_PrintFormatItem_ID = 200148 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208725 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200148) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Accounted Credit',0,'N','Y','C',200005,'N',0,'F','N',50,208718,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','Y','N','N','N','N','Acct Credit',0,'N','ff6dd747-7092-4e40-8744-22fc45c46576',0,200149,'N',0,TO_TIMESTAMP('2013-03-01 12:34:04','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:34:04','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200149 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208718) WHERE AD_PrintFormatItem_ID = 200149 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208718 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200149) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Accounted Debit',0,'N','Y','C',200005,'N',0,'F','N',60,208719,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','Y','N','N','N','N','Acct Debit',0,'N','195446d9-ff37-4bb4-add8-0922748608da',0,200150,'N',0,TO_TIMESTAMP('2013-03-01 12:34:04','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:34:04','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200150 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208719) WHERE AD_PrintFormatItem_ID = 200150 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208719 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200150) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsSuppressRepeats,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive,IsDesc) VALUES ('Balance',0,'N','Y','C',200005,'N',0,'F','N',70,208720,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','Y','N','N','N','N','Balance',0,'N','810c3421-ed5f-4d64-8583-f9b2e7024112',0,200151,'N',0,TO_TIMESTAMP('2013-03-01 12:34:05','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-03-01 12:34:05','YYYY-MM-DD HH24:MI:SS'),0,'Y','N')
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200151 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208720) WHERE AD_PrintFormatItem_ID = 200151 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208720 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200151) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200138 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200139 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200138)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200137 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200140 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200137)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200136 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200141 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200136)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200134 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200142 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200134)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200131 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200143 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200131)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200126 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200144 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200126)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200132 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200145 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200132)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200133 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200146 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200133)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200135 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200147 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200135)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200127 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200148 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200127)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200128 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200149 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200128)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200129 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200150 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200129)
;

-- Mar 1, 2013 12:34:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName="old".PrintName,PrintNameSuffix="old".PrintNameSuffix,IsTranslated="old".IsTranslated FROM AD_PrintFormatItem_Trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND "old".AD_PrintFormatItem_ID =200130 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID=200151 AND EXISTS (SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem_trl "old" WHERE "old".AD_Language=AD_PrintFormatItem_Trl.AD_Language AND AD_PrintFormatItem_ID =200130)
;

-- Mar 1, 2013 12:34:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_PrintFormat WHERE AD_PrintFormat_ID=200003
;

-- Mar 1, 2013 12:34:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET Name='Bank Register Report',Updated=TO_TIMESTAMP('2013-03-01 12:34:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200005
;

-- Mar 1, 2013 12:35:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,AD_ReportView_ID,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',200035,'N',200001,'Y','860657cd-af9b-4c98-9f96-3909deba4f54','1','N','N',0,0,'Y','D','org.compiere.report.BankRegister','Bank Register Report','BankRegister',0,0,TO_TIMESTAMP('2013-03-01 12:35:38','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-03-01 12:35:38','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Mar 1, 2013 12:35:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200035 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Mar 1, 2013 12:36:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',835,200052,'c3d74841-8b65-42e4-9fbf-19f56c5ca316','The Bank is a unique identifier of a Bank for this Organization or for a Business Partner with whom this Organization transacts.',200035,19,'Y','D','Bank','C_Bank_ID','Bank',0,'Y',10,'Y',100,TO_TIMESTAMP('2013-03-01 12:36:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-01 12:36:09','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 12:36:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200052 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 12:37:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',263,200053,'87de0151-1900-47dc-b22a-5be1ceba19d4','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200035,15,'N','D','Account Date','DateAcct','Accounting Date',0,'Y',20,'SELECT StartDate FROM C_Period  WHERE C_Year_ID IN (SELECT p.C_Year_ID FROM AD_ClientInfo c INNER JOIN C_Year y ON (c.C_Calendar_ID=y.C_Calendar_ID) INNER JOIN C_Period p ON (y.C_Year_ID=p.C_Year_ID)  WHERE c.AD_Client_ID=@#AD_Client_ID@ AND getdate() BETWEEN StartDate AND EndDate) AND IsActive=''Y'' AND PeriodType=''S'' AND periodNo = 1','Y',100,TO_TIMESTAMP('2013-03-01 12:37:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-01 12:37:11','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 12:37:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200053 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 12:37:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',187,200054,'989c092f-6384-488b-bfd3-b040cb114a10','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200035,30,'N','D','Business Partner ','C_BPartner_ID','Identifies a Business Partner',0,'Y',30,'Y',100,TO_TIMESTAMP('2013-03-01 12:37:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-03-01 12:37:37','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 1, 2013 12:37:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200054 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 1, 2013 12:38:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,"action",IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200043,'N','N','N',200035,'D','37e1bf78-0c58-4cc3-80ba-8c2d8dcf5e17','Y','Bank Register Report','R','Y',0,100,TO_TIMESTAMP('2013-03-01 12:38:31','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-03-01 12:38:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 1, 2013 12:38:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200043 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 1, 2013 12:38:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200043, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200043)
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200043
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=31, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200042
;

-- Mar 1, 2013 12:38:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=32, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Mar 5, 2013 4:01:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET IsRange='Y',Updated=TO_TIMESTAMP('2013-03-05 16:01:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200053
;

SELECT register_migration_script('201303041621_TICKET-1001763_BankRegister.sql') FROM dual
;