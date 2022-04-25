-- IDEMPIERE-5259
SELECT register_migration_script('202204151349_IDEMPIERE-5259.sql') FROM dual;

-- Apr 15, 2022, 1:49:28 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200337,'Label Category','C_LabelCategory','3',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','e497a660-02e7-462c-9cd1-740bdbb38e1e','N')
;

-- Apr 15, 2022, 1:49:28 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_LabelCategory',1000000,'N','N','Table C_LabelCategory','Y','Y',0,0,TO_TIMESTAMP('2022-04-15 13:49:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:28','YYYY-MM-DD HH24:MI:SS'),100,200406,'Y',1000000,1,200000,'12273cf5-5902-406d-913a-b58120468cbf')
;

-- Apr 15, 2022, 1:49:29 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214759,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200337,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:28','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','b40de7ac-6115-4b10-bb88-c20f64c19cc9','N')
;

-- Apr 15, 2022, 1:49:29 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214760,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200337,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:29','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','26da493c-529a-4fca-ad8f-9fc24a199c12','N')
;

-- Apr 15, 2022, 1:49:29 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214761,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200337,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:29','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','152c01c7-db84-489f-95df-ad18da6baa86','N')
;

-- Apr 15, 2022, 1:49:30 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214762,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200337,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:29','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','96c57dbd-662f-4319-81ad-502445924425','N')
;

-- Apr 15, 2022, 1:49:30 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214763,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200337,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:30','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','e46ea276-7277-4445-a0c3-27c9f79fcaa1','N')
;

-- Apr 15, 2022, 1:49:30 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214764,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200337,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:30','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','5e611c1c-7553-4aa7-af2a-ae20f4dc4ad4','N')
;

-- Apr 15, 2022, 1:49:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214765,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200337,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:30','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','6d5a5aac-1f07-4757-9a5f-4df800f653b7','N')
;

-- Apr 15, 2022, 1:49:31 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203574,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:31','YYYY-MM-DD HH24:MI:SS'),100,'C_LabelCategory_ID','Label Category','Label Category','D','460ee4c5-5030-40dc-a272-9aad4290fe90')
;

-- Apr 15, 2022, 1:49:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214766,0.0,'Label Category',200337,'C_LabelCategory_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:31','YYYY-MM-DD HH24:MI:SS'),100,203574,'N','N','D','N','e41ecebd-3659-4bf3-a59c-ca34c0922649','N')
;

-- Apr 15, 2022, 1:49:32 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203575,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:31','YYYY-MM-DD HH24:MI:SS'),100,'C_LabelCategory_UU','C_LabelCategory_UU','C_LabelCategory_UU','D','581b49d2-2e5c-459b-916e-bdc445926f20')
;

-- Apr 15, 2022, 1:49:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214767,0.0,'C_LabelCategory_UU',200337,'C_LabelCategory_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:32','YYYY-MM-DD HH24:MI:SS'),100,203575,'Y','N','D','N','3acb6a70-a947-4a92-ae0a-e4f346847ac4','N')
;

-- Apr 15, 2022, 1:49:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214768,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200337,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:49:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:49:32','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','bbfd109d-0654-4a6d-b2c2-fcc413c26e82',10,'N')
;

-- Apr 15, 2022, 1:50:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214769,0,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200337,'IsDefault','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:50:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:50:02','YYYY-MM-DD HH24:MI:SS'),100,1103,'Y','N','D','N','N','N','Y','05fdb3bd-909a-408d-ba9d-5f2f22bea4ae','Y',0,'N','N','N')
;

-- Apr 15, 2022, 1:50:42 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CLabelCategory', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:50:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214759
;

-- Apr 15, 2022, 1:50:42 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CLabelCategory', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:50:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214760
;

-- Apr 15, 2022, 1:50:42 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CLabelCategory', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:50:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214762
;

-- Apr 15, 2022, 1:50:42 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CLabelCategory', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:50:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214764
;

