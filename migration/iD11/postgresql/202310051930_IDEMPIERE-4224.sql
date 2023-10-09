-- IDEMPIERE-4224  Decluttering configuration
SELECT register_migration_script('202310051930_IDEMPIERE-4224.sql') FROM dual;

-- Oct 5, 2023, 6:53:24 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView) VALUES (200390,'Table Attribute','AD_TableAttribute',0,'6',0,0,'Y',TO_TIMESTAMP('2023-10-05 18:53:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:53:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','8bafd527-5c02-408a-a133-435c9e0a7662','N','N','N')
;

-- Oct 5, 2023, 6:53:24 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_TableAttribute',1000000,'N','N','Table AD_TableAttribute','Y','Y',0,0,TO_TIMESTAMP('2023-10-05 18:53:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:53:24','YYYY-MM-DD HH24:MI:SS'),100,200461,'Y',1000000,1,200000,'b37cc419-5a3c-43d1-8a11-8386a42a2bf0')
;

-- Oct 5, 2023, 6:53:49 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203838,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:53:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:53:41','YYYY-MM-DD HH24:MI:SS'),100,'AD_TableAttribute_ID','AD_TableAttribute_ID',NULL,NULL,'AD_TableAttribute_ID','D','b9254738-dec4-4bbc-8ac5-ea70edb1784f')
;

-- Oct 5, 2023, 6:53:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215931,0,'AD_TableAttribute_ID',200390,'AD_TableAttribute_ID',22,'Y','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:53:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:53:56','YYYY-MM-DD HH24:MI:SS'),100,203838,'N','N','D','N','N','N','Y','c243fb33-e4fb-4678-8675-ba4ad0fb4052','N',0,'N','N','N','N')
;

-- Oct 5, 2023, 6:54:29 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203839,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:54:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:54:13','YYYY-MM-DD HH24:MI:SS'),100,'AD_TableAttribute_UU','AD_TableAttribute_UU',NULL,NULL,'AD_TableAttribute_UU','D','20a2fe5a-a089-429b-b63d-7ea5f45c6340')
;

-- Oct 5, 2023, 6:54:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215932,0,'AD_TableAttribute_UU',200390,'AD_TableAttribute_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:54:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:54:36','YYYY-MM-DD HH24:MI:SS'),100,203839,'N','N','D','N','N','N','Y','0237387e-9c9a-47b0-aea2-bdf1bd6e5a0d','N',0,'N','N','N','N')
;

-- Oct 5, 2023, 6:55:01 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215933,0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200390,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:55:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:55:00','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','N','N','N','Y','c9bea1a0-3a28-48d2-8a98-ba8a6b31173b','N',0,'N','N','D','N')
;

-- Oct 5, 2023, 6:55:21 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215934,0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200390,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:55:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:55:20','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','N','N','Y','80152795-2f68-4f38-b9f9-77984fee40dd','N',0,'N','N','D','N')
;

-- Oct 5, 2023, 6:55:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215935,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200390,'Created','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:55:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:55:30','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','4b673cf7-f567-4f6f-8c36-a5a49d4abc38','N',0,'N','N','N')
;

-- Oct 5, 2023, 6:55:39 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215936,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200390,'CreatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:55:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:55:39','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','9c9c96e6-37ea-416e-b344-5f68a8c227b4','N',0,'N','N','D','N')
;

-- Oct 5, 2023, 6:55:52 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215937,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200390,'IsActive','Y',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:55:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:55:51','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','6aab43ec-3300-4d80-9a1c-da87fc8a971a','N',0,'N','N','N')
;

-- Oct 5, 2023, 6:56:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215938,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200390,'Updated','SYSDATE',7,'N','N','N','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:56:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:56:10','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','fdc404a1-19f1-40d8-b956-01c85239588a','N',0,'N','N','N')
;

-- Oct 5, 2023, 6:56:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215939,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200390,'UpdatedBy',22,'N','N','N','N','N',0,'N',18,110,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:56:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:56:17','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','ed487b3b-8f4e-4855-b292-75852fa15873','N',0,'N','N','D','N')
;

-- Oct 5, 2023, 6:56:37 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215940,0,'Attribute','Product Attribute','Product Attribute like Color, Size',200390,'M_Attribute_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:56:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:56:37','YYYY-MM-DD HH24:MI:SS'),100,2015,'N','N','D','N','N','N','Y','bc6f4eb5-e26d-4519-a637-804e04cbce6f','Y',0,'N','N','N')
;

-- Oct 5, 2023, 6:57:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215941,0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200390,'Value',40,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:57:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:57:11','YYYY-MM-DD HH24:MI:SS'),100,620,'Y','Y','D','N','N','N','Y','99611e9b-7f7f-4c22-a708-80cf74eab95b','Y',10,'N','N','N')
;

