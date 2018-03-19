-- Sep 18, 2012 11:17:01 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','4',0,200020,'N','N','N','N','D','N','L','54a5f4ee-e0e9-4504-961a-6269c0052dfa','Y','Y','AD_Schedule','Times for the Scheduler','AD_Schedule',0,'Y',0,0,TO_DATE('2012-09-18 11:16:35','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-09-18 11:16:35','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 11:17:01 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Sep 18, 2012 11:17:02 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',200000,'Y',1000000,1000000,'N','Y',200020,'Table AD_Schedule','AD_Schedule',1,'1cd2e6e4-72de-492a-9c52-a140bc5b1fac',0,0,TO_DATE('2012-09-18 11:17:01','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-09-18 11:17:01','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Sep 18, 2012 11:21:52 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200471,'U','Y','N','N',0,'N',22,'N',19,'N','N',102,'N','N','31aa3740-d9b8-4765-8420-0417f644e940','N','Y','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',0,TO_DATE('2012-09-18 11:21:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:21:52','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:21:52 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200471 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:22:45 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200472,'U','Y','N','N',0,'N',22,'N',19,'N',104,'N',113,'N','Y','aa30dabd-cc97-429d-89ed-d6c5cbe949ac','N','Y','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',0,TO_DATE('2012-09-18 11:22:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:22:44','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:22:45 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200472 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:24:05 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_Schedule_ID',200132,'D','AD_Schedule_ID','AD_Schedule_ID','bce1a7be-08e9-4e36-b908-312ef92605e2',0,TO_DATE('2012-09-18 11:24:04','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-18 11:24:04','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y')
;

-- Sep 18, 2012 11:24:05 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200132 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 18, 2012 11:24:51 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200473,'D','N','N','Y',1,'N',22,'N',13,'N','Y',200132,'N','N','9bdff8e7-b227-4712-86cd-f873520e85d7','N','N','N','AD_Schedule_ID','AD_Schedule_ID','N',0,TO_DATE('2012-09-18 11:24:50','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:24:50','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:24:51 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200473 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:24:57 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-09-18 11:24:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200471
;

-- Sep 18, 2012 11:25:02 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-09-18 11:25:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200472
;

-- Sep 18, 2012 11:29:41 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200474,'D','Y','N','N',0,'N',7,'N',16,'N','N',245,'N','N','676bd5f9-f80f-417e-bc5f-5be8181dd6a3','N','Y','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',0,TO_DATE('2012-09-18 11:29:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:29:40','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:29:41 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200474 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:33:32 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200475,'D',110,'Y','N','N',0,'N',22,'N',18,'N','N',246,'N','Y','6b87ab8f-baa6-49ee-a4a8-0ca225691fb4','N','Y','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',0,TO_DATE('2012-09-18 11:33:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:33:32','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:33:32 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200475 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:34:48 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200476,'D','Y','N','N',0,'N',7,'N',16,'N','N',607,'N','N','fc29c26c-e144-4d77-abfe-354eb3a8cdc6','N','Y','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',0,TO_DATE('2012-09-18 11:34:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:34:47','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:34:48 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200476 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:39:25 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200477,'D',110,'Y','N','N',0,'N',22,'N',18,'N','N',608,'N','N','c66a48fd-47e0-4004-9d36-65924de07c74','N','Y','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',0,TO_DATE('2012-09-18 11:39:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:39:24','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:39:25 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200477 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:40:28 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200478,'D','Y','N','N',0,'N',1,'N',40,'N','N',348,'N','N','cd090c45-d7ec-4e4f-a205-c2471f8425c9','N','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',0,TO_DATE('2012-09-18 11:40:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:40:17','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:40:28 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200478 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:41:40 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200479,'D','N','N','N',0,'N',225,'N',10,'N','N',275,'N','N','8bd423be-e422-44ce-aa43-e75d796d2f74','N','Y','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',0,TO_DATE('2012-09-18 11:41:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:41:39','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:41:40 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200479 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:44:31 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200480,'D',221,'N','N','N',0,'N',1,'N',17,'N','N',1507,'N','Y','97df7222-704c-4790-b9c6-f0b089cb2f9f','N','Y','N','FrequencyType','Frequency of event','The frequency type is used for calculating the date of the next event.','Frequency Type','Y',0,TO_DATE('2012-09-18 11:44:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:44:31','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:44:31 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200480 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:46:04 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200481,'D',318,'N','N','N',0,'N',1,'N',17,'N','N',2457,'N','Y','92fda8e1-8815-4718-8b54-df770ec08594','N','Y','N','ScheduleType','Type of schedule','F','Define the method how the next occurrence is calculated','Schedule Type','Y',0,TO_DATE('2012-09-18 11:46:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:46:03','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:46:04 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200481 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:47:20 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200482,'D','N','N','N',0,'N',255,'N',10,'N','N',54124,'N','Y','4777132c-1cd4-4ef7-af7b-3b753f892b2e','N','Y','N','CronPattern','Cron pattern to define when the process should be invoked.','Cron pattern to define when the process should be invoked. See http://en.wikipedia.org/wiki/Cron#crontab_syntax for cron scheduling syntax and example.','Cron Scheduling Pattern','Y',0,TO_DATE('2012-09-18 11:47:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:47:19','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:47:20 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200482 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:48:44 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200483,'U','N','N','N',0,'N',22,'N',11,'N','N',1506,'N','Y','16094bae-2dca-4217-bcd6-703801047ce3','N','Y','N','Frequency','Frequency of events','The frequency is used in conjunction with the frequency type in determining an event. Example: If the Frequency Type is Week and the Frequency is 2 - it is every two weeks.','Frequency','Y',0,TO_DATE('2012-09-18 11:48:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:48:19','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:48:44 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200483 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:55:03 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,ValueMax,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,ValueMin,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200484,'31','D','N','N','N',0,'1','N',22,'N',11,'N','N',2454,'N','Y','1781134b-b56e-48b4-bef9-7e5ccfc29811','N','Y','N','MonthDay','Day of the month 1 to 28/29/30/31','Day of the Month','Y',0,TO_DATE('2012-09-18 11:54:59','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:54:59','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:55:03 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200484 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:55:32 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-09-18 11:55:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200483
;

-- Sep 18, 2012 11:56:25 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200485,'U',167,'N','N','N',0,'N',1,'N',17,'N','N',2458,'N','Y','fc957f56-4f18-462a-80a5-ad67231ffc75','N','Y','N','WeekDay','Day of the Week','Day of the Week','Y',0,TO_DATE('2012-09-18 11:56:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:56:24','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:56:25 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200485 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:56:34 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-09-18 11:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200485
;

-- Sep 18, 2012 11:59:13 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200486,'D','N','N','N',0,'N',60,'N',10,'N','N',3011,'N','N','a332a52b-8b68-43d4-b5ac-43c42a78db3f','N','Y','N','IP_Address','Defines the IP address to transfer data to','Contains info on the IP address to which we will transfer data','IP Address','Y',0,TO_DATE('2012-09-18 11:59:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 11:59:12','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 11:59:13 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200486 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 11:59:20 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET ColumnName='RunOnlyOnIP', Name='RunOnlyOnIP',Updated=TO_DATE('2012-09-18 11:59:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200486
;

-- Sep 18, 2012 11:59:20 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200486
;

-- Sep 18, 2012 11:59:20 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET Name='RunOnlyOnIP', Description='Defines the IP address to transfer data to', Help='Contains info on the IP address to which we will transfer data' WHERE AD_Column_ID=200486 AND IsCentrallyMaintained='Y'
;

-- Sep 18, 2012 12:06:20 PM COT
-- IDEMPIERE-391 Scheduler improvements
CREATE TABLE AD_Schedule (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_Schedule_ID NUMBER(10) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, CronPattern NVARCHAR2(255) DEFAULT NULL , Description NVARCHAR2(225) DEFAULT NULL , Frequency NUMBER(10) DEFAULT NULL , FrequencyType CHAR(1) DEFAULT NULL , IsActive NVARCHAR2(1) DEFAULT 'Y' NOT NULL, MonthDay NUMBER(10) DEFAULT NULL , RunOnlyOnIP NVARCHAR2(60) DEFAULT NULL , ScheduleType CHAR(1) DEFAULT 'F', Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, WeekDay CHAR(1) DEFAULT NULL , CONSTRAINT AD_Schedule_Key PRIMARY KEY (AD_Schedule_ID))
;

-- Sep 18, 2012 12:08:05 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=9434
;

-- Sep 18, 2012 12:10:34 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,Description,AD_Window_ID,Processing,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('T','N','N','N',0,0,'D','Schedule','Times for the scheduler',200012,'N','b1165a29-bcef-442c-be03-92ca75d4c019',TO_DATE('2012-09-18 12:10:34','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-18 12:10:34','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',0,0)
;

-- Sep 18, 2012 12:10:34 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200012 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Sep 18, 2012 12:11:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',200012,10,'N','N',200020,'N','N','N','N','Y','N',0,'06dc0531-48ba-42cf-8c50-d4fbb44928fc','D','Schedule','Schedule',200019,0,0,TO_DATE('2012-09-18 12:11:18','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-09-18 12:11:18','YYYY-MM-DD HH24:MI:SS'),0,'N','Y')
;

-- Sep 18, 2012 12:11:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200019 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Sep 18, 2012 12:11:25 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,1,'N','N',200478,'Y',200488,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','Y','N','0dcbc18c-ee3d-4bf3-bf42-4bd6a0d63783',0,0,TO_DATE('2012-09-18 12:11:25','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:25 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200488 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200019,22,'N','N',200473,'Y',200489,'N','D','AD_Schedule_ID','N','N','94177e96-cd4e-4537-9ac0-457ddd542f3f',0,0,TO_DATE('2012-09-18 12:11:25','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:25','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Sep 18, 2012 12:11:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200489 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,22,'N','N',200471,'Y',200490,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','Y','N','aa204f69-805c-4a4c-95c8-1e15a5448c86',0,0,TO_DATE('2012-09-18 12:11:26','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200490 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:27 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,255,'N','N',200482,'Y',200491,'N','Cron pattern to define when the process should be invoked. See http://en.wikipedia.org/wiki/Cron#crontab_syntax for cron scheduling syntax and example.','D','Cron pattern to define when the process should be invoked.','Cron Scheduling Pattern','Y','N','03487b4d-0971-4c70-8f04-46fe0e420278',0,0,TO_DATE('2012-09-18 12:11:26','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:27 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200491 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:27 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,22,'N','N',200484,'Y',200492,'N','D','Day of the month 1 to 28/29/30/31','Day of the Month','Y','N','deeababe-b70b-44d9-a11a-1e8894614a4b',0,0,TO_DATE('2012-09-18 12:11:27','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:27 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200492 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:28 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,1,'N','N',200485,'Y',200493,'N','D','Day of the Week','Day of the Week','Y','N','bd084abe-110c-4810-9fbf-6966b6bae3d1',0,0,TO_DATE('2012-09-18 12:11:27','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:27','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:28 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200493 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:28 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,225,'N','N',200479,'Y',200494,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','Y','N','ca15c625-eaa2-4c2e-af8a-f5c38c85820b',0,0,TO_DATE('2012-09-18 12:11:28','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:28 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200494 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,22,'N','N',200483,'Y',200495,'N','The frequency is used in conjunction with the frequency type in determining an event. Example: If the Frequency Type is Week and the Frequency is 2 - it is every two weeks.','D','Frequency of events','Frequency','Y','N','f2a92a92-ab3d-4b14-9cd6-b340b23c7eac',0,0,TO_DATE('2012-09-18 12:11:28','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200495 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,1,'N','N',200480,'Y',200496,'N','The frequency type is used for calculating the date of the next event.','D','Frequency of event','Frequency Type','Y','N','87167c4f-fe83-4ee2-8089-913c63eca7d9',0,0,TO_DATE('2012-09-18 12:11:29','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200496 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,22,'N','N',200472,'Y',200497,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','Y','N','c0054e5a-74ae-41cd-9f90-1fc31b504318',0,0,TO_DATE('2012-09-18 12:11:29','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200497 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:30 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,60,'N','N',200486,'Y',200498,'N','Contains info on the IP address to which we will transfer data','D','Defines the IP address to transfer data to','IP Address','Y','N','2d42c7e3-1df7-4f1d-9097-288628f38e8e',0,0,TO_DATE('2012-09-18 12:11:29','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:30 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200498 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:11:30 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,1,'N','N',200481,'Y',200499,'N','Define the method how the next occurrence is calculated','D','Type of schedule','Schedule Type','Y','N','f8967225-915e-4f3d-b51d-3fd73d69a178',0,0,TO_DATE('2012-09-18 12:11:30','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:11:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:11:30 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200499 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:12:04 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200490
;

-- Sep 18, 2012 12:12:04 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200497
;

-- Sep 18, 2012 12:12:04 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200488
;

-- Sep 18, 2012 12:12:04 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200491
;

-- Sep 18, 2012 12:12:04 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200492
;

-- Sep 18, 2012 12:12:05 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200493
;

-- Sep 18, 2012 12:12:05 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200494
;

-- Sep 18, 2012 12:12:05 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200495
;

-- Sep 18, 2012 12:12:05 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200496
;

-- Sep 18, 2012 12:12:05 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200498
;

-- Sep 18, 2012 12:12:05 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200499
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200492
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200493
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200494
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200499
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200496
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200495
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200491
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200498
;

-- Sep 18, 2012 12:13:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200488
;

-- Sep 18, 2012 12:14:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200487,'D','N','N','N',0,'N',22,'Y',10,'N','N',469,'N','Y','85289efa-6925-4a1b-a56d-d2eeab992199','N','Y','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',0,TO_DATE('2012-09-18 12:14:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-18 12:14:18','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 18, 2012 12:14:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200487 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 18, 2012 12:14:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule ADD Name NVARCHAR2(22) DEFAULT NULL 
;

-- Sep 18, 2012 12:14:45 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,22,'N','N',200487,'Y',200500,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','Y','N','40e45db9-e809-4c5b-9eb1-ded79bc2065f',0,0,TO_DATE('2012-09-18 12:14:45','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-09-18 12:14:45','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 18, 2012 12:14:45 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200500 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200500
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200494
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200499
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200496
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200495
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200491
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200498
;

-- Sep 18, 2012 12:15:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200488
;

-- Sep 18, 2012 1:47:15 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET DisplayLogic='@ScheduleType@=F',Updated=TO_DATE('2012-09-18 13:47:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200496
;

-- Sep 18, 2012 1:50:16 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET DisplayLogic='@ScheduleType@=C',Updated=TO_DATE('2012-09-18 13:50:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200491
;

-- Sep 18, 2012 1:52:00 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-18 13:52:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200488
;

-- Sep 18, 2012 1:52:10 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=1,Updated=TO_DATE('2012-09-18 13:52:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200488
;

-- Sep 18, 2012 1:52:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-18 13:52:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200490
;

-- Sep 18, 2012 1:52:36 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-18 13:52:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200497
;

-- Sep 18, 2012 1:52:43 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-09-18 13:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200500
;

-- Sep 18, 2012 1:52:58 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=5, NumLines=3,Updated=TO_DATE('2012-09-18 13:52:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200494
;

-- Sep 18, 2012 1:53:07 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-18 13:53:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200499
;

-- Sep 18, 2012 1:53:20 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-18 13:53:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200496
;

-- Sep 18, 2012 1:53:33 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-18 13:53:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200495
;

-- Sep 18, 2012 1:53:38 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2012-09-18 13:53:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200495
;

-- Sep 18, 2012 1:53:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-09-18 13:53:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200491
;

-- Sep 18, 2012 1:53:51 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-09-18 13:53:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200498
;

-- Sep 18, 2012 1:53:58 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-09-18 13:53:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200488
;

-- Sep 18, 2012 1:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Description,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200012,200018,'N','N','N','D','Y','Schedule','Maintain times foe Scheduler','W','e821174d-eb46-4c6c-b295-9b9ea2d3822e','Y',0,0,TO_DATE('2012-09-18 13:56:43','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-09-18 13:56:43','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 18, 2012 1:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200018 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Sep 18, 2012 1:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 0, SysDate, 0,t.AD_Tree_ID, 200018, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200018)
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=450
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200018
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=446
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53191
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53192
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=439
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=440
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=594
;

-- Sep 18, 2012 1:57:13 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50009
;

-- Sep 18, 2012 2:13:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200491
;

-- Sep 18, 2012 2:13:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200495
;

-- Sep 18, 2012 2:14:48 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET AD_Reference_ID=20,Updated=TO_DATE('2012-09-18 14:14:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200478
;

-- Sep 28, 2012 5:40:09 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_Schedule_UU',200158,'D','AD_Schedule_UU','AD_Schedule_UU','027b3c04-57c2-4df2-bae1-daffffa41fa7',0,TO_DATE('2012-09-28 17:40:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-28 17:40:07','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y')
;

-- Sep 28, 2012 5:40:09 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200158 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 28, 2012 5:40:56 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200559,'D','N','N','N',0,'N',36,'N',10,'N','N',200158,'N','Y','b4867242-4498-4608-aa86-c262f3af378e','N','Y','N','AD_Schedule_UU','AD_Schedule_UU','N',0,TO_DATE('2012-09-28 17:40:55','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-28 17:40:55','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Sep 28, 2012 5:40:56 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200559 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 28, 2012 5:40:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule ADD AD_Schedule_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Sep 20, 2012 9:38:20 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Schedule (Frequency,AD_Client_ID,AD_Org_ID,AD_Schedule_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,FrequencyType,ScheduleType,MonthDay,Name) VALUES (1,0,0,200000,TO_DATE('2012-09-20 09:38:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-20 09:38:18','YYYY-MM-DD HH24:MI:SS'),100,'Y','D','F',0,'1 Day')
;

-- Sep 20, 2012 10:16:54 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Schedule (Frequency,AD_Client_ID,AD_Org_ID,AD_Schedule_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,FrequencyType,ScheduleType,MonthDay,Name) VALUES (7,0,0,200001,TO_DATE('2012-09-20 10:16:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-20 10:16:53','YYYY-MM-DD HH24:MI:SS'),100,'Y','D','F',0,'7 Days')
;

-- Sep 20, 2012 10:20:08 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,688,200489,'D','N','N','N',0,'N',10,'N',19,'N','N',200132,'N','Y','a61f8f27-8146-4c2d-9cea-b9fc50d7a77e','N','Y','N','AD_Schedule_ID','AD_Schedule_ID','Y',100,TO_DATE('2012-09-20 10:20:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-20 10:20:07','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 20, 2012 10:20:08 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200489 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 20, 2012 10:20:17 AM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Scheduler ADD AD_Schedule_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 20, 2012 10:20:58 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',589,10,'N','N',200489,'Y',200501,'N','D','AD_Schedule_ID','Y','N','ae7b8de9-50f5-4f79-92ef-c7d5e72555b0',100,0,TO_DATE('2012-09-20 10:20:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 10:20:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 10:20:58 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200501 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 10:20:59 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',589,36,'N','N',60493,'Y',200502,'N','D','AD_Scheduler_UU','Y','N','57fc4fb5-58ff-4f4d-8799-a9fee348cc9f',100,0,TO_DATE('2012-09-20 10:20:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 10:20:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 10:20:59 AM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200502 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200502
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200501
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=10051
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=9437
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9430
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=58773
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=58774
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=9432
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=9442
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=9443
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=9438
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=60991
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=60992
;

-- Sep 20, 2012 10:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=9434
;

-- Sep 20, 2012 10:24:02 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET Name='Schedule', ColumnSpan=2,Updated=TO_DATE('2012-09-20 10:24:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200501
;

-- Sep 20, 2012 10:24:02 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200501
;

-- Sep 20, 2012 10:26:00 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200502
;

-- Sep 20, 2012 10:26:00 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200501
;

-- Sep 20, 2012 10:27:53 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET SeqNoSelection=2,Updated=TO_DATE('2012-09-20 10:27:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200487
;

-- Sep 20, 2012 11:23:10 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsSelectionColumn='N', IsUpdateable='N', SeqNoSelection=0,Updated=TO_DATE('2012-09-20 11:23:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200487
;

-- Sep 20, 2012 11:23:16 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsSelectionColumn='Y', IsUpdateable='N', SeqNoSelection=2,Updated=TO_DATE('2012-09-20 11:23:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200487
;


-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=58774
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9430
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9437
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=10051
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=58773
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=9432
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9442
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=9443
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=9438
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=60991
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=60992
;

-- Sep 20, 2012 11:35:11 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=9434
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=58774
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=9430
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=9437
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=10051
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=58773
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=9432
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=9442
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=9443
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=9438
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=60991
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=60992
;

-- Sep 20, 2012 11:37:12 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200501
;

-- Sep 20, 2012 11:52:30 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 11:52:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59029
;

-- Sep 20, 2012 11:52:39 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 11:52:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11247
;

-- Sep 20, 2012 11:52:44 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 11:52:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11255
;

-- Sep 20, 2012 11:52:55 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 11:52:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11523
;

-- Sep 20, 2012 11:53:05 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 11:53:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11521
;

-- Sep 20, 2012 11:53:14 AM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 11:53:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11522
;

-- Sep 20, 2012 6:24:20 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,695,200490,'D','N','N','N',0,'N',10,'N',19,'N','N',200132,'N','Y','7e549561-f9c8-44b7-9bc2-9e1d1bb4c728','N','Y','N','AD_Schedule_ID','AD_Schedule_ID','Y',100,TO_DATE('2012-09-20 18:24:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-20 18:24:18','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 20, 2012 6:24:20 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200490 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 20, 2012 6:24:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',608,10,'N','N',200490,'Y',200503,'N','D','AD_Schedule_ID','Y','N','6d491d80-dc56-484f-90c8-8c6d0cb2344d',100,0,TO_DATE('2012-09-20 18:24:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 18:24:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 6:24:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200503 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 6:24:56 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',608,36,'N','N',60588,'Y',200504,'N','D','C_AcctProcessor_UU','Y','N','1cbac684-149b-40fc-b1bc-66a8e3bde012',100,0,TO_DATE('2012-09-20 18:24:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 18:24:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 6:24:56 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200504 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200504
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9039
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200503
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=9037
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9028
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=9027
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=9033
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=9031
;

-- Sep 20, 2012 6:25:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=9032
;

-- Sep 20, 2012 6:25:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9028
;

-- Sep 20, 2012 6:25:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9037
;

-- Sep 20, 2012 6:25:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=9027
;

-- Sep 20, 2012 6:25:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9033
;

-- Sep 20, 2012 6:25:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=9031
;

-- Sep 20, 2012 6:25:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=9032
;

-- Sep 20, 2012 6:27:37 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 18:27:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11348
;

-- Sep 20, 2012 6:27:43 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 18:27:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11359
;

-- Sep 20, 2012 6:28:12 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=3,Updated=TO_DATE('2012-09-20 18:28:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200503
;

-- Sep 20, 2012 6:29:41 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Schedule (Frequency,AD_Client_ID,AD_Org_ID,AD_Schedule_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,FrequencyType,ScheduleType,MonthDay,Name,Description) VALUES (10,0,0,200002,TO_DATE('2012-09-20 18:29:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-20 18:29:40','YYYY-MM-DD HH24:MI:SS'),100,'Y','M','F',0,'10 Minutes','(do not delete, used in Initial Client Setup)')
;

-- Sep 20, 2012 6:31:38 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE C_AcctProcessor ADD AD_Schedule_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 20, 2012 6:33:24 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsIdentifier='Y', SeqNo=2, IsUpdateable='N',Updated=TO_DATE('2012-09-20 18:33:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200487
;

-- Sep 20, 2012 6:55:21 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,700,200491,'D','N','N','N',0,'N',10,'N',19,'N','N',200132,'N','Y','273fcf64-47b6-48ef-a432-b1d600bad17f','N','Y','N','AD_Schedule_ID','AD_Schedule_ID','Y',100,TO_DATE('2012-09-20 18:55:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-20 18:55:19','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 20, 2012 6:55:21 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200491 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 20, 2012 6:55:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_AlertProcessor ADD AD_Schedule_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 20, 2012 6:56:21 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',631,36,'N','N',60374,'Y',200505,'N','D','AD_AlertProcessor_UU','Y','N','a9ee04e4-207b-400f-b182-b6600231ce3e',100,0,TO_DATE('2012-09-20 18:56:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 18:56:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 6:56:21 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200505 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 6:56:22 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',631,10,'N','N',200491,'Y',200506,'N','D','AD_Schedule_ID','Y','N','bcfced0e-e826-4815-a75e-767f25b1f1ae',100,0,TO_DATE('2012-09-20 18:56:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 18:56:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 6:56:22 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200506 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200505
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9534
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9533
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200506
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=9530
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=9532
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=9524
;

-- Sep 20, 2012 6:56:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9527
;

-- Sep 20, 2012 6:57:01 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-20 18:57:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200506
;

-- Sep 20, 2012 6:57:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='N', IsActive='N',Updated=TO_DATE('2012-09-20 18:57:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11441
;

-- Sep 20, 2012 6:57:32 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-20 18:57:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11440
;

-- Sep 20, 2012 6:57:43 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_AlertProcessor MODIFY FrequencyType CHAR(1) DEFAULT NULL 
;

-- Sep 20, 2012 6:57:43 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_AlertProcessor MODIFY FrequencyType NULL
;

-- Sep 20, 2012 6:59:53 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_AlertProcessor SET AD_Schedule_ID=200000,Updated=TO_DATE('2012-09-20 18:59:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_AlertProcessor_ID=100
;

-- Sep 20, 2012 7:00:09 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Element SET PrintName='Schedule',Updated=TO_DATE('2012-09-20 19:00:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200132
;

-- Sep 20, 2012 7:00:09 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200132
;

-- Sep 20, 2012 7:00:09 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_PrintFormatItem pi SET PrintName='Schedule', Name='AD_Schedule_ID' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200132)
;

-- Sep 20, 2012 7:23:52 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,420,200492,'D','N','N','N',0,'N',10,'N',19,'N','N',200132,'N','Y','e3fdcc19-7a75-4a63-97a1-785bbafe1996','N','Y','N','AD_Schedule_ID','AD_Schedule_ID','Y',100,TO_DATE('2012-09-20 19:23:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-20 19:23:51','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 20, 2012 7:23:52 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200492 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 20, 2012 7:35:11 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE R_RequestProcessor ADD AD_Schedule_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 20, 2012 7:36:28 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',346,10,'N','N',200492,'Y',200507,'N','D','AD_Schedule_ID','Y','N','fad6e2a5-de6b-44ec-add5-f61622bf7731',100,0,TO_DATE('2012-09-20 19:36:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 19:36:26','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 7:36:28 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200507 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 7:36:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',346,36,'N','N',61024,'Y',200508,'N','D','R_RequestProcessor_UU','Y','N','034c812e-f7b9-4897-baa8-7a5751483828',100,0,TO_DATE('2012-09-20 19:36:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 19:36:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 7:36:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200508 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=4330
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=4331
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200508
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200507
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=5149
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=10907
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=5150
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=5166
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=10912
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=9318
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=4327
;

-- Sep 20, 2012 7:36:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=4328
;

-- Sep 20, 2012 7:37:15 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-20 19:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200507
;

-- Sep 20, 2012 7:37:37 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 19:37:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5480
;

-- Sep 20, 2012 7:37:41 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 19:37:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5481
;

-- Sep 20, 2012 7:39:26 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Schedule (Frequency,AD_Client_ID,AD_Org_ID,AD_Schedule_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,FrequencyType,ScheduleType,MonthDay,Name,Description) VALUES (15,0,0,200003,TO_DATE('2012-09-20 19:39:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-20 19:39:24','YYYY-MM-DD HH24:MI:SS'),100,'Y','M','F',0,'15 Minutes','(do not delete, used in Initial Client Setup)')
;

-- Sep 20, 2012 7:55:53 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,697,200493,'D','N','N','N',0,'N',10,'N',19,'N','N',200132,'N','Y','a8107d13-a59f-4b3f-b5d7-467c067eb8f0','N','Y','N','AD_Schedule_ID','AD_Schedule_ID','Y',100,TO_DATE('2012-09-20 19:55:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-20 19:55:52','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 20, 2012 7:55:53 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200493 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 20, 2012 7:56:02 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_WorkflowProcessor ADD AD_Schedule_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 20, 2012 7:56:54 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',592,10,'N','N',200493,'Y',200509,'N','D','AD_Schedule_ID','Y','N','8be243a9-ba4d-49c2-addb-128f2451e3d8',100,0,TO_DATE('2012-09-20 19:56:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 19:56:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 7:56:54 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200509 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 7:56:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',592,36,'N','N',60559,'Y',200510,'N','D','AD_WorkflowProcessor_UU','Y','N','ba7097bf-ef51-4e12-9602-745bd0218380',100,0,TO_DATE('2012-09-20 19:56:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-20 19:56:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 20, 2012 7:56:55 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200510 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 20, 2012 7:57:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200510
;

-- Sep 20, 2012 7:57:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9509
;

-- Sep 20, 2012 7:57:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=9502
;

-- Sep 20, 2012 7:57:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200509
;

-- Sep 20, 2012 7:57:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=10916
;

-- Sep 20, 2012 7:57:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=10917
;

-- Sep 20, 2012 7:57:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=9510
;

-- Sep 20, 2012 7:57:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=9501
;

-- Sep 20, 2012 7:57:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=10924
;

-- Sep 20, 2012 7:57:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=9511
;

-- Sep 20, 2012 7:57:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=9499
;

-- Sep 20, 2012 7:57:36 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 19:57:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11391
;

-- Sep 20, 2012 7:57:41 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-20 19:57:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11382
;

-- Sep 20, 2012 7:59:45 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Schedule (Frequency,AD_Client_ID,AD_Org_ID,AD_Schedule_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,FrequencyType,ScheduleType,MonthDay) VALUES (2,0,0,200004,TO_DATE('2012-09-20 19:59:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-20 19:59:44','YYYY-MM-DD HH24:MI:SS'),100,'Y','H','F',0)
;

-- Sep 24, 2012 3:50:02 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200557,'U','N','N','N',0,'N',1,'N',20,'N','N',54123,'N','Y','3be5ad4a-1390-4dd5-b526-230f6fe3c9ee','N','Y','N','IsIgnoreProcessingTime','Do not include processing time for the DateNextRun calculation','N','When this is selected, the previous DateNextRun is always use as the source for the next DateNextRun calculation.','Ignore Processing Time','Y',100,TO_DATE('2012-09-24 15:50:01','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-24 15:50:01','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 24, 2012 3:50:02 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200557 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 3:50:11 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET EntityType='D',Updated=TO_DATE('2012-09-24 15:50:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200557
;

-- Sep 24, 2012 3:50:15 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule ADD IsIgnoreProcessingTime CHAR(1) DEFAULT 'N' CHECK (IsIgnoreProcessingTime IN ('Y','N'))
;

-- Sep 24, 2012 5:05:08 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsSystemSchedule',200157,'D','IsSystemSchedule','Schedule Just For System','System Schedule','0fcff3a8-e3d4-4d54-a060-7aa225b329c6',0,TO_DATE('2012-09-24 17:05:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 17:05:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 24, 2012 5:05:08 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200157 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 5:06:10 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200020,200558,'D','N','N','N',0,'N',1,'N',20,'N','N',200157,'N','Y','f5b750f4-c9a7-4dfb-a4de-17f8431a1f47','N','Y','N','IsSystemSchedule','Schedule Just For System','N','IsSystemSchedule','Y',100,TO_DATE('2012-09-24 17:06:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-24 17:06:09','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 24, 2012 5:06:10 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200558 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 5:06:23 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule ADD IsSystemSchedule CHAR(1) DEFAULT 'N' CHECK (IsSystemSchedule IN ('Y','N'))
;

/* Create schedule records for actual configuration */
insert into ad_schedule (ad_schedule_id, ad_schedule_uu, ad_client_id, ad_org_id, frequencytype, frequency, weekday, scheduletype, isignoreprocessingtime, cronpattern
,created, createdby,description,isactive,runonlyonip,updated,updatedby,name,issystemschedule)
select distinct nextidfunc( 200020 , 'N'), generate_uuid(), 0, 0, frequencytype, frequency, weekday, scheduletype, isignoreprocessingtime, cronpattern
,sysdate,100,null,'Y',null,sysdate,100,coalesce(frequencytype,' ')||' '||coalesce(frequency,-1)||' '||coalesce(scheduletype,' ')||' '||nvl(cronpattern,' '),'N'
from (
select distinct frequencytype, frequency, weekday, scheduletype, isignoreprocessingtime, cronpattern
from ad_scheduler
where not exists (select 1 from ad_schedule where 
coalesce(ad_scheduler.frequencytype,' ')         =coalesce(ad_schedule.frequencytype,' ') and
coalesce(ad_scheduler.frequency,-1)              =coalesce(ad_schedule.frequency,-1) and
coalesce(ad_scheduler.weekday,' ')               =coalesce(ad_schedule.weekday,' ') and
coalesce(ad_scheduler.scheduletype,' ')          =coalesce(ad_schedule.scheduletype,' ') and
coalesce(ad_scheduler.isignoreprocessingtime,' ')=coalesce(ad_schedule.isignoreprocessingtime,' ') and
nvl(ad_scheduler.cronpattern,' ')           =nvl(ad_schedule.cronpattern,' ')
)
)
;

insert into ad_schedule (ad_schedule_id, ad_schedule_uu, ad_client_id, ad_org_id, frequencytype, frequency, scheduletype, isignoreprocessingtime
,created, createdby,description,isactive,runonlyonip,updated,updatedby,name,issystemschedule)
select distinct nextidfunc( 200020 , 'N'), generate_uuid(), 0, 0, frequencytype, frequency, scheduletype, isignoreprocessingtime
,sysdate,100,null,'Y',null,sysdate,100,coalesce(frequencytype,' ')||' '||coalesce(frequency,-1)||' '||coalesce(scheduletype,' '),'N'
from (
select distinct frequencytype, frequency, 'F' as scheduletype, 'Y' as isignoreprocessingtime
from c_acctprocessor
where not exists (select 1 from ad_schedule where 
coalesce(c_acctprocessor.frequencytype,' ')         =coalesce(ad_schedule.frequencytype,' ') and
coalesce(c_acctprocessor.frequency,-1)              =coalesce(ad_schedule.frequency,-1)
and ad_schedule.scheduletype='F'
)
)
;

insert into ad_schedule (ad_schedule_id, ad_schedule_uu, ad_client_id, ad_org_id, frequencytype, frequency, scheduletype, isignoreprocessingtime
,created, createdby,description,isactive,runonlyonip,updated,updatedby,name,issystemschedule)
select distinct nextidfunc( 200020 , 'N'), generate_uuid(), 0, 0, frequencytype, frequency, scheduletype, isignoreprocessingtime
,sysdate,100,null,'Y',null,sysdate,100,coalesce(frequencytype,' ')||' '||coalesce(frequency,-1)||' '||coalesce(scheduletype,' '),'N'
from (
select distinct frequencytype, frequency, 'F' as scheduletype, 'Y' as isignoreprocessingtime
from ad_alertprocessor
where not exists (select 1 from ad_schedule where 
coalesce(ad_alertprocessor.frequencytype,' ')         =coalesce(ad_schedule.frequencytype,' ') and
coalesce(ad_alertprocessor.frequency,-1)              =coalesce(ad_schedule.frequency,-1)
and ad_schedule.scheduletype='F'
)
)
;

insert into ad_schedule (ad_schedule_id, ad_schedule_uu, ad_client_id, ad_org_id, frequencytype, frequency, scheduletype, isignoreprocessingtime
,created, createdby,description,isactive,runonlyonip,updated,updatedby,name,issystemschedule)
select distinct nextidfunc( 200020 , 'N'), generate_uuid(), 0, 0, frequencytype, frequency, scheduletype, isignoreprocessingtime
,sysdate,100,null,'Y',null,sysdate,100,coalesce(frequencytype,' ')||' '||coalesce(frequency,-1)||' '||coalesce(scheduletype,' '),'N'
from (
select distinct frequencytype, frequency, 'F' as scheduletype, 'Y' as isignoreprocessingtime
from r_requestprocessor
where not exists (select 1 from ad_schedule where 
coalesce(r_requestprocessor.frequencytype,' ')         =coalesce(ad_schedule.frequencytype,' ') and
coalesce(r_requestprocessor.frequency,-1)              =coalesce(ad_schedule.frequency,-1)
and ad_schedule.scheduletype='F'
)
)
;

insert into ad_schedule (ad_schedule_id, ad_schedule_uu, ad_client_id, ad_org_id, frequencytype, frequency, scheduletype, isignoreprocessingtime
,created, createdby,description,isactive,runonlyonip,updated,updatedby,name,issystemschedule)
select distinct nextidfunc( 200020 , 'N'), generate_uuid(), 0, 0, frequencytype, frequency, scheduletype, isignoreprocessingtime
,sysdate,100,null,'Y',null,sysdate,100,coalesce(frequencytype,' ')||' '||coalesce(frequency,-1)||' '||coalesce(scheduletype,' '),'N'
from (
select distinct frequencytype, frequency, 'F' as scheduletype, 'Y' as isignoreprocessingtime
from ad_workflowprocessor
where not exists (select 1 from ad_schedule where 
coalesce(ad_workflowprocessor.frequencytype,' ')         =coalesce(ad_schedule.frequencytype,' ') and
coalesce(ad_workflowprocessor.frequency,-1)              =coalesce(ad_schedule.frequency,-1)
and ad_schedule.scheduletype='F'
)
)
;

-- Sep 24, 2012 3:50:36 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Table SET AD_Window_ID=200012,Updated=TO_DATE('2012-09-24 15:50:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200020
;

-- Sep 24, 2012 3:50:49 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,1,'N','N',200557,'Y',200552,'N','When this is selected, the previous DateNextRun is always use as the source for the next DateNextRun calculation.','D','Do not include processing time for the DateNextRun calculation','Ignore Processing Time','Y','N','8abaf449-ec3d-4333-ba76-d437f0055462',100,0,TO_DATE('2012-09-24 15:50:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 15:50:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 24, 2012 3:50:49 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200552 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 3:51:10 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2012-09-24 15:51:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200552
;

-- Sep 24, 2012 3:51:17 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-24 15:51:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=59028
;

-- Sep 24, 2012 3:52:27 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET IsDisplayed='N', IsActive='N',Updated=TO_DATE('2012-09-24 15:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58773
;

-- Sep 24, 2012 5:06:51 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200019,1,'N','N',200558,'Y',200553,'N','D','Schedule Just For System','IsSystemSchedule','Y','N','1a29d07e-df06-4d49-bab4-733c0f547714',100,0,TO_DATE('2012-09-24 17:06:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 17:06:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 24, 2012 5:06:51 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200553 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 5:07:07 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=2,Updated=TO_DATE('2012-09-24 17:07:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200553
;

-- Sep 24, 2012 5:09:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET XPosition=5,Updated=TO_DATE('2012-09-24 17:09:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200552
;

-- Sep 24, 2012 5:29:33 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Val_Rule (Code,AD_Val_Rule_ID,EntityType,Name,Type,AD_Val_Rule_UU,CreatedBy,UpdatedBy,Updated,Created,AD_Client_ID,IsActive,AD_Org_ID) VALUES ('AD_Schedule.IsSystemSchedule=''N'' OR @AD_Client_ID@=0',200007,'D','AD_scheduler for System','S','2643339c-9859-4187-a5ec-e0809a93a43a',100,100,TO_DATE('2012-09-24 17:29:32','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 17:29:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Sep 24, 2012 5:32:02 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Val_Rule SET Name='AD_Schedule for System',Updated=TO_DATE('2012-09-24 17:32:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200007
;

-- Sep 24, 2012 5:32:06 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET AD_Val_Rule_ID=200007,Updated=TO_DATE('2012-09-24 17:32:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200490
;

-- Sep 24, 2012 5:39:23 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET AD_Val_Rule_ID=200007,Updated=TO_DATE('2012-09-24 17:39:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200491
;

-- Sep 24, 2012 5:47:37 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET AD_Val_Rule_ID=200007,Updated=TO_DATE('2012-09-24 17:47:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200493
;

-- Sep 24, 2012 5:51:36 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET AD_Val_Rule_ID=200007,Updated=TO_DATE('2012-09-24 17:51:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200492
;

-- Sep 27, 2012 10:19:28 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 10:19:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11348
;

-- Sep 27, 2012 10:19:30 AM COT
ALTER TABLE C_AcctProcessor MODIFY Frequency NUMBER(10) DEFAULT NULL 
;

ALTER TABLE C_AcctProcessor MODIFY Frequency NULL
;

-- Sep 27, 2012 11:05:06 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:05:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11348
;

-- Sep 27, 2012 11:36:59 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 11:36:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11441
;

-- Sep 27, 2012 11:37:05 AM COT
ALTER TABLE AD_AlertProcessor MODIFY Frequency NUMBER(10) DEFAULT NULL 
;

-- Sep 27, 2012 11:37:18 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:37:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11441
;

-- Sep 27, 2012 11:37:24 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 11:37:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11440
;

-- Sep 27, 2012 11:37:28 AM COT
ALTER TABLE AD_AlertProcessor MODIFY FrequencyType CHAR(1) DEFAULT NULL 
;

-- Sep 27, 2012 11:37:34 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:37:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11440
;

-- Sep 27, 2012 11:38:29 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 11:38:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5480
;

-- Sep 27, 2012 11:38:33 AM COT
ALTER TABLE R_RequestProcessor MODIFY Frequency NUMBER(10) DEFAULT 1
;

-- Sep 27, 2012 11:38:33 AM COT
ALTER TABLE R_RequestProcessor MODIFY Frequency NULL
;

-- Sep 27, 2012 11:38:38 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:38:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5480
;

-- Sep 27, 2012 11:38:45 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 11:38:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5481
;

-- Sep 27, 2012 11:38:49 AM COT
ALTER TABLE R_RequestProcessor MODIFY FrequencyType CHAR(1) DEFAULT NULL 
;

-- Sep 27, 2012 11:38:50 AM COT
ALTER TABLE R_RequestProcessor MODIFY FrequencyType NULL
;

-- Sep 27, 2012 11:38:55 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:38:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5481
;

-- Sep 27, 2012 11:39:55 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 11:39:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11391
;

-- Sep 27, 2012 11:39:56 AM COT
ALTER TABLE AD_WorkflowProcessor MODIFY Frequency NUMBER(10) DEFAULT NULL 
;

-- Sep 27, 2012 11:39:56 AM COT
ALTER TABLE AD_WorkflowProcessor MODIFY Frequency NULL
;

-- Sep 27, 2012 11:40:03 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:40:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11391
;

-- Sep 27, 2012 11:40:11 AM COT
UPDATE AD_Column SET IsMandatory='N', IsActive='N',Updated=TO_DATE('2012-09-27 11:40:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11382
;

-- Sep 27, 2012 11:45:45 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 11:45:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11247
;

-- Sep 27, 2012 11:45:49 AM COT
ALTER TABLE AD_Scheduler MODIFY Frequency NUMBER(10) DEFAULT NULL 
;

-- Sep 27, 2012 11:45:49 AM COT
ALTER TABLE AD_Scheduler MODIFY Frequency NULL
;

-- Sep 27, 2012 11:45:55 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:45:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11247
;

-- Sep 27, 2012 11:46:03 AM COT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-09-27 11:46:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11255
;

-- Sep 27, 2012 11:46:05 AM COT
ALTER TABLE AD_Scheduler MODIFY FrequencyType CHAR(1) DEFAULT NULL 
;

-- Sep 27, 2012 11:46:05 AM COT
ALTER TABLE AD_Scheduler MODIFY FrequencyType NULL
;

-- Sep 27, 2012 11:46:10 AM COT
UPDATE AD_Column SET IsActive='N',Updated=TO_DATE('2012-09-27 11:46:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=11255
;

-- Sep 27, 2012 11:49:52 AM COT
UPDATE AD_Window SET WindowType='M',Updated=TO_DATE('2012-09-27 11:49:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200012
;

-- Sep 28, 2012 5:38:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Table SET Name='Schedule',Updated=TO_DATE('2012-09-28 17:38:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=200020
;

-- Sep 28, 2012 5:38:59 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200020
;

-- Sep 28, 2012 5:42:10 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('RunOnlyOnIP',200159,'D','Run only on IP','Run only on IP','090ed7f1-67f7-4d25-ac6b-c4de976b732b',0,TO_DATE('2012-09-28 17:42:09','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-28 17:42:09','YYYY-MM-DD HH24:MI:SS'),0,0,0,'Y')
;

-- Sep 28, 2012 5:42:10 PM COT
-- IDEMPIERE-391 Scheduler improvements
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200159 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 28, 2012 5:42:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET AD_Element_ID=200159, ColumnName='RunOnlyOnIP', Description=NULL, Help=NULL, Name='Run only on IP',Updated=TO_DATE('2012-09-28 17:42:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200486
;

-- Sep 28, 2012 5:42:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200486
;

-- Sep 28, 2012 5:42:18 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET Name='Run only on IP', Description=NULL, Help=NULL WHERE AD_Column_ID=200486 AND IsCentrallyMaintained='Y'
;

CREATE UNIQUE INDEX ad_schedule_uu_idx ON ad_schedule (ad_schedule_uu)
;

-- Sep 28, 2012 6:21:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Element SET Name='System Schedule',Updated=TO_DATE('2012-09-28 18:21:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200157
;

-- Sep 28, 2012 6:21:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200157
;

-- Sep 28, 2012 6:21:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET ColumnName='IsSystemSchedule', Name='System Schedule', Description='Schedule Just For System', Help=NULL WHERE AD_Element_ID=200157
;

-- Sep 28, 2012 6:21:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Process_Para SET ColumnName='IsSystemSchedule', Name='System Schedule', Description='Schedule Just For System', Help=NULL, AD_Element_ID=200157 WHERE UPPER(ColumnName)='ISSYSTEMSCHEDULE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 28, 2012 6:21:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Process_Para SET ColumnName='IsSystemSchedule', Name='System Schedule', Description='Schedule Just For System', Help=NULL WHERE AD_Element_ID=200157 AND IsCentrallyMaintained='Y'
;

-- Sep 28, 2012 6:21:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET Name='System Schedule', Description='Schedule Just For System', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200157) AND IsCentrallyMaintained='Y'
;

-- Sep 28, 2012 6:21:19 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_PrintFormatItem pi SET PrintName='System Schedule', Name='System Schedule' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200157)
;

-- Sep 28, 2012 6:22:28 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y', FieldLength=60, IsUpdateable='Y',Updated=TO_DATE('2012-09-28 18:22:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200487
;

-- Sep 28, 2012 6:22:53 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Schedule SET Name='2 Hours',Updated=TO_DATE('2012-09-28 18:22:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Schedule_ID=200004
;

-- Sep 28, 2012 6:23:11 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule MODIFY Name NVARCHAR2(60)
;

-- Sep 28, 2012 6:23:11 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule MODIFY Name NOT NULL
;

-- Sep 28, 2012 6:26:22 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsIdentifier='N', SeqNo=0, IsUpdateable='N',Updated=TO_DATE('2012-09-28 18:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200473
;

-- Sep 28, 2012 6:26:38 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET SeqNo=1,Updated=TO_DATE('2012-09-28 18:26:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200487
;

-- Sep 28, 2012 6:26:53 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET SeqNoSelection=1,Updated=TO_DATE('2012-09-28 18:26:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200487
;

-- Sep 28, 2012 6:28:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-09-28 18:28:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200557
;

-- Sep 28, 2012 6:28:30 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule MODIFY IsIgnoreProcessingTime CHAR(1) DEFAULT 'N'
;

-- Sep 28, 2012 6:28:31 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Schedule SET IsIgnoreProcessingTime='N' WHERE IsIgnoreProcessingTime IS NULL
;

-- Sep 28, 2012 6:28:31 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule MODIFY IsIgnoreProcessingTime NOT NULL
;

-- Sep 28, 2012 6:28:42 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-09-28 18:28:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200558
;

-- Sep 28, 2012 6:28:48 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule MODIFY IsSystemSchedule CHAR(1) DEFAULT 'N'
;

-- Sep 28, 2012 6:28:48 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Schedule SET IsSystemSchedule='N' WHERE IsSystemSchedule IS NULL
;

-- Sep 28, 2012 6:28:48 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Schedule MODIFY IsSystemSchedule NOT NULL
;

-- ?? MIGRATE ACTUAL DATA


-- Sep 28, 2012 6:30:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Element SET Name='Schedule',Updated=TO_DATE('2012-09-28 18:30:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200132
;

-- Sep 28, 2012 6:30:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200132
;

-- Sep 28, 2012 6:30:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET ColumnName='AD_Schedule_ID', Name='Schedule', Description=NULL, Help=NULL WHERE AD_Element_ID=200132
;

-- Sep 28, 2012 6:30:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Process_Para SET ColumnName='AD_Schedule_ID', Name='Schedule', Description=NULL, Help=NULL, AD_Element_ID=200132 WHERE UPPER(ColumnName)='AD_SCHEDULE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Sep 28, 2012 6:30:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Process_Para SET ColumnName='AD_Schedule_ID', Name='Schedule', Description=NULL, Help=NULL WHERE AD_Element_ID=200132 AND IsCentrallyMaintained='Y'
;

-- Sep 28, 2012 6:30:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Field SET Name='Schedule', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200132) AND IsCentrallyMaintained='Y'
;

-- Sep 28, 2012 6:30:44 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_PrintFormatItem pi SET PrintName='Schedule', Name='Schedule' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200132)
;

-- Sep 28, 2012 6:32:24 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Scheduler SET Record_ID=NULL, AD_Schedule_ID=200001,Updated=TO_DATE('2012-09-28 18:32:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Scheduler_ID=100
;

-- Sep 28, 2012 6:34:29 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-09-28 18:34:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200491
;

/* Set schedules for actual records before making them mandatory */
update ad_scheduler set ad_schedule_id=(select min(ad_schedule_id) from ad_schedule where 
coalesce(ad_scheduler.frequencytype,' ')         =coalesce(ad_schedule.frequencytype,' ') and
coalesce(ad_scheduler.frequency,-1)              =coalesce(ad_schedule.frequency,-1) and
coalesce(ad_scheduler.weekday,' ')               =coalesce(ad_schedule.weekday,' ') and
coalesce(ad_scheduler.scheduletype,' ')          =coalesce(ad_schedule.scheduletype,' ') and
coalesce(ad_scheduler.isignoreprocessingtime,' ')=coalesce(ad_schedule.isignoreprocessingtime,' ') and
nvl(ad_scheduler.cronpattern,' ')           =nvl(ad_schedule.cronpattern,' '))
;

update c_acctprocessor set ad_schedule_id=(select min(ad_schedule_id) from ad_schedule where 
coalesce(c_acctprocessor.frequencytype,' ')=coalesce(ad_schedule.frequencytype,' ') and
coalesce(c_acctprocessor.frequency,-1)     =coalesce(ad_schedule.frequency,-1) and
ad_schedule.scheduletype='F')
;

update ad_alertprocessor set ad_schedule_id=(select min(ad_schedule_id) from ad_schedule where 
coalesce(ad_alertprocessor.frequencytype,' ')=coalesce(ad_schedule.frequencytype,' ') and
coalesce(ad_alertprocessor.frequency,-1)     =coalesce(ad_schedule.frequency,-1) and
ad_schedule.scheduletype='F')
;

update ad_workflowprocessor set ad_schedule_id=(select min(ad_schedule_id) from ad_schedule where 
coalesce(ad_workflowprocessor.frequencytype,' ')=coalesce(ad_schedule.frequencytype,' ') and
coalesce(ad_workflowprocessor.frequency,-1)     =coalesce(ad_schedule.frequency,-1) and
ad_schedule.scheduletype='F')
;

update r_requestprocessor set ad_schedule_id=(select min(ad_schedule_id) from ad_schedule where 
coalesce(r_requestprocessor.frequencytype,' ')=coalesce(ad_schedule.frequencytype,' ') and
coalesce(r_requestprocessor.frequency,-1)     =coalesce(ad_schedule.frequency,-1) and
ad_schedule.scheduletype='F')
;

-- Sep 28, 2012 6:34:33 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_AlertProcessor MODIFY AD_Schedule_ID NUMBER(10)
;

-- Sep 28, 2012 6:34:33 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_AlertProcessor MODIFY AD_Schedule_ID NOT NULL
;

-- Sep 28, 2012 6:34:50 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-09-28 18:34:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200489
;

-- Sep 28, 2012 6:34:52 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Scheduler MODIFY AD_Schedule_ID NUMBER(10)
;

-- Sep 28, 2012 6:34:52 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_Scheduler MODIFY AD_Schedule_ID NOT NULL
;

-- Sep 28, 2012 6:35:38 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_WorkflowProcessor SET AD_Schedule_ID=200004,Updated=TO_DATE('2012-09-28 18:35:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_WorkflowProcessor_ID=100
;

-- Sep 28, 2012 6:36:15 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-09-28 18:36:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200493
;

-- Sep 28, 2012 6:36:16 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_WorkflowProcessor MODIFY AD_Schedule_ID NUMBER(10)
;

-- Sep 28, 2012 6:36:16 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE AD_WorkflowProcessor MODIFY AD_Schedule_ID NOT NULL
;

-- Sep 28, 2012 6:37:32 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE C_AcctProcessor SET AD_Schedule_ID=200002,Updated=TO_DATE('2012-09-28 18:37:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctProcessor_ID=100
;

-- Sep 28, 2012 6:38:02 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE R_RequestProcessor SET AD_Schedule_ID=200003,Updated=TO_DATE('2012-09-28 18:38:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE R_RequestProcessor_ID=100
;

-- Sep 28, 2012 6:38:36 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-09-28 18:38:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200490
;

-- Sep 28, 2012 6:38:37 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE C_AcctProcessor MODIFY AD_Schedule_ID NUMBER(10)
;

-- Sep 28, 2012 6:38:37 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE C_AcctProcessor MODIFY AD_Schedule_ID NOT NULL
;

-- Sep 28, 2012 6:39:50 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-09-28 18:39:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200492
;

-- Sep 28, 2012 6:39:52 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE R_RequestProcessor MODIFY AD_Schedule_ID NUMBER(10)
;

-- Sep 28, 2012 6:39:52 PM COT
-- IDEMPIERE-391 Scheduler improvements
ALTER TABLE R_RequestProcessor MODIFY AD_Schedule_ID NOT NULL
;

-- Sep 28, 2012 6:47:43 PM COT
-- IDEMPIERE-391 Scheduler improvements
UPDATE AD_Column SET AD_Val_Rule_ID=200007,Updated=TO_DATE('2012-09-28 18:47:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200489
;

-- Oct 2, 2012 8:02:11 PM COT
UPDATE AD_Field SET DisplayLogic='@ScheduleType@=F',Updated=TO_DATE('2012-10-02 20:02:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200495
;

-- Oct 2, 2012 8:06:14 PM COT
UPDATE AD_Element SET Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html',Updated=TO_DATE('2012-10-02 20:06:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=54124
;

-- Oct 2, 2012 8:06:14 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=54124
;

-- Oct 2, 2012 8:06:14 PM COT
UPDATE AD_Column SET ColumnName='CronPattern', Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html' WHERE AD_Element_ID=54124
;

-- Oct 2, 2012 8:06:14 PM COT
UPDATE AD_Process_Para SET ColumnName='CronPattern', Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html', AD_Element_ID=54124 WHERE UPPER(ColumnName)='CRONPATTERN' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 2, 2012 8:06:14 PM COT
UPDATE AD_Process_Para SET ColumnName='CronPattern', Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html' WHERE AD_Element_ID=54124 AND IsCentrallyMaintained='Y'
;

-- Oct 2, 2012 8:06:14 PM COT
UPDATE AD_Field SET Name='Cron Scheduling Pattern', Description='Cron pattern to define when the process should be invoked.', Help='Cron pattern to define when the process should be invoked. See http://www.sauronsoftware.it/projects/cron4j/api/it/sauronsoftware/cron4j/SchedulingPattern.html' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=54124) AND IsCentrallyMaintained='Y'
;

ALTER TABLE C_AcctProcessor MODIFY FrequencyType NULL
;

ALTER TABLE AD_AlertProcessor MODIFY Frequency NULL
;

ALTER TABLE AD_WorkflowProcessor MODIFY FrequencyType NULL
;

-- Oct 2, 2012 10:44:20 PM COT
UPDATE AD_Field SET IsDisplayed='N',Updated=TO_DATE('2012-10-02 22:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9434
;

SELECT register_migration_script('912_IDEMPIERE-391.sql') FROM dual
;