-- Apr 15, 2022, 1:50:42 PM CEST
CREATE TABLE C_LabelCategory (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_LabelCategory_ID NUMERIC(10) NOT NULL, C_LabelCategory_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsDefault CHAR(1) DEFAULT 'N' CHECK (IsDefault IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_LabelCategory_Key PRIMARY KEY (C_LabelCategory_ID), CONSTRAINT C_LabelCategory_UU_idx UNIQUE (C_LabelCategory_UU))
;

-- Apr 15, 2022, 1:50:42 PM CEST
ALTER TABLE C_LabelCategory ADD CONSTRAINT ADClient_CLabelCategory FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:50:42 PM CEST
ALTER TABLE C_LabelCategory ADD CONSTRAINT ADOrg_CLabelCategory FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:50:42 PM CEST
ALTER TABLE C_LabelCategory ADD CONSTRAINT CreatedBy_CLabelCategory FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:50:42 PM CEST
ALTER TABLE C_LabelCategory ADD CONSTRAINT UpdatedBy_CLabelCategory FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:51:10 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200338,'Label','C_Label','3',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:10','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','6d94c697-23eb-46db-acf4-f46277a092a0','N')
;

-- Apr 15, 2022, 1:51:11 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_Label',1000000,'N','N','Table C_Label','Y','Y',0,0,TO_TIMESTAMP('2022-04-15 13:51:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:10','YYYY-MM-DD HH24:MI:SS'),100,200407,'Y',1000000,1,200000,'c0fbe174-e897-4c30-979d-9f48a77ea2a6')
;

-- Apr 15, 2022, 1:51:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214770,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200338,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:11','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','f0e216b7-6079-482f-97c6-3c3248d6bede','N')
;

-- Apr 15, 2022, 1:51:11 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214771,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200338,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:11','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','66bbb8bb-ece8-458e-aaa7-303ba79161de','N')
;

-- Apr 15, 2022, 1:51:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214772,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200338,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:11','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','84b687e4-c9c4-442e-88c9-86778a78f316','N')
;

-- Apr 15, 2022, 1:51:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214773,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200338,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:12','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','68e1d399-9171-4da6-83b2-863206a04549','N')
;

-- Apr 15, 2022, 1:51:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214774,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200338,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:12','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','55b7739a-ed23-4981-aa0f-2f8617b3de52','N')
;

-- Apr 15, 2022, 1:51:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214775,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200338,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:12','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','98fe3ca4-b5b0-472c-865d-758f2f35d58f','N')
;

-- Apr 15, 2022, 1:51:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214776,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200338,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:13','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','9e7560e5-3e90-43d1-a965-eb7cdda7fdd9','N')
;

-- Apr 15, 2022, 1:51:13 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203576,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:13','YYYY-MM-DD HH24:MI:SS'),100,'C_Label_ID','Label','Label','D','4fed11ff-e6d7-4ed1-a993-f7779a421792')
;

-- Apr 15, 2022, 1:51:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214777,0.0,'Label',200338,'C_Label_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:13','YYYY-MM-DD HH24:MI:SS'),100,203576,'N','N','D','N','d5b9a2e7-8eca-44cf-92af-9f56224fbdc8','N')
;

-- Apr 15, 2022, 1:51:14 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203577,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:14','YYYY-MM-DD HH24:MI:SS'),100,'C_Label_UU','C_Label_UU','C_Label_UU','D','e630e483-49c6-4b19-9f59-96bd092ed54c')
;

-- Apr 15, 2022, 1:51:14 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214778,0.0,'C_Label_UU',200338,'C_Label_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:14','YYYY-MM-DD HH24:MI:SS'),100,203577,'Y','N','D','N','181a2afd-3f23-4838-8a8d-51061802a163','N')
;

-- Apr 15, 2022, 1:51:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214779,0.0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200338,'Value',40,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:14','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','N','b358cc9c-3438-4eb5-8761-fed067be5677',10,'N')
;

-- Apr 15, 2022, 1:51:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214780,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200338,'Name',60,'N','N','Y','Y','Y','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:15','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','6bb060d1-fdc2-411a-a7b4-980db524eadb',20,'N')
;

-- Apr 15, 2022, 1:51:15 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200339,'Label Trl','C_Label_Trl','3',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:15','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','D','Y','L','d7fd3cf2-3876-4ead-8413-26a8e640f905','N')
;

-- Apr 15, 2022, 1:51:16 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_Label_Trl',1000000,'N','N','Table C_Label_Trl','Y','Y',0,0,TO_TIMESTAMP('2022-04-15 13:51:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:15','YYYY-MM-DD HH24:MI:SS'),100,200408,'Y',1000000,1,200000,'3e804cf1-5224-4306-8304-807c7673ed88')
;

-- Apr 15, 2022, 1:51:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214781,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200339,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:16','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','42817461-2acd-4a6b-b063-17c268f5c918','N')
;

-- Apr 15, 2022, 1:51:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214782,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200339,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:16','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','4ec11a3f-64f9-4f36-a477-4ccaf3d88db7','N')
;

-- Apr 15, 2022, 1:51:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214783,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200339,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:16','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','6cf2f0d9-ff06-444d-b678-2e0313ace11a','N')
;

-- Apr 15, 2022, 1:51:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214784,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200339,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:17','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','e3ba8dbb-101e-4de4-a7b0-20839d0b35eb','N')
;

-- Apr 15, 2022, 1:51:17 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214785,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200339,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:17','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','d57689cc-22e2-40b7-837a-0e9d084cbf76','N')
;

