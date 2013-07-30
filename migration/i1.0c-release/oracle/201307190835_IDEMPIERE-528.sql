-- Feb 28, 2013 9:10:46 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Table (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Table_UU,AccessLevel,CopyColumnsFromTable,Created,CreatedBy,EntityType,ImportTable,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,ReplicationType,TableName,Updated,UpdatedBy) VALUES (0,0,200066,'7017f8ca-58d1-49a3-958e-e480afac19b7','6','N',TO_DATE('2013-02-28 09:10:44','YYYY-MM-DD HH24:MI:SS'),100,'D','N','Y','Y','N','Y','N','N','N',0,'AD_ZoomCondition','L','AD_ZoomCondition',TO_DATE('2013-02-28 09:10:44','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:10:47 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Feb 28, 2013 9:10:48 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,AD_Sequence_UU,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200061,'9b7528dd-6a23-4d7b-9f0c-cd1187f6ee61',TO_DATE('2013-02-28 09:10:47','YYYY-MM-DD HH24:MI:SS'),100,1000000,200000,'Table AD_ZoomCondition',1,'Y','N','Y','Y','AD_ZoomCondition','N',1000000,TO_DATE('2013-02-28 09:10:47','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:11:20 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,ReadOnlyLogic,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208597,'7693c30c-ed90-4904-90e7-cdcdfd24bdd1',102,0,19,200066,'AD_Client_ID',TO_DATE('2013-02-28 09:11:20','YYYY-MM-DD HH24:MI:SS'),100,'@#AD_Client_ID@','Client/Tenant for this installation.','D',10,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Client','1=1',0,0,TO_DATE('2013-02-28 09:11:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:11:21 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208597 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:12:54 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208599,'22446ae7-86ed-4394-a4c3-9a117a68a6a9',113,0,19,200066,'AD_Org_ID',TO_DATE('2013-02-28 09:12:53','YYYY-MM-DD HH24:MI:SS'),100,'@AD_Org_ID@','Organizational entity within client','D',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Organization',0,0,TO_DATE('2013-02-28 09:12:53','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:12:54 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208599 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:13:12 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208600,'18655836-ca9e-484d-98bf-82fa89852f53',126,0,19,200066,'AD_Table_ID',TO_DATE('2013-02-28 09:13:11','YYYY-MM-DD HH24:MI:SS'),100,'Database Table information','D',10,'The Database Table provides the information of the table definition','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','Y','Table',0,0,TO_DATE('2013-02-28 09:13:11','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:13:12 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208600 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:13:23 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208601,'abf3c6ba-7603-4461-8869-fb3ce02ef8c8',143,0,19,200066,'AD_Window_ID',TO_DATE('2013-02-28 09:13:23','YYYY-MM-DD HH24:MI:SS'),100,'Data entry or display window','D',10,'The Window field identifies a unique Window in the system.','Y','Y','Y','N','N','N','N','N','N','N','N','N','N','N','Y','Window',0,0,TO_DATE('2013-02-28 09:13:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:13:23 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208601 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:14:00 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Element_UU,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,202220,'702a0568-b6d2-4a03-bd40-ebd5553c0e87',0,'AD_ZoomCondition_ID',TO_DATE('2013-02-28 09:13:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Zoom condition','Zoom Condition',TO_DATE('2013-02-28 09:13:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:14:00 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202220 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 9:14:21 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208602,'8cd799e3-79e0-46f1-97ce-fb70d8b5ce42',202220,0,13,200066,'AD_ZoomCondition_ID',TO_DATE('2013-02-28 09:14:20','YYYY-MM-DD HH24:MI:SS'),100,'D',10,'Y','N','Y','N','N','N','N','Y','Y','N','N','N','N','N','N','Zoom condition',0,0,TO_DATE('2013-02-28 09:14:20','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:14:21 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208602 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:14:37 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208603,'5da090fc-fcc1-4e8d-a3b5-4349e15eecc8',245,0,16,200066,'Created',TO_DATE('2013-02-28 09:14:36','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was created','D',7,'The Created field indicates the date that this record was created.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Created',0,0,TO_DATE('2013-02-28 09:14:36','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:14:37 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208603 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:14:56 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208604,'912511e6-6c78-4c95-97c3-ba10c6f52f78',246,0,30,110,200066,'CreatedBy',TO_DATE('2013-02-28 09:14:56','YYYY-MM-DD HH24:MI:SS'),100,'User who created this records','D',10,'The Created By field indicates the user who created this record.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','N','Created By',0,0,TO_DATE('2013-02-28 09:14:56','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:14:56 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208604 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:15:15 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208605,'a885d497-ffa3-4af9-9f66-3aa8f4d9d913',275,0,10,200066,'Description',TO_DATE('2013-02-28 09:15:14','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record','D',255,'A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','N','N','Y','N','N','N','Y','Description',0,0,TO_DATE('2013-02-28 09:15:14','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:15:15 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208605 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:15:45 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,DefaultValue,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208606,'0ebeff27-20ce-4fe4-af1d-8bc15bdba33d',348,0,20,200066,'IsActive',TO_DATE('2013-02-28 09:15:45','YYYY-MM-DD HH24:MI:SS'),100,'Y','The record is active in the system','D',1,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','Y','Active',0,0,TO_DATE('2013-02-28 09:15:45','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:15:45 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208606 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:16:01 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202221 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Feb 28, 2013 9:16:44 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208609,'172a5e9f-9349-4cb9-ac36-e30c8084cad6',607,0,16,200066,'Updated',TO_DATE('2013-02-28 09:16:44','YYYY-MM-DD HH24:MI:SS'),100,'Date this record was updated','D',7,'The Updated field indicates the date that this record was updated.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','Y','Updated',0,0,TO_DATE('2013-02-28 09:16:44','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:16:44 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208609 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:17:02 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column (AD_Client_ID,AD_Column_ID,AD_Column_UU,AD_Element_ID,AD_Org_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,ColumnName,Created,CreatedBy,Description,EntityType,FieldLength,Help,IsActive,IsAllowCopy,IsAllowLogging,IsAlwaysUpdateable,IsAutocomplete,IsEncrypted,IsIdentifier,IsKey,IsMandatory,IsParent,IsSelectionColumn,IsSyncDatabase,IsToolbarButton,IsTranslated,IsUpdateable,Name,SeqNo,SeqNoSelection,Updated,UpdatedBy,Version) VALUES (0,208610,'7ec0064d-79a7-40c8-8b63-56c250c511e7',608,0,30,110,200066,'UpdatedBy',TO_DATE('2013-02-28 09:17:01','YYYY-MM-DD HH24:MI:SS'),100,'User who updated this records','D',10,'The Updated By field indicates the user who updated this record.','Y','N','Y','N','N','N','N','N','Y','N','N','N','N','N','Y','Updated By',0,0,TO_DATE('2013-02-28 09:17:01','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Feb 28, 2013 9:17:02 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208610 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Feb 28, 2013 9:19:31 AM CET
-- IDEMPIERE 528
CREATE TABLE AD_ZoomCondition (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_Table_ID NUMBER(10) NOT NULL , AD_Window_ID NUMBER(10) NOT NULL , AD_ZoomCondition_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description NVARCHAR2(255) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_ZoomCondition_Key PRIMARY KEY (AD_ZoomCondition_ID))
;

-- Feb 28, 2013 9:21:18 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Tab (AD_Client_ID,AD_Org_ID,AD_Tab_ID,AD_Tab_UU,AD_Table_ID,AD_Window_ID,Created,CreatedBy,EntityType,HasTree,ImportFields,IsActive,IsAdvancedTab,IsInfoTab,IsInsertRecord,IsReadOnly,IsSingleRow,IsSortTab,IsTranslationTab,Name,Processing,SeqNo,TabLevel,Updated,UpdatedBy) VALUES (0,0,200077,'a0a70dd0-c734-480f-8747-f214b664434f',200066,100,TO_DATE('2013-02-28 09:21:17','YYYY-MM-DD HH24:MI:SS'),100,'D','N','N','Y','N','N','Y','N','N','N','N','Zoom Condition','N',50,1,TO_DATE('2013-02-28 09:21:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:18 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, CommitWarning,Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.CommitWarning,t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200077 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Feb 28, 2013 9:21:21 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,208606,201828,'95c4eb2d-402e-4c90-8de6-645894be94ee',0,200077,TO_DATE('2013-02-28 09:21:21','YYYY-MM-DD HH24:MI:SS'),100,'The record is active in the system',1,'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Y','Y','Y','N','N','N','N','N','Active',TO_DATE('2013-02-28 09:21:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:21 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201828 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:22 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,208597,201829,'4329192c-9678-40e0-9fca-47998707d6e5',0,200077,TO_DATE('2013-02-28 09:21:21','YYYY-MM-DD HH24:MI:SS'),100,'Client/Tenant for this installation.',10,'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Y','Y','Y','N','N','N','N','N','Client',TO_DATE('2013-02-28 09:21:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:22 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201829 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:23 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,208605,201831,'48a9f52f-9e36-4b6f-91cd-2625054b0e2c',0,200077,TO_DATE('2013-02-28 09:21:22','YYYY-MM-DD HH24:MI:SS'),100,'Optional short description of the record',255,'D','A description is limited to 255 characters.','Y','Y','Y','N','N','N','N','N','Description',TO_DATE('2013-02-28 09:21:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:23 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201831 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:24 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201833 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:25 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,208599,201834,'fdb09527-c0d3-4890-90bf-0718a4cef97c',0,200077,TO_DATE('2013-02-28 09:21:24','YYYY-MM-DD HH24:MI:SS'),100,'Organizational entity within client',10,'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Y','Y','Y','N','N','N','N','N','Organization',TO_DATE('2013-02-28 09:21:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:25 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201834 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:26 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,208600,201836,'81d602d3-8103-4cad-9fb6-ef6d140bc287',0,200077,TO_DATE('2013-02-28 09:21:25','YYYY-MM-DD HH24:MI:SS'),100,'Database Table information',10,'D','The Database Table provides the information of the table definition','Y','Y','Y','N','N','N','N','N','Table',TO_DATE('2013-02-28 09:21:25','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:26 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201836 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:26 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,Description,DisplayLength,EntityType,Help,IsActive,IsCentrallyMaintained,IsDisplayed,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,208601,201837,'88383714-5074-4fc2-aaeb-9bd26bb05f62',0,200077,TO_DATE('2013-02-28 09:21:26','YYYY-MM-DD HH24:MI:SS'),100,'Data entry or display window',10,'D','The Window field identifies a unique Window in the system.','Y','Y','Y','N','N','N','N','N','Window',TO_DATE('2013-02-28 09:21:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:26 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201837 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:27 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field (AD_Client_ID,AD_Column_ID,AD_Field_ID,AD_Field_UU,AD_Org_ID,AD_Tab_ID,Created,CreatedBy,DisplayLength,EntityType,IsActive,IsCentrallyMaintained,IsDisplayed,IsDisplayedGrid,IsEncrypted,IsFieldOnly,IsHeading,IsReadOnly,IsSameLine,Name,Updated,UpdatedBy) VALUES (0,208602,201838,'0b3e75c7-d953-4c10-8a0a-a24c65fa3c44',0,200077,TO_DATE('2013-02-28 09:21:26','YYYY-MM-DD HH24:MI:SS'),100,10,'D','Y','Y','N','N','N','N','N','N','N','Zoom condition',TO_DATE('2013-02-28 09:21:26','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Feb 28, 2013 9:21:27 AM CET
-- IDEMPIERE 528
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201838 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201829
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201834
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201828
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201837
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201832
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201831
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201836
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201830
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=201833
;

-- Feb 28, 2013 9:21:56 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=201835
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201829
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201834
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201837
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201832
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201828
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201831
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201836
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201830
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201833
;

-- Feb 28, 2013 9:22:30 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201835
;

-- Feb 28, 2013 9:23:47 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-28 09:23:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201834
;

-- Feb 28, 2013 9:24:07 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-28 09:24:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201830
;

-- Feb 28, 2013 9:24:13 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-28 09:24:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201835
;

-- Feb 28, 2013 9:31:41 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, XPosition=3,Updated=TO_DATE('2013-02-28 09:31:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201834
;

-- Feb 28, 2013 9:31:42 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=2,Updated=TO_DATE('2013-02-28 09:31:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201828
;

-- Feb 28, 2013 9:31:42 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=3,Updated=TO_DATE('2013-02-28 09:31:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201832
;

-- Feb 28, 2013 9:31:42 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, XPosition=3,Updated=TO_DATE('2013-02-28 09:31:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201830
;

-- Feb 28, 2013 9:31:42 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=3,Updated=TO_DATE('2013-02-28 09:31:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201835
;

-- Feb 28, 2013 9:31:42 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET SeqNo=0,Updated=TO_DATE('2013-02-28 09:31:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201838
;

-- Feb 28, 2013 9:33:54 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2013-02-28 09:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201832
;

-- Feb 28, 2013 9:34:54 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET IsCentrallyMaintained='N',Updated=TO_DATE('2013-02-28 09:34:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Feb 28, 2013 9:35:13 AM CET
-- IDEMPIERE 528
UPDATE AD_Field SET Name='Standard Window (from AD_Table)',Updated=TO_DATE('2013-02-28 09:35:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Feb 28, 2013 9:35:13 AM CET
-- IDEMPIERE 528
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=201837
;

-- Mar 6, 2013 3:42:43 PM COT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',0,200066,208802,'D','N','N','N',0,'N',22,'N',11,'N',566,'N','Y','e92a35b8-c042-44b8-ad1a-24b7c248f736','Y','SeqNo','Method of ordering records; lowest number comes first',NULL,'The Sequence indicates the order of records','Sequence','N',TO_DATE('2013-03-06 15:42:26','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-03-06 15:42:26','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Mar 6, 2013 3:42:43 PM COT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208802 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 6, 2013 3:43:06 PM COT
-- IDEMPIERE-528 Determine Zoom window depending on record
ALTER TABLE AD_ZoomCondition ADD SeqNo NUMBER(10) DEFAULT NULL 
;

-- Jul 19, 2013 5:06:58 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',0,200066,210659,'Y','N','N',0,'N',2000,'N',14,'N','N','Y','441569aa-fb87-46dd-a0f4-a1716a815a56','Y','WhereClause','Fully qualified SQL WHERE clause','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".','Sql WHERE','Y',TO_DATE('2013-07-19 17:06:41','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-07-19 17:06:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',630)
;

-- Jul 19, 2013 5:06:58 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210659 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 19, 2013 5:07:02 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
ALTER TABLE AD_ZoomCondition ADD WhereClause NVARCHAR2(2000) NOT NULL
;

-- Jul 19, 2013 5:07:15 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2013-07-19 17:07:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208600
;

-- Jul 19, 2013 5:07:26 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2013-07-19 17:07:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208601
;

-- Jul 19, 2013 5:09:40 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET Name='Window',IsCentrallyMaintained='Y',Updated=TO_DATE('2013-07-19 17:09:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Jul 19, 2013 5:10:20 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines) VALUES (0,'N',200077,0,'N','N',210659,80,'Y',202337,'N','The Where Clause indicates the SQL WHERE clause to use for record selection. The WHERE clause is added to the query. Fully qualified means "tablename.columnname".','D','Fully qualified SQL WHERE clause','Sql WHERE','0fe4d6d4-6156-413f-9ea4-95f769abfe7e','Y','N',100,0,TO_DATE('2013-07-19 17:10:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-07-19 17:10:04','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,'N',0,1,1)
;

-- Jul 19, 2013 5:10:20 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202337 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 19, 2013 5:12:29 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=40, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-07-19 17:12:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201836
;

-- Jul 19, 2013 5:12:29 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=50,Updated=TO_DATE('2013-07-19 17:12:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Jul 19, 2013 5:12:29 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=1, ColumnSpan=3, NumLines=3,Updated=TO_DATE('2013-07-19 17:12:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202337
;

-- Jul 19, 2013 5:12:29 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=1, ColumnSpan=2,Updated=TO_DATE('2013-07-19 17:12:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201831
;

-- Jul 22, 2013 11:48:27 AM MYT
-- IDEMPIERE-1042 Role Data Access
UPDATE AD_SysConfig SET Value='IDEMPIERE-528 Determine Zoom window depending on record',Updated=TO_DATE('2013-07-22 11:48:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50003
;

-- Jul 22, 2013 11:50:07 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID) VALUES (0,'N',1,200066,210660,'Y','N','Y',0,'N',60,'Y',10,'N','N','Y','45deb4e7-a2a4-4aa5-9f32-05c2066e72cd','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',TO_DATE('2013-07-22 11:50:03','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2013-07-22 11:50:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',469)
;

-- Jul 22, 2013 11:50:07 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=210660 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jul 22, 2013 11:50:16 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
ALTER TABLE AD_ZoomCondition ADD Name NVARCHAR2(60) NOT NULL
;

-- Jul 22, 2013 11:50:29 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_DATE('2013-07-22 11:50:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208600
;

-- Jul 22, 2013 11:51:35 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Field (NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan) VALUES (1,0,'N',200077,0,'N','N',210660,80,'Y',202338,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','Y','N','7fe3177c-2c44-4f58-944d-6f921646eb7d',100,0,TO_DATE('2013-07-22 11:51:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-07-22 11:51:33','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,1,'N',0,1)
;

-- Jul 22, 2013 11:51:35 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202338 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 22, 2013 11:54:03 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Column SET DefaultValue='@SQL=SELECT COALESCE(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_ZoomCondition WHERE AD_Table_ID=@AD_Table_ID@',Updated=TO_DATE('2013-07-22 11:54:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208802
;

-- Jul 22, 2013 11:54:50 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-07-22 11:54:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201836
;

-- Jul 22, 2013 11:54:51 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=40,Updated=TO_DATE('2013-07-22 11:54:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201828
;

-- Jul 22, 2013 11:54:51 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-07-22 11:54:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202338
;

-- Jul 22, 2013 11:54:51 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=60, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-07-22 11:54:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201831
;

-- Jul 22, 2013 11:54:51 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2013-07-22 11:54:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Jul 22, 2013 11:54:51 AM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2013-07-22 11:54:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202337
;

-- Jul 22, 2013 12:03:45 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET IsReadOnly='Y', IsAllowCopy='Y',Updated=TO_DATE('2013-07-22 12:03:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201834
;

-- Jul 22, 2013 12:05:46 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Field (NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan) VALUES (1,0,'N',200077,0,'N','N',208802,90,'Y',202339,'N','The Sequence indicates the order of records','D','Method of ordering records; lowest number comes first','Sequence','Y','N','01de863d-b0b4-4745-b85f-4fde583761de',100,0,TO_DATE('2013-07-22 12:05:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-07-22 12:05:44','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,1)
;

-- Jul 22, 2013 12:05:46 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=202339 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jul 22, 2013 12:06:10 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_DATE('2013-07-22 12:06:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202339
;

-- Jul 22, 2013 12:06:10 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=60,Updated=TO_DATE('2013-07-22 12:06:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202338
;

-- Jul 22, 2013 12:06:10 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=70,Updated=TO_DATE('2013-07-22 12:06:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201831
;

-- Jul 22, 2013 12:06:10 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=80,Updated=TO_DATE('2013-07-22 12:06:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201837
;

-- Jul 22, 2013 12:06:10 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Field SET SeqNo=90,Updated=TO_DATE('2013-07-22 12:06:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202337
;

-- Jul 22, 2013 1:02:14 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Tab SET SeqNo=60,Updated=TO_DATE('2013-07-22 13:02:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53069
;

-- Jul 22, 2013 1:02:25 PM MYT
-- IDEMPIERE-528 Determine Zoom window depending on record
UPDATE AD_Tab SET SeqNo=70,Updated=TO_DATE('2013-07-22 13:02:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=673
;

SELECT register_migration_script('201307190835_IDEMPIERE-528.sql') FROM dual
;

