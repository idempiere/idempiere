SET SQLBLANKLINES ON
SET DEFINE OFF

-- Development of Process Customization
-- 24/11/2017 9h47min49s BRST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,Help,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200232,'User defined Process','User defined Process','User defined Process','AD_UserDef_Proc',0,'3',0,0,'Y',TO_DATE('2017-11-24 09:47:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','33449b20-f6cc-4e48-afad-bcbe5d0dd92e','N','N','N')
;

-- 24/11/2017 9h47min49s BRST
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200232 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- 24/11/2017 9h47min49s BRST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Proc',1000000,'N','N','Table AD_UserDef_Proc','Y','Y',0,0,TO_DATE('2017-11-24 09:47:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:49','YYYY-MM-DD HH24:MI:SS'),100,200293,'Y',1000000,1,200000,'87cd3d3d-9773-470c-8ecd-29364f399a8e')
;

-- 24/11/2017 9h47min54s BRST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203143,0,0,'Y',TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Proc_ID','AD_UserDef_Proc_ID','Primary Key : User defined Process','Primary Key : User defined Process','AD_UserDef_Proc_ID','D','a5330037-dce0-4bd2-a283-c726a72f2971')
;

-- 24/11/2017 9h47min54s BRST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,Description,Help,PrintName,PO_Description,PO_Help,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.Description,t.Help,t.PrintName,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=203143 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- 24/11/2017 9h47min54s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213260,0.0,'AD_UserDef_Proc_ID','Primary Key : User defined Process','Primary Key : User defined Process',200232,'AD_UserDef_Proc_ID',22,'Y','N','Y','N','Y','N',13,0,0,'Y',TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,203143,'N','N','D','N','bdbaf39d-0d4a-4b4b-bb8f-8f2b054c3b70','N')
;

-- 24/11/2017 9h47min54s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213260 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min54s BRST
CREATE TABLE AD_UserDef_Proc (AD_UserDef_Proc_ID NUMBER(10) NOT NULL, CONSTRAINT AD_UserDef_Proc_Key PRIMARY KEY (AD_UserDef_Proc_ID))
;

-- 24/11/2017 9h47min54s BRST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203144,0,0,'Y',TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Proc_UU','AD_UserDef_Proc_UU','AD_UserDef_Proc_UU','D','907aeb97-cf7a-49e0-834b-2073e1a5d681')
;

-- 24/11/2017 9h47min54s BRST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,Description,Help,PrintName,PO_Description,PO_Help,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.Description,t.Help,t.PrintName,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=203144 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213261,1.0,'AD_UserDef_Proc_UU',200232,'AD_UserDef_Proc_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:54','YYYY-MM-DD HH24:MI:SS'),100,203144,'Y','N','D','N','753bfc94-f7cc-4435-b0d0-2444bf9b2bfe','N')
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213261 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD AD_UserDef_Proc_UU VARCHAR2(36) DEFAULT NULL
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD CONSTRAINT AD_UserDef_Proc_UU_idx UNIQUE (AD_UserDef_Proc_UU)
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213262,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200232,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','00caa0b0-f0ff-4f98-b192-19d6b75f8623','N')
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213262 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213263,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200232,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','eabe6960-1ea2-4fcb-af57-604e5d59c34b','N')
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213263 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213264,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200232,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','b4e6c969-ea9b-4e4b-856d-ee0bc49e58fb','N')
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213264 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213265,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200232,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','17d8d6a9-8602-4874-9b51-2598e4aa907b','N')
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213265 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD Created DATE NOT NULL
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213266,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200232,'CreatedBy',22,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','fb8ab9c1-62dc-43db-923d-47e0041bc280','N')
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213266 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD CreatedBy NUMBER(10) NOT NULL
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213267,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200232,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','2b81f60d-60ad-4a41-9d5b-1ea0e51fbdbe','N')
;

-- 24/11/2017 9h47min55s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213267 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min55s BRST
ALTER TABLE AD_UserDef_Proc ADD Updated DATE NOT NULL
;

-- 24/11/2017 9h47min56s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213268,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200232,'UpdatedBy',22,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:47:55','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','09d26b4a-d418-47cc-9ccc-fe43bc041276','N')
;

-- 24/11/2017 9h47min56s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213268 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h47min56s BRST
ALTER TABLE AD_UserDef_Proc ADD UpdatedBy NUMBER(10) NOT NULL
;

-- 24/11/2017 9h49min6s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213269,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200232,'AD_Role_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2017-11-24 09:49:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:49:06','YYYY-MM-DD HH24:MI:SS'),100,123,'Y','N','D','N','N','N','Y','dbd7e1b5-7e89-487b-a200-0d686f45ff33','Y',0,'N','N','C')
;