-- Apr 15, 2022, 1:51:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214786,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200339,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:17','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','6659e483-ad5b-4a8c-91c9-4b0530475989','N')
;

-- Apr 15, 2022, 1:51:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214787,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200339,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:18','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','da9e5d28-22f8-49d5-a09c-b1c9e0b9fbb9','N')
;

-- Apr 15, 2022, 1:51:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (214788,0.0,'Label',200339,'C_Label_ID',10,'N','Y','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:18','YYYY-MM-DD HH24:MI:SS'),100,203576,'N','N','D','N','8b205818-3e55-40bd-be67-510ca8d9d6ff','N','C')
;

-- Apr 15, 2022, 1:51:19 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203578,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,'C_Label_Trl_UU','C_Label_Trl_UU','C_Label_Trl_UU','D','4ec17ab0-d024-423e-8507-9cb40188b4d3')
;

-- Apr 15, 2022, 1:51:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214789,0.0,'C_Label_Trl_UU',200339,'C_Label_Trl_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,203578,'Y','N','D','N','1f301efa-64a9-4268-a699-d164255b4233','N')
;

-- Apr 15, 2022, 1:51:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214790,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200339,'AD_Language',6,'N','Y','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','N','f1f6d622-1afc-4615-b78d-2ac70be6010a','N')
;

-- Apr 15, 2022, 1:51:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214791,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200339,'IsTranslated','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:20','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','N','2a670d43-b53f-4781-9ec5-5893195d079b','N')
;

-- Apr 15, 2022, 1:51:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214792,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200339,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:20','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','8951368e-a06d-4b11-8fc2-94511520318a',10,'N')
;

-- Apr 15, 2022, 1:51:21 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201117,'17940a28-0623-4fd3-a8e6-c6f5f58d7aec',TO_TIMESTAMP('2022-04-15 13:51:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_Label_Trl_pkey',TO_TIMESTAMP('2022-04-15 13:51:20','YYYY-MM-DD HH24:MI:SS'),100,200339,'Y','Y','N','Y')
;

-- Apr 15, 2022, 1:51:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201491,'37177286-332e-475c-af3f-147a6f768dc6',TO_TIMESTAMP('2022-04-15 13:51:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-04-15 13:51:21','YYYY-MM-DD HH24:MI:SS'),100,214790,201117,1)
;

-- Apr 15, 2022, 1:51:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201492,'16a35d1d-4023-4f7f-bcc5-85db7cbe2005',TO_TIMESTAMP('2022-04-15 13:51:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-04-15 13:51:21','YYYY-MM-DD HH24:MI:SS'),100,214788,201117,2)
;

-- Apr 15, 2022, 1:51:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214793,0,'Label Category',200338,'C_LabelCategory_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:51:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:51:56','YYYY-MM-DD HH24:MI:SS'),100,203574,'N','N','D','N','N','N','Y','5bdd55eb-12ba-49f9-a67c-831f93fb633b','Y',0,'N','N','N','N')
;

-- Apr 15, 2022, 1:52:19 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CLabel', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214770
;

-- Apr 15, 2022, 1:52:19 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CLabel', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214771
;

-- Apr 15, 2022, 1:52:19 PM CEST
UPDATE AD_Column SET FKConstraintName='CLabelCategory_CLabel', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214793
;

-- Apr 15, 2022, 1:52:19 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CLabel', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214773
;

-- Apr 15, 2022, 1:52:19 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CLabel', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214775
;

-- Apr 15, 2022, 1:52:19 PM CEST
CREATE TABLE C_Label (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_Label_ID NUMERIC(10) NOT NULL, C_Label_UU VARCHAR(36) DEFAULT NULL , C_LabelCategory_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, Value VARCHAR(40) DEFAULT NULL , CONSTRAINT C_Label_Key PRIMARY KEY (C_Label_ID), CONSTRAINT C_Label_UU_idx UNIQUE (C_Label_UU))
;

