-- Apr 19, 2012 5:14:48 PM COT
-- IDEMPIERE-221 Password reset validation
INSERT INTO AD_Table (AccessLevel,AD_Client_ID,AD_Org_ID,AD_Table_ID,CopyColumnsFromTable,Created,CreatedBy,EntityType,ImportTable,IsActive,IsCentrallyMaintained,IsChangeLog,IsDeleteable,IsHighVolume,IsSecurityEnabled,IsView,LoadSeq,Name,ReplicationType,TableName,Updated,UpdatedBy) VALUES ('4',0,0,200005,'N',TO_DATE('2012-04-19 17:14:47','YYYY-MM-DD HH24:MI:SS'),0,'D','N','Y','Y','N','Y','N','N','N',0,'AD_PasswordRule','L','AD_PasswordRule',TO_DATE('2012-04-19 17:14:47','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:14:48 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Apr 19, 2012 5:14:49 PM COT
INSERT INTO AD_Sequence (AD_Client_ID,AD_Org_ID,AD_Sequence_ID,Created,CreatedBy,CurrentNext,CurrentNextSys,Description,IncrementNo,IsActive,IsAudited,IsAutoSequence,IsTableID,Name,StartNewYear,StartNo,Updated,UpdatedBy) VALUES (0,0,200006,TO_DATE('2012-04-19 17:14:48','YYYY-MM-DD HH24:MI:SS'),0,1000000,50000,'Table AD_PasswordRule',1,'Y','N','Y','Y','AD_PasswordRule','N',1000000,TO_DATE('2012-04-19 17:14:48','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:01 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200024,0,'AD_PasswordRule_ID',TO_DATE('2012-04-19 17:15:00','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','AD_PasswordRule','AD_PasswordRule',TO_DATE('2012-04-19 17:15:00','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:01 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200024 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:01 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200114,200005,'D',0,'Y','N','N','N','AD_PasswordRule',10,'N',13,'Y',200024,'AD_PasswordRule_ID','N','N','N',0,TO_DATE('2012-04-19 17:15:00','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:00','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:01 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200114 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:02 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200115,200005,'D',0,'Y','N','N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','N','Client/Tenant for this installation.','Client',10,'N',19,'N',102,'AD_Client_ID','N','N','N',0,TO_DATE('2012-04-19 17:15:01','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:01','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200115 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:02 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200116,200005,'D',0,'Y','N','N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','N','Organizational entity within client','Organization',10,'N',19,'N',113,'AD_Org_ID','N','N','N',0,TO_DATE('2012-04-19 17:15:02','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:02','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200116 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:02 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200117,200005,'D',0,'N','N','N','The Created field indicates the date that this record was created.','N','Date this record was created','Created',29,'N',16,'N',245,'Created','N','N','N',0,TO_DATE('2012-04-19 17:15:02','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:02','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200117 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:03 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200118,200005,'D',0,110,'Y','N','N','The Created By field indicates the user who created this record.','N','User who created this records','Created By',10,'N',18,'N',246,'CreatedBy','N','N','N',0,TO_DATE('2012-04-19 17:15:03','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:03','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200118 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:03 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200119,200005,'D',0,'N','N','N','The Updated field indicates the date that this record was updated.','N','Date this record was updated','Updated',29,'N',16,'N',607,'Updated','N','N','N',0,TO_DATE('2012-04-19 17:15:03','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:03','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200119 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:04 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200120,200005,'D',0,110,'N','N','N','The Updated By field indicates the user who updated this record.','N','User who updated this records','Updated By',10,'N',18,'N',608,'UpdatedBy','N','N','N',0,TO_DATE('2012-04-19 17:15:03','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:03','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200120 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:04 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200121,200005,'D',0,'N','N','N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','N','The record is active in the system','Active',1,'N',20,'N',348,'IsActive','N','Y','N',0,TO_DATE('2012-04-19 17:15:04','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:04','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200121 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:05 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200122,200005,'D',0,'N','N','N','N','Maximum Length of Data','Maximum Length',10,'N',11,'N',2812,'MaxLength','N','Y','N',0,TO_DATE('2012-04-19 17:15:04','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:04','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:05 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200122 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:06 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200025,0,'digitcharacter',TO_DATE('2012-04-19 17:15:05','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','digitcharacter','digitcharacter',TO_DATE('2012-04-19 17:15:05','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:06 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:06 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200124,200005,'D',0,'N','N','N','N','digitcharacter',10,'N',11,'N',200025,'digitcharacter','N','Y','N',0,TO_DATE('2012-04-19 17:15:05','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:05','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:06 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200124 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:08 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200026,0,'lowercasecharacter',TO_DATE('2012-04-19 17:15:07','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','lowercasecharacter','lowercasecharacter',TO_DATE('2012-04-19 17:15:07','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:08 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:08 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200127,200005,'D',0,'N','N','N','N','lowercasecharacter',10,'N',11,'N',200026,'lowercasecharacter','N','Y','N',0,TO_DATE('2012-04-19 17:15:07','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:07','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:08 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200127 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:08 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200027,0,'alphabeticalcharacter',TO_DATE('2012-04-19 17:15:08','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','alphabeticalcharacter','alphabeticalcharacter',TO_DATE('2012-04-19 17:15:08','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:08 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200027 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:09 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200128,200005,'D',0,'N','N','N','N','alphabeticalcharacter',10,'N',11,'N',200027,'alphabeticalcharacter','N','Y','N',0,TO_DATE('2012-04-19 17:15:08','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:08','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:09 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200128 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:10 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200028,0,'numericalsequence',TO_DATE('2012-04-19 17:15:09','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','numericalsequence','numericalsequence',TO_DATE('2012-04-19 17:15:09','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:10 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:10 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200130,200005,'D',0,'N','N','N','N','numericalsequence',10,'N',11,'N',200028,'numericalsequence','N','Y','N',0,TO_DATE('2012-04-19 17:15:09','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:09','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:10 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200130 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:11 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200029,0,'qwertysequence',TO_DATE('2012-04-19 17:15:10','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','qwertysequence','qwertysequence',TO_DATE('2012-04-19 17:15:10','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:11 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200029 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:11 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200131,200005,'D',0,'N','N','N','N','qwertysequence',1,'N',20,'N',200029,'qwertysequence','N','Y','N',0,TO_DATE('2012-04-19 17:15:10','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:10','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:11 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200131 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:12 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200030,0,'whitespace',TO_DATE('2012-04-19 17:15:12','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','whitespace','whitespace',TO_DATE('2012-04-19 17:15:12','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:12 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200030 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:13 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200133,200005,'D',0,'N','N','N','N','whitespace',1,'N',20,'N',200030,'whitespace','N','Y','N',0,TO_DATE('2012-04-19 17:15:12','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:12','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:13 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200133 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:13 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200134,200005,'D',0,'N','N','N','Email of the responsible person for the system (registered in WebStore)','N','Email of the responsible for the System','Registered EMail',1,'Y',20,'N',1903,'UserName','N','Y','N',0,TO_DATE('2012-04-19 17:15:13','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:13','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:13 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200134 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:14 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200031,0,'usingdictionary',TO_DATE('2012-04-19 17:15:13','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','usingdictionary','usingdictionary',TO_DATE('2012-04-19 17:15:13','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:14 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200031 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:14 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200135,200005,'D',0,'N','N','N','N','usingdictionary',1,'N',20,'N',200031,'usingdictionary','N','Y','N',0,TO_DATE('2012-04-19 17:15:13','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:13','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:14 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200135 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:15 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200032,0,'dictwordlength',TO_DATE('2012-04-19 17:15:14','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','dictwordlength','dictwordlength',TO_DATE('2012-04-19 17:15:14','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:15 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200032 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:15 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200137,200005,'D',0,'N','N','N','N','dictwordlength',10,'N',11,'N',200032,'dictwordlength','N','Y','N',0,TO_DATE('2012-04-19 17:15:14','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:14','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:15 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200137 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:15:16 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200033,0,'dictmatchbackwards',TO_DATE('2012-04-19 17:15:15','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','dictmatchbackwards','dictmatchbackwards',TO_DATE('2012-04-19 17:15:15','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:16 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200033 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Apr 19, 2012 5:15:16 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200138,200005,'D',0,'N','N','N','N','dictmatchbackwards',1,'N',20,'N',200033,'dictmatchbackwards','N','Y','N',0,TO_DATE('2012-04-19 17:15:15','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:15:15','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:15:16 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200138 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:18:00 PM COT
INSERT INTO AD_Window (AD_Client_ID,AD_Org_ID,AD_Window_ID,Created,CreatedBy,EntityType,IsActive,IsBetaFunctionality,IsDefault,IsSOTrx,Name,Processing,Updated,UpdatedBy,WindowType,WinHeight,WinWidth) VALUES (0,0,200002,TO_DATE('2012-04-19 17:17:59','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','N','N','N','Password Rule','N',TO_DATE('2012-04-19 17:17:59','YYYY-MM-DD HH24:MI:SS'),0,'M',0,0)
;

-- Apr 19, 2012 5:18:00 PM COT
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Window_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Apr 19, 2012 5:19:00 PM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,Name,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,AD_Tab_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,TabLevel,IsInsertRecord,IsAdvancedTab,EntityType,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,IsActive,UpdatedBy,Processing) VALUES ('Y',200002,'Password Rule',10,'N','N',200005,200004,'N','N','N','N',0,'Y','N','D',0,0,TO_DATE('2012-04-19 17:18:59','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-04-19 17:18:59','YYYY-MM-DD HH24:MI:SS'),'Y',0,'N')
;

-- Apr 19, 2012 5:19:00 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Name,Description,Help,CommitWarning, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Tab_ID, t.Name,t.Description,t.Help,t.CommitWarning, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200004 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Apr 19, 2012 5:19:07 PM COT
INSERT INTO AD_Field (IsEncrypted,Description,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N','The record is active in the system',1,'Active','Y','N','N',200121,'N','Y',200004,200074,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D',0,0,'Y',TO_DATE('2012-04-19 17:19:06','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:06','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:07 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200074 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:07 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'AD_PasswordRule','N','N','N',200114,'N','Y',200004,200075,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:07','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:07','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:07 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200075 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:08 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'alphabeticalcharacter','Y','N','N',200128,'N','Y',200004,200076,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:07','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:07','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:08 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200076 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:09 PM COT
INSERT INTO AD_Field (IsEncrypted,Description,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N','Client/Tenant for this installation.',10,'Client','Y','N','N',200115,'N','Y',200004,200078,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D',0,0,'Y',TO_DATE('2012-04-19 17:19:08','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:08','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:09 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200078 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:09 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'dictmatchbackwards','Y','N','N',200138,'N','Y',200004,200079,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:09','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:09','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:09 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200079 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:10 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'dictwordlength','Y','N','N',200137,'N','Y',200004,200080,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:09','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:09','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:10 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200080 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:10 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'digitcharacter','Y','N','N',200124,'N','Y',200004,200081,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:10','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:10 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200081 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:10 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'lowercasecharacter','Y','N','N',200127,'N','Y',200004,200082,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:10','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:10 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200082 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:11 PM COT
INSERT INTO AD_Field (IsEncrypted,Description,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N','Maximum Length of Data',10,'Maximum Length','Y','N','N',200122,'N','Y',200004,200083,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:10','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:10','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:11 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200083 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:12 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'numericalsequence','Y','N','N',200130,'N','Y',200004,200086,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:12','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:12','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:12 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200086 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:13 PM COT
INSERT INTO AD_Field (IsEncrypted,Description,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N','Organizational entity within client',10,'Organization','Y','N','N',200116,'N','Y',200004,200087,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D',0,0,'Y',TO_DATE('2012-04-19 17:19:12','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:12','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:13 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200087 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:14 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'qwertysequence','Y','N','N',200131,'N','Y',200004,200089,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:13','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:14 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200089 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:14 PM COT
INSERT INTO AD_Field (IsEncrypted,Description,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N','Email of the responsible for the System',1,'Registered EMail','Y','N','N',200134,'N','Y',200004,200090,'N','Email of the responsible person for the system (registered in WebStore)','D',0,0,'Y',TO_DATE('2012-04-19 17:19:14','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:14','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:14 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200090 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:15 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'usingdictionary','Y','N','N',200135,'N','Y',200004,200093,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:15','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:15 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200093 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:19:16 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'whitespace','Y','N','N',200133,'N','Y',200004,200094,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:19:15','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:19:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:19:16 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200094 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200090
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200078
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200087
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200074
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200083
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200084
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200077
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200076
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200081
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200085
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200092
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200082
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200086
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200089
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200091
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200094
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200093
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200088
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200079
;

-- Apr 19, 2012 5:24:35 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200080
;

-- Apr 19, 2012 5:31:33 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,Help,IsParent,Description,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200139,200005,'D',0,'N','N','Y',1,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','N','Alphanumeric identifier of the entity','Name',60,'Y',10,'N',469,'Name','N','Y','N',0,TO_DATE('2012-04-19 17:31:33','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:31:33','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:31:33 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200139 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:31:44 PM COT
INSERT INTO AD_Field (IsEncrypted,Description,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,Help,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N','Alphanumeric identifier of the entity',60,'Name','Y','N','N',200139,'N','Y',200004,200095,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D',0,0,'Y',TO_DATE('2012-04-19 17:31:44','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:31:44','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:31:44 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200095 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200095
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200074
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200083
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200084
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200077
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200076
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200081
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200085
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200092
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200082
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200086
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200089
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200091
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200094
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200093
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200088
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200079
;

-- Apr 19, 2012 5:32:03 PM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200080
;

-- Apr 19, 2012 5:34:56 PM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,Name,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200140,112,'D',0,'N','N','N','N','AD_PasswordRule',10,'N',19,'N',200024,'AD_PasswordRule_ID','N','Y','N',0,TO_DATE('2012-04-19 17:34:55','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-04-19 17:34:55','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:34:56 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200140 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Apr 19, 2012 5:35:11 PM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'AD_PasswordRule','Y','N','N',200140,'N','Y',145,200096,'N','D',0,0,'Y',TO_DATE('2012-04-19 17:35:11','YYYY-MM-DD HH24:MI:SS'),0,0,TO_DATE('2012-04-19 17:35:11','YYYY-MM-DD HH24:MI:SS'))
;

-- Apr 19, 2012 5:35:11 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Description,Name,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Description,t.Name,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200096 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Apr 19, 2012 5:38:59 PM COT
INSERT INTO AD_Menu (Action,AD_Client_ID,AD_Menu_ID,AD_Org_ID,AD_Window_ID,Created,CreatedBy,EntityType,IsActive,IsCentrallyMaintained,IsReadOnly,IsSOTrx,IsSummary,Name,Updated,UpdatedBy) VALUES ('W',0,200002,0,200002,TO_DATE('2012-04-19 17:38:58','YYYY-MM-DD HH24:MI:SS'),0,'D','Y','Y','N','N','N','Password Rule',TO_DATE('2012-04-19 17:38:58','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 19, 2012 5:38:59 PM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Menu_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Apr 19, 2012 5:38:59 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 0, SysDate, 0,t.AD_Tree_ID, 200002, 0, 999 FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200002)
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200002
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=147
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53246
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=487
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=150
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=495
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50007
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=362
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Apr 19, 2012 5:40:41 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Apr 19, 2012 5:42:41 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200091
;

-- Apr 19, 2012 5:42:41 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200089
;

-- Apr 24, 2012 4:40:57 PM COT
INSERT INTO AD_Process_Para (AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy) VALUES (0,1896,0,288,200005,10,'NewEMailConfirm',TO_DATE('2012-04-24 16:40:56','YYYY-MM-DD HH24:MI:SS'),0,'D',30,'Y','Y','N','N','New EMail Confirm',45,TO_DATE('2012-04-24 16:40:56','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 24, 2012 4:40:57 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;


-- Apr 25, 2012 10:58:47 AM COT
UPDATE AD_Field SET Name='Min Lenght',Updated=TO_DATE('2012-04-25 10:58:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200084
;

-- Apr 25, 2012 10:58:47 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200084
;

-- Apr 25, 2012 10:59:03 AM COT
UPDATE AD_Field SET Name='Alphabetical Sequence ',Updated=TO_DATE('2012-04-25 10:59:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200077
;

-- Apr 25, 2012 10:59:03 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200077
;

-- Apr 25, 2012 10:59:44 AM COT
UPDATE AD_Field SET Name='Alphabetical Character',Updated=TO_DATE('2012-04-25 10:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200076
;

-- Apr 25, 2012 10:59:44 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200076
;

-- Apr 25, 2012 10:59:53 AM COT
UPDATE AD_Field SET Name='Digit Character',Updated=TO_DATE('2012-04-25 10:59:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200081
;

-- Apr 25, 2012 10:59:53 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200081
;

-- Apr 25, 2012 11:00:08 AM COT
UPDATE AD_Field SET Name='Non Alphanumeric Character',Updated=TO_DATE('2012-04-25 11:00:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200085
;

-- Apr 25, 2012 11:00:08 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200085
;

-- Apr 25, 2012 11:00:22 AM COT
UPDATE AD_Field SET Name='Upper Case Character',Updated=TO_DATE('2012-04-25 11:00:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200092
;

-- Apr 25, 2012 11:00:22 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200092
;

-- Apr 25, 2012 11:00:35 AM COT
UPDATE AD_Field SET Name='Lower Case Character',Updated=TO_DATE('2012-04-25 11:00:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200082
;

-- Apr 25, 2012 11:00:35 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200082
;

-- Apr 25, 2012 11:01:43 AM COT
UPDATE AD_Field SET Name='Numerical Sequence',Updated=TO_DATE('2012-04-25 11:01:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200086
;

-- Apr 25, 2012 11:01:43 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200086
;

-- Apr 25, 2012 11:01:58 AM COT
UPDATE AD_Field SET Name='Repeat Character Regex',Updated=TO_DATE('2012-04-25 11:01:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200091
;

-- Apr 25, 2012 11:01:58 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200091
;

-- Apr 25, 2012 11:02:09 AM COT
UPDATE AD_Field SET Name='Qwerty Sequence',Updated=TO_DATE('2012-04-25 11:02:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200089
;

-- Apr 25, 2012 11:02:09 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200089
;

-- Apr 25, 2012 11:02:17 AM COT
UPDATE AD_Field SET Name='Whitespace',Updated=TO_DATE('2012-04-25 11:02:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200094
;

-- Apr 25, 2012 11:02:17 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200094
;

-- Apr 25, 2012 11:02:28 AM COT
UPDATE AD_Field SET Name='Using Dictionary',Updated=TO_DATE('2012-04-25 11:02:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200093
;

-- Apr 25, 2012 11:02:28 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200093
;

-- Apr 25, 2012 11:02:38 AM COT
UPDATE AD_Field SET Name='Path Dictionary',Updated=TO_DATE('2012-04-25 11:02:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200088
;

-- Apr 25, 2012 11:02:38 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200088
;

-- Apr 25, 2012 11:02:55 AM COT
UPDATE AD_Field SET Name='Match Backwards of Dictionary',Updated=TO_DATE('2012-04-25 11:02:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200079
;

-- Apr 25, 2012 11:02:55 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200079
;

-- Apr 25, 2012 11:03:10 AM COT
UPDATE AD_Field SET Name='Word Length Dictionary',Updated=TO_DATE('2012-04-25 11:03:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200080
;

-- Apr 25, 2012 11:03:10 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200080
;

-- Apr 25, 2012 11:04:35 AM COT
UPDATE AD_Field SET Description='Allow alphabetical sequences',Updated=TO_DATE('2012-04-25 11:04:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200077
;

-- Apr 25, 2012 11:04:35 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200077
;

-- Apr 25, 2012 11:05:30 AM COT
UPDATE AD_Field SET Description='require at least # digit in passwords',Updated=TO_DATE('2012-04-25 11:05:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200081
;

-- Apr 25, 2012 11:05:30 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200081
;

-- Apr 25, 2012 11:05:46 AM COT
UPDATE AD_Field SET Description='require at least # non-alphanumeric char',Updated=TO_DATE('2012-04-25 11:05:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200085
;

-- Apr 25, 2012 11:05:46 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200085
;

-- Apr 25, 2012 11:07:29 AM COT
UPDATE AD_Field SET Description='require at least # upper case char',Updated=TO_DATE('2012-04-25 11:07:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200092
;

-- Apr 25, 2012 11:07:29 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200092
;

-- Apr 25, 2012 11:07:49 AM COT
UPDATE AD_Field SET Description='equire at least # lower case char',Updated=TO_DATE('2012-04-25 11:07:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200082
;

-- Apr 25, 2012 11:07:49 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200082
;

-- Apr 25, 2012 11:08:06 AM COT
UPDATE AD_Field SET Description='allow numerical sequences of length #',Updated=TO_DATE('2012-04-25 11:08:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200086
;

-- Apr 25, 2012 11:08:06 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200086
;

-- Apr 25, 2012 11:08:29 AM COT
UPDATE AD_Field SET Description='allow # repeat characters',Updated=TO_DATE('2012-04-25 11:08:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200091
;

-- Apr 25, 2012 11:08:29 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200091
;

-- Apr 25, 2012 11:08:48 AM COT
UPDATE AD_Field SET Description='allow qwerty sequences',Updated=TO_DATE('2012-04-25 11:08:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200089
;

-- Apr 25, 2012 11:08:48 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200089
;

-- Apr 25, 2012 11:09:02 AM COT
UPDATE AD_Field SET Description='allow whitespace',Updated=TO_DATE('2012-04-25 11:09:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200094
;

-- Apr 25, 2012 11:09:02 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200094
;

-- Apr 25, 2012 11:09:12 AM COT
UPDATE AD_Field SET Description='use dictionary',Updated=TO_DATE('2012-04-25 11:09:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200093
;

-- Apr 25, 2012 11:09:12 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200093
;

-- Apr 25, 2012 11:09:36 AM COT
UPDATE AD_Field SET Description='match dictionary words backwards',Updated=TO_DATE('2012-04-25 11:09:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200079
;

-- Apr 25, 2012 11:09:36 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200079
;

-- Apr 25, 2012 11:09:47 AM COT
UPDATE AD_Field SET Description='size of words to check in the password',Updated=TO_DATE('2012-04-25 11:09:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200080
;

-- Apr 25, 2012 11:09:48 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200080
;

-- Apr 25, 2012 11:10:02 AM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200077
;

-- Apr 25, 2012 11:10:02 AM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200083
;

-- Apr 25, 2012 11:10:02 AM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200084
;

-- Jul 31, 2012 5:29:01 PM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200064,0,'NewPasswordConfirm',TO_DATE('2012-07-31 17:29:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','NewPasswordConfirm','NewPasswordConfirm',TO_DATE('2012-07-31 17:29:00','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 31, 2012 5:29:01 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200064 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jul 31, 2012 5:29:42 PM COT
UPDATE AD_Element SET PrintName='New Password Confirm',Updated=TO_DATE('2012-07-31 17:29:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200064
;

-- Jul 31, 2012 5:29:42 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200064
;

-- Jul 31, 2012 5:29:42 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='New Password Confirm', Name='NewPasswordConfirm' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200064)
;

-- Jul 31, 2012 5:30:17 PM COT
INSERT INTO AD_Process_Para (AD_Client_ID,AD_Element_ID,AD_Org_ID,AD_Process_ID,AD_Process_Para_ID,AD_Reference_ID,ColumnName,Created,CreatedBy,EntityType,FieldLength,IsActive,IsCentrallyMaintained,IsEncrypted,IsMandatory,IsRange,Name,SeqNo,Updated,UpdatedBy) VALUES (0,200064,0,288,200028,10,'NewPasswordConfirm',TO_DATE('2012-07-31 17:30:17','YYYY-MM-DD HH24:MI:SS'),100,'D',0,'Y','Y','N','N','N','NewPasswordConfirm',35,TO_DATE('2012-07-31 17:30:17','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jul 31, 2012 5:30:17 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Description,Help,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Description,t.Help,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Aug 1, 2012 11:45:53 AM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200065,0,'minlength',TO_DATE('2012-08-01 11:45:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','minlength','minlength',TO_DATE('2012-08-01 11:45:51','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:53 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200065 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 1, 2012 11:45:53 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,Name,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200233,200005,'D',0,'N','N','N','N',10,'N','minlength',11,'N',200065,'minlength','N','Y','N',100,TO_DATE('2012-08-01 11:45:51','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-08-01 11:45:51','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:53 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200233 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 1, 2012 11:45:54 AM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200066,0,'nonalphanumericcharacter',TO_DATE('2012-08-01 11:45:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','nonalphanumericcharacter','nonalphanumericcharacter',TO_DATE('2012-08-01 11:45:53','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:54 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 1, 2012 11:45:54 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,Name,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200234,200005,'D',0,'N','N','N','N',10,'N','nonalphanumericcharacter',11,'N',200066,'nonalphanumericcharacter','N','Y','N',100,TO_DATE('2012-08-01 11:45:53','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-08-01 11:45:53','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:54 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200234 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 1, 2012 11:45:55 AM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200067,0,'uppercasecharacter',TO_DATE('2012-08-01 11:45:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','uppercasecharacter','uppercasecharacter',TO_DATE('2012-08-01 11:45:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:55 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 1, 2012 11:45:55 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,Name,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200235,200005,'D',0,'N','N','N','N',10,'N','uppercasecharacter',11,'N',200067,'uppercasecharacter','N','Y','N',100,TO_DATE('2012-08-01 11:45:54','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-08-01 11:45:54','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:55 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200235 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 1, 2012 11:45:56 AM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200068,0,'alphabeticalsequence',TO_DATE('2012-08-01 11:45:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','alphabeticalsequence','alphabeticalsequence',TO_DATE('2012-08-01 11:45:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:56 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 1, 2012 11:45:56 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,Name,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200236,200005,'D',0,'N','N','N','N',1,'N','alphabeticalsequence',20,'N',200068,'alphabeticalsequence','N','Y','N',100,TO_DATE('2012-08-01 11:45:55','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-08-01 11:45:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:56 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200236 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 1, 2012 11:45:56 AM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200069,0,'repeatcharacterregex',TO_DATE('2012-08-01 11:45:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','repeatcharacterregex','repeatcharacterregex',TO_DATE('2012-08-01 11:45:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:56 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 1, 2012 11:45:57 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,Name,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200237,200005,'D',0,'N','N','N','N',10,'N','repeatcharacterregex',11,'N',200069,'repeatcharacterregex','N','Y','N',100,TO_DATE('2012-08-01 11:45:56','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-08-01 11:45:56','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:57 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200237 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 1, 2012 11:45:57 AM COT
INSERT INTO AD_Element (AD_Client_ID,AD_Element_ID,AD_Org_ID,ColumnName,Created,CreatedBy,EntityType,IsActive,Name,PrintName,Updated,UpdatedBy) VALUES (0,200070,0,'pathdictionary',TO_DATE('2012-08-01 11:45:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','pathdictionary','pathdictionary',TO_DATE('2012-08-01 11:45:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:57 AM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Description,Help,Name,PO_Description,PO_Help,PO_Name,PO_PrintName,PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Element_ID, t.Description,t.Help,t.Name,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName,t.PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 1, 2012 11:45:58 AM COT
INSERT INTO AD_Column (AD_Column_ID,AD_Table_ID,EntityType,Version,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,Name,AD_Reference_ID,IsKey,AD_Element_ID,ColumnName,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,IsActive,Created,UpdatedBy) VALUES (200238,200005,'D',0,'N','N','N','N',60,'N','pathdictionary',10,'N',200070,'pathdictionary','N','Y','N',100,TO_DATE('2012-08-01 11:45:57','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',TO_DATE('2012-08-01 11:45:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Aug 1, 2012 11:45:58 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200238 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 1, 2012 11:46:41 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',1,'alphabeticalsequence','Y','N','N',200236,'N','Y',200004,200251,'N','D',100,0,'Y',TO_DATE('2012-08-01 11:46:40','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-01 11:46:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 1, 2012 11:46:41 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200251 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2012 11:46:42 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'minlength','Y','N','N',200233,'N','Y',200004,200252,'N','D',100,0,'Y',TO_DATE('2012-08-01 11:46:41','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-01 11:46:41','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 1, 2012 11:46:42 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200252 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2012 11:46:42 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'nonalphanumericcharacter','Y','N','N',200234,'N','Y',200004,200253,'N','D',100,0,'Y',TO_DATE('2012-08-01 11:46:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-01 11:46:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 1, 2012 11:46:42 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200253 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2012 11:46:43 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',60,'pathdictionary','Y','N','N',200238,'N','Y',200004,200254,'N','D',100,0,'Y',TO_DATE('2012-08-01 11:46:42','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-01 11:46:42','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 1, 2012 11:46:43 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200254 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2012 11:46:43 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'repeatcharacterregex','Y','N','N',200237,'N','Y',200004,200255,'N','D',100,0,'Y',TO_DATE('2012-08-01 11:46:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-01 11:46:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 1, 2012 11:46:43 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200255 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2012 11:46:44 AM COT
INSERT INTO AD_Field (IsEncrypted,DisplayLength,Name,IsDisplayed,IsSameLine,IsHeading,AD_Column_ID,IsFieldOnly,IsCentrallyMaintained,AD_Tab_ID,AD_Field_ID,IsReadOnly,EntityType,UpdatedBy,AD_Org_ID,IsActive,Created,AD_Client_ID,CreatedBy,Updated) VALUES ('N',10,'uppercasecharacter','Y','N','N',200235,'N','Y',200004,200256,'N','D',100,0,'Y',TO_DATE('2012-08-01 11:46:43','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-08-01 11:46:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 1, 2012 11:46:44 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200256 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200083
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200252
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200076
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200081
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200082
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200253
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200255
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200256
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200089
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200094
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200093
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200254
;

-- Aug 1, 2012 11:49:05 AM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200079
;

-- Aug 1, 2012 11:49:06 AM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200080
;

-- Aug 1, 2012 11:49:06 AM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200251
;

-- Aug 1, 2012 11:49:23 AM COT
UPDATE AD_Field SET Name='Min Length',Updated=TO_DATE('2012-08-01 11:49:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200252
;

-- Aug 1, 2012 11:49:23 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200252
;

-- Aug 1, 2012 11:49:50 AM COT
UPDATE AD_Field SET Name='Non AlphaNumeric Character',Updated=TO_DATE('2012-08-01 11:49:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200253
;

-- Aug 1, 2012 11:49:50 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200253
;

-- Aug 1, 2012 11:53:10 AM COT
UPDATE AD_Field SET Name='Repeat Character Regex',Updated=TO_DATE('2012-08-01 11:53:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200255
;

-- Aug 1, 2012 11:53:10 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200255
;

-- Aug 1, 2012 11:53:21 AM COT
UPDATE AD_Field SET Name='Upper Case Character',Updated=TO_DATE('2012-08-01 11:53:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200256
;

-- Aug 1, 2012 11:53:21 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200256
;

-- Aug 1, 2012 11:54:28 AM COT
UPDATE AD_Field SET Name='Path Dictionary',Updated=TO_DATE('2012-08-01 11:54:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200254
;

-- Aug 1, 2012 11:54:28 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200254
;

-- Aug 1, 2012 11:54:41 AM COT
UPDATE AD_Field SET Name='Alphabetical Sequence',Updated=TO_DATE('2012-08-01 11:54:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200251
;

-- Aug 1, 2012 11:54:41 AM COT
UPDATE AD_Field_Trl SET IsTranslated='N' WHERE AD_Field_ID=200251
;

-- Aug 1, 2012 11:58:34 AM COT
UPDATE AD_Process_Para SET IsEncrypted='Y',Updated=TO_DATE('2012-08-01 11:58:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200028
;

-- Aug 2, 2012 4:44:50 PM COT
ALTER TABLE AD_Client ADD AD_PasswordRule_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 2, 2012 5:10:39 PM COT
UPDATE AD_Element SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description='Allow alphabetical sequences', PrintName='Alphabetical Character',Updated=TO_DATE('2012-08-02 17:10:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200027
;

-- Aug 2, 2012 5:10:39 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200027
;

-- Aug 2, 2012 5:10:39 PM COT
UPDATE AD_Column SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description='Allow alphabetical sequences', Help=NULL WHERE AD_Element_ID=200027
;

-- Aug 2, 2012 5:10:39 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description='Allow alphabetical sequences', Help=NULL, AD_Element_ID=200027 WHERE UPPER(ColumnName)='ALPHABETICALCHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:10:39 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description='Allow alphabetical sequences', Help=NULL WHERE AD_Element_ID=200027 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:10:39 PM COT
UPDATE AD_Field SET Name='Alphabetical Character', Description='Allow alphabetical sequences', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200027) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:10:39 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Alphabetical Character', Name='Alphabetical Character' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200027)
;

-- Aug 2, 2012 5:11:44 PM COT
UPDATE AD_Element SET Description=NULL,Updated=TO_DATE('2012-08-02 17:11:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200027
;

-- Aug 2, 2012 5:11:44 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200027
;

-- Aug 2, 2012 5:11:44 PM COT
UPDATE AD_Column SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200027
;

-- Aug 2, 2012 5:11:44 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description=NULL, Help=NULL, AD_Element_ID=200027 WHERE UPPER(ColumnName)='ALPHABETICALCHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:11:44 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalCharacter', Name='Alphabetical Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200027 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:11:44 PM COT
UPDATE AD_Field SET Name='Alphabetical Character', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200027) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:12:13 PM COT
UPDATE AD_Element SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Allow alphabetical sequences', PrintName='Alphabetical Sequence',Updated=TO_DATE('2012-08-02 17:12:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200068
;

-- Aug 2, 2012 5:12:13 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200068
;

-- Aug 2, 2012 5:12:13 PM COT
UPDATE AD_Column SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Allow alphabetical sequences', Help=NULL WHERE AD_Element_ID=200068
;

-- Aug 2, 2012 5:12:13 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Allow alphabetical sequences', Help=NULL, AD_Element_ID=200068 WHERE UPPER(ColumnName)='ALPHABETICALSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:12:13 PM COT
UPDATE AD_Process_Para SET ColumnName='AlphabeticalSequence', Name='Alphabetical Sequence', Description='Allow alphabetical sequences', Help=NULL WHERE AD_Element_ID=200068 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:12:13 PM COT
UPDATE AD_Field SET Name='Alphabetical Sequence', Description='Allow alphabetical sequences', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200068) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:12:13 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Alphabetical Sequence', Name='Alphabetical Sequence' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200068)
;

-- Aug 2, 2012 5:12:49 PM COT
UPDATE AD_Element SET ColumnName='DictMatchBackwards', Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', PrintName='Match Backwards of Dictionary',Updated=TO_DATE('2012-08-02 17:12:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200033
;

-- Aug 2, 2012 5:12:49 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200033
;

-- Aug 2, 2012 5:12:49 PM COT
UPDATE AD_Column SET ColumnName='DictMatchBackwards', Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', Help=NULL WHERE AD_Element_ID=200033
;

-- Aug 2, 2012 5:12:49 PM COT
UPDATE AD_Process_Para SET ColumnName='DictMatchBackwards', Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', Help=NULL, AD_Element_ID=200033 WHERE UPPER(ColumnName)='DICTMATCHBACKWARDS' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:12:49 PM COT
UPDATE AD_Process_Para SET ColumnName='DictMatchBackwards', Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', Help=NULL WHERE AD_Element_ID=200033 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:12:49 PM COT
UPDATE AD_Field SET Name='Match Backwards of Dictionary', Description='Match dictionary words backwards', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200033) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:12:49 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Match Backwards of Dictionary', Name='Match Backwards of Dictionary' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200033)
;

-- Aug 2, 2012 5:13:26 PM COT
UPDATE AD_Element SET ColumnName='DictWordLength', Name='Word Length Dictionary', PrintName='Word Length Dictionary',Updated=TO_DATE('2012-08-02 17:13:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200032
;

-- Aug 2, 2012 5:13:26 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200032
;

-- Aug 2, 2012 5:13:26 PM COT
UPDATE AD_Column SET ColumnName='DictWordLength', Name='Word Length Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200032
;

-- Aug 2, 2012 5:13:26 PM COT
UPDATE AD_Process_Para SET ColumnName='DictWordLength', Name='Word Length Dictionary', Description=NULL, Help=NULL, AD_Element_ID=200032 WHERE UPPER(ColumnName)='DICTWORDLENGTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:13:26 PM COT
UPDATE AD_Process_Para SET ColumnName='DictWordLength', Name='Word Length Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200032 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:13:26 PM COT
UPDATE AD_Field SET Name='Word Length Dictionary', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200032) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:13:26 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Word Length Dictionary', Name='Word Length Dictionary' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200032)
;

-- Aug 2, 2012 5:13:50 PM COT
UPDATE AD_Element SET ColumnName='DigitCharacter', Name='Digit Character', PrintName='Digit Character',Updated=TO_DATE('2012-08-02 17:13:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200025
;

-- Aug 2, 2012 5:13:50 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200025
;

-- Aug 2, 2012 5:13:50 PM COT
UPDATE AD_Column SET ColumnName='DigitCharacter', Name='Digit Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200025
;

-- Aug 2, 2012 5:13:50 PM COT
UPDATE AD_Process_Para SET ColumnName='DigitCharacter', Name='Digit Character', Description=NULL, Help=NULL, AD_Element_ID=200025 WHERE UPPER(ColumnName)='DIGITCHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:13:50 PM COT
UPDATE AD_Process_Para SET ColumnName='DigitCharacter', Name='Digit Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200025 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:13:50 PM COT
UPDATE AD_Field SET Name='Digit Character', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200025) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:13:50 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Digit Character', Name='Digit Character' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200025)
;

-- Aug 2, 2012 5:14:09 PM COT
UPDATE AD_Element SET Description='Require at least # digit in passwords',Updated=TO_DATE('2012-08-02 17:14:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200025
;

-- Aug 2, 2012 5:14:09 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200025
;

-- Aug 2, 2012 5:14:09 PM COT
UPDATE AD_Column SET ColumnName='DigitCharacter', Name='Digit Character', Description='Require at least # digit in passwords', Help=NULL WHERE AD_Element_ID=200025
;

-- Aug 2, 2012 5:14:09 PM COT
UPDATE AD_Process_Para SET ColumnName='DigitCharacter', Name='Digit Character', Description='Require at least # digit in passwords', Help=NULL, AD_Element_ID=200025 WHERE UPPER(ColumnName)='DIGITCHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:14:09 PM COT
UPDATE AD_Process_Para SET ColumnName='DigitCharacter', Name='Digit Character', Description='Require at least # digit in passwords', Help=NULL WHERE AD_Element_ID=200025 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:14:09 PM COT
UPDATE AD_Field SET Name='Digit Character', Description='Require at least # digit in passwords', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200025) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:14:48 PM COT
UPDATE AD_Element SET ColumnName='LowercaseCharacter', Name='Lowercase Character', Description='Require at least # lower case char', PrintName='Lowercase Character',Updated=TO_DATE('2012-08-02 17:14:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200026
;

-- Aug 2, 2012 5:14:48 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200026
;

-- Aug 2, 2012 5:14:48 PM COT
UPDATE AD_Column SET ColumnName='LowercaseCharacter', Name='Lowercase Character', Description='Require at least # lower case char', Help=NULL WHERE AD_Element_ID=200026
;

-- Aug 2, 2012 5:14:48 PM COT
UPDATE AD_Process_Para SET ColumnName='LowercaseCharacter', Name='Lowercase Character', Description='Require at least # lower case char', Help=NULL, AD_Element_ID=200026 WHERE UPPER(ColumnName)='LOWERCASECHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:14:48 PM COT
UPDATE AD_Process_Para SET ColumnName='LowercaseCharacter', Name='Lowercase Character', Description='Require at least # lower case char', Help=NULL WHERE AD_Element_ID=200026 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:14:48 PM COT
UPDATE AD_Field SET Name='Lowercase Character', Description='Require at least # lower case char', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200026) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:14:48 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Lowercase Character', Name='Lowercase Character' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200026)
;

-- Aug 2, 2012 5:15:01 PM COT
UPDATE AD_Element SET ColumnName='MinLength', Name='Min Length', PrintName='Min Length',Updated=TO_DATE('2012-08-02 17:15:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200065
;

-- Aug 2, 2012 5:15:01 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200065
;

-- Aug 2, 2012 5:15:01 PM COT
UPDATE AD_Column SET ColumnName='MinLength', Name='Min Length', Description=NULL, Help=NULL WHERE AD_Element_ID=200065
;

-- Aug 2, 2012 5:15:01 PM COT
UPDATE AD_Process_Para SET ColumnName='MinLength', Name='Min Length', Description=NULL, Help=NULL, AD_Element_ID=200065 WHERE UPPER(ColumnName)='MINLENGTH' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:15:01 PM COT
UPDATE AD_Process_Para SET ColumnName='MinLength', Name='Min Length', Description=NULL, Help=NULL WHERE AD_Element_ID=200065 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:01 PM COT
UPDATE AD_Field SET Name='Min Length', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200065) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:01 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Min Length', Name='Min Length' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200065)
;

-- Aug 2, 2012 5:15:20 PM COT
UPDATE AD_Element SET ColumnName='NonAlphaNumericCharacter', Name='Non Alpha Numeric Character', PrintName='Non Alpha Numeric Character',Updated=TO_DATE('2012-08-02 17:15:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200066
;

-- Aug 2, 2012 5:15:20 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200066
;

-- Aug 2, 2012 5:15:20 PM COT
UPDATE AD_Column SET ColumnName='NonAlphaNumericCharacter', Name='Non Alpha Numeric Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200066
;

-- Aug 2, 2012 5:15:20 PM COT
UPDATE AD_Process_Para SET ColumnName='NonAlphaNumericCharacter', Name='Non Alpha Numeric Character', Description=NULL, Help=NULL, AD_Element_ID=200066 WHERE UPPER(ColumnName)='NONALPHANUMERICCHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:15:20 PM COT
UPDATE AD_Process_Para SET ColumnName='NonAlphaNumericCharacter', Name='Non Alpha Numeric Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200066 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:20 PM COT
UPDATE AD_Field SET Name='Non Alpha Numeric Character', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200066) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:20 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Non Alpha Numeric Character', Name='Non Alpha Numeric Character' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200066)
;

-- Aug 2, 2012 5:15:33 PM COT
UPDATE AD_Element SET Description='Require at least # non-alphanumeric char',Updated=TO_DATE('2012-08-02 17:15:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200066
;

-- Aug 2, 2012 5:15:33 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200066
;

-- Aug 2, 2012 5:15:33 PM COT
UPDATE AD_Column SET ColumnName='NonAlphaNumericCharacter', Name='Non Alpha Numeric Character', Description='Require at least # non-alphanumeric char', Help=NULL WHERE AD_Element_ID=200066
;

-- Aug 2, 2012 5:15:33 PM COT
UPDATE AD_Process_Para SET ColumnName='NonAlphaNumericCharacter', Name='Non Alpha Numeric Character', Description='Require at least # non-alphanumeric char', Help=NULL, AD_Element_ID=200066 WHERE UPPER(ColumnName)='NONALPHANUMERICCHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:15:33 PM COT
UPDATE AD_Process_Para SET ColumnName='NonAlphaNumericCharacter', Name='Non Alpha Numeric Character', Description='Require at least # non-alphanumeric char', Help=NULL WHERE AD_Element_ID=200066 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:33 PM COT
UPDATE AD_Field SET Name='Non Alpha Numeric Character', Description='Require at least # non-alphanumeric char', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200066) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:49 PM COT
UPDATE AD_Element SET ColumnName='NumericalSequence', Name='Numerical Sequence', PrintName='Numerical Sequence',Updated=TO_DATE('2012-08-02 17:15:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200028
;

-- Aug 2, 2012 5:15:49 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200028
;

-- Aug 2, 2012 5:15:49 PM COT
UPDATE AD_Column SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description=NULL, Help=NULL WHERE AD_Element_ID=200028
;

-- Aug 2, 2012 5:15:49 PM COT
UPDATE AD_Process_Para SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description=NULL, Help=NULL, AD_Element_ID=200028 WHERE UPPER(ColumnName)='NUMERICALSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:15:49 PM COT
UPDATE AD_Process_Para SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description=NULL, Help=NULL WHERE AD_Element_ID=200028 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:49 PM COT
UPDATE AD_Field SET Name='Numerical Sequence', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200028) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:15:49 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Numerical Sequence', Name='Numerical Sequence' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200028)
;

-- Aug 2, 2012 5:16:10 PM COT
UPDATE AD_Element SET Description='Allow numerical sequences of length #',Updated=TO_DATE('2012-08-02 17:16:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200028
;

-- Aug 2, 2012 5:16:10 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200028
;

-- Aug 2, 2012 5:16:10 PM COT
UPDATE AD_Column SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description='Allow numerical sequences of length #', Help=NULL WHERE AD_Element_ID=200028
;

-- Aug 2, 2012 5:16:10 PM COT
UPDATE AD_Process_Para SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description='Allow numerical sequences of length #', Help=NULL, AD_Element_ID=200028 WHERE UPPER(ColumnName)='NUMERICALSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:16:10 PM COT
UPDATE AD_Process_Para SET ColumnName='NumericalSequence', Name='Numerical Sequence', Description='Allow numerical sequences of length #', Help=NULL WHERE AD_Element_ID=200028 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:16:10 PM COT
UPDATE AD_Field SET Name='Numerical Sequence', Description='Allow numerical sequences of length #', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200028) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:16:35 PM COT
UPDATE AD_Element SET ColumnName='PathDictionary', Name='Path Dictionary', PrintName='Path Dictionary',Updated=TO_DATE('2012-08-02 17:16:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200070
;

-- Aug 2, 2012 5:16:35 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200070
;

-- Aug 2, 2012 5:16:35 PM COT
UPDATE AD_Column SET ColumnName='PathDictionary', Name='Path Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200070
;

-- Aug 2, 2012 5:16:35 PM COT
UPDATE AD_Process_Para SET ColumnName='PathDictionary', Name='Path Dictionary', Description=NULL, Help=NULL, AD_Element_ID=200070 WHERE UPPER(ColumnName)='PATHDICTIONARY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:16:35 PM COT
UPDATE AD_Process_Para SET ColumnName='PathDictionary', Name='Path Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200070 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:16:35 PM COT
UPDATE AD_Field SET Name='Path Dictionary', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200070) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:16:35 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Path Dictionary', Name='Path Dictionary' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200070)
;

-- Aug 2, 2012 5:16:44 PM COT
UPDATE AD_Column SET AD_Reference_ID=39,Updated=TO_DATE('2012-08-02 17:16:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200238
;

-- Aug 2, 2012 5:17:39 PM COT
UPDATE AD_Element SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Allow qwerty sequences', PrintName='QWERTY Sequence',Updated=TO_DATE('2012-08-02 17:17:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200029
;

-- Aug 2, 2012 5:17:39 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200029
;

-- Aug 2, 2012 5:17:39 PM COT
UPDATE AD_Column SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Allow qwerty sequences', Help=NULL WHERE AD_Element_ID=200029
;

-- Aug 2, 2012 5:17:39 PM COT
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Allow qwerty sequences', Help=NULL, AD_Element_ID=200029 WHERE UPPER(ColumnName)='QWERTYSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:17:39 PM COT
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Allow qwerty sequences', Help=NULL WHERE AD_Element_ID=200029 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:17:39 PM COT
UPDATE AD_Field SET Name='QWERTY Sequence', Description='Allow qwerty sequences', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200029) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:17:39 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='QWERTY Sequence', Name='QWERTY Sequence' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200029)
;

-- Aug 2, 2012 5:17:45 PM COT
UPDATE AD_Element SET Description='Allow QWERTY sequences',Updated=TO_DATE('2012-08-02 17:17:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200029
;

-- Aug 2, 2012 5:17:45 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200029
;

-- Aug 2, 2012 5:17:45 PM COT
UPDATE AD_Column SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Allow QWERTY sequences', Help=NULL WHERE AD_Element_ID=200029
;

-- Aug 2, 2012 5:17:45 PM COT
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Allow QWERTY sequences', Help=NULL, AD_Element_ID=200029 WHERE UPPER(ColumnName)='QWERTYSEQUENCE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:17:45 PM COT
UPDATE AD_Process_Para SET ColumnName='QWERTYSequence', Name='QWERTY Sequence', Description='Allow QWERTY sequences', Help=NULL WHERE AD_Element_ID=200029 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:17:45 PM COT
UPDATE AD_Field SET Name='QWERTY Sequence', Description='Allow QWERTY sequences', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200029) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:04 PM COT
UPDATE AD_Element SET ColumnName='RepeatCharacterRegex', Name='Repeat Character Regex', PrintName='Repeat Character Regex',Updated=TO_DATE('2012-08-02 17:18:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200069
;

-- Aug 2, 2012 5:18:04 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200069
;

-- Aug 2, 2012 5:18:04 PM COT
UPDATE AD_Column SET ColumnName='RepeatCharacterRegex', Name='Repeat Character Regex', Description=NULL, Help=NULL WHERE AD_Element_ID=200069
;

-- Aug 2, 2012 5:18:04 PM COT
UPDATE AD_Process_Para SET ColumnName='RepeatCharacterRegex', Name='Repeat Character Regex', Description=NULL, Help=NULL, AD_Element_ID=200069 WHERE UPPER(ColumnName)='REPEATCHARACTERREGEX' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:18:04 PM COT
UPDATE AD_Process_Para SET ColumnName='RepeatCharacterRegex', Name='Repeat Character Regex', Description=NULL, Help=NULL WHERE AD_Element_ID=200069 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:04 PM COT
UPDATE AD_Field SET Name='Repeat Character Regex', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200069) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:04 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Repeat Character Regex', Name='Repeat Character Regex' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200069)
;

-- Aug 2, 2012 5:18:30 PM COT
UPDATE AD_Element SET ColumnName='UppercaseCharacter', Name='Uppercase Character', PrintName='Uppercase Character',Updated=TO_DATE('2012-08-02 17:18:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200067
;

-- Aug 2, 2012 5:18:30 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200067
;

-- Aug 2, 2012 5:18:30 PM COT
UPDATE AD_Column SET ColumnName='UppercaseCharacter', Name='Uppercase Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200067
;

-- Aug 2, 2012 5:18:30 PM COT
UPDATE AD_Process_Para SET ColumnName='UppercaseCharacter', Name='Uppercase Character', Description=NULL, Help=NULL, AD_Element_ID=200067 WHERE UPPER(ColumnName)='UPPERCASECHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:18:30 PM COT
UPDATE AD_Process_Para SET ColumnName='UppercaseCharacter', Name='Uppercase Character', Description=NULL, Help=NULL WHERE AD_Element_ID=200067 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:30 PM COT
UPDATE AD_Field SET Name='Uppercase Character', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200067) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:30 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Uppercase Character', Name='Uppercase Character' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200067)
;

-- Aug 2, 2012 5:18:40 PM COT
UPDATE AD_Element SET Description='Require at least # upper case char',Updated=TO_DATE('2012-08-02 17:18:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200067
;

-- Aug 2, 2012 5:18:40 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200067
;

-- Aug 2, 2012 5:18:40 PM COT
UPDATE AD_Column SET ColumnName='UppercaseCharacter', Name='Uppercase Character', Description='Require at least # upper case char', Help=NULL WHERE AD_Element_ID=200067
;

-- Aug 2, 2012 5:18:40 PM COT
UPDATE AD_Process_Para SET ColumnName='UppercaseCharacter', Name='Uppercase Character', Description='Require at least # upper case char', Help=NULL, AD_Element_ID=200067 WHERE UPPER(ColumnName)='UPPERCASECHARACTER' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:18:40 PM COT
UPDATE AD_Process_Para SET ColumnName='UppercaseCharacter', Name='Uppercase Character', Description='Require at least # upper case char', Help=NULL WHERE AD_Element_ID=200067 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:40 PM COT
UPDATE AD_Field SET Name='Uppercase Character', Description='Require at least # upper case char', Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200067) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:56 PM COT
UPDATE AD_Element SET ColumnName='UsingDictionary', Name='Using Dictionary', PrintName='Using Dictionary',Updated=TO_DATE('2012-08-02 17:18:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200031
;

-- Aug 2, 2012 5:18:56 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200031
;

-- Aug 2, 2012 5:18:56 PM COT
UPDATE AD_Column SET ColumnName='UsingDictionary', Name='Using Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200031
;

-- Aug 2, 2012 5:18:56 PM COT
UPDATE AD_Process_Para SET ColumnName='UsingDictionary', Name='Using Dictionary', Description=NULL, Help=NULL, AD_Element_ID=200031 WHERE UPPER(ColumnName)='USINGDICTIONARY' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:18:56 PM COT
UPDATE AD_Process_Para SET ColumnName='UsingDictionary', Name='Using Dictionary', Description=NULL, Help=NULL WHERE AD_Element_ID=200031 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:56 PM COT
UPDATE AD_Field SET Name='Using Dictionary', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200031) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:18:56 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Using Dictionary', Name='Using Dictionary' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200031)
;

-- Aug 2, 2012 5:19:30 PM COT
UPDATE AD_Column SET FieldLength=255,Updated=TO_DATE('2012-08-02 17:19:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200238
;

-- Aug 2, 2012 5:19:49 PM COT
UPDATE AD_Field SET DisplayLogic='@UsingDictionary@=Y',Updated=TO_DATE('2012-08-02 17:19:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200254
;

-- Aug 2, 2012 5:20:02 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-08-02 17:20:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200087
;

-- Aug 2, 2012 5:22:37 PM COT
CREATE TABLE AD_PasswordRule (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_PasswordRule_ID NUMBER(10) NOT NULL, AlphabeticalCharacter NUMBER(10) DEFAULT NULL , AlphabeticalSequence CHAR(1) DEFAULT NULL  CHECK (AlphabeticalSequence IN ('Y','N')), Created DATE DEFAULT NULL , CreatedBy NUMBER(10) NOT NULL, DictMatchBackwards CHAR(1) DEFAULT NULL  CHECK (DictMatchBackwards IN ('Y','N')), DictWordLength NUMBER(10) DEFAULT NULL , DigitCharacter NUMBER(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT NULL  CHECK (IsActive IN ('Y','N')), LowercaseCharacter NUMBER(10) DEFAULT NULL , MaxLength NUMBER(10) DEFAULT NULL , MinLength NUMBER(10) DEFAULT NULL , Name NVARCHAR2(60) DEFAULT NULL , NonAlphaNumericCharacter NUMBER(10) DEFAULT NULL , NumericalSequence NUMBER(10) DEFAULT NULL , PathDictionary NVARCHAR2(255) DEFAULT NULL , QWERTYSequence CHAR(1) DEFAULT NULL  CHECK (QWERTYSequence IN ('Y','N')), RepeatCharacterRegex NUMBER(10) DEFAULT NULL , Updated DATE DEFAULT NULL , UpdatedBy NUMBER(10) DEFAULT NULL , UppercaseCharacter NUMBER(10) DEFAULT NULL , UserName CHAR(1) DEFAULT NULL  CHECK (UserName IN ('Y','N')), UsingDictionary CHAR(1) DEFAULT NULL  CHECK (UsingDictionary IN ('Y','N')), whitespace CHAR(1) DEFAULT NULL  CHECK (whitespace IN ('Y','N')), CONSTRAINT AD_PasswordRule_Key PRIMARY KEY (AD_PasswordRule_ID))
;

-- Aug 2, 2012 5:38:53 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_PasswordRule_UU',200071,'D','AD_PasswordRule_UU','AD_PasswordRule_UU','da3bffb7-097d-4b2a-be64-fdf0f3fe3fd1',0,TO_DATE('2012-08-02 17:38:52','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-08-02 17:38:52','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 2, 2012 5:38:53 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200071 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 2, 2012 5:39:43 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200005,200239,'D','N','N','N',0,'N',36,'N',10,'N','N',200071,'N','Y','bffe00d6-ad3d-4a06-bf13-7ec310dca514','N','Y','N','AD_PasswordRule_UU','AD_PasswordRule_UU','N',100,TO_DATE('2012-08-02 17:39:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-08-02 17:39:42','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 2, 2012 5:39:43 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200239 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 2, 2012 5:39:47 PM COT
ALTER TABLE AD_PasswordRule ADD AD_PasswordRule_UU NVARCHAR2(36) DEFAULT NULL 
;

-- Aug 2, 2012 5:45:24 PM COT
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_DATE('2012-08-02 17:45:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200139
;

-- Aug 2, 2012 5:45:30 PM COT
ALTER TABLE AD_PasswordRule MODIFY Name NVARCHAR2(60)
;

-- Aug 2, 2012 5:45:30 PM COT
ALTER TABLE AD_PasswordRule MODIFY Name NOT NULL
;

-- Aug 2, 2012 5:46:11 PM COT
UPDATE AD_Element SET Name='Password Policies', PrintName='Password Policies',Updated=TO_DATE('2012-08-02 17:46:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200024
;

-- Aug 2, 2012 5:46:11 PM COT
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200024
;

-- Aug 2, 2012 5:46:11 PM COT
UPDATE AD_Column SET ColumnName='AD_PasswordRule_ID', Name='Password Policies', Description=NULL, Help=NULL WHERE AD_Element_ID=200024
;

-- Aug 2, 2012 5:46:11 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_PasswordRule_ID', Name='Password Policies', Description=NULL, Help=NULL, AD_Element_ID=200024 WHERE UPPER(ColumnName)='AD_PASSWORDRULE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Aug 2, 2012 5:46:11 PM COT
UPDATE AD_Process_Para SET ColumnName='AD_PasswordRule_ID', Name='Password Policies', Description=NULL, Help=NULL WHERE AD_Element_ID=200024 AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:46:11 PM COT
UPDATE AD_Field SET Name='Password Policies', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200024) AND IsCentrallyMaintained='Y'
;

-- Aug 2, 2012 5:46:11 PM COT
UPDATE AD_PrintFormatItem pi SET PrintName='Password Policies', Name='Password Policies' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=200024)
;

-- Aug 2, 2012 5:49:27 PM COT
UPDATE AD_Process_Para SET SeqNo=70,Updated=TO_DATE('2012-08-02 17:49:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=520
;

-- Aug 2, 2012 5:49:54 PM COT
UPDATE AD_Process_Para SET AD_Element_ID=NULL, IsCentrallyMaintained='N', SeqNo=80, IsEncrypted='Y',Updated=TO_DATE('2012-08-02 17:49:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200005
;

-- Aug 2, 2012 5:50:08 PM COT
UPDATE AD_Process_Para SET SeqNo=60,Updated=TO_DATE('2012-08-02 17:50:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=518
;

-- Aug 2, 2012 5:50:11 PM COT
UPDATE AD_Process_Para SET SeqNo=50,Updated=TO_DATE('2012-08-02 17:50:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=519
;

-- Aug 2, 2012 5:50:13 PM COT
UPDATE AD_Process_Para SET SeqNo=40,Updated=TO_DATE('2012-08-02 17:50:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200028
;

-- Aug 2, 2012 5:50:26 PM COT
UPDATE AD_Process_Para SET IsEncrypted='Y',Updated=TO_DATE('2012-08-02 17:50:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=520
;

-- Aug 2, 2012 5:50:38 PM COT
UPDATE AD_Process_Para SET FieldLength=30,Updated=TO_DATE('2012-08-02 17:50:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200028
;

UPDATE AD_System
  SET LastMigrationScriptApplied='857_IDEMPIERE-221.sql'
WHERE LastMigrationScriptApplied<'857_IDEMPIERE-221.sql'
   OR LastMigrationScriptApplied IS NULL
;