-- 24/11/2017 9h49min6s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213269 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h49min17s BRST
UPDATE AD_Column SET FKConstraintName='ADRole_ADUserDefProc', FKConstraintType='C',Updated=TO_DATE('2017-11-24 09:49:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213269
;

-- 24/11/2017 9h49min17s BRST
ALTER TABLE AD_UserDef_Proc ADD AD_Role_ID NUMBER(10) DEFAULT NULL
;

-- 24/11/2017 9h49min17s BRST
ALTER TABLE AD_UserDef_Proc ADD CONSTRAINT ADRole_ADUserDefProc FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- 24/11/2017 9h49min43s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213270,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200232,'AD_User_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_DATE('2017-11-24 09:49:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:49:43','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','N','N','N','Y','49f3f723-3c89-4947-83f0-bcbbe61f8145','Y',0,'N','N')
;

-- 24/11/2017 9h49min43s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213270 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h49min49s BRST
UPDATE AD_Column SET FKConstraintName='ADUser_ADUserDefProc', FKConstraintType='N',Updated=TO_DATE('2017-11-24 09:49:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213270
;

-- 24/11/2017 9h49min49s BRST
ALTER TABLE AD_UserDef_Proc ADD AD_User_ID NUMBER(10) DEFAULT NULL
;

-- 24/11/2017 9h49min49s BRST
ALTER TABLE AD_UserDef_Proc ADD CONSTRAINT ADUser_ADUserDefProc FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- 24/11/2017 9h50min9s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213271,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200232,'Name',60,'N','N','N','N','Y',0,'N',10,0,0,'Y',TO_DATE('2017-11-24 09:50:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:50:08','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','f0177ad4-1e6d-4fbc-b6ad-03db0c3e2cbe','Y',0,'N','N')
;

-- 24/11/2017 9h50min9s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213271 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h54min4s BRST
ALTER TABLE AD_UserDef_Proc ADD Name VARCHAR2(60) DEFAULT NULL
;

-- 24/11/2017 9h54min21s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213272,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200232,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2017-11-24 09:54:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:54:21','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','cee03637-343c-4929-a07e-d8d608a8f439','Y',0,'N','N')
;

-- 24/11/2017 9h54min21s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213272 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h54min24s BRST
ALTER TABLE AD_UserDef_Proc ADD Description VARCHAR2(255) DEFAULT NULL
;

-- 24/11/2017 9h56min11s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213273,0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200232,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2017-11-24 09:56:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:56:11','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','N','N','Y','eecb0847-819d-4658-b11a-ad41fba68a17','Y',0,'N','N')
;

-- 24/11/2017 9h56min11s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213273 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h56min15s BRST
ALTER TABLE AD_UserDef_Proc ADD Help VARCHAR2(2000) DEFAULT NULL
;

-- 24/11/2017 9h56min51s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213274,0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200232,'AD_Language',6,'N','N','N','N','N',0,'N',18,106,0,0,'Y',TO_DATE('2017-11-24 09:56:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 09:56:51','YYYY-MM-DD HH24:MI:SS'),100,109,'Y','N','D','N','N','N','Y','0738e8e3-3dd6-4158-9b74-484331bd3962','Y',0,'N','N','N')
;

-- 24/11/2017 9h56min51s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213274 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 9h56min55s BRST
UPDATE AD_Column SET FKConstraintName='ADLanguage_ADUserDefProc', FKConstraintType='N',Updated=TO_DATE('2017-11-24 09:56:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213274
;

-- 24/11/2017 9h56min56s BRST
ALTER TABLE AD_UserDef_Proc ADD AD_Language VARCHAR2(6) DEFAULT NULL
;

-- 24/11/2017 9h56min56s BRST
ALTER TABLE AD_UserDef_Proc ADD CONSTRAINT ADLanguage_ADUserDefProc FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- 24/11/2017 10h39min47s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213277,0,'User updatable','The field can be updated by the user','The User Updatable checkbox indicate if the user can update  this field.',200232,'IsUserUpdateable',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2017-11-24 10:39:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:39:46','YYYY-MM-DD HH24:MI:SS'),100,423,'Y','N','D','N','N','N','Y','c082256d-cdc8-48de-a243-9df7ac48e10f','Y',0,'N','N','N')
;

-- 24/11/2017 10h39min47s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213277 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h39min53s BRST
ALTER TABLE AD_UserDef_Proc ADD IsUserUpdateable CHAR(1) DEFAULT NULL  CHECK (IsUserUpdateable IN ('Y','N'))
;

-- 24/11/2017 10h45min14s BRST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,Help,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200233,'User defined Process Parameter','User defined Process Parameter','User defined Process Parameter','AD_UserDef_Proc_Parameter',0,'3',0,0,'Y',TO_DATE('2017-11-24 10:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','cf6639d3-ed90-4fe4-9b52-9f323f7c0677','N','N','N')
;

-- 24/11/2017 10h45min14s BRST
INSERT INTO AD_Table_Trl (AD_Language,AD_Table_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Table_Trl_UU ) SELECT l.AD_Language,t.AD_Table_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Table t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Table_ID=200233 AND NOT EXISTS (SELECT * FROM AD_Table_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Table_ID=t.AD_Table_ID)
;

-- 24/11/2017 10h45min14s BRST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_UserDef_Proc_Parameter',1000000,'N','N','Table AD_UserDef_Proc_Parameter','Y','Y',0,0,TO_DATE('2017-11-24 10:45:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:14','YYYY-MM-DD HH24:MI:SS'),100,200294,'Y',1000000,1,200000,'3c57d150-6ac4-4c75-8319-0c57aa9f9605')
;

-- 24/11/2017 10h45min18s BRST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203145,0,0,'Y',TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Proc_Parameter_ID','AD_UserDef_Proc_Parameter_ID','Primary Key : User defined Process Parameter','Primary Key : User defined Process Parameter','AD_UserDef_Proc_Parameter_ID','D','2383475f-d543-4358-9fd5-5fe7b4f87d10')
;

-- 24/11/2017 10h45min18s BRST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,Description,Help,PrintName,PO_Description,PO_Help,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.Description,t.Help,t.PrintName,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=203145 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- 24/11/2017 10h45min18s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213278,0.0,'AD_UserDef_Proc_Parameter_ID','Primary Key : User defined Process Parameter','Primary Key : User defined Process Parameter',200233,'AD_UserDef_Proc_Parameter_ID',22,'Y','N','Y','N','Y','N',13,0,0,'Y',TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,203145,'N','N','D','N','b066c991-5244-452c-a606-e91e40ffa1dc','N')
;

-- 24/11/2017 10h45min18s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213278 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min18s BRST
CREATE TABLE AD_UserDef_Proc_Parameter (AD_UserDef_Proc_Parameter_ID NUMBER(10) NOT NULL, CONSTRAINT AD_UserDef_Proc_Parameter_Key PRIMARY KEY (AD_UserDef_Proc_Parameter_ID))
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203146,0,0,'Y',TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,'AD_UserDef_Proc_Parameter_UU','AD_UserDef_Proc_Parameter_UU','AD_UserDef_Proc_Parameter_UU','D','8cb7044d-64c4-4ff2-9d67-cf5b885c9727')
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Name,Description,Help,PrintName,PO_Description,PO_Help,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Name,t.Description,t.Help,t.PrintName,t.PO_Description,t.PO_Help,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=203146 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213279,1.0,'AD_UserDef_Proc_Parameter_UU',200233,'AD_UserDef_Proc_Parameter_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:18','YYYY-MM-DD HH24:MI:SS'),100,203146,'Y','N','D','N','6a291346-e3be-4992-a646-5bf1ebd89fc7','N')
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213279 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min19s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD AD_UserDef_Proc_Parameter_UU VARCHAR2(36) DEFAULT NULL
;

