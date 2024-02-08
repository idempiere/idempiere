-- IDEMPIERE-6013 Implement a way to filter dinamically records on MRole.addAccessSQL
SELECT register_migration_script('202401251553_IDEMPIERE-6013.sql') FROM dual;

-- Jan 25, 2024, 3:53:32 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200150,'Dynamic Validation per Table',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:32','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','7d7acdf6-a331-49dc-a3c8-0b5ce376ddc9')
;

-- Jan 25, 2024, 3:53:33 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,AD_Window_ID,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200415,'Dynamic Validation per Table',200150,'AD_TableValRule',0,'6',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','42023256-9f38-4db3-907e-6758ef65c934','N','N','N','N','N','N','N')
;

-- Jan 25, 2024, 3:53:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216445,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200415,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:34','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','Y','N','N','Y','3da0fdb2-d027-4c60-af5c-7e44b5f0a1e1','N','N','N','ADClient_ADTableValRule','N','N','N')
;

-- Jan 25, 2024, 3:53:34 PM CET
CREATE TABLE AD_TableValRule (AD_Client_ID NUMERIC(10) NOT NULL)
;

-- Jan 25, 2024, 3:53:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216446,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200415,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:34','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','5706e86f-6f5c-476e-89e1-fd5fb8bbb165','N','N','N','ADOrg_ADTableValRule','N','N','N')
;

-- Jan 25, 2024, 3:53:35 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Jan 25, 2024, 3:53:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216447,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200415,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:35','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','038379c3-b03f-459e-bcd1-0e64f4c728b4','N','N','N','N','N','N')
;

-- Jan 25, 2024, 3:53:35 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN Created TIMESTAMP NOT NULL
;

-- Jan 25, 2024, 3:53:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216448,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200415,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:35','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','73139319-8b80-4546-8be5-ee4febbf1687','N','N','N','CreatedBy_ADTableValRule','N','N','N')
;

-- Jan 25, 2024, 3:53:36 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Jan 25, 2024, 3:53:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216449,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200415,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:36','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','d0de3c6e-8e0d-4f58-b48b-07222bfe9bda','N','N','N','N','N','N')
;

-- Jan 25, 2024, 3:53:36 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN Updated TIMESTAMP NOT NULL
;

-- Jan 25, 2024, 3:53:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216450,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200415,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:36','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','3200f9c8-3d92-4a05-bdc5-2c05682d7ba2','N','N','N','UpdatedBy_ADTableValRule','N','N','N')
;

-- Jan 25, 2024, 3:53:37 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Jan 25, 2024, 3:53:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216451,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200415,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','65da9adc-d313-44c4-8c3b-40a5d0655a99','N','N','N','N','N','N')
;

-- Jan 25, 2024, 3:53:37 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jan 25, 2024, 3:53:37 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203905,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,'AD_TableValRule_UU','AD_TableValRule_UU','AD_TableValRule_UU','D','cb4a6da9-64a3-4003-8642-25478dd3a7f9')
;

-- Jan 25, 2024, 3:53:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216452,0.0,'AD_TableValRule_UU',200415,'AD_TableValRule_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:37','YYYY-MM-DD HH24:MI:SS'),100,203905,'Y','N','D','Y','N','N','Y','42c87f0a-9754-4f27-a859-1205989f5074','N','N','N','N','N','N')
;

-- Jan 25, 2024, 3:53:38 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN AD_TableValRule_UU VARCHAR(36) DEFAULT NULL 
;

-- Jan 25, 2024, 3:53:38 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT AD_TableValRule_UU_idx UNIQUE (AD_TableValRule_UU)
;

-- Jan 25, 2024, 3:53:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216453,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200415,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','N','D','Y','N','N','Y','4d32c358-8b59-4e15-bb61-c44f3b9327ea','Y','N','N','N','N','N')
;

-- Jan 25, 2024, 3:53:38 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN Description VARCHAR(255) DEFAULT NULL 
;

-- Jan 25, 2024, 3:53:39 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216454,0,'Table','Database Table information','The Database Table provides the information of the table definition',200415,'AD_Table_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:38','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','Y','N','N','Y','a5f38788-d59d-40d1-ac82-1c07e5b795ec','Y',0,'N','N','ADTable_ADTableValRule','N','N','N')
;

