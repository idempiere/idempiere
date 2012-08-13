-- Aug 10, 2012 9:07:09 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Table (IsSecurityEnabled,AccessLevel,LoadSeq,AD_Table_ID,IsHighVolume,ImportTable,IsView,IsChangeLog,EntityType,CopyColumnsFromTable,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,Name,AD_Client_ID,IsActive,AD_Org_ID,Updated,CreatedBy,UpdatedBy,Created) VALUES ('N','4',0,200008,'N','N','N','N','D','N','L','d37ad1ee-3036-4f1b-bbcf-f565aad54351','Y','Y','AD_Tab_Customization','Grid user customization','Tab Customization',0,'Y',0,TO_TIMESTAMP('2012-08-10 21:07:08','YYYY-MM-DD HH24:MI:SS'),100,100,TO_TIMESTAMP('2012-08-10 21:07:08','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 10, 2012 9:07:09 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- Aug 10, 2012 9:07:10 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Sequence (StartNewYear,CurrentNextSys,IsTableID,StartNo,CurrentNext,IsAudited,IsAutoSequence,AD_Sequence_ID,AD_Sequence_UU,Description,Name,IncrementNo,AD_Org_ID,AD_Client_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive) VALUES ('N',50000,'Y',1000000,1000000,'N','Y',200009,'7efd073c-23e4-48ef-8b1a-66e1d666dbef','Table AD_Tab_Customization','AD_Tab_Customization',1,0,0,TO_TIMESTAMP('2012-08-10 21:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-10 21:07:09','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Aug 10, 2012 9:11:43 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200254,'D','Y','N','N',0,'N',10,'N',19,'N','N',102,'N','Y','acccad07-6b1b-4a90-b49a-f2e6b2dc0b8e','N','N','N','AD_Client_ID','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client','N',100,TO_TIMESTAMP('2012-08-10 21:11:42','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:11:42','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:11:43 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200254 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:14:34 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200255,'D','Y','N','N',0,'N',10,'N',19,'N','N',113,'N','Y','09102aa5-35f2-4f01-88d6-f13349ddf85f','N','N','N','AD_Org_ID','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization','N',100,TO_TIMESTAMP('2012-08-10 21:14:33','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:14:33','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:14:34 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200255 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:28:15 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('AD_Tab_Customization_ID',200081,'D','Tab Customization','Tab Customization','d61e6f5a-8c73-4b19-8983-f91d2d2ce8d6',0,TO_TIMESTAMP('2012-08-10 21:28:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-10 21:28:14','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 10, 2012 9:28:15 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200081 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 10, 2012 9:28:52 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200256,'D','N','N','N',0,'N',10,'N',13,'N','Y',200081,'N','Y','3b84e2e6-fe63-40a6-bb7d-d4bcc5691e94','N','N','N','AD_Tab_Customization_ID','Tab Customization','N',100,TO_TIMESTAMP('2012-08-10 21:28:51','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:28:51','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:28:52 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200256 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:29:53 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200257,'D','N','N','N',0,'N',22,'N',19,'N','N',125,'N','Y','58805cb1-51c3-47a0-ac10-338e64ff53d6','N','Y','N','AD_Tab_ID','Tab within a Window','The Tab indicates a tab that displays within a window.','Tab','Y',100,TO_TIMESTAMP('2012-08-10 21:29:52','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:29:52','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:29:53 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200257 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:30:33 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200258,'D','Y','N','N',0,'N',22,'N',19,'N','N',138,'N','Y','84795887-a568-4ef3-9a02-1b5e3e7a5d0c','N','Y','N','AD_User_ID','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact','User/Contact','Y',100,TO_TIMESTAMP('2012-08-10 21:30:32','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:30:32','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:30:33 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200258 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:31:20 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200259,'D','Y','N','N',0,'N',7,'N',16,'N','N',245,'N','Y','e2e511e1-7f19-4368-9043-2b62e42023e5','N','Y','N','Created','Date this record was created','The Created field indicates the date that this record was created.','Created','N',100,TO_TIMESTAMP('2012-08-10 21:31:19','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:31:19','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:31:20 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200259 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:32:10 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200260,'D',110,'Y','N','N',0,'N',10,'N',18,'N','N',246,'N','Y','161e2f80-1cce-4f35-b16d-f19804b684d3','N','Y','N','CreatedBy','User who created this records','The Created By field indicates the user who created this record.','Created By','N',100,TO_TIMESTAMP('2012-08-10 21:32:10','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:32:10','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:32:10 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200260 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:32:52 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('Custom',200082,'D','Custom','Custom','a9bece93-c6d9-4619-b782-13038c21ac3b',0,TO_TIMESTAMP('2012-08-10 21:32:51','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-10 21:32:51','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 10, 2012 9:32:52 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200082 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 10, 2012 9:33:41 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200261,'D','Y','N','N',0,'N',2000,'N',10,'N','N',200082,'N','Y','3be04407-eba4-4afe-8e37-c151944231f8','N','Y','N','Custom','Custom','Y',100,TO_TIMESTAMP('2012-08-10 21:33:40','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:33:40','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:33:41 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200261 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:34:13 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200262,'D','Y','N','N',0,'N',1,'N',20,'N','N',348,'N','Y','20d47288-2df0-4720-9b30-4fd92748044e','N','Y','N','IsActive','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active','N',100,TO_TIMESTAMP('2012-08-10 21:34:12','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:34:12','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:34:13 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200262 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:34:45 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200263,'D','Y','N','N',0,'N',7,'N',16,'N','N',607,'N','Y','446e4633-c822-46e1-9971-dfb5d61c1d3d','N','Y','N','Updated','Date this record was updated','The Updated field indicates the date that this record was updated.','Updated','N',100,TO_TIMESTAMP('2012-08-10 21:34:41','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:34:41','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:34:45 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200263 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:37:17 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,200008,200264,'D',110,'Y','N','N',0,'N',10,'N',18,'N','N',608,'N','Y','37526f39-0004-42aa-9943-44a376298a0c','N','Y','N','UpdatedBy','User who updated this records','The Updated By field indicates the user who updated this record.','Updated By','N',100,TO_TIMESTAMP('2012-08-10 21:37:14','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:37:14','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:37:17 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200264 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:38:15 PM IST
-- Customizable Grid View IDEMPIERE-364
CREATE TABLE AD_Tab_Customization (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Tab_Customization_ID NUMERIC(10) DEFAULT NULL , AD_Tab_ID NUMERIC(10) DEFAULT NULL , AD_User_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, Custom VARCHAR(2000) NOT NULL, IsActive CHAR(1) CHECK (IsActive IN ('Y','N')) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_Tab_Customization_Key PRIMARY KEY (AD_Tab_Customization_ID))
;

-- Aug 10, 2012 9:45:32 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('IsDisplayedGrid',200083,'D','Show in Grid','Show in Grid','7bd94f01-3515-4e9d-a86c-580335a4f979',0,TO_TIMESTAMP('2012-08-10 21:45:32','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-10 21:45:32','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 10, 2012 9:45:32 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200083 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 10, 2012 9:47:13 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,107,200265,'D','N','N','N',0,'N',1,'N',20,'N','N',200083,'N','Y','0eacadc5-a92e-4ca2-a1f7-ca9e463bc34f','N','Y','N','IsDisplayedGrid','Y','Show in Grid','Y',100,TO_TIMESTAMP('2012-08-10 21:47:13','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:47:13','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:47:13 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200265 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:49:01 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('SeqNoGrid',200084,'D','Grid Sequence No','Grid Sequence No','fc7dd770-a99b-4e41-955f-80397ae579eb',0,TO_TIMESTAMP('2012-08-10 21:49:00','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-08-10 21:49:00','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Aug 10, 2012 9:49:01 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200084 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Aug 10, 2012 9:50:05 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column (Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID) VALUES (0,107,200266,'D','N','N','N',0,'N',22,'N',11,'N','N',200084,'N','Y','363b94b4-d830-4fdc-83db-bc3de77f02ab','N','Y','N','SeqNoGrid','@SQL=SELECT NVL(MAX(GridSeqNo),0)+10 AS DefaultValue FROM AD_Field WHERE AD_Tab_ID=@AD_Tab_ID@','Grid Sequence No','Y',100,TO_TIMESTAMP('2012-08-10 21:50:04','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-08-10 21:50:04','YYYY-MM-DD HH24:MI:SS'),100,0)
;

-- Aug 10, 2012 9:50:05 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200266 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Aug 10, 2012 9:50:21 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Column SET DefaultValue='@SQL=SELECT NVL(MAX(SeqNoGrid),0)+10 AS DefaultValue FROM AD_Field WHERE AD_Tab_ID=@AD_Tab_ID@',Updated=TO_TIMESTAMP('2012-08-10 21:50:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200266
;

-- Aug 10, 2012 9:50:39 PM IST
-- Customizable Grid View IDEMPIERE-364
ALTER TABLE AD_Field ADD COLUMN SeqNoGrid NUMERIC(10) DEFAULT NULL 
;

-- Aug 10, 2012 9:51:24 PM IST
-- Customizable Grid View IDEMPIERE-364
ALTER TABLE AD_Field ADD COLUMN IsDisplayedGrid CHAR(1) DEFAULT 'Y' CHECK (IsDisplayedGrid IN ('Y','N'))
;

-- Aug 10, 2012 9:52:07 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,36,'N','N',60409,'Y',200273,'N','D','AD_Field_UU','N','Y','71784d16-dd0c-4504-b837-279dacf7ef42',100,0,TO_TIMESTAMP('2012-08-10 21:52:06','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-10 21:52:06','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 10, 2012 9:52:07 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200273 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 10, 2012 9:52:08 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,22,'N','N',200266,'Y',200274,'N','D','Grid Sequence No','N','Y','ae7dc496-8beb-430b-88d3-d684612f8240',100,0,TO_TIMESTAMP('2012-08-10 21:52:07','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-10 21:52:07','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 10, 2012 9:52:08 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200274 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 10, 2012 9:52:09 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,255,'N','N',54359,'Y',200275,'N','Fully qualified class name that implements the InfoFactory interface. This can be use to provide custom Info class for column.','D','Fully qualified class name that implements the InfoFactory interface','Info Factory Class','N','Y','bc2e9a27-a0dd-432d-80bf-1903085ec192',100,0,TO_TIMESTAMP('2012-08-10 21:52:08','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-10 21:52:08','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 10, 2012 9:52:09 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200275 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 10, 2012 9:52:09 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,IsFieldOnly,IsDisplayed,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive) VALUES ('N',107,1,'N','N',200265,'Y',200276,'N','D','Show in Grid','N','Y','26931797-3bde-42ae-acfc-e61ab4948abd',100,0,TO_TIMESTAMP('2012-08-10 21:52:09','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2012-08-10 21:52:09','YYYY-MM-DD HH24:MI:SS'),'Y')
;

-- Aug 10, 2012 9:52:09 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200276 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=140,IsDisplayed='Y' WHERE AD_Field_ID=200276
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=150,IsDisplayed='Y' WHERE AD_Field_ID=924
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=160,IsDisplayed='Y' WHERE AD_Field_ID=133
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=170,IsDisplayed='Y' WHERE AD_Field_ID=136
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=180,IsDisplayed='Y' WHERE AD_Field_ID=142
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=190,IsDisplayed='Y' WHERE AD_Field_ID=137
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=200,IsDisplayed='Y' WHERE AD_Field_ID=200274
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=210,IsDisplayed='Y' WHERE AD_Field_ID=139
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=220,IsDisplayed='Y' WHERE AD_Field_ID=138
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=230,IsDisplayed='Y' WHERE AD_Field_ID=8343
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=240,IsDisplayed='Y' WHERE AD_Field_ID=140
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=250,IsDisplayed='Y' WHERE AD_Field_ID=141
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=260,IsDisplayed='Y' WHERE AD_Field_ID=13425
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=270,IsDisplayed='Y' WHERE AD_Field_ID=54401
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=280,IsDisplayed='Y' WHERE AD_Field_ID=54402
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=290,IsDisplayed='Y' WHERE AD_Field_ID=13424
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=300,IsDisplayed='Y' WHERE AD_Field_ID=62468
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=310,IsDisplayed='Y' WHERE AD_Field_ID=53280
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=320,IsDisplayed='Y' WHERE AD_Field_ID=200273
;

-- Aug 10, 2012 9:53:17 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET SeqNo=330,IsDisplayed='Y' WHERE AD_Field_ID=200275
;

-- Aug 10, 2012 9:53:35 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-10 21:53:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200274
;

-- Aug 10, 2012 9:53:58 PM IST
-- Customizable Grid View IDEMPIERE-364
UPDATE AD_Field SET IsSameLine='Y',Updated=TO_TIMESTAMP('2012-08-10 21:53:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200276
;

-- Aug 10, 2012 9:57:04 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Tab (IsSingleRow,AD_Window_ID,SeqNo,IsTranslationTab,IsSortTab,AD_Table_ID,ImportFields,HasTree,IsReadOnly,IsInfoTab,AD_ColumnSortYesNo_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,Name,Description,AD_Tab_ID,AD_ColumnSortOrder_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,Processing,IsActive) VALUES ('N',102,65,'N','Y',107,'N','N','N','N',200265,'Y','N',2,'27d1dcc7-2696-45e2-bbf8-6c1f51c3e48f','D','Grid Sequence','Defined field order for grid layout',200009,200266,0,0,TO_TIMESTAMP('2012-08-10 21:57:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-08-10 21:57:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y')
;

-- Aug 10, 2012 9:57:04 PM IST
-- Customizable Grid View IDEMPIERE-364
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Help,CommitWarning,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Help,t.CommitWarning,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

Update ad_field set isDisplayedGrid = isDisplayed;

Update ad_field set seqNoGrid = seqNo;


UPDATE AD_System
  SET LastMigrationScriptApplied='872_IDEMPIERE-364_Customizable_Grid.sql'
WHERE LastMigrationScriptApplied<'872_IDEMPIERE-364_Customizable_Grid.sql'
   OR LastMigrationScriptApplied IS NULL
;