-- Apr 15, 2022, 1:52:19 PM CEST
ALTER TABLE C_Label ADD CONSTRAINT ADClient_CLabel FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:19 PM CEST
ALTER TABLE C_Label ADD CONSTRAINT ADOrg_CLabel FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:19 PM CEST
ALTER TABLE C_Label ADD CONSTRAINT CLabelCategory_CLabel FOREIGN KEY (C_LabelCategory_ID) REFERENCES c_labelcategory(c_labelcategory_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:19 PM CEST
ALTER TABLE C_Label ADD CONSTRAINT CreatedBy_CLabel FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:19 PM CEST
ALTER TABLE C_Label ADD CONSTRAINT UpdatedBy_CLabel FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:27 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CLabelTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214781
;

-- Apr 15, 2022, 1:52:27 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADLanguage_CLabelTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214790
;

-- Apr 15, 2022, 1:52:27 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CLabelTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214782
;

-- Apr 15, 2022, 1:52:27 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='CLabel_CLabelTrl', FKConstraintType='C',Updated=TO_TIMESTAMP('2022-04-15 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214788
;

-- Apr 15, 2022, 1:52:27 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CLabelTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214784
;

-- Apr 15, 2022, 1:52:27 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CLabelTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:52:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214786
;

-- Apr 15, 2022, 1:52:27 PM CEST
CREATE TABLE C_Label_Trl (AD_Client_ID NUMERIC(10) NOT NULL, AD_Language VARCHAR(6) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, C_Label_ID NUMERIC(10) NOT NULL, C_Label_Trl_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR(60) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_Label_Trl_UU_idx UNIQUE (C_Label_Trl_UU))
;

-- Apr 15, 2022, 1:52:27 PM CEST
ALTER TABLE C_Label_Trl ADD CONSTRAINT ADClient_CLabelTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:27 PM CEST
ALTER TABLE C_Label_Trl ADD CONSTRAINT ADLanguage_CLabelTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:27 PM CEST
ALTER TABLE C_Label_Trl ADD CONSTRAINT ADOrg_CLabelTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:27 PM CEST
ALTER TABLE C_Label_Trl ADD CONSTRAINT CLabel_CLabelTrl FOREIGN KEY (C_Label_ID) REFERENCES c_label(c_label_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:27 PM CEST
ALTER TABLE C_Label_Trl ADD CONSTRAINT CreatedBy_CLabelTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:52:27 PM CEST
ALTER TABLE C_Label_Trl ADD CONSTRAINT UpdatedBy_CLabelTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:53:02 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200124,'Label Category',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:01','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','N','N','N','3be76d84-eea9-4906-9457-14ed7b71cf34')
;

-- Apr 15, 2022, 1:53:02 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200310,'Label Category',200124,10,'Y',200337,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:02','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','C_LabelCategory.Name','N',0,'N','D','Y','N','1416b763-91f6-4502-b211-72afbcfbdb6f')
;

-- Apr 15, 2022, 1:53:03 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206949,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200310,214759,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','30582703-e0d6-43b3-abf4-9f793b8145f9','N',2)
;

-- Apr 15, 2022, 1:53:03 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206950,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200310,214760,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a1d0a22-036f-4734-9b0e-0d258b3d07e7','Y','Y',10,4,2)
;

-- Apr 15, 2022, 1:53:03 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206951,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200310,214768,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','45918909-c97b-48ca-a1a2-de815dafbbab','Y',20,5)
;

-- Apr 15, 2022, 1:53:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206952,'Label Category',200310,214766,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a43dfccd-ed14-4d8e-9e46-daa299d04bfb','N',2)
;

-- Apr 15, 2022, 1:53:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206953,'C_LabelCategory_UU',200310,214767,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','85ac27a1-d79a-4004-90a0-3ea977dab1c1','N',2)
;

-- Apr 15, 2022, 1:53:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206954,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200310,214769,'Y',1,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e6262269-b0d2-4729-8d2b-3d34903abdd2','Y',30,2,2)
;

-- Apr 15, 2022, 1:53:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206955,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200310,214765,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bf72eab7-ead0-4d14-b604-2e557e6d943f','Y',40,2,2)
;

-- Apr 15, 2022, 1:53:05 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200202,'Label Category','W',200124,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:53:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:53:05','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','2f9034b8-70cf-42e2-861d-8dbda4f633f2')
;

-- Apr 15, 2022, 1:53:05 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200202, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200202)
;

-- Apr 15, 2022, 1:53:05 PM CEST
UPDATE AD_Table SET AD_Window_ID=200124,Updated=TO_TIMESTAMP('2022-04-15 13:53:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200337
;

-- Apr 15, 2022, 1:53:30 PM CEST
UPDATE AD_Window SET Name='Labels',Updated=TO_TIMESTAMP('2022-04-15 13:53:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200124
;

-- Apr 15, 2022, 1:53:30 PM CEST
UPDATE AD_Menu SET Name='Labels', Description=NULL, IsActive='Y',Updated=TO_TIMESTAMP('2022-04-15 13:53:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200202
;

-- Apr 15, 2022, 1:53:57 PM CEST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:53:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206951
;

-- Apr 15, 2022, 1:53:57 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:53:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206954
;

-- Apr 15, 2022, 1:53:57 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:53:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206955
;

-- Apr 15, 2022, 1:53:57 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:53:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206953
;

-- Apr 15, 2022, 1:53:57 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:53:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206952
;

-- Apr 15, 2022, 1:55:28 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200311,'Label',200124,20,'Y',200338,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:27','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','1e43ea08-7cd4-4561-bcc0-fca500342469','B','N','Y',0)
;

-- Apr 15, 2022, 1:55:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206956,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200311,214770,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9000a6f2-ee93-4017-8d4b-11de99a4241a','N',2)
;

-- Apr 15, 2022, 1:55:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206957,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200311,214771,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1dd51ece-9012-4235-b84e-175a310c0a0a','Y','Y',10,4,2)
;

-- Apr 15, 2022, 1:55:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206958,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200311,214779,'Y',40,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','326831c5-f66d-493e-9bf1-08ab8dc4efb0','Y',20,2)
;

-- Apr 15, 2022, 1:55:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206959,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200311,214780,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aaf15cd7-fd63-4c36-b3c9-21a0c5d48c50','Y',30,5)
;

-- Apr 15, 2022, 1:55:35 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206960,'Label',200311,214777,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d6e79972-7bf6-4f44-b635-bf7117f22da2','N',2)
;

-- Apr 15, 2022, 1:55:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206961,'C_Label_UU',200311,214778,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f511d690-afbb-4e79-aa56-548fcbf16a83','N',2)
;

-- Apr 15, 2022, 1:55:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206962,'Label Category',200311,214793,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','50030169-9b64-456d-8f2e-e50e2aa7e4db','Y',40,2)
;

-- Apr 15, 2022, 1:55:36 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206963,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200311,214776,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:55:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:55:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','862f5c3c-0fa2-4b0b-b199-5fa22f0241df','Y',50,2,2)
;

-- Apr 15, 2022, 1:56:10 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200312,'Translation',200124,30,'Y',200339,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:09','YYYY-MM-DD HH24:MI:SS'),100,'N','N','Y','N','N','N',2,'N','D','N','N','8a75d1d1-2727-4a99-88a9-1f09a45ebb44','B','N','N',0)
;

-- Apr 15, 2022, 1:56:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206964,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200312,214781,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b7ed3547-02c5-4b8b-b433-177e91e0aa15','N',2)
;

-- Apr 15, 2022, 1:56:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206965,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200312,214782,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dff6c354-dc67-4c6a-a4a8-13fd73bae971','Y','Y',10,4,2)
;

-- Apr 15, 2022, 1:56:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206966,'Label',200312,214788,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','21fa5b94-9473-4c3b-877e-5a1dd1917eef','Y',20,2)
;

-- Apr 15, 2022, 1:56:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206967,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200312,214790,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','345bfb88-4982-4177-8f03-679882da4110','Y',30,2)
;

-- Apr 15, 2022, 1:56:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206968,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200312,214792,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ce0fa437-ccf3-4e83-8167-42bf58b906ef','Y',40,5)
;

-- Apr 15, 2022, 1:56:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206969,'C_Label_Trl_UU',200312,214789,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','30b4b01d-099c-4fa5-94e5-ced257a4c515','N',2)
;

-- Apr 15, 2022, 1:56:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206970,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200312,214791,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d300cb6c-31f1-406a-91f3-d1b052c3cee0','Y',50,2,2)
;

-- Apr 15, 2022, 1:56:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206971,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200312,214787,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:56:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:56:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4dac9c3f-670b-4317-bead-f41b2def8710','Y',60,2,2)
;

-- Apr 15, 2022, 1:56:34 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206962
;

-- Apr 15, 2022, 1:56:34 PM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206958
;

-- Apr 15, 2022, 1:56:34 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206963
;

-- Apr 15, 2022, 1:56:34 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206959
;

-- Apr 15, 2022, 1:56:34 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206961
;

-- Apr 15, 2022, 1:56:34 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206960
;

-- Apr 15, 2022, 1:56:56 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206967
;

-- Apr 15, 2022, 1:56:56 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206968
;

-- Apr 15, 2022, 1:56:56 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206970
;

-- Apr 15, 2022, 1:56:56 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206971
;

-- Apr 15, 2022, 1:56:56 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 13:56:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206969
;

-- Apr 15, 2022, 1:57:04 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206966
;

-- Apr 15, 2022, 1:57:04 PM CEST
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206965
;

-- Apr 15, 2022, 1:57:04 PM CEST
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206967
;

-- Apr 15, 2022, 1:57:04 PM CEST
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206968
;

-- Apr 15, 2022, 1:57:04 PM CEST
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206970
;

-- Apr 15, 2022, 1:57:04 PM CEST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206971
;

-- Apr 15, 2022, 1:57:37 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200340,'Label Assignment','C_LabelAssignment','3',0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','9fcd37b5-c37f-45ce-9506-7a80a06f52f3','N')
;

-- Apr 15, 2022, 1:57:37 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_LabelAssignment',1000000,'N','N','Table C_LabelAssignment','Y','Y',0,0,TO_TIMESTAMP('2022-04-15 13:57:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:37','YYYY-MM-DD HH24:MI:SS'),100,200409,'Y',1000000,1,200000,'bcad7059-ed66-45ec-84f1-548b66c64158')
;

-- Apr 15, 2022, 1:57:37 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214794,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200340,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:37','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','4cb09c57-780e-4af3-b88b-e11079ea5be1','N')
;

-- Apr 15, 2022, 1:57:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214795,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200340,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:37','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','bde5d325-e18d-479a-8452-8c4e9c929c5b','N')
;

-- Apr 15, 2022, 1:57:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214796,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200340,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:38','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','d8bb1b97-6e57-4e5d-9486-9c883e0fe940','N')
;

-- Apr 15, 2022, 1:57:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214797,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200340,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:38','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','ca034ac2-a1c8-4a2e-991c-e5d3d359232b','N')
;

-- Apr 15, 2022, 1:57:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214798,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200340,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:38','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','33c661c4-f2c9-4a85-a448-5c1b2e88b060','N')
;

-- Apr 15, 2022, 1:57:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214799,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200340,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:39','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','cd85c4bd-bce8-4883-9f77-f2c3e939dc56','N')
;

-- Apr 15, 2022, 1:57:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214800,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200340,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:39','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','5f909cbb-d355-4e0d-b3db-6809a409ffef','N')
;

-- Apr 15, 2022, 1:57:40 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203579,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:39','YYYY-MM-DD HH24:MI:SS'),100,'C_LabelAssignment_ID','Label Assignment','Label Assignment','D','85eaebda-f072-4990-a595-ba2bbb711eae')
;

-- Apr 15, 2022, 1:57:40 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214801,0.0,'Label Assignment',200340,'C_LabelAssignment_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:40','YYYY-MM-DD HH24:MI:SS'),100,203579,'N','N','D','N','e8dd3a64-7125-4c1d-950c-4c8b67a5ebcf','N')
;

-- Apr 15, 2022, 1:57:40 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203580,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:40','YYYY-MM-DD HH24:MI:SS'),100,'C_LabelAssignment_UU','C_LabelAssignment_UU','C_LabelAssignment_UU','D','54414549-f981-4e0c-a841-40d957070d07')
;

-- Apr 15, 2022, 1:57:41 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214802,0.0,'C_LabelAssignment_UU',200340,'C_LabelAssignment_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:40','YYYY-MM-DD HH24:MI:SS'),100,203580,'Y','N','D','N','d8c2958b-806f-4d92-a2da-ee694fd818db','N')
;

-- Apr 15, 2022, 1:57:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214803,0,'Table','Database Table information','The Database Table provides the information of the table definition',200340,'AD_Table_ID',10,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:57:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:57:56','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','N','N','Y','e4adc93c-10a8-4afe-bfec-078c89c24e48','Y',0,'N','N','N','N')
;

-- Apr 15, 2022, 1:58:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214804,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200340,'Record_ID',22,'N','N','Y','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:58:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:58:43','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','N','N','N','Y','083b781a-eba4-424f-ae86-ab0c55cde593','Y',0,'B','N','N')
;