-- Jan 25, 2024, 3:53:39 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN AD_Table_ID NUMERIC(10) NOT NULL
;

-- Jan 25, 2024, 3:53:39 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216455,0,'Validation code','Validation Code','The Validation Code displays the date, time and message of the error.',200415,'Code',4000,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:39','YYYY-MM-DD HH24:MI:SS'),100,227,'Y','N','D','Y','N','N','Y','f5dae707-97a4-4cd7-836b-e3c759bfadd0','Y',0,'N','N','N','N','N')
;

-- Jan 25, 2024, 3:53:39 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN Code VARCHAR(4000) NOT NULL
;

-- Jan 25, 2024, 3:53:39 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216456,0,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200415,'AD_Role_ID','NULL',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:39','YYYY-MM-DD HH24:MI:SS'),100,123,'Y','N','D','Y','N','N','Y','537b6ba6-d9a6-4b4b-8482-7f97bc1d90cc','Y',0,'N','N','ADRole_ADTableValRule','C','N','N')
;

-- Jan 25, 2024, 3:53:40 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN AD_Role_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 25, 2024, 3:53:40 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216457,0,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200415,'AD_User_ID','NULL',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:40','YYYY-MM-DD HH24:MI:SS'),100,138,'Y','N','D','Y','N','N','Y','9ae5e470-5185-4015-bd5f-b88cc1728cce','Y',0,'N','N','ADUser_ADTableValRule','N','N','N')
;

-- Jan 25, 2024, 3:53:40 PM CET
ALTER TABLE AD_TableValRule ADD COLUMN AD_User_ID NUMERIC(10) DEFAULT NULL 
;

-- Jan 25, 2024, 3:53:40 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201269,'e3e8630e-49ee-431b-992d-81476a16a701',TO_TIMESTAMP('2024-01-25 15:53:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TableValRule_uu_idx',TO_TIMESTAMP('2024-01-25 15:53:40','YYYY-MM-DD HH24:MI:SS'),100,200415,'Y','Y','N','Y')
;

-- Jan 25, 2024, 3:53:41 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201722,'0f4ab741-34bb-4a58-a7c6-e21a5f9097d0',TO_TIMESTAMP('2024-01-25 15:53:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-01-25 15:53:40','YYYY-MM-DD HH24:MI:SS'),100,216452,201269,10)
;

-- Jan 25, 2024, 3:53:41 PM CET
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201270,'58c81ee9-9e77-4bfe-845c-5283cb46e2c2',TO_TIMESTAMP('2024-01-25 15:53:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TableValRule_Unq',TO_TIMESTAMP('2024-01-25 15:53:41','YYYY-MM-DD HH24:MI:SS'),100,200415,'N','Y','N','N','N')
;

-- Jan 25, 2024, 3:53:41 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201723,'c72e5505-c213-45bf-8ba3-31b6215774f6',TO_TIMESTAMP('2024-01-25 15:53:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-01-25 15:53:41','YYYY-MM-DD HH24:MI:SS'),100,216454,201270,10)
;

-- Jan 25, 2024, 3:53:42 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201724,'a958a52a-e176-4e56-9cb9-7a90a3f901f9',TO_TIMESTAMP('2024-01-25 15:53:41','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-01-25 15:53:41','YYYY-MM-DD HH24:MI:SS'),100,216445,201270,20)
;

