-- Mar 28, 2012 10:13:03 AM COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,CopyColumnsFromTable,EntityType,IsCentrallyMaintained,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','4',0,200003,'N','N','N','Y','N','D','Y','Y','L','AD_ToolBarButtons','ToolBar Buttons',0,'Y',0,100,TO_DATE('2012-03-28 10:13:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-28 10:13:02','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:13:04 AM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200003 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 28, 2012 10:13:18 AM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Client_ID@',200083,200003,'D',1,'Y','N','N',0,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'Y','N',102,'N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client',100,TO_DATE('2012-03-28 10:13:18','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:18 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200083 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:19 AM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Org_ID@',200084,200003,'D',1,'Y','N','N',0,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'Y',104,'N',113,'N','N','N','AD_Org_ID','Organizational entity within client','Organization',100,TO_DATE('2012-03-28 10:13:18','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:19 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200084 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:19 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200085,200003,'D',1,'Y','N','N',0,'The Created field indicates the date that this record was created.','N',7,'N',16,'Y','N',245,'N','N','N','Created','Date this record was created','Created',100,TO_DATE('2012-03-28 10:13:19','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:19','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:19 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200085 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:20 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200086,200003,'D',1,110,'Y','N','N',0,'The Created By field indicates the user who created this record.','N',22,'N',18,'Y','N',246,'N','N','N','CreatedBy','User who created this records','Created By',100,TO_DATE('2012-03-28 10:13:19','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:19','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:20 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200086 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:20 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200087,200003,'D',1,'N','N','N',0,'A description is limited to 255 characters.','N',255,'Y',10,'Y','N',275,'N','Y','N','Description','Optional short description of the record','Description',100,TO_DATE('2012-03-28 10:13:20','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:20 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200087 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:21 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200088,200003,'D',1,'N','N','N',0,'The Help field contains a hint, comment or help about the use of this item.','N',2000,'N',14,'Y','N',326,'N','Y','N','Help','Comment or Hint','Comment/Help',100,TO_DATE('2012-03-28 10:13:20','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:20','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:21 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200088 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:21 AM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200089,200003,'D',1,'Y','N','N',0,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'Y','N',348,'N','Y','N','IsActive','The record is active in the system','Active',100,TO_DATE('2012-03-28 10:13:21','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:21 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200089 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:22 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200016,'AD_ToolBarButtons_ID','D','ToolBar Buttons','ToolBar Buttons',0,TO_DATE('2012-03-28 10:13:21','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-28 10:13:21','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 28, 2012 10:13:22 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200016 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 28, 2012 10:13:22 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200090,200003,'D',1,'Y','N','N',0,'N',22,'N',13,'Y','Y',200016,'N','N','N','AD_ToolBarButtons_ID','ToolBar Buttons',100,TO_DATE('2012-03-28 10:13:21','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:21','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:22 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200090 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:23 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200091,200003,'D',1,'Y','N','Y',1,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','N',60,'Y',10,'Y','N',469,'N','Y','N','Name','Alphanumeric identifier of the entity','Name',100,TO_DATE('2012-03-28 10:13:22','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:22','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:23 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200091 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:23 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200092,200003,'D',1,'Y','N','N',0,'The Updated field indicates the date that this record was updated.','N',7,'N',16,'Y','N',607,'N','N','N','Updated','Date this record was updated','Updated',100,TO_DATE('2012-03-28 10:13:23','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:23 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200092 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:24 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200093,200003,'D',1,110,'Y','N','N',0,'The Updated By field indicates the user who updated this record.','N',22,'N',18,'Y','N',608,'N','N','N','UpdatedBy','User who updated this records','Updated By',100,TO_DATE('2012-03-28 10:13:23','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:23','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:24 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200093 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:24 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200094,200003,'D',1,'Y','N','N',0,'A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','N',40,'Y',10,'Y','N',620,'N','Y','N','Value','Search key for the record in the format required - must be unique','Search Key',100,TO_DATE('2012-03-28 10:13:24','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:13:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:13:24 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200094 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:13:39 AM COT
UPDATE AD_Table SET TableName='AD_ToolBarButton', Name='ToolBar Button',Updated=TO_DATE('2012-03-28 10:13:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200003
;

-- Mar 28, 2012 10:13:39 AM COT
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200003
;

-- Mar 28, 2012 10:13:39 AM COT
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,CreatedBy,IsActive) VALUES (1,'N',50000,'Y',1000000,1000000,'N','Y',200003,'Table AD_ToolBarButton','AD_ToolBarButton',0,0,TO_DATE('2012-03-28 10:13:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-28 10:13:39','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Mar 28, 2012 10:13:53 AM COT
UPDATE AD_Element SET ColumnName='AD_ToolBarButton_ID', Name='ToolBar Button', PrintName='ToolBar Button',Updated=TO_DATE('2012-03-28 10:13:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200016
;

-- Mar 28, 2012 10:13:53 AM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200016
;

-- Mar 28, 2012 10:13:53 AM COT
UPDATE AD_Column SET ColumnName='AD_ToolBarButton_ID', Name='ToolBar Button', Description=NULL, Help=NULL WHERE AD_Element_ID=200016
;

-- Mar 28, 2012 10:13:53 AM COT
UPDATE AD_Process_Para SET ColumnName='AD_ToolBarButton_ID', Name='ToolBar Button', Description=NULL, Help=NULL, AD_Element_ID=200016 WHERE UPPER(ColumnName)='AD_TOOLBARBUTTON_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Mar 28, 2012 10:13:53 AM COT
UPDATE AD_Process_Para SET ColumnName='AD_ToolBarButton_ID', Name='ToolBar Button', Description=NULL, Help=NULL WHERE AD_Element_ID=200016 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 10:13:53 AM COT
UPDATE AD_Field SET Name='ToolBar Button', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200016) AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 10:13:53 AM COT
UPDATE AD_PrintFormatItem pi SET PrintName='ToolBar Button', Name='ToolBar Button' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200016)
;

-- Mar 28, 2012 10:14:52 AM COT
UPDATE AD_Column SET Help='The Classname identifies the Java classname used by this report or process.', IsSelectionColumn='N', AD_Element_ID=1299, ColumnName='Classname', Description='Java Classname', Name='Classname',Updated=TO_DATE('2012-03-28 10:14:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200087
;

-- Mar 28, 2012 10:14:52 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200087
;

-- Mar 28, 2012 10:14:52 AM COT
UPDATE AD_Field SET Name='Classname', Description='Java Classname', Help='The Classname identifies the Java classname used by this report or process.' WHERE AD_Column_ID=200087 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 10:15:18 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200017,'ComponentName','D','Component Name','Component Name',0,TO_DATE('2012-03-28 10:15:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-28 10:15:17','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 28, 2012 10:15:18 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200017 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 28, 2012 10:15:40 AM COT
UPDATE AD_Column SET IsMandatory='Y', Help=NULL, FieldLength=255, AD_Reference_ID=10, AD_Element_ID=200017, ColumnName='ComponentName', Description=NULL, Name='Component Name',Updated=TO_DATE('2012-03-28 10:15:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200088
;

-- Mar 28, 2012 10:15:40 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200088
;

-- Mar 28, 2012 10:15:40 AM COT
UPDATE AD_Field SET Name='Component Name', Description=NULL, Help=NULL WHERE AD_Column_ID=200088 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 10:15:43 AM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-03-28 10:15:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200087
;

-- Mar 28, 2012 10:16:24 AM COT
UPDATE AD_Column SET DefaultValue='N', Help='The migration "resets" the system to the current/original setting.  If selected you can save the customization and re-apply it.  Please note that you need to check, if your customization has no negative side effect in the new release.', FieldLength=1, IsSelectionColumn='N', AD_Reference_ID=20, AD_Element_ID=2643, ColumnName='IsCustomization', Description='The change is a customization of the data dictionary and can be applied after Migration', Name='Customization',Updated=TO_DATE('2012-03-28 10:16:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200094
;

-- Mar 28, 2012 10:16:24 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200094
;

-- Mar 28, 2012 10:16:24 AM COT
UPDATE AD_Field SET Name='Customization', Description='The change is a customization of the data dictionary and can be applied after Migration', Help='The migration "resets" the system to the current/original setting.  If selected you can save the customization and re-apply it.  Please note that you need to check, if your customization has no negative side effect in the new release.' WHERE AD_Column_ID=200094 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 10:17:30 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,Description,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200018,'ActionClassName','D','Action Class Name','The class name that implements the interface for toolbar actions','Action Class Name',0,TO_DATE('2012-03-28 10:17:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-28 10:17:29','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 28, 2012 10:17:30 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200018 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 28, 2012 10:17:52 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200095,200003,'D',0,'N','N','N',0,'N',255,'N',10,'N','N',200018,'N','Y','N','Y','N','ActionClassName','The class name that implements the interface for toolbar actions','Action Class Name','Y',100,TO_DATE('2012-03-28 10:17:51','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:17:51','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:17:52 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200095 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:18:46 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,EntityType,Name,Description,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200019,'ActionName','Used to get the corresponding message and Icon name prefix','D','Action Name','Action name on the toolbar','Action Name',0,TO_DATE('2012-03-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 28, 2012 10:18:46 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200019 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 28, 2012 10:19:02 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200096,200003,'D',0,'N','N','N',0,'Used to get the corresponding message and Icon name prefix','N',60,'N',10,'N','N',200019,'N','Y','N','Y','N','ActionName','Action name on the toolbar','Action Name','Y',100,TO_DATE('2012-03-28 10:19:01','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:19:01','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:19:02 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200096 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:20:14 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,Description,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200020,'KeyStroke_KeyCode','D','KeyCode','KeyCode for shortcuts','KeyCode',0,TO_DATE('2012-03-28 10:20:13','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-28 10:20:13','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 28, 2012 10:20:14 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 28, 2012 10:20:33 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,Description,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200021,'KeyStroke_Modifiers','D','Keystroke Modifiers','Keystroke Modifiers for shortcuts','Keystroke Modifiers',0,TO_DATE('2012-03-28 10:20:33','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-28 10:20:33','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 28, 2012 10:20:33 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 28, 2012 10:20:51 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200097,200003,'D',0,'N','N','N',0,'N',10,'N',11,'N','N',200020,'N','Y','N','Y','N','KeyStroke_KeyCode','KeyCode for shortcuts','KeyCode','Y',100,TO_DATE('2012-03-28 10:20:51','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:20:51','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:20:51 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200097 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:21:05 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200098,200003,'D',0,'N','N','N',0,'N',10,'N',11,'N','N',200021,'N','Y','N','Y','N','KeyStroke_Modifiers','Keystroke Modifiers for shortcuts','Keystroke Modifiers','Y',100,TO_DATE('2012-03-28 10:21:05','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 10:21:05','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 10:21:05 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200098 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 10:21:24 AM COT
CREATE TABLE AD_ToolBarButton (ActionClassName NVARCHAR2(255) DEFAULT NULL , ActionName NVARCHAR2(60) DEFAULT NULL , AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_ToolBarButton_ID NUMBER(10) NOT NULL, Classname NVARCHAR2(255) NOT NULL, ComponentName NVARCHAR2(255) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsCustomization CHAR(1) DEFAULT 'N' CHECK (IsCustomization IN ('Y','N')) NOT NULL, KeyStroke_KeyCode NUMBER(10) DEFAULT NULL , KeyStroke_Modifiers NUMBER(10) DEFAULT NULL , Name NVARCHAR2(60) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_ToolBarButton_Key PRIMARY KEY (AD_ToolBarButton_ID))
;

-- Mar 28, 2012 10:22:18 AM COT
INSERT INTO AD_Window (AD_Window_ID,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,IsActive,Created,UpdatedBy,CreatedBy,Updated,AD_Org_ID,AD_Client_ID,Processing) VALUES (200000,'M','Y','N','N',0,0,'D','ToolBar Button','Y',TO_DATE('2012-03-28 10:22:18','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2012-03-28 10:22:18','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 28, 2012 10:22:19 AM COT
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Mar 28, 2012 10:22:27 AM COT
UPDATE AD_Table SET AD_Window_ID=200000,Updated=TO_DATE('2012-03-28 10:22:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200003
;

-- Mar 28, 2012 10:23:18 AM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,AD_Tab_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,TabLevel,IsInsertRecord,IsAdvancedTab,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,IsActive,UpdatedBy,Processing) VALUES ('Y',200000,10,'N','N',200003,200002,'N','N','N','N',0,'Y','N','D','ToolBar Button',0,0,TO_DATE('2012-03-28 10:23:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-28 10:23:17','YYYY-MM-DD HH24:MI:SS'),'Y',100,'N')
;

-- Mar 28, 2012 10:23:18 AM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Mar 28, 2012 10:23:21 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',255,'Y','N','N',200095,'N','Y',200002,200051,'N','D','The class name that implements the interface for toolbar actions','Action Class Name',100,0,'Y',TO_DATE('2012-03-28 10:23:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:21 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200051 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:22 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',60,'Y','N','N',200096,'N','Y',200002,200052,'N','Used to get the corresponding message and Icon name prefix','D','Action name on the toolbar','Action Name',100,0,'Y',TO_DATE('2012-03-28 10:23:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:22 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200052 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:22 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'Y','N','N',200089,'N','Y',200002,200053,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active',100,0,'Y',TO_DATE('2012-03-28 10:23:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:22 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200053 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:23 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',255,'Y','N','N',200087,'N','Y',200002,200054,'N','The Classname identifies the Java classname used by this report or process.','D','Java Classname','Classname',100,0,'Y',TO_DATE('2012-03-28 10:23:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:23 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200054 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:23 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',200083,'N','Y',200002,200055,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client',100,0,'Y',TO_DATE('2012-03-28 10:23:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:23 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200055 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:23 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',255,'Y','N','N',200088,'N','Y',200002,200056,'N','D','Component Name',100,0,'Y',TO_DATE('2012-03-28 10:23:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:23 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200056 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:24 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'Y','N','N',200094,'N','Y',200002,200057,'N','The migration "resets" the system to the current/original setting.  If selected you can save the customization and re-apply it.  Please note that you need to check, if your customization has no negative side effect in the new release.','D','The change is a customization of the data dictionary and can be applied after Migration','Customization',100,0,'Y',TO_DATE('2012-03-28 10:23:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:24 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200057 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:24 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'Y','N','N',200097,'N','Y',200002,200058,'N','D','KeyCode for shortcuts','KeyCode',100,0,'Y',TO_DATE('2012-03-28 10:23:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:24','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:24 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200058 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:25 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'Y','N','N',200098,'N','Y',200002,200059,'N','D','Keystroke Modifiers for shortcuts','Keystroke Modifiers',100,0,'Y',TO_DATE('2012-03-28 10:23:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:24','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:25 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200059 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:25 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',60,'Y','N','N',200091,'N','Y',200002,200060,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name',100,0,'Y',TO_DATE('2012-03-28 10:23:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:25 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200060 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:26 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',200084,'N','Y',200002,200061,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization',100,0,'Y',TO_DATE('2012-03-28 10:23:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:26 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200061 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:23:26 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'N','N','N',200090,'N','Y',200002,200062,'N','D','ToolBar Button',100,0,'Y',TO_DATE('2012-03-28 10:23:26','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 10:23:26','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 10:23:26 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200062 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200055
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200061
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200060
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200054
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200056
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200057
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200051
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200052
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200058
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200059
;

-- Mar 28, 2012 10:24:08 AM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200053
;

-- Mar 28, 2012 10:24:17 AM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-03-28 10:24:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200061
;

-- Mar 28, 2012 10:25:03 AM COT
UPDATE AD_Field SET DisplayLogic='@IsCustomization@=Y',Updated=TO_DATE('2012-03-28 10:25:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200051
;

-- Mar 28, 2012 10:25:06 AM COT
UPDATE AD_Field SET DisplayLogic='@IsCustomization@=Y',Updated=TO_DATE('2012-03-28 10:25:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200052
;

-- Mar 28, 2012 10:25:08 AM COT
UPDATE AD_Field SET DisplayLogic='@IsCustomization@=Y',Updated=TO_DATE('2012-03-28 10:25:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200058
;

-- Mar 28, 2012 10:25:12 AM COT
UPDATE AD_Field SET IsSameLine='Y', DisplayLogic='@IsCustomization@=Y',Updated=TO_DATE('2012-03-28 10:25:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200059
;

-- Mar 28, 2012 10:25:49 AM COT
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,Action,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Created,IsActive,UpdatedBy,AD_Client_ID,CreatedBy,Updated,AD_Org_ID) VALUES (200000,200000,'N','W','N','N','D','Y','ToolBar Button',TO_DATE('2012-03-28 10:25:48','YYYY-MM-DD HH24:MI:SS'),'Y',100,0,100,TO_DATE('2012-03-28 10:25:48','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Mar 28, 2012 10:25:49 AM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200000 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 28, 2012 10:25:49 AM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200000, 0, 999 FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200000)
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- Mar 28, 2012 10:26:06 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- Mar 28, 2012 10:49:55 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:49:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200083
;

-- Mar 28, 2012 10:50:25 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:50:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200084
;

-- Mar 28, 2012 10:50:26 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:50:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200085
;

-- Mar 28, 2012 10:50:37 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:50:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200086
;

-- Mar 28, 2012 10:50:39 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:50:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200089
;

-- Mar 28, 2012 10:50:43 AM COT
UPDATE AD_Column SET IsUpdateable='N', IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:50:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200090
;

-- Mar 28, 2012 10:50:44 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:50:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200092
;

-- Mar 28, 2012 10:50:46 AM COT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2012-03-28 10:50:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200093
;

-- Mar 28, 2012 10:33:16 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 10:33:16','YYYY-MM-DD HH24:MI:SS'),100,'Ignore','Y','Window - Ignore',TO_DATE('2012-03-28 10:33:16','YYYY-MM-DD HH24:MI:SS'),100,200000,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:08:13 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:08:12','YYYY-MM-DD HH24:MI:SS'),100,'Help','Y','Window - Help',TO_DATE('2012-03-28 11:08:12','YYYY-MM-DD HH24:MI:SS'),100,200001,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:09:27 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:09:26','YYYY-MM-DD HH24:MI:SS'),100,'New','Y','Window - New',TO_DATE('2012-03-28 11:09:26','YYYY-MM-DD HH24:MI:SS'),100,200002,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:09:36 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:09:36','YYYY-MM-DD HH24:MI:SS'),100,'Copy','Y','Window - Copy',TO_DATE('2012-03-28 11:09:36','YYYY-MM-DD HH24:MI:SS'),100,200003,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:09:43 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:09:43','YYYY-MM-DD HH24:MI:SS'),100,'Delete','Y','Window - Delete',TO_DATE('2012-03-28 11:09:43','YYYY-MM-DD HH24:MI:SS'),100,200004,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:09:52 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:09:52','YYYY-MM-DD HH24:MI:SS'),100,'DeleteSelection','Y','Window - DeleteSelection',TO_DATE('2012-03-28 11:09:52','YYYY-MM-DD HH24:MI:SS'),100,200005,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:01 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:01','YYYY-MM-DD HH24:MI:SS'),100,'Save','Y','Window - Save',TO_DATE('2012-03-28 11:10:01','YYYY-MM-DD HH24:MI:SS'),100,200006,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:12 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:11','YYYY-MM-DD HH24:MI:SS'),100,'Refresh','Y','Window - Refresh',TO_DATE('2012-03-28 11:10:11','YYYY-MM-DD HH24:MI:SS'),100,200007,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:19 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:18','YYYY-MM-DD HH24:MI:SS'),100,'Find','Y','Window - Find',TO_DATE('2012-03-28 11:10:18','YYYY-MM-DD HH24:MI:SS'),100,200008,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:25 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:25','YYYY-MM-DD HH24:MI:SS'),100,'Attachment','Y','Window - Attachment',TO_DATE('2012-03-28 11:10:25','YYYY-MM-DD HH24:MI:SS'),100,200009,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:31 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:31','YYYY-MM-DD HH24:MI:SS'),100,'Chat','Y','Window - Chat',TO_DATE('2012-03-28 11:10:31','YYYY-MM-DD HH24:MI:SS'),100,200010,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:39 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:39','YYYY-MM-DD HH24:MI:SS'),100,'Multi','Y','Window - Multi',TO_DATE('2012-03-28 11:10:39','YYYY-MM-DD HH24:MI:SS'),100,200011,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:45 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:44','YYYY-MM-DD HH24:MI:SS'),100,'History','Y','Window - History',TO_DATE('2012-03-28 11:10:44','YYYY-MM-DD HH24:MI:SS'),100,200012,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:10:49 AM COT
UPDATE AD_ToolBarButton SET ComponentName='Home', Name='Window - Home',Updated=TO_DATE('2012-03-28 11:10:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200012
;

-- Mar 28, 2012 11:10:55 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:10:55','YYYY-MM-DD HH24:MI:SS'),100,'Parent','Y','Window - Parent',TO_DATE('2012-03-28 11:10:55','YYYY-MM-DD HH24:MI:SS'),100,200013,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:02 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:01','YYYY-MM-DD HH24:MI:SS'),100,'Detail','Y','Window - Detail',TO_DATE('2012-03-28 11:11:01','YYYY-MM-DD HH24:MI:SS'),100,200014,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:07 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:07','YYYY-MM-DD HH24:MI:SS'),100,'First','Y','Window - First',TO_DATE('2012-03-28 11:11:07','YYYY-MM-DD HH24:MI:SS'),100,200015,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:13 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:13','YYYY-MM-DD HH24:MI:SS'),100,'Previous','Y','Window - Previous',TO_DATE('2012-03-28 11:11:13','YYYY-MM-DD HH24:MI:SS'),100,200016,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:20 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:19','YYYY-MM-DD HH24:MI:SS'),100,'Next','Y','Window - Next',TO_DATE('2012-03-28 11:11:19','YYYY-MM-DD HH24:MI:SS'),100,200017,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:26 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:25','YYYY-MM-DD HH24:MI:SS'),100,'Last','Y','Window - Last',TO_DATE('2012-03-28 11:11:25','YYYY-MM-DD HH24:MI:SS'),100,200018,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:31 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:31','YYYY-MM-DD HH24:MI:SS'),100,'Report','Y','Window - Report',TO_DATE('2012-03-28 11:11:31','YYYY-MM-DD HH24:MI:SS'),100,200019,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:37 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:36','YYYY-MM-DD HH24:MI:SS'),100,'Archive','Y','Window - Archive',TO_DATE('2012-03-28 11:11:36','YYYY-MM-DD HH24:MI:SS'),100,200020,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:43 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:42','YYYY-MM-DD HH24:MI:SS'),100,'PrintPreview','Y','Window - PrintPreview',TO_DATE('2012-03-28 11:11:42','YYYY-MM-DD HH24:MI:SS'),100,200021,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:49 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:49','YYYY-MM-DD HH24:MI:SS'),100,'Print','Y','Window - Print',TO_DATE('2012-03-28 11:11:49','YYYY-MM-DD HH24:MI:SS'),100,200022,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:11:56 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:11:56','YYYY-MM-DD HH24:MI:SS'),100,'ZoomAcross','Y','Window - ZoomAcross',TO_DATE('2012-03-28 11:11:56','YYYY-MM-DD HH24:MI:SS'),100,200023,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:12:02 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:12:02','YYYY-MM-DD HH24:MI:SS'),100,'WorkFlow','Y','Window - WorkFlow',TO_DATE('2012-03-28 11:12:02','YYYY-MM-DD HH24:MI:SS'),100,200024,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:12:08 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:12:07','YYYY-MM-DD HH24:MI:SS'),100,'Request','Y','Window - Request',TO_DATE('2012-03-28 11:12:07','YYYY-MM-DD HH24:MI:SS'),100,200025,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:12:14 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:12:13','YYYY-MM-DD HH24:MI:SS'),100,'InfoProduct','Y','Window - InfoProduct',TO_DATE('2012-03-28 11:12:13','YYYY-MM-DD HH24:MI:SS'),100,200026,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:12:20 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:12:19','YYYY-MM-DD HH24:MI:SS'),100,'End','Y','Window - End',TO_DATE('2012-03-28 11:12:19','YYYY-MM-DD HH24:MI:SS'),100,200027,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:15:27 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:15:27','YYYY-MM-DD HH24:MI:SS'),100,'Lock','Y','Window - Lock',TO_DATE('2012-03-28 11:15:27','YYYY-MM-DD HH24:MI:SS'),100,200028,'org.compiere.apps.APanel','N',0,0)
;

-- Mar 28, 2012 11:16:00 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:16:00','YYYY-MM-DD HH24:MI:SS'),100,'Ignore','Y','zk Window - Ignore',TO_DATE('2012-03-28 11:16:00','YYYY-MM-DD HH24:MI:SS'),100,200029,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:16:41 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:16:41','YYYY-MM-DD HH24:MI:SS'),100,'Help','Y','zk Window - Help',TO_DATE('2012-03-28 11:16:41','YYYY-MM-DD HH24:MI:SS'),100,200030,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:16:50 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:16:50','YYYY-MM-DD HH24:MI:SS'),100,'New','Y','zk Window - New',TO_DATE('2012-03-28 11:16:50','YYYY-MM-DD HH24:MI:SS'),100,200031,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:16:59 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:16:58','YYYY-MM-DD HH24:MI:SS'),100,'Copy','Y','zk Window - Copy',TO_DATE('2012-03-28 11:16:58','YYYY-MM-DD HH24:MI:SS'),100,200032,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:09 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:09','YYYY-MM-DD HH24:MI:SS'),100,'Delete','Y','zk Window - Delete',TO_DATE('2012-03-28 11:17:09','YYYY-MM-DD HH24:MI:SS'),100,200033,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:16 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:15','YYYY-MM-DD HH24:MI:SS'),100,'DeleteSelection','Y','zk Window - DeleteSelection',TO_DATE('2012-03-28 11:17:15','YYYY-MM-DD HH24:MI:SS'),100,200034,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:22 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:21','YYYY-MM-DD HH24:MI:SS'),100,'Save','Y','zk Window - Save',TO_DATE('2012-03-28 11:17:21','YYYY-MM-DD HH24:MI:SS'),100,200035,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:30 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:29','YYYY-MM-DD HH24:MI:SS'),100,'SaveCreate','Y','zk Window - SaveCreate',TO_DATE('2012-03-28 11:17:29','YYYY-MM-DD HH24:MI:SS'),100,200036,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:36 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:35','YYYY-MM-DD HH24:MI:SS'),100,'Refresh','Y','zk Window - Refresh',TO_DATE('2012-03-28 11:17:35','YYYY-MM-DD HH24:MI:SS'),100,200037,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:42 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:41','YYYY-MM-DD HH24:MI:SS'),100,'Find','Y','zk Window - Find',TO_DATE('2012-03-28 11:17:41','YYYY-MM-DD HH24:MI:SS'),100,200038,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:49 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:48','YYYY-MM-DD HH24:MI:SS'),100,'Attachment','Y','zk Window - Attachment',TO_DATE('2012-03-28 11:17:48','YYYY-MM-DD HH24:MI:SS'),100,200039,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:17:57 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:17:57','YYYY-MM-DD HH24:MI:SS'),100,'Chat','Y','zk Window - Chat',TO_DATE('2012-03-28 11:17:57','YYYY-MM-DD HH24:MI:SS'),100,200040,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:18:06 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:18:06','YYYY-MM-DD HH24:MI:SS'),100,'Multi','Y','zk Window - Multi',TO_DATE('2012-03-28 11:18:06','YYYY-MM-DD HH24:MI:SS'),100,200041,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:18:12 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:18:12','YYYY-MM-DD HH24:MI:SS'),100,'History','Y','zk Window - History',TO_DATE('2012-03-28 11:18:12','YYYY-MM-DD HH24:MI:SS'),100,200042,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:18:40 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:18:40','YYYY-MM-DD HH24:MI:SS'),100,'Parent','Y','zk Window - Parent',TO_DATE('2012-03-28 11:18:40','YYYY-MM-DD HH24:MI:SS'),100,200043,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:18:50 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:18:49','YYYY-MM-DD HH24:MI:SS'),100,'Detail','Y','zk Window - Detail',TO_DATE('2012-03-28 11:18:49','YYYY-MM-DD HH24:MI:SS'),100,200044,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:18:56 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,'First','Y','zk Window - First',TO_DATE('2012-03-28 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,200045,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:03 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:02','YYYY-MM-DD HH24:MI:SS'),100,'Previous','Y','zk Window - Previous',TO_DATE('2012-03-28 11:19:02','YYYY-MM-DD HH24:MI:SS'),100,200046,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:08 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:08','YYYY-MM-DD HH24:MI:SS'),100,'Next','Y','zk Window - Next',TO_DATE('2012-03-28 11:19:08','YYYY-MM-DD HH24:MI:SS'),100,200047,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:19 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:18','YYYY-MM-DD HH24:MI:SS'),100,'Last','Y','zk Window - Last',TO_DATE('2012-03-28 11:19:18','YYYY-MM-DD HH24:MI:SS'),100,200048,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:27 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:27','YYYY-MM-DD HH24:MI:SS'),100,'Report','Y','zk Window - Report',TO_DATE('2012-03-28 11:19:27','YYYY-MM-DD HH24:MI:SS'),100,200049,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:33 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:32','YYYY-MM-DD HH24:MI:SS'),100,'Archive','Y','zk Window - Archive',TO_DATE('2012-03-28 11:19:32','YYYY-MM-DD HH24:MI:SS'),100,200050,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:39 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:39','YYYY-MM-DD HH24:MI:SS'),100,'Print','Y','zk Window - Print',TO_DATE('2012-03-28 11:19:39','YYYY-MM-DD HH24:MI:SS'),100,200051,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:46 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,'Lock','Y','zk Window - Lock',TO_DATE('2012-03-28 11:19:45','YYYY-MM-DD HH24:MI:SS'),100,200052,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:52 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,'ZoomAcross','Y','zk Window - ZoomAcross',TO_DATE('2012-03-28 11:19:51','YYYY-MM-DD HH24:MI:SS'),100,200053,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:19:58 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:19:57','YYYY-MM-DD HH24:MI:SS'),100,'WorkFlow','Y','zk Window - WorkFlow',TO_DATE('2012-03-28 11:19:57','YYYY-MM-DD HH24:MI:SS'),100,200054,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:20:04 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:20:04','YYYY-MM-DD HH24:MI:SS'),100,'Request','Y','zk Window - Request',TO_DATE('2012-03-28 11:20:04','YYYY-MM-DD HH24:MI:SS'),100,200055,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:20:11 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:20:10','YYYY-MM-DD HH24:MI:SS'),100,'InfoProduct','Y','zk Window - InfoProduct',TO_DATE('2012-03-28 11:20:10','YYYY-MM-DD HH24:MI:SS'),100,200056,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:20:17 AM COT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,Name,Updated,UpdatedBy,AD_ToolBarButton_ID,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers) VALUES (0,0,TO_DATE('2012-03-28 11:20:17','YYYY-MM-DD HH24:MI:SS'),100,'Export','Y','zk Window - Export',TO_DATE('2012-03-28 11:20:17','YYYY-MM-DD HH24:MI:SS'),100,200057,'org.adempiere.webui.component.CWindowToolbar','N',0,0)
;