-- Apr 15, 2022, 1:59:03 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214805,0,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',200340,'Comments',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2022-04-15 13:59:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 13:59:03','YYYY-MM-DD HH24:MI:SS'),100,230,'Y','N','D','N','N','N','Y','8c9f2970-7d86-48c4-9bb2-a79d736ff498','N',0,'N','N','N')
;

-- Apr 15, 2022, 1:59:44 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214794
;

-- Apr 15, 2022, 1:59:44 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214795
;

-- Apr 15, 2022, 1:59:44 PM CEST
UPDATE AD_Column SET FKConstraintName='ADTable_CLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214803
;

-- Apr 15, 2022, 1:59:44 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214797
;

-- Apr 15, 2022, 1:59:44 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 13:59:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214799
;

-- Apr 15, 2022, 1:59:44 PM CEST
CREATE TABLE C_LabelAssignment (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Table_ID NUMERIC(10) NOT NULL, C_LabelAssignment_ID NUMERIC(10) NOT NULL, C_LabelAssignment_UU VARCHAR(36) DEFAULT NULL , Comments VARCHAR(2000) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Record_ID NUMERIC(10) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT C_LabelAssignment_Key PRIMARY KEY (C_LabelAssignment_ID), CONSTRAINT C_LabelAssignment_UU_idx UNIQUE (C_LabelAssignment_UU))
;

