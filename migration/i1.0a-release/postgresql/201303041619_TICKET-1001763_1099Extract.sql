-- Feb 28, 2013 5:11:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200067,'N','N','N','D','L','b7e5140c-ab39-458b-a41f-e4153099ea31','Y','Y','T_1099EXTRACT','1099 Extract',0,'Y',0,TO_TIMESTAMP('2013-02-28 17:11:23','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-02-28 17:11:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 28, 2013 5:11:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Feb 28, 2013 5:11:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200062,'81ceacea-ec37-4fdc-bf07-3e23825847f0','Table T_1099EXTRACT','T_1099EXTRACT',1,0,0,TO_TIMESTAMP('2013-02-28 17:11:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-02-28 17:11:25','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Feb 28, 2013 5:14:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208612,'D','Y','N','N','N',22,'N',19,129,'N',102,'N','Y','64e0933a-ee44-4792-b4f4-a81c48fcb62f','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2013-02-28 17:14:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:14','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208612 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208613,'D','N','N','N','N',22,'N',19,104,'N',113,'N','Y','2371e4ab-9651-4548-8bc3-72785066de20','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2013-02-28 17:14:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208613 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208614,'D','Y','N','N','N',22,'N',19,'N',114,'N','Y','8c02bdb7-52f4-4ef5-9e72-4f79d34efb39','N','AD_PInstance_ID','Instance of the process','Process Instance','Y',100,TO_TIMESTAMP('2013-02-28 17:14:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208614 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208615,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','ca699748-dda5-48ac-a1f5-0dc60248b961','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2013-02-28 17:14:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208615 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208616,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','222c0cc8-8da4-41ba-82bf-348e357d5c3e','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2013-02-28 17:14:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208616 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208617,'D','Y','N','N','N',22,'N',13,'N',885,'N','Y','f6d03f2c-05f6-4dda-9303-bc7c61126236','N','Fact_Acct_ID','Accounting Fact','Y',100,TO_TIMESTAMP('2013-02-28 17:14:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208617 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'Y',200067,208618,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','8e584bb3-f5d6-432e-9043-3095cedca362','Y','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2013-02-28 17:14:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:29','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208618 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'Y',200067,208619,'D','N','N','N','N',60,'N',10,'N',54274,'N','Y','ae996471-7891-418e-b0bd-d0aee1efdb1f','Y','MatchCode','String identifying related accounting facts','Match Code','Y',100,TO_TIMESTAMP('2013-02-28 17:14:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208619 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('T_1099EXTRACT_UU',202222,'D','T_1099EXTRACT_UU','T_1099EXTRACT_UU','0847dcfe-2de6-42ad-bb09-a8cfa45b76c7',0,TO_TIMESTAMP('2013-02-28 17:14:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:14:31','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:14:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202222 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:14:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1.00,'N',200067,208620,'D','N','N','N','N',36,'N',10,'N',202222,'N','Y','f5587b87-26dd-4f59-a18e-303374c94bfb','Y','T_1099EXTRACT_UU','T_1099EXTRACT_UU','N',100,TO_TIMESTAMP('2013-02-28 17:14:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:31','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208620 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208621,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','0863b847-41d8-4bbd-a01c-b4aa515e31cb','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2013-02-28 17:14:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208621 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:14:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'Y',200067,208622,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','ec31ca00-7fef-49a4-bcbf-3bb16abf217e','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2013-02-28 17:14:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:14:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 5:14:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208622 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:16:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208617
;

-- Feb 28, 2013 5:16:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208617
;

-- Feb 28, 2013 5:16:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=208619
;

-- Feb 28, 2013 5:16:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
DELETE FROM AD_Column WHERE AD_Column_ID=208619
;

-- Feb 28, 2013 5:16:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Table SET TableName='T_1099Extract',Updated=TO_TIMESTAMP('2013-02-28 17:16:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200067
;

-- Feb 28, 2013 5:16:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Sequence SET Name='T_1099Extract',Updated=TO_TIMESTAMP('2013-02-28 17:16:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Sequence_ID=200062
;

-- Feb 28, 2013 5:17:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='T_1099Extract_UU', Name='T_1099Extract_UU', PrintName='T_1099Extract_UU',Updated=TO_TIMESTAMP('2013-02-28 17:17:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202222
;

-- Feb 28, 2013 5:17:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202222
;

-- Feb 28, 2013 5:17:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='T_1099Extract_UU', Name='T_1099Extract_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202222
;

-- Feb 28, 2013 5:17:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='T_1099Extract_UU', Name='T_1099Extract_UU', Description=NULL, Help=NULL, AD_Element_ID=202222 WHERE UPPER(ColumnName)='T_1099EXTRACT_UU' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:17:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='T_1099Extract_UU', Name='T_1099Extract_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202222 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:17:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='T_1099Extract_UU', Name='T_1099Extract_UU', Description=NULL, Help=NULL WHERE AD_Element_ID=202222 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:17:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='T_1099Extract_UU', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202222) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:17:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='T_1099Extract_UU', Name='T_1099Extract_UU' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202222)
;

-- Feb 28, 2013 5:18:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket01',202223,'D','AmtBucket01','AmtBucket01','3f95cb06-95eb-4b8e-bd6f-635008443e5e',0,TO_TIMESTAMP('2013-02-28 17:18:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:18:03','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:18:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202223 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:18:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket02',202224,'D','AmtBucket02','AmtBucket02','93ec0f06-ce3b-4003-9833-0408a91e784f',0,TO_TIMESTAMP('2013-02-28 17:18:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:18:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:18:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202224 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:18:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket03',202225,'D','AmtBucket03','AmtBucket03','00cebd24-b734-4ee3-9452-07cfa0710ded',0,TO_TIMESTAMP('2013-02-28 17:18:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:18:24','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:18:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202225 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:18:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket04',202226,'D','AmtBucket04','AmtBucket04','159fdab2-ead3-437a-b9d1-3ab4dd5eba70',0,TO_TIMESTAMP('2013-02-28 17:18:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:18:31','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:18:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202226 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:18:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket05',202227,'D','AmtBucket05','AmtBucket05','722e6e4c-d436-4542-861c-f904cdf88916',0,TO_TIMESTAMP('2013-02-28 17:18:41','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:18:41','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:18:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202227 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:18:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket06',202228,'D','AmtBucket06','AmtBucket06','f72f6036-a203-40fc-8a58-1e90604a9162',0,TO_TIMESTAMP('2013-02-28 17:18:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:18:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:18:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202228 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:18:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket07',202229,'D','AmtBucket07','AmtBucket07','3e3a2321-16f9-4729-9202-9edcee5b9f81',0,TO_TIMESTAMP('2013-02-28 17:18:58','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:18:58','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:18:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202229 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:19:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket08',202230,'D','AmtBucket08','AmtBucket08','afcf8c62-26d8-48de-8ad3-f988caf4b2c9',0,TO_TIMESTAMP('2013-02-28 17:19:07','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:19:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:19:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202230 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket09',202231,'D','AmtBucket09','AmtBucket09','f894edc9-c217-4d98-959b-2aed20865d1d',0,TO_TIMESTAMP('2013-02-28 17:19:16','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:19:16','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:19:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202231 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:19:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket10',202232,'D','AmtBucket10','AmtBucket10','956341ed-1f65-4b46-a37f-224b34c248f8',0,TO_TIMESTAMP('2013-02-28 17:19:25','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:19:25','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:19:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202232 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:19:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket11',202233,'D','AmtBucket11','AmtBucket11','5d3c9b44-22b6-4a0c-86f8-4d0a04e56efa',0,TO_TIMESTAMP('2013-02-28 17:19:40','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:19:40','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:19:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202233 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:19:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket12',202234,'D','AmtBucket12','AmtBucket12','28546cdc-256c-4846-a91b-eb8b35b2beaf',0,TO_TIMESTAMP('2013-02-28 17:19:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:19:51','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:19:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202234 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:20:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket13',202235,'D','AmtBucket13','AmtBucket13','423eb35f-a296-49fd-b260-e7c17f845931',0,TO_TIMESTAMP('2013-02-28 17:20:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:20:00','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:20:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202235 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:20:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket14',202236,'D','AmtBucket14','AmtBucket14','b7f7ad31-4936-40c9-af07-e629ae61e841',0,TO_TIMESTAMP('2013-02-28 17:20:09','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:20:09','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:20:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202236 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:20:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket15',202237,'D','AmtBucket15','AmtBucket15','a9701e04-5e4f-499c-99de-0c6daaf52565',0,TO_TIMESTAMP('2013-02-28 17:20:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:20:20','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:20:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202237 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:20:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AmtBucket16',202238,'D','AmtBucket16','AmtBucket16','9a86d8fe-cdcd-4f82-82e6-05dcc2634602',0,TO_TIMESTAMP('2013-02-28 17:20:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:20:32','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:20:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202238 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:21:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208623,'D','N','N','N',0,'N',14,'N',12,'N',202223,'N','Y','a284a9d7-0405-4d1e-a8cf-4df4b965809e','Y','AmtBucket01','AmtBucket01','Y',100,TO_TIMESTAMP('2013-02-28 17:21:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:21:12','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:21:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208623 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:22:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208624,'D','N','N','N',0,'N',14,'N',12,'N',202224,'N','Y','4d1223ff-359e-432c-b245-1e94bdd1cc2d','Y','AmtBucket02','AmtBucket02','Y',100,TO_TIMESTAMP('2013-02-28 17:22:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:22:31','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:22:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208624 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:22:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208625,'D','N','N','N',0,'N',14,'N',12,'N',202225,'N','Y','dc942cf0-a661-48e3-a357-c694e0ec253b','Y','AmtBucket03','AmtBucket03','Y',100,TO_TIMESTAMP('2013-02-28 17:22:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:22:46','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:22:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208625 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:23:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208626,'D','N','N','N',0,'N',14,'N',12,'N',202226,'N','Y','5501ac5b-ce89-4656-bb18-7ced1d268eb2','Y','AmtBucket04','AmtBucket04','Y',100,TO_TIMESTAMP('2013-02-28 17:22:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:22:58','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:23:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208626 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:23:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208627,'D','N','N','N',0,'N',14,'N',12,'N',202227,'N','Y','095e5743-3c8f-4616-b02c-e6f056290b21','Y','AmtBucket05','AmtBucket05','Y',100,TO_TIMESTAMP('2013-02-28 17:23:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:23:14','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:23:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208627 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:23:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208628,'D','N','N','N',0,'N',14,'N',12,'N',202228,'N','Y','c7402624-d711-4dc6-8966-0b704c566282','Y','AmtBucket06','AmtBucket06','Y',100,TO_TIMESTAMP('2013-02-28 17:23:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:23:40','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:23:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208628 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:24:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208629,'D','N','N','N',0,'N',14,'N',12,'N',202229,'N','Y','c2d44ee6-bc86-44dc-aeba-053499c2ad0e','Y','AmtBucket07','AmtBucket07','Y',100,TO_TIMESTAMP('2013-02-28 17:24:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:24:11','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:24:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208629 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:24:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208630,'D','N','N','N',0,'N',14,'N',12,'N',202230,'N','Y','93d33eea-66ab-432b-a3fa-97a6c5fda6e8','Y','AmtBucket08','AmtBucket08','Y',100,TO_TIMESTAMP('2013-02-28 17:24:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:24:33','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:24:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208630 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:24:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208631,'D','N','N','N',0,'N',14,'N',12,'N',202231,'N','Y','76abd5dd-026b-4233-b095-9074d275a48c','Y','AmtBucket09','AmtBucket09','Y',100,TO_TIMESTAMP('2013-02-28 17:24:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:24:53','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:24:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208631 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:25:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208632,'D','N','N','N',0,'N',14,'N',12,'N',202232,'N','Y','0c1e00fd-17f2-4001-ad40-f4fb850d02f3','Y','AmtBucket10','AmtBucket10','Y',100,TO_TIMESTAMP('2013-02-28 17:25:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:25:06','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:25:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208632 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:25:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208633,'D','N','N','N',0,'N',14,'N',12,'N',202233,'N','Y','3699e293-3dc7-472a-b8d6-8c5733f01a6e','Y','AmtBucket11','AmtBucket11','Y',100,TO_TIMESTAMP('2013-02-28 17:25:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:25:27','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:25:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208633 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:25:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208634,'D','N','N','N',0,'N',14,'N',12,'N',202234,'N','Y','eecec4b3-10f8-4c18-b061-6332430e3698','Y','AmtBucket12','AmtBucket12','Y',100,TO_TIMESTAMP('2013-02-28 17:25:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:25:41','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:25:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208634 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:25:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208635,'D','N','N','N',0,'N',14,'N',12,'N',202235,'N','Y','edd6c6b4-bdd3-4dd6-8878-d24295e69e6a','Y','AmtBucket13','AmtBucket13','Y',100,TO_TIMESTAMP('2013-02-28 17:25:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:25:54','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:25:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208635 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:26:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208636,'D','N','N','N',0,'N',14,'N',12,'N',202236,'N','Y','4fa4fad6-a3ba-44de-aeb5-16e886710116','Y','AmtBucket14','AmtBucket14','Y',100,TO_TIMESTAMP('2013-02-28 17:26:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:26:12','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:26:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208636 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:26:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208637,'D','N','N','N',0,'N',14,'N',12,'N',202237,'N','Y','619558da-eab3-46f6-ab07-82713f90806a','Y','AmtBucket15','AmtBucket15','Y',100,TO_TIMESTAMP('2013-02-28 17:26:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:26:34','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:26:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208637 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:26:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208638,'D','N','N','N',0,'N',14,'N',12,'N',202238,'N','Y','bd68bcca-2664-4b26-b3d0-b037d26782b7','Y','AmtBucket16','AmtBucket16','Y',100,TO_TIMESTAMP('2013-02-28 17:26:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:26:49','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:26:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208638 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:28:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208639,'D','Y','N','N',0,'N',10,'N',19,'N',187,'N','Y','43c28a21-b9e2-4f61-868f-f524f19818e3','Y','C_BPartner_ID','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Business Partner ','Y',100,TO_TIMESTAMP('2013-02-28 17:28:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:28:35','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:28:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208639 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:30:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208640,'D','N','N','N',0,'N',10,'N',21,'N',202,'N','Y','73055055-97d1-49bd-beed-6af19fd70184','Y','C_Location_ID','Location or Address','The Location / Address field defines the location of an entity.','Address','Y',100,TO_TIMESTAMP('2013-02-28 17:30:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:30:07','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:30:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208640 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:31:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Cut_Date',202239,'D','Cut Date','Cut Date','fa45128f-8f37-4207-bff5-743026da2431',0,TO_TIMESTAMP('2013-02-28 17:31:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:31:36','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:31:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202239 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:31:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Cut_Year',202240,'D','Cut Year','Cut Year','2f38f415-f6f0-4b16-8cb2-a0c9ceff95ea',0,TO_TIMESTAMP('2013-02-28 17:31:52','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:31:52','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:31:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202240 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:32:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 1', PrintName='Amount Bucket 1',Updated=TO_TIMESTAMP('2013-02-28 17:32:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202223
;

-- Feb 28, 2013 5:32:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202223
;

-- Feb 28, 2013 5:32:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket01', Name='Amount Bucket 1', Description=NULL, Help=NULL WHERE AD_Element_ID=202223
;

-- Feb 28, 2013 5:32:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket01', Name='Amount Bucket 1', Description=NULL, Help=NULL, AD_Element_ID=202223 WHERE UPPER(ColumnName)='AMTBUCKET01' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:32:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket01', Name='Amount Bucket 1', Description=NULL, Help=NULL WHERE AD_Element_ID=202223 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket01', Name='Amount Bucket 1', Description=NULL, Help=NULL WHERE AD_Element_ID=202223 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 1', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202223) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 1', Name='Amount Bucket 1' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202223)
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 2', PrintName='Amount Bucket 2',Updated=TO_TIMESTAMP('2013-02-28 17:32:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202224
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202224
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket02', Name='Amount Bucket 2', Description=NULL, Help=NULL WHERE AD_Element_ID=202224
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket02', Name='Amount Bucket 2', Description=NULL, Help=NULL, AD_Element_ID=202224 WHERE UPPER(ColumnName)='AMTBUCKET02' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket02', Name='Amount Bucket 2', Description=NULL, Help=NULL WHERE AD_Element_ID=202224 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket02', Name='Amount Bucket 2', Description=NULL, Help=NULL WHERE AD_Element_ID=202224 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 2', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202224) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 2', Name='Amount Bucket 2' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202224)
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 3', PrintName='Amount Bucket 3',Updated=TO_TIMESTAMP('2013-02-28 17:32:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202225
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202225
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket03', Name='Amount Bucket 3', Description=NULL, Help=NULL WHERE AD_Element_ID=202225
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket03', Name='Amount Bucket 3', Description=NULL, Help=NULL, AD_Element_ID=202225 WHERE UPPER(ColumnName)='AMTBUCKET03' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket03', Name='Amount Bucket 3', Description=NULL, Help=NULL WHERE AD_Element_ID=202225 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket03', Name='Amount Bucket 3', Description=NULL, Help=NULL WHERE AD_Element_ID=202225 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 3', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202225) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 3', Name='Amount Bucket 3' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202225)
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 4', PrintName='Amount Bucket 4',Updated=TO_TIMESTAMP('2013-02-28 17:32:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202226
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202226
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket04', Name='Amount Bucket 4', Description=NULL, Help=NULL WHERE AD_Element_ID=202226
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket04', Name='Amount Bucket 4', Description=NULL, Help=NULL, AD_Element_ID=202226 WHERE UPPER(ColumnName)='AMTBUCKET04' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket04', Name='Amount Bucket 4', Description=NULL, Help=NULL WHERE AD_Element_ID=202226 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket04', Name='Amount Bucket 4', Description=NULL, Help=NULL WHERE AD_Element_ID=202226 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 4', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202226) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 4', Name='Amount Bucket 4' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202226)
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 5', PrintName='Amount Bucket 5',Updated=TO_TIMESTAMP('2013-02-28 17:32:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202227
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202227
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket05', Name='Amount Bucket 5', Description=NULL, Help=NULL WHERE AD_Element_ID=202227
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket05', Name='Amount Bucket 5', Description=NULL, Help=NULL, AD_Element_ID=202227 WHERE UPPER(ColumnName)='AMTBUCKET05' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket05', Name='Amount Bucket 5', Description=NULL, Help=NULL WHERE AD_Element_ID=202227 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket05', Name='Amount Bucket 5', Description=NULL, Help=NULL WHERE AD_Element_ID=202227 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 5', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202227) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 5', Name='Amount Bucket 5' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202227)
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 6', PrintName='Amount Bucket 6',Updated=TO_TIMESTAMP('2013-02-28 17:32:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202228
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202228
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket06', Name='Amount Bucket 6', Description=NULL, Help=NULL WHERE AD_Element_ID=202228
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket06', Name='Amount Bucket 6', Description=NULL, Help=NULL, AD_Element_ID=202228 WHERE UPPER(ColumnName)='AMTBUCKET06' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket06', Name='Amount Bucket 6', Description=NULL, Help=NULL WHERE AD_Element_ID=202228 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket06', Name='Amount Bucket 6', Description=NULL, Help=NULL WHERE AD_Element_ID=202228 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 6', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202228) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:32:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 6', Name='Amount Bucket 6' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202228)
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 7', PrintName='Amount Bucket 7',Updated=TO_TIMESTAMP('2013-02-28 17:33:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202229
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202229
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket07', Name='Amount Bucket 7', Description=NULL, Help=NULL WHERE AD_Element_ID=202229
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket07', Name='Amount Bucket 7', Description=NULL, Help=NULL, AD_Element_ID=202229 WHERE UPPER(ColumnName)='AMTBUCKET07' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket07', Name='Amount Bucket 7', Description=NULL, Help=NULL WHERE AD_Element_ID=202229 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket07', Name='Amount Bucket 7', Description=NULL, Help=NULL WHERE AD_Element_ID=202229 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 7', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202229) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 7', Name='Amount Bucket 7' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202229)
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 8', PrintName='Amount Bucket 8',Updated=TO_TIMESTAMP('2013-02-28 17:33:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202230
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202230
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket08', Name='Amount Bucket 8', Description=NULL, Help=NULL WHERE AD_Element_ID=202230
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket08', Name='Amount Bucket 8', Description=NULL, Help=NULL, AD_Element_ID=202230 WHERE UPPER(ColumnName)='AMTBUCKET08' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket08', Name='Amount Bucket 8', Description=NULL, Help=NULL WHERE AD_Element_ID=202230 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket08', Name='Amount Bucket 8', Description=NULL, Help=NULL WHERE AD_Element_ID=202230 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 8', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202230) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 8', Name='Amount Bucket 8' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202230)
;

-- Feb 28, 2013 5:33:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 9', PrintName='Amount Bucket 9',Updated=TO_TIMESTAMP('2013-02-28 17:33:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202231
;

-- Feb 28, 2013 5:33:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202231
;

-- Feb 28, 2013 5:33:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket09', Name='Amount Bucket 9', Description=NULL, Help=NULL WHERE AD_Element_ID=202231
;

-- Feb 28, 2013 5:33:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket09', Name='Amount Bucket 9', Description=NULL, Help=NULL, AD_Element_ID=202231 WHERE UPPER(ColumnName)='AMTBUCKET09' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:33:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket09', Name='Amount Bucket 9', Description=NULL, Help=NULL WHERE AD_Element_ID=202231 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket09', Name='Amount Bucket 9', Description=NULL, Help=NULL WHERE AD_Element_ID=202231 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 9', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202231) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 9', Name='Amount Bucket 9' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202231)
;

-- Feb 28, 2013 5:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 10', PrintName='Amount Bucket 10',Updated=TO_TIMESTAMP('2013-02-28 17:33:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202232
;

-- Feb 28, 2013 5:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202232
;

-- Feb 28, 2013 5:33:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket10', Name='Amount Bucket 10', Description=NULL, Help=NULL WHERE AD_Element_ID=202232
;

-- Feb 28, 2013 5:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket10', Name='Amount Bucket 10', Description=NULL, Help=NULL, AD_Element_ID=202232 WHERE UPPER(ColumnName)='AMTBUCKET10' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket10', Name='Amount Bucket 10', Description=NULL, Help=NULL WHERE AD_Element_ID=202232 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket10', Name='Amount Bucket 10', Description=NULL, Help=NULL WHERE AD_Element_ID=202232 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 10', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202232) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:33:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 10', Name='Amount Bucket 10' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202232)
;

-- Feb 28, 2013 5:34:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 11', PrintName='Amount Bucket 11',Updated=TO_TIMESTAMP('2013-02-28 17:34:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202233
;

-- Feb 28, 2013 5:34:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202233
;

-- Feb 28, 2013 5:34:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket11', Name='Amount Bucket 11', Description=NULL, Help=NULL WHERE AD_Element_ID=202233
;

-- Feb 28, 2013 5:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket11', Name='Amount Bucket 11', Description=NULL, Help=NULL, AD_Element_ID=202233 WHERE UPPER(ColumnName)='AMTBUCKET11' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket11', Name='Amount Bucket 11', Description=NULL, Help=NULL WHERE AD_Element_ID=202233 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket11', Name='Amount Bucket 11', Description=NULL, Help=NULL WHERE AD_Element_ID=202233 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 11', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202233) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 11', Name='Amount Bucket 11' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202233)
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 12', PrintName='Amount Bucket 12',Updated=TO_TIMESTAMP('2013-02-28 17:34:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202234
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202234
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket12', Name='Amount Bucket 12', Description=NULL, Help=NULL WHERE AD_Element_ID=202234
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket12', Name='Amount Bucket 12', Description=NULL, Help=NULL, AD_Element_ID=202234 WHERE UPPER(ColumnName)='AMTBUCKET12' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket12', Name='Amount Bucket 12', Description=NULL, Help=NULL WHERE AD_Element_ID=202234 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket12', Name='Amount Bucket 12', Description=NULL, Help=NULL WHERE AD_Element_ID=202234 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 12', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202234) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 12', Name='Amount Bucket 12' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202234)
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 13', PrintName='Amount Bucket 13',Updated=TO_TIMESTAMP('2013-02-28 17:34:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202235
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202235
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket13', Name='Amount Bucket 13', Description=NULL, Help=NULL WHERE AD_Element_ID=202235
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket13', Name='Amount Bucket 13', Description=NULL, Help=NULL, AD_Element_ID=202235 WHERE UPPER(ColumnName)='AMTBUCKET13' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket13', Name='Amount Bucket 13', Description=NULL, Help=NULL WHERE AD_Element_ID=202235 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket13', Name='Amount Bucket 13', Description=NULL, Help=NULL WHERE AD_Element_ID=202235 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 13', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202235) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 13', Name='Amount Bucket 13' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202235)
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 14', PrintName='Amount Bucket 14',Updated=TO_TIMESTAMP('2013-02-28 17:34:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202236
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202236
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket14', Name='Amount Bucket 14', Description=NULL, Help=NULL WHERE AD_Element_ID=202236
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket14', Name='Amount Bucket 14', Description=NULL, Help=NULL, AD_Element_ID=202236 WHERE UPPER(ColumnName)='AMTBUCKET14' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket14', Name='Amount Bucket 14', Description=NULL, Help=NULL WHERE AD_Element_ID=202236 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket14', Name='Amount Bucket 14', Description=NULL, Help=NULL WHERE AD_Element_ID=202236 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 14', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202236) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 14', Name='Amount Bucket 14' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202236)
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 15', PrintName='Amount Bucket 15',Updated=TO_TIMESTAMP('2013-02-28 17:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202237
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202237
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket15', Name='Amount Bucket 15', Description=NULL, Help=NULL WHERE AD_Element_ID=202237
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket15', Name='Amount Bucket 15', Description=NULL, Help=NULL, AD_Element_ID=202237 WHERE UPPER(ColumnName)='AMTBUCKET15' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket15', Name='Amount Bucket 15', Description=NULL, Help=NULL WHERE AD_Element_ID=202237 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket15', Name='Amount Bucket 15', Description=NULL, Help=NULL WHERE AD_Element_ID=202237 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 15', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202237) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 15', Name='Amount Bucket 15' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202237)
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET Name='Amount Bucket 16', PrintName='Amount Bucket 16',Updated=TO_TIMESTAMP('2013-02-28 17:34:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202238
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202238
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='AmtBucket16', Name='Amount Bucket 16', Description=NULL, Help=NULL WHERE AD_Element_ID=202238
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket16', Name='Amount Bucket 16', Description=NULL, Help=NULL, AD_Element_ID=202238 WHERE UPPER(ColumnName)='AMTBUCKET16' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='AmtBucket16', Name='Amount Bucket 16', Description=NULL, Help=NULL WHERE AD_Element_ID=202238 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='AmtBucket16', Name='Amount Bucket 16', Description=NULL, Help=NULL WHERE AD_Element_ID=202238 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Amount Bucket 16', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202238) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 5:34:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Amount Bucket 16', Name='Amount Bucket 16' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202238)
;

-- Feb 28, 2013 5:36:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208641,'D','N','N','N',0,'N',7,'N',15,'N',202239,'N','Y','5703898c-21ff-4a02-a6b3-9481bd4e76d3','Y','Cut_Date','Cut Date','Y',100,TO_TIMESTAMP('2013-02-28 17:36:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:36:26','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:36:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208641 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:45:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208642,'D','N','N','N',0,'N',14,'N',11,'N',202240,'N','Y','e5f6d496-ecba-4c49-a877-358a30bc700d','Y','Cut_Year','Cut Year','Y',100,TO_TIMESTAMP('2013-02-28 17:45:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:45:02','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:45:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208642 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:45:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208643,'D','Y','N','Y',0,'N',120,'N',10,'N',469,'N','Y','9843aded-5975-4bac-b207-deefd5a9494f','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_TIMESTAMP('2013-02-28 17:45:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:45:52','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:45:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208643 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:46:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208644,'D','N','N','N',0,'N',20,'N',10,'N',590,'N','Y','3fbf47a2-2eea-4a8d-bb15-1f78c2d44d20','Y','TaxID','Tax Identification','The Tax ID field identifies the legal Identification number of this Entity.','Tax ID','Y',100,TO_TIMESTAMP('2013-02-28 17:46:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:46:31','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:46:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208644 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:47:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200067,208645,'D','Y','N','N',0,'N',40,'N',10,'N',620,'N','Y','cc4527d4-aef7-49b4-9aea-8aa21174841e','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_TIMESTAMP('2013-02-28 17:47:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:47:17','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 5:47:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208645 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:47:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
CREATE TABLE T_1099Extract (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) DEFAULT NULL , AD_PInstance_ID NUMERIC(10) NOT NULL, AmtBucket01 NUMERIC DEFAULT NULL , AmtBucket02 NUMERIC DEFAULT NULL , AmtBucket03 NUMERIC DEFAULT NULL , AmtBucket04 NUMERIC DEFAULT NULL , AmtBucket05 NUMERIC DEFAULT NULL , AmtBucket06 NUMERIC DEFAULT NULL , AmtBucket07 NUMERIC DEFAULT NULL , AmtBucket08 NUMERIC DEFAULT NULL , AmtBucket09 NUMERIC DEFAULT NULL , AmtBucket10 NUMERIC DEFAULT NULL , AmtBucket11 NUMERIC DEFAULT NULL , AmtBucket12 NUMERIC DEFAULT NULL , AmtBucket13 NUMERIC DEFAULT NULL , AmtBucket14 NUMERIC DEFAULT NULL , AmtBucket15 NUMERIC DEFAULT NULL , AmtBucket16 NUMERIC DEFAULT NULL , C_BPartner_ID NUMERIC(10) NOT NULL, C_Location_ID NUMERIC(10) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Cut_Date TIMESTAMP DEFAULT NULL , Cut_Year NUMERIC(10) DEFAULT NULL , IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(120) NOT NULL, T_1099Extract_UU VARCHAR(36) DEFAULT NULL , TaxID VARCHAR(20) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, Value VARCHAR(40) NOT NULL)
;

-- Feb 28, 2013 5:49:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200068,'N','Y','N','D','L','f64362a8-a693-4af3-946f-84b912d5b6eb','Y','N','RV_T_1099Extract','1099 Extract',0,'Y',0,TO_TIMESTAMP('2013-02-28 17:49:39','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-02-28 17:49:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 28, 2013 5:49:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Feb 28, 2013 5:49:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200063,'1651c6a3-3e37-4d6d-b82b-d51bc385ec0f','Table RV_T_1099Extract','RV_T_1099Extract',1,0,0,TO_TIMESTAMP('2013-02-28 17:49:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-02-28 17:49:40','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

CREATE OR REPLACE VIEW RV_T_1099Extract AS 
 SELECT t.ad_pinstance_id, t.ad_client_id, t.ad_org_id, t.isactive, t.created, t.createdby, t.updated, t.updatedby, 
 t.c_bpartner_id, t.value, t.name, t.taxid, l.address1 || ' ' || l.address2 || ' ' || l.address3 || ' ' || l.address4 AS address, 
 l.address1, l.address2, l.address3, l.address4, l.city || ', ' || r.name || ' ' || l.postal AS citystatezip, 
 l.city, r.name AS region, l.postal AS zip, ctry.name AS country, t.cut_year, t.cut_date, 
 COALESCE(t.amtbucket01, 0) AS amtbucket01, COALESCE(t.amtbucket02, 0) AS amtbucket02, COALESCE(t.amtbucket03, 0) AS amtbucket03, 
 COALESCE(t.amtbucket04, 0) AS amtbucket04, COALESCE(t.amtbucket05, 0) AS amtbucket05, COALESCE(t.amtbucket06, 0) AS amtbucket06, 
 COALESCE(t.amtbucket07, 0) AS amtbucket07, COALESCE(t.amtbucket08, 0) AS amtbucket08, COALESCE(t.amtbucket09, 0) AS amtbucket09, 
 COALESCE(t.amtbucket10, 0) AS amtbucket10, COALESCE(t.amtbucket11, 0) AS amtbucket11, COALESCE(t.amtbucket12, 0) AS amtbucket12, 
 COALESCE(t.amtbucket13, 0) AS amtbucket13, COALESCE(t.amtbucket14, 0) AS amtbucket14, COALESCE(t.amtbucket15, 0) AS amtbucket15, 
 COALESCE(t.amtbucket16, 0) AS amtbucket16
   FROM t_1099extract t
   LEFT JOIN c_location l ON t.c_location_id = l.c_location_id
   LEFT JOIN c_region r ON r.c_region_id = l.c_region_id
   LEFT JOIN c_country ctry ON ctry.c_country_id = l.c_country_id
  WHERE t.ad_pinstance_id = (SELECT max(t_1099extract.ad_pinstance_id) AS max
   FROM t_1099extract);-- Feb 28, 2013 5:57:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208646,'D','N','N','N','N',10,'N',19,'N',114,'23bfec04-9c67-4d6e-8483-dc3ae4a8f522','N','AD_PInstance_ID','Instance of the process','Process Instance',100,TO_TIMESTAMP('2013-02-28 17:57:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208646 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208647,'D','N','N','N','N',10,'N',19,'N',102,'353b0741-2e6f-4736-8bac-1d426d42c489','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',100,TO_TIMESTAMP('2013-02-28 17:57:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208647 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208648,'D','N','N','N','N',10,'N',19,'N',113,'1d14c9f0-0aa9-4f49-af83-738df5f021fc','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',100,TO_TIMESTAMP('2013-02-28 17:57:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208648 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208649,'D','N','N','N','N',1,'N',20,'N',348,'08068e02-c911-4e57-8a2a-026d6e70b911','N','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active',100,TO_TIMESTAMP('2013-02-28 17:57:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208649 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208650,'D','N','N','N','N',29,'N',16,'N',245,'21586218-b6b8-4322-bc41-c86b21dc0e15','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created',100,TO_TIMESTAMP('2013-02-28 17:57:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208650 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208651,'D',110,'N','N','N','N',10,'N',18,'N',246,'64dfc749-3d9c-49aa-8e25-c0422ef9aff6','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By',100,TO_TIMESTAMP('2013-02-28 17:57:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:24','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208651 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208652,'D','N','N','N','N',29,'N',16,'N',607,'eea4e473-7883-493b-a5a2-671265fc48a6','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated',100,TO_TIMESTAMP('2013-02-28 17:57:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:25','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208652 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208653,'D',110,'N','N','N','N',10,'N',18,'N',608,'67381835-8fac-428f-88a1-0c321f4578b5','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By',100,TO_TIMESTAMP('2013-02-28 17:57:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:26','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208653 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208654,'D','N','N','N','N',10,'N',19,'N',187,'1ddeb813-0867-4a87-842f-6105d49d3ebd','N','C_BPartner_ID','Identifies a Business Partner','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Business Partner ',100,TO_TIMESTAMP('2013-02-28 17:57:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208654 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208655,'D','N','N','N','N',40,'Y',10,'N',620,'ba9c71fb-cab5-4641-94dd-bfbb9ac03b01','N','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key',100,TO_TIMESTAMP('2013-02-28 17:57:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:31','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208655 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208656,'D','N','N','Y',1,'N',120,'Y',10,'N',469,'ed28eef9-45fe-4f7c-8f64-87f547f0909f','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name',100,TO_TIMESTAMP('2013-02-28 17:57:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:32','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208656 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208657,'D','N','N','N','N',20,'N',10,'N',590,'87b47a9e-8327-43d9-8c3f-cca5341c5963','N','TaxID','Tax Identification','The Tax ID field identifies the legal Identification number of this Entity.','Tax ID',100,TO_TIMESTAMP('2013-02-28 17:57:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:33','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208657 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('address',202241,'D','address','address','41ec56bc-68f2-461a-b723-d2889e0a982d',0,TO_TIMESTAMP('2013-02-28 17:57:36','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:57:36','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:57:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202241 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:57:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208658,'D','N','N','N','N',2147483647,'N',14,'N',202241,'83c52ff6-cb50-4bf5-8a9c-bc1e303b8e0c','N','address','address',100,TO_TIMESTAMP('2013-02-28 17:57:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208658 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208659,'D','N','N','N','N',60,'N',10,'N',156,'47a37178-489a-416f-aef3-c4659ab83a8f','N','Address1','Address line 1 for this location','The Address 1 identifies the address for an entity''s location','Address 1',100,TO_TIMESTAMP('2013-02-28 17:57:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:38','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208659 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208660,'D','N','N','N','N',60,'N',10,'N',157,'ad129f09-a981-4a90-919b-7e5ec5048557','N','Address2','Address line 2 for this location','The Address 2 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','Address 2',100,TO_TIMESTAMP('2013-02-28 17:57:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208660 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208661,'D','N','N','N','N',60,'N',10,'N',2555,'50653395-95d9-4b43-bdef-f6b00ba0f29c','N','Address3','Address Line 3 for the location','The Address 2 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','Address 3',100,TO_TIMESTAMP('2013-02-28 17:57:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208661 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208662,'D','N','N','N','N',60,'N',10,'N',2556,'eead86f4-d24d-4472-a00d-2074794694da','N','Address4','Address Line 4 for the location','The Address 4 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','Address 4',100,TO_TIMESTAMP('2013-02-28 17:57:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:41','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208662 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('citystatezip',202242,'D','citystatezip','citystatezip','85a81b02-cd62-4b57-88af-55912d0139cb',0,TO_TIMESTAMP('2013-02-28 17:57:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:57:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:57:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202242 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:57:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208663,'D','N','N','N','N',2147483647,'N',14,'N',202242,'3610fc95-5a06-4bb6-ace9-a900bff0e6e8','N','citystatezip','citystatezip',100,TO_TIMESTAMP('2013-02-28 17:57:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:42','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208663 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208664,'D','N','N','N','N',60,'N',10,'N',225,'a41950b2-29ee-4050-9656-5ea65928afdb','N','City','Identifies a City','The City identifies a unique City for this Country or Region.','City',100,TO_TIMESTAMP('2013-02-28 17:57:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:44','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208664 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('region',202243,'D','region','region','9f645bd8-0d83-43c3-b593-b5d3f034980f',0,TO_TIMESTAMP('2013-02-28 17:57:45','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:57:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:57:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202243 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:57:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208665,'D','N','N','N','N',60,'N',10,'N',202243,'c16bb46b-6163-4d3c-b0ac-4c5dba692944','N','region','region',100,TO_TIMESTAMP('2013-02-28 17:57:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:45','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208665 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('zip',202244,'D','zip','zip','333e0193-a208-441a-b1d3-93caac880d77',0,TO_TIMESTAMP('2013-02-28 17:57:47','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:57:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:57:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202244 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:57:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208666,'D','N','N','N','N',10,'N',10,'N',202244,'876f6a8e-e3c2-4f31-9536-1b9205e530b5','N','zip','zip',100,TO_TIMESTAMP('2013-02-28 17:57:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208666 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('country',202245,'D','country','country','7b0ef0f0-3f19-472e-844a-b8ef91cc5781',0,TO_TIMESTAMP('2013-02-28 17:57:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 17:57:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 5:57:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202245 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 5:57:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208667,'D','N','N','N','N',60,'N',10,'N',202245,'59eddec8-7175-46cb-8ae3-07c7279a818b','N','country','country',100,TO_TIMESTAMP('2013-02-28 17:57:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:49','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208667 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208668,'D','N','N','N','N',10,'N',11,'N',202240,'9ab9bc7f-ee65-46f0-92a9-37b62aba57e4','N','Cut_Year','Cut Year',100,TO_TIMESTAMP('2013-02-28 17:57:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:51','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208668 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208669,'D','N','N','N','N',29,'N',16,'N',202239,'51f92fcf-be09-4a18-9ec8-aa052810f3ed','N','Cut_Date','Cut Date',100,TO_TIMESTAMP('2013-02-28 17:57:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:52','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208669 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208670,'D','N','N','N','N',131089,'N',12,'N',202223,'a12db323-a2f7-442f-9210-18b164fe04f1','N','AmtBucket01','Amount Bucket 1',100,TO_TIMESTAMP('2013-02-28 17:57:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208670 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:57:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208671,'D','N','N','N','N',131089,'N',12,'N',202224,'ea54f62d-0e68-4477-bffa-524985cc9c39','N','AmtBucket02','Amount Bucket 2',100,TO_TIMESTAMP('2013-02-28 17:57:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:55','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:57:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208671 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208672,'D','N','N','N','N',131089,'N',12,'N',202225,'1818a303-bd9a-4359-81d5-f40c41f47ca3','N','AmtBucket03','Amount Bucket 3',100,TO_TIMESTAMP('2013-02-28 17:57:56','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:57:56','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208672 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208673,'D','N','N','N','N',131089,'N',12,'N',202226,'cdaf4f00-5fef-4b12-8f9e-2e7770ef8d3d','N','AmtBucket04','Amount Bucket 4',100,TO_TIMESTAMP('2013-02-28 17:58:00','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:00','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208673 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208674,'D','N','N','N','N',131089,'N',12,'N',202227,'bb7872c2-f55e-4609-919e-07152dec0ce0','N','AmtBucket05','Amount Bucket 5',100,TO_TIMESTAMP('2013-02-28 17:58:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:01','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208674 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208675,'D','N','N','N','N',131089,'N',12,'N',202228,'ef958325-4095-4edc-bcae-d48053ebb44e','N','AmtBucket06','Amount Bucket 6',100,TO_TIMESTAMP('2013-02-28 17:58:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:02','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208675 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208676,'D','N','N','N','N',131089,'N',12,'N',202229,'3aefab9c-367f-4416-b4f3-dffca67a6da5','N','AmtBucket07','Amount Bucket 7',100,TO_TIMESTAMP('2013-02-28 17:58:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:03','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208676 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208677,'D','N','N','N','N',131089,'N',12,'N',202230,'bf07e553-e617-4c10-979e-8ed7848a7052','N','AmtBucket08','Amount Bucket 8',100,TO_TIMESTAMP('2013-02-28 17:58:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208677 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208678,'D','N','N','N','N',131089,'N',12,'N',202231,'042bad02-734c-47df-87a6-ee3a6c3d74d8','N','AmtBucket09','Amount Bucket 9',100,TO_TIMESTAMP('2013-02-28 17:58:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208678 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208679,'D','N','N','N','N',131089,'N',12,'N',202232,'1d799893-10f0-490c-a9fd-02ec267ed72b','N','AmtBucket10','Amount Bucket 10',100,TO_TIMESTAMP('2013-02-28 17:58:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:06','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208679 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208680,'D','N','N','N','N',131089,'N',12,'N',202233,'551adaff-a946-4059-b6ae-2bc6f810c4ab','N','AmtBucket11','Amount Bucket 11',100,TO_TIMESTAMP('2013-02-28 17:58:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208680 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208681,'D','N','N','N','N',131089,'N',12,'N',202234,'beeeff17-10e9-4ccb-8139-cc750880796b','N','AmtBucket12','Amount Bucket 12',100,TO_TIMESTAMP('2013-02-28 17:58:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:08','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208681 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208682,'D','N','N','N','N',131089,'N',12,'N',202235,'7fd66d8d-6dd8-477d-a9fd-d20cd508d317','N','AmtBucket13','Amount Bucket 13',100,TO_TIMESTAMP('2013-02-28 17:58:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:10 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208682 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208683,'D','N','N','N','N',131089,'N',12,'N',202236,'29010c8f-28a7-4471-9462-3a191acfe358','N','AmtBucket14','Amount Bucket 14',100,TO_TIMESTAMP('2013-02-28 17:58:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:10','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208683 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208684,'D','N','N','N','N',131089,'N',12,'N',202237,'7b7a669f-061c-4e2d-82ce-a97937409cf9','N','AmtBucket15','Amount Bucket 15',100,TO_TIMESTAMP('2013-02-28 17:58:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208684 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 5:58:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsAlwaysUpdateable,IsEncrypted) VALUES (0,200068,208685,'D','N','N','N','N',131089,'N',12,'N',202238,'6263eab2-580b-47cd-ab07-1cf2c72b996b','N','AmtBucket16','Amount Bucket 16',100,TO_TIMESTAMP('2013-02-28 17:58:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 17:58:12','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Feb 28, 2013 5:58:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208685 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:00:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Address', Name='Address', PrintName='Address',Updated=TO_TIMESTAMP('2013-02-28 18:00:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202241
;

-- Feb 28, 2013 6:00:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202241
;

-- Feb 28, 2013 6:00:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Address', Name='Address', Description=NULL, Help=NULL WHERE AD_Element_ID=202241
;

-- Feb 28, 2013 6:00:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Address', Name='Address', Description=NULL, Help=NULL, AD_Element_ID=202241 WHERE UPPER(ColumnName)='ADDRESS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 6:00:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Address', Name='Address', Description=NULL, Help=NULL WHERE AD_Element_ID=202241 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Address', Name='Address', Description=NULL, Help=NULL WHERE AD_Element_ID=202241 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Address', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202241) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Address', Name='Address' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202241)
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='CityStateZip', Name='City State Zip', PrintName='City State Zip',Updated=TO_TIMESTAMP('2013-02-28 18:00:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202242
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202242
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='CityStateZip', Name='City State Zip', Description=NULL, Help=NULL WHERE AD_Element_ID=202242
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='CityStateZip', Name='City State Zip', Description=NULL, Help=NULL, AD_Element_ID=202242 WHERE UPPER(ColumnName)='CITYSTATEZIP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='CityStateZip', Name='City State Zip', Description=NULL, Help=NULL WHERE AD_Element_ID=202242 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='CityStateZip', Name='City State Zip', Description=NULL, Help=NULL WHERE AD_Element_ID=202242 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='City State Zip', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202242) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='City State Zip', Name='City State Zip' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202242)
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Country', Name='Country', PrintName='Country',Updated=TO_TIMESTAMP('2013-02-28 18:00:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202245
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202245
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Country', Name='Country', Description=NULL, Help=NULL WHERE AD_Element_ID=202245
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Country', Name='Country', Description=NULL, Help=NULL, AD_Element_ID=202245 WHERE UPPER(ColumnName)='COUNTRY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Country', Name='Country', Description=NULL, Help=NULL WHERE AD_Element_ID=202245 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Country', Name='Country', Description=NULL, Help=NULL WHERE AD_Element_ID=202245 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Country', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202245) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Country', Name='Country' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202245)
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Zip', Name='Zip', PrintName='Zip',Updated=TO_TIMESTAMP('2013-02-28 18:00:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202244
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202244
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Zip', Name='Zip', Description=NULL, Help=NULL WHERE AD_Element_ID=202244
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Zip', Name='Zip', Description=NULL, Help=NULL, AD_Element_ID=202244 WHERE UPPER(ColumnName)='ZIP' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Zip', Name='Zip', Description=NULL, Help=NULL WHERE AD_Element_ID=202244 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Zip', Name='Zip', Description=NULL, Help=NULL WHERE AD_Element_ID=202244 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Zip', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202244) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 6:00:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Zip', Name='Zip' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202244)
;

-- Feb 28, 2013 6:04:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_ReportView (AD_ReportView_UU,AD_Table_ID,AD_ReportView_ID,EntityType,Name,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Org_ID,IsActive) VALUES ('db24ebe0-c6bf-4ab7-b356-3a63209971f6',200068,200000,'D','RV_T_1099Extract',0,TO_TIMESTAMP('2013-02-28 18:04:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-02-28 18:04:42','YYYY-MM-DD HH24:MI:SS'),100,0,'Y')
;

-- Feb 28, 2013 6:06:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,AD_ReportView_ID,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',200034,'N',200000,'Y','5577f73c-ca99-43b6-8ad6-272739305b60','3','N','N',0,0,'Y','D','org.adempiere.process.ASU_Fill1099Extract','1099 Extract','1099 Extract',0,0,TO_TIMESTAMP('2013-02-28 18:06:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:06:03','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Feb 28, 2013 6:06:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200034 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Feb 28, 2013 6:06:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,DefaultValue,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',202239,200051,'a0516401-a005-4aa5-902d-31b9eac32768',200034,15,'N','D','Cut Date','Cut_Date',0,'Y',10,'@#Date@','Y',100,TO_TIMESTAMP('2013-02-28 18:06:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-02-28 18:06:40','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Feb 28, 2013 6:06:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200051 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Feb 28, 2013 6:09:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200069,'N','N','N','D','L','c30ba29f-a4ad-4457-b4a9-4818d7502599','Y','Y','ASU_1099Box','1099 Box',0,'Y',0,TO_TIMESTAMP('2013-02-28 18:09:10','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2013-02-28 18:09:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 28, 2013 6:09:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Feb 28, 2013 6:09:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200064,'e073a95b-670f-4ead-91a5-fb62670554ff','Table ASU_1099Box','ASU_1099Box',1,0,0,TO_TIMESTAMP('2013-02-28 18:09:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-02-28 18:09:11','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Feb 28, 2013 6:13:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208686,'D','Y','N','N','N',22,'N',19,129,'N',102,'N','Y','c0b60533-1e8d-44d4-9e92-a7aa35c9fdfc','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2013-02-28 18:13:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208686 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208687,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','5ff73687-c3b7-45ef-899d-fc8e9dba16b7','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2013-02-28 18:13:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208687 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ASU_1099Box_ID',202246,'D','1099 Box','1099 Box','86a1d685-db8d-408d-9425-9a3b8705c7a4',0,TO_TIMESTAMP('2013-02-28 18:13:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:13:19','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 6:13:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202246 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 6:13:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208688,'D','Y','N','N','N',22,'N',13,'Y',202246,'N','Y','aed0137b-141a-4fed-b7fa-bdce7c995cb9','N','ASU_1099Box_ID','1099 Box','N',100,TO_TIMESTAMP('2013-02-28 18:13:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208688 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ASU_1099Box_UU',202247,'D','ASU_1099Box_UU','ASU_1099Box_UU','f718f03b-e96c-488e-b344-2245bcce3c27',0,TO_TIMESTAMP('2013-02-28 18:13:21','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:13:21','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 6:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202247 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 6:13:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1.00,'N',200069,208689,'D','N','N','N','N',36,'N',10,'N',202247,'N','Y','b510ba17-72d1-4c0e-b5e4-dd00bd39908f','Y','ASU_1099Box_UU','ASU_1099Box_UU','N',100,TO_TIMESTAMP('2013-02-28 18:13:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208689 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208690,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','1d42f76a-9ed8-4e22-b95d-5fa550b0d532','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2013-02-28 18:13:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:29','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208690 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208691,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','ad78790b-2e5d-4345-b4c8-78c6e0a01e7c','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2013-02-28 18:13:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:30','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208691 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208692,'D','N','N','N','N',255,'Y',10,'N',275,'N','Y','a35477e7-6966-47d9-b85b-03b78c4956a9','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_TIMESTAMP('2013-02-28 18:13:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:31','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208692 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208693,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','8b3bc284-c463-473f-8887-3fc45c9c215c','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2013-02-28 18:13:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:32','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208693 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208694,'D','Y','N','Y',1,'N',60,'Y',10,'N',469,'N','Y','68542e32-e109-4344-a99a-b0e3f39b8d7b','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_TIMESTAMP('2013-02-28 18:13:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:33','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208694 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208695,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','8fc1ecd1-0e0f-4fa8-8c72-0c1f9e54390d','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2013-02-28 18:13:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208695 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:13:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200069,208696,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','a43ce763-9a10-4808-9f46-5b7408bbb722','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2013-02-28 18:13:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:13:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 28, 2013 6:13:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208696 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:16:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Bucket',202248,'D','Bucket','Bucket','8856f05a-49f8-4c59-959f-c3640be7e75b',0,TO_TIMESTAMP('2013-02-28 18:16:33','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:16:33','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 6:16:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202248 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 6:17:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,ValueMin,IsSyncDatabase,AD_Table_ID,AD_Column_ID,ValueMax,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'1','N',200069,208697,'16','D','Y','N','N',0,'N',14,'N',11,'N',202248,'N','Y','907d1f5b-518d-4c30-a33f-346dc6057ee5','Y','Bucket','Bucket','Y',100,TO_TIMESTAMP('2013-02-28 18:17:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:17:05','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:17:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208697 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:17:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200069,208698,'D','N','N','N',0,'N',2000,'N',14,'N',326,'N','Y','e1d6bec4-9866-42ab-9810-465cda40e860','Y','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',100,TO_TIMESTAMP('2013-02-28 18:17:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:17:49','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:17:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208698 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:18:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200069,208699,'D','Y','N','N',0,'N',40,'N',10,'N',620,'N','Y','7bb33046-902f-4a86-bc5c-2b310833b4e5','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_TIMESTAMP('2013-02-28 18:18:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:18:29','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:18:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208699 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:18:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
CREATE TABLE ASU_1099Box (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, ASU_1099Box_ID NUMERIC(10) NOT NULL, ASU_1099Box_UU VARCHAR(36) DEFAULT NULL , Bucket NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Description VARCHAR(255) DEFAULT NULL , Help VARCHAR(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, Value VARCHAR(40) NOT NULL, CONSTRAINT ASU_1099Box_Key PRIMARY KEY (ASU_1099Box_ID))
;

-- Feb 28, 2013 6:21:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Default1099Box_ID',202249,'D','Default 1099 Box','Default 1099 Box','6c022404-8216-4312-9629-44c2d80bbffe',0,TO_TIMESTAMP('2013-02-28 18:21:03','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:21:03','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 6:21:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202249 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 6:21:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Client_ID,AD_Org_ID,Updated,CreatedBy,IsActive,Created,UpdatedBy) VALUES (200065,'ASU_1099Box','D','d2516191-26bf-4536-9a32-0a63bd08e44a','N','T',0,0,TO_TIMESTAMP('2013-02-28 18:21:31','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2013-02-28 18:21:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 6:21:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Feb 28, 2013 6:21:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Ref_Table (IsValueDisplayed,AD_Reference_ID,AD_Key,AD_Display,EntityType,AD_Table_ID,AD_Ref_Table_UU,CreatedBy,Updated,Created,AD_Client_ID,UpdatedBy,AD_Org_ID,IsActive) VALUES ('Y',200065,208688,208694,'D',200069,'418e13b3-113c-4d10-bed1-6e1c24c91549',100,TO_TIMESTAMP('2013-02-28 18:21:56','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:21:56','YYYY-MM-DD HH24:MI:SS'),0,100,0,'Y')
;

-- Feb 28, 2013 6:22:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',291,208700,'D',200065,'N','N','N',0,'N',10,'N',18,'N',202249,'N','Y','c33fe104-a5ab-4607-a552-775d3a8154a2','Y','Default1099Box_ID','Default 1099 Box','Y',100,TO_TIMESTAMP('2013-02-28 18:22:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:22:16','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:22:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208700 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:22:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
ALTER TABLE C_BPartner ADD COLUMN Default1099Box_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 28, 2013 6:22:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Is1099Vendor',202250,'D','1099 Vendor','1099 Vendor','d47c3e7e-d9d8-42cb-bcd4-0cc6975830bc',0,TO_TIMESTAMP('2013-02-28 18:22:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:22:46','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 6:22:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202250 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 6:23:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',291,208701,'D','Y','N','N',0,'N',1,'N',20,'N',202250,'N','Y','b62b3292-3268-46bf-9dea-81150a9b285a','Y','Is1099Vendor','N','1099 Vendor','Y',100,TO_TIMESTAMP('2013-02-28 18:23:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:23:12','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:23:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208701 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:23:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
ALTER TABLE C_BPartner ADD COLUMN Is1099Vendor CHAR(1) DEFAULT 'N' CHECK (Is1099Vendor IN ('Y','N')) NOT NULL
;

-- Feb 28, 2013 6:25:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',598,208702,'D',200065,'N','N','N',0,'N',10,'N',18,'N',202246,'N','Y','1fac63b9-5298-4138-bc56-ee4e1507b18d','Y','ASU_1099Box_ID','1099 Box','Y',100,TO_TIMESTAMP('2013-02-28 18:25:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:25:17','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:25:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208702 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:25:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
ALTER TABLE I_Invoice ADD COLUMN ASU_1099Box_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 28, 2013 6:25:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('ASU_1099Box_Value',202251,'D','1099 Box Value','1099 Box Value','1ceb23a4-335a-42a8-86da-de7ee14a4abf',0,TO_TIMESTAMP('2013-02-28 18:25:43','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:25:43','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 28, 2013 6:25:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202251 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 6:26:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',598,208703,'D','N','N','N',0,'N',40,'N',10,'N',202251,'N','Y','b6a4c506-50ca-4df4-b6b6-9457a3417de1','Y','ASU_1099Box_Value','1099 Box Value','Y',100,TO_TIMESTAMP('2013-02-28 18:26:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:26:03','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:26:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208703 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:26:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
ALTER TABLE I_Invoice ADD COLUMN ASU_1099Box_Value VARCHAR(40) DEFAULT NULL 
;

-- Feb 28, 2013 6:27:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',333,208704,'D',200065,'N','N','N',0,'N',10,'N',18,'N',202246,'N','Y','c17e9812-f26a-4044-84a3-dd237429a1f0','Y','ASU_1099Box_ID','@SQL=SELECT Default1099Box_ID FROM C_BPartner WHERE C_BPartner_ID=@C_BPartner_ID@ AND Is1099Vendor=''Y'' AND IsVendor=''Y'' AND ''@IsSOTrx@''=''N''','1099 Box','Y',100,TO_TIMESTAMP('2013-02-28 18:27:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2013-02-28 18:27:13','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 28, 2013 6:27:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208704 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 6:27:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
ALTER TABLE C_InvoiceLine ADD COLUMN ASU_1099Box_ID NUMERIC(10) DEFAULT NULL 
;

-- Feb 28, 2013 6:28:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Window (Processing,WindowType,IsSOTrx,IsDefault,WinWidth,IsBetaFunctionality,WinHeight,EntityType,Name,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Client_ID,AD_Org_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('N','M','N','N',0,'N',0,'D','1099 Box',200036,'6bddc8cc-8d7c-44d9-8438-d03bcd6da13f',TO_TIMESTAMP('2013-02-28 18:28:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-02-28 18:28:51','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Feb 28, 2013 6:28:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200036 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Feb 28, 2013 6:29:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Name,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','Y',200036,10,'N','N',200069,'N','N','N','98596e65-a82f-4649-b4f2-abced2c16f62','Y','N',0,'D','1099 Box',200078,0,TO_TIMESTAMP('2013-02-28 18:29:17','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-02-28 18:29:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 28, 2013 6:29:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200078 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Feb 28, 2013 6:29:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200078,22,'N','N',208688,'Y',201839,'N','D','1099 Box','N','N','7b8ef0b8-3562-4551-a5cb-57d8c2bc72ef',100,0,TO_TIMESTAMP('2013-02-28 18:29:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:19','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Feb 28, 2013 6:29:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201839 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,1,'N','N',208693,'Y',201840,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','52f5d1ac-72ea-444a-ba9d-f21aa67dd4b8',100,0,TO_TIMESTAMP('2013-02-28 18:29:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201840 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,36,'N','N',208689,'Y',201841,'N','D','ASU_1099Box_UU','N','Y','2d0e5301-75a6-4b28-a464-8a2aa3a05ca0',100,0,TO_TIMESTAMP('2013-02-28 18:29:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201841 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,14,'N','N',208697,'Y',201842,'N','D','Bucket','N','Y','5fd618a5-bd1a-4ff7-ace4-5a193f10ae57',100,0,TO_TIMESTAMP('2013-02-28 18:29:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201842 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,22,'N','N',208686,'Y',201843,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','bec16345-399b-4392-9601-5874eb925a6b',100,0,TO_TIMESTAMP('2013-02-28 18:29:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201843 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,2000,'N','N',208698,'Y',201844,'N','The Help field contains a hint, comment or help about the use of this item.','D','Comment or Hint','Comment/Help','N','Y','62fa961b-8253-43f4-a450-0cd1e29857a0',100,0,TO_TIMESTAMP('2013-02-28 18:29:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:24','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201844 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,255,'N','N',208692,'Y',201845,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','N','Y','b1c325f5-ad75-409b-8e75-146319fae207',100,0,TO_TIMESTAMP('2013-02-28 18:29:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201845 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,60,'N','N',208694,'Y',201846,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','N','Y','3c9754ad-b2ef-49ed-990a-b10b9628f815',100,0,TO_TIMESTAMP('2013-02-28 18:29:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201846 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,22,'N','N',208687,'Y',201847,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','af71820f-d152-4b0f-a489-59014634fa96',100,0,TO_TIMESTAMP('2013-02-28 18:29:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201847 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200078,40,'N','N',208699,'Y',201848,'N','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','D','Search key for the record in the format required - must be unique','Search Key','N','Y','d8109565-22fe-4726-ac18-fec6c0c66f7f',100,0,TO_TIMESTAMP('2013-02-28 18:29:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:29:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:29:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201848 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:29:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201841
;

-- Feb 28, 2013 6:29:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201843
;

-- Feb 28, 2013 6:29:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201847
;

-- Feb 28, 2013 6:29:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201848
;

-- Feb 28, 2013 6:29:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201846
;

-- Feb 28, 2013 6:29:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201842
;

-- Feb 28, 2013 6:29:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201845
;

-- Feb 28, 2013 6:29:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201844
;

-- Feb 28, 2013 6:29:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201840
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201841
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201843
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201847
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201848
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201846
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201842
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201845
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201844
;

-- Feb 28, 2013 6:30:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201840
;

-- Feb 28, 2013 6:30:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-02-28 18:30:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201847
;

-- Feb 28, 2013 6:30:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=22,Updated=TO_TIMESTAMP('2013-02-28 18:30:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201848
;

-- Feb 28, 2013 6:30:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:30:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201843
;

-- Feb 28, 2013 6:30:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:30:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201847
;

-- Feb 28, 2013 6:30:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:30:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201848
;

-- Feb 28, 2013 6:30:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:30:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201846
;

-- Feb 28, 2013 6:30:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:30:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201842
;

-- Feb 28, 2013 6:31:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:31:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201845
;

-- Feb 28, 2013 6:31:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:31:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201844
;

-- Feb 28, 2013 6:31:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:31:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201840
;

-- Feb 28, 2013 6:31:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET NumLines=3, ColumnSpan=5,Updated=TO_TIMESTAMP('2013-02-28 18:31:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201844
;

-- Feb 28, 2013 6:31:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-02-28 18:31:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201845
;

-- Feb 28, 2013 6:31:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_TIMESTAMP('2013-02-28 18:31:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201846
;

-- Feb 28, 2013 6:34:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Tab SET IsActive='Y',Updated=TO_TIMESTAMP('2013-02-28 18:34:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=224
;

-- Feb 28, 2013 6:34:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,1,'N','N',208701,'Y',201849,'N','D','1099 Vendor','N','Y','59132d30-b786-41e2-9358-066670095d11',100,0,TO_TIMESTAMP('2013-02-28 18:34:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201849 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,36,'N','N',60605,'Y',201850,'N','D','C_BPartner_UU','N','Y','0e2d9729-cbf7-47a4-b097-20911fcb9899',100,0,TO_TIMESTAMP('2013-02-28 18:34:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201850 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:34:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,60,'N','N',200612,'Y',201851,'N','D','Customer Profile ID','N','Y','57f5bfe2-6a00-48a1-83e1-ea5c04a6b9d8',100,0,TO_TIMESTAMP('2013-02-28 18:34:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201851 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:34:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,10,'N','N',208700,'Y',201852,'N','D','Default 1099 Box','N','Y','c4d02088-159e-4c27-ac9b-3ea51503d6a2',100,0,TO_TIMESTAMP('2013-02-28 18:34:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201852 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:34:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,7,'N','N',53246,'Y',201853,'N','D','Dunning Grace Date','N','Y','4a926d89-9bb0-4fbb-812e-21a7b4c4b3d4',100,0,TO_TIMESTAMP('2013-02-28 18:34:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201853 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:34:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,10,'N','N',58113,'Y',201854,'N','D','Logo','N','Y','d377e74b-8c97-416c-944e-120184793a5e',100,0,TO_TIMESTAMP('2013-02-28 18:34:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201854 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:34:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,1,'N','N',58381,'Y',201855,'N','If a business partner is exempt from tax on purchases, the exempt tax rate is used. For this, you need to set up a tax rate with a 0% rate and indicate that this is your tax exempt rate.  This is required for tax reporting, so that you can track tax exempt transactions.','D','Business partner is exempt from tax on purchases','PO Tax exempt','N','Y','be313995-5b93-42c6-bdea-0e2996d1cbe9',100,0,TO_TIMESTAMP('2013-02-28 18:34:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201855 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:34:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',224,10,'N','N',54463,'Y',201856,'N','EE04','Tax Group','N','Y','cb54920b-8d4b-4247-8413-a232585194d9',100,0,TO_TIMESTAMP('2013-02-28 18:34:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:34:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:34:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201856 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201850
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201851
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201853
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201854
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201855
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201856
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=201849
;

-- Feb 28, 2013 6:35:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=201852
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201850
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2442
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201851
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201853
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201854
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201855
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201856
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=2444
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=2475
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=2464
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=7622
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=2567
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=8344
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=2480
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=4622
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=2466
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=5283
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=58570
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=201849
;

-- Feb 28, 2013 6:35:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=201852
;

-- Feb 28, 2013 6:36:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLogic='@Is1099Vendor@=''Y''', ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:36:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201852
;

-- Feb 28, 2013 6:36:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:36:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201849
;

-- Feb 28, 2013 6:36:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14, IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-02-28 18:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201852
;

-- Feb 28, 2013 6:36:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-28 18:36:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201849
;

-- Feb 28, 2013 6:36:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-28 18:36:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201852
;

-- Feb 28, 2013 6:36:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Tab SET IsActive='N',Updated=TO_TIMESTAMP('2013-02-28 18:36:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=224
;

-- Feb 28, 2013 6:38:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',291,10,'N','N',208704,'Y',201857,'N','D','1099 Box','N','Y','09845e2b-d8fc-4677-ad6f-bd1034fb87f0',100,0,TO_TIMESTAMP('2013-02-28 18:38:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:38:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:38:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201857 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:38:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',291,36,'N','N',60665,'Y',201858,'N','D','C_InvoiceLine_UU','N','Y','21ebaa24-485e-460f-a711-f4cc4e043e3f',100,0,TO_TIMESTAMP('2013-02-28 18:38:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:38:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:38:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201858 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:38:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',291,1,'N','N',61470,'Y',201859,'N','D','IsFixedAssetInvoice','N','Y','d7126966-a50e-49f9-88be-24d9176320f6',100,0,TO_TIMESTAMP('2013-02-28 18:38:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:38:41','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:38:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201859 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:38:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',291,1,'N','N',56073,'Y',201860,'N','D','Processed','N','Y','4ad428d5-1607-4449-8b91-1ffa8d476a2d',100,0,TO_TIMESTAMP('2013-02-28 18:38:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:38:42','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:38:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201860 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:38:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',291,22,'N','N',52008,'Y',201861,'N','Detail information about the returned goods','D','Return Material Authorization Line','RMA Line','N','Y','609fe7a6-7f66-4dda-b27a-7bec36e3dcfe',100,0,TO_TIMESTAMP('2013-02-28 18:38:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:38:43','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:38:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201861 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201858
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201859
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201860
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201861
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=201857
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=3366
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=56252
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=56253
;

-- Feb 28, 2013 6:38:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=5825
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=56254
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=10823
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=3365
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=3374
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=10824
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=3372
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=3373
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=3364
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=6430
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=12747
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=13668
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=13669
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=13693
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=13674
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=13675
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=3370
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=8266
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=8244
;

-- Feb 28, 2013 6:39:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=8267
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201858
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=3358
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201859
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201860
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201861
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=3359
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=3362
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=3363
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=3369
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=3357
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=3371
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=3360
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201857
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=56252
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=56253
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=5825
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=56254
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=10823
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=3365
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=3374
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=10824
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=3372
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=3373
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=3364
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=6430
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=12747
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=13668
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=13669
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=13693
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=13674
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=13675
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=3370
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=8266
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=8244
;

-- Feb 28, 2013 6:39:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=8267
;

-- Feb 28, 2013 6:39:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:39:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201857
;

-- Feb 28, 2013 6:40:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',510,10,'N','N',208702,'Y',201862,'N','D','1099 Box','N','Y','73a28046-64ea-4526-8f1c-a09684b107a4',100,0,TO_TIMESTAMP('2013-02-28 18:40:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:40:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:40:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201862 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:40:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',510,40,'N','N',208703,'Y',201863,'N','D','1099 Box Value','N','Y','3017f291-8141-4d54-b9be-dd6cb83f3da0',100,0,TO_TIMESTAMP('2013-02-28 18:40:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:40:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:40:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201863 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:40:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',510,36,'N','N',60839,'Y',201864,'N','D','I_Invoice_UU','N','Y','008b715c-3385-45f0-a1db-e3d8b8a89305',100,0,TO_TIMESTAMP('2013-02-28 18:40:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 18:40:36','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 6:40:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201864 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=7210
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201864
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=7231
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=7213
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=7242
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=7245
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=7251
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=7226
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=7243
;

-- Feb 28, 2013 6:41:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=7246
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=7238
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=7216
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=7230
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=7248
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=7227
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=7223
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=7234
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=7236
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=7249
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=7221
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=7220
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=7218
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=7219
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=7637
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=7222
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=7229
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=7225
;

-- Feb 28, 2013 6:41:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=7235
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=7214
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=7635
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=7638
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=7634
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=7244
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=7639
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=7636
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=7212
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=8261
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=8260
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=7240
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=7208
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=53253
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=53254
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=7233
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=7232
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=7207
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=7228
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=7241
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=7215
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y' WHERE AD_Field_ID=7250
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y' WHERE AD_Field_ID=7209
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=7211
;

-- Feb 28, 2013 6:41:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y' WHERE AD_Field_ID=7239
;

-- Feb 28, 2013 6:41:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=53251
;

-- Feb 28, 2013 6:41:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=7237
;

-- Feb 28, 2013 6:41:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y' WHERE AD_Field_ID=7217
;

-- Feb 28, 2013 6:41:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:41:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y' WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:41:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y' WHERE AD_Field_ID=7247
;

-- Feb 28, 2013 6:41:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=580,IsDisplayed='Y' WHERE AD_Field_ID=7224
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=7210
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=7226
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201864
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=7231
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=7213
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=7242
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=7245
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=7251
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=7243
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=7246
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=7238
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=7216
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=7230
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=7248
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=7227
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=7223
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=7234
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=7236
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=7249
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=7221
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=7220
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=7218
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=7219
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=7637
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=7222
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=7229
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=7225
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=7235
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=7214
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=7635
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=7638
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=7634
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=7244
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=7639
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=7636
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=7212
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=8261
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=8260
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y' WHERE AD_Field_ID=7240
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y' WHERE AD_Field_ID=7208
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y' WHERE AD_Field_ID=53253
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y' WHERE AD_Field_ID=53254
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=480,IsDisplayedGrid='Y' WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=490,IsDisplayedGrid='Y' WHERE AD_Field_ID=7211
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=500,IsDisplayedGrid='Y' WHERE AD_Field_ID=7239
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=510,IsDisplayedGrid='Y' WHERE AD_Field_ID=53251
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=520,IsDisplayedGrid='Y' WHERE AD_Field_ID=7237
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=530,IsDisplayedGrid='Y' WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:41:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=540,IsDisplayedGrid='Y' WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:41:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=550,IsDisplayedGrid='Y' WHERE AD_Field_ID=7217
;

-- Feb 28, 2013 6:41:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=560,IsDisplayedGrid='Y' WHERE AD_Field_ID=7247
;

-- Feb 28, 2013 6:41:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=570,IsDisplayedGrid='Y' WHERE AD_Field_ID=7224
;

-- Feb 28, 2013 6:41:46 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:41:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:42:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14, IsSameLine='Y', XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:42:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:42:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-02-28 18:42:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:45:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,"action",IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200036,200041,'N','N','N','D','4fe89318-c3ec-4b52-917a-35aaa2a1d402','Y','1099 Box','W','Y',0,100,TO_TIMESTAMP('2013-02-28 18:45:32','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-02-28 18:45:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 6:45:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200041 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Feb 28, 2013 6:45:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200041, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200041)
;

-- Feb 28, 2013 6:45:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,"action",IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200042,'N','N','N',200034,'D','d6dc1c98-961b-4e15-918f-13a7ecc5ccdd','Y','1099 Extract','R','Y',0,100,TO_TIMESTAMP('2013-02-28 18:45:52','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2013-02-28 18:45:52','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 6:45:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200042 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Feb 28, 2013 6:45:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200042, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200042)
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Feb 28, 2013 6:46:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200042
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Feb 28, 2013 6:46:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Feb 28, 2013 6:46:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Feb 28, 2013 6:46:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Feb 28, 2013 6:46:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Feb 28, 2013 6:46:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=31, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=519
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53083
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200022
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=518
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200024
;

-- Feb 28, 2013 6:46:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200042
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Feb 28, 2013 6:46:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=31, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200042
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Feb 28, 2013 6:46:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200042
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=31, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Feb 28, 2013 6:46:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=32, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200042
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=31, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Feb 28, 2013 6:46:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=32, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200041
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=31, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200042
;

-- Feb 28, 2013 6:46:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=32, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Feb 28, 2013 6:49:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2013-02-28 18:49:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201840
;

-- Feb 28, 2013 6:51:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=7237
;

-- Feb 28, 2013 6:51:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=53251
;

-- Feb 28, 2013 6:51:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:51:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y' WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:51:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=510,IsDisplayedGrid='Y' WHERE AD_Field_ID=7237
;

-- Feb 28, 2013 6:51:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=520,IsDisplayedGrid='Y' WHERE AD_Field_ID=53251
;

-- Feb 28, 2013 6:51:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=530,IsDisplayedGrid='Y' WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:51:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=540,IsDisplayedGrid='Y' WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:51:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=530,IsDisplayedGrid='Y' WHERE AD_Field_ID=7217
;

-- Feb 28, 2013 6:51:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=540,IsDisplayedGrid='Y' WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:51:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=550,IsDisplayedGrid='Y' WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:52:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:52:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53251
;

-- Feb 28, 2013 6:52:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2013-02-28 18:52:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7217
;

-- Feb 28, 2013 6:52:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2013-02-28 18:52:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:52:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-02-28 18:52:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201863
;

-- Feb 28, 2013 6:52:47 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-02-28 18:52:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201862
;

-- Feb 28, 2013 6:52:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-02-28 18:52:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53251
;

-- Feb 28, 2013 6:52:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-02-28 18:52:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7217
;

-- Feb 28, 2013 6:53:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-02-28 18:53:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53251
;

-- Feb 28, 2013 6:53:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:53:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:54:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2013-02-28 18:54:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7211
;

-- Feb 28, 2013 6:54:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2013-02-28 18:54:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7239
;

-- Feb 28, 2013 6:54:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-02-28 18:54:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:54:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-02-28 18:54:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7211
;

-- Feb 28, 2013 6:54:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-02-28 18:54:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7209
;

-- Feb 28, 2013 6:54:09 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2013-02-28 18:54:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:54:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=7211
;

-- Feb 28, 2013 6:54:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:54:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=480,IsDisplayedGrid='Y' WHERE AD_Field_ID=7211
;

-- Feb 28, 2013 6:54:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=490,IsDisplayedGrid='Y' WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:54:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2013-02-28 18:54:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7211
;

-- Feb 28, 2013 6:55:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=4,Updated=TO_TIMESTAMP('2013-02-28 18:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53252
;

-- Feb 28, 2013 6:55:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-02-28 18:55:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7239
;

-- Feb 28, 2013 6:56:11 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLength=14,Updated=TO_TIMESTAMP('2013-02-28 18:56:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7247
;

-- Feb 28, 2013 6:57:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='N',Updated=TO_TIMESTAMP('2013-02-28 18:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7224
;

-- Feb 28, 2013 6:58:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 18:58:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53254
;

-- Feb 28, 2013 7:00:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',220,1,'N','N',208701,'Y',201865,'N','D','1099 Vendor','N','Y','0e7b06d4-d47a-4ce0-a5a6-8b359bd8590c',100,0,TO_TIMESTAMP('2013-02-28 19:00:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 19:00:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 7:00:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201865 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 7:00:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',220,10,'N','N',208700,'Y',201866,'N','D','Default 1099 Box','N','Y','ce66823b-82ef-4a8e-87be-2eeb02076d27',100,0,TO_TIMESTAMP('2013-02-28 19:00:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-02-28 19:00:51','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 28, 2013 7:00:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201866 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=54555
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=9606
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=10592
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=2155
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=9620
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=2160
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=57981
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=2164
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=2133
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=2141
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=2136
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=9600
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=9602
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=9624
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=9601
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=9612
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=9607
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=9622
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=9611
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=10470
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=9628
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=54556
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=9619
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=9610
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=9603
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=200622
;

-- Feb 28, 2013 7:01:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=9621
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=9608
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=201865
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=201866
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y' WHERE AD_Field_ID=9609
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y' WHERE AD_Field_ID=2124
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=3261
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=9604
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y' WHERE AD_Field_ID=9618
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=9625
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=9613
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y' WHERE AD_Field_ID=2154
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=2132
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y' WHERE AD_Field_ID=2144
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y' WHERE AD_Field_ID=2127
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=580,IsDisplayed='Y' WHERE AD_Field_ID=2146
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=590,IsDisplayed='Y' WHERE AD_Field_ID=2153
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=600,IsDisplayed='Y' WHERE AD_Field_ID=2148
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=610,IsDisplayed='Y' WHERE AD_Field_ID=2128
;

-- Feb 28, 2013 7:01:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNo=620,IsDisplayed='Y' WHERE AD_Field_ID=2135
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201865
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=2123
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201866
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=9614
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=9626
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=9623
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=2125
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=2156
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=9627
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=3261
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=2145
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=3228
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=2133
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=2136
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=2141
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=8238
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=10592
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=2155
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=2160
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=57981
;

-- Feb 28, 2013 7:01:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=54555
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=2132
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=2149
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=2144
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=2162
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=3955
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=2124
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=2164
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=2139
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=9620
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=2148
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y' WHERE AD_Field_ID=2128
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y' WHERE AD_Field_ID=2127
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y' WHERE AD_Field_ID=2146
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y' WHERE AD_Field_ID=2154
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y' WHERE AD_Field_ID=2153
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y' WHERE AD_Field_ID=2135
;

-- Feb 28, 2013 7:01:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y' WHERE AD_Field_ID=57533
;

-- Feb 28, 2013 7:01:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET AD_FieldGroup_ID=200006,Updated=TO_TIMESTAMP('2013-02-28 19:01:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201865
;

-- Feb 28, 2013 7:01:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET AD_FieldGroup_ID=200006,Updated=TO_TIMESTAMP('2013-02-28 19:01:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201866
;

-- Feb 28, 2013 7:02:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLogic='@IsVendor@=Y',Updated=TO_TIMESTAMP('2013-02-28 19:02:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201865
;

-- Feb 28, 2013 7:02:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLogic='@IsVendor@=Y', ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 19:02:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201866
;

-- Feb 28, 2013 7:02:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2013-02-28 19:02:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201865
;

-- Feb 28, 2013 7:02:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-02-28 19:02:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201866
;

-- Feb 28, 2013 7:02:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET XPosition=2,Updated=TO_TIMESTAMP('2013-02-28 19:02:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201865
;

-- Feb 28, 2013 7:03:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET DisplayLogic='@IsVendor@=Y&@Is1099Vendor@=Y',Updated=TO_TIMESTAMP('2013-02-28 19:03:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201866
;

-- Feb 28, 2013 7:08:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormat (CreateCopy,IsForm,IsDefault,AD_PrintFormat_ID,IsStandardHeaderFooter,AD_ReportView_ID,AD_PrintPaper_ID,AD_PrintColor_ID,IsTableBased,AD_Table_ID,HeaderMargin,AD_PrintFont_ID,AD_PrintFormat_UU,FooterMargin,Name,Updated,CreatedBy,Created,UpdatedBy,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('N','N','N',200002,'Y',200000,100,100,'Y',200068,0,130,'b01c8fb7-5846-4543-a64c-9222ee91328f',0,'1099 Extract',TO_TIMESTAMP('2013-02-28 19:08:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-02-28 19:08:53','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0)
;

-- Feb 28, 2013 7:09:12 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET AD_PrintPaper_ID=100, AD_PrintColor_ID=100, AD_Table_ID=200068, AD_PrintFont_ID=130, Name='RV_T_1099Extract_2',Updated=TO_TIMESTAMP('2013-02-28 19:09:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200002
;

-- Feb 28, 2013 7:09:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Name',0,'Y','Y','C',200002,'N',0,'F','N',1,208656,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Name',1,'N','462eaeb4-0e0c-401a-9bd0-460298079211',0,200086,'N',0,TO_TIMESTAMP('2013-02-28 19:09:13','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:13','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200086 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:14 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208656) WHERE AD_PrintFormatItem_ID = 200086 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208656 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200086) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Active',0,'N','N','C',200002,'N',0,'F','N',0,208649,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Active',0,'N','02ff5b1f-5eea-4a19-8f8a-00b128e67af0',0,200087,'N',0,TO_TIMESTAMP('2013-02-28 19:09:14','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:14','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200087 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:15 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208649) WHERE AD_PrintFormatItem_ID = 200087 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208649 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200087) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Address',0,'N','Y','C',200002,'N',0,'F','N',3,208658,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Address',0,'N','4dc00cfc-1534-4602-9c79-bab9580e1292',0,200088,'N',0,TO_TIMESTAMP('2013-02-28 19:09:15','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:15','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200088 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208658) WHERE AD_PrintFormatItem_ID = 200088 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208658 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200088) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Address 1',0,'N','Y','C',200002,'N',0,'F','N',4,208659,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Address 1',0,'N','cf5653d5-872b-4841-89c1-9072f1de9049',0,200089,'N',0,TO_TIMESTAMP('2013-02-28 19:09:16','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:16','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200089 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:17 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208659) WHERE AD_PrintFormatItem_ID = 200089 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208659 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200089) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Address 2',0,'N','Y','C',200002,'N',0,'F','N',5,208660,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Address 2',0,'N','f008554a-71a5-4d27-bbb0-6e5b53a56539',0,200090,'N',0,TO_TIMESTAMP('2013-02-28 19:09:18','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:18','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200090 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208660) WHERE AD_PrintFormatItem_ID = 200090 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208660 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200090) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Address 3',0,'N','Y','C',200002,'N',0,'F','N',6,208661,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Address 3',0,'N','15f2b60f-ddb5-4f46-b2f5-4a0a2e38a91b',0,200091,'N',0,TO_TIMESTAMP('2013-02-28 19:09:19','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:19','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200091 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208661) WHERE AD_PrintFormatItem_ID = 200091 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208661 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200091) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Address 4',0,'N','Y','C',200002,'N',0,'F','N',7,208662,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Address 4',0,'N','08fc0220-e41f-4cda-9d84-f9660eefa7f4',0,200092,'N',0,TO_TIMESTAMP('2013-02-28 19:09:20','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:20','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200092 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208662) WHERE AD_PrintFormatItem_ID = 200092 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208662 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200092) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 1',0,'N','Y','C',200002,'N',0,'F','N',8,208670,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 1',0,'N','e5d5a283-e331-432b-acc2-5bf8af510c85',0,200093,'N',0,TO_TIMESTAMP('2013-02-28 19:09:21','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:21','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200093 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208670) WHERE AD_PrintFormatItem_ID = 200093 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208670 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200093) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 10',0,'N','Y','C',200002,'N',0,'F','N',9,208679,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 10',0,'N','2991916b-7b3e-4c6c-9e80-08657a32a87d',0,200094,'N',0,TO_TIMESTAMP('2013-02-28 19:09:25','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:25','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200094 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208679) WHERE AD_PrintFormatItem_ID = 200094 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208679 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200094) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 11',0,'N','Y','C',200002,'N',0,'F','N',10,208680,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 11',0,'N','3347926a-1833-4d0d-b9e4-8a5026c4f402',0,200095,'N',0,TO_TIMESTAMP('2013-02-28 19:09:26','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:26','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200095 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:27 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208680) WHERE AD_PrintFormatItem_ID = 200095 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208680 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200095) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 12',0,'N','Y','C',200002,'N',0,'F','N',11,208681,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 12',0,'N','7ddd1ed4-8b6f-418c-bbda-607fb46c452f',0,200096,'N',0,TO_TIMESTAMP('2013-02-28 19:09:27','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:27','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200096 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:28 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208681) WHERE AD_PrintFormatItem_ID = 200096 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208681 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200096) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 13',0,'N','Y','C',200002,'N',0,'F','N',12,208682,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 13',0,'N','ace86336-6342-4585-97e3-c537a4b43214',0,200097,'N',0,TO_TIMESTAMP('2013-02-28 19:09:28','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:28','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200097 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:29 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208682) WHERE AD_PrintFormatItem_ID = 200097 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208682 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200097) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 14',0,'N','Y','C',200002,'N',0,'F','N',13,208683,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 14',0,'N','5f6f8594-d760-4ed6-b964-3f80646e13c8',0,200098,'N',0,TO_TIMESTAMP('2013-02-28 19:09:29','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:29','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200098 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208683) WHERE AD_PrintFormatItem_ID = 200098 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208683 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200098) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 15',0,'N','Y','C',200002,'N',0,'F','N',14,208684,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 15',0,'N','74628a15-a658-41dd-ac75-ac2b3cc900f2',0,200099,'N',0,TO_TIMESTAMP('2013-02-28 19:09:30','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:30','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200099 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:31 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208684) WHERE AD_PrintFormatItem_ID = 200099 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208684 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200099) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 16',0,'N','Y','C',200002,'N',0,'F','N',15,208685,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 16',0,'N','d1d6071b-f98d-46e8-9bf0-a5020c7dd4f5',0,200100,'N',0,TO_TIMESTAMP('2013-02-28 19:09:31','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:31','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200100 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:32 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208685) WHERE AD_PrintFormatItem_ID = 200100 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208685 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200100) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 2',0,'N','Y','C',200002,'N',0,'F','N',16,208671,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 2',0,'N','81d4788a-e624-41c8-a712-0b2371ab056f',0,200101,'N',0,TO_TIMESTAMP('2013-02-28 19:09:32','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:32','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200101 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:33 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208671) WHERE AD_PrintFormatItem_ID = 200101 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208671 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200101) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 3',0,'N','Y','C',200002,'N',0,'F','N',17,208672,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 3',0,'N','eaa00a53-5cbc-4f7d-bbfd-bf31946e16a0',0,200102,'N',0,TO_TIMESTAMP('2013-02-28 19:09:33','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:33','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200102 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:34 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208672) WHERE AD_PrintFormatItem_ID = 200102 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208672 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200102) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 4',0,'N','Y','C',200002,'N',0,'F','N',18,208673,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 4',0,'N','b6dfb300-1956-4285-8c2e-b5abdb7e943c',0,200103,'N',0,TO_TIMESTAMP('2013-02-28 19:09:34','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:34','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200103 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208673) WHERE AD_PrintFormatItem_ID = 200103 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208673 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200103) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 5',0,'N','Y','C',200002,'N',0,'F','N',19,208674,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 5',0,'N','f01e3057-d8fa-4987-8722-ae69ad9ac96d',0,200104,'N',0,TO_TIMESTAMP('2013-02-28 19:09:35','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:35','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200104 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208674) WHERE AD_PrintFormatItem_ID = 200104 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208674 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200104) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 6',0,'N','Y','C',200002,'N',0,'F','N',20,208675,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 6',0,'N','9596366d-0951-47f0-b673-624b509253d9',0,200105,'N',0,TO_TIMESTAMP('2013-02-28 19:09:36','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:36','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200105 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208675) WHERE AD_PrintFormatItem_ID = 200105 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208675 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200105) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 7',0,'N','Y','C',200002,'N',0,'F','N',21,208676,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 7',0,'N','559a08ac-2794-4879-b8cb-17b51537c1fe',0,200106,'N',0,TO_TIMESTAMP('2013-02-28 19:09:37','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:37','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200106 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208676) WHERE AD_PrintFormatItem_ID = 200106 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208676 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200106) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 8',0,'N','Y','C',200002,'N',0,'F','N',22,208677,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 8',0,'N','968c4a3f-9364-49f2-8f64-b2c2231b146e',0,200107,'N',0,TO_TIMESTAMP('2013-02-28 19:09:38','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:38','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200107 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208677) WHERE AD_PrintFormatItem_ID = 200107 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208677 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200107) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Amount Bucket 9',0,'N','Y','C',200002,'N',0,'F','N',23,208678,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Amount Bucket 9',0,'N','a3478eab-3923-4475-974a-9527e20686fe',0,200108,'N',0,TO_TIMESTAMP('2013-02-28 19:09:39','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:39','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200108 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208678) WHERE AD_PrintFormatItem_ID = 200108 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208678 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200108) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Business Partner ',0,'N','Y','C',200002,'N',0,'F','N',24,208654,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Business Partner ',0,'N','d9ea53b9-c359-4e66-b804-6b04a6def4a8',0,200109,'N',0,TO_TIMESTAMP('2013-02-28 19:09:40','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:40','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200109 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208654) WHERE AD_PrintFormatItem_ID = 200109 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208654 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200109) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('City',0,'N','Y','C',200002,'N',0,'F','N',25,208664,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','City',0,'N','17a34303-29d9-4aa6-8bbe-15cca5bd1d96',0,200110,'N',0,TO_TIMESTAMP('2013-02-28 19:09:41','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:41','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200110 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208664) WHERE AD_PrintFormatItem_ID = 200110 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208664 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200110) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('City State Zip',0,'N','Y','C',200002,'N',0,'F','N',26,208663,'X',0,'B','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','City State Zip',0,'N','3fbef02b-4409-4721-8969-e74a4895458f',0,200111,'N',0,TO_TIMESTAMP('2013-02-28 19:09:42','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:42','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200111 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208663) WHERE AD_PrintFormatItem_ID = 200111 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208663 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200111) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Client',0,'N','N','C',200002,'N',0,'F','N',0,208647,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Client',0,'N','a806b83b-62ac-4170-b673-61c164747c29',0,200112,'N',0,TO_TIMESTAMP('2013-02-28 19:09:43','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:43','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200112 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208647) WHERE AD_PrintFormatItem_ID = 200112 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208647 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200112) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Country',0,'N','Y','C',200002,'N',0,'F','N',28,208667,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Country',0,'N','749bf9d9-54e2-4371-9fea-aa0ca506fd14',0,200113,'N',0,TO_TIMESTAMP('2013-02-28 19:09:44','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:44','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200113 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208667) WHERE AD_PrintFormatItem_ID = 200113 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208667 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200113) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Created',0,'N','N','C',200002,'N',0,'F','N',0,208650,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Created',0,'N','bef4d265-9e6a-471d-a925-2ea54f39a248',0,200114,'N',0,TO_TIMESTAMP('2013-02-28 19:09:45','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:45','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200114 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208650) WHERE AD_PrintFormatItem_ID = 200114 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208650 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200114) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Created By',0,'N','N','C',200002,'N',0,'F','N',0,208651,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Created By',0,'N','624fa07f-e24e-467f-bf4e-cae90435b9c9',0,200115,'N',0,TO_TIMESTAMP('2013-02-28 19:09:49','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:49','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200115 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:50 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208651) WHERE AD_PrintFormatItem_ID = 200115 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208651 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200115) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Cut Date',0,'N','Y','C',200002,'N',0,'F','N',31,208669,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Cut Date',0,'N','175f1a41-cb24-4089-943f-b808a54d6e7d',0,200116,'N',0,TO_TIMESTAMP('2013-02-28 19:09:50','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:50','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200116 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208669) WHERE AD_PrintFormatItem_ID = 200116 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208669 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200116) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Cut Year',0,'N','Y','C',200002,'N',0,'F','N',32,208668,'X',0,'T','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Cut Year',0,'N','b44919b5-8a2c-4854-94c1-c98c8927e2d1',0,200117,'N',0,TO_TIMESTAMP('2013-02-28 19:09:51','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:51','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200117 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208668) WHERE AD_PrintFormatItem_ID = 200117 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208668 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200117) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Organization',0,'N','N','C',200002,'N',0,'F','N',0,208648,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Organization',0,'N','1d91444f-d1c7-49a0-a9b3-c02a06b51e0f',0,200118,'N',0,TO_TIMESTAMP('2013-02-28 19:09:52','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:52','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200118 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208648) WHERE AD_PrintFormatItem_ID = 200118 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208648 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200118) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Process Instance',0,'N','Y','C',200002,'N',0,'F','N',34,208646,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Process Instance',0,'N','4e7dfbea-16b2-46db-9459-16bb44e843ca',0,200119,'N',0,TO_TIMESTAMP('2013-02-28 19:09:53','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:53','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200119 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208646) WHERE AD_PrintFormatItem_ID = 200119 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208646 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200119) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('region',0,'N','Y','C',200002,'N',0,'F','N',35,208665,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','region',0,'N','c4911e30-c3b3-49eb-9e3d-1d6ac6eff5c3',0,200120,'N',0,TO_TIMESTAMP('2013-02-28 19:09:54','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:54','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200120 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208665) WHERE AD_PrintFormatItem_ID = 200120 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208665 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200120) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:09:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Search Key',0,'N','Y','C',200002,'N',0,'F','N',36,208655,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Search Key',0,'N','d544205b-8f42-4b07-8e7f-d7309da97197',0,200121,'N',0,TO_TIMESTAMP('2013-02-28 19:09:58','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:58','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:09:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200121 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:09:59 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208655) WHERE AD_PrintFormatItem_ID = 200121 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208655 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200121) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:10:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Tax ID',0,'N','Y','C',200002,'N',0,'F','N',37,208657,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Tax ID',0,'N','a5dbd31d-4740-4ceb-b8f3-bc98549252b8',0,200122,'N',0,TO_TIMESTAMP('2013-02-28 19:09:59','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:09:59','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:10:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200122 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:10:00 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208657) WHERE AD_PrintFormatItem_ID = 200122 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208657 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200122) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:10:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Updated',0,'N','N','C',200002,'N',0,'F','N',0,208652,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Updated',0,'N','6aebbb2e-9756-4584-bcf5-272c3eb21844',0,200123,'N',0,TO_TIMESTAMP('2013-02-28 19:10:00','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:10:00','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:10:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200123 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:10:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208652) WHERE AD_PrintFormatItem_ID = 200123 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208652 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200123) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:10:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Updated By',0,'N','N','C',200002,'N',0,'F','N',0,208653,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Updated By',0,'N','09ab74ff-5e56-484e-8947-e0a94bdbd2bc',0,200124,'N',0,TO_TIMESTAMP('2013-02-28 19:10:01','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:10:01','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:10:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200124 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:10:02 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208653) WHERE AD_PrintFormatItem_ID = 200124 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208653 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200124) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:10:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem (Name,XPosition,IsOrderBy,IsPrinted,PrintAreaType,AD_PrintFormat_ID,IsGroupBy,MaxHeight,PrintFormatType,ImageIsAttached,SeqNo,AD_Column_ID,LineAlignmentType,XSpace,FieldAlignmentType,IsRelativePosition,IsPageBreak,YPosition,IsSuppressNull,IsFixedWidth,IsNextLine,IsFilledRectangle,LineWidth,IsNextPage,IsCentrallyMaintained,IsVarianceCalc,IsImageField,ArcDiameter,ShapeType,IsMaxCalc,IsMinCalc,IsSummarized,IsAveraged,IsCounted,IsDeviationCalc,IsRunningTotal,PrintName,SortNo,IsHeightOneLine,AD_PrintFormatItem_UU,YSpace,AD_PrintFormatItem_ID,IsSetNLPosition,MaxWidth,Updated,UpdatedBy,AD_Client_ID,CreatedBy,Created,AD_Org_ID,IsActive) VALUES ('Zip',0,'N','Y','C',200002,'N',0,'F','N',40,208666,'X',0,'L','Y','N',0,'N','N','N','N',1,'N','Y','N','N',0,'N','N','N','N','N','N','N','N','Zip',0,'N','e697164c-2e56-4205-9e81-0f7f3fa0b56c',0,200125,'N',0,TO_TIMESTAMP('2013-02-28 19:10:02','YYYY-MM-DD HH24:MI:SS'),100,0,100,TO_TIMESTAMP('2013-02-28 19:10:02','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Feb 28, 2013 7:10:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
INSERT INTO AD_PrintFormatItem_Trl (AD_Language,AD_PrintFormatItem_ID, Name,PrintName,PrintNameSuffix, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_PrintFormatItem_Trl_UU ) SELECT l.AD_Language,t.AD_PrintFormatItem_ID, t.Name,t.PrintName,t.PrintNameSuffix, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_PrintFormatItem t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_PrintFormatItem_ID=200125 AND NOT EXISTS (SELECT * FROM AD_PrintFormatItem_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_PrintFormatItem_ID=t.AD_PrintFormatItem_ID)
;

-- Feb 28, 2013 7:10:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET PrintName = (SELECT e.PrintName FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208666) WHERE AD_PrintFormatItem_ID = 200125 AND EXISTS (SELECT * FROM AD_Element_Trl e, AD_Column c WHERE e.AD_Language=AD_PrintFormatItem_Trl.AD_Language AND e.AD_Element_ID=c.AD_Element_ID AND c.AD_Column_ID=208666 AND AD_PrintFormatItem_Trl.AD_PrintFormatItem_ID = 200125) AND EXISTS (SELECT * FROM AD_Client WHERE AD_Client_ID=AD_PrintFormatItem_Trl.AD_Client_ID AND IsMultiLingualDocument='Y')
;

-- Feb 28, 2013 7:10:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET AD_PrintFont_ID=160,Updated=TO_TIMESTAMP('2013-02-28 19:10:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200002
;

-- Feb 28, 2013 7:10:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormat SET Name='1099 Extract',Updated=TO_TIMESTAMP('2013-02-28 19:10:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormat_ID=200002
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200088
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200109
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200110
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200116
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200119
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200121
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200125
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=0,IsPrinted='N' WHERE AD_PrintFormatItem_ID=200120
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=10,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200086
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=20,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200089
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=30,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200090
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=40,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200091
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=50,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200092
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=60,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200111
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=70,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200113
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=80,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200122
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=90,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200117
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=100,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200093
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=110,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200101
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=120,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200102
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=130,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200103
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=140,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200104
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=150,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200105
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=160,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200106
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=170,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200107
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=180,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200108
;

-- Feb 28, 2013 7:11:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=190,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200094
;

-- Feb 28, 2013 7:11:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=200,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200095
;

-- Feb 28, 2013 7:11:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=210,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200096
;

-- Feb 28, 2013 7:11:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=220,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200097
;

-- Feb 28, 2013 7:11:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=230,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200098
;

-- Feb 28, 2013 7:11:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=240,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200099
;

-- Feb 28, 2013 7:11:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET SeqNo=250,IsPrinted='Y' WHERE AD_PrintFormatItem_ID=200100
;

-- Feb 28, 2013 7:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element SET ColumnName='Region', Name='Region', PrintName='Region',Updated=TO_TIMESTAMP('2013-02-28 19:13:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202243
;

-- Feb 28, 2013 7:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202243
;

-- Feb 28, 2013 7:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Column SET ColumnName='Region', Name='Region', Description=NULL, Help=NULL WHERE AD_Element_ID=202243
;

-- Feb 28, 2013 7:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Region', Name='Region', Description=NULL, Help=NULL, AD_Element_ID=202243 WHERE UPPER(ColumnName)='REGION' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 28, 2013 7:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Process_Para SET ColumnName='Region', Name='Region', Description=NULL, Help=NULL WHERE AD_Element_ID=202243 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 7:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_InfoColumn SET ColumnName='Region', Name='Region', Description=NULL, Help=NULL WHERE AD_Element_ID=202243 AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 7:13:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_Field SET Name='Region', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202243) AND IsCentrallyMaintained='Y'
;

-- Feb 28, 2013 7:13:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET PrintName='Region', Name='Region' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202243)
;

-- Feb 28, 2013 7:14:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Year', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:14:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200117
;

-- Feb 28, 2013 7:14:49 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200117
;

-- Feb 28, 2013 7:14:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 1/10', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:14:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200093
;

-- Feb 28, 2013 7:14:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200093
;

-- Feb 28, 2013 7:14:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 2/13', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:14:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200101
;

-- Feb 28, 2013 7:14:58 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200101
;

-- Feb 28, 2013 7:15:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 3/14', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200102
;

-- Feb 28, 2013 7:15:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200102
;

-- Feb 28, 2013 7:15:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 4/15a', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200103
;

-- Feb 28, 2013 7:15:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200103
;

-- Feb 28, 2013 7:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 5/15b', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200104
;

-- Feb 28, 2013 7:15:16 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200104
;

-- Feb 28, 2013 7:15:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 6/16', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200105
;

-- Feb 28, 2013 7:15:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200105
;

-- Feb 28, 2013 7:15:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 7/17', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200106
;

-- Feb 28, 2013 7:15:26 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200106
;

-- Feb 28, 2013 7:15:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 8/18', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200107
;

-- Feb 28, 2013 7:15:30 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200107
;

-- Feb 28, 2013 7:15:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 10', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200108
;

-- Feb 28, 2013 7:15:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200108
;

-- Feb 28, 2013 7:15:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 13', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200094
;

-- Feb 28, 2013 7:15:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200094
;

-- Feb 28, 2013 7:15:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 14', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200095
;

-- Feb 28, 2013 7:15:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200095
;

-- Feb 28, 2013 7:15:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 15a', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200096
;

-- Feb 28, 2013 7:15:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200096
;

-- Feb 28, 2013 7:15:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 15b', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200097
;

-- Feb 28, 2013 7:15:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200097
;

-- Feb 28, 2013 7:15:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 16', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:15:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200098
;

-- Feb 28, 2013 7:15:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200098
;

-- Feb 28, 2013 7:16:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 17', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200099
;

-- Feb 28, 2013 7:16:01 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200099
;

-- Feb 28, 2013 7:16:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, PrintName='Box 18', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200100
;

-- Feb 28, 2013 7:16:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem_Trl SET IsTranslated='N' WHERE AD_PrintFormatItem_ID=200100
;

-- Feb 28, 2013 7:16:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200089
;

-- Feb 28, 2013 7:16:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200090
;

-- Feb 28, 2013 7:16:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200091
;

-- Feb 28, 2013 7:16:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200092
;

-- Feb 28, 2013 7:16:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200111
;

-- Feb 28, 2013 7:16:23 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200113
;

-- Feb 28, 2013 7:16:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200108
;

-- Feb 28, 2013 7:16:52 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200094
;

-- Feb 28, 2013 7:16:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200095
;

-- Feb 28, 2013 7:16:53 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200096
;

-- Feb 28, 2013 7:16:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200097
;

-- Feb 28, 2013 7:16:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200098
;

-- Feb 28, 2013 7:16:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:16:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200099
;

-- Feb 28, 2013 7:17:35 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsSuppressNull='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200100
;

-- Feb 28, 2013 7:17:36 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200089
;

-- Feb 28, 2013 7:17:37 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200090
;

-- Feb 28, 2013 7:17:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200091
;

-- Feb 28, 2013 7:17:38 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200092
;

-- Feb 28, 2013 7:17:39 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200111
;

-- Feb 28, 2013 7:17:40 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200113
;

-- Feb 28, 2013 7:17:42 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=1, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200089
;

-- Feb 28, 2013 7:17:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=1, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200090
;

-- Feb 28, 2013 7:17:43 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=1, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200091
;

-- Feb 28, 2013 7:17:44 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=1, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200092
;

-- Feb 28, 2013 7:17:45 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=1, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200111
;

-- Feb 28, 2013 7:17:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=1, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200113
;

-- Feb 28, 2013 7:17:54 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200100
;

-- Feb 28, 2013 7:17:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200099
;

-- Feb 28, 2013 7:17:55 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200098
;

-- Feb 28, 2013 7:17:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200097
;

-- Feb 28, 2013 7:17:56 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200096
;

-- Feb 28, 2013 7:17:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200095
;

-- Feb 28, 2013 7:17:57 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:17:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200094
;

-- Feb 28, 2013 7:18:18 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsNextLine='Y', BelowColumn=10, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200108
;

-- Feb 28, 2013 7:18:19 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=11, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200094
;

-- Feb 28, 2013 7:18:20 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=12, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200095
;

-- Feb 28, 2013 7:18:21 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=13, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200096
;

-- Feb 28, 2013 7:18:22 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=14, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200097
;

-- Feb 28, 2013 7:18:24 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=15, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200098
;

-- Feb 28, 2013 7:18:25 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=16, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200099
;

-- Feb 28, 2013 7:18:41 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, BelowColumn=17, SortNo=0,Updated=TO_TIMESTAMP('2013-02-28 19:18:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200100
;

-- Feb 28, 2013 7:18:48 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, YPosition=0, MaxWidth=180,Updated=TO_TIMESTAMP('2013-02-28 19:18:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200086
;

-- Feb 28, 2013 7:18:51 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, MaxWidth=64,Updated=TO_TIMESTAMP('2013-02-28 19:18:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200122
;

-- Feb 28, 2013 7:19:03 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, IsFixedWidth='Y', SortNo=0, MaxWidth=24,Updated=TO_TIMESTAMP('2013-02-28 19:19:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200117
;

-- Feb 28, 2013 7:19:04 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200089
;

-- Feb 28, 2013 7:19:05 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200090
;

-- Feb 28, 2013 7:19:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200091
;

-- Feb 28, 2013 7:19:06 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200092
;

-- Feb 28, 2013 7:19:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200111
;

-- Feb 28, 2013 7:19:07 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200113
;

-- Feb 28, 2013 7:19:08 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200122
;

-- Feb 28, 2013 7:19:13 PM SGT
-- Ticket 1001763: Standard Templates for Docs and Forms - Reporting
UPDATE AD_PrintFormatItem SET XPosition=0, IsGroupBy='N', IsPageBreak='N', YPosition=0, SortNo=0, IsHeightOneLine='Y',Updated=TO_TIMESTAMP('2013-02-28 19:19:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_PrintFormatItem_ID=200117
;

CREATE OR REPLACE FUNCTION asu_get1099bucket (
   p_cbpartner_id   IN   numeric,
   p_cut_date       IN   timestamp with time zone,
   p_bucket         IN   numeric
)
   RETURNS numeric
AS
$BODY$
DECLARE
   tmpvar   numeric;
/******************************************************************************
   NAME:       asu_get1099bucket
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        04/01/2008  Carlos Ruiz      1. Created this function.

******************************************************************************/
BEGIN
   SELECT SUM (  (COALESCE (linenetamt, 0) + COALESCE (taxamt, 0))
               * (CASE WHEN docbasetype = 'API' THEN 1 
					CASE WHEN docbasetype = 'APC' THEN -1
					ELSE 0 END)
              )            -- +API->AP Invoice / -APC->AP Credit Memo
     INTO tmpvar
     FROM C_INVOICE i, C_INVOICELINE il, ASU_1099BOX b, C_DOCTYPE dt
    WHERE i.c_invoice_id = il.c_invoice_id
      AND i.issotrx = 'N'
      AND il.asu_1099box_id = b.asu_1099box_id
      AND i.dateacct BETWEEN TRUNC (p_cut_date, 'YEAR') AND p_cut_date
      AND c_bpartner_id = p_cbpartner_id
      AND b.bucket = p_bucket
      AND i.c_doctype_id = dt.c_doctype_id
      AND i.docstatus IN ('CO', 'CL');

   RETURN tmpvar;
END;
$BODY$
   LANGUAGE plpgsql VOLATILE
   COST 100;

SELECT register_migration_script('201303041619_TICKET-1001763_1099Extract.sql') FROM dual
;