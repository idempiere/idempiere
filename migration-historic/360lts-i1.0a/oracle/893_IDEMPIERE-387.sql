-- Sep 6, 2012 9:50:18 PM COT
-- IDEMPIERE-387 Enable mixed payments on POS Sales Order
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,Processing,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('M','Y','N','N',0,0,'D','POS Payment',200008,'N','449605a6-1c37-4030-acb8-b127d670c4fb',TO_DATE('2012-09-06 21:50:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 21:50:17','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Sep 6, 2012 9:50:18 PM COT
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Sep 6, 2012 9:54:38 PM COT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','3',0,200008,200016,'Y','N','N','Y','D','N','L','d7912f1c-6e30-4b00-aa23-76e298f10803','Y','Y','C_POSPayment','POS Payment',0,'Y',0,100,TO_DATE('2012-09-06 21:54:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 21:54:37','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 6, 2012 9:54:38 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200016 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Sep 6, 2012 9:54:38 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',50000,'Y',1000000,1000000,'N','Y',200016,'Table C_POSPayment','C_POSPayment',1,'ef396191-b898-4e73-9bd8-c7910dd1acd6',0,0,TO_DATE('2012-09-06 21:54:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 21:54:38','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 6, 2012 9:57:29 PM COT
INSERT INTO AD_Window (WindowType,IsSOTrx,IsDefault,IsBetaFunctionality,WinHeight,WinWidth,EntityType,Name,AD_Window_ID,Processing,AD_Window_UU,Created,Updated,AD_Org_ID,AD_Client_ID,IsActive,UpdatedBy,CreatedBy) VALUES ('M','Y','N','N',0,0,'D','POS Tender Type',200009,'N','2bd43b79-3a91-4a6d-873c-a364c3ca88e7',TO_DATE('2012-09-06 21:57:28','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 21:57:28','YYYY-MM-DD HH24:MI:SS'),0,0,'Y',100,100)
;

-- Sep 6, 2012 9:57:29 PM COT
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- Sep 6, 2012 9:58:19 PM COT
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Window_ID,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Name,AD_Client_ID,IsActive,AD_Org_ID,CreatedBy,Updated,UpdatedBy,Created) VALUES ('N','3',0,200009,200017,'N','N','N','Y','D','N','L','4db90b94-46b9-4408-8ff5-22b0d0d580dd','Y','Y','C_POSTenderType','POS Tender Type',0,'Y',0,100,TO_DATE('2012-09-06 21:58:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 21:58:18','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 6, 2012 9:58:19 PM COT
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200017 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Sep 6, 2012 9:58:20 PM COT
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,Description,Name,IncrementNo,AD_Sequence_UU,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',50000,'Y',1000000,1000000,'N','Y',200017,'Table C_POSTenderType','C_POSTenderType',1,'1bef08f7-8dfa-4040-89d3-84e6b8d0893b',0,0,TO_DATE('2012-09-06 21:58:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 21:58:19','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Sep 6, 2012 9:59:25 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200411,'D','Y','N','N',0,'N',22,'N',19,'Y','N',102,'N','Y','bc1b9a45-6169-429c-a4c7-851d583ac9bf','N','N','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2012-09-06 21:59:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:25 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200411 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:25 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200412,'D','Y','N','N',0,'N',22,'N',19,'Y',104,'N',113,'N','Y','910c242f-0083-4893-814d-0e2d3b563aa7','N','N','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2012-09-06 21:59:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:25 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200412 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:26 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200413,'D','Y','N','N',0,'N',7,'N',16,'Y','N',245,'N','Y','1703935d-9346-44ce-ba2a-038609c32b33','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2012-09-06 21:59:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:26 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200413 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:26 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200414,'D',110,'Y','N','N',0,'N',22,'N',18,'Y','N',246,'N','Y','5af75529-5c74-4289-92ef-00217a3f4124','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2012-09-06 21:59:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:26 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200414 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:26 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200415,'D','N','N','N',0,'N',255,'Y',10,'Y','N',275,'N','Y','e9d2d6e3-a152-40b2-94aa-2e4bb5db2c6e','N','Y','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_DATE('2012-09-06 21:59:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:26 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200415 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:27 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200416,'D','N','N','N',0,'N',2000,'N',14,'Y','N',326,'N','Y','595181ae-d387-4c4b-acd8-a7d18e36b89f','N','Y','N','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',100,TO_DATE('2012-09-06 21:59:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:27 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200416 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:27 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200417,'D','Y','N','N',0,'N',1,'N',20,'Y','N',348,'N','Y','8fe4f6be-cc2c-49af-8ebb-84ddb412ea50','N','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2012-09-06 21:59:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:27 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200417 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:28 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('C_POSTenderType_ID',200118,'D','POS Tender Type','POS Tender Type','36f330b8-677a-428e-9263-2a9ac2dee891',0,TO_DATE('2012-09-06 21:59:27','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 21:59:27','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 9:59:28 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200118 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 9:59:29 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200418,'D','Y','N','N',0,'N',22,'N',13,'Y','Y',200118,'N','Y','44c710a8-cb53-44fd-bc97-567d1cfdbfd0','N','N','N','C_POSTenderType_ID','POS Tender Type','N',100,TO_DATE('2012-09-06 21:59:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:29 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200418 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:29 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('C_POSTenderType_UU',200119,'D','C_POSTenderType_UU','C_POSTenderType_UU','9d935a67-668e-4875-a2fb-42615f8c0f74',0,TO_DATE('2012-09-06 21:59:29','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 21:59:29','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 9:59:29 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200119 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 9:59:30 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200017,200419,'D','N','N','N','N',36,'N',10,'N','N',200119,'N','Y','378b6e83-f162-49be-9de8-d80ac9e048fa','N','Y','N','C_POSTenderType_UU','C_POSTenderType_UU','N',100,TO_DATE('2012-09-06 21:59:29','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:29','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:30 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200419 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:30 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200420,'D','Y','N','Y',1,'N',60,'Y',10,'Y','N',469,'N','Y','d7f58459-b196-4737-908b-be00d49cb64e','N','Y','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_DATE('2012-09-06 21:59:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:30 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200420 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:30 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200421,'D','Y','N','N',0,'N',7,'N',16,'Y','N',607,'N','Y','6857fc15-c064-4354-83ae-6a074891ec5b','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2012-09-06 21:59:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:30 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200421 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:31 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200422,'D',110,'Y','N','N',0,'N',22,'N',18,'Y','N',608,'N','Y','139b7abb-6410-4c42-950c-2d1ed677eaee','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2012-09-06 21:59:30','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:30','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:31 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200422 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 9:59:31 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200017,200423,'D','Y','N','N',0,'N',40,'Y',10,'Y','N',620,'N','Y','915afd35-421e-4f02-881a-85f9a6b19b47','N','Y','N','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_DATE('2012-09-06 21:59:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 21:59:31','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 9:59:31 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200423 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:01:46 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,Description,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsGuarantee',200120,'D','Guarantee','Guarantee for a Credit','Guarantee','c53c89ea-e334-4b62-8a9d-d089311ff2d6',0,TO_DATE('2012-09-06 22:01:46','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 22:01:46','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 10:01:46 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200120 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 10:02:44 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200017,200424,'D','Y','N','N',0,'N',1,'N',20,'N','N',200120,'N','Y','c3862f84-356f-481b-860a-2ca8f009e7de','N','Y','N','IsGuarantee','Guarantee for a Credit','N','Guarantee','Y',100,TO_DATE('2012-09-06 22:02:43','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:02:43','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:02:44 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200424 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:03:14 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsPostDated',200121,'D','Post Dated','Post Dated','196874d7-2fba-4b88-9635-3a55e435ce72',0,TO_DATE('2012-09-06 22:03:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 22:03:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 10:03:14 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200121 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 10:03:50 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200017,200425,'D','Y','N','N',0,'N',1,'N',20,'N','N',200121,'N','Y','bde5bb1c-ae75-4654-a793-e1578afdd9ab','N','Y','N','IsPostDated','N','Post Dated','Y',100,TO_DATE('2012-09-06 22:03:49','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:03:49','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:03:50 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200425 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:05:32 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200017,200426,'D',214,'N','N','N',0,'N',1,'N',17,'N','N',1441,'N','Y','2bee3615-ff9c-4054-8970-a34ef0c38142','N','Y','N','TenderType','Method of Payment','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)','Tender type','Y',100,TO_DATE('2012-09-06 22:05:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:05:32','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:05:32 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200426 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:05:57 PM COT
CREATE TABLE C_POSTenderType (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_POSTenderType_ID NUMBER(10) NOT NULL, C_POSTenderType_UU NVARCHAR2(36) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description NVARCHAR2(255) DEFAULT NULL , Help NVARCHAR2(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsGuarantee CHAR(1) DEFAULT 'N' CHECK (IsGuarantee IN ('Y','N')) NOT NULL, IsPostDated CHAR(1) DEFAULT 'N' CHECK (IsPostDated IN ('Y','N')) NOT NULL, Name NVARCHAR2(60) NOT NULL, TenderType CHAR(1) DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, Value NVARCHAR2(40) NOT NULL, CONSTRAINT C_POSTenderType_Key PRIMARY KEY (C_POSTenderType_ID))
;

-- Sep 6, 2012 10:13:22 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200427,'D','Y','N','N',0,'N',22,'N',19,'Y','N',102,'N','Y','f86cf498-84e0-4d0a-9368-9084a42af34a','N','N','N','AD_Client_ID','Client/Tenant for this installation.','@#AD_Client_ID@','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_DATE('2012-09-06 22:13:21','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:21','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:22 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200427 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:23 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,AD_Val_Rule_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200428,'D','Y','N','N',0,'N',22,'N',19,'Y',104,'N',113,'N','Y','45405de8-9b08-44be-8fec-440321efdaa4','N','N','N','AD_Org_ID','Organizational entity within client','@#AD_Org_ID@','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_DATE('2012-09-06 22:13:22','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:22','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:23 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200428 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:23 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200429,'D','Y','N','N',0,'N',7,'N',16,'Y','N',245,'N','Y','5da98d1a-1c88-4b9f-8df5-63936ec8aa99','N','N','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_DATE('2012-09-06 22:13:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:23 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200429 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:24 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200430,'D',110,'Y','N','N',0,'N',22,'N',18,'Y','N',246,'N','Y','f2e602e2-c89c-463d-a75c-5db34e560b01','N','N','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_DATE('2012-09-06 22:13:23','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:23','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:24 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200430 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:24 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200431,'D','N','N','N',0,'N',255,'Y',10,'Y','N',275,'N','Y','dccf6294-b7f6-4763-9b1c-863d048526ce','N','Y','N','Description','Optional short description of the record','A description is limited to 255 characters.','Description','Y',100,TO_DATE('2012-09-06 22:13:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:24 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200431 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:24 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200432,'D','N','N','N',0,'N',2000,'N',14,'Y','N',326,'N','Y','bcc60dbc-3633-4053-804c-1569f48f0e47','N','Y','N','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',100,TO_DATE('2012-09-06 22:13:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:24 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200432 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:25 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200433,'D','Y','N','N',0,'N',1,'N',20,'Y','N',348,'N','Y','45dc3448-ac37-4bd4-b25d-add178c46ee1','N','Y','N','IsActive','The record is active in the system','Y','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_DATE('2012-09-06 22:13:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:24','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:25 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200433 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:25 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('C_POSPayment_ID',200122,'D','POS Payment','POS Payment','238382f6-39e1-44d4-8d0e-1f4889d23380',0,TO_DATE('2012-09-06 22:13:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 22:13:25','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 10:13:25 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200122 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 10:13:26 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200434,'D','Y','N','N',0,'N',22,'N',13,'Y','Y',200122,'N','Y','fd4c4cf7-ce66-4398-9fe7-6898ddde780d','N','N','N','C_POSPayment_ID','POS Payment','N',100,TO_DATE('2012-09-06 22:13:25','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:25','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:26 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200434 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:26 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('C_POSPayment_UU',200123,'D','C_POSPayment_UU','C_POSPayment_UU','d7e1e264-99e2-43fa-8ab8-8fe795de4cac',0,TO_DATE('2012-09-06 22:13:26','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 22:13:26','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 10:13:26 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200123 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 10:13:27 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1.00,200016,200435,'D','N','N','N','N',36,'N',10,'N','N',200123,'N','Y','7a9a3d69-ced3-4a00-a047-d54a0062ab71','N','Y','N','C_POSPayment_UU','C_POSPayment_UU','N',100,TO_DATE('2012-09-06 22:13:26','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:26','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:27 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200435 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:27 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200436,'D','Y','N','Y',1,'N',60,'Y',10,'Y','N',469,'N','Y','c237cf78-e636-479d-8f10-2a81ddfcac85','N','Y','N','Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','Name','Y',100,TO_DATE('2012-09-06 22:13:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:27 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200436 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:28 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200437,'D','Y','N','N',0,'N',7,'N',16,'Y','N',607,'N','Y','74f3b184-aebb-4fd4-ad77-2ee48c7df3e5','N','N','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_DATE('2012-09-06 22:13:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:27','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:28 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200437 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:28 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200438,'D',110,'Y','N','N',0,'N',22,'N',18,'Y','N',608,'N','Y','39ecbe25-1e1b-4ba0-83f8-9ac5e3898261','N','N','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_DATE('2012-09-06 22:13:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:28','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:28 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200438 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:13:29 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (1,200016,200439,'D','Y','N','N',0,'N',40,'Y',10,'Y','N',620,'N','Y','bdde2799-30ea-4cc0-a612-bdc66b879874','N','Y','N','Value','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Search Key','Y',100,TO_DATE('2012-09-06 22:13:28','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:13:28','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Sep 6, 2012 10:13:29 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200439 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:14:36 PM COT
UPDATE AD_Column SET FieldLength=20, IsSelectionColumn='N', AD_Element_ID=840, ColumnName='AccountNo', Description='Account Number', Help='The Account Number indicates the Number assigned to this bank account. ', Name='Account No',Updated=TO_DATE('2012-09-06 22:14:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200431
;

-- Sep 6, 2012 10:14:36 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200431
;

-- Sep 6, 2012 10:14:36 PM COT
UPDATE AD_Field SET Name='Account No', Description='Account Number', Help='The Account Number indicates the Number assigned to this bank account. ' WHERE AD_Column_ID=200431 AND IsCentrallyMaintained='Y'
;

-- Sep 6, 2012 10:15:12 PM COT
UPDATE AD_Column SET FieldLength=60, AD_Reference_ID=10, AD_Element_ID=1354, ColumnName='A_Name', Description='Name on Credit Card or Account holder', Help='The Name of the Credit Card or Account holder.', Name='Account Name',Updated=TO_DATE('2012-09-06 22:15:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200432
;

-- Sep 6, 2012 10:15:12 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200432
;

-- Sep 6, 2012 10:15:12 PM COT
UPDATE AD_Field SET Name='Account Name', Description='Name on Credit Card or Account holder', Help='The Name of the Credit Card or Account holder.' WHERE AD_Column_ID=200432 AND IsCentrallyMaintained='Y'
;

-- Sep 6, 2012 10:16:11 PM COT
UPDATE AD_Column SET IsMandatory='N', IsIdentifier='N', FieldLength=20, IsSelectionColumn='N', AD_Element_ID=249, ColumnName='CreditCardNumber', Description='Credit Card Number ', Help='The Credit Card number indicates the number on the credit card, without blanks or spaces.', Name='Number',Updated=TO_DATE('2012-09-06 22:16:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200436
;

-- Sep 6, 2012 10:16:11 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200436
;

-- Sep 6, 2012 10:16:11 PM COT
UPDATE AD_Field SET Name='Number', Description='Credit Card Number ', Help='The Credit Card number indicates the number on the credit card, without blanks or spaces.' WHERE AD_Column_ID=200436 AND IsCentrallyMaintained='Y'
;

-- Sep 6, 2012 10:16:50 PM COT
UPDATE AD_Column SET IsMandatory='N', FieldLength=20, IsSelectionColumn='N', AD_Element_ID=1445, ColumnName='VoiceAuthCode', Description='Voice Authorization Code from credit card company', Help='The Voice Authorization Code indicates the code received from the Credit Card Company.', Name='Voice authorization code',Updated=TO_DATE('2012-09-06 22:16:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200439
;

-- Sep 6, 2012 10:16:50 PM COT
UPDATE AD_Column_Trl SET IsTranslated='N' WHERE AD_Column_ID=200439
;

-- Sep 6, 2012 10:16:50 PM COT
UPDATE AD_Field SET Name='Voice authorization code', Description='Voice Authorization Code from credit card company', Help='The Voice Authorization Code indicates the code received from the Credit Card Company.' WHERE AD_Column_ID=200439 AND IsCentrallyMaintained='Y'
;

-- Sep 6, 2012 10:17:41 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200440,'D','N','N','N',0,'N',20,'N',10,'N','N',1389,'N','Y','ed842774-860b-46f5-b298-54ade73ec37f','N','Y','N','CheckNo','Check Number','The Check Number indicates the number on the check.','Check No','Y',100,TO_DATE('2012-09-06 22:17:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:17:40','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:17:41 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200440 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:18:14 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('CheckStatus',200124,'D','Check Status','Check Status','f8e72873-6765-45fe-8d2d-1db9e139a6a4',0,TO_DATE('2012-09-06 22:18:14','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 22:18:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 10:18:14 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200124 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 10:20:56 PM COT
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200007,'Check Status','D','d6785790-d25c-4952-b9ec-598abb69ed76','N','L',0,0,100,TO_DATE('2012-09-06 22:20:55','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2012-09-06 22:20:55','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 6, 2012 10:20:56 PM COT
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Sep 6, 2012 10:21:31 PM COT
UPDATE AD_Preference SET Value='Y',Updated=TO_DATE('2012-09-06 22:21:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000009
;

-- Sep 6, 2012 10:21:48 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200020,200007,'D','Charged','a1add19e-164b-4e39-bda5-d1e46690dc73','C',TO_DATE('2012-09-06 22:21:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:21:48','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Sep 6, 2012 10:21:48 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200020 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 6, 2012 10:22:02 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200021,200007,'D','Delayed','5b33e119-d7a5-4cea-bc93-08fbaf9e5598','D',TO_DATE('2012-09-06 22:22:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:22:01','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Sep 6, 2012 10:22:02 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 6, 2012 10:22:10 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200022,200007,'D','Replaced','d136c5ab-5469-4909-902b-b22f53cbefb2','P',TO_DATE('2012-09-06 22:22:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:22:09','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Sep 6, 2012 10:22:10 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 6, 2012 10:22:21 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200023,200007,'D','Received','f4234c44-1a21-4c11-b38f-db2afd89c0a2','R',TO_DATE('2012-09-06 22:22:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:22:21','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Sep 6, 2012 10:22:21 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200023 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 6, 2012 10:22:30 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200024,200007,'D','Returned','8acc92df-e6ce-4522-a0e9-5a97919e87a1','T',TO_DATE('2012-09-06 22:22:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:22:29','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Sep 6, 2012 10:22:30 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200024 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 6, 2012 10:22:38 PM COT
UPDATE AD_Preference SET Value='N',Updated=TO_DATE('2012-09-06 22:22:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000009
;

-- Sep 6, 2012 10:22:40 PM COT
UPDATE AD_Preference SET Value='Y',Updated=TO_DATE('2012-09-06 22:22:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000009
;

-- Sep 6, 2012 10:23:03 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200441,'D',200007,'N','N','N',0,'N',1,'N',17,'N','N',200124,'N','Y','067cd337-25f8-4cb1-b56e-f7458c688005','N','Y','N','CheckStatus','Check Status','Y',100,TO_DATE('2012-09-06 22:23:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:23:02','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:23:03 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200441 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:23:47 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200442,'D','Y','N','N',0,'Y',10,'N',30,'N','N',558,'N','Y','e72fe624-6b9e-44d1-a692-870ee7f99c33','N','N','N','C_Order_ID','Order','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','Order','Y',100,TO_DATE('2012-09-06 22:23:46','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:23:46','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:23:47 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200442 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:24:11 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200443,'D','N','N','N',0,'N',10,'N',30,'N','N',1384,'N','Y','e6085000-5517-4123-90e1-245b64a82f41','N','Y','N','C_Payment_ID','Payment identifier','The Payment is a unique identifier of this payment.','Payment','Y',100,TO_DATE('2012-09-06 22:24:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:24:10','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:24:11 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200443 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:25:04 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200444,'D',149,'N','N','N',0,'N',1,'N',17,'N','N',1012,'N','Y','2c5bc26a-824d-4fc3-8a2f-0d6295c418be','N','Y','N','CreditCardType','Credit Card (Visa, MC, AmEx)','The Credit Card drop down list box is used for selecting the type of Credit Card presented for payment.','Credit Card','Y',100,TO_DATE('2012-09-06 22:25:03','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:25:03','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:25:04 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200444 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:25:38 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200445,'D','N','N','N',0,'N',10,'N',15,'N','N',269,'N','Y','40b1282a-10e0-481a-9b7a-11bfc9c5bc11','N','Y','N','DatePromised','Date Order was promised','The Date Promised indicates the date, if any, that an Order was promised for.','Date Promised','Y',100,TO_DATE('2012-09-06 22:25:37','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:25:37','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:25:38 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200445 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:26:18 PM COT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('DepositGroup',200125,'D','Deposit Group','Deposit Group','1e2e58a2-0ae3-4817-a4f3-8b1845621692',0,TO_DATE('2012-09-06 22:26:17','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-06 22:26:17','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Sep 6, 2012 10:26:18 PM COT
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Name,Description,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Name,t.Description,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200125 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Sep 6, 2012 10:26:34 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200446,'D','N','N','N',0,'N',20,'N',10,'N','N',200125,'N','Y','41c98c39-2603-421c-a96a-134b13921487','N','Y','N','DepositGroup','Deposit Group','Y',100,TO_DATE('2012-09-06 22:26:34','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:26:34','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:26:34 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200446 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:27:10 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200447,'D','N','N','N',0,'N',2000,'N',14,'N','N',326,'N','Y','b3d26d0e-f321-4aa5-a748-211a0e3a97de','N','Y','N','Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.','Comment/Help','Y',100,TO_DATE('2012-09-06 22:27:09','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:27:09','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:27:10 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200447 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:28:09 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,Callout,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200448,'D','Y','N','N',0,'N',10,'N',19,'N','N',200118,'N','Y','148148c9-8b30-41dd-bbf4-765ab059b19d','N','Y','org.compiere.model.CalloutOrder.SalesOrderTenderType','N','C_POSTenderType_ID','POS Tender Type','Y',100,TO_DATE('2012-09-06 22:28:08','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:28:08','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:28:09 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200448 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:28:38 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200449,'D','Y','N','N',0,'N',1,'N',20,'N','N',200121,'N','Y','28867a6d-ade2-41ff-a460-a5d80bd044f6','N','Y','N','IsPostDated','N','Post Dated','Y',100,TO_DATE('2012-09-06 22:28:38','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:28:38','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:28:38 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200449 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:29:02 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200450,'D','N','N','N',0,'N',20,'N',10,'N','N',1407,'N','Y','1600b9d8-f999-409f-8372-6a8377d09504','N','Y','N','Micr','Combination of routing no, account and check no','The Micr number is the combination of the bank routing number, account number and check number','Micr','Y',100,TO_DATE('2012-09-06 22:29:02','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:29:02','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:29:02 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200450 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:29:24 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200451,'D','Y','N','N',0,'N',22,'N',12,'N','N',1477,'N','Y','0b3a28bc-b082-431b-837d-f70415ad69cb','N','Y','N','PayAmt','Amount being paid','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','Payment amount','Y',100,TO_DATE('2012-09-06 22:29:24','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:29:24','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:29:24 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200451 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:29:52 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,ReadOnlyLogic,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200452,'D','Y','N','N',0,'N',1,'N',20,'N','N',1047,'N','N','Y','b6fb4114-5981-4d7f-9d5a-10baffa615a3','N','Y','N','Processed','The document has been processed','The Processed checkbox indicates that a document has been processed.','Processed','Y',100,TO_DATE('2012-09-06 22:29:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:29:51','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:29:52 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200452 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:30:18 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200453,'D','N','N','N',0,'N',20,'N',10,'N','N',964,'N','Y','2e4032f9-26df-478c-b348-d4800feee2a2','N','Y','N','RoutingNo','Bank Routing Number','The Bank Routing Number (ABA Number) identifies a legal Bank.  It is used in routing checks and electronic transactions.','Routing No','Y',100,TO_DATE('2012-09-06 22:30:17','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:30:17','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:30:18 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200453 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:30:59 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,200016,200454,'D',214,'N','N','N',0,'N',1,'N',17,'N','N',1441,'N','Y','2f217389-f95a-4f33-8f56-2be85dc86933','N','Y','N','TenderType','Method of Payment','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)','Tender type','Y',100,TO_DATE('2012-09-06 22:30:58','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 22:30:58','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 10:30:59 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200454 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 10:31:21 PM COT
CREATE TABLE C_POSPayment (AccountNo NVARCHAR2(20) DEFAULT NULL , AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, A_Name NVARCHAR2(60) DEFAULT NULL , CheckNo NVARCHAR2(20) DEFAULT NULL , CheckStatus CHAR(1) DEFAULT NULL , C_Order_ID NUMBER(10) NOT NULL, C_Payment_ID NUMBER(10) DEFAULT NULL , C_POSPayment_ID NUMBER(10) NOT NULL, C_POSPayment_UU NVARCHAR2(36) DEFAULT NULL , C_POSTenderType_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, CreditCardNumber NVARCHAR2(20) DEFAULT NULL , CreditCardType CHAR(1) DEFAULT NULL , DatePromised DATE DEFAULT NULL , DepositGroup NVARCHAR2(20) DEFAULT NULL , Help NVARCHAR2(2000) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsPostDated CHAR(1) DEFAULT 'N' CHECK (IsPostDated IN ('Y','N')) NOT NULL, Micr NVARCHAR2(20) DEFAULT NULL , PayAmt NUMBER NOT NULL, Processed CHAR(1) CHECK (Processed IN ('Y','N')) NOT NULL, RoutingNo NVARCHAR2(20) DEFAULT NULL , TenderType CHAR(1) DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, VoiceAuthCode NVARCHAR2(20) DEFAULT NULL , CONSTRAINT C_POSPayment_Key PRIMARY KEY (C_POSPayment_ID))
;

-- Sep 6, 2012 10:32:04 PM COT
UPDATE AD_Preference SET Value='N',Updated=TO_DATE('2012-09-06 22:32:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000009
;

-- Sep 6, 2012 10:33:03 PM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('Y',200009,10,'N','N',200017,'N','N','N','N','Y','N',0,'ed5a16d3-a040-4691-95ca-b8f8466901ea','D','POS Tender Type',200014,0,0,TO_DATE('2012-09-06 22:33:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:33:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Sep 6, 2012 10:33:03 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Sep 6, 2012 10:33:20 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,1,'N','N',200417,'Y',200412,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','Y','N','848beee0-9ec5-4460-b614-d25f4e423c70',100,0,TO_DATE('2012-09-06 22:33:20','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:20','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:21 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200412 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:21 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,22,'N','N',200411,'Y',200413,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','Y','N','8b5a88d6-2528-42c1-83d3-441a8fad9d09',100,0,TO_DATE('2012-09-06 22:33:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:21 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200413 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:22 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,2000,'N','N',200416,'Y',200414,'N','The Help field contains a hint, comment or help about the use of this item.','D','Comment or Hint','Comment/Help','Y','N','8f016508-96c4-4465-b843-26e6e717bde6',100,0,TO_DATE('2012-09-06 22:33:21','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:21','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:22 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200414 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:22 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,36,'N','N',200419,'Y',200415,'N','D','C_POSTenderType_UU','Y','N','02c22fad-a32a-4829-9626-d8b648eda94d',100,0,TO_DATE('2012-09-06 22:33:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:22 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200415 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:22 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,255,'N','N',200415,'Y',200416,'N','A description is limited to 255 characters.','D','Optional short description of the record','Description','Y','N','9fdb47ab-911d-46d0-8532-abe00da7419e',100,0,TO_DATE('2012-09-06 22:33:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:22 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200416 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:23 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,1,'N','N',200424,'Y',200417,'N','D','Guarantee for a Credit','Guarantee','Y','N','63e29a4e-b773-473b-a56e-73e71b8247bb',100,0,TO_DATE('2012-09-06 22:33:22','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:22','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:23 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200417 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:23 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,60,'N','N',200420,'Y',200418,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','D','Alphanumeric identifier of the entity','Name','Y','N','ac33c1d5-c029-4c28-8794-bd582139d803',100,0,TO_DATE('2012-09-06 22:33:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:23 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200418 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:24 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,22,'N','N',200412,'Y',200419,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','Y','N','b5707165-a0df-4802-ad06-aaecad816fe5',100,0,TO_DATE('2012-09-06 22:33:23','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:23','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:24 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200419 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:24 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,1,'N','N',200425,'Y',200420,'N','D','Post Dated','Y','N','cfc09a6d-f9bc-453b-aa12-bf7b433a3014',100,0,TO_DATE('2012-09-06 22:33:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:24','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:24 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200420 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:25 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200014,22,'N','N',200418,'Y',200421,'N','D','POS Tender Type','N','N','c4d6085d-7fac-45cc-b335-366e4e6c9d4f',100,0,TO_DATE('2012-09-06 22:33:24','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:24','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Sep 6, 2012 10:33:25 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200421 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:25 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,40,'N','N',200423,'Y',200422,'N','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','D','Search key for the record in the format required - must be unique','Search Key','Y','N','5c0b5815-8129-4891-b111-5a6d40f7dfa0',100,0,TO_DATE('2012-09-06 22:33:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:25 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200422 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:33:26 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200014,1,'N','N',200426,'Y',200423,'N','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)','D','Method of Payment','Tender type','Y','N','dc3df3ef-e631-484c-aeec-3f6fd6a5eb95',100,0,TO_DATE('2012-09-06 22:33:25','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:33:25','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:33:26 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200423 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200415
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200413
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200419
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200422
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200418
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200416
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200414
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200417
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200420
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200423
;

-- Sep 6, 2012 10:34:39 PM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200412
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200415
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200413
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200419
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200422
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200418
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200416
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200414
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200417
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200420
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200423
;

-- Sep 6, 2012 10:35:20 PM COT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200412
;

-- Sep 6, 2012 10:36:49 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:36:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200413
;

-- Sep 6, 2012 10:36:55 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:36:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200419
;

-- Sep 6, 2012 10:37:02 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:37:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200422
;

-- Sep 6, 2012 10:37:09 PM COT
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-09-06 22:37:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200418
;

-- Sep 6, 2012 10:37:15 PM COT
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-09-06 22:37:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200416
;

-- Sep 6, 2012 10:37:20 PM COT
UPDATE AD_Field SET ColumnSpan=5, NumLines=3,Updated=TO_DATE('2012-09-06 22:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200414
;

-- Sep 6, 2012 10:37:58 PM COT
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:37:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200417
;

-- Sep 6, 2012 10:38:03 PM COT
UPDATE AD_Field SET XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:38:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200420
;

-- Sep 6, 2012 10:38:09 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:38:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200423
;

-- Sep 6, 2012 10:38:15 PM COT
UPDATE AD_Field SET XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:38:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200412
;

-- Sep 6, 2012 10:39:25 PM COT
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200009,200013,'N','Y','N','D','Y','POS Tender Type','W','2c6ad6f4-05a4-4e23-8188-c2f6501ee913','Y',0,100,TO_DATE('2012-09-06 22:39:24','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-09-06 22:39:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 6, 2012 10:39:25 PM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200013 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Sep 6, 2012 10:39:25 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200013, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200013)
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=52001
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=460
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=301
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=129
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=543
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=195
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53223
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=407
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=406
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=335
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=436
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=507
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=448
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=449
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=492
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53269
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=491
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=419
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=269
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=137
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=257
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=264
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=513
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=136
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=134
;

-- Sep 6, 2012 10:39:56 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53249
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=269
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=137
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=257
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=264
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=513
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=136
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=134
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53249
;

-- Sep 6, 2012 10:40:00 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=272, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200013
;

-- Sep 6, 2012 10:41:40 PM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',200008,10,'N','N',200016,'N','N','N','N','Y','N',0,'2df978cb-2c56-43b2-8232-042adcb48fe4','D','POS Payment',200015,0,0,TO_DATE('2012-09-06 22:41:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:41:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Sep 6, 2012 10:41:40 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200015 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Sep 6, 2012 10:42:04 PM COT
INSERT INTO AD_Menu (AD_Window_ID,AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,Name,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200008,200014,'N','Y','N','D','Y','POS Payment','W','060122b8-c06d-460c-b353-02c5af209728','Y',0,100,TO_DATE('2012-09-06 22:42:03','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2012-09-06 22:42:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 6, 2012 10:42:04 PM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200014 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Sep 6, 2012 10:42:04 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200014, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200014)
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=52001
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=460
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=301
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=129
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=543
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=195
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53223
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=407
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=406
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=335
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=436
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=507
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=448
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=449
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=492
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53269
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=491
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=419
;

-- Sep 6, 2012 10:42:19 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=457, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200014
;

-- Sep 6, 2012 10:42:29 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,60,'N','N',200432,'Y',200424,'N','The Name of the Credit Card or Account holder.','D','Name on Credit Card or Account holder','Account Name','Y','N','4cfc243d-5a34-48ca-add3-90c21996c01b',100,0,TO_DATE('2012-09-06 22:42:28','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:28','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:29 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200424 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:29 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,20,'N','N',200431,'Y',200425,'N','The Account Number indicates the Number assigned to this bank account. ','D','Account Number','Account No','Y','N','720ce617-0bf7-47a3-8e82-64061a70c925',100,0,TO_DATE('2012-09-06 22:42:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:29 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200425 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:30 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,1,'N','N',200433,'Y',200426,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','Y','N','1c697d2f-6e7f-4868-874f-e1d6646b0814',100,0,TO_DATE('2012-09-06 22:42:29','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:29','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:30 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200426 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:30 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,20,'N','N',200440,'Y',200427,'N','The Check Number indicates the number on the check.','D','Check Number','Check No','Y','N','d8684bc5-a518-4835-824d-bd83a673c001',100,0,TO_DATE('2012-09-06 22:42:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:30 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200427 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:31 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,1,'N','N',200441,'Y',200428,'N','D','Check Status','Y','N','35a0c112-e9c5-4859-8277-1b972a743c85',100,0,TO_DATE('2012-09-06 22:42:30','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:30','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:31 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200428 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:31 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,22,'N','N',200427,'Y',200429,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','Y','N','a3e5cf8f-a271-4079-9e5e-8b872258ce0a',100,0,TO_DATE('2012-09-06 22:42:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:31 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200429 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:31 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,2000,'N','N',200447,'Y',200430,'N','The Help field contains a hint, comment or help about the use of this item.','D','Comment or Hint','Comment/Help','Y','N','cff94233-f5fb-498a-a7d9-c8fa8afb6b3b',100,0,TO_DATE('2012-09-06 22:42:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:31 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200430 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:32 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,36,'N','N',200435,'Y',200431,'N','D','C_POSPayment_UU','Y','N','bb9c1a80-806f-4f6d-8a34-b055693a8a5a',100,0,TO_DATE('2012-09-06 22:42:31','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:31','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:32 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200431 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:32 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,1,'N','N',200444,'Y',200432,'N','The Credit Card drop down list box is used for selecting the type of Credit Card presented for payment.','D','Credit Card (Visa, MC, AmEx)','Credit Card','Y','N','eb796e15-2d87-4f93-b95f-e335d4d6bb94',100,0,TO_DATE('2012-09-06 22:42:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:32 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200432 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:33 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,10,'N','N',200445,'Y',200433,'N','The Date Promised indicates the date, if any, that an Order was promised for.','D','Date Order was promised','Date Promised','Y','N','2f6474bb-e36a-493d-bb24-acacb4a4363e',100,0,TO_DATE('2012-09-06 22:42:32','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:32','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:33 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200433 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:33 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,20,'N','N',200446,'Y',200434,'N','D','Deposit Group','Y','N','051c946f-f996-472e-93b4-729a82a4f633',100,0,TO_DATE('2012-09-06 22:42:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:33 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200434 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:34 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,20,'N','N',200450,'Y',200435,'N','The Micr number is the combination of the bank routing number, account number and check number','D','Combination of routing no, account and check no','Micr','Y','N','846ec5ab-d946-4c23-aa5c-6db8d1109e14',100,0,TO_DATE('2012-09-06 22:42:33','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:33','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:34 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200435 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:34 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,20,'N','N',200436,'Y',200436,'N','The Credit Card number indicates the number on the credit card, without blanks or spaces.','D','Credit Card Number ','Number','Y','N','fa1216e9-7c84-4c28-8587-590e1578158b',100,0,TO_DATE('2012-09-06 22:42:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:34 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200436 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:35 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,10,'N','N',200442,'Y',200437,'N','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','D','Order','Order','Y','N','aa4299d5-0b35-4aa4-bde8-73a8be98a7b0',100,0,TO_DATE('2012-09-06 22:42:34','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:34','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:35 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200437 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:35 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,22,'N','N',200428,'Y',200438,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','Y','N','22d861ae-b757-4293-a613-54b01e7f3d24',100,0,TO_DATE('2012-09-06 22:42:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:35 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200438 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:35 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,10,'N','N',200443,'Y',200439,'N','The Payment is a unique identifier of this payment.','D','Payment identifier','Payment','Y','N','22300b04-7547-4df4-9a58-541bd7f43179',100,0,TO_DATE('2012-09-06 22:42:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:35 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200439 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:36 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,22,'N','N',200451,'Y',200440,'N','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','D','Amount being paid','Payment amount','Y','N','ed430dd6-f0ad-4dd9-8219-28ef086d1c99',100,0,TO_DATE('2012-09-06 22:42:35','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:35','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:36 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200440 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:37 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid) VALUES ('N',200015,22,'N','N',200434,'Y',200441,'N','D','POS Payment','N','N','0598923d-a14f-4a1c-8b2f-18f5f8156c9e',100,0,TO_DATE('2012-09-06 22:42:36','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:36','YYYY-MM-DD HH24:MI:SS'),'Y','N')
;

-- Sep 6, 2012 10:42:37 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200441 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:37 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,1,'N','N',200449,'Y',200442,'N','D','Post Dated','Y','N','4420c7d7-4d72-437f-90e5-df5326641795',100,0,TO_DATE('2012-09-06 22:42:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:37 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200442 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:37 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,10,'N','N',200448,'Y',200443,'N','D','POS Tender Type','Y','N','9e9b48a4-079b-4ada-821b-405e41a8bc66',100,0,TO_DATE('2012-09-06 22:42:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:37 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200443 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:38 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,1,'N','N',200452,'Y',200444,'N','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','Y','N','d7b04026-1ae9-400a-85d0-9f5ed4d61b99',100,0,TO_DATE('2012-09-06 22:42:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:37','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:38 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200444 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:38 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,20,'N','N',200453,'Y',200445,'N','The Bank Routing Number (ABA Number) identifies a legal Bank.  It is used in routing checks and electronic transactions.','D','Bank Routing Number','Routing No','Y','N','7a05fb46-c7ef-43a0-8bd2-7239d21d05f9',100,0,TO_DATE('2012-09-06 22:42:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:38 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200445 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:39 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,1,'N','N',200454,'Y',200446,'N','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)','D','Method of Payment','Tender type','Y','N','027d7fef-886e-4297-9dd8-5a62538a26dd',100,0,TO_DATE('2012-09-06 22:42:38','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:38','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:39 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200446 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:42:39 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',200015,20,'N','N',200439,'Y',200447,'N','The Voice Authorization Code indicates the code received from the Credit Card Company.','D','Voice Authorization Code from credit card company','Voice authorization code','Y','N','8ac9c2ce-ccb5-4623-afc3-264bf1e2fe3b',100,0,TO_DATE('2012-09-06 22:42:39','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:42:39','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Sep 6, 2012 10:42:39 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200447 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200431
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200429
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200438
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200437
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200439
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200443
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200446
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200440
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200424
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200445
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200427
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200425
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=200435
;

-- Sep 6, 2012 10:44:37 PM COT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y' WHERE AD_Field_ID=200442
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200433
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=200428
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=200432
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=200436
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=200447
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=200434
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200430
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=200444
;

-- Sep 6, 2012 10:44:38 PM COT
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=200426
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200431
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200429
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200438
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200437
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200439
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200443
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200446
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200440
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200430
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200444
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200426
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200442
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200433
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=200424
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=200445
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=200427
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=200425
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=200435
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=200428
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=200432
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=200436
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=200447
;

-- Sep 6, 2012 10:46:54 PM COT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=200434
;

-- Sep 6, 2012 10:47:21 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-09-06 22:47:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200419
;

-- Sep 6, 2012 10:47:27 PM COT
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_DATE('2012-09-06 22:47:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200438
;

-- Sep 6, 2012 10:47:41 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:47:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200429
;

-- Sep 6, 2012 10:47:47 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:47:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200438
;

-- Sep 6, 2012 10:47:57 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:47:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200437
;

-- Sep 6, 2012 10:48:04 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:48:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200439
;

-- Sep 6, 2012 10:48:13 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200443
;

-- Sep 6, 2012 10:48:18 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:48:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200446
;

-- Sep 6, 2012 10:48:22 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:48:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200440
;

-- Sep 6, 2012 10:48:30 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200424
;

-- Sep 6, 2012 10:48:41 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:48:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200445
;

-- Sep 6, 2012 10:48:45 PM COT
UPDATE AD_Field SET ColumnSpan=5,Updated=TO_DATE('2012-09-06 22:48:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200424
;

-- Sep 6, 2012 10:48:51 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:48:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200427
;

-- Sep 6, 2012 10:49:02 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200425
;

-- Sep 6, 2012 10:49:08 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200435
;

-- Sep 6, 2012 10:49:18 PM COT
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200442
;

-- Sep 6, 2012 10:49:24 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200433
;

-- Sep 6, 2012 10:49:32 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200428
;

-- Sep 6, 2012 10:49:37 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200432
;

-- Sep 6, 2012 10:49:48 PM COT
UPDATE AD_Field SET ObscureType='904', XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200436
;

-- Sep 6, 2012 10:49:58 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:49:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200447
;

-- Sep 6, 2012 10:50:02 PM COT
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:50:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200434
;

-- Sep 6, 2012 10:50:09 PM COT
UPDATE AD_Field SET ColumnSpan=5, NumLines=3,Updated=TO_DATE('2012-09-06 22:50:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200430
;

-- Sep 6, 2012 10:50:14 PM COT
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:50:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200444
;

-- Sep 6, 2012 10:50:20 PM COT
UPDATE AD_Field SET XPosition=5, ColumnSpan=2,Updated=TO_DATE('2012-09-06 22:50:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200426
;

-- Sep 6, 2012 10:50:40 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-06 22:50:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200437
;

-- Sep 6, 2012 10:50:45 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-06 22:50:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200439
;

-- Sep 6, 2012 10:50:49 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-06 22:50:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200443
;

-- Sep 6, 2012 10:50:52 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-06 22:50:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200446
;

-- Sep 6, 2012 10:51:01 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-06 22:51:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200440
;

-- Sep 6, 2012 10:51:15 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-06 22:51:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200442
;

-- Sep 6, 2012 10:51:20 PM COT
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_DATE('2012-09-06 22:51:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200444
;

-- Sep 6, 2012 10:51:45 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=C | @TenderType@=K',Updated=TO_DATE('2012-09-06 22:51:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200424
;

-- Sep 6, 2012 10:51:50 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=A | @TenderType@=K',Updated=TO_DATE('2012-09-06 22:51:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200445
;

-- Sep 6, 2012 10:51:57 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=K',Updated=TO_DATE('2012-09-06 22:51:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200427
;

-- Sep 6, 2012 10:52:01 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=A | @TenderType@=K',Updated=TO_DATE('2012-09-06 22:52:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200425
;

-- Sep 6, 2012 10:52:04 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=K',Updated=TO_DATE('2012-09-06 22:52:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200435
;

-- Sep 6, 2012 10:52:09 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=K',Updated=TO_DATE('2012-09-06 22:52:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200442
;

-- Sep 6, 2012 10:52:12 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsPostDated@=Y',Updated=TO_DATE('2012-09-06 22:52:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200433
;

-- Sep 6, 2012 10:52:17 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=K & @IsPostDated@=Y',Updated=TO_DATE('2012-09-06 22:52:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200428
;

-- Sep 6, 2012 10:52:20 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_DATE('2012-09-06 22:52:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200432
;

-- Sep 6, 2012 10:52:24 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_DATE('2012-09-06 22:52:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200436
;

-- Sep 6, 2012 10:52:28 PM COT
UPDATE AD_Field SET DisplayLogic='@TenderType@=C',Updated=TO_DATE('2012-09-06 22:52:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200447
;

-- Sep 6, 2012 10:55:18 PM COT
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsInfoTab,IsReadOnly,AD_Column_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,AD_Tab_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('Y',143,50,'N','N',200016,'N','N','N','N',200442,'Y','N',0,'b29acba2-af8e-4c28-a889-2a7131c5848c','D','POS Payment',200016,0,0,TO_DATE('2012-09-06 22:55:17','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 22:55:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Sep 6, 2012 10:55:18 PM COT
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200016 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Sep 6, 2012 10:56:00 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,36,'N','N',200435,0,'Y',200448,'N','D','C_POSPayment_UU','N','N','a374a7c6-2920-4292-92d1-923af4513304',100,0,TO_DATE('2012-09-06 22:55:59','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:55:59','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,1,1)
;

-- Sep 6, 2012 10:56:00 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200448 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:01 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,22,'N','N',200427,10,'Y',200449,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','D','Client/Tenant for this installation.','Client','Y','N','3cb37b5f-eb3b-47cb-9499-1467fe73bd4f',100,0,TO_DATE('2012-09-06 22:56:00','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:00','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,1,2,1)
;

-- Sep 6, 2012 10:56:01 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200449 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:01 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,22,'Y','N',200428,20,'Y',200450,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','D','Organizational entity within client','Organization','Y','N','56a39cbb-2118-4adb-ba34-e772745909b3',100,0,TO_DATE('2012-09-06 22:56:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:01','YYYY-MM-DD HH24:MI:SS'),'Y','Y',10,4,2,1)
;

-- Sep 6, 2012 10:56:01 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200450 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:02 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,10,'N','N',200442,30,'Y',200451,'Y','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','D','Order','Order','Y','N','7b8c455c-a246-4384-92c6-b1dc4d614694',100,0,TO_DATE('2012-09-06 22:56:01','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:01','YYYY-MM-DD HH24:MI:SS'),'Y','Y',20,1,2,1)
;

-- Sep 6, 2012 10:56:02 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200451 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:02 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,10,'N','N',200443,40,'Y',200452,'Y','The Payment is a unique identifier of this payment.','D','Payment identifier','Payment','Y','N','aa61fccd-4e7c-4158-ae26-4db822c61fd4',100,0,TO_DATE('2012-09-06 22:56:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',30,4,2,1)
;

-- Sep 6, 2012 10:56:02 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200452 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:02 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,10,'N','N',200448,50,'Y',200453,'Y','D','POS Tender Type','Y','N','0f75aef8-5870-4494-99dd-7f8b14e7f363',100,0,TO_DATE('2012-09-06 22:56:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',40,1,2,1)
;

-- Sep 6, 2012 10:56:02 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200453 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:03 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,1,'N','N',200454,60,'Y',200454,'Y','The Tender Type indicates the method of payment (ACH or Direct Deposit, Credit Card, Check, Direct Debit)','D','Method of Payment','Tender type','Y','N','b0f50f02-a936-4abd-b581-752da275ca26',100,0,TO_DATE('2012-09-06 22:56:02','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:02','YYYY-MM-DD HH24:MI:SS'),'Y','Y',50,4,2,1)
;

-- Sep 6, 2012 10:56:03 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200454 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:03 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,22,'N','N',200451,70,'Y',200455,'Y','Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','D','Amount being paid','Payment amount','Y','N','ef6d1dcc-a0f9-46ba-bf7e-1edbd8948e6d',100,0,TO_DATE('2012-09-06 22:56:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:03','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,1,2,1)
;

-- Sep 6, 2012 10:56:03 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200455 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:04 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,60,'N','N',200432,80,'Y',200456,'N','The Name of the Credit Card or Account holder.','@TenderType@=C | @TenderType@=K','D','Name on Credit Card or Account holder','Account Name','Y','N','f70d6a8e-3b3a-4b79-81b3-507b527f4b56',100,0,TO_DATE('2012-09-06 22:56:03','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:03','YYYY-MM-DD HH24:MI:SS'),'Y','Y',120,1,5,1)
;

-- Sep 6, 2012 10:56:04 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200456 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:04 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,20,'N','N',200453,90,'Y',200457,'N','The Bank Routing Number (ABA Number) identifies a legal Bank.  It is used in routing checks and electronic transactions.','@TenderType@=A | @TenderType@=K','D','Bank Routing Number','Routing No','Y','N','3843f24b-0f6d-4883-928f-80218d3f1448',100,0,TO_DATE('2012-09-06 22:56:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:04','YYYY-MM-DD HH24:MI:SS'),'Y','Y',130,1,2,1)
;

-- Sep 6, 2012 10:56:04 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200457 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:05 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,20,'N','N',200440,100,'Y',200458,'N','The Check Number indicates the number on the check.','@TenderType@=K','D','Check Number','Check No','Y','N','f81706d7-5562-461f-a290-c2cfe8e4a4f8',100,0,TO_DATE('2012-09-06 22:56:04','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:04','YYYY-MM-DD HH24:MI:SS'),'Y','Y',140,4,2,1)
;

-- Sep 6, 2012 10:56:05 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200458 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:05 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,20,'N','N',200431,110,'Y',200459,'N','The Account Number indicates the Number assigned to this bank account. ','@TenderType@=A | @TenderType@=K','D','Account Number','Account No','Y','N','fc8ff7f4-acf9-4f9a-bc58-fed49663b39b',100,0,TO_DATE('2012-09-06 22:56:05','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:05','YYYY-MM-DD HH24:MI:SS'),'Y','Y',150,1,2,1)
;

-- Sep 6, 2012 10:56:05 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200459 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:06 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,20,'N','N',200450,120,'Y',200460,'N','The Micr number is the combination of the bank routing number, account number and check number','@TenderType@=K','D','Combination of routing no, account and check no','Micr','Y','N','866f35d4-a682-4feb-9042-21d33d3c38fa',100,0,TO_DATE('2012-09-06 22:56:05','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:05','YYYY-MM-DD HH24:MI:SS'),'Y','Y',160,4,2,1)
;

-- Sep 6, 2012 10:56:06 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200460 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:06 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,DisplayLogic,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,1,'N','N',200449,130,'Y',200461,'Y','@TenderType@=K','D','Post Dated','Y','N','8604a1f0-317b-4101-8807-6e9e0b82801f',100,0,TO_DATE('2012-09-06 22:56:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:06','YYYY-MM-DD HH24:MI:SS'),'Y','Y',100,2,2,1)
;

-- Sep 6, 2012 10:56:06 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200461 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:06 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,10,'N','N',200445,140,'Y',200462,'N','The Date Promised indicates the date, if any, that an Order was promised for.','@TenderType@=K & @IsPostDated@=Y','D','Date Order was promised','Date Promised','Y','N','7643f9b6-fa64-4425-8031-d34ad4f51fb2',100,0,TO_DATE('2012-09-06 22:56:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:06','YYYY-MM-DD HH24:MI:SS'),'Y','Y',110,4,2,1)
;

-- Sep 6, 2012 10:56:06 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200462 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:07 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,DisplayLogic,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,1,'N','N',200441,150,'Y',200463,'N','@TenderType@=K & @IsPostDated@=Y','D','Check Status','Y','N','029ef236-5521-4130-b7bb-59340d1243ca',100,0,TO_DATE('2012-09-06 22:56:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:06','YYYY-MM-DD HH24:MI:SS'),'Y','Y',170,1,2,1)
;

-- Sep 6, 2012 10:56:07 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200463 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:07 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,1,'N','N',200444,160,'Y',200464,'N','The Credit Card drop down list box is used for selecting the type of Credit Card presented for payment.','@TenderType@=C','D','Credit Card (Visa, MC, AmEx)','Credit Card','Y','N','559d1d7b-e1cc-47db-ab0d-4142b34b7b3c',100,0,TO_DATE('2012-09-06 22:56:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:07','YYYY-MM-DD HH24:MI:SS'),'Y','Y',180,1,2,1)
;

-- Sep 6, 2012 10:56:07 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200464 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:08 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,ObscureType,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,20,'N','N',200436,170,'Y',200465,'N','The Credit Card number indicates the number on the credit card, without blanks or spaces.','904','@TenderType@=C','D','Credit Card Number ','Number','Y','N','2e9f1b38-fbab-4244-bee9-5576df5cff54',100,0,TO_DATE('2012-09-06 22:56:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:07','YYYY-MM-DD HH24:MI:SS'),'Y','Y',190,4,2,1)
;

-- Sep 6, 2012 10:56:08 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200465 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:13 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,20,'N','N',200439,180,'Y',200466,'N','The Voice Authorization Code indicates the code received from the Credit Card Company.','@TenderType@=C','D','Voice Authorization Code from credit card company','Voice authorization code','Y','N','29b093ee-5206-4dda-bb10-207bf5041543',100,0,TO_DATE('2012-09-06 22:56:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:08','YYYY-MM-DD HH24:MI:SS'),'Y','Y',200,1,2,1)
;

-- Sep 6, 2012 10:56:13 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200466 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:13 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,20,'N','N',200446,190,'Y',200467,'N','D','Deposit Group','Y','N','7675716b-7a3d-4358-a7ca-6b8747ad9631',100,0,TO_DATE('2012-09-06 22:56:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:13','YYYY-MM-DD HH24:MI:SS'),'Y','Y',210,1,2,1)
;

-- Sep 6, 2012 10:56:13 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200467 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:14 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,2000,'N','N',200447,200,'Y',200468,'N','The Help field contains a hint, comment or help about the use of this item.','D','Comment or Hint','Comment/Help','Y','N','7335cbeb-2cec-46c1-9fc4-0e8b8900357d',100,0,TO_DATE('2012-09-06 22:56:13','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:13','YYYY-MM-DD HH24:MI:SS'),'Y','Y',70,1,5,3)
;

-- Sep 6, 2012 10:56:14 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200468 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:14 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,1,'N','N',200452,210,'Y',200469,'Y','The Processed checkbox indicates that a document has been processed.','D','The document has been processed','Processed','Y','N','ebac66aa-e527-4a3f-84cc-08011b5370e5',100,0,TO_DATE('2012-09-06 22:56:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:14','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,2,2,1)
;

-- Sep 6, 2012 10:56:14 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200469 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:15 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,1,'N','N',200433,220,'Y',200470,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','D','The record is active in the system','Active','Y','N','8a0f5ef3-d641-45cb-96d6-babdbd1bc028',100,0,TO_DATE('2012-09-06 22:56:14','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:14','YYYY-MM-DD HH24:MI:SS'),'Y','Y',90,5,2,1)
;

-- Sep 6, 2012 10:56:15 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200470 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:15 PM COT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,XPosition,ColumnSpan,NumLines) VALUES ('N',200016,22,'N','N',200434,'Y',200471,'N','D','POS Payment','N','N','3acb972e-723c-44c6-bf94-253567746333',100,0,TO_DATE('2012-09-06 22:56:15','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 22:56:15','YYYY-MM-DD HH24:MI:SS'),'Y','N',1,1,1)
;

-- Sep 6, 2012 10:56:15 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200471 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 10:56:48 PM COT
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2012-09-06 22:56:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200451
;

-- Sep 6, 2012 10:56:57 PM COT
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2012-09-06 22:56:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200453
;

-- Sep 6, 2012 10:57:03 PM COT
UPDATE AD_Field SET IsReadOnly='N',Updated=TO_DATE('2012-09-06 22:57:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200455
;

-- Sep 6, 2012 10:59:50 PM COT
UPDATE AD_Column SET AD_Reference_ID=17, AD_Val_Rule_ID=NULL,Updated=TO_DATE('2012-09-06 22:59:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4019
;

-- Sep 6, 2012 11:03:20 PM COT
UPDATE AD_Ref_List SET Name='Mixed POS Payment',Updated=TO_DATE('2012-09-06 23:03:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=52000
;

-- Sep 6, 2012 11:03:20 PM COT
UPDATE AD_Ref_List_Trl SET IsTranslated='N' WHERE AD_Ref_List_ID=52000
;

-- Sep 6, 2012 11:18:38 PM COT
UPDATE AD_Tab SET DisplayLogic='@PaymentRule@=M',Updated=TO_DATE('2012-09-06 23:18:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200016
;

-- Sep 6, 2012 11:30:24 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','There are not POS invoice(s)',200041,'D','b9cffc90-3060-4350-b0d1-3453f8603c27','NoPOSInvoices','Y',TO_DATE('2012-09-06 23:30:23','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-06 23:30:23','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 6, 2012 11:30:24 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200041 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 6, 2012 11:33:35 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Total POS Payments differ from Total Invoice',200042,'D','bc47633c-cc5e-4637-992d-f77c59d36297','POSPaymentDiffers','Y',TO_DATE('2012-09-06 23:33:33','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-06 23:33:33','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 6, 2012 11:33:35 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200042 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 6, 2012 11:37:59 PM COT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','No account defined for this organization / currency','Create an account on the bank account window for the organization / currency, the POS payments will be created on the defined account',200043,'D','0d396db0-7024-4849-ac0f-150a886dc1cb','NoAccountOrgCurrency','Y',TO_DATE('2012-09-06 23:37:58','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-06 23:37:58','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 6, 2012 11:37:59 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200043 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 6, 2012 11:38:58 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200025,216,'D','Cash','efdadde5-1f09-4e32-9fff-ab94a7caf845','B',TO_DATE('2012-09-06 23:38:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 23:38:57','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Sep 6, 2012 11:38:58 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 6, 2012 11:39:06 PM COT
INSERT INTO AD_Ref_List (AD_Ref_List_ID,AD_Reference_ID,EntityType,Name,AD_Ref_List_UU,Value,Created,CreatedBy,Updated,UpdatedBy,IsActive,AD_Org_ID,AD_Client_ID) VALUES (200026,216,'D','Card','0246f122-2d14-4aee-ba91-c72b43d6e85e','D',TO_DATE('2012-09-06 23:39:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-09-06 23:39:06','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,0)
;

-- Sep 6, 2012 11:39:06 PM COT
INSERT INTO AD_Ref_List_Trl (AD_Language,AD_Ref_List_ID, Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Ref_List_Trl_UU ) SELECT l.AD_Language,t.AD_Ref_List_ID, t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Ref_List t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Ref_List_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Ref_List_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Ref_List_ID=t.AD_Ref_List_ID)
;

-- Sep 6, 2012 11:43:32 PM COT
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (0,335,200455,'D','N','N','N',0,'N',10,'N',19,'N','N',200118,'N','Y','d5e66f32-7ad8-4c72-93d3-67dc9675e6a1','N','Y','N','C_POSTenderType_ID','POS Tender Type','Y',100,TO_DATE('2012-09-06 23:43:31','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_DATE('2012-09-06 23:43:31','YYYY-MM-DD HH24:MI:SS'),100,0,0)
;

-- Sep 6, 2012 11:43:32 PM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200455 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Sep 6, 2012 11:43:35 PM COT
ALTER TABLE C_Payment ADD C_POSTenderType_ID NUMBER(10) DEFAULT NULL 
;

-- Sep 6, 2012 11:46:50 PM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (0,'N',330,0,'N','N',200455,285,'Y',200472,'Y','D','POS Tender Type','Y','N','a6108362-88cf-4f93-a291-c725be5b7ec7',100,0,TO_DATE('2012-09-06 23:46:49','YYYY-MM-DD HH24:MI:SS'),0,100,TO_DATE('2012-09-06 23:46:49','YYYY-MM-DD HH24:MI:SS'),'Y','Y',285,1,1,1)
;

-- Sep 6, 2012 11:46:50 PM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200472 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Sep 6, 2012 11:47:12 PM COT
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_DATE('2012-09-06 23:47:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200472
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=200472
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=4363
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=4054
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=4027
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=4032
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=340,IsDisplayed='Y' WHERE AD_Field_ID=4041
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=350,IsDisplayed='Y' WHERE AD_Field_ID=4036
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=360,IsDisplayed='Y' WHERE AD_Field_ID=4057
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=370,IsDisplayed='Y' WHERE AD_Field_ID=4035
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=380,IsDisplayed='Y' WHERE AD_Field_ID=4037
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=390,IsDisplayed='Y' WHERE AD_Field_ID=4033
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=400,IsDisplayed='Y' WHERE AD_Field_ID=4034
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=410,IsDisplayed='Y' WHERE AD_Field_ID=4023
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=420,IsDisplayed='Y' WHERE AD_Field_ID=4025
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=430,IsDisplayed='Y' WHERE AD_Field_ID=4019
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=440,IsDisplayed='Y' WHERE AD_Field_ID=4026
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=450,IsDisplayed='Y' WHERE AD_Field_ID=4024
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=460,IsDisplayed='Y' WHERE AD_Field_ID=6299
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=470,IsDisplayed='Y' WHERE AD_Field_ID=4021
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=480,IsDisplayed='Y' WHERE AD_Field_ID=4022
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=490,IsDisplayed='Y' WHERE AD_Field_ID=4020
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=500,IsDisplayed='Y' WHERE AD_Field_ID=4055
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=510,IsDisplayed='Y' WHERE AD_Field_ID=4043
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=520,IsDisplayed='Y' WHERE AD_Field_ID=4058
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=530,IsDisplayed='Y' WHERE AD_Field_ID=4042
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=540,IsDisplayed='Y' WHERE AD_Field_ID=4258
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=550,IsDisplayed='Y' WHERE AD_Field_ID=4039
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=560,IsDisplayed='Y' WHERE AD_Field_ID=4053
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=570,IsDisplayed='Y' WHERE AD_Field_ID=4052
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=580,IsDisplayed='Y' WHERE AD_Field_ID=4051
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=590,IsDisplayed='Y' WHERE AD_Field_ID=4047
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=600,IsDisplayed='Y' WHERE AD_Field_ID=4049
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=610,IsDisplayed='Y' WHERE AD_Field_ID=4048
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=620,IsDisplayed='Y' WHERE AD_Field_ID=4362
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=630,IsDisplayed='Y' WHERE AD_Field_ID=4361
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=640,IsDisplayed='Y' WHERE AD_Field_ID=6552
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=650,IsDisplayed='Y' WHERE AD_Field_ID=4044
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=660,IsDisplayed='Y' WHERE AD_Field_ID=4266
;

-- Sep 6, 2012 11:47:43 PM COT
UPDATE AD_Field SET SeqNo=670,IsDisplayed='Y' WHERE AD_Field_ID=52052
;

-- Sep 6, 2012 11:48:13 PM COT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=4017
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=4018
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=4267
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=4030
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=4132
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=4933
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=4265
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=10393
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=10392
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=4264
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=4257
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=10902
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=6551
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=6969
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y' WHERE AD_Field_ID=11013
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y' WHERE AD_Field_ID=7809
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y' WHERE AD_Field_ID=7807
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y' WHERE AD_Field_ID=7808
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y' WHERE AD_Field_ID=7806
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y' WHERE AD_Field_ID=7810
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y' WHERE AD_Field_ID=4133
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y' WHERE AD_Field_ID=4129
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y' WHERE AD_Field_ID=8651
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y' WHERE AD_Field_ID=4131
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y' WHERE AD_Field_ID=5117
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y' WHERE AD_Field_ID=5736
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y' WHERE AD_Field_ID=5737
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y' WHERE AD_Field_ID=4056
;

-- Sep 6, 2012 11:48:14 PM COT
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y' WHERE AD_Field_ID=200472
;

-- Sep 6, 2012 11:53:59 PM COT
UPDATE AD_Field SET XPosition=1,Updated=TO_DATE('2012-09-06 23:53:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3113
;

-- Sep 6, 2012 11:55:09 PM COT
UPDATE AD_Tab SET TabLevel=1,Updated=TO_DATE('2012-09-06 23:55:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200016
;

-- Sep 7, 2012 12:03:03 AM COT
UPDATE AD_SysConfig SET Value='Y',Updated=TO_DATE('2012-09-07 00:03:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50028
;

-- Sep 7, 2012 12:05:56 AM COT
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_DATE('2012-09-07 00:05:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4030
;

-- Sep 7, 2012 12:06:24 AM COT
UPDATE AD_Field SET DisplayLogic='1=2 & @TenderType@=''X''',Updated=TO_DATE('2012-09-07 00:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52052
;

-- Sep 7, 2012 12:09:36 AM COT
UPDATE AD_Window SET Help='The Bank / Cash Window is used to define the banks and accounts associated with an organization or business partner', Name='Bank / Cash', Description='Maintain Bank / Cash',Updated=TO_DATE('2012-09-07 00:09:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=158
;

-- Sep 7, 2012 12:09:36 AM COT
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=158
;

-- Sep 7, 2012 12:09:36 AM COT
UPDATE AD_Menu SET Name='Bank / Cash', Description='Maintain Bank / Cash', IsActive='Y',Updated=TO_DATE('2012-09-07 00:09:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=171
;

-- Sep 7, 2012 12:09:36 AM COT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=171
;

-- Sep 7, 2012 12:09:49 AM COT
UPDATE AD_Tab SET Name='Bank / Cash',Updated=TO_DATE('2012-09-07 00:09:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=227
;

-- Sep 7, 2012 12:09:49 AM COT
UPDATE AD_Tab_Trl SET IsTranslated='N' WHERE AD_Tab_ID=227
;

-- Sep 7, 2012 12:10:48 AM COT
UPDATE AD_Column SET AD_Val_Rule_ID=NULL,Updated=TO_DATE('2012-09-07 00:10:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5046
;

UPDATE AD_System
  SET LastMigrationScriptApplied='893_IDEMPIERE-387.sql'
WHERE LastMigrationScriptApplied<'893_IDEMPIERE-387.sql'
   OR LastMigrationScriptApplied IS NULL
;

