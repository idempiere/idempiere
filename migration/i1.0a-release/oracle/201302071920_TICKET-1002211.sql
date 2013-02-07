-- Feb 5, 2013 2:19:30 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','7',130,200063,'Y','N','N','D','L','c0367ce2-d6c4-4aab-9bef-290e377d7267','Y','Y','AD_CtxHelp',NULL,'Help Context',0,'Y',0,TO_DATE('2013-02-05 14:19:29','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-02-05 14:19:29','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 5, 2013 2:19:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200063 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Feb 5, 2013 2:19:32 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200058,'ae7c3aa5-b955-414a-9d45-b7af4d7e36ae','Table AD_CtxHelp','AD_CtxHelp',1,0,0,TO_DATE('2013-02-05 14:19:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-05 14:19:31','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Feb 5, 2013 2:19:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208531,'D','Y','N','N','N',22,'N',19,'N',102,'N','Y','73092a9b-52b2-4c69-a194-962294d40e46','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2013-02-05 14:19:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:39','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:40 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208531 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_CtxHelp_ID',202212,'D','Help Context','Help Context','270a8288-7981-4ad1-825a-b199282923ad',0,TO_DATE('2013-02-05 14:19:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:19:40','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 5, 2013 2:19:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202212 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 5, 2013 2:19:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208532,'D','Y','N','N',0,'N',22,'N',13,'Y',202212,'N','Y','6877648e-c18c-4c21-944b-f06c041e039f','N','AD_CtxHelp_ID','Help Context','N',100,TO_DATE('2013-02-05 14:19:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208532 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:43 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_CtxHelp_UU',202213,'D','AD_CtxHelp_UU','AD_CtxHelp_UU','82900a06-20c5-4206-a48a-2971eef050c9',0,TO_DATE('2013-02-05 14:19:42','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:19:42','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 5, 2013 2:19:43 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202213 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 5, 2013 2:19:44 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1.00,'N',200063,208533,'D','N','N','N','N',36,'N',10,'N',202213,'N','Y','88b839e1-dd88-4ba4-adeb-660b88160b0a','Y','AD_CtxHelp_UU','AD_CtxHelp_UU','N',100,TO_DATE('2013-02-05 14:19:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:42','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:44 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208533 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208534,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','28cc09cb-e123-49b6-b833-f901fa8847a9','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2013-02-05 14:19:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:44','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208534 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208535,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','ef17b263-190e-42ea-8ac9-d73bffd55209','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2013-02-05 14:19:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:45','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208535 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208536,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','6a61c584-ade3-4b3c-95e8-669d4db324e9','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2013-02-05 14:19:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:46','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208536 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208537,'D',389,'Y','N','N',0,'N',40,'N',18,'N',1682,'@EntityType@=D','N','Y','ff0fae2e-1904-474b-a3ba-eba92343bba4','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','U','The Entity Types "Dictionary", "Adempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',100,TO_DATE('2013-02-05 14:19:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:47 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208537 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208538,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','55d86f90-e570-4e91-8bef-9c15e488a07d','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2013-02-05 14:19:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208538 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208539,'D','Y','Y','N',0,'N',2000,'Y',14,'N',463,'N','Y','964a8267-60be-4339-99e0-4b50a19e26d3','Y','MsgText','Textual Informational, Menu or Error Message','The Message Text indicates the message that will display ','Message Text','Y',100,TO_DATE('2013-02-05 14:19:48','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:48','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208539 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208540,'D','N','Y','N','N',2000,'Y',14,'N',464,'N','Y','07c51446-f4ee-4551-8b5f-3237a5f362a8','Y','MsgTip','Additional tip or help for this message','The Message Tip defines additional help or information about this message.','Message Tip','Y',100,TO_DATE('2013-02-05 14:19:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:49','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208540 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:52 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208541,'D',103,'Y','N','N','N',1,'N',17,'N',465,'N','Y','b08665de-c18a-4abe-a7a3-f8e772c8a0c4','Y','MsgType','Type of message (Informational, Menu or Error)','I','The Message Type indicates the type of message being defined.  Valid message types are Informational, Menu and Error.','Message Type','Y',100,TO_DATE('2013-02-05 14:19:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:51','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:52 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208541 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208542,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','b1f5d411-8007-4202-97cf-4fb7e088d4ce','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2013-02-05 14:19:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:52','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208542 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208543,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','24bc96e2-2848-4009-86b0-703456f707b2','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2013-02-05 14:19:53','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:53','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208543 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:19:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200063,208544,'D','Y','N','Y',1,'N',255,'Y',10,'N',620,'N','Y','b7f5fc87-2461-476a-bd2f-a1c4dc9352ea','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_DATE('2013-02-05 14:19:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:19:54','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:19:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208544 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:20:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208537
;

-- Feb 5, 2013 2:20:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208537
;

-- Feb 5, 2013 2:20:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208539
;

-- Feb 5, 2013 2:20:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208539
;

-- Feb 5, 2013 2:20:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208540
;

-- Feb 5, 2013 2:20:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208540
;

-- Feb 5, 2013 2:20:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208544
;

-- Feb 5, 2013 2:20:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208544
;

-- Feb 5, 2013 2:29:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208541
;

-- Feb 5, 2013 2:29:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208541
;

-- Feb 5, 2013 2:30:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('CtxType',202214,'D','Content Type','Content Type','6e7c656b-8dea-484c-afe3-5f8991cb24ed',0,TO_DATE('2013-02-05 14:30:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:30:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 5, 2013 2:30:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202214 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 5, 2013 2:30:38 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Client_ID,AD_Org_ID,Updated,CreatedBy,IsActive,Created,UpdatedBy) VALUES (200064,'AD_CtxHelp CtxType','D','67d6ad25-ce88-4a4a-a94a-ab8a4615ce2b','N','L',0,0,TO_DATE('2013-02-05 14:30:37','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2013-02-05 14:30:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 5, 2013 2:30:38 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200064 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Feb 5, 2013 2:30:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200126,200064,'D','Tab','9f05baa2-95a5-4dd8-8e98-325d3a99ed8a','T',100,TO_DATE('2013-02-05 14:30:45','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:30:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Feb 5, 2013 2:30:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200126 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Feb 5, 2013 2:30:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200127,200064,'D','Process','23ad31bb-d366-462c-a8ac-d6b4f7b8698c','P',100,TO_DATE('2013-02-05 14:30:56','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:30:56','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Feb 5, 2013 2:30:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200127 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Feb 5, 2013 2:31:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200128,200064,'D','Form','20d41f7f-b9d9-4167-b08f-21961f12a046','F',100,TO_DATE('2013-02-05 14:31:02','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:31:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Feb 5, 2013 2:31:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200128 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Feb 5, 2013 2:31:23 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208545,'D',200064,'Y','N','N',0,'N',1,'N',17,'N',202214,'N','Y','7f09dd5b-369c-4ae5-b04f-c67379e75bc2','Y','CtxType','Content Type','Y',100,TO_DATE('2013-02-05 14:31:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:31:23','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:31:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208545 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:36:52 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208546,'D','N','N','N',0,'N',10,'N',19,'N',125,'N','Y','@CtxType@=''T''','eb7ee643-1b97-4b68-b0aa-b91381ef0284','Y','AD_Tab_ID','Tab within a Window','The Tab indicates a tab that displays within a window.','Tab','Y',100,TO_DATE('2013-02-05 14:36:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:36:52','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:36:52 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208546 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:37:40 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208547,'D','N','N','N',0,'N',10,'N',19,'N',117,'N','Y','@CtxType@=''P''','5029d5e0-c4ff-4ba5-8dd0-98e133fe293c','Y','AD_Process_ID','Process or Report','The Process field identifies a unique Process or Report in the system.','Process','Y',100,TO_DATE('2013-02-05 14:37:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:37:39','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:37:40 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208547 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:38:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208548,'D','N','N','N',0,'N',10,'N',19,'N',1298,'N','Y','@CtxType@=''F''','8b2e5eb2-382c-4aa4-a255-46262a060918','Y','AD_Form_ID','Special Form','The Special Form field identifies a unique Special Form in the system.','Special Form','Y',100,TO_DATE('2013-02-05 14:38:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:38:35','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:38:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208548 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:40:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208549,'D','Y','N','N',0,'N',120,'N',10,'N',469,'N','Y','ad79dbcd-1690-4398-8476-ded9ba68be26','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_DATE('2013-02-05 14:40:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:40:41','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:40:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208549 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:41:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208550,'D','N','N','N',0,'N',255,'N',14,'N',275,'N','Y','ffa6904e-9edc-4a24-bd3c-df7cf6d7cbc2','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_DATE('2013-02-05 14:41:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:41:08','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:41:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208550 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:41:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
CREATE TABLE AD_CtxHelp (AD_Client_ID NUMBER(10) NOT NULL, AD_CtxHelp_ID NUMBER(10) NOT NULL, AD_CtxHelp_UU NVARCHAR2(36) DEFAULT NULL , AD_Form_ID NUMBER(10) DEFAULT NULL , AD_Org_ID NUMBER(10) NOT NULL, AD_Process_ID NUMBER(10) DEFAULT NULL , AD_Tab_ID NUMBER(10) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, CtxType CHAR(1) NOT NULL, Description NVARCHAR2(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name NVARCHAR2(120) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_CtxHelp_Key PRIMARY KEY (AD_CtxHelp_ID))
;

-- Feb 5, 2013 2:41:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','7',130,200064,'Y','N','N','D','L','017c7ca2-7c0e-413f-8fa3-96bd27dfa3c1','Y','Y','AD_CtxHelpMsg','Help Context Message',0,'Y',0,TO_DATE('2013-02-05 14:41:55','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-02-05 14:41:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 5, 2013 2:41:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200064 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Feb 5, 2013 2:41:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200059,'067e6cb4-2028-406c-b8e6-338d5df797eb','Table AD_CtxHelpMsg','AD_CtxHelpMsg',1,0,0,TO_DATE('2013-02-05 14:41:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-05 14:41:56','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Feb 5, 2013 2:42:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208551,'D','Y','N','N','N',22,'N',19,'N',102,'N','Y','fe592707-3f96-4bf1-b2e6-9f5310f216d9','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2013-02-05 14:42:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:05','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208551 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_CtxHelpMsg_ID',202215,'D','Help Context Message','Help Context Message','ea5c42bd-ea25-446b-af43-5992a928863d',0,TO_DATE('2013-02-05 14:42:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:42:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 5, 2013 2:42:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202215 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 5, 2013 2:42:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208552,'D','Y','N','N',0,'N',22,'N',13,'Y',202215,'N','Y','08aa3d15-073f-4676-99c2-8ec0181a2c49','N','AD_CtxHelpMsg_ID','Help Context Message','N',100,TO_DATE('2013-02-05 14:42:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:06','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208552 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_CtxHelpMsg_UU',202216,'D','AD_CtxHelpMsg_UU','AD_CtxHelpMsg_UU','557614a8-6326-40f3-9e9a-d92d231a38bd',0,TO_DATE('2013-02-05 14:42:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:42:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 5, 2013 2:42:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202216 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 5, 2013 2:42:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1.00,'N',200064,208553,'D','N','N','N','N',36,'N',10,'N',202216,'N','Y','f7a5826e-ff59-4645-8dc2-888333987421','Y','AD_CtxHelpMsg_UU','AD_CtxHelpMsg_UU','N',100,TO_DATE('2013-02-05 14:42:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:07','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208553 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208554,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','8124d7b3-0491-4569-861c-859722f01190','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2013-02-05 14:42:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:09','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208554 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208555,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','bdd2e593-7d7c-4ff0-bc19-7a17879e37d6','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2013-02-05 14:42:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:10','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208555 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208556,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','5aa3adf6-7363-4a53-ba4d-b865ddbeee0a','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2013-02-05 14:42:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:10','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208556 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208557,'D',389,'Y','N','N',0,'N',40,'N',18,'N',1682,'@EntityType@=D','N','Y','13146ade-f7c3-4dc7-a894-e3cc4065dd88','Y','EntityType','Dictionary Entity Type; Determines ownership and synchronization','U','The Entity Types "Dictionary", "Adempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!','Entity Type','Y',100,TO_DATE('2013-02-05 14:42:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208557 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208558,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','57f7d2ec-d44b-4410-b3f6-947c2bfbe32d','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2013-02-05 14:42:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:12','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208558 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208559,'D','Y','Y','N',0,'N',2000,'Y',14,'N',463,'N','Y','cfaa0b7d-d9e8-4fc0-8129-d02c638e7bf0','Y','MsgText','Textual Informational, Menu or Error Message','The Message Text indicates the message that will display ','Message Text','Y',100,TO_DATE('2013-02-05 14:42:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:13','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208559 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208560,'D','N','Y','N','N',2000,'Y',14,'N',464,'N','Y','44fe61ae-174e-4637-ab31-f6cd76345670','Y','MsgTip','Additional tip or help for this message','The Message Tip defines additional help or information about this message.','Message Tip','Y',100,TO_DATE('2013-02-05 14:42:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:14','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208560 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208561,'D',103,'Y','N','N','N',1,'N',17,'N',465,'N','Y','193f5730-b062-4773-ab93-a868353fdb9f','Y','MsgType','Type of message (Informational, Menu or Error)','I','The Message Type indicates the type of message being defined.  Valid message types are Informational, Menu and Error.','Message Type','Y',100,TO_DATE('2013-02-05 14:42:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:14','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208561 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208562,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','900f69b5-8efb-4f7e-ae56-7447b6f656c7','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2013-02-05 14:42:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208562 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208563,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','62297aeb-833f-49a4-a26b-1abf29a1fe50','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2013-02-05 14:42:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208563 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200064,208564,'D','Y','N','Y',1,'N',255,'Y',10,'N',620,'N','Y','e0b2553a-5681-4bc9-99df-25654df43943','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_DATE('2013-02-05 14:42:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:42:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:42:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208564 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208557
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208557
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208560
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208560
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208561
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208561
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208564
;

-- Feb 5, 2013 2:42:34 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208564
;

-- Feb 5, 2013 2:44:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200064,208565,'D','N','N','Y',0,'N',14,'N',11,'N',439,'N','Y','f2b38cc8-94e7-4c8a-9756-5853906c90ba','Y','Line','Unique line for this document','@SQL=SELECT COALESCE(MAX(Line),0)+10 AS DefaultValue FROM AD_CtxHelpMsg WHERE AD_CtxHelp_ID=@AD_CtxHelp_ID@','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','Line No','Y',100,TO_DATE('2013-02-05 14:44:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:44:45','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:44:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208565 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:44:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2013-02-05 14:44:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208565
;

-- Feb 5, 2013 2:46:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200064,208566,'D','Y','N','N',0,'Y',10,'N',19,'N',202212,'N','Y','ff8d4222-7942-4662-84c7-367741509aca','N','AD_CtxHelp_ID','Help Context','Y',100,TO_DATE('2013-02-05 14:46:54','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:46:54','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 5, 2013 2:46:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208566 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:49:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
CREATE TABLE AD_CtxHelpMsg (AD_Client_ID NUMBER(10) NOT NULL, AD_CtxHelp_ID NUMBER(10) NOT NULL, AD_CtxHelpMsg_ID NUMBER(10) NOT NULL, AD_CtxHelpMsg_UU NVARCHAR2(36) DEFAULT NULL , AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Line NUMBER(10) NOT NULL, MsgText NVARCHAR2(2000) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_CtxHelpMsg_Key PRIMARY KEY (AD_CtxHelpMsg_ID))
;

-- Feb 5, 2013 2:50:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','7',130,200065,'Y','N','N','D','L','a2251bfa-a2cd-4f1e-be25-48d3a94219c8','Y','Y','AD_CtxHelpMsg_Trl','Help Context Message Trl',0,'Y',0,TO_DATE('2013-02-05 14:50:02','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-02-05 14:50:02','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 5, 2013 2:50:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Feb 5, 2013 2:50:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200060,'476142fa-78e5-4b21-8257-396ba7e11e85','Table AD_CtxHelpMsg_Trl','AD_CtxHelpMsg_Trl',1,0,0,TO_DATE('2013-02-05 14:50:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-05 14:50:03','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Feb 5, 2013 2:50:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208567,'D','Y','N','N','N',22,'N',19,'N',102,'N','Y','b9fb0bcb-97e1-4296-adbe-1e596c1f0c78','N','AD_Client_ID','Client/Tenant for this installation.','@AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2013-02-05 14:50:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:10','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208567 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208568,'D',106,'Y','N','Y',2,'Y',6,'N',18,'N',109,'N','Y','30b66d03-e520-4c6a-91e0-16d3a3021756','N','AD_Language','Language for this entity','The Language identifies the language to use for display and formatting','Language','Y',100,TO_DATE('2013-02-05 14:50:11','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:11','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208568 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208569,'D','Y','N','Y',1,'Y',22,'N',19,'N',1752,'N','Y','7552984a-4429-4378-be38-731e2c3dcc77','N','AD_Message_ID','System Message','Information and Error messages','Message','Y',100,TO_DATE('2013-02-05 14:50:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:12','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208569 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_CtxHelpMsg_Trl_UU',202217,'D','AD_CtxHelpMsg_Trl_UU','AD_CtxHelpMsg_Trl_UU','f1654e45-0dd1-4a37-b246-eab8f6f30ed6',0,TO_DATE('2013-02-05 14:50:13','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:50:13','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Feb 5, 2013 2:50:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202217 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 5, 2013 2:50:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1.00,'N',200065,208570,'D','N','N','N','N',36,'N',10,'N',202217,'N','Y','3194b1b9-c3d8-44b0-8b45-d10e8484df74','Y','AD_CtxHelpMsg_Trl_UU','AD_CtxHelpMsg_Trl_UU','N',100,TO_DATE('2013-02-05 14:50:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:13','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208570 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208571,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','d7b99f8d-1d28-4b23-ba9b-055711e85604','N','AD_Org_ID','Organizational entity within client','@AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2013-02-05 14:50:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:14','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:15 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208571 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208572,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','bc6ce6db-cd45-4e7a-9b73-5b9f513ee1b3','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2013-02-05 14:50:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208572 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208573,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','daabf80e-9792-4e28-9020-ee63610adbe0','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2013-02-05 14:50:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208573 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208574,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','23a3b0a0-3a91-47fd-ae0b-6f96c1ce16c2','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2013-02-05 14:50:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208574 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208575,'D','Y','N','N','N',1,'N',20,'N',420,'N','Y','73f8be70-dd10-486a-9e2e-aa881b4ff507','Y','IsTranslated','This column is translated','The Translated checkbox indicates if this column is translated.','Translated','Y',100,TO_DATE('2013-02-05 14:50:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208575 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208576,'D','Y','N','N','N',2000,'N',14,'N',463,'N','Y','d91fb7f1-5ea1-4935-bac3-c147357cdb2d','Y','MsgText','Textual Informational, Menu or Error Message','The Message Text indicates the message that will display ','Message Text','Y',100,TO_DATE('2013-02-05 14:50:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208576 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208577,'D','N','N','N','N',2000,'N',14,'N',464,'N','Y','70fe3482-7124-4346-a660-9bbefc30eea7','Y','MsgTip','Additional tip or help for this message','The Message Tip defines additional help or information about this message.','Message Tip','Y',100,TO_DATE('2013-02-05 14:50:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208577 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:21 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208578,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','791c3dc8-221f-4b65-8de0-b152e69bac19','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2013-02-05 14:50:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:20','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:21 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208578 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (1,'N',200065,208579,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','c24e0f78-5d77-4d26-b1a2-054cf5ca03b4','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2013-02-05 14:50:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-05 14:50:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Feb 5, 2013 2:50:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208579 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 5, 2013 2:50:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Element_ID=202215, IsUpdateable='N', ColumnName='AD_CtxHelpMsg_ID', Description=NULL, Help=NULL, Name='Help Context Message',Updated=TO_DATE('2013-02-05 14:50:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208569
;

-- Feb 5, 2013 2:50:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=208569
;

-- Feb 5, 2013 2:50:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET Name='Help Context Message', Description=NULL, Help=NULL WHERE AD_Column_ID=208569 AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2013 2:50:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208577
;

-- Feb 5, 2013 2:50:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
DELETE FROM AD_Column WHERE AD_Column_ID=208577
;

-- Feb 5, 2013 2:51:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
CREATE TABLE AD_CtxHelpMsg_Trl (AD_Client_ID NUMBER(10) NOT NULL, AD_CtxHelpMsg_ID NUMBER(10) NOT NULL, AD_CtxHelpMsg_Trl_UU NVARCHAR2(36) DEFAULT NULL , AD_Language VARCHAR2(6) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL, MsgText NVARCHAR2(2000) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_CtxHelpMsg_Trl_Key PRIMARY KEY (AD_CtxHelpMsg_ID, AD_Language))
;

-- Feb 5, 2013 2:52:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Window (Processing,WindowType,Help,IsSOTrx,IsDefault,IsBetaFunctionality,EntityType,Name,Description,AD_Window_ID,AD_Window_UU,Created,Updated,AD_Client_ID,AD_Org_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('N','M',NULL,'Y','N','N','D','Help Context',NULL,200034,'9da664a6-1cde-4908-a3fe-ba367c04f851',TO_DATE('2013-02-05 14:52:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-05 14:52:07','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Feb 5, 2013 2:52:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200034 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Feb 5, 2013 2:52:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Name,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',200034,10,'N','N',200063,'N','N','N','5269f12b-f2ac-4d5e-8d28-e79c2254a531','Y','N',0,'D','Help Context',200074,0,TO_DATE('2013-02-05 14:52:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-02-05 14:52:56','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 5, 2013 2:52:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200074 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Feb 5, 2013 2:53:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,1,'N','N',208538,'Y',201768,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','c9c11180-1fd1-4a4c-9db8-433d5cac5b63',100,0,TO_DATE('2013-02-05 14:53:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201768 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:05 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,36,'N','N',208533,'Y',201769,'N','D','AD_CtxHelp_UU','N','Y','f48859f6-cd05-48aa-b0db-0c8ae0bb41e1',100,0,TO_DATE('2013-02-05 14:53:05','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:05','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201769 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,22,'N','N',208531,'Y',201770,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','9c326da6-bf55-4e6a-80ad-0baf5df1b007',100,0,TO_DATE('2013-02-05 14:53:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201770 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,1,'N','N',208545,'Y',201771,'N','D','Content Type','N','Y','b12bce03-c122-42fa-8338-81f1fc30b5dc',100,0,TO_DATE('2013-02-05 14:53:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201771 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,255,'N','N',208550,'Y',201772,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','N','Y','c4e00c63-f19b-43fc-bd35-f36907bb8619',100,0,TO_DATE('2013-02-05 14:53:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201772 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200074,22,'N','N',208532,'Y',201773,'N','D','Help Context','N','N','2147a087-e2bc-4247-94be-6458571a2af8',100,0,TO_DATE('2013-02-05 14:53:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:08','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Feb 5, 2013 2:53:09 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201773 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,120,'N','N',208549,'Y',201774,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','N','Y','cf403281-d1f2-4433-8e7c-cefa5b8b38ff',100,0,TO_DATE('2013-02-05 14:53:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201774 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,22,'N','N',208534,'Y',201775,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','70f80dee-c0e4-4995-865f-735327bca912',100,0,TO_DATE('2013-02-05 14:53:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201775 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:11 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,10,'N','N',208547,'Y',201776,'N','The Process field identifies a unique Process or Report in the system.','D','Process or Report','Process','N','Y','961a4949-a469-4bb4-9ff6-f9d7413a25b1',100,0,TO_DATE('2013-02-05 14:53:11','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:11','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201776 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,10,'N','N',208548,'Y',201777,'N','The Special Form field identifies a unique Special Form in the system.','D','Special Form','Special Form','N','Y','544071f1-269f-4575-ae50-6e292e061d5d',100,0,TO_DATE('2013-02-05 14:53:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201777 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:53:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,10,'N','N',208546,'Y',201778,'N','The Tab indicates a tab that displays within a window.','D','Tab within a Window','Tab','N','Y','2fb9aabc-2199-43df-b564-77ae3fc61548',100,0,TO_DATE('2013-02-05 14:53:12','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:53:12','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:53:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201778 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201769
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201770
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201775
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201774
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201772
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201768
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201771
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201778
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201776
;

-- Feb 5, 2013 2:54:13 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=201777
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201769
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201770
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201775
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201774
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201772
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201768
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201771
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201778
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201776
;

-- Feb 5, 2013 2:54:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=201777
;

-- Feb 5, 2013 2:54:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET DisplayLength=60,Updated=TO_DATE('2013-02-05 14:54:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201774
;

-- Feb 5, 2013 2:55:03 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-05 14:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201775
;

-- Feb 5, 2013 2:55:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201770
;

-- Feb 5, 2013 2:55:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:55:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201775
;

-- Feb 5, 2013 2:55:28 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2013-02-05 14:55:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201774
;

-- Feb 5, 2013 2:55:33 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET NumLines=3, ColumnSpan=5,Updated=TO_DATE('2013-02-05 14:55:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201772
;

-- Feb 5, 2013 2:55:36 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:55:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201768
;

-- Feb 5, 2013 2:55:38 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:55:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201771
;

-- Feb 5, 2013 2:55:38 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:55:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201778
;

-- Feb 5, 2013 2:55:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:55:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201776
;

-- Feb 5, 2013 2:55:40 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:55:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201777
;

-- Feb 5, 2013 2:56:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET DisplayLogic='@CtxType@=''T''',Updated=TO_DATE('2013-02-05 14:56:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201778
;

-- Feb 5, 2013 2:56:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET DisplayLogic='@CtxType@=''P''',Updated=TO_DATE('2013-02-05 14:56:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201776
;

-- Feb 5, 2013 2:56:28 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET DisplayLogic='@CtxType@=''F''',Updated=TO_DATE('2013-02-05 14:56:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201777
;

-- Feb 5, 2013 2:57:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Column_ID,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Parent_Column_ID,Name,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',200034,20,'N','N',200064,'N','N','N',208566,'2be45426-5bb2-4442-8ec1-7e25e0f381ed','Y','N',1,'D',208532,'Context Message',200075,0,TO_DATE('2013-02-05 14:57:47','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-02-05 14:57:47','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 5, 2013 2:57:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200075 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Feb 5, 2013 2:57:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200075,1,'N','N',208558,'Y',201779,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','89fb8e59-89cc-4307-8b11-576a420e7c8f',100,0,TO_DATE('2013-02-05 14:57:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:52','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:57:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201779 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:57:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200075,36,'N','N',208553,'Y',201780,'N','D','AD_CtxHelpMsg_UU','N','Y','6fae96bf-78e3-49cb-a46c-aa9b102f2afb',100,0,TO_DATE('2013-02-05 14:57:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:57:54 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201780 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:57:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200075,22,'N','N',208551,'Y',201781,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','a49ddec6-f187-4c76-b0dd-42308c4795db',100,0,TO_DATE('2013-02-05 14:57:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:57:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201781 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:57:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200075,10,'N','N',208566,'Y',201782,'N','D','Help Context','N','Y','c16c8de3-3a8e-42b3-88ae-8fda77d8b60a',100,0,TO_DATE('2013-02-05 14:57:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:57:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201782 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:57:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200075,22,'N','N',208552,'Y',201783,'N','D','Help Context Message','N','N','3c8db6a4-0c5e-4774-859b-d8dbfc351c60',100,0,TO_DATE('2013-02-05 14:57:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:56','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Feb 5, 2013 2:57:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201783 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:57:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200075,14,'N','N',208565,'Y',201784,'N','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','D','Unique line for this document','Line No','N','Y','474913c8-8846-43d0-897b-01d23dfbddba',100,0,TO_DATE('2013-02-05 14:57:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:57:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201784 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:57:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200075,2000,'N','N',208559,'Y',201785,'N','The Message Text indicates the message that will display ','D','Textual Informational, Menu or Error Message','Message Text','N','Y','6863cd9e-2492-4f3a-bc34-a79523c32a2f',100,0,TO_DATE('2013-02-05 14:57:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:57:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201785 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:57:59 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200075,22,'N','N',208554,'Y',201786,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','7cd8739f-253e-4aed-83dc-46ca23c377d4',100,0,TO_DATE('2013-02-05 14:57:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 14:57:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 2:57:59 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201786 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 2:58:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201780
;

-- Feb 5, 2013 2:58:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201781
;

-- Feb 5, 2013 2:58:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201786
;

-- Feb 5, 2013 2:58:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201782
;

-- Feb 5, 2013 2:58:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201784
;

-- Feb 5, 2013 2:58:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201779
;

-- Feb 5, 2013 2:58:20 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201785
;

-- Feb 5, 2013 2:58:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201780
;

-- Feb 5, 2013 2:58:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201781
;

-- Feb 5, 2013 2:58:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201786
;

-- Feb 5, 2013 2:58:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201782
;

-- Feb 5, 2013 2:58:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201784
;

-- Feb 5, 2013 2:58:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201779
;

-- Feb 5, 2013 2:58:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201785
;

-- Feb 5, 2013 2:58:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-02-05 14:58:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201781
;

-- Feb 5, 2013 2:58:43 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-02-05 14:58:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201786
;

-- Feb 5, 2013 2:58:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201781
;

-- Feb 5, 2013 2:58:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:58:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201786
;

-- Feb 5, 2013 2:58:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:58:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201782
;

-- Feb 5, 2013 2:58:53 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201784
;

-- Feb 5, 2013 2:58:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-02-05 14:58:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201779
;

-- Feb 5, 2013 2:59:23 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET NumLines=5, ColumnSpan=5,Updated=TO_DATE('2013-02-05 14:59:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201785
;

-- Feb 5, 2013 2:59:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-05 14:59:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201786
;

-- Feb 5, 2013 2:59:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-05 14:59:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201784
;

-- Feb 5, 2013 3:00:23 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Column_ID,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Parent_Column_ID,Name,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','Y',200034,30,'Y','N',200065,'N','N','N',208569,'2945b8e0-2d36-4b9f-999f-3833dd10b767','N','N',2,'D',208552,'Translation',200076,0,TO_DATE('2013-02-05 15:00:22','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-02-05 15:00:22','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Feb 5, 2013 3:00:23 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200076 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Feb 5, 2013 3:00:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,1,'N','N',208574,'Y',201787,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','9cbaa346-e269-4c79-b04e-13f1cd7901d2',100,0,TO_DATE('2013-02-05 15:00:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:24','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201787 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:26 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,36,'N','N',208570,'Y',201788,'N','D','AD_CtxHelpMsg_Trl_UU','N','Y','8c033917-f113-490a-89f4-64ae2f7570bf',100,0,TO_DATE('2013-02-05 15:00:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:26 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201788 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:27 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,22,'N','N',208567,'Y',201789,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','f5973cc7-76f9-4bbb-97ca-cd607783e450',100,0,TO_DATE('2013-02-05 15:00:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:27 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201789 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:27 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,22,'N','N',208569,'Y',201790,'N','D','Help Context Message','N','Y','5c9c9d14-238d-494b-adbb-b72e44f1b738',100,0,TO_DATE('2013-02-05 15:00:27','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:28 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201790 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:28 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,6,'N','N',208568,'Y',201791,'N','The Language identifies the language to use for display and formatting','D','Language for this entity','Language','N','Y','7af928fb-7871-451a-9c23-e45acbd46ed4',100,0,TO_DATE('2013-02-05 15:00:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:28 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201791 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,2000,'N','N',208576,'Y',201792,'N','The Message Text indicates the message that will display ','D','Textual Informational, Menu or Error Message','Message Text','N','Y','c4aef6b3-feed-4fa4-b908-a9d1170e11b2',100,0,TO_DATE('2013-02-05 15:00:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201792 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:30 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,22,'N','N',208571,'Y',201793,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','a6a39200-d809-45e2-969a-8bcaa57dd218',100,0,TO_DATE('2013-02-05 15:00:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:30 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201793 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200076,1,'N','N',208575,'Y',201794,'N','The Translated checkbox indicates if this column is translated.','D','This column is translated','Translated','N','Y','f9ef67be-76b2-4df5-b872-184e4372750d',100,0,TO_DATE('2013-02-05 15:00:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-05 15:00:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 5, 2013 3:00:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201794 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201788
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201789
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201793
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201790
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201791
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201787
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201794
;

-- Feb 5, 2013 3:00:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201792
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201788
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201789
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201793
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201790
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201791
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201787
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201794
;

-- Feb 5, 2013 3:01:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201792
;

-- Feb 5, 2013 3:01:55 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-02-05 15:01:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201789
;

-- Feb 5, 2013 3:01:58 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-02-05 15:01:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201793
;

-- Feb 5, 2013 3:02:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 15:02:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201789
;

-- Feb 5, 2013 3:02:02 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-02-05 15:02:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201793
;

-- Feb 5, 2013 3:02:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 15:02:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201790
;

-- Feb 5, 2013 3:02:06 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-05 15:02:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201791
;

-- Feb 5, 2013 3:02:08 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-02-05 15:02:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201787
;

-- Feb 5, 2013 3:02:10 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-02-05 15:02:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201794
;

-- Feb 5, 2013 3:02:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET NumLines=5, ColumnSpan=5,Updated=TO_DATE('2013-02-05 15:02:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201792
;

-- Feb 5, 2013 3:02:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-05 15:02:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201793
;

-- Feb 5, 2013 3:02:59 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,Action,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200034,200038,'N','N','N','D','acaa627c-edab-4248-82b3-abf15d1b7cf7','Y','Help Context','W','Y',0,100,TO_DATE('2013-02-05 15:02:58','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-02-05 15:02:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 5, 2013 3:02:59 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200038 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Feb 5, 2013 3:02:59 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200038, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200038)
;

-- Feb 5, 2013 3:56:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Table SET Name='Context Help',Updated=TO_DATE('2013-02-05 15:56:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200063
;

-- Feb 5, 2013 3:56:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200063
;

-- Feb 5, 2013 3:56:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Table SET Name='Context Help Message',Updated=TO_DATE('2013-02-05 15:56:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200064
;

-- Feb 5, 2013 3:56:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200064
;

-- Feb 5, 2013 3:56:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Table SET Name='Context Help Message Trl',Updated=TO_DATE('2013-02-05 15:56:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200065
;

-- Feb 5, 2013 3:56:31 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200065
;

-- Feb 5, 2013 3:56:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element SET Name='Context Help', PrintName='Context Help',Updated=TO_DATE('2013-02-05 15:56:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202212
;

-- Feb 5, 2013 3:56:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202212
;

-- Feb 5, 2013 3:56:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET ColumnName='AD_CtxHelp_ID', Name='Context Help', Description=NULL, Help=NULL WHERE AD_Element_ID=202212
;

-- Feb 5, 2013 3:56:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='AD_CtxHelp_ID', Name='Context Help', Description=NULL, Help=NULL, AD_Element_ID=202212 WHERE UPPER(ColumnName)='AD_CTXHELP_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 5, 2013 3:56:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='AD_CtxHelp_ID', Name='Context Help', Description=NULL, Help=NULL WHERE AD_Element_ID=202212 AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2013 3:56:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_InfoColumn SET ColumnName='AD_CtxHelp_ID', Name='Context Help', Description=NULL, Help=NULL WHERE AD_Element_ID=202212 AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2013 3:56:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET Name='Context Help', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202212) AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2013 3:56:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_PrintFormatItem pi SET PrintName='Context Help', Name='Context Help' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202212)
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element SET Name='Context Help Message', PrintName='Context Help Message',Updated=TO_DATE('2013-02-05 15:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202215
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202215
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET ColumnName='AD_CtxHelpMsg_ID', Name='Context Help Message', Description=NULL, Help=NULL WHERE AD_Element_ID=202215
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='AD_CtxHelpMsg_ID', Name='Context Help Message', Description=NULL, Help=NULL, AD_Element_ID=202215 WHERE UPPER(ColumnName)='AD_CTXHELPMSG_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Process_Para SET ColumnName='AD_CtxHelpMsg_ID', Name='Context Help Message', Description=NULL, Help=NULL WHERE AD_Element_ID=202215 AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_InfoColumn SET ColumnName='AD_CtxHelpMsg_ID', Name='Context Help Message', Description=NULL, Help=NULL WHERE AD_Element_ID=202215 AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET Name='Context Help Message', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202215) AND IsCentrallyMaintained='Y'
;

-- Feb 5, 2013 3:57:04 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_PrintFormatItem pi SET PrintName='Context Help Message', Name='Context Help Message' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202215)
;

-- Feb 5, 2013 3:57:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Window SET Name='Context Help',Updated=TO_DATE('2013-02-05 15:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200034
;

-- Feb 5, 2013 3:57:41 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=200034
;

-- Feb 5, 2013 3:57:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Menu SET Name='Context Help', Description=NULL, IsActive='Y',Updated=TO_DATE('2013-02-05 15:57:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200038
;

-- Feb 5, 2013 3:57:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=200038
;

-- Feb 5, 2013 3:57:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab SET Name='Context Help',Updated=TO_DATE('2013-02-05 15:57:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200074
;

-- Feb 5, 2013 3:57:49 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=200074
;

-- Feb 5, 2013 3:58:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab SET Name='Message',Updated=TO_DATE('2013-02-05 15:58:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200075
;

-- Feb 5, 2013 3:58:00 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=200075
;

-- Feb 6, 2013 7:25:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200129,200064,'D','Info','fda43bed-c524-4266-b4a5-bd1b994f6d9d','I',100,TO_DATE('2013-02-06 19:25:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-06 19:25:46','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Feb 6, 2013 7:25:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200129 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Feb 6, 2013 7:26:02 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200130,200064,'D','Workflow','cf5c0d72-f4fd-471f-883a-f9bcf8a3f27d','W',100,TO_DATE('2013-02-06 19:26:01','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-06 19:26:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Feb 6, 2013 7:26:02 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200130 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Feb 6, 2013 7:26:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200132,200064,'D','Task','8cc9dcb5-3b44-40b7-a179-e08c5ee148e7','K',100,TO_DATE('2013-02-06 19:26:23','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-06 19:26:23','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Feb 6, 2013 7:26:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200132 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Feb 6, 2013 7:28:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List (AD_Client_ID,AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,CreatedBy,Created,Updated,UpdatedBy,IsActive,AD_Org_ID) VALUES (0,200133,200064,'D','Home','6a1f4225-4625-48a0-8272-4fcb9f9739bb','H',100,TO_DATE('2013-02-06 19:28:12','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-06 19:28:12','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Feb 6, 2013 7:28:12 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200133 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Feb 6, 2013 7:28:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208580,'D','N','N','N',0,'N',10,'N',19,'N',3068,'N','Y','@CtxType@=''I''','54a75584-daf1-48cb-af2b-2d570c9066fb','Y','AD_InfoWindow_ID','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.','Info Window','Y',100,TO_DATE('2013-02-06 19:28:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-06 19:28:44','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 6, 2013 7:28:45 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208580 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 6, 2013 7:28:48 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelp ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 6, 2013 7:29:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208581,'D','N','N','N',0,'N',10,'N',19,'N',144,'N','Y','@CtxType@=''W''','1935fd3b-9136-431a-858f-081c0183323a','Y','AD_Workflow_ID','Workflow or combination of tasks','The Workflow field identifies a unique Workflow in the system.','Workflow','Y',100,TO_DATE('2013-02-06 19:29:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-06 19:29:15','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 6, 2013 7:29:16 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208581 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 6, 2013 7:29:18 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelp ADD AD_Workflow_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 6, 2013 7:29:44 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column (Version,IsSyncDatabase,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,MandatoryLogic,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',200063,208582,'D','N','N','N',0,'N',10,'N',19,'N',128,'N','Y','@CtxType@=''K''','41a3e1b6-11c8-4e1e-adb5-91d413248438','Y','AD_Task_ID','Operation System Task','The Task field identifies a Operation System Task in the system.','OS Task','Y',100,TO_DATE('2013-02-06 19:29:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-02-06 19:29:44','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N','N')
;

-- Feb 6, 2013 7:29:44 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208582 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 6, 2013 7:29:46 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelp ADD AD_Task_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 6, 2013 7:30:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,10,'N','N',208580,'Y',201795,'N','The Info window is used to search and select records as well as display information relevant to the selection.','D','Info and search/select Window','Info Window','N','Y','ab7907b5-0d80-4a01-9c0e-b35f0ea8d76f',100,0,TO_DATE('2013-02-06 19:30:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-06 19:30:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 6, 2013 7:30:24 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201795 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 6, 2013 7:30:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,10,'N','N',208582,'Y',201796,'N','The Task field identifies a Operation System Task in the system.','D','Operation System Task','OS Task','N','Y','2bceefb0-d401-44e6-b287-8b44ab264fb9',100,0,TO_DATE('2013-02-06 19:30:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-06 19:30:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 6, 2013 7:30:25 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201796 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 6, 2013 7:30:26 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200074,10,'N','N',208581,'Y',201797,'N','The Workflow field identifies a unique Workflow in the system.','D','Workflow or combination of tasks','Workflow','N','Y','66fab2a0-0a0b-4a4e-b50e-0817d762e673',100,0,TO_DATE('2013-02-06 19:30:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-02-06 19:30:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Feb 6, 2013 7:30:26 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201797 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 6, 2013 7:30:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=201795
;

-- Feb 6, 2013 7:30:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=201797
;

-- Feb 6, 2013 7:30:39 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201796
;

-- Feb 6, 2013 7:30:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=201795
;

-- Feb 6, 2013 7:30:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=201797
;

-- Feb 6, 2013 7:30:42 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=201796
;

-- Feb 6, 2013 7:31:02 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET DisplayLogic='@CtxType@=''I''',Updated=TO_DATE('2013-02-06 19:31:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201795
;

-- Feb 6, 2013 7:31:07 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET DisplayLogic='@CtxType@=''W''',Updated=TO_DATE('2013-02-06 19:31:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201797
;

-- Feb 6, 2013 7:31:14 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET DisplayLogic='@CtxType@=''K''',Updated=TO_DATE('2013-02-06 19:31:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201796
;

-- Feb 6, 2013 7:31:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-06 19:31:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201795
;

-- Feb 6, 2013 7:31:19 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-06 19:31:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201797
;

-- Feb 6, 2013 7:31:22 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-02-06 19:31:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201796
;

-- Feb 7, 2013 11:59:13 AM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('M','Getting Started',200139,'D','878862f1-d685-42ad-822f-63b62de42720','GettingStarted','Y',TO_DATE('2013-02-07 11:59:11','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-02-07 11:59:11','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 7, 2013 11:59:13 AM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200139 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 7, 2013 11:59:29 AM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('M','Tool Tip',200140,'D','095d0068-b8a2-4673-bdb8-df2cac8868ff','ToolTip','Y',TO_DATE('2013-02-07 11:59:28','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-02-07 11:59:28','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 7, 2013 11:59:29 AM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200140 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 7, 2013 11:59:40 AM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('M','How To',200141,'D','f2fef657-f879-475a-9fe7-4c3fe76f7748','HowTo','Y',TO_DATE('2013-02-07 11:59:39','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-02-07 11:59:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 7, 2013 11:59:40 AM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200141 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 7, 2013 12:00:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Place your cursor into a field on the screen',200142,'D','1b137728-d99e-48d8-a704-74fbf908eada','PlaceCursorIntoField','Y',TO_DATE('2013-02-07 12:00:28','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-02-07 12:00:28','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 7, 2013 12:00:29 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200142 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 7, 2013 12:01:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Not available',200143,'D','6928db0a-0256-4ea8-86a5-ada16df64b98','NotAvailable','Y',TO_DATE('2013-02-07 12:01:57','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-02-07 12:01:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Feb 7, 2013 12:01:57 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200143 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Feb 7, 2013 12:03:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Element_ID=126, ColumnName='AD_Table_ID', Description='Database Table information', Help='The Database Table provides the information of the table definition', Name='Table',Updated=TO_DATE('2013-02-07 12:03:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208580
;

-- Feb 7, 2013 12:03:50 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=208580
;

-- Feb 7, 2013 12:03:51 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET Name='Table', Description='Database Table information', Help='The Database Table provides the information of the table definition' WHERE AD_Column_ID=208580 AND IsCentrallyMaintained='Y'
;

-- Feb 7, 2013 12:03:56 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelp ADD AD_Table_ID NUMBER(10) DEFAULT NULL 
;

-- Feb 7, 2013 12:30:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column SET AD_Element_ID=3068, ColumnName='AD_InfoWindow_ID', Description='Info and search/select Window', Help='The Info window is used to search and select records as well as display information relevant to the selection.', Name='Info Window',Updated=TO_DATE('2013-02-07 12:30:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208580
;

-- Feb 7, 2013 12:30:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=208580
;

-- Feb 7, 2013 12:30:17 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
UPDATE AD_Field SET Name='Info Window', Description='Info and search/select Window', Help='The Info window is used to search and select records as well as display information relevant to the selection.' WHERE AD_Column_ID=208580 AND IsCentrallyMaintained='Y'
;

-- Feb 7, 2013 12:30:21 PM SGT
-- Ticket #1002211: Create Help pane for Bizidium
ALTER TABLE AD_CtxHelp MODIFY AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

SELECT register_migration_script('201302071920_TICKET-1002211.sql') FROM dual
;