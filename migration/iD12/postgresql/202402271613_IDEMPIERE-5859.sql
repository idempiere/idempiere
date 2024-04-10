-- IDEMPIERE-5859 Support Attribute Set Instance for Reference=>Multi-Chosen fieldtypes
SELECT register_migration_script('202402271613_IDEMPIERE-5859.sql') FROM dual;

-- Feb 27, 2024, 4:13:28 PM MYT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200416,'Attribute Instance Values','Selected attribute values of an attribute instance','M_AttributeInstanceLine',0,'3',0,0,'Y',TO_TIMESTAMP('2024-02-27 16:13:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:13:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','055f08ea-e553-4b62-b66b-476ddb2ce36e','N','N','N','N','N','N','N')
;

-- Feb 27, 2024, 4:13:29 PM MYT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('M_AttributeInstanceLine',1000000,'N','N','Table M_AttributeInstanceLine','Y','Y',0,0,TO_TIMESTAMP('2024-02-27 16:13:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:13:28','YYYY-MM-DD HH24:MI:SS'),100,200487,'Y',1000000,1,200000,'e292c3e4-caf8-4418-b377-ec5437ce5635')
;

-- Feb 27, 2024, 4:14:23 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216571,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200416,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:23','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','01a158c0-031f-4a2e-bbc6-df402ac5182a','N')
;

-- Feb 27, 2024, 4:14:24 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216572,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200416,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:23','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','4b1de05d-c6d3-4081-b201-5533da60cb36','N')
;

-- Feb 27, 2024, 4:14:24 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216573,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200416,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:24','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','2a9355b3-7ad2-4017-9e72-c1d1be5f289c','N')
;

-- Feb 27, 2024, 4:14:25 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216574,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200416,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:24','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','3246db86-cf99-4acf-8c6d-1979256d316e','N')
;

-- Feb 27, 2024, 4:14:26 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216575,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200416,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:25','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','87d315c3-cd12-449c-9979-754d73d3eeef','N')
;

-- Feb 27, 2024, 4:14:26 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216576,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200416,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:26','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','fa6af04b-0d7e-4d35-9fcb-cffdc39fe290','N')
;

-- Feb 27, 2024, 4:14:27 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216577,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200416,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:26','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','ea152a49-5d8e-4625-a3c0-0977a131105a','N')
;

-- Feb 27, 2024, 4:14:27 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203925,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:27','YYYY-MM-DD HH24:MI:SS'),100,'M_AttributeInstanceLine_ID','Attribute Instance Values','Selected attribute values of an attribute instance','Attribute Instance Values','D','da748052-0b46-46b3-9fce-ace05c956237')
;

-- Feb 27, 2024, 4:14:28 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216578,0.0,'Attribute Instance Values','Selected attribute values of an attribute instance',200416,'M_AttributeInstanceLine_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:27','YYYY-MM-DD HH24:MI:SS'),100,203925,'N','N','D','N','c34503ee-9e51-4556-ba3c-304b7c6b6e37','N')
;

-- Feb 27, 2024, 4:14:29 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203926,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:28','YYYY-MM-DD HH24:MI:SS'),100,'M_AttributeInstanceLine_UU','M_AttributeInstanceLine_UU','M_AttributeInstanceLine_UU','D','c61b71d5-d686-4126-a4e9-5c62546612cf')
;

-- Feb 27, 2024, 4:14:29 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (216579,0.0,'M_AttributeInstanceLine_UU',200416,'M_AttributeInstanceLine_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:14:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:14:29','YYYY-MM-DD HH24:MI:SS'),100,203926,'Y','N','D','N','c45c6493-e9fc-4a1a-8fb3-0a3bf8713a6a','N')
;

-- Feb 27, 2024, 4:14:30 PM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201271,'ac117825-7390-4782-95f3-b82a5e863cd8',TO_TIMESTAMP('2024-02-27 16:14:29','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_AttributeInstanceLine_uu_idx',TO_TIMESTAMP('2024-02-27 16:14:29','YYYY-MM-DD HH24:MI:SS'),100,200416,'Y','Y','N','N')
;

-- Feb 27, 2024, 4:14:30 PM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201727,'a7dd953a-ffb8-4473-883f-3123c5ff2931',TO_TIMESTAMP('2024-02-27 16:14:30','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-02-27 16:14:30','YYYY-MM-DD HH24:MI:SS'),100,216579,201271,10)
;