-- 24/11/2017 10h45min19s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD CONSTRAINT AD_UserDef_Proc_Parameteruuidx UNIQUE (AD_UserDef_Proc_Parameter_UU)
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213280,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200233,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','666b360f-4c91-4261-ba63-446bfc333413','N')
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213280 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min19s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213281,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200233,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','e1853311-53b6-488b-a66f-67f3e3a82344','N')
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213281 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min19s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213282,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200233,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','085f71f5-d0e2-4552-a04a-6af9d0d01abc','N')
;

-- 24/11/2017 10h45min19s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213282 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min19s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213283,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200233,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:19','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','7a8f468d-0e6e-454a-aaef-26868856a975','N')
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213283 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min20s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD Created DATE NOT NULL
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213284,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200233,'CreatedBy',22,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_DATE('2017-11-24 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','7c03bec3-9958-45d4-87b0-f18eb651d15f','N')
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213284 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min20s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD CreatedBy NUMBER(10) NOT NULL
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213285,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200233,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2017-11-24 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','316c5836-d27f-4221-93a6-7c3a91fd6265','N')
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213285 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min20s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD Updated DATE NOT NULL
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (213286,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200233,'UpdatedBy',22,'N','N','Y','N','N','N',18,110,0,0,'Y',TO_DATE('2017-11-24 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:45:20','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','f85109bc-9917-4770-9e1b-b485a4b93089','N')
;

-- 24/11/2017 10h45min20s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213286 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h45min20s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD UpdatedBy NUMBER(10) NOT NULL
;

-- 24/11/2017 10h49min38s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213287,0,'AD_UserDef_Proc_ID','Primary Key : User defined Process','Primary Key : User defined Process',200233,'AD_UserDef_Proc_ID',22,'N','N','Y','N','Y',0,'N',19,0,0,'Y',TO_DATE('2017-11-24 10:49:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:49:38','YYYY-MM-DD HH24:MI:SS'),100,203143,'N','N','D','N','N','N','Y','be7c3ec8-93a1-4972-b701-f353a098d55b','Y',0,'N','N','N')
;

-- 24/11/2017 10h49min38s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213287 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h49min46s BRST
UPDATE AD_Column SET FKConstraintName='ADUserDefProc_ADUserDefProcPar', FKConstraintType='N',Updated=TO_DATE('2017-11-24 10:49:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213287
;

-- 24/11/2017 10h49min46s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD AD_UserDef_Proc_ID NUMBER(10) NOT NULL
;

-- 24/11/2017 10h49min46s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD CONSTRAINT ADUserDefProc_ADUserDefProcPar FOREIGN KEY (AD_UserDef_Proc_ID) REFERENCES ad_userdef_proc(ad_userdef_proc_id) DEFERRABLE INITIALLY DEFERRED
;

-- 24/11/2017 10h57min16s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213288,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200233,'Name',60,'N','N','N','N','Y',1,'N',10,0,0,'Y',TO_DATE('2017-11-24 10:57:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:57:16','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','dff52153-a8d4-45e0-aba8-4b9e66e7e18d','Y',0,'N','N')
;

-- 24/11/2017 10h57min16s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213288 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h57min45s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213289,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200233,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2017-11-24 10:57:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:57:44','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','6430cad1-c94e-43a8-91e5-feee5844335e','Y',0,'N','N')
;

-- 24/11/2017 10h57min45s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213289 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h57min51s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD Description VARCHAR2(255) DEFAULT NULL
;

-- 24/11/2017 10h58min22s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213290,0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200233,'Help',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2017-11-24 10:58:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 10:58:21','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','N','N','N','Y','c5bfa676-180d-4157-b94d-fe276c2b7e3a','Y',0,'N','N')
;

-- 24/11/2017 10h58min22s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213290 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 10h58min28s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD Help VARCHAR2(2000) DEFAULT NULL
;

-- 24/11/2017 11h2min52s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213291,0,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200233,'IsDisplayed','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2017-11-24 11:02:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:02:52','YYYY-MM-DD HH24:MI:SS'),100,368,'Y','N','D','N','N','N','Y','cad34f07-dacc-4032-a2cf-10bef936bdb7','Y',0,'N','N')
;