-- Oct 5, 2023, 6:57:23 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215942,0,'Value Date',200390,'ValueDate',7,'N','N','N','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:57:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:57:22','YYYY-MM-DD HH24:MI:SS'),100,202805,'Y','N','D','N','N','N','Y','d1e32dd6-4bd9-4903-8af4-a4797e31321d','Y',0,'N','N','N','N')
;

-- Oct 5, 2023, 6:57:31 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215943,0,'Value','Numeric Value',200390,'ValueNumber',22,'N','N','N','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:57:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:57:30','YYYY-MM-DD HH24:MI:SS'),100,2579,'Y','N','D','N','N','N','Y','14710ad1-38bd-4a37-bd84-15e5120fd08c','Y',0,'N','N','N')
;

-- Oct 5, 2023, 6:57:42 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215944,0,'Table','Database Table information','The Database Table provides the information of the table definition',200390,'AD_Table_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:57:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:57:42','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','N','N','Y','41b6d967-ee8f-4227-980a-10f5ecefb391','Y',0,'N','N','N','N')
;

-- Oct 5, 2023, 6:58:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215945,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200390,'Record_ID',22,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:58:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:58:09','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','N','N','N','Y','59a60ff9-fd34-42f0-b51e-01743f493fbb','Y',0,'Y','N','N')
;

-- Oct 5, 2023, 6:58:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215946,0,'Attribute Value','Product Attribute Value','Individual value of a product attribute (e.g. green, large, ..)',200390,'M_AttributeValue_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:58:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:58:46','YYYY-MM-DD HH24:MI:SS'),100,2020,'N','N','D','N','N','N','Y','d9e7841b-38cd-4fda-9acf-4ec2ba13012b','Y',0,'N','N','N')
;

-- Oct 5, 2023, 6:58:53 PM IST
UPDATE AD_Column SET FKConstraintName='ADTable_ADTableAttribute', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-10-05 18:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215944
;

-- Oct 5, 2023, 6:58:53 PM IST
UPDATE AD_Column SET FKConstraintName='MAttribute_ADTableAttribute', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-10-05 18:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215940
;

-- Oct 5, 2023, 6:58:53 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeValue_ADTableAttribu', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-10-05 18:58:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215946
;

-- Oct 5, 2023, 6:58:53 PM IST
CREATE TABLE AD_TableAttribute (AD_Client_ID NUMERIC(10) DEFAULT NULL , AD_Org_ID NUMERIC(10) DEFAULT NULL , AD_Table_ID NUMERIC(10) DEFAULT NULL , AD_TableAttribute_ID NUMERIC(10) DEFAULT NULL , AD_TableAttribute_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP DEFAULT statement_timestamp(), CreatedBy NUMERIC(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')), M_Attribute_ID NUMERIC(10) DEFAULT NULL , M_AttributeValue_ID NUMERIC(10) DEFAULT NULL , Record_ID NUMERIC(10) DEFAULT NULL , Updated TIMESTAMP DEFAULT statement_timestamp(), UpdatedBy NUMERIC(10) DEFAULT NULL , Value VARCHAR(40) DEFAULT NULL , ValueDate TIMESTAMP DEFAULT NULL , ValueNumber NUMERIC DEFAULT NULL , CONSTRAINT AD_TableAttribute_Key PRIMARY KEY (AD_TableAttribute_ID), CONSTRAINT AD_TableAttribute_UU_idx UNIQUE (AD_TableAttribute_UU))
;

-- Oct 5, 2023, 6:58:53 PM IST
ALTER TABLE AD_TableAttribute ADD CONSTRAINT ADTable_ADTableAttribute FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 5, 2023, 6:58:53 PM IST
ALTER TABLE AD_TableAttribute ADD CONSTRAINT MAttribute_ADTableAttribute FOREIGN KEY (M_Attribute_ID) REFERENCES m_attribute(m_attribute_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 5, 2023, 6:58:53 PM IST
ALTER TABLE AD_TableAttribute ADD CONSTRAINT MAttributeValue_ADTableAttribu FOREIGN KEY (M_AttributeValue_ID) REFERENCES m_attributevalue(m_attributevalue_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 5, 2023, 6:59:16 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201259,'27e77bb9-e6e3-4514-b7db-ca02c3e4ea15',TO_TIMESTAMP('2023-10-05 18:59:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TableAttribute_AttributeKey',TO_TIMESTAMP('2023-10-05 18:59:16','YYYY-MM-DD HH24:MI:SS'),100,200390,'Y','Y','N','N','N')
;

-- Oct 5, 2023, 6:59:25 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201701,'fa42c9e1-697f-491d-8f4f-ddedc9553e98',TO_TIMESTAMP('2023-10-05 18:59:24','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-10-05 18:59:24','YYYY-MM-DD HH24:MI:SS'),100,215944,201259,0)
;

-- Oct 5, 2023, 6:59:32 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201702,'2bc23165-ede5-4e5a-bd91-b0dea37c7702',TO_TIMESTAMP('2023-10-05 18:59:31','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-10-05 18:59:31','YYYY-MM-DD HH24:MI:SS'),100,215945,201259,0)
;

-- Oct 5, 2023, 6:59:38 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201703,'634f9994-55f8-4d36-9e13-e0bed294715a',TO_TIMESTAMP('2023-10-05 18:59:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2023-10-05 18:59:37','YYYY-MM-DD HH24:MI:SS'),100,215940,201259,0)
;

-- Oct 5, 2023, 6:59:41 PM IST
ALTER TABLE AD_TableAttribute ADD CONSTRAINT AD_TableAttribute_AttributeKey UNIQUE (AD_Table_ID,Record_ID,M_Attribute_ID)
;

-- Oct 5, 2023, 7:00:24 PM IST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2023-10-05 19:00:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=562
;

-- Oct 5, 2023, 7:04:17 PM IST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2023-10-05 19:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=558
;

-- Oct 5, 2023, 7:04:30 PM IST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2023-10-05 19:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=560
;

-- Oct 5, 2023, 7:04:53 PM IST
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2023-10-05 19:04:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=563
;

-- Oct 5, 2023, 7:05:49 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215947,0,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',562,'DefaultValue',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-10-05 19:05:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 19:05:48','YYYY-MM-DD HH24:MI:SS'),100,272,'Y','N','D','N','N','N','Y','6f238c61-5bbf-4d03-a5f2-952cb6bc951c','Y',0,'N','N','N')
;