-- Feb 27, 2024, 4:17:13 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (216580,0,'M_AttributeInstance_UU',200416,'M_AttributeInstance_UU',36,'N','Y','Y','N','N',0,'N',200234,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:17:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:17:12','YYYY-MM-DD HH24:MI:SS'),100,54959,'N','N','D','N','N','N','Y','6d1acedd-e16a-4fc1-85ca-68727830a3b7','N',0,'N','N','C','N','N')
;

-- Feb 27, 2024, 4:18:50 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216581,0,'Line No','Unique line for this document','Indicates the unique line for a document.  It will also control the display order of the lines within a document.',200416,'Line',22,'N','N','Y','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:18:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:18:49','YYYY-MM-DD HH24:MI:SS'),100,439,'Y','N','D','N','N','N','Y','5a9c4ac9-8e66-4fbb-805e-640a6619faf5','N',0,'N','N','N','N')
;

-- Feb 27, 2024, 4:19:26 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (216582,0,'Attribute Value','Product Attribute Value','Individual value of a product attribute (e.g. green, large, ..)',200416,'M_AttributeValue_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-02-27 16:19:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-27 16:19:25','YYYY-MM-DD HH24:MI:SS'),100,2020,'N','N','D','N','N','N','Y','11bd3ec8-6b4c-4045-aa8c-93a3881231ba','N',0,'N','N','N','N')
;

-- Feb 27, 2024, 4:19:33 PM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_MAttributeInstanceLin', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-02-27 16:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216571
;

-- Feb 27, 2024, 4:19:33 PM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_MAttributeInstanceLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-02-27 16:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216572
;

-- Feb 27, 2024, 4:19:33 PM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_MAttributeInstanceLi', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-02-27 16:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216574
;

-- Feb 27, 2024, 4:19:33 PM MYT
UPDATE AD_Column SET FieldLength=36, IsUpdateable='N', FKConstraintName='MAttributeInstanceUU_MAttribut', FKConstraintType='C',Updated=TO_TIMESTAMP('2024-02-27 16:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216580
;

-- Feb 27, 2024, 4:19:33 PM MYT
UPDATE AD_Column SET FKConstraintName='MAttributeValue_MAttributeInst', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-02-27 16:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216582
;

-- Feb 27, 2024, 4:19:33 PM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_MAttributeInstanceLi', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-02-27 16:19:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216576
;

-- Feb 27, 2024, 4:19:33 PM MYT
CREATE TABLE M_AttributeInstanceLine (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Line NUMERIC(10) NOT NULL, M_AttributeInstanceLine_ID NUMERIC(10) NOT NULL, M_AttributeInstanceLine_UU VARCHAR(36) DEFAULT NULL , M_AttributeInstance_UU VARCHAR(36) NOT NULL, M_AttributeValue_ID NUMERIC(10) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT M_AttributeInstanceLine_Key PRIMARY KEY (M_AttributeInstanceLine_ID), CONSTRAINT M_AttributeInstanceLine_UU_idx UNIQUE (M_AttributeInstanceLine_UU))
;

-- Feb 27, 2024, 4:19:33 PM MYT
ALTER TABLE M_AttributeInstanceLine ADD CONSTRAINT ADClient_MAttributeInstanceLin FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 27, 2024, 4:19:33 PM MYT
ALTER TABLE M_AttributeInstanceLine ADD CONSTRAINT ADOrg_MAttributeInstanceLine FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 27, 2024, 4:19:33 PM MYT
ALTER TABLE M_AttributeInstanceLine ADD CONSTRAINT CreatedBy_MAttributeInstanceLi FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 27, 2024, 4:19:33 PM MYT
ALTER TABLE M_AttributeInstanceLine ADD CONSTRAINT MAttributeInstanceUU_MAttribut FOREIGN KEY (M_AttributeInstance_UU) REFERENCES M_AttributeInstance(M_AttributeInstance_UU) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Feb 27, 2024, 4:19:33 PM MYT
ALTER TABLE M_AttributeInstanceLine ADD CONSTRAINT MAttributeValue_MAttributeInst FOREIGN KEY (M_AttributeValue_ID) REFERENCES m_attributevalue(m_attributevalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 27, 2024, 4:19:33 PM MYT
ALTER TABLE M_AttributeInstanceLine ADD CONSTRAINT UpdatedBy_MAttributeInstanceLi FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Feb 27, 2024, 4:22:24 PM MYT
UPDATE AD_Column SET FieldLength=36, IsMandatory='Y', IsUpdateable='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2024-02-27 16:22:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216579
;

-- Feb 27, 2024, 4:22:36 PM MYT
INSERT INTO t_alter_column values('m_attributeinstanceline','M_AttributeInstanceLine_UU','VARCHAR(36)',null,null)
;

-- Feb 27, 2024, 4:22:36 PM MYT
INSERT INTO t_alter_column values('m_attributeinstanceline','M_AttributeInstanceLine_UU',null,'NOT NULL',null)
;