-- 24/11/2017 11h2min53s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213291 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 11h3min22s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD IsDisplayed CHAR(1) DEFAULT 'Y' CHECK (IsDisplayed IN ('Y','N'))
;

-- 24/11/2017 11h4min32s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213293,0,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200233,'DisplayLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2017-11-24 11:04:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:04:32','YYYY-MM-DD HH24:MI:SS'),100,283,'Y','N','D','N','N','N','Y','6756a368-c060-42c3-a3bb-3e4820a29011','Y',0,'N','N')
;

-- 24/11/2017 11h4min32s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213293 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 11h4min35s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD DisplayLogic VARCHAR2(2000) DEFAULT NULL
;

-- 24/11/2017 11h5min34s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213294,0,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200233,'DefaultValue',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2017-11-24 11:05:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:05:34','YYYY-MM-DD HH24:MI:SS'),100,272,'Y','N','D','N','N','N','Y','000b4d82-089a-4697-b3b9-91136e4805a4','Y',0,'N','N')
;

-- 24/11/2017 11h5min34s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213294 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 11h5min38s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD DefaultValue VARCHAR2(2000) DEFAULT NULL
;

-- 24/11/2017 11h10min39s BRST
INSERT INTO AD_Window (AD_Window_ID,Name,Description,Help,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,WinWidth,IsBetaFunctionality,AD_Window_UU) VALUES (200095,'User defined Process','User defined Process','User defined Process',0,0,'Y',TO_DATE('2017-11-24 11:10:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:10:39','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,0,'N','2f7799ea-a248-4422-ab0f-90f09a61132c')
;

-- 24/11/2017 11h10min39s BRST
INSERT INTO AD_Window_Trl (AD_Language,AD_Window_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Window_Trl_UU ) SELECT l.AD_Language,t.AD_Window_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Window t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Window_ID=200095 AND NOT EXISTS (SELECT * FROM AD_Window_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Window_ID=t.AD_Window_ID)
;

-- 24/11/2017 11h12min41s BRST
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200234,'User defined Process','User defined Process','User defined Process',200095,10,'Y',200232,0,0,'Y',TO_DATE('2017-11-24 11:12:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','60c65615-8d2b-4d97-97fc-2cd033adfa0d','B')
;

-- 24/11/2017 11h12min41s BRST
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Name,Description,Help,CommitWarning, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Name,t.Description,t.Help,t.CommitWarning, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200234 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- 24/11/2017 11h12min58s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205246,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200234,213262,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f16ccd4e-7298-4685-b27e-755461ff9d43','N',2)
;

-- 24/11/2017 11h12min58s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205246 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h12min58s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205247,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200234,213263,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b09a31f2-1d55-4eee-98c9-a29cfa6fa0f4','Y','Y',10,4,2)
;

-- 24/11/2017 11h12min58s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205247 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h12min58s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205248,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200234,213271,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a6151f43-fab0-4010-a47d-475c1e785893','Y',20,5)
;

-- 24/11/2017 11h12min58s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205248 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205249,'Description','Optional short description of the record','A description is limited to 255 characters.',200234,213272,'Y',255,40,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a0cb89f-6e3d-442c-92df-6236af65a1a0','Y',30,5)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205249 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (205250,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200234,213273,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','78f2d475-9826-4621-8203-df64192c0c3c','Y',40,5,3)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205250 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205251,'AD_UserDef_Proc_ID','Primary Key : User defined Process','Primary Key : User defined Process',200234,213260,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cfdc3ec0-4153-41fc-9a08-460ef8a4beff','N',2)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205251 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205252,'AD_UserDef_Proc_UU',200234,213261,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8fe6c05b-3280-43ac-aa0e-f745cff17cad','N',2)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205252 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205253,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200234,213269,'Y',22,60,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a2f777c1-4251-4fbd-9cb2-8807f7b7d806','Y',50,2)
;

-- 24/11/2017 11h12min59s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205253 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205254,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200234,213270,'Y',22,70,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:12:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','36194a55-5ba3-47c3-b4ca-e173f5122927','Y',60,2)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205254 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205255,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200234,213274,'Y',6,80,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:13:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:13:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','64550c31-ca61-4751-b420-0455cee610a4','Y',70,2)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205255 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205257,'User updatable','The field can be updated by the user','The User Updatable checkbox indicate if the user can update  this field.',200234,213277,'Y',1,100,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:13:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:13:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8b44d067-5808-4844-a969-d6d50f055a02','Y',90,2,2)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205257 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205258,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200234,213264,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:13:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:13:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fc9e630c-254f-4cb9-b72c-2a443b35a4ca','Y',100,2,2)
;

