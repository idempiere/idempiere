SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 23, 2013 5:43:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200056,'N','N','N','D','L','4428e636-52c0-40c7-bfa3-d637dbac1642','Y','Y','X_DepositBatch','Receipts into Batch',0,'Y',0,TO_DATE('2013-01-23 17:43:11','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-01-23 17:43:11','YYYY-MM-DD HH24:MI:SS'))
;

-- Jan 23, 2013 5:43:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200056 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Jan 23, 2013 5:43:15 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200051,'225ea2ca-af9e-484e-a64c-a7348c3dd01b','Table X_DepositBatch','X_DepositBatch',1,0,0,TO_DATE('2013-01-23 17:43:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-23 17:43:14','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Jan 23, 2013 5:44:15 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208398,'D','Y','N','N','N',22,'N',19,'N',102,'N','Y','2d8664be-6fe2-4101-96c1-430ab0239fb1','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2013-01-23 17:44:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:13','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:15 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208398 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:16 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208399,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','0b04414e-898c-443d-920a-861390037ce4','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2013-01-23 17:44:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:15','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:16 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208399 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:17 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208400,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','8f0513e9-b931-446f-bd38-1fed5bd4b98a','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2013-01-23 17:44:16','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:16','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:17 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208400 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:18 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208401,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','74751997-d9b9-459f-a187-58b087f2a241','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2013-01-23 17:44:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:17','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:18 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208401 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:19 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208402,'D','N','N','N','N',255,'Y',10,'N',275,'N','Y','ba56e79b-9cf3-4a2d-9626-c2cf9c6cd4be','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_DATE('2013-01-23 17:44:18','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:18','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:19 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208402 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:20 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208403,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','78523715-b9b6-4fcf-b7dd-8519a6b2c4dd','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2013-01-23 17:44:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:19','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:20 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208403 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:21 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208404,'D','Y','N','N',0,'N',1,'N',20,'N',1103,'N','Y','129a7fa8-8182-449d-ade5-415a085018d9','Y','IsDefault','Default value','N','The Default Checkbox indicates if this record will be used as a default value.','Default','Y',100,TO_DATE('2013-01-23 17:44:20','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:20','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:44:21 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208404 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:22 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208405,'D','Y','N','Y',1,'N',60,'Y',10,'N',469,'N','Y','12270b16-e9dd-4d72-9196-11394805615d','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_DATE('2013-01-23 17:44:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:22 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208405 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:22 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208406,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','bd1af2c5-5a73-42a1-8d07-6ad158db107a','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2013-01-23 17:44:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:22','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:22 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208406 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208407,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','2af94666-4c6c-442a-a4c0-420af1dd36f8','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2013-01-23 17:44:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:23','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208407 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:24 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208408,'D','Y','N','N',0,'N',40,'N',10,'N',620,'N','Y','4a595470-7566-47f5-ae36-aa02f2f44233','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_DATE('2013-01-23 17:44:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:23','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:44:24 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208408 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208409,'D','Y','N','N',0,'Y',10,'N',19,'N',200601,'N','Y','8f84791b-c852-4281-83d9-ddd42eef708a','N','X_Shipper_ID','Shipper','Y',100,TO_DATE('2013-01-23 17:44:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:24','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:44:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208409 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:26 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('X_DepositBatch_ID',202195,'D','Receipts into Batch','Receipts into Batch','bfada75f-e83d-4726-8cf3-edf1c771f2cf',0,TO_DATE('2013-01-23 17:44:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 17:44:25','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 23, 2013 5:44:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202195 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 23, 2013 5:44:28 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200056,208410,'D','Y','N','N','N',22,'N',13,'Y',202195,'N','Y','7cc2a164-9cb2-4e1e-890b-7b593750299b','N','X_DepositBatch_ID','Receipts into Batch','N',100,TO_DATE('2013-01-23 17:44:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:25','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:28 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208410 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:44:29 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('X_DepositBatch_UU',202196,'D','X_DepositBatch_UU','X_DepositBatch_UU','683ea13b-9f88-4947-a2ce-237ed9c0ad89',0,TO_DATE('2013-01-23 17:44:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 17:44:28','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 23, 2013 5:44:29 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202196 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 23, 2013 5:44:30 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1.00,'N','N',200056,208411,'D','N','N','N','N',36,'N',10,'N',202196,'N','Y','30e43343-a737-44e5-b281-7ed55be45974','Y','X_DepositBatch_UU','X_DepositBatch_UU','N',100,TO_DATE('2013-01-23 17:44:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:44:28','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:44:30 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208411 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:45:00 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208404
;

-- Jan 23, 2013 5:45:01 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208404
;

-- Jan 23, 2013 5:45:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208405
;

-- Jan 23, 2013 5:45:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208405
;

-- Jan 23, 2013 5:45:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208408
;

-- Jan 23, 2013 5:45:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208408
;

-- Jan 23, 2013 5:45:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208409
;

-- Jan 23, 2013 5:45:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208409
;

-- Jan 23, 2013 5:45:35 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208412,'D','Y','N','N',0,'N',10,'N',19,'N',836,'N','Y','6a2370a3-09f8-4d30-81cf-baa821f3bac9','Y','C_BankAccount_ID','Account at the Bank','The Bank Account identifies an account at this Bank.','Bank Account','Y',100,TO_DATE('2013-01-23 17:45:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:45:34','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:45:35 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208412 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:46:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208413,'D','Y','N','N',0,'N',10,'N',19,'N',196,'N','Y','14dfbc52-7dcc-40c3-ae5e-ef0bab3512f9','Y','C_DocType_ID','Document type or rules','The Document Type determines document sequence and processing rules','Document Type','Y',100,TO_DATE('2013-01-23 17:46:05','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:46:05','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:46:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208413 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:47:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208414,'D','N','N','N',0,'N',1,'N',28,'N',1490,'N','Y','e55e3f8d-28d7-43cb-b369-077017e6b823','Y','CreateFrom','Process which will generate a new document lines based on an existing document','The Create From process will create a new document based on information in an existing document selected by the user.','Create lines from','Y',100,TO_DATE('2013-01-23 17:47:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:47:04','YYYY-MM-DD HH24:MI:SS'),100,0,0,'Y','N')
;

-- Jan 23, 2013 5:47:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208414 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:48:01 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DateDeposit',202197,'D','Deposit Date','Deposit Date','d11ff847-d57c-4f51-92e9-c7bed69071cc',0,TO_DATE('2013-01-23 17:48:00','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 17:48:00','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 23, 2013 5:48:01 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202197 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 23, 2013 5:48:24 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208415,'D','Y','N','Y',0,'N',7,'N',15,'N',202197,'N','Y','b17960ea-1616-47eb-8971-9d5e980f44f4','Y','DateDeposit','@#Date@','Deposit Date','Y',100,TO_DATE('2013-01-23 17:48:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:48:23','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:48:24 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208415 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:49:20 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208416,'D','Y','N','N',0,'N',7,'N',15,'N',265,'N','Y','5fc53d1e-3942-44dc-b70d-614efcb82de9','Y','DateDoc','Date of the Document','@#Date@','The Document Date indicates the date the document was generated.  It may or may not be the same as the accounting date.','Document Date','Y',100,TO_DATE('2013-01-23 17:49:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:49:19','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:49:20 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208416 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:49:50 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DepositAmt',202198,'D','Deposit Amount','Deposit Amount','1c52e614-ae8e-4767-aab1-f6ffe26eadee',0,TO_DATE('2013-01-23 17:49:49','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 17:49:49','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 23, 2013 5:49:50 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202198 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 23, 2013 5:50:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208417,'D','Y','N','N',0,'N',14,'N',12,'N',202198,'N','Y','6b6f91e3-10ef-4e42-9131-5053e50bd53f','Y','DepositAmt','Deposit Amount','Y',100,TO_DATE('2013-01-23 17:50:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:50:45','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:50:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208417 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:51:33 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208418,'D',131,'Y','N','N',0,'N',2,'N',17,'N',289,'N','Y','93912515-ea34-4fcd-b2e3-72eaf5104da7','Y','DocStatus','The current status of the document','DR','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','Document Status','Y',100,TO_DATE('2013-01-23 17:51:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:51:32','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:51:33 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208418 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:52:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208419,'D','Y','N','Y',1,'N',30,'N',10,'N',290,'N','Y','98986539-7553-48d2-a01c-dce62a2e707a','Y','DocumentNo','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Document No','Y',100,TO_DATE('2013-01-23 17:52:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:52:12','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:52:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208419 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:52:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208420,'D','Y','N','N',0,'N',1,'N',20,'N',1047,'N','Y','ddb5f7e8-383b-49da-8eec-173a825209fd','Y','Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.','Processed','Y',100,TO_DATE('2013-01-23 17:52:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:52:52','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:52:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208420 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:54:12 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,Value,AD_Org_ID,AD_Client_ID,Created,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',200031,'N','N','204960ea-1515-48ad-be88-93bdd8100f01','3','N','N',0,0,'Y','D','org.adempiere.process.DepositBatchClose','Deposit Batch Close','X_DepositBatch Close',0,0,TO_DATE('2013-01-23 17:54:11','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 17:54:11','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Jan 23, 2013 5:54:12 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200031 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Jan 23, 2013 5:54:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,AD_Process_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200056,208421,'D','N','N','N',0,'N',1,'N',28,'N',524,200031,'@Processed@=''Y''','N','Y','0625f0a4-093d-4909-87c5-3a36f860b1c3','Y','Processing','Process Now','Y',100,TO_DATE('2013-01-23 17:54:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:54:24','YYYY-MM-DD HH24:MI:SS'),100,0,0,'Y','N')
;

-- Jan 23, 2013 5:54:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208421 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:54:52 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
CREATE TABLE X_DepositBatch (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_BankAccount_ID NUMBER(10) NOT NULL, C_DocType_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, CreateFrom CHAR(1) DEFAULT NULL , DateDeposit DATE NOT NULL, DateDoc DATE NOT NULL, DepositAmt NUMBER NOT NULL, Description NVARCHAR2(255) DEFAULT NULL , DocStatus NVARCHAR2(2) DEFAULT 'DR' NOT NULL, DocumentNo NVARCHAR2(30) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Processed CHAR(1) CHECK (Processed IN ('Y','N')) NOT NULL, Processing CHAR(1) DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, X_DepositBatch_ID NUMBER(10) NOT NULL, X_DepositBatch_UU NVARCHAR2(36) DEFAULT NULL , CONSTRAINT X_DepositBatch_Key PRIMARY KEY (X_DepositBatch_ID))
;

-- Jan 23, 2013 5:55:56 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Table (ImportTable,CopyColumnsFromTable,IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,IsView,IsChangeLog,EntityType,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','N','N','3',0,200057,'N','N','N','D','L','21bd7d26-d60b-4e9a-bcd2-85b95c162aa7','Y','Y','X_DepositBatchLine','Deposit Batch Line',0,'Y',0,TO_DATE('2013-01-23 17:55:55','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2013-01-23 17:55:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Jan 23, 2013 5:55:56 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200057 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Jan 23, 2013 5:55:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Sequence (UpdatedBy,StartNewYear,CurrentNextSys,IsTableID,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,IsActive,StartNo) VALUES (100,'N',200000,'Y',1000000,'N','Y',200052,'2d30472a-cb6b-4631-b037-a18997bc61b9','Table X_DepositBatchLine','X_DepositBatchLine',1,0,0,TO_DATE('2013-01-23 17:55:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-01-23 17:55:56','YYYY-MM-DD HH24:MI:SS'),'Y',1000000)
;

-- Jan 23, 2013 5:56:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Table SET Name='Receipts into Batch Line',Updated=TO_DATE('2013-01-23 17:56:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200057
;

-- Jan 23, 2013 5:56:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200057
;

-- Jan 23, 2013 5:56:35 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208422,'D','Y','N','N','N',22,'N',19,'N',102,'N','Y','7a4c6365-d057-4041-bf7d-4d65aaae2cc3','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2013-01-23 17:56:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:34','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:35 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208422 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:36 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208423,'D','Y','N','N','N',22,'N',19,104,'N',113,'N','Y','f87bdd5f-d8b2-485b-9e79-89c3a9780a3b','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2013-01-23 17:56:35','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:35','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:36 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208423 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:36 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208424,'D','Y','N','N','N',7,'N',16,'N',245,'N','Y','1d931ea9-fc11-4fae-9479-2318c1f61ccb','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2013-01-23 17:56:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:36 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208424 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208425,'D',110,'Y','N','N','N',22,'N',18,'N',246,'N','Y','8d6bbaa6-5f3d-4514-9919-b5fc723eb8cd','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2013-01-23 17:56:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:36','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208425 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208426,'D','N','N','N','N',255,'Y',10,'N',275,'N','Y','020e13a1-cf72-49af-9768-5fc575cfc089','Y','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_DATE('2013-01-23 17:56:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:37','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208426 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:39 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208427,'D','Y','N','N','N',1,'N',20,'N',348,'N','Y','f21ce087-fe26-474f-92ac-500d646bebde','Y','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2013-01-23 17:56:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:38','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:39 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208427 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:40 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208428,'D','Y','N','N',0,'N',1,'N',20,'N',1103,'N','Y','797ba1b9-c4fe-418c-8c9b-12b5572772c9','Y','IsDefault','Default value','N','The Default Checkbox indicates if this record will be used as a default value.','Default','Y',100,TO_DATE('2013-01-23 17:56:39','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:39','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:56:40 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208428 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:41 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208429,'D','Y','N','Y',1,'N',60,'Y',10,'N',469,'N','Y','de6545a6-4c1e-4d02-a282-880b428c2686','Y','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_DATE('2013-01-23 17:56:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:40','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:41 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208429 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:42 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208430,'D','Y','N','N','N',7,'N',16,'N',607,'N','Y','89f73975-72e0-4094-9247-adc2ac6cb2cc','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2013-01-23 17:56:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:41','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:42 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208430 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:43 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208431,'D',110,'Y','N','N','N',22,'N',18,'N',608,'N','Y','74593580-daa8-4324-821b-64d630a31439','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2013-01-23 17:56:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:42','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:43 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208431 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:44 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208432,'D','Y','N','N',0,'N',40,'N',10,'N',620,'N','Y','ef8ee59d-c878-423b-9596-a70196d6be51','Y','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_DATE('2013-01-23 17:56:43','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:43','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:56:44 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208432 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208433,'D','Y','N','N',0,'Y',10,'N',19,'N',200601,'N','Y','565cfc26-2ab6-4902-bf11-39a10ac5090f','N','X_Shipper_ID','Shipper','Y',100,TO_DATE('2013-01-23 17:56:44','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:44','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:56:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208433 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:46 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('X_DepositBatchLine_ID',202199,'D','Receipts into Batch Line','Receipts into Batch Line','0ecc1c05-ce0d-4668-b037-4cf0bc5e4a6d',0,TO_DATE('2013-01-23 17:56:45','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 17:56:45','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 23, 2013 5:56:46 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202199 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 23, 2013 5:56:47 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1,'Y','N',200057,208434,'D','Y','N','N','N',22,'N',13,'Y',202199,'N','Y','5ba3e70b-9087-4a78-ac1d-27da921780f7','N','X_DepositBatchLine_ID','Receipts into Batch Line','N',100,TO_DATE('2013-01-23 17:56:45','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:45','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:47 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208434 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:56:51 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('X_DepositBatchLine_UU',202200,'D','X_DepositBatchLine_UU','X_DepositBatchLine_UU','7913a3b1-6e32-4764-afe0-24e3fbaf574c',0,TO_DATE('2013-01-23 17:56:47','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 17:56:47','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 23, 2013 5:56:51 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202200 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 23, 2013 5:56:52 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable) VALUES (1.00,'N','N',200057,208435,'D','N','N','N','N',36,'N',10,'N',202200,'N','Y','a01d37de-3836-4f42-a697-e324684966a1','Y','X_DepositBatchLine_UU','X_DepositBatchLine_UU','N',100,TO_DATE('2013-01-23 17:56:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:56:47','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N')
;

-- Jan 23, 2013 5:56:52 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208435 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208426
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208426
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208428
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208428
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208429
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208429
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208432
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208432
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=208433
;

-- Jan 23, 2013 5:57:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
DELETE FROM AD_Column WHERE AD_Column_ID=208433
;

-- Jan 23, 2013 5:57:50 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208436,'D','Y','N','N',0,'N',14,'N',12,'N',1477,'N','Y','e2044592-39c2-416d-8290-347d623d2802','Y','PayAmt','Amount being paid','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','Payment amount','Y',100,TO_DATE('2013-01-23 17:57:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:57:49','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:57:50 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208436 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:58:16 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208437,'D','Y','N','N',0,'N',10,'N',19,'N',1384,'N','Y','139d61a5-2419-4ae7-89ea-29cff433ee6b','Y','C_Payment_ID','Payment identifier','The Payment is a unique identifier of this payment.','Payment','Y',100,TO_DATE('2013-01-23 17:58:15','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:58:15','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:58:16 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208437 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:58:58 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208438,'D','Y','N','Y',0,'N',14,'N',11,'N',439,'N','Y','aa02a955-a0ce-4193-82b2-ef48472a4645','Y','Line','Unique line for this document','@SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM X_DepositBatchLine WHERE X_DepositBatch_ID=@X_DepositBatch_ID@','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','Line No','Y',100,TO_DATE('2013-01-23 17:58:57','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:58:57','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:58:58 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208438 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:59:26 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208439,'D','Y','N','N',0,'N',1,'N',20,'N',1047,'N','Y','213e0828-2b2b-491e-89d7-8ff1b91513a3','Y','Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.','Processed','Y',100,TO_DATE('2013-01-23 17:59:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:59:26','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:59:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208439 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 5:59:47 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208440,'D','Y','N','N',0,'N',1,'N',20,'N',524,'N','Y','8cbdcd1c-4c89-4149-a67a-db427dae1274','Y','Processing','Process Now','Y',100,TO_DATE('2013-01-23 17:59:47','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 17:59:47','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 5:59:47 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208440 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 6:00:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',200057,208441,'D','Y','N','Y',1,'Y',10,'N',30,'N',202195,'N','Y','ea94bbcc-6e17-4f2e-bf87-9b66e1a839d3','N','X_DepositBatch_ID','Receipts into Batch','Y',100,TO_DATE('2013-01-23 18:00:36','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 18:00:36','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 6:00:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208441 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 6:01:11 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Column SET IsUpdateable='N', Name='Deposit Batch',Updated=TO_DATE('2013-01-23 18:01:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208441
;

-- Jan 23, 2013 6:01:11 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=208441
;

-- Jan 23, 2013 6:01:11 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Column_ID=208441 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2013 6:01:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Element SET PrintName='Deposit Batch',Updated=TO_DATE('2013-01-23 18:01:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202195
;

-- Jan 23, 2013 6:01:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202195
;

-- Jan 23, 2013 6:01:25 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_PrintFormatItem pi SET PrintName='Deposit Batch', Name='Receipts into Batch' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202195)
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Element SET Name='Deposit Batch Line', PrintName='Deposit Batch Line',Updated=TO_DATE('2013-01-23 18:01:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202199
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202199
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Column SET ColumnName='X_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL WHERE AD_Element_ID=202199
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Process_Para SET ColumnName='X_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL, AD_Element_ID=202199 WHERE UPPER(ColumnName)='X_DEPOSITBATCHLINE_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Process_Para SET ColumnName='X_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL WHERE AD_Element_ID=202199 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_InfoColumn SET ColumnName='X_DepositBatchLine_ID', Name='Deposit Batch Line', Description=NULL, Help=NULL WHERE AD_Element_ID=202199 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET Name='Deposit Batch Line', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202199) AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2013 6:01:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_PrintFormatItem pi SET PrintName='Deposit Batch Line', Name='Deposit Batch Line' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202199)
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Element SET Name='Deposit Batch',Updated=TO_DATE('2013-01-23 18:01:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202195
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=202195
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Column SET ColumnName='X_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202195
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Process_Para SET ColumnName='X_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL, AD_Element_ID=202195 WHERE UPPER(ColumnName)='X_DEPOSITBATCH_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Process_Para SET ColumnName='X_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202195 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_InfoColumn SET ColumnName='X_DepositBatch_ID', Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Element_ID=202195 AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET Name='Deposit Batch', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202195) AND IsCentrallyMaintained='Y'
;

-- Jan 23, 2013 6:01:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_PrintFormatItem pi SET PrintName='Deposit Batch', Name='Deposit Batch' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=pi.AD_Column_ID AND c.AD_Element_ID=202195)
;

-- Jan 23, 2013 6:02:07 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Table SET Name='Deposit Batch Line',Updated=TO_DATE('2013-01-23 18:02:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200057
;

-- Jan 23, 2013 6:02:07 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200057
;

-- Jan 23, 2013 6:02:20 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Table SET Name='Deposit Batch',Updated=TO_DATE('2013-01-23 18:02:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200056
;

-- Jan 23, 2013 6:02:20 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200056
;

-- Jan 23, 2013 6:02:29 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
CREATE TABLE X_DepositBatchLine (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_Payment_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Line NUMBER(10) NOT NULL, PayAmt NUMBER NOT NULL, Processed CHAR(1) CHECK (Processed IN ('Y','N')) NOT NULL, Processing CHAR(1) CHECK (Processing IN ('Y','N')) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, X_DepositBatch_ID NUMBER(10) NOT NULL, X_DepositBatchLine_ID NUMBER(10) NOT NULL, X_DepositBatchLine_UU NVARCHAR2(36) DEFAULT NULL , CONSTRAINT X_DepositBatchLine_Key PRIMARY KEY (X_DepositBatchLine_ID))
;

-- Jan 23, 2013 6:03:36 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('X_CreateFromBatch',202201,'D','Create From Batch','Create From Batch','a56bf24b-a9b0-459b-8db3-17fff6f8d9c1',0,TO_DATE('2013-01-23 18:03:35','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 18:03:35','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Jan 23, 2013 6:03:36 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=202201 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Jan 23, 2013 6:04:09 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',392,208442,'D','N','N','N',0,'N',1,'N',28,'N',202201,'N','Y','b6c3169b-a7c0-422c-bf51-89f9614ddef4','Y','X_CreateFromBatch','Create From Batch','Y',100,TO_DATE('2013-01-23 18:04:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 18:04:08','YYYY-MM-DD HH24:MI:SS'),100,0,0,'Y','N')
;

-- Jan 23, 2013 6:04:09 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208442 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 6:04:10 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
ALTER TABLE C_BankStatement ADD X_CreateFromBatch CHAR(1) DEFAULT NULL 
;

-- Jan 23, 2013 6:06:32 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column (Version,IsSyncDatabase,IsEncrypted,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection,IsToolbarButton,IsAlwaysUpdateable) VALUES (0,'N','N',335,208443,'D','N','N','N',0,'Y',10,'N',19,'N',202195,'N','Y','622ebed6-d1da-436e-81ab-9283d921d0b4','N','X_DepositBatch_ID','Deposit Batch','Y',100,TO_DATE('2013-01-23 18:06:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2013-01-23 18:06:31','YYYY-MM-DD HH24:MI:SS'),100,0,0,'N','N')
;

-- Jan 23, 2013 6:06:32 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=208443 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Jan 23, 2013 6:06:35 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
ALTER TABLE C_Payment ADD X_DepositBatch_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 23, 2013 6:08:49 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',328,36,'N','N',60601,'Y',201690,'N','D','C_BankStatement_UU','N','Y','d5f5ce1f-21cb-4b9e-a21f-62822cc17d57',100,0,TO_DATE('2013-01-23 18:08:48','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:08:48','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:08:50 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201690 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:08:51 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',328,1,'N','N',208442,'Y',201691,'N','D','Create From Batch','N','Y','cdf9b481-ae14-4458-ac87-44afbb2fe155',100,0,TO_DATE('2013-01-23 18:08:50','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:08:50','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:08:51 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201691 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201690
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201691
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=4003
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=8933
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200599
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=3997
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=8686
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=8687
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=10585
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=10586
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=10587
;

-- Jan 23, 2013 6:09:27 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=3999
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=61967
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201690
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=3991
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200599
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200600
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=3992
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=3994
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=4120
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=4002
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=3996
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=3998
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=4119
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=3993
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=4365
;

-- Jan 23, 2013 6:09:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=201691
;

-- Jan 23, 2013 6:11:16 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:11:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201691
;

-- Jan 23, 2013 6:12:26 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Window (Processing,WindowType,Help,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,Description,AD_Window_ID,AD_Image_ID,AD_Window_UU,Created,Updated,AD_Client_ID,AD_Org_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('N','T','The Process Receipts Window allows you to enter receipts for invoices.  If the payment is for a single invoice then it can be processed here.','Y','N','N',0,0,'D','Receipts into Batch','Process Receipts',200031,106,'74b265cf-fb73-4715-b926-f2e6e485d992',TO_DATE('2013-01-23 18:12:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-01-23 18:12:25','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Jan 23, 2013 6:12:26 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200031 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Jan 23, 2013 6:12:54 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Name,AD_Tab_ID,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',200031,10,'N','N',200056,'N','N','N','b2b0e8f8-0bbb-47b5-8dce-1accf43ad27c','Y','N',0,'D','Batch',200067,0,TO_DATE('2013-01-23 18:12:53','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-01-23 18:12:53','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Jan 23, 2013 6:12:54 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jan 23, 2013 6:12:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,1,'N','N',208403,'Y',201692,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','9124887c-0d0c-4985-ab70-e135578d4f13',100,0,TO_DATE('2013-01-23 18:12:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:12:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:12:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201692 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:12:58 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,10,'N','N',208412,'Y',201693,'N','The Bank Account identifies an account at this Bank.','D','Account at the Bank','Bank Account','N','Y','b93077eb-579f-41d0-9e87-50a20d100a65',100,0,TO_DATE('2013-01-23 18:12:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:12:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:12:58 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201693 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:12:59 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,22,'N','N',208398,'Y',201694,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','d98af125-94ef-4da3-a4c7-6db0e3d27e7e',100,0,TO_DATE('2013-01-23 18:12:58','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:12:58','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:12:59 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201694 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:00 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,1,'N','N',208414,'Y',201695,'N','The Create From process will create a new document based on information in an existing document selected by the user.','D','Process which will generate a new document lines based on an existing document','Create lines from','N','Y','809b4770-3ac7-44ca-883a-403e3fcc99df',100,0,TO_DATE('2013-01-23 18:12:59','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:12:59','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:00 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201695 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:01 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,14,'N','N',208417,'Y',201696,'N','D','Deposit Amount','N','Y','3d6714d8-e720-4aca-bde7-87a680611ac1',100,0,TO_DATE('2013-01-23 18:13:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:00','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:01 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201696 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:02 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200067,22,'N','N',208410,'Y',201697,'N','D','Deposit Batch','N','N','42e24a69-e7f9-4219-b121-5e5a53cf504e',100,0,TO_DATE('2013-01-23 18:13:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:01','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Jan 23, 2013 6:13:02 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201697 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:02 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,7,'N','N',208415,'Y',201698,'N','D','Deposit Date','N','Y','5afd8215-cc8e-4c10-9191-9ece1df7e760',100,0,TO_DATE('2013-01-23 18:13:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:02 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201698 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:03 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,255,'N','N',208402,'Y',201699,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','N','Y','0836c263-cbd8-4051-98f4-3f389990d6d8',100,0,TO_DATE('2013-01-23 18:13:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:02','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:03 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201699 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,7,'N','N',208416,'Y',201700,'N','The Document Date indicates the date the document was generated.  It may or may not be the same as the accounting date.','D','Date of the Document','Document Date','N','Y','ae0d05d5-8aa5-409b-a5e2-ddde334ecf06',100,0,TO_DATE('2013-01-23 18:13:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:03','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201700 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,30,'N','N',208419,'Y',201701,'N','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','D','Document sequence number of the document','Document No','N','Y','a9e341f3-f2dd-4ab9-b9f2-d9eebb9745d0',100,0,TO_DATE('2013-01-23 18:13:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:04','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201701 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,2,'N','N',208418,'Y',201702,'N','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field','D','The current status of the document','Document Status','N','Y','4432e795-042a-4a96-80ea-71603e6a4f5a',100,0,TO_DATE('2013-01-23 18:13:05','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:05','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201702 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:07 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,10,'N','N',208413,'Y',201703,'N','The Document Type determines document sequence and processing rules','D','Document type or rules','Document Type','N','Y','c14cdcd0-48a6-4f58-81e6-076117137cab',100,0,TO_DATE('2013-01-23 18:13:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:07 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201703 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,22,'N','N',208399,'Y',201704,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','41ed507f-b5e8-4b5f-a1a3-9492c34fbffc',100,0,TO_DATE('2013-01-23 18:13:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201704 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:09 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,1,'N','N',208421,'Y',201705,'N','D','Process Now','N','Y','c2172400-027c-4496-a7fd-53a4e94691c3',100,0,TO_DATE('2013-01-23 18:13:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:09 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201705 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:10 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,1,'N','N',208420,'Y',201706,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','N','Y','d6034f0a-77cd-4e51-9f8e-e25d9496094b',100,0,TO_DATE('2013-01-23 18:13:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:10 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201706 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:13:11 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200067,36,'N','N',208411,'Y',201707,'N','D','X_DepositBatch_UU','N','Y','097b9034-c40f-484a-89ac-a0ccae0d2363',100,0,TO_DATE('2013-01-23 18:13:10','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:13:10','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:13:11 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201707 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:14:13 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201702
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201707
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201694
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201704
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201693
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201698
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201703
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201701
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201700
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201699
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=201696
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=201695
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=201692
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=201705
;

-- Jan 23, 2013 6:14:14 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=201706
;

-- Jan 23, 2013 6:15:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201702
;

-- Jan 23, 2013 6:15:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201707
;

-- Jan 23, 2013 6:15:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201694
;

-- Jan 23, 2013 6:15:05 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201704
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201693
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201698
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201703
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201701
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201700
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201699
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=201696
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=201695
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=201692
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=201705
;

-- Jan 23, 2013 6:15:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=201706
;

-- Jan 23, 2013 6:15:58 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:15:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201704
;

-- Jan 23, 2013 6:16:04 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:16:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201694
;

-- Jan 23, 2013 6:16:09 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET XPosition=4,Updated=TO_DATE('2013-01-23 18:16:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201704
;

-- Jan 23, 2013 6:16:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:16:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201693
;

-- Jan 23, 2013 6:16:40 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:16:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201698
;

-- Jan 23, 2013 6:16:42 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:16:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201703
;

-- Jan 23, 2013 6:17:00 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:17:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201701
;

-- Jan 23, 2013 6:17:06 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:17:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201700
;

-- Jan 23, 2013 6:17:12 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2013-01-23 18:17:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201699
;

-- Jan 23, 2013 6:17:15 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:17:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201696
;

-- Jan 23, 2013 6:17:39 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', XPosition=5, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:17:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201695
;

-- Jan 23, 2013 6:18:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:18:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201692
;

-- Jan 23, 2013 6:18:49 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', DisplayLogic='@DepositAmt@!0', XPosition=5, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:18:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201705
;

-- Jan 23, 2013 6:19:02 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsReadOnly='Y', XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:19:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201706
;

-- Jan 23, 2013 6:19:11 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2013-01-23 18:19:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201696
;

-- Jan 23, 2013 6:19:43 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Tab (ImportFields,Processing,IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,HasTree,IsReadOnly,IsInfoTab,AD_Tab_UU,IsInsertRecord,IsAdvancedTab,TabLevel,EntityType,Name,AD_Tab_ID,ReadOnlyLogic,AD_Client_ID,Updated,AD_Org_ID,Created,CreatedBy,UpdatedBy,IsActive) VALUES ('N','N','N',200031,20,'N','N',200057,'N','N','N','3adbb99b-98d8-450f-83a0-87ebc00d2950','Y','N',1,'D','Lines',200068,'@Processed@=''Y''',0,TO_DATE('2013-01-23 18:19:42','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-01-23 18:19:42','YYYY-MM-DD HH24:MI:SS'),100,100,'Y')
;

-- Jan 23, 2013 6:19:43 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Jan 23, 2013 6:19:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,1,'N','N',208427,'Y',201708,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','N','Y','e9fa326b-c53b-4428-a7a3-fd98f9dd68c5',100,0,TO_DATE('2013-01-23 18:19:44','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:44','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:45 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201708 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:46 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,22,'N','N',208422,'Y',201709,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','N','Y','2205a77d-7491-4ae8-8bcb-e2c601d37d4c',100,0,TO_DATE('2013-01-23 18:19:45','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:45','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:46 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201709 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:47 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,10,'N','N',208441,'Y',201710,'N','D','Deposit Batch','N','Y','0c853d59-6d17-4653-b036-ec3a51478185',100,0,TO_DATE('2013-01-23 18:19:46','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:46','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:47 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201710 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:51 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200068,22,'N','N',208434,'Y',201711,'N','D','Deposit Batch Line','N','N','97d87d68-da47-4d84-9fb7-998fb0757a1b',100,0,TO_DATE('2013-01-23 18:19:47','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:47','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Jan 23, 2013 6:19:51 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201711 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:52 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,14,'N','N',208438,'Y',201712,'N','Indicates the unique line for a document.  It will also control the display order of the lines within a document.','D','Unique line for this document','Line No','N','Y','8d47a707-97e7-49ef-8db3-3b19a6864f32',100,0,TO_DATE('2013-01-23 18:19:51','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:51','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:52 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201712 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,22,'N','N',208423,'Y',201713,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','N','Y','f92541af-e885-426c-af88-c75cf30314fe',100,0,TO_DATE('2013-01-23 18:19:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:52','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:53 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201713 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:54 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,10,'N','N',208437,'Y',201714,'N','The Payment is a unique identifier of this payment.','D','Payment identifier','Payment','N','Y','3951ce27-652a-4a11-b1e5-a4d47c56a860',100,0,TO_DATE('2013-01-23 18:19:53','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:53','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:54 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201714 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:55 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,14,'N','N',208436,'Y',201715,'N','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','D','Amount being paid','Payment amount','N','Y','1bba36a4-c629-4d77-9f81-b5483df0997b',100,0,TO_DATE('2013-01-23 18:19:54','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:54','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:55 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201715 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:56 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,1,'N','N',208440,'Y',201716,'N','D','Process Now','N','Y','104eefdd-cc7b-46c6-bb19-18b04b13aff5',100,0,TO_DATE('2013-01-23 18:19:55','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:55','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:56 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201716 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,1,'N','N',208439,'Y',201717,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','N','Y','564ec798-4a21-4148-9ec3-1a787b5d33bd',100,0,TO_DATE('2013-01-23 18:19:56','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:56','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:57 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201717 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:19:58 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200068,36,'N','N',208435,'Y',201718,'N','D','X_DepositBatchLine_UU','N','Y','3a4a08ce-5c9e-4eea-9860-a4d121eaa3d3',100,0,TO_DATE('2013-01-23 18:19:57','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2013-01-23 18:19:57','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Jan 23, 2013 6:19:58 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=201718 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201716
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=201718
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=201709
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=201713
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=201710
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=201712
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=201714
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=201715
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=201708
;

-- Jan 23, 2013 6:20:23 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=201717
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201716
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=201718
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=201709
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=201713
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=201710
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=201712
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=201714
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=201715
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=201708
;

-- Jan 23, 2013 6:20:37 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=201717
;

-- Jan 23, 2013 6:21:03 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:21:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201709
;

-- Jan 23, 2013 6:21:22 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:21:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201713
;

-- Jan 23, 2013 6:21:29 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:21:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201710
;

-- Jan 23, 2013 6:21:40 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201712
;

-- Jan 23, 2013 6:21:49 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:21:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201714
;

-- Jan 23, 2013 6:22:07 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', IsReadOnly='Y', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:22:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201715
;

-- Jan 23, 2013 6:22:21 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:22:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201708
;

-- Jan 23, 2013 6:22:35 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_Field SET IsSameLine='Y', IsReadOnly='Y', XPosition=5, ColumnSpan=2,Updated=TO_DATE('2013-01-23 18:22:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201717
;

-- Jan 23, 2013 6:23:56 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU,IsCentrallyMaintained,Name,Action,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200031,200035,'N','N','N','D','e84239a8-560a-4f7c-ba32-fb2e70f1c616','Y','Receipts Into Batch','W','Y',0,100,TO_DATE('2013-01-23 18:23:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-01-23 18:23:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Jan 23, 2013 6:23:56 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200035 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Jan 23, 2013 6:23:56 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200035, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200035)
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Jan 23, 2013 6:24:08 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Jan 23, 2013 6:24:34 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53187
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=241
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=288
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=432
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=243
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=413
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=538
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=462
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=505
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200023
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=235
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=511
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=245
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=251
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=246
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=509
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=510
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=496
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=497
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=304
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=255
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=286
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=287
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=438
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=234
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200035
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=244
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53313
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53314
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53190
;

-- Jan 23, 2013 6:24:38 PM SGT
-- Ticket #1001569: Move receipts into batch from QS to Idempiere
UPDATE AD_TreeNodeMM SET Parent_ID=236, SeqNo=30, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53187
;

SELECT register_migration_script('201301251920_TICKET-1001569.sql') FROM dual
;