-- Mar 28, 2012 11:22:48 AM COT
INSERT INTO AD_Window (AD_Window_ID,WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,IsActive,Created,UpdatedBy,CreatedBy,Updated,AD_Org_ID,AD_Client_ID,Processing) VALUES (200001,'M','Y','N','N',0,0,'D','ToolBar Button Restrict','Y',TO_DATE('2012-03-28 11:22:47','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2012-03-28 11:22:47','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 28, 2012 11:22:48 AM COT
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Mar 28, 2012 11:22:59 AM COT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,CopyColumnsFromTable,EntityType,IsCentrallyMaintained,IsDeleteable,ReplicationType,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','6',0,200001,200004,'N','N','N','Y','N','D','Y','Y','L','AD_ToolBarButtonRestrict','ToolBar Button Restrict',0,'Y',0,100,TO_DATE('2012-03-28 11:22:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-28 11:22:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:22:59 AM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200004 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Mar 28, 2012 11:23:00 AM COT
INSERT INTO AD_Sequence (IncrementNo,StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,CreatedBy,IsActive) VALUES (1,'N',50000,'Y',1000000,1000000,'N','Y',200004,'Table AD_ToolBarButtonRestrict','AD_ToolBarButtonRestrict',0,0,TO_DATE('2012-03-28 11:22:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-28 11:22:59','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Mar 28, 2012 11:28:13 AM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Client_ID@',200100,200004,'D',1,'Y','N','N',0,'A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N',22,'N',19,'Y','N',102,'N','Y','N','N','N','AD_Client_ID','Client/Tenant for this installation.','Client','N',100,TO_DATE('2012-03-28 11:28:12','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:13 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200100 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:13 AM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('@#AD_Org_ID@',200101,200004,'D',1,'Y','N','N',0,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N',22,'N',19,'Y',104,'N',113,'N','Y','N','N','N','AD_Org_ID','Organizational entity within client','Organization','N',100,TO_DATE('2012-03-28 11:28:13','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:13','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:13 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200101 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:14 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200102,200004,'D',1,'Y','N','N',0,'The Created field indicates the date that this record was created.','N',7,'N',16,'Y','N',245,'N','Y','N','N','N','Created','Date this record was created','Created','N',100,TO_DATE('2012-03-28 11:28:13','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:13','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:14 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200102 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:14 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200103,200004,'D',1,110,'Y','N','N',0,'The Created By field indicates the user who created this record.','N',22,'N',18,'Y','N',246,'N','Y','N','N','N','CreatedBy','User who created this records','Created By','N',100,TO_DATE('2012-03-28 11:28:14','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:14','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:14 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200103 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:15 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200104,200004,'D',1,'N','N','N',0,'A description is limited to 255 characters.','N',255,'Y',10,'Y','N',275,'N','Y','N','Y','N','Description','Optional short description of the record','Description','Y',100,TO_DATE('2012-03-28 11:28:14','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:14','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:15 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200104 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:15 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200105,200004,'D',1,'N','N','N',0,'The Help field contains a hint, comment or help about the use of this item.','N',2000,'N',14,'Y','N',326,'N','Y','N','Y','N','Help','Comment or Hint','Comment/Help','Y',100,TO_DATE('2012-03-28 11:28:15','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:15','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:15 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200105 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:16 AM COT
INSERT INTO AD_Column (DefaultValue,AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES ('Y',200106,200004,'D',1,'Y','N','N',0,'There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N',1,'N',20,'Y','N',348,'N','Y','N','Y','N','IsActive','The record is active in the system','Active','N',100,TO_DATE('2012-03-28 11:28:15','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:15','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:16 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200106 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:16 AM COT
INSERT INTO AD_Element (AD_Element_ID,ColumnName,EntityType,Name,PrintName,AD_Client_ID,Created,Updated,IsActive,AD_Org_ID,CreatedBy,UpdatedBy) VALUES (200022,'AD_ToolBarButtonRestrict_ID','D','ToolBar Button Restrict','ToolBar Button Restrict',0,TO_DATE('2012-03-28 11:28:16','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-03-28 11:28:16','YYYY-MM-DD HH24:MI:SS'),'Y',0,100,100)
;

-- Mar 28, 2012 11:28:16 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_PrintName,PO_Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_PrintName,t.PO_Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Mar 28, 2012 11:28:16 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200107,200004,'D',1,'Y','N','N',0,'N',22,'N',13,'Y','Y',200022,'N','Y','N','N','N','AD_ToolBarButtonRestrict_ID','ToolBar Button Restrict','N',100,TO_DATE('2012-03-28 11:28:16','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:16 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200107 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:17 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200108,200004,'D',1,'Y','N','Y',1,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','N',60,'Y',10,'Y','N',469,'N','Y','N','Y','N','Name','Alphanumeric identifier of the entity','Name','Y',100,TO_DATE('2012-03-28 11:28:16','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:16','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:17 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200108 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:17 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200109,200004,'D',1,'Y','N','N',0,'The Updated field indicates the date that this record was updated.','N',7,'N',16,'Y','N',607,'N','Y','N','N','N','Updated','Date this record was updated','Updated','N',100,TO_DATE('2012-03-28 11:28:17','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:17 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200109 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:18 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200110,200004,'D',1,110,'Y','N','N',0,'The Updated By field indicates the user who updated this record.','N',22,'N',18,'Y','N',608,'N','Y','N','N','N','UpdatedBy','User who updated this records','Updated By','N',100,TO_DATE('2012-03-28 11:28:17','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:18 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200110 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:28:18 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200111,200004,'D',1,'Y','N','N',0,'A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','N',40,'Y',10,'Y','N',620,'N','Y','N','Y','N','Value','Search key for the record in the format required - must be unique','Search Key','Y',100,TO_DATE('2012-03-28 11:28:18','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-03-28 11:28:18','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 28, 2012 11:28:18 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200111 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Mar 28, 2012 11:29:31 AM COT
UPDATE AD_Column SET Help=NULL, IsSelectionColumn='N', AD_Reference_ID=19, AD_Element_ID=200016, ColumnName='AD_ToolBarButton_ID', Description=NULL, Name='ToolBar Button',Updated=TO_DATE('2012-03-28 11:29:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200104
;

-- Mar 28, 2012 11:29:31 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200104
;

-- Mar 28, 2012 11:29:31 AM COT
UPDATE AD_Field SET Name='ToolBar Button', Description=NULL, Help=NULL WHERE AD_Column_ID=200104 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 11:29:37 AM COT
UPDATE AD_Column SET FieldLength=10,Updated=TO_DATE('2012-03-28 11:29:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200104
;

-- Mar 28, 2012 11:33:37 AM COT
INSERT INTO AD_Val_Rule (Code,Type,AD_Val_Rule_ID,EntityType,Name,CreatedBy,Updated,UpdatedBy,AD_Client_ID,IsActive,AD_Org_ID,Created) VALUES ('AD_RefList.Value IN (''W'',''R'',''X'')','S',200002,'D','AD_ToolBarButton Action - Window/Report/Form',100,TO_DATE('2012-03-28 11:33:36','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',0,TO_DATE('2012-03-28 11:33:36','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:33:47 AM COT
UPDATE AD_Column SET AD_Reference_Value_ID=104, IsMandatory='Y', Help='The Action field is a drop down list box which indicates the Action to be performed for this Item.', FieldLength=1, AD_Reference_ID=17, AD_Val_Rule_ID=200002, AD_Element_ID=152, ColumnName='Action', Description='Indicates the Action to be performed', Name='Action',Updated=TO_DATE('2012-03-28 11:33:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200105
;

-- Mar 28, 2012 11:33:47 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200105
;

-- Mar 28, 2012 11:33:47 AM COT
UPDATE AD_Field SET Name='Action', Description='Indicates the Action to be performed', Help='The Action field is a drop down list box which indicates the Action to be performed for this Item.' WHERE AD_Column_ID=200105 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 11:35:22 AM COT
UPDATE AD_Column SET IsIdentifier='N', Help='The Role determines security and access a user who has this Role will have in the System.', FieldLength=10, IsSelectionColumn='N', AD_Reference_ID=19, AD_Element_ID=123, ColumnName='AD_Role_ID', Description='Responsibility Role', Name='Role',Updated=TO_DATE('2012-03-28 11:35:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200108
;

-- Mar 28, 2012 11:35:22 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200108
;

-- Mar 28, 2012 11:35:22 AM COT
UPDATE AD_Field SET Name='Role', Description='Responsibility Role', Help='The Role determines security and access a user who has this Role will have in the System.' WHERE AD_Column_ID=200108 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 11:35:54 AM COT
UPDATE AD_Column SET IsMandatory='N', Help='The Window field identifies a unique Window in the system.', FieldLength=10, IsSelectionColumn='N', AD_Reference_ID=19, AD_Element_ID=143, ColumnName='AD_Window_ID', Description='Data entry or display window', Name='Window',Updated=TO_DATE('2012-03-28 11:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200111
;

-- Mar 28, 2012 11:35:54 AM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200111
;

-- Mar 28, 2012 11:35:54 AM COT
UPDATE AD_Field SET Name='Window', Description='Data entry or display window', Help='The Window field identifies a unique Window in the system.' WHERE AD_Column_ID=200111 AND IsCentrallyMaintained='Y'
;

-- Mar 28, 2012 11:36:24 AM COT
CREATE TABLE AD_ToolBarButtonRestrict (Action CHAR(1) NOT NULL, AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_Role_ID NUMBER(10) NOT NULL, AD_ToolBarButton_ID NUMBER(10) DEFAULT NULL , AD_ToolBarButtonRestrict_ID NUMBER(10) NOT NULL, AD_Window_ID NUMBER(10) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT AD_ToolBarButtonRestrict_Key PRIMARY KEY (AD_ToolBarButtonRestrict_ID))
;

-- Mar 28, 2012 11:37:48 AM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,AD_Tab_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,TabLevel,IsInsertRecord,IsAdvancedTab,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,IsActive,UpdatedBy,Processing) VALUES ('Y',200001,10,'N','N',200004,200003,'N','N','N','N',0,'Y','N','D','ToolBar Button Restrict',0,0,TO_DATE('2012-03-28 11:37:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-03-28 11:37:47','YYYY-MM-DD HH24:MI:SS'),'Y',100,'N')
;

-- Mar 28, 2012 11:37:48 AM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200003 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Mar 28, 2012 11:37:52 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'Y','N','N',200105,'N','Y',200003,200063,'N','The Action field is a drop down list box which indicates the Action to be performed for this Item.','D','Indicates the Action to be performed','Action',100,0,'Y',TO_DATE('2012-03-28 11:37:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:52 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200063 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:37:53 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'Y','N','N',200106,'N','Y',200003,200064,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active',100,0,'Y',TO_DATE('2012-03-28 11:37:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:52','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:53 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200064 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:37:53 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',200100,'N','Y',200003,200065,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client',100,0,'Y',TO_DATE('2012-03-28 11:37:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:53 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:37:54 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'Y','N','N',200101,'N','Y',200003,200066,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization',100,0,'Y',TO_DATE('2012-03-28 11:37:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:54 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:37:54 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'Y','N','N',200108,'N','Y',200003,200067,'N','The Role determines security and access a user who has this Role will have in the System.','D','Responsibility Role','Role',100,0,'Y',TO_DATE('2012-03-28 11:37:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:54 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:37:54 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'Y','N','N',200104,'N','Y',200003,200068,'N','D','ToolBar Button',100,0,'Y',TO_DATE('2012-03-28 11:37:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:54 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:37:55 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',22,'N','N','N',200107,'N','Y',200003,200069,'N','D','ToolBar Button Restrict',100,0,'Y',TO_DATE('2012-03-28 11:37:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:54','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:55 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:37:55 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'Y','N','N',200111,'N','Y',200003,200070,'N','The Window field identifies a unique Window in the system.','D','Data entry or display window','Window',100,0,'Y',TO_DATE('2012-03-28 11:37:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-03-28 11:37:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 28, 2012 11:37:55 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Mar 28, 2012 11:38:22 AM COT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200065
;

-- Mar 28, 2012 11:38:22 AM COT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200066
;

-- Mar 28, 2012 11:38:22 AM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200067
;

-- Mar 28, 2012 11:38:22 AM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200064
;

-- Mar 28, 2012 11:38:22 AM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200063
;

-- Mar 28, 2012 11:38:22 AM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200070
;

-- Mar 28, 2012 11:38:22 AM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200068
;

-- Mar 28, 2012 11:38:30 AM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-03-28 11:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200066
;

-- Mar 28, 2012 11:38:42 AM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-03-28 11:38:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200064
;

-- Mar 28, 2012 11:38:56 AM COT
UPDATE AD_Field SET IsSameLine='Y', DisplayLogic='@Action@=W',Updated=TO_DATE('2012-03-28 11:38:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200070
;

-- Mar 28, 2012 11:39:03 AM COT
UPDATE AD_Field SET DisplayLength=40,Updated=TO_DATE('2012-03-28 11:39:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200068
;

-- Mar 28, 2012 11:39:48 AM COT
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,Action,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Created,IsActive,UpdatedBy,AD_Client_ID,CreatedBy,Updated,AD_Org_ID) VALUES (200001,200001,'N','W','N','N','U','Y','ToolBar Button Restrict',TO_DATE('2012-03-28 11:39:47','YYYY-MM-DD HH24:MI:SS'),'Y',100,0,100,TO_DATE('2012-03-28 11:39:47','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Mar 28, 2012 11:39:48 AM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 28, 2012 11:39:48 AM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200001, 0, 999 FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200001)
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=147
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53246
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=487
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=150
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=495
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50007
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=362
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200001
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Mar 28, 2012 11:40:25 AM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Mar 28, 2012 11:44:41 AM COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_Val_Rule SET Code='AD_Ref_List.Value IN (''W'',''R'',''X'')',Updated=TO_DATE('2012-03-28 11:44:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200002
;

-- Mar 29, 2012 11:53:47 AM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2012-03-29 11:53:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200108
;

-- Mar 29, 2012 11:53:52 AM CEST
ALTER TABLE AD_ToolBarButtonRestrict MODIFY AD_Role_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 29, 2012 11:53:54 AM CEST
ALTER TABLE AD_ToolBarButtonRestrict MODIFY AD_Role_ID NULL
;

-- Mar 29, 2012 1:44:21 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=158, IsUpdateable='N',Updated=TO_DATE('2012-03-29 13:44:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200108
;

-- Mar 29, 2012 1:44:51 PM CEST
UPDATE AD_Column SET IsMandatory='N', IsUpdateable='N',Updated=TO_DATE('2012-03-29 13:44:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200105
;

-- Mar 29, 2012 1:44:53 PM CEST
ALTER TABLE AD_ToolBarButtonRestrict MODIFY Action CHAR(1) DEFAULT NULL 
;

-- Mar 29, 2012 1:44:53 PM CEST
ALTER TABLE AD_ToolBarButtonRestrict MODIFY Action NULL
;

-- Mar 29, 2012 1:45:01 PM CEST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_DATE('2012-03-29 13:45:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=200111
;

-- 05-abr-2012 0:19:55 COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_ToolBarButton SET ComponentName='Toggle',Updated=TO_DATE('2012-04-05 00:19:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200041
;

-- 05-abr-2012 0:20:01 COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_ToolBarButton SET ComponentName='HistoryRecords',Updated=TO_DATE('2012-04-05 00:20:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200042
;

-- 05-abr-2012 0:20:10 COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_ToolBarButton SET ComponentName='ParentRecord',Updated=TO_DATE('2012-04-05 00:20:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200043
;

-- 05-abr-2012 0:20:12 COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_ToolBarButton SET ComponentName='DetailRecord',Updated=TO_DATE('2012-04-05 00:20:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200044
;

-- 05-abr-2012 0:20:32 COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_ToolBarButton SET ComponentName='ActiveWorkflows',Updated=TO_DATE('2012-04-05 00:20:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200054
;

-- 05-abr-2012 0:20:35 COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_ToolBarButton SET ComponentName='Requests',Updated=TO_DATE('2012-04-05 00:20:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200055
;

-- 05-abr-2012 0:20:39 COT
-- IDEMPIERE-129 Restrictions on Toolbar and Menu
UPDATE AD_ToolBarButton SET ComponentName='ProductInfo',Updated=TO_DATE('2012-04-05 00:20:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200056
;

UPDATE AD_System
  SET LastMigrationScriptApplied='833_IDEMPIERE-129.sql'
WHERE LastMigrationScriptApplied<'833_IDEMPIERE-129.sql'
   OR LastMigrationScriptApplied IS NULL
;
