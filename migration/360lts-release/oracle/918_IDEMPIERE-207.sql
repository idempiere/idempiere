-- Sep 24, 2012 12:16:27 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Window (AD_Window_ID,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,EntityType,Name,IsActive,Created,UpdatedBy,CreatedBy,Updated,AD_Org_ID,AD_Client_ID,Processing) VALUES (200013,'M','Y','N','N','D','GL Journal Generator','Y',TO_DATE('2012-09-24 12:16:25','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2012-09-24 12:16:25','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Sep 24, 2012 12:16:27 PM COT
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Sep 24, 2012 12:16:28 PM COT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Window_ID,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','3',200013,200021,'N','N','N','Y','D','Y','L','GL_JournalGenerator','GL Journal Generator',0,'Y',0,100,TO_DATE('2012-09-24 12:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:27','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:28 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Sep 24, 2012 12:16:28 PM COT
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,CreatedBy,IsActive) VALUES (1,'N',200000,'Y',1000000,1000000,'N','Y',200021,'Table GL_JournalGenerator','GL_JournalGenerator',0,0,TO_DATE('2012-09-24 12:16:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:28','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 24, 2012 12:16:29 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200134,'GL_JournalGenerator_ID','D','GL Journal Generator','GL Journal Generator',0,TO_DATE('2012-09-24 12:16:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:16:28','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:16:29 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200134 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:16:30 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200494,200021,'D',1,'Y','N','N','N',22,'N',13,'Y','Y',200134,'N','N','N','GL_JournalGenerator_ID','GL Journal Generator',100,TO_DATE('2012-09-24 12:16:29','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:30 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200494 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:30 PM COT
CREATE TABLE GL_JournalGenerator (GL_JournalGenerator_ID NUMBER(10) NOT NULL, CONSTRAINT GL_JournalGenerator_Key PRIMARY KEY (GL_JournalGenerator_ID))
;

-- Sep 24, 2012 12:16:30 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Client_ID@',200495,200021,'D',1,'Y','N','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'Y','N',102,'N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client',100,TO_DATE('2012-09-24 12:16:30','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:30 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200495 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:30 PM COT
ALTER TABLE GL_JournalGenerator ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:16:31 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Org_ID@',200496,200021,'D',1,'Y','N','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'Y',104,'N',113,'N','N','N','AD_Org_ID','Organizational entity within client','Organization',100,TO_DATE('2012-09-24 12:16:31','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:31 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200496 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:31 PM COT
ALTER TABLE GL_JournalGenerator ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:16:32 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200497,200021,'D',1,'Y','N','N','The Created field indicates the date that this record was created.','N',7,'N',16,'Y','N',245,'N','N','N','Created','Date this record was created','Created',100,TO_DATE('2012-09-24 12:16:31','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:32 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200497 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:32 PM COT
ALTER TABLE GL_JournalGenerator ADD Created DATE NOT NULL
;

-- Sep 24, 2012 12:16:32 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200498,200021,'D',1,110,'Y','N','N','The Created By field indicates the user who created this record.','N',22,'N',18,'Y','N',246,'N','N','N','CreatedBy','User who created this records','Created By',100,TO_DATE('2012-09-24 12:16:32','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:32 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200498 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:32 PM COT
ALTER TABLE GL_JournalGenerator ADD CreatedBy NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:16:33 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200499,200021,'D',1,'N','N','N','A description is limited to 255 characters.','N',255,'Y',10,'Y','N',275,'N','Y','N','Description','Optional short description of the record','Description',100,TO_DATE('2012-09-24 12:16:32','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:33 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200499 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:33 PM COT
ALTER TABLE GL_JournalGenerator ADD Description NVARCHAR2(255) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:33 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200500,200021,'D',1,'N','N','N','The Help field contains a hint, comment or help about the use of this item.','N',2000,'N',14,'Y','N',326,'N','Y','N','Help','Comment or Hint','Comment/Help',100,TO_DATE('2012-09-24 12:16:33','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:33 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200500 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:33 PM COT
ALTER TABLE GL_JournalGenerator ADD Help NVARCHAR2(2000) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:34 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200501,200021,'D',1,'Y','N','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'Y','N',348,'N','Y','N','IsActive','The record is active in the system','Active',100,TO_DATE('2012-09-24 12:16:34','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:34 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200501 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:34 PM COT
ALTER TABLE GL_JournalGenerator ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Sep 24, 2012 12:16:35 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200502,200021,'D',1,'Y','N','Y',1,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','N',60,'Y',10,'Y','N',469,'N','Y','N','Name','Alphanumeric identifier of the entity','Name',100,TO_DATE('2012-09-24 12:16:34','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:35 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200502 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:35 PM COT
ALTER TABLE GL_JournalGenerator ADD Name NVARCHAR2(60) NOT NULL
;

-- Sep 24, 2012 12:16:36 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200503,200021,'D',1,'Y','N','N','The Updated field indicates the date that this record was updated.','N',7,'N',16,'Y','N',607,'N','N','N','Updated','Date this record was updated','Updated',100,TO_DATE('2012-09-24 12:16:35','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:36 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200503 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:36 PM COT
ALTER TABLE GL_JournalGenerator ADD Updated DATE NOT NULL
;

-- Sep 24, 2012 12:16:36 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200504,200021,'D',1,110,'Y','N','N','The Updated By field indicates the user who updated this record.','N',22,'N',18,'Y','N',608,'N','N','N','UpdatedBy','User who updated this records','Updated By',100,TO_DATE('2012-09-24 12:16:36','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:36 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200504 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:36 PM COT
ALTER TABLE GL_JournalGenerator ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:16:37 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200135,'C_ElementValueAdjustDR_ID','D','Account Adjust DR','Account Adjust DR',0,TO_DATE('2012-09-24 12:16:36','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:16:36','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:16:37 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200135 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:16:37 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200505,200021,'D',0,362,'N','N','N','N',10,'N',18,'Y',252,'N',200135,'N','Y','N','C_ElementValueAdjustDR_ID','Account Adjust DR',100,TO_DATE('2012-09-24 12:16:37','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:37','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:37 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200505 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:37 PM COT
ALTER TABLE GL_JournalGenerator ADD C_ElementValueAdjustDR_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:38 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200136,'C_ElementValueAdjustCR_ID','D','Account Adjust CR','Account Adjust CR',0,TO_DATE('2012-09-24 12:16:37','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:16:37','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:16:38 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200136 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:16:38 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200506,200021,'D',0,362,'N','N','N','N',10,'N',18,'Y',252,'N',200136,'N','Y','N','C_ElementValueAdjustCR_ID','Account Adjust CR',100,TO_DATE('2012-09-24 12:16:38','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:38','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:38 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200506 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:38 PM COT
ALTER TABLE GL_JournalGenerator ADD C_ElementValueAdjustCR_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:39 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200507,200021,'D',0,'N','N','N','The Document Type determines document sequence and processing rules','N',10,'N',19,'Y',102,'N',196,'N','Y','N','C_DocType_ID','Document type or rules','Document Type',100,TO_DATE('2012-09-24 12:16:39','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:39 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200507 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:39 PM COT
ALTER TABLE GL_JournalGenerator ADD C_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:40 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@GL_Category_ID@',200508,200021,'D',0,'N','N','N','The General Ledger Category is an optional, user defined method of grouping journal lines.','N',10,'N',19,'Y',118,'N',309,'N','Y','N','GL_Category_ID','General Ledger Category','GL Category',100,TO_DATE('2012-09-24 12:16:39','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:39','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:40 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200508 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:40 PM COT
ALTER TABLE GL_JournalGenerator ADD GL_Category_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:40 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200137,'GenerateGLJournal','D','Generate GL Journal','Generate GL Journal',0,TO_DATE('2012-09-24 12:16:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:16:40','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:16:40 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200137 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:16:41 PM COT
INSERT INTO AD_Process (AD_Process_ID,IsDirectPrint,IsReport,AccessLevel,IsBetaFunctionality,WorkflowValue,ShowHelp,EntityType,Statistic_Seconds,Statistic_Count,Classname,Value,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,CreatedBy,Created,IsActive) VALUES (200010,'N','N','3','N',NULL,'Y','D',0,0,'org.globalqss.process.GLJournalGenerate','GLJournalGenerate','Generate GL Journal',0,0,TO_DATE('2012-09-24 12:16:40','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2012-09-24 12:16:40','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 24, 2012 12:16:41 PM COT
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Sep 24, 2012 12:16:42 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,AD_Process_ID,IsCentrallyMaintained,DefaultValue2,AD_Reference_ID,SeqNo,IsMandatory,DefaultValue,AD_Element_ID,EntityType,Name,ColumnName,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('Y',200036,10,200010,'Y','@SQL=SELECT firstof(SYSDATE,''MM'')-1 FROM DUAL',15,10,'Y','@SQL=SELECT firstof(add_months(SYSDATE,-1),''MM'') FROM DUAL',1479,'D','Processing date','ProcessingDate','Y',0,100,TO_DATE('2012-09-24 12:16:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:41','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:16:42 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200036 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 24, 2012 12:16:42 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,Help,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,SeqNo,IsMandatory,DefaultValue,AD_Element_ID,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200037,10,'The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200010,'Y',15,20,'Y','@#Date@',263,'D','Account Date','DateAcct','Accounting Date','Y',0,100,TO_DATE('2012-09-24 12:16:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:42','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:16:42 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200037 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 24, 2012 12:16:43 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,SeqNo,IsMandatory,DefaultValue,AD_Element_ID,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200038,10,200010,'Y',20,30,'Y','Y',1667,'D','Simulation','IsSimulation','Performing the function is only simulated','Y',0,100,TO_DATE('2012-09-24 12:16:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:42','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:16:43 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200038 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 24, 2012 12:16:43 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,Help,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,AD_Val_Rule_ID,SeqNo,IsMandatory,AD_Reference_Value_ID,AD_Element_ID,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200039,10,'You find the current status in the Document Status field. The options are listed in a popup',200010,'Y',17,219,40,'N',135,287,'D','Document Action','DocAction','The targeted status of the document','Y',0,100,TO_DATE('2012-09-24 12:16:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:43','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:16:43 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200039 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 24, 2012 12:16:44 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,Help,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,SeqNo,IsMandatory,AD_Element_ID,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200040,30,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".',200010,'Y',10,50,'N',290,'D','Document No','DocumentNo','Document sequence number of the document','Y',0,100,TO_DATE('2012-09-24 12:16:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:43','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:16:44 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200040 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 24, 2012 12:16:44 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,Help,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,SeqNo,IsMandatory,AD_Reference_Value_ID,AD_Element_ID,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200041,10,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson',200010,'Y',30,60,'N',138,187,'D','Business Partner ','C_BPartner_ID','Identifies a Business Partner','Y',0,100,TO_DATE('2012-09-24 12:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:44','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:16:44 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200041 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 24, 2012 12:16:45 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Process_Para_ID,FieldLength,Help,AD_Process_ID,IsCentrallyMaintained,AD_Reference_ID,SeqNo,IsMandatory,AD_Reference_Value_ID,AD_Element_ID,EntityType,Name,ColumnName,Description,IsActive,AD_Client_ID,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID) VALUES ('N',200042,10,'Identifies an item which is either purchased or sold in this organization.',200010,'Y',30,70,'N',162,454,'D','Product','M_Product_ID','Product, Service, Item','Y',0,100,TO_DATE('2012-09-24 12:16:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:44','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:16:45 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200042 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Sep 24, 2012 12:16:46 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,AD_Process_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200509,200021,'D',0,'N','N','N','N',10,'N',28,'Y','N',200137,200010,'N','Y','N','GenerateGLJournal','Generate GL Journal',100,TO_DATE('2012-09-24 12:16:45','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:45','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:46 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200509 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:46 PM COT
ALTER TABLE GL_JournalGenerator ADD GenerateGLJournal CHAR(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:47 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@$C_AcctSchema_ID@',200510,200021,'D',0,'N','N','N','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar','N',22,'N',19,'Y','N',181,'N','Y','N','C_AcctSchema_ID','Rules for accounting','Accounting Schema',100,TO_DATE('2012-09-24 12:16:46','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:46','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:47 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200510 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:47 PM COT
ALTER TABLE GL_JournalGenerator ADD C_AcctSchema_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:16:48 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('A',200511,200021,'D',0,125,'N','N','N','The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.','N',1,'N',17,'Y','N',514,'N','Y','N','PostingType','The type of posted amount for the transaction','PostingType',100,TO_DATE('2012-09-24 12:16:47','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:47','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:48 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200511 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:48 PM COT
ALTER TABLE GL_JournalGenerator ADD PostingType CHAR(1) DEFAULT 'A'
;

-- Sep 24, 2012 12:16:48 PM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Tab_ID,AD_Table_ID,CommitWarning,HasTree,IsInfoTab,IsReadOnly,TabLevel,IsInsertRecord,IsAdvancedTab,EntityType,Name,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,Created,IsActive,UpdatedBy,Processing) VALUES ('Y',200013,10,'N','N',200020,200021,NULL,'N','Y','N',0,'Y','N','D','GL Journal Generator',0,0,100,TO_DATE('2012-09-24 12:16:48','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:16:48','YYYY-MM-DD HH24:MI:SS'),'Y',100,'N')
;

-- Sep 24, 2012 12:16:48 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Sep 24, 2012 12:16:49 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,22,'Y','N','N',200495,'N',10,'Y',200511,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client',100,0,'Y',TO_DATE('2012-09-24 12:16:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:48','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:49 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200511 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:50 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,22,'Y','Y','N',200496,'N',20,'Y',200512,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization',100,0,'Y',TO_DATE('2012-09-24 12:16:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:49','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:50 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200512 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:50 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,60,'Y','N','N',200502,'N',30,'Y',200513,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name',100,0,'Y',TO_DATE('2012-09-24 12:16:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:50 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200513 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:51 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,255,'Y','N','N',200499,'N',40,'Y',200514,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description',100,0,'Y',TO_DATE('2012-09-24 12:16:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:51 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200514 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:51 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,2000,'Y','N','N',200500,'N',50,'Y',200515,'N','The Help field contains a hint, comment or help about the use of this item.','D','Comment or Hint','Comment/Help',100,0,'Y',TO_DATE('2012-09-24 12:16:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:51 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200515 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:52 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,10,'Y','N','N',200507,'N',60,'Y',200516,'N','The Document Type determines document sequence and processing rules','D','Document type or rules','Document Type',100,0,'Y',TO_DATE('2012-09-24 12:16:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:52 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200516 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:52 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,10,'Y','N','N',200508,'N',70,'Y',200517,'N','The General Ledger Category is an optional, user defined method of grouping journal lines.','D','General Ledger Category','GL Category',100,0,'Y',TO_DATE('2012-09-24 12:16:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:52 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200517 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:53 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,1,'Y','Y','N',200511,'N',80,'Y',200518,'N','The Posting Type indicates the type of amount (Actual, Budget, Reservation, Commitment, Statistical) the transaction.','D','The type of posted amount for the transaction','PostingType',100,0,'Y',TO_DATE('2012-09-24 12:16:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:53 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200518 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:53 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,22,'Y','N','N',200510,'N',90,'Y',200519,'N','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar','D','Rules for accounting','Accounting Schema',100,0,'Y',TO_DATE('2012-09-24 12:16:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:53 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200519 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:54 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,10,'Y','N','N',200505,'N',100,'Y',200520,'N','D','Account Adjust DR',100,0,'Y',TO_DATE('2012-09-24 12:16:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:54 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200520 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:54 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,10,'Y','Y','N',200506,'N',110,'Y',200521,'N','D','Account Adjust CR',100,0,'Y',TO_DATE('2012-09-24 12:16:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:54 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200521 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:55 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,10,'Y','N','N',200509,'N',120,'Y',200522,'N','D','Generate GL Journal',100,0,'Y',TO_DATE('2012-09-24 12:16:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:55 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200522 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:55 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,1,'Y','N','N',200501,'N',130,'Y',200523,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active',100,0,'Y',TO_DATE('2012-09-24 12:16:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:55 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200523 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:56 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200020,22,'N','N','N',200494,'N',0,'Y',200524,'N','D','GL Journal Generator',100,0,'Y',TO_DATE('2012-09-24 12:16:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:16:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:56 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200524 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:16:56 PM COT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Window_ID,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','3',200013,200022,'N','N','N','Y','D','Y','L','GL_JournalGeneratorLine','Generator Line',0,'Y',0,100,TO_DATE('2012-09-24 12:16:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:56','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:16:56 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Sep 24, 2012 12:16:57 PM COT
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,CreatedBy,IsActive) VALUES (1,'N',200000,'Y',1000000,1000000,'N','Y',200022,'Table GL_JournalGeneratorLine','GL_JournalGeneratorLine',0,0,TO_DATE('2012-09-24 12:16:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:16:56','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 24, 2012 12:16:57 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200138,'GL_JournalGeneratorLine_ID','D','Generator Line','Generator Line',0,TO_DATE('2012-09-24 12:16:57','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:16:57','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:16:58 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200138 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:16:58 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200512,200022,'D',1,'Y','N','N','N',22,'N',13,'Y','Y',200138,'N','N','N','GL_JournalGeneratorLine_ID','Generator Line',100,TO_DATE('2012-09-24 12:16:58','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:58 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200512 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:58 PM COT
CREATE TABLE GL_JournalGeneratorLine (GL_JournalGeneratorLine_ID NUMBER(10) NOT NULL, CONSTRAINT GL_JournalGeneratorLine_Key PRIMARY KEY (GL_JournalGeneratorLine_ID))
;

-- Sep 24, 2012 12:16:59 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Client_ID@',200513,200022,'D',1,'Y','N','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'Y','N',102,'N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client',100,TO_DATE('2012-09-24 12:16:58','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:58','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:59 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200513 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:59 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:16:59 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Org_ID@',200514,200022,'D',1,'Y','N','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'Y',104,'N',113,'N','N','N','AD_Org_ID','Organizational entity within client','Organization',100,TO_DATE('2012-09-24 12:16:59','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:16:59 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200514 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:16:59 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:00 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200515,200022,'D',1,'Y','N','N','The Created field indicates the date that this record was created.','N',7,'N',16,'Y','N',245,'N','N','N','Created','Date this record was created','Created',100,TO_DATE('2012-09-24 12:16:59','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:16:59','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:00 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200515 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:00 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD Created DATE NOT NULL
;

-- Sep 24, 2012 12:17:00 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200516,200022,'D',1,110,'Y','N','N','The Created By field indicates the user who created this record.','N',22,'N',18,'Y','N',246,'N','N','N','CreatedBy','User who created this records','Created By',100,TO_DATE('2012-09-24 12:17:00','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:00','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:00 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200516 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:00 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD CreatedBy NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:01 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200517,200022,'D',1,'N','N','N','A description is limited to 255 characters.','N',255,'Y',10,'Y','N',275,'N','Y','N','Description','Optional short description of the record','Description',100,TO_DATE('2012-09-24 12:17:00','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:00','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:01 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200517 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:01 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD Description NVARCHAR2(255) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:02 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200518,200022,'D',1,'N','N','N','The Help field contains a hint, comment or help about the use of this item.','N',2000,'N',14,'Y','N',326,'N','Y','N','Help','Comment or Hint','Comment/Help',100,TO_DATE('2012-09-24 12:17:01','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200518 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:02 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD Help NVARCHAR2(2000) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:03 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200519,200022,'D',1,'Y','N','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'Y','N',348,'N','Y','N','IsActive','The record is active in the system','Active',100,TO_DATE('2012-09-24 12:17:02','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:02','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200519 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:03 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Sep 24, 2012 12:17:03 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200520,200022,'D',1,'Y','N','Y',1,'Y',22,'N',19,'Y','N',200134,'N','N','N','GL_JournalGenerator_ID','GL Journal Generator',100,TO_DATE('2012-09-24 12:17:03','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200520 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:03 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD GL_JournalGenerator_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:04 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200521,200022,'D',1,'Y','N','N','The Updated field indicates the date that this record was updated.','N',7,'N',16,'Y','N',607,'N','N','N','Updated','Date this record was updated','Updated',100,TO_DATE('2012-09-24 12:17:03','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200521 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:04 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD Updated DATE NOT NULL
;

-- Sep 24, 2012 12:17:04 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200522,200022,'D',1,110,'Y','N','N','The Updated By field indicates the user who updated this record.','N',22,'N',18,'Y','N',608,'N','N','N','UpdatedBy','User who updated this records','Updated By',100,TO_DATE('2012-09-24 12:17:04','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:04','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200522 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:04 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:05 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@SQL=SELECT NVL(MAX(SeqNo),0)+10 AS DefaultValue FROM GL_JournalGeneratorLine WHERE GL_JournalGenerator_ID=@GL_JournalGenerator_ID@',200523,200022,'D',1,'Y','N','Y',2,'The Sequence indicates the order of records','N',22,'N',11,'Y','N',566,'N','Y','N','SeqNo','Method of ordering records; lowest number comes first','Sequence',100,TO_DATE('2012-09-24 12:17:04','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:04','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:05 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200523 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:05 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD SeqNo NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:06 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200139,'C_ElementValueDR_ID','D','Account DR','Account DR',0,TO_DATE('2012-09-24 12:17:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:05','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:06 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200139 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:06 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200524,200022,'D',0,362,'N','N','N','N',10,'N',18,'Y',252,'N',200139,'N','Y','N','C_ElementValueDR_ID','Account DR',100,TO_DATE('2012-09-24 12:17:06','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:06','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:06 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200524 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:06 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD C_ElementValueDR_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:07 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200140,'C_ElementValueCR_ID','D','Account CR','Account CR',0,TO_DATE('2012-09-24 12:17:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:06','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:07 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200140 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:07 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200525,200022,'D',0,362,'N','N','N','N',10,'N',18,'Y',252,'N',200140,'N','Y','N','C_ElementValueCR_ID','Account CR',100,TO_DATE('2012-09-24 12:17:07','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:07','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:07 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200525 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:07 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD C_ElementValueCR_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:08 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200141,'BPDimensionType','D','Type of BP Dimension','Type of BP Dimension',0,TO_DATE('2012-09-24 12:17:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:07','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:08 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200141 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:08 PM COT
INSERT INTO AD_Reference (AD_Reference_ID,ValidationType,EntityType,Name,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200008,'L','D','GL_JournalGeneratorLine BPDimensionType',0,0,100,TO_DATE('2012-09-24 12:17:08','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-09-24 12:17:08','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:08 PM COT
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Sep 24, 2012 12:17:09 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Value,Name,CreatedBy,Updated,UpdatedBy,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES (200027,200008,'D','C','Column',100,TO_DATE('2012-09-24 12:17:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:17:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Sep 24, 2012 12:17:09 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 24, 2012 12:17:10 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Value,Name,CreatedBy,Updated,UpdatedBy,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES (200028,200008,'D','F','Fixed',100,TO_DATE('2012-09-24 12:17:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:17:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Sep 24, 2012 12:17:10 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 24, 2012 12:17:10 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Value,Name,CreatedBy,Updated,UpdatedBy,Created,AD_Org_ID,IsActive,AD_Client_ID) VALUES (200029,200008,'D','S','Same',100,TO_DATE('2012-09-24 12:17:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:17:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',0)
;

-- Sep 24, 2012 12:17:10 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200029 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 24, 2012 12:17:11 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200526,200022,'D',0,200008,'N','N','N','N',1,'N',17,'Y','N',200141,'N','Y','N','BPDimensionType','Type of BP Dimension',100,TO_DATE('2012-09-24 12:17:10','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:10','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:11 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200526 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:11 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD BPDimensionType CHAR(1) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:11 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200527,200022,'D',0,138,'N','N','N','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','N',10,'N',30,'Y','N',187,'N','Y','N','C_BPartner_ID','Identifies a Business Partner','Business Partner ',100,TO_DATE('2012-09-24 12:17:11','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:11','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:11 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200527 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:11 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD C_BPartner_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:12 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200142,'BPColumn','D','BP Column','BP Column',0,TO_DATE('2012-09-24 12:17:12','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:12','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:12 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200142 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:13 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200528,200022,'D',0,'N','N','N','N',100,'N',10,'Y','N',200142,'N','Y','N','BPColumn','BP Column',100,TO_DATE('2012-09-24 12:17:12','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:13 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200528 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:13 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD BPColumn NVARCHAR2(100) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:13 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200143,'IsCopyAllDimensions','D','Copy All Dimensions','Copy All Dimensions',0,TO_DATE('2012-09-24 12:17:13','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:13','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:13 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200143 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:14 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('N',200529,200022,'D',0,'Y','N','N','N',1,'N',20,'Y','N',200143,'N','Y','N','IsCopyAllDimensions','Copy All Dimensions',100,TO_DATE('2012-09-24 12:17:13','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:13','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:14 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200529 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:14 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD IsCopyAllDimensions CHAR(1) DEFAULT 'N' CHECK (IsCopyAllDimensions IN ('Y','N')) NOT NULL
;

-- Sep 24, 2012 12:17:15 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200144,'IsSameProduct','D','Same Product','Same Product',0,TO_DATE('2012-09-24 12:17:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:14','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:15 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200144 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:15 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('N',200530,200022,'D',0,'Y','N','N','N',1,'N',20,'Y','N',200144,'N','Y','N','IsSameProduct','Same Product',100,TO_DATE('2012-09-24 12:17:15','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:15','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:15 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200530 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:15 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD IsSameProduct CHAR(1) DEFAULT 'N' CHECK (IsSameProduct IN ('Y','N')) NOT NULL
;

-- Sep 24, 2012 12:17:16 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('1',200531,200022,'D',0,'N','N','N','The Multiplier Amount indicates the amount to multiply the total amount generated by this commission run by.','N',14,'N',22,'Y','N',1545,'N','Y','N','AmtMultiplier','Multiplier Amount for generating commissions','Multiplier Amount',100,TO_DATE('2012-09-24 12:17:15','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:15','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:16 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200531 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:16 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD AmtMultiplier NUMBER DEFAULT 1
;

-- Sep 24, 2012 12:17:16 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200145,'RoundFactor','D','Round Factor','Round Factor',0,TO_DATE('2012-09-24 12:17:16','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:16','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:16 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200145 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:17 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('0',200532,200022,'D',0,'N','N','N','N',22,'N',11,'Y','N',200145,'N','Y','N','RoundFactor','Round Factor',100,TO_DATE('2012-09-24 12:17:16','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:17 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200532 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:17 PM COT
ALTER TABLE GL_JournalGeneratorLine ADD RoundFactor NUMBER(10) DEFAULT 0
;

-- Sep 24, 2012 12:17:18 PM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Tab_ID,AD_Table_ID,CommitWarning,HasTree,IsInfoTab,IsReadOnly,AD_Column_ID,TabLevel,IsInsertRecord,IsAdvancedTab,EntityType,Name,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,Created,IsActive,UpdatedBy,Processing) VALUES ('Y',200013,20,'N','N',200021,200022,NULL,'N','Y','N',200520,1,'Y','N','D','Generator Line',0,0,100,TO_DATE('2012-09-24 12:17:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:17','YYYY-MM-DD HH24:MI:SS'),'Y',100,'N')
;

-- Sep 24, 2012 12:17:18 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Sep 24, 2012 12:17:18 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,22,'Y','N','N',200513,'N',10,'Y',200525,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client',100,0,'Y',TO_DATE('2012-09-24 12:17:18','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:18','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:18 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200525 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:19 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,22,'Y','Y','N',200514,'N',20,'Y',200526,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization',100,0,'Y',TO_DATE('2012-09-24 12:17:18','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:18','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:19 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200526 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:19 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,22,'Y','N','N',200520,'N',30,'Y',200527,'N','D','GL Journal Generator',100,0,'Y',TO_DATE('2012-09-24 12:17:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:19','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:19 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200527 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:20 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,22,'Y','N','N',200523,'N',40,'Y',200528,'N','The Sequence indicates the order of records','D','Method of ordering records; lowest number comes first','Sequence',100,0,'Y',TO_DATE('2012-09-24 12:17:19','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:19','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:20 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200528 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:20 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,255,'Y','N','N',200517,'N',50,'Y',200529,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description',100,0,'Y',TO_DATE('2012-09-24 12:17:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:20 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200529 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:21 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,2000,'Y','N','N',200518,'N',60,'Y',200530,'N','The Help field contains a hint, comment or help about the use of this item.','D','Comment or Hint','Comment/Help',100,0,'Y',TO_DATE('2012-09-24 12:17:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:21 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200530 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:21 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,10,'Y','N','N',200524,'N',70,'Y',200531,'N','D','Account DR',100,0,'Y',TO_DATE('2012-09-24 12:17:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:21 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200531 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:22 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,10,'Y','Y','N',200525,'N',80,'Y',200532,'N','D','Account CR',100,0,'Y',TO_DATE('2012-09-24 12:17:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:22 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200532 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:22 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,1,'Y','N','N',200526,'N',90,'Y',200533,'N','D','Type of BP Dimension',100,0,'Y',TO_DATE('2012-09-24 12:17:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:22 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200533 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:23 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,10,'Y','Y','N',200527,'N',100,'Y',200534,'N','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','@BPDimensionType@=F','D','Identifies a Business Partner','Business Partner ',100,0,'Y',TO_DATE('2012-09-24 12:17:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:23 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200534 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:23 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,DisplayLogic,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,100,'Y','Y','N',200528,'N',110,'Y',200535,'N','@BPDimensionType@=C','D','BP Column',100,0,'Y',TO_DATE('2012-09-24 12:17:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:23 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200535 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:24 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,1,'Y','N','N',200530,'N',120,'Y',200536,'N','D','Same Product',100,0,'Y',TO_DATE('2012-09-24 12:17:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:24 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200536 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:24 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,1,'Y','N','N',200529,'N',130,'Y',200537,'N','D','Copy All Dimensions',100,0,'Y',TO_DATE('2012-09-24 12:17:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:24','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:24 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200537 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:25 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,14,'Y','N','N',200531,'N',140,'Y',200538,'N','The Multiplier Amount indicates the amount to multiply the total amount generated by this commission run by.','D','Multiplier Amount for generating commissions','Multiplier Amount',100,0,'Y',TO_DATE('2012-09-24 12:17:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:24','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:25 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200538 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:25 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,22,'Y','Y','N',200532,'N',150,'Y',200539,'N','D','Round Factor',100,0,'Y',TO_DATE('2012-09-24 12:17:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:25 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200539 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:26 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,1,'Y','N','N',200519,'N',160,'Y',200540,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active',100,0,'Y',TO_DATE('2012-09-24 12:17:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:26 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200540 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:26 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200021,22,'N','N','N',200512,'N',0,'Y',200541,'N','D','Generator Line',100,0,'Y',TO_DATE('2012-09-24 12:17:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:26','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:26 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200541 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:27 PM COT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,AD_Window_ID,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','3',200013,200023,'N','N','N','Y','D','Y','L','GL_JournalGeneratorSource','Generator Source',0,'Y',0,100,TO_DATE('2012-09-24 12:17:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:17:27','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:27 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Sep 24, 2012 12:17:28 PM COT
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,CreatedBy,IsActive) VALUES (1,'N',200000,'Y',1000000,1000000,'N','Y',200023,'Table GL_JournalGeneratorSource','GL_JournalGeneratorSource',0,0,TO_DATE('2012-09-24 12:17:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-24 12:17:27','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 24, 2012 12:17:28 PM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200146,'GL_JournalGeneratorSource_ID','D','Generator Source','Generator Source',0,TO_DATE('2012-09-24 12:17:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:28','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Sep 24, 2012 12:17:28 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,PO_Name,Name,Description,PrintName,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.PO_Name,t.Name,t.Description,t.PrintName,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200146 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 12:17:29 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200533,200023,'D',1,'Y','N','N','N',22,'N',13,'Y','Y',200146,'N','N','N','GL_JournalGeneratorSource_ID','Generator Source',100,TO_DATE('2012-09-24 12:17:28','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:28','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:29 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200533 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:29 PM COT
CREATE TABLE GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID NUMBER(10) NOT NULL, CONSTRAINT GL_JournalGeneratorSource_Key PRIMARY KEY (GL_JournalGeneratorSource_ID))
;

-- Sep 24, 2012 12:17:30 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Client_ID@',200534,200023,'D',1,'Y','N','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'Y','N',102,'N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client',100,TO_DATE('2012-09-24 12:17:29','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:29','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:30 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200534 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:30 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:30 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Org_ID@',200535,200023,'D',1,'Y','N','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'Y',104,'N',113,'N','N','N','AD_Org_ID','Organizational entity within client','Organization',100,TO_DATE('2012-09-24 12:17:30','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:30 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200535 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:30 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:31 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200536,200023,'D',1,'Y','N','N','The Created field indicates the date that this record was created.','N',7,'N',16,'Y','N',245,'N','N','N','Created','Date this record was created','Created',100,TO_DATE('2012-09-24 12:17:30','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:30','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:31 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200536 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:31 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD Created DATE NOT NULL
;

-- Sep 24, 2012 12:17:31 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200537,200023,'D',1,110,'Y','N','N','The Created By field indicates the user who created this record.','N',22,'N',18,'Y','N',246,'N','N','N','CreatedBy','User who created this records','Created By',100,TO_DATE('2012-09-24 12:17:31','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:31 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200537 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:31 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD CreatedBy NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:32 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200538,200023,'D',1,'N','N','N','The Help field contains a hint, comment or help about the use of this item.','N',2000,'N',14,'Y','N',326,'N','Y','N','Help','Comment or Hint','Comment/Help',100,TO_DATE('2012-09-24 12:17:31','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:31','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:32 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200538 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:32 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD Help NVARCHAR2(2000) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:32 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200539,200023,'D',1,'Y','N','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'Y','N',348,'N','Y','N','IsActive','The record is active in the system','Active',100,TO_DATE('2012-09-24 12:17:32','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:32','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:32 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200539 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:33 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Sep 24, 2012 12:17:33 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200540,200023,'D',1,'Y','N','N','The Updated field indicates the date that this record was updated.','N',7,'N',16,'Y','N',607,'N','N','N','Updated','Date this record was updated','Updated',100,TO_DATE('2012-09-24 12:17:33','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:33 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200540 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:33 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD Updated DATE NOT NULL
;

-- Sep 24, 2012 12:17:34 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200541,200023,'D',1,110,'Y','N','N','The Updated By field indicates the user who updated this record.','N',22,'N',18,'Y','N',608,'N','N','N','UpdatedBy','User who updated this records','Updated By',100,TO_DATE('2012-09-24 12:17:33','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:33','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:34 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200541 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:34 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:34 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200542,200023,'D',0,'Y','N','N','Y',10,'N',19,'Y','N',200138,'N','N','N','GL_JournalGeneratorLine_ID','Generator Line',100,TO_DATE('2012-09-24 12:17:34','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:34 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200542 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:34 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD GL_JournalGeneratorLine_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:35 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200543,200023,'D',0,182,'Y','N','N','Account Elements can be natural accounts or user defined values.','N',10,'N',18,'Y',252,'N',198,'N','Y','N','C_ElementValue_ID','Account Element','Account Element',100,TO_DATE('2012-09-24 12:17:34','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:34','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:35 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200543 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:35 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD C_ElementValue_ID NUMBER(10) NOT NULL
;

-- Sep 24, 2012 12:17:35 PM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('1',200544,200023,'D',0,'Y','N','N','The Multiplier Amount indicates the amount to multiply the total amount generated by this commission run by.','N',1,'N',22,'Y','N',1545,'N','Y','N','AmtMultiplier','Multiplier Amount for generating commissions','Multiplier Amount',100,TO_DATE('2012-09-24 12:17:35','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:35','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:35 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200544 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:36 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD AmtMultiplier NUMBER DEFAULT 1 NOT NULL
;

-- Sep 24, 2012 12:17:36 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200545,200023,'D',0,'N','N','N','N',14,'N',11,'Y','N',200145,'N','Y','N','RoundFactor','Round Factor',100,TO_DATE('2012-09-24 12:17:36','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:36 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200545 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:36 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD RoundFactor NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:37 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200546,200023,'D',0,'N','N','N','The General Ledger Category is an optional, user defined method of grouping journal lines.','N',10,'N',19,'Y','N',309,'N','Y','N','GL_Category_ID','General Ledger Category','GL Category',100,TO_DATE('2012-09-24 12:17:36','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-09-24 12:17:36','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 24, 2012 12:17:37 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200546 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 12:17:37 PM COT
ALTER TABLE GL_JournalGeneratorSource ADD GL_Category_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 24, 2012 12:17:38 PM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Tab_ID,AD_Table_ID,CommitWarning,HasTree,IsInfoTab,IsReadOnly,AD_Column_ID,TabLevel,IsInsertRecord,IsAdvancedTab,EntityType,Name,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,Created,IsActive,UpdatedBy,Processing) VALUES ('N',200013,30,'N','N',200022,200023,NULL,'N','Y','N',200542,2,'Y','N','D','Generator Source',0,0,100,TO_DATE('2012-09-24 12:17:37','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 12:17:37','YYYY-MM-DD HH24:MI:SS'),'Y',100,'N')
;

-- Sep 24, 2012 12:17:38 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Sep 24, 2012 12:17:38 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,22,'Y','N','N',200534,'N',10,'Y',200542,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client',100,0,'Y',TO_DATE('2012-09-24 12:17:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:38','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:38 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200542 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:39 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,22,'Y','Y','N',200535,'N',20,'Y',200543,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization',100,0,'Y',TO_DATE('2012-09-24 12:17:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:38','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:39 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200543 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:39 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,10,'Y','N','N',200542,'N',30,'Y',200544,'N','D','Generator Line',100,0,'Y',TO_DATE('2012-09-24 12:17:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:39 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200544 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:40 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,10,'Y','N','N',200543,'N',40,'Y',200545,'N','Account Elements can be natural accounts or user defined values.','D','Account Element','Account Element',100,0,'Y',TO_DATE('2012-09-24 12:17:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:39','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:40 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200545 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:40 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,10,'Y','Y','N',200546,'N',50,'Y',200546,'N','The General Ledger Category is an optional, user defined method of grouping journal lines.','D','General Ledger Category','GL Category',100,0,'Y',TO_DATE('2012-09-24 12:17:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:40 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200546 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:41 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,1,'Y','N','N',200544,'N',60,'Y',200547,'N','The Multiplier Amount indicates the amount to multiply the total amount generated by this commission run by.','D','Multiplier Amount for generating commissions','Multiplier Amount',100,0,'Y',TO_DATE('2012-09-24 12:17:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:41 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200547 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:41 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,14,'Y','Y','N',200545,'N',70,'Y',200548,'N','D','Round Factor',100,0,'Y',TO_DATE('2012-09-24 12:17:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:41 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200548 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:42 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,2000,'Y','N','N',200538,'N',80,'Y',200549,'N','The Help field contains a hint, comment or help about the use of this item.','D','Comment or Hint','Comment/Help',100,0,'Y',TO_DATE('2012-09-24 12:17:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:42 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200549 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:43 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,1,'Y','N','N',200539,'N',90,'Y',200550,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active',100,0,'Y',TO_DATE('2012-09-24 12:17:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:43 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200550 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:44 PM COT
INSERT INTO AD_Field (SortNo,AD_Tab_ID,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES (0,200022,22,'N','N','N',200533,'N',0,'Y',200551,'N','D','Generator Source',100,0,'Y',TO_DATE('2012-09-24 12:17:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-24 12:17:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 24, 2012 12:17:44 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200551 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 24, 2012 12:17:44 PM COT
update AD_Field set isallowcopy='N' where AD_Field_ID=(select ad_field_id from ad_field where name ='Sequence' and ad_tab_id=(select ad_tab_id from ad_tab where name='Generator Line' and entitytype='D'))
;

-- Sep 24, 2012 12:17:44 PM COT
update ad_column set mandatorylogic='@BPDimensionType@=C' where columnname='BPColumn' and ad_table_id=(select ad_table_id from ad_table where tablename='GL_JournalGeneratorLine')
;

-- Sep 24, 2012 12:17:44 PM COT
update ad_column set mandatorylogic='@BPDimensionType@=F' where columnname='C_BPartner_ID' and ad_table_id=(select ad_table_id from ad_table where tablename='GL_JournalGeneratorLine')
;

-- Sep 24, 2012 12:17:44 PM COT
ALTER TABLE GL_JournalGenerator ADD (CONSTRAINT CAcctSchema_QSSJournalGenerato FOREIGN KEY (C_AcctSchema_ID) REFERENCES C_AcctSchema);

ALTER TABLE GL_JournalGenerator ADD (CONSTRAINT CDocType_QSSJournalGenerator FOREIGN KEY (C_DocType_ID) REFERENCES C_DocType);

ALTER TABLE GL_JournalGenerator ADD (CONSTRAINT CElementValueAdjustCR_QSSJourn FOREIGN KEY (C_ElementValueAdjustCR_ID) REFERENCES C_ElementValue);

ALTER TABLE GL_JournalGenerator ADD (CONSTRAINT CElementValueAdjustDR_QSSJourn FOREIGN KEY (C_ElementValueAdjustDR_ID) REFERENCES C_ElementValue);

ALTER TABLE GL_JournalGenerator ADD (CONSTRAINT GLCategory_QSSJournalGenerator FOREIGN KEY (GL_Category_ID) REFERENCES GL_Category);

ALTER TABLE GL_JournalGeneratorLine ADD (CONSTRAINT CBPartner_QSSJournalGeneratorL FOREIGN KEY (C_BPartner_ID) REFERENCES C_BPartner);

ALTER TABLE GL_JournalGeneratorLine ADD (CONSTRAINT CElementValueCR_QSSJournalGene FOREIGN KEY (C_ElementValueCR_ID) REFERENCES C_ElementValue);

ALTER TABLE GL_JournalGeneratorLine ADD (CONSTRAINT CElementValueDR_QSSJournalGene FOREIGN KEY (C_ElementValueDR_ID) REFERENCES C_ElementValue);

ALTER TABLE GL_JournalGeneratorLine ADD (CONSTRAINT QSSJournalGenerator_QSSJournal FOREIGN KEY (GL_JournalGenerator_ID) REFERENCES GL_JournalGenerator);

ALTER TABLE GL_JournalGeneratorSource ADD (CONSTRAINT CElementValue_QSSJournalGenera FOREIGN KEY (C_ElementValue_ID) REFERENCES C_ElementValue);

ALTER TABLE GL_JournalGeneratorSource ADD (CONSTRAINT QSSJournalGeneratorLine_QSSJou FOREIGN KEY (GL_JournalGeneratorLine_ID) REFERENCES GL_JournalGeneratorLine);

-- Sep 24, 2012 12:17:45 PM COT
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,Action,IsSOTrx,IsReadOnly,EntityType,Name,Created,IsActive,UpdatedBy,AD_Client_ID,CreatedBy,Updated,AD_Org_ID) VALUES (200013,200019,'N','W','N','N','D','GL Journal Generator',TO_DATE('2012-09-24 12:17:44','YYYY-MM-DD HH24:MI:SS'),'Y',100,0,100,TO_DATE('2012-09-24 12:17:44','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Sep 24, 2012 12:17:45 PM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200019 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Sep 24, 2012 12:17:45 PM COT
INSERT INTO AD_TREENODEMM(AD_Client_ID, AD_Org_ID, CreatedBy, UpdatedBy, Parent_ID, SeqNo, AD_Tree_ID, Node_ID)VALUES(0, 0, 0, 0, 278,13, 10, 200019)
;

-- Sep 24, 2012 1:52:05 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('GL_JournalGenerator_UU',200154,'U','GL_JournalGenerator_UU','GL_JournalGenerator_UU','ce1c9845-c843-4171-a29e-58ba1a00b7a5',0,TO_DATE('2012-09-24 13:52:05','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 13:52:05','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 24, 2012 1:52:05 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200154 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 1:52:05 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200021,200554,'U','N','N','N','N',36,'N',10,'N',200154,'036bbd32-d2b8-4977-aa89-63d03b982c9d','N','Y','N','GL_JournalGenerator_UU','GL_JournalGenerator_UU',100,TO_DATE('2012-09-24 13:52:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-24 13:52:05','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 24, 2012 1:52:05 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200554 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 1:52:05 PM COT
-- IDEMPIERE-207 GL Journal Generator
ALTER TABLE GL_JournalGenerator ADD GL_JournalGenerator_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Sep 24, 2012 1:52:06 PM COT
-- IDEMPIERE-207 GL Journal Generator
CREATE UNIQUE INDEX GL_JournalGenerator_UU_idx ON gl_journalgenerator(GL_JournalGenerator_UU)
;

-- Sep 24, 2012 1:52:06 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('GL_JournalGeneratorLine_UU',200155,'U','GL_JournalGeneratorLine_UU','GL_JournalGeneratorLine_UU','01031500-7362-453d-b5c2-59e493651afd',0,TO_DATE('2012-09-24 13:52:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 13:52:06','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 24, 2012 1:52:06 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200155 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 1:52:07 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200022,200555,'U','N','N','N','N',36,'N',10,'N',200155,'3084f1fd-f809-4379-aaeb-b7539cb982bd','N','Y','N','GL_JournalGeneratorLine_UU','GL_JournalGeneratorLine_UU',100,TO_DATE('2012-09-24 13:52:06','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-24 13:52:06','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 24, 2012 1:52:07 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200555 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 1:52:07 PM COT
-- IDEMPIERE-207 GL Journal Generator
ALTER TABLE GL_JournalGeneratorLine ADD GL_JournalGeneratorLine_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Sep 24, 2012 1:52:07 PM COT
-- IDEMPIERE-207 GL Journal Generator
CREATE UNIQUE INDEX GL_JournalGeneratorLine_UU_idx ON gl_journalgeneratorline(GL_JournalGeneratorLine_UU)
;

-- Sep 24, 2012 1:52:07 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('GL_JournalGeneratorSource_UU',200156,'U','GL_JournalGeneratorSource_UU','GL_JournalGeneratorSource_UU','c14d313c-2e81-461d-8b8f-9a33913bbaeb',0,TO_DATE('2012-09-24 13:52:07','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-24 13:52:07','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 24, 2012 1:52:07 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200156 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 24, 2012 1:52:08 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200023,200556,'U','N','N','N','N',36,'N',10,'N',200156,'2f6ca282-6903-4207-907a-6cff865d8867','N','Y','N','GL_JournalGeneratorSource_UU','GL_JournalGeneratorSource_UU',100,TO_DATE('2012-09-24 13:52:07','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-24 13:52:07','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 24, 2012 1:52:08 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200556 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 24, 2012 1:52:08 PM COT
-- IDEMPIERE-207 GL Journal Generator
ALTER TABLE GL_JournalGeneratorSource ADD GL_JournalGeneratorSource_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Sep 24, 2012 1:52:08 PM COT
-- IDEMPIERE-207 GL Journal Generator
CREATE UNIQUE INDEX GL_JournalGeneratorSource_U_uu_idx ON gl_journalgeneratorsource(GL_JournalGeneratorSource_UU)
;

-- Sep 24, 2012 2:13:33 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGenerator (GL_JournalGenerator_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,Help,IsActive,Name,Updated,UpdatedBy,C_ElementValueAdjustDR_ID,C_ElementValueAdjustCR_ID,C_DocType_ID,GL_Category_ID,GenerateGLJournal,C_AcctSchema_ID,PostingType,GL_JournalGenerator_UU) VALUES (200000,11,0,TO_DATE('2012-09-24 14:13:32','YYYY-MM-DD HH24:MI:SS'),100,'Step 1 - close Revenue/Expense to Income Summary','Processing date start on 1900 - execute on adjustment period','Y','Year-End Closing Sample - step 1',TO_DATE('2012-09-24 14:13:32','YYYY-MM-DD HH24:MI:SS'),100,771,771,115,108,'N',101,'A','d7614300-365f-4cca-b7c3-0085310c35d2')
;

-- Sep 24, 2012 2:16:26 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorLine (IsCopyAllDimensions,IsSameProduct,GL_JournalGeneratorLine_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,GL_JournalGenerator_ID,Updated,UpdatedBy,SeqNo,AmtMultiplier,RoundFactor,GL_JournalGeneratorLine_UU) VALUES ('Y','N',200000,11,0,TO_DATE('2012-09-24 14:16:25','YYYY-MM-DD HH24:MI:SS'),100,'Close 4 Sales','Y',200000,TO_DATE('2012-09-24 14:16:25','YYYY-MM-DD HH24:MI:SS'),100,10,-1.000000000000,2,'d6c7e2eb-3c82-4a1f-9439-7ee7b0c61020')
;

-- Sep 24, 2012 2:16:59 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200000,11,0,TO_DATE('2012-09-24 14:16:58','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 14:16:58','YYYY-MM-DD HH24:MI:SS'),100,200000,632,1,2,'970de838-635a-4c09-b4ed-7b3ae59ed8a6')
;

-- Sep 24, 2012 2:17:23 PM COT
-- IDEMPIERE-207 GL Journal Generator
UPDATE GL_JournalGeneratorLine SET Description='Close Sales and Other Income',Updated=TO_DATE('2012-09-24 14:17:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE GL_JournalGeneratorLine_ID=200000
;

-- Sep 24, 2012 2:17:35 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200001,11,0,TO_DATE('2012-09-24 14:17:35','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 14:17:35','YYYY-MM-DD HH24:MI:SS'),100,200000,704,1,2,'57af9f43-577a-4ed0-9519-b6fd5bced6e0')
;

-- Sep 24, 2012 2:25:28 PM COT
-- IDEMPIERE-207 GL Journal Generator
UPDATE GL_JournalGeneratorLine SET Description='Close (4) Sales and (80) Other Income',Updated=TO_DATE('2012-09-24 14:25:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE GL_JournalGeneratorLine_ID=200000
;

-- Sep 24, 2012 2:26:24 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorLine (IsCopyAllDimensions,IsSameProduct,GL_JournalGeneratorLine_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,GL_JournalGenerator_ID,Updated,UpdatedBy,SeqNo,AmtMultiplier,RoundFactor,GL_JournalGeneratorLine_UU) VALUES ('Y','N',200001,11,0,TO_DATE('2012-09-24 14:26:24','YYYY-MM-DD HH24:MI:SS'),100,'Close (5) Cost of Goods Sold','Y',200000,TO_DATE('2012-09-24 14:26:24','YYYY-MM-DD HH24:MI:SS'),100,20,-1.000000000000,2,'4c1a5d2a-e48f-4315-ac80-14544e25b568')
;

-- Sep 24, 2012 2:29:17 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200002,11,0,TO_DATE('2012-09-24 14:29:17','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 14:29:17','YYYY-MM-DD HH24:MI:SS'),100,200001,429,1,2,'f4f9fdfc-14dc-4fb6-9af7-e856a584afab')
;

-- Sep 24, 2012 2:29:42 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorLine (IsCopyAllDimensions,IsSameProduct,GL_JournalGeneratorLine_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,GL_JournalGenerator_ID,Updated,UpdatedBy,SeqNo,AmtMultiplier,RoundFactor,GL_JournalGeneratorLine_UU) VALUES ('Y','N',200002,11,0,TO_DATE('2012-09-24 14:29:42','YYYY-MM-DD HH24:MI:SS'),100,'Close (6) Expenses','Y',200000,TO_DATE('2012-09-24 14:29:42','YYYY-MM-DD HH24:MI:SS'),100,30,-1.000000000000,2,'6a1fa3f1-78e7-4174-86b2-9aabf59322bc')
;

-- Sep 24, 2012 2:30:46 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200003,11,0,TO_DATE('2012-09-24 14:30:45','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 14:30:45','YYYY-MM-DD HH24:MI:SS'),100,200002,449,1,2,'ea2bbf84-169a-4b34-892f-ef5ad109c823')
;

-- Sep 24, 2012 2:31:12 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorLine (IsCopyAllDimensions,IsSameProduct,GL_JournalGeneratorLine_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,GL_JournalGenerator_ID,Updated,UpdatedBy,SeqNo,AmtMultiplier,RoundFactor,GL_JournalGeneratorLine_UU) VALUES ('Y','N',200003,11,0,TO_DATE('2012-09-24 14:31:12','YYYY-MM-DD HH24:MI:SS'),100,'Close (7) Expenses','Y',200000,TO_DATE('2012-09-24 14:31:12','YYYY-MM-DD HH24:MI:SS'),100,40,-1.000000000000,2,'54db5016-489f-4756-a106-f93a9ad0be8a')
;

-- Sep 24, 2012 2:32:03 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200004,11,0,TO_DATE('2012-09-24 14:32:02','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 14:32:02','YYYY-MM-DD HH24:MI:SS'),100,200003,783,1,2,'a78c163f-05c6-47ae-8ea2-f63b9d11ef7a')
;

-- Sep 24, 2012 2:32:17 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorLine (IsCopyAllDimensions,IsSameProduct,GL_JournalGeneratorLine_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,GL_JournalGenerator_ID,Updated,UpdatedBy,SeqNo,AmtMultiplier,RoundFactor,GL_JournalGeneratorLine_UU) VALUES ('Y','N',200004,11,0,TO_DATE('2012-09-24 14:32:17','YYYY-MM-DD HH24:MI:SS'),100,'Close (82) Other Expense and (83) Expense (Absorbed)','Y',200000,TO_DATE('2012-09-24 14:32:17','YYYY-MM-DD HH24:MI:SS'),100,50,-1.000000000000,2,'8c9e465f-49dd-4145-a2a2-12ac48973418')
;

-- Sep 24, 2012 2:33:17 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200005,11,0,TO_DATE('2012-09-24 14:33:15','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 14:33:15','YYYY-MM-DD HH24:MI:SS'),100,200004,716,1,2,'0d0629f8-87ec-4909-8b1e-a480fc90118d')
;

-- Sep 24, 2012 2:33:27 PM COT
-- IDEMPIERE-207 GL Journal Generator
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200006,11,0,TO_DATE('2012-09-24 14:33:27','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 14:33:27','YYYY-MM-DD HH24:MI:SS'),100,200004,50008,1,2,'79807f6d-c9f2-49db-b573-2dd0a087a1ee')
;

-- Sep 24, 2012 2:38:28 PM COT
-- IDEMPIERE-207 GL Journal Generator
UPDATE AD_Tab SET OrderByClause='SeqNo',Updated=TO_DATE('2012-09-24 14:38:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200021
;

-- Sep 24, 2012 2:52:41 PM COT
INSERT INTO GL_JournalGenerator (GL_JournalGenerator_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,Help,IsActive,Name,Updated,UpdatedBy,C_ElementValueAdjustDR_ID,C_ElementValueAdjustCR_ID,C_DocType_ID,GL_Category_ID,GenerateGLJournal,C_AcctSchema_ID,PostingType,GL_JournalGenerator_UU) VALUES (200001,11,0,TO_DATE('2012-09-24 14:52:41','YYYY-MM-DD HH24:MI:SS'),100,'Step 1 - close Income Summary to Retained Earnings','Executed on year-end - must be executed after -> Year-End Closing Sample - step 1','Y','Year-End Closing Sample - step 2',TO_DATE('2012-09-24 14:52:41','YYYY-MM-DD HH24:MI:SS'),100,631,631,115,108,'N         ',101,'A','c81431ee-d7a3-4123-9ebb-12b41a1364f4')
;

-- Sep 24, 2012 3:00:46 PM COT
INSERT INTO GL_JournalGeneratorLine (IsCopyAllDimensions,IsSameProduct,GL_JournalGeneratorLine_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Description,IsActive,GL_JournalGenerator_ID,Updated,UpdatedBy,SeqNo,C_ElementValueCR_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorLine_UU) VALUES ('N','N',200005,11,0,TO_DATE('2012-09-24 15:00:46','YYYY-MM-DD HH24:MI:SS'),100,'Move Income Summary to Retained Earnings','Y',200001,TO_DATE('2012-09-24 15:00:46','YYYY-MM-DD HH24:MI:SS'),100,10,771,1,2,'56b30bc0-aee2-4649-b527-80daeec4b8fb')
;

-- Sep 24, 2012 3:04:50 PM COT
INSERT INTO GL_JournalGeneratorSource (GL_JournalGeneratorSource_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,GL_JournalGeneratorLine_ID,C_ElementValue_ID,AmtMultiplier,RoundFactor,GL_JournalGeneratorSource_UU) VALUES (200008,11,0,TO_DATE('2012-09-24 15:04:49','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_DATE('2012-09-24 15:04:49','YYYY-MM-DD HH24:MI:SS'),100,200005,771,1,2,'edb1ff7a-496c-460e-b798-dae6fd26c22c')
;

-- Sep 24, 2012 3:39:41 PM COT
UPDATE AD_Column SET AD_Reference_Value_ID=362,Updated=TO_DATE('2012-09-24 15:39:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200217
;

UPDATE AD_Field SET XPosition=3 WHERE AD_Tab_ID IN (200020,200021,200022) AND IsSameLine='Y' AND IsActive='Y';

UPDATE AD_Field SET XPosition=1 WHERE AD_Tab_ID IN (200020,200021,200022) AND IsSameline='N' AND IsActive='Y';

UPDATE AD_Field SET ColumnSpan=1 WHERE AD_Tab_ID IN (200020,200021,200022) AND DisplayLength<30 AND IsActive='Y';

UPDATE AD_Field SET ColumnSpan=3 WHERE AD_Tab_ID IN (200020,200021,200022) AND DisplayLength>=30 AND IsActive='Y';

UPDATE AD_Field SET NumLines=3 WHERE AD_Tab_ID IN (200020,200021,200022) AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=14) AND IsActive='Y';

UPDATE AD_Field SET NumLines=5 WHERE AD_Tab_ID IN (200020,200021,200022) AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=36) AND IsActive='Y';

UPDATE AD_Field SET NumLines=8 WHERE AD_Tab_ID IN (200020,200021,200022) AND AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Reference_ID=34) AND IsActive='Y';

UPDATE AD_Field SET ColumnSpan=2 WHERE AD_Tab_ID IN (200020,200021,200022) AND AD_Field_ID IN (SELECT AD_Field_ID FROM AD_Field WHERE XPosition=1 AND ColumnSpan=1 AND IsActive='Y');

UPDATE AD_Field SET XPosition=4,ColumnSpan=2 WHERE AD_Tab_ID IN (200020,200021,200022) AND AD_Field_ID IN (SELECT AD_Field_ID FROM AD_Field WHERE XPosition=3 AND ColumnSpan=1 AND IsActive='Y');

UPDATE AD_Field SET XPosition=XPosition+1 WHERE AD_Tab_ID IN (200020,200021,200022) AND AD_Field_ID IN (SELECT fi.AD_Field_ID FROM AD_Field fi INNER JOIN AD_Column c ON (fi.AD_Column_ID=C.AD_Column_ID) WHERE c.AD_Reference_ID in (20,28) AND fi.IsActive='Y');

UPDATE AD_Field SET ColumnSpan=5 WHERE AD_Tab_ID IN (200020,200021,200022) AND AD_Field_ID IN (SELECT AD_Field_ID FROM AD_Field WHERE XPosition=1 AND ColumnSpan=3 AND IsActive='Y');

SELECT register_migration_script('918_IDEMPIERE-207.sql') FROM dual
;