-- Jan 25, 2024, 3:53:42 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201725,'dd86e335-e80a-4b76-8f3d-a8255808a148',TO_TIMESTAMP('2024-01-25 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-01-25 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,216456,201270,'COALESCE(AD_Role_ID,-1)',30)
;

-- Jan 25, 2024, 3:53:42 PM CET
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,ColumnSQL,SeqNo) VALUES (0,0,201726,'0201f3ef-8a68-49f5-bec2-a3554188d848',TO_TIMESTAMP('2024-01-25 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-01-25 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,216457,201270,'COALESCE(AD_User_ID,-1)',40)
;

-- Jan 25, 2024, 3:53:42 PM CET
CREATE UNIQUE INDEX AD_TableValRule_Unq ON AD_TableValRule (AD_Table_ID,AD_Client_ID,COALESCE(AD_Role_ID,-1),COALESCE(AD_User_ID,-1))
;

-- Jan 25, 2024, 3:53:43 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200385,'Dynamic Validation per Table',200150,10,'Y',200415,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:42','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','AD_TableValRule.Created DESC','N',0,'N','D','Y','Y','72743e37-0045-4f00-b049-0d00b10d845b','B','N','Y',0)
;

-- Jan 25, 2024, 3:53:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208355,'AD_TableValRule_UU',200385,216452,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a648d911-37b4-48c7-972a-4446ea8b2ee2','N',1,2,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208356,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200385,216445,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','689964ca-3099-46ba-ab4f-7421fa3edc35','Y',10,1,2,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208357,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200385,216446,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a8807d22-5c3d-4711-99d3-85f5e87cf340','Y','N',4,2,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208358,'Table','Database Table information','The Database Table provides the information of the table definition',200385,216454,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d4c082b5-c333-4584-8c29-d5804aa8f77e','Y',40,1,2,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208359,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200385,216451,'Y',1,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2ce3d4ca-431d-4955-9f7b-7fd9129926a1','Y',80,5,2,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208360,'Role','Responsibility Role','The Role determines security and access a user who has this Role will have in the System.',200385,216456,'Y',22,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','67a35371-6841-4cee-b22d-12ed859c3047','Y',60,1,2,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208361,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200385,216457,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f4356264-6227-408c-9768-5b7b1febc140','Y',70,1,2,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:46 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208362,'Description','Optional short description of the record','A description is limited to 255 characters.',200385,216453,'Y',255,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9deb3d72-98e3-47e3-8e92-de733e1d0818','Y',20,1,5,1,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:46 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (208363,'SQL Filter','SQL Filter','Enter a valid WHERE SQL fully qualified clause.  The WHERE is not needed, the code will be surrounded within parenthesis before applied',200385,216455,'Y',4000,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:46','YYYY-MM-DD HH24:MI:SS'),100,'N','N','D','354c9fcc-9961-4c76-8040-3bc0727a8be0','Y',50,1,5,8,'N','N','N','N')
;

-- Jan 25, 2024, 3:53:46 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,"action",AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200234,'Dynamic Validation per Table','W',200150,0,0,'Y',TO_TIMESTAMP('2024-01-25 15:53:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','a1cd8878-33b0-4228-9d0f-00aa536134c0')
;

-- Jan 25, 2024, 3:53:46 PM CET
UPDATE AD_TREENODEMM SET SeqNo=SeqNo+1 WHERE Parent_ID=367 AND SeqNo>=10 AND AD_Tree_ID=10
;

-- Jan 25, 2024, 3:53:46 PM CET
INSERT INTO AD_TreeNodeMM (AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Parent_ID,SeqNo,AD_Tree_ID,Node_ID,AD_Client_ID,AD_TreeNodeMM_UU) VALUES (0,'Y',TO_TIMESTAMP('2024-01-25 15:53:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-01-25 15:53:46','YYYY-MM-DD HH24:MI:SS'),100,367,10,10,200234,0,'b4f8ea74-a8d3-4d4a-a43b-9e1c09ec6ec0')
;

-- Jan 25, 2024, 3:53:46 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT ADClient_ADTableValRule FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 25, 2024, 3:53:46 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT ADOrg_ADTableValRule FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 25, 2024, 3:53:46 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT CreatedBy_ADTableValRule FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 25, 2024, 3:53:46 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT UpdatedBy_ADTableValRule FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 25, 2024, 3:53:46 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT ADTable_ADTableValRule FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 25, 2024, 3:53:46 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT ADRole_ADTableValRule FOREIGN KEY (AD_Role_ID) REFERENCES ad_role(ad_role_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Jan 25, 2024, 3:53:47 PM CET
ALTER TABLE AD_TableValRule ADD CONSTRAINT ADUser_ADTableValRule FOREIGN KEY (AD_User_ID) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