-- Apr 15, 2022, 1:59:44 PM CEST
ALTER TABLE C_LabelAssignment ADD CONSTRAINT ADClient_CLabelAssignment FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:59:44 PM CEST
ALTER TABLE C_LabelAssignment ADD CONSTRAINT ADOrg_CLabelAssignment FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:59:44 PM CEST
ALTER TABLE C_LabelAssignment ADD CONSTRAINT ADTable_CLabelAssignment FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:59:44 PM CEST
ALTER TABLE C_LabelAssignment ADD CONSTRAINT CreatedBy_CLabelAssignment FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 1:59:44 PM CEST
ALTER TABLE C_LabelAssignment ADD CONSTRAINT UpdatedBy_CLabelAssignment FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 2:00:03 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200125,'Label Assignment',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:03','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','N','N','N','1a360e71-dd45-40e3-aaff-a46ceb158fbb')
;

-- Apr 15, 2022, 2:00:03 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200313,'Label Assignment',200125,10,'Y',200340,0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','C_LabelAssignment.Created DESC','N',0,'N','D','Y','N','ebf44faf-663e-4c33-85e7-fc7114aa1318')
;

-- Apr 15, 2022, 2:00:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206972,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200313,214794,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a5e0679c-f943-4627-ab1b-323d5137bf72','N',2)
;