-- Oct 5, 2023, 7:05:52 PM IST
ALTER TABLE M_Attribute ADD COLUMN DefaultValue VARCHAR(2000) DEFAULT NULL 
;

-- Oct 5, 2023, 7:06:57 PM IST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200657,'Table Attribute',200115,'TA',0,0,'Y',TO_TIMESTAMP('2023-10-05 19:06:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 19:06:57','YYYY-MM-DD HH24:MI:SS'),100,'D','ceeecb4b-990f-4c00-a494-0db2d5ba0dec')
;

-- Oct 5, 2023, 7:08:00 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207748,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',462,215947,'Y',0,130,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-05 19:07:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 19:07:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','56969b0b-3adc-4bf8-a117-d9cfa8d70fc0','Y',130,1,1,1,'N','N','N','N')
;

-- Oct 5, 2023, 7:08:11 PM IST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-10-05 19:08:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207748
;

-- Oct 5, 2023, 7:10:40 PM IST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200180,'M_AttributeSet (Table Attribute)','S','M_AttributeSet.M_AttributeSet_Type=''TA''',0,0,'Y',TO_TIMESTAMP('2023-10-05 19:10:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 19:10:39','YYYY-MM-DD HH24:MI:SS'),100,'D','1ccc975e-7d12-4e40-b92f-b28dcac83a11')
;

-- Oct 5, 2023, 7:10:55 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215948,0,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',100,200180,'M_AttributeSet_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-10-05 19:10:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 19:10:55','YYYY-MM-DD HH24:MI:SS'),100,2017,'N','N','D','N','N','N','Y','5965098d-456d-48a2-b05d-e1b8cbc9ec8b','Y',0,'N','N','N')
;

-- Oct 5, 2023, 7:10:58 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSet_ADTable', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-10-05 19:10:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215948
;

-- Oct 5, 2023, 7:10:58 PM IST
ALTER TABLE AD_Table ADD COLUMN M_AttributeSet_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 5, 2023, 7:10:58 PM IST
ALTER TABLE AD_Table ADD CONSTRAINT MAttributeSet_ADTable FOREIGN KEY (M_AttributeSet_ID) REFERENCES m_attributeset(m_attributeset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Oct 5, 2023, 7:11:56 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207749,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',100,215948,'Y',0,230,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-05 19:11:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 19:11:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','218bf59a-05d3-498e-a136-ca808b4ea4b3','Y',200,1,2,1,'N','N','N','N')
;

-- Oct 5, 2023, 7:15:34 PM IST
UPDATE AD_Column SET IsUpdateable='Y', IsAlwaysUpdateable='Y',Updated=TO_TIMESTAMP('2023-10-05 19:15:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215948
;