-- 24/11/2017 11h13min1s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205258 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205253
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205258
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205248
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205249
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205250
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205254
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205256
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205257
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205251
;

-- 24/11/2017 11h16min13s BRST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205252
;

-- 24/11/2017 11h18min44s BRST
INSERT INTO AD_Tab (AD_Tab_ID,Name,Description,Help,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn) VALUES (200235,'User defined Process Parameter','User defined Process Parameter','User defined Process Parameter',200095,20,'Y',200233,0,0,'Y',TO_DATE('2017-11-24 11:18:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:43','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','81393e58-922f-4bea-84d8-704b90694b85','B')
;

-- 24/11/2017 11h18min44s BRST
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, Name,Description,Help,CommitWarning, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.Name,t.Description,t.Help,t.CommitWarning, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200235 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- 24/11/2017 11h18min55s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205259,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200235,213280,'Y',22,10,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a3c2bd77-5f54-4afc-80a2-4a222f86e2b5','N',2)
;

-- 24/11/2017 11h18min55s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205259 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min55s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205260,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200235,213281,'Y',22,20,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a4a835d9-c23d-4a76-948d-4d20f49e9c48','Y','Y',10,4,2)
;

-- 24/11/2017 11h18min55s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205260 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205261,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200235,213288,'Y',60,30,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c7700c3d-613f-4487-98be-afeddf7c911b','Y',20,5)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205261 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205262,'Description','Optional short description of the record','A description is limited to 255 characters.',200235,213289,'Y',255,40,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0246aab7-b47b-44a2-9167-1d77d1af492a','Y',30,5)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205262 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (205263,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200235,213290,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f7736d24-bfa4-4879-92b6-bdc39bf3b648','Y',40,5,3)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205263 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205264,'AD_UserDef_Proc_Parameter_ID','Primary Key : User defined Process Parameter','Primary Key : User defined Process Parameter',200235,213278,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e6840ce3-a4cb-4ec5-815d-93807ec7f2ca','N',2)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205264 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (205265,'AD_UserDef_Proc_Parameter_UU',200235,213279,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b9d021bf-f45b-47f2-ae82-fa9e741510f8','N',2)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205265 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205266,'AD_UserDef_Proc_ID','Primary Key : User defined Process','Primary Key : User defined Process',200235,213287,'Y',22,60,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8b53fab2-faca-4098-8cf6-c35566f15cf3','Y',50,2)
;

-- 24/11/2017 11h18min56s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205266 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205267,'Displayed','Determines, if this field is displayed','If the field is displayed, the field Display Logic will determine at runtime, if it is actually displayed',200235,213291,'Y',1,70,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4e691c06-1533-4c0c-bdc1-ea4e01c48d9b','Y',60,2,2)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205267 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (205269,'Display Logic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200235,213293,'Y',2000,90,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','045f78e0-a8aa-4e91-985d-c9fb04d5fab6','Y',80,5,3)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205269 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205270,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',200235,213294,'Y',2000,100,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','355e62a7-0205-4393-80e6-3e3d7b073398','Y',90,5)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205270 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205271,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200235,213282,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 11:18:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:18:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','65aa9708-deba-4ba3-bdc7-4a95dfbc2105','Y',100,2,2)
;

-- 24/11/2017 11h18min57s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205271 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205266
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205271
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205261
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205262
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205263
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205270
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205268
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205264
;

-- 24/11/2017 11h23min36s BRST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 11:23:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205265
;

-- 24/11/2017 11h26min46s BRST
UPDATE AD_Table SET AD_Window_ID=200095,Updated=TO_DATE('2017-11-24 11:26:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200232
;

-- 24/11/2017 11h29min12s BRST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200150,'User defined Process','W',200095,0,0,'Y',TO_DATE('2017-11-24 11:29:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 11:29:09','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','6a03885f-ff4c-434b-8305-4108eef29bde')
;

-- 24/11/2017 11h29min12s BRST
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200150 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- 24/11/2017 11h29min12s BRST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200150, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200150)
;