-- Apr 15, 2022, 2:00:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206973,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200313,214795,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','93213971-9587-49ac-a129-a6d6246356dc','Y','Y',10,4,2)
;

-- Apr 15, 2022, 2:00:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206974,'Label Assignment',200313,214801,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3284b09b-1396-477a-8f30-c0800de30eb8','N',2)
;

-- Apr 15, 2022, 2:00:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206975,'C_LabelAssignment_UU',200313,214802,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1da5c4e6-f043-4e40-916c-cb14351a3ca5','N',2)
;

-- Apr 15, 2022, 2:00:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206976,'Table','Database Table information','The Database Table provides the information of the table definition',200313,214803,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2bf8cb56-3767-47c6-a464-52bc975b4609','Y',20,2)
;

-- Apr 15, 2022, 2:00:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206977,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200313,214804,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:05','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec01d00b-be2e-4bec-beb5-21cb33379b70','Y',30,2,2)
;

-- Apr 15, 2022, 2:00:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan,NumLines) VALUES (206978,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',200313,214805,'Y',2000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','dfe79dae-1dbb-4479-8079-d0f17f841b5f','Y',40,5,3)
;

-- Apr 15, 2022, 2:00:06 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206979,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200313,214800,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c1ad358b-4e12-4435-bf52-fc9e47de05b1','Y',50,2,2)
;

-- Apr 15, 2022, 2:00:07 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200203,'Label Assignment','W',200125,0,0,'Y',TO_TIMESTAMP('2022-04-15 14:00:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:00:06','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','790b3302-7017-45c1-b554-e1c42d3915e1')
;

-- Apr 15, 2022, 2:00:07 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200203, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200203)
;