-- 24/11/2017 11h29min33s BRST
UPDATE AD_Menu_Trl SET Name='Personalização de Processo',Updated=TO_DATE('2017-11-24 11:29:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200150 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h30min35s BRST
UPDATE AD_Window_Trl SET Description='Personalização de Processo', Help='Personalização de Processo', Name='Personalização de Processo',Updated=TO_DATE('2017-11-24 11:30:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200095 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h30min55s BRST
UPDATE AD_Tab_Trl SET Name='Personalização de Processo', Description='Personalização de Processo', Help='Personalização de Processo',Updated=TO_DATE('2017-11-24 11:30:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200235 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h31min8s BRST
UPDATE AD_Tab_Trl SET Name='Personalização de Parametro', Description='Personalização de Parametro', Help='Personalização de Parametro',Updated=TO_DATE('2017-11-24 11:31:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200235 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h31min18s BRST
UPDATE AD_Tab_Trl SET Name='Personalização de Parametro', Description='Personalização de Parametro', Help='Personalização de Parametro',Updated=TO_DATE('2017-11-24 11:31:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200234 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h36min26s BRST
UPDATE AD_Tab SET TabLevel=1,Updated=TO_DATE('2017-11-24 11:36:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200235
;

-- 24/11/2017 11h44min49s BRST
UPDATE AD_Element_Trl SET Name='User defined Process', Description='User defined Process', Help='User defined Process', PrintName='User defined Process',Updated=TO_DATE('2017-11-24 11:44:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203143 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h45min27s BRST
UPDATE AD_Element_Trl SET Name='User defined Process Parameter', Description='User defined Process Parameter', Help='User defined Process Parameter', PrintName='User defined Process Parameter',Updated=TO_DATE('2017-11-24 11:45:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203145 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h51min52s BRST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_DATE('2017-11-24 11:51:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213287
;

-- 24/11/2017 11h51min57s BRST
ALTER TABLE AD_UserDef_Proc_Parameter MODIFY AD_UserDef_Proc_ID NUMBER(10)
;

-- 24/11/2017 11h58min26s BRST
UPDATE AD_Element_Trl SET Name='Janela definida pelo Usuário', Description='Janela definida pelo Usuário', Help='Janela definida pelo Usuário', PrintName='Janela definida pelo Usuário',Updated=TO_DATE('2017-11-24 11:58:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203143 AND AD_Language='pt_BR'
;

-- 24/11/2017 11h59min38s BRST
UPDATE AD_Element SET Name='User defined Process', PrintName='User defined Process',Updated=TO_DATE('2017-11-24 11:59:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203143
;

-- 24/11/2017 11h59min38s BRST
UPDATE AD_Column SET ColumnName='AD_UserDef_Proc_ID', Name='User defined Process', Description='Primary Key : User defined Process', Help='Primary Key : User defined Process' WHERE AD_Element_ID=203143
;

-- 24/11/2017 11h59min38s BRST
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Proc_ID', Name='User defined Process', Description='Primary Key : User defined Process', Help='Primary Key : User defined Process', AD_Element_ID=203143 WHERE UPPER(ColumnName)='AD_USERDEF_PROC_ID' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- 24/11/2017 11h59min38s BRST
UPDATE AD_Process_Para SET ColumnName='AD_UserDef_Proc_ID', Name='User defined Process', Description='Primary Key : User defined Process', Help='Primary Key : User defined Process' WHERE AD_Element_ID=203143 AND IsCentrallyMaintained='Y'
;

-- 24/11/2017 11h59min38s BRST
UPDATE AD_InfoColumn SET ColumnName='AD_UserDef_Proc_ID', Name='User defined Process', Description='Primary Key : User defined Process', Help='Primary Key : User defined Process' WHERE AD_Element_ID=203143 AND IsCentrallyMaintained='Y'
;

-- 24/11/2017 11h59min38s BRST
UPDATE AD_Field SET Name='User defined Process', Description='Primary Key : User defined Process', Help='Primary Key : User defined Process' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=203143) AND IsCentrallyMaintained='Y'
;

-- 24/11/2017 11h59min38s BRST
UPDATE AD_PrintFormatItem SET PrintName='User defined Process', Name='User defined Process' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=203143)
;

-- 24/11/2017 12h1min4s BRST
UPDATE AD_Element_Trl SET Name='Parâmetro definido pelo Usuário', Description='Parâmetro definido pelo Usuário', Help='Parâmetro definido pelo Usuário', PrintName='Parâmetro definido pelo Usuário',Updated=TO_DATE('2017-11-24 12:01:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=203145 AND AD_Language='pt_BR'
;

-- 24/11/2017 12h9min39s BRST
UPDATE AD_Tab_Trl SET Name='Personalização de Processo', Description='Personalização de Processo', Help='Personalização de Processo',Updated=TO_DATE('2017-11-24 12:09:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200234 AND AD_Language='pt_BR'
;

-- 24/11/2017 12h9min47s BRST
UPDATE AD_Tab_Trl SET Name='Personalização de Parâmetro', Description='Personalização de Parâmetro', Help='Personalização de Parâmetro',Updated=TO_DATE('2017-11-24 12:09:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200235 AND AD_Language='pt_BR'
;

-- 24/11/2017 13h8min44s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213295,0,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200232,'AD_Process_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2017-11-24 13:08:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 13:08:44','YYYY-MM-DD HH24:MI:SS'),100,117,'Y','N','D','N','N','N','Y','135df6ac-860c-470f-9df7-d47bbba35734','Y',0,'N','N','N')
;

-- 24/11/2017 13h8min44s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213295 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 13h8min48s BRST
UPDATE AD_Column SET FKConstraintName='ADProcess_ADUserDefProc', FKConstraintType='N',Updated=TO_DATE('2017-11-24 13:08:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213295
;

-- 24/11/2017 13h8min48s BRST
ALTER TABLE AD_UserDef_Proc ADD AD_Process_ID NUMBER(10) NOT NULL
;

-- 24/11/2017 13h8min48s BRST
ALTER TABLE AD_UserDef_Proc ADD CONSTRAINT ADProcess_ADUserDefProc FOREIGN KEY (AD_Process_ID) REFERENCES ad_process(ad_process_id) DEFERRABLE INITIALLY DEFERRED
;

-- 24/11/2017 13h9min53s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205272,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200234,213295,'Y',22,120,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 13:09:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 13:09:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9320cfa5-4e73-4cf4-b261-3c1fe34aa439','Y',110,2)
;

-- 24/11/2017 13h9min53s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205272 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 13h12min50s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205272
;

-- 24/11/2017 13h12min51s BRST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205248
;

-- 24/11/2017 13h12min51s BRST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205249
;

-- 24/11/2017 13h12min51s BRST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205250
;

-- 24/11/2017 13h12min51s BRST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205255
;

-- 24/11/2017 13h12min51s BRST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205254
;

-- 24/11/2017 13h12min51s BRST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205256
;

-- 24/11/2017 13h12min51s BRST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 13:12:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205257
;

-- 24/11/2017 15h8min13s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213297,0,'Process Parameter',200233,186,'AD_Process_Para_ID',10,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_DATE('2017-11-24 15:08:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 15:08:13','YYYY-MM-DD HH24:MI:SS'),100,118,'Y','N','@AD_Window_ID@>0 | @AD_Form_ID@>0 | @AD_Task_ID@>0 | @AD_Workflow_ID@>0','D','N','N','N','Y','92ec5e88-0aad-4b51-89c1-b0ce1870c8ca','Y',0,'N','N','N')
;

-- 24/11/2017 15h8min13s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213297 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 24/11/2017 15h8min18s BRST
UPDATE AD_Column SET FKConstraintName='ADProcessPara_ADUserDefProcPar', FKConstraintType='N',Updated=TO_DATE('2017-11-24 15:08:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213297
;

-- 24/11/2017 15h8min18s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD AD_Process_Para_ID NUMBER(10) NOT NULL
;

-- 24/11/2017 15h8min18s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD CONSTRAINT ADProcessPara_ADUserDefProcPar FOREIGN KEY (AD_Process_Para_ID) REFERENCES ad_process_para(ad_process_para_id) DEFERRABLE INITIALLY DEFERRED
;

-- 24/11/2017 15h8min48s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (205274,'Process Parameter',200235,213297,'Y',10,130,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-24 15:08:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 15:08:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8eb9f6c6-dd1e-440c-bde6-0f07feb6f181','Y',110,2)
;

-- 24/11/2017 15h8min48s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205274 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 24/11/2017 15h9min1s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-24 15:09:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205274
;

-- 24/11/2017 15h9min27s BRST
UPDATE AD_Column SET AD_Reference_ID=17, FKConstraintType=NULL,Updated=TO_DATE('2017-11-24 15:09:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213297
;

-- 24/11/2017 15h10min32s BRST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200112,'AD_Process_Para of AD_UserDef_Proc','S','AD_Process_Para.AD_Process_ID=@AD_Process_ID@',0,0,'Y',TO_DATE('2017-11-24 15:10:32','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-24 15:10:32','YYYY-MM-DD HH24:MI:SS'),100,'D','e363b179-0d30-45a0-8377-af37ea623746')
;

-- 24/11/2017 16h21min55s BRST
UPDATE AD_Column SET AD_Reference_ID=19,Updated=TO_DATE('2017-11-24 16:21:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213297
;

-- 24/11/2017 16h22min41s BRST
UPDATE AD_Val_Rule SET Code='AD_Process_Para_ID IN (select AD_Process_Para_ID from AD_Process_Para where AD_Process_ID=@0|AD_Process_ID@)',Updated=TO_DATE('2017-11-24 16:22:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200112
;

-- 24/11/2017 16h49min4s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD Name VARCHAR2(60) DEFAULT NULL
;

-- 28/11/2017 13h59min44s BRST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutProcessCustomization.processParameter',Updated=TO_DATE('2017-11-28 13:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213297
;

-- 29/11/2017 9h52min41s BRST
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=205268
;

-- 29/11/2017 9h52min42s BRST
DELETE FROM AD_Field WHERE AD_Field_ID=205268
;

-- 29/11/2017 9h55min49s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213301,0,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200233,'ReadOnlyLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2017-11-29 09:55:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-29 09:55:49','YYYY-MM-DD HH24:MI:SS'),100,1663,'Y','N','D','N','N','N','Y','6ce5dae0-ab1f-42f4-a489-2db84a15b009','Y',0,'N','N')
;

-- 29/11/2017 9h55min50s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213301 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 29/11/2017 9h55min54s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD ReadOnlyLogic VARCHAR2(2000) DEFAULT NULL
;

-- 29/11/2017 9h56min51s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (205275,'Read Only Logic','Logic to determine if field is read only (applies only when field is read-write)','format := {expression} [{logic} {expression}]<br>
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br>
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
'||chr(64)||'AD_Table_ID@=14 | @Language@!GERGER <br>
'||chr(64)||'PriceLimit@>10 | @PriceList@>@PriceActual@<br>
'||chr(64)||'Name@>J<br>
Strings may be in single quotes (optional)',200235,213301,'Y',2000,110,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-29 09:56:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-29 09:56:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','98045d11-a9d4-43c5-8d4c-0196498928c0','Y',120,5,3)
;

-- 29/11/2017 9h56min51s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205275 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 29/11/2017 10h0min28s BRST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 10:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205274
;

-- 29/11/2017 10h0min28s BRST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 10:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205262
;

-- 29/11/2017 10h0min28s BRST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 10:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205263
;

-- 29/11/2017 10h0min28s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 10:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205275
;

-- 29/11/2017 10h0min28s BRST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=3, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 10:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205270
;

-- 29/11/2017 10h0min28s BRST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 10:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205269
;

-- 29/11/2017 10h0min28s BRST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 10:00:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

-- 29/11/2017 10h7min22s BRST
UPDATE AD_Column SET SeqNo=3, IsUpdateable='N', IsAllowCopy='N',Updated=TO_DATE('2017-11-29 10:07:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213260
;

-- 29/11/2017 10h7min37s BRST
UPDATE AD_Column SET SeqNo=1,Updated=TO_DATE('2017-11-29 10:07:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213271
;

-- 29/11/2017 10h7min49s BRST
UPDATE AD_Column SET SeqNo=0, IsUpdateable='N',Updated=TO_DATE('2017-11-29 10:07:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213260
;

-- 29/11/2017 15h43min46s BRST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213302,0,'Mandatory Logic',200233,'MandatoryLogic',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_DATE('2017-11-29 15:43:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-29 15:43:46','YYYY-MM-DD HH24:MI:SS'),100,50074,'Y','N','D','N','N','N','Y','acd1912c-38e2-4e4d-9d15-4db08d487255','Y',0,'N','N')
;

-- 29/11/2017 15h43min46s BRST
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=213302 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- 29/11/2017 15h43min50s BRST
ALTER TABLE AD_UserDef_Proc_Parameter ADD MandatoryLogic VARCHAR2(2000) DEFAULT NULL
;

-- 29/11/2017 15h45min20s BRST
UPDATE AD_Table SET AD_Window_ID=200095,Updated=TO_DATE('2017-11-29 15:45:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200233
;

-- 29/11/2017 15h46min5s BRST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (205276,'Mandatory Logic',200235,213302,'Y',2000,130,'N','N','N','N',0,0,'Y',TO_DATE('2017-11-29 15:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-11-29 15:46:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a1bdbd0-155d-4a7f-ab89-fba27a1f5302','Y',130,5,3)
;

-- 29/11/2017 15h46min5s BRST
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Name,Description,Help, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Name,t.Description,t.Help, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=205276 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- 29/11/2017 15h52min36s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 15:52:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205276
;

-- 29/11/2017 15h52min36s BRST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 15:52:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205269
;

-- 29/11/2017 15h52min36s BRST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-29 15:52:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205267
;

-- 30/11/2017 14h42min1s BRST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutProcessCustomization.process',Updated=TO_DATE('2017-11-30 14:42:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213295
;

-- 30/11/2017 14h45min59s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-30 14:45:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205254
;

-- 30/11/2017 14h45min59s BRST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-30 14:45:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205258
;

-- 30/11/2017 14h45min59s BRST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-30 14:45:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205248
;

-- 30/11/2017 14h45min59s BRST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-30 14:45:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205249
;

-- 30/11/2017 14h45min59s BRST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-30 14:45:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205250
;

-- 30/11/2017 14h45min59s BRST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2017-11-30 14:45:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205255
;

-- 30/11/2017 14h48min54s BRST
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=205257
;

-- 30/11/2017 14h48min54s BRST
DELETE FROM AD_Field WHERE AD_Field_ID=205257
;

-- 30/11/2017 14h56min29s BRST
UPDATE AD_Column SET AD_Reference_ID=19, FKConstraintType=NULL,Updated=TO_DATE('2017-11-30 14:56:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213270
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200145
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200142
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53203
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=586
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=138
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=139
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200065
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200063
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=249
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=141
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=300
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=589
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200000
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=295
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=216
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=140
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=142
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53012
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=143
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=201
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=20, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=176
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=21, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200072
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=22, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53086
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=23, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=239
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=24, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=517
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=25, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=499
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=26, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200150
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=27, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53089
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=28, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53090
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=29, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200038
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=30, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200143
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=31, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200141
;

-- May 16, 2019, 9:25:26 AM BRT
UPDATE AD_TreeNodeMM SET Parent_ID=153, SeqNo=32, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50001
;

-- May 16, 2019, 9:25:42 AM BRT
UPDATE AD_Menu SET Name='Process Customization',Updated=TO_DATE('2019-05-16 09:25:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200150
;

-- May 16, 2019, 9:25:56 AM BRT
UPDATE AD_Window SET Name='Process Customization', Description='Process Customization', Help='Process Customization',Updated=TO_DATE('2019-05-16 09:25:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200095
;

-- May 16, 2019, 9:25:56 AM BRT
UPDATE AD_Menu SET Name='Process Customization', Description='Process Customization', IsActive='Y',Updated=TO_DATE('2019-05-16 09:25:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200150
;

-- May 16, 2019, 9:26:08 AM BRT
UPDATE AD_Tab SET Name='Process Customization',Updated=TO_DATE('2019-05-16 09:26:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200234
;

-- May 16, 2019, 9:26:17 AM BRT
UPDATE AD_Table SET Name='Process Customization',Updated=TO_DATE('2019-05-16 09:26:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200232
;

SELECT register_migration_script('201905160920_IDEMPIERE-3971.sql') FROM dual
;