-- Apr 15, 2022, 2:00:07 PM CEST
UPDATE AD_Table SET AD_Window_ID=200125,Updated=TO_TIMESTAMP('2022-04-15 14:00:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200340
;

-- Apr 15, 2022, 2:00:57 PM CEST
UPDATE AD_Table SET AD_Window_ID=200124,Updated=TO_TIMESTAMP('2022-04-15 14:00:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200339
;

-- Apr 15, 2022, 2:01:02 PM CEST
UPDATE AD_Table SET AD_Window_ID=200124,Updated=TO_TIMESTAMP('2022-04-15 14:01:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200338
;

-- Apr 15, 2022, 2:18:18 PM CEST
UPDATE AD_Tab SET AD_Column_ID=214793,Updated=TO_TIMESTAMP('2022-04-15 14:18:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200311
;

-- Apr 15, 2022, 2:49:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214806,0,'Label',200340,'C_Label_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 14:49:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:49:12','YYYY-MM-DD HH24:MI:SS'),100,203576,'N','N','D','N','N','N','Y','11425055-0163-4314-98c8-283761d9b39c','N',0,'N','N','N','N')
;

-- Apr 15, 2022, 2:49:14 PM CEST
UPDATE AD_Column SET FKConstraintName='CLabel_CLabelAssignment', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 14:49:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214806
;

-- Apr 15, 2022, 2:49:14 PM CEST
ALTER TABLE C_LabelAssignment ADD COLUMN C_Label_ID NUMERIC(10) NOT NULL
;

-- Apr 15, 2022, 2:49:14 PM CEST
ALTER TABLE C_LabelAssignment ADD CONSTRAINT CLabel_CLabelAssignment FOREIGN KEY (C_Label_ID) REFERENCES c_label(c_label_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 2:49:29 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206980,'Label',200313,214806,'Y',22,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:49:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:49:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ea7e4fc4-7752-46ae-80c7-428ec4aa87c1','Y',60,2)
;

-- Apr 15, 2022, 2:58:26 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214807,0,'Label Category',200340,'C_LabelCategory_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-04-15 14:58:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:58:26','YYYY-MM-DD HH24:MI:SS'),100,203574,'N','N','D','N','N','N','Y','6232e4ea-0092-444b-8c05-c0c248139182','Y',0,'N','N','N','N')
;

-- Apr 15, 2022, 2:58:28 PM CEST
UPDATE AD_Column SET FKConstraintName='CLabelCategory_CLabelAssignmen', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-04-15 14:58:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214807
;

-- Apr 15, 2022, 2:58:28 PM CEST
ALTER TABLE C_LabelAssignment ADD COLUMN C_LabelCategory_ID NUMERIC(10) NOT NULL
;

-- Apr 15, 2022, 2:58:28 PM CEST
ALTER TABLE C_LabelAssignment ADD CONSTRAINT CLabelCategory_CLabelAssignmen FOREIGN KEY (C_LabelCategory_ID) REFERENCES c_labelcategory(c_labelcategory_id) DEFERRABLE INITIALLY DEFERRED
;

-- Apr 15, 2022, 2:58:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206981,'Label Category',200313,214807,'Y',22,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:58:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:58:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7bfd226b-c046-4875-ac30-9e50aa0f0299','Y',70,2)
;

-- Apr 15, 2022, 2:58:55 PM CEST
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206981
;

-- Apr 15, 2022, 2:58:55 PM CEST
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206980
;

-- Apr 15, 2022, 2:58:55 PM CEST
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206978
;

-- Apr 15, 2022, 2:58:55 PM CEST
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=206979
;

-- Apr 15, 2022, 2:59:15 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 14:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206979
;

-- Apr 15, 2022, 2:59:15 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 14:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206977
;

-- Apr 15, 2022, 2:59:15 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 14:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206981
;

-- Apr 15, 2022, 2:59:15 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 14:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206980
;

-- Apr 15, 2022, 2:59:15 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 14:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206978
;

-- Apr 15, 2022, 2:59:15 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 14:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206975
;

-- Apr 15, 2022, 2:59:15 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-04-15 14:59:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206974
;

-- Apr 15, 2022, 2:59:38 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Label Editor',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:59:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:59:38','YYYY-MM-DD HH24:MI:SS'),100,200742,'org.adempiere.webui.window.LabelAction.label','D','9d9272c0-a878-410a-8be9-ab298147ab28')
;

-- Apr 15, 2022, 2:59:56 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Panel used to manage labels',0,0,'Y',TO_TIMESTAMP('2022-04-15 14:59:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-15 14:59:56','YYYY-MM-DD HH24:MI:SS'),100,200743,'org.adempiere.webui.window.LabelAction.tooltip','D','1b52f58f-9a21-4911-83b7-2d55ef45d8f4')
;

-- Apr 15, 2022, 3:01:26 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,ActionClassName,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",SeqNo,IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_TIMESTAMP('2022-04-15 15:01:25','YYYY-MM-DD HH24:MI:SS'),100,'LabelEditor','Y',200118,'Label Editor',TO_TIMESTAMP('2022-04-15 15:01:25','YYYY-MM-DD HH24:MI:SS'),100,'Y','org.adempiere.webui.window.LabelAction',0,0,'b75cd084-f59d-4541-bbad-c8a01d359608','W',310,'N','N','D','N')
;

-- Apr 25, 2022, 10:18:29 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Labels: ',0,0,'Y',TO_TIMESTAMP('2022-04-25 10:18:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-25 10:18:29','YYYY-MM-DD HH24:MI:SS'),100,200746,'LabelPanelTitle','D','ff05c43d-e10b-4d5c-bba9-fb105b83ec76')
;

-- Apr 25, 2022, 10:19:02 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Optional Comment',0,0,'Y',TO_TIMESTAMP('2022-04-25 10:19:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-25 10:19:01','YYYY-MM-DD HH24:MI:SS'),100,200747,'LabelPanelOptionalComment','D','4f842979-2f31-4360-9af3-556787be0e7f')
;

-- Apr 25, 2022, 10:21:10 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Name of new label',0,0,'Y',TO_TIMESTAMP('2022-04-25 10:21:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-04-25 10:21:09','YYYY-MM-DD HH24:MI:SS'),100,200748,'LabelPanelAddPopupTitle','D','ba88ecb6-4193-4463-954a-5c03e6b527c9')
;
