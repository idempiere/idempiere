-- IDEMPIERE-4224  Decluttering configuration
SELECT register_migration_script('202407231630_IDEMPIERE-4224.sql') FROM dual;

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
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215945,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200390,'Record_ID',22,'N','N','N','N','N',0,'N',200202,0,0,'Y',TO_TIMESTAMP('2023-10-05 18:58:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-05 18:58:09','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','N','N','N','Y','59a60ff9-fd34-42f0-b51e-01743f493fbb','Y',0,'Y','N','N')
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
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:00:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=562
;

-- Oct 5, 2023, 7:04:17 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:04:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=558
;

-- Oct 5, 2023, 7:04:30 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=560
;

-- Oct 5, 2023, 7:04:53 PM IST
UPDATE AD_Table SET AccessLevel='7',Updated=TO_TIMESTAMP('2023-10-05 19:04:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=563
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

-- Oct 25, 2023, 3:32:17 PM IST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",IsAdvancedButton,IsAddSeparator,EntityType,IsShowMore) VALUES (0,0,TO_TIMESTAMP('2023-10-25 15:32:16','YYYY-MM-DD HH24:MI:SS'),100,'AttributeForm','Y',200133,'Window - AttributeForm',TO_TIMESTAMP('2023-10-25 15:32:16','YYYY-MM-DD HH24:MI:SS'),100,'N',0,0,'563fb0ac-a92d-482e-b6b3-dd3f9970cd96','W','N','N','D','N')
;

-- Oct 27, 2023, 2:44:57 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215962,0,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',563,'DefaultValue',2000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-10-27 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-27 14:44:56','YYYY-MM-DD HH24:MI:SS'),100,272,'Y','N','D','N','N','N','Y','ec6d468d-26fc-4eb7-b3aa-6af8a4a08dca','Y',0,'N','N','N','N')
;

-- Oct 27, 2023, 2:45:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207832,'Default Logic','Default value hierarchy, separated by ;','The defaults are evaluated in the order of definition, the first not null value becomes the default value of the column. The values are separated by comma or semicolon. a) Literals:. ''Text'' or 123 b) Variables - in format @Variable@ - Login e.g. #Date, #AD_Org_ID, #AD_Client_ID - Accounting Schema: e.g. $C_AcctSchema_ID, $C_Calendar_ID - Global defaults: e.g. DateFormat - Window values (all Picks, CheckBoxes, RadioButtons, and DateDoc/DateAcct) c) SQL code with the tag: @SQL=SELECT something AS DefaultValue FROM ... The SQL statement can contain variables.  There can be no other value other than the SQL statement. The default is only evaluated, if no user preference is defined.  Default definitions are ignored for record columns as Key, Parent, Client as well as Buttons.',467,215962,'Y',0,70,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-10-27 14:45:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-10-27 14:45:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c0c30032-7894-4e2d-8892-1ab1bd26e174','Y',70,1,2,1,'N','N','N','N')
;

-- Oct 27, 2023, 2:46:42 PM IST
ALTER TABLE M_AttributeUse ADD COLUMN DefaultValue VARCHAR(2000) DEFAULT NULL 
;

-- Nov 4, 2023, 9:19:53 AM IST
UPDATE AD_Column SET FieldLength=2000, AD_Reference_ID=14,Updated=TO_TIMESTAMP('2023-11-04 09:19:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215941
;

-- Nov 4, 2023, 9:19:58 AM IST
INSERT INTO t_alter_column values('ad_tableattribute','Value','VARCHAR(2000)',null,'NULL')
;

-- Dec 27, 2023, 2:32:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216309,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',560,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2023-12-27 14:32:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 14:32:10','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','852977a0-72a9-4bc5-8e2b-2d7542d97532','Y',0,'N','N','N','N')
;

-- Dec 27, 2023, 2:32:14 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-12-27 14:32:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216309
;

-- Dec 27, 2023, 2:32:14 PM IST
ALTER TABLE M_AttributeSet ADD COLUMN EntityType VARCHAR(40) DEFAULT NULL 
;

-- Dec 27, 2023, 2:32:14 PM IST
ALTER TABLE M_AttributeSet ADD CONSTRAINT EntityType_MAttributeSet FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 2:35:42 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208099,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',461,216309,'Y',40,230,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-27 14:35:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 14:35:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6b299959-5f2b-4ae5-8d0e-2798fc8accc1','Y',220,2)
;

-- Dec 27, 2023, 2:36:08 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208099
;

-- Dec 27, 2023, 2:36:08 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12370
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12369
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6351
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8376
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6347
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12372
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12371
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6350
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8377
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6404
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201617
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10419
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204081
;

-- Dec 27, 2023, 2:36:09 PM IST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:36:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204432
;

-- Dec 27, 2023, 2:36:50 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216310,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',563,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2023-12-27 14:36:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 14:36:50','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','bfdc9b7c-89ba-475a-9bf4-2fcc5185584a','Y',0,'N','N','N','N')
;

-- Dec 27, 2023, 2:36:52 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttributeUse', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-12-27 14:36:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216310
;

-- Dec 27, 2023, 2:36:52 PM IST
ALTER TABLE M_AttributeUse ADD COLUMN EntityType VARCHAR(40) DEFAULT NULL 
;

-- Dec 27, 2023, 2:36:52 PM IST
ALTER TABLE M_AttributeUse ADD CONSTRAINT EntityType_MAttributeUse FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 2:37:13 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208100,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',467,216310,'Y',40,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-27 14:37:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 14:37:13','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','585aef9d-37f1-4d2d-aaef-0edca5b13891','Y',80,2)
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208100
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6408
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6407
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6428
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207832
;

-- Dec 27, 2023, 2:37:39 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:37:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202903
;

-- Dec 27, 2023, 2:38:20 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216311,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',562,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2023-12-27 14:38:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 14:38:20','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','6d07a1a8-67f5-48fa-90b0-ee9bdf62a308','Y',0,'N','N','N','N')
;

-- Dec 27, 2023, 2:38:22 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttribute', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-12-27 14:38:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216311
;

-- Dec 27, 2023, 2:38:22 PM IST
ALTER TABLE M_Attribute ADD COLUMN EntityType VARCHAR(40) DEFAULT NULL 
;

-- Dec 27, 2023, 2:38:22 PM IST
ALTER TABLE M_Attribute ADD CONSTRAINT EntityType_MAttribute FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 2:39:20 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208101,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',462,216311,'Y',40,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-27 14:39:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 14:39:19','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e5eb26e5-805b-448c-bee6-a6eb6d4987d8','Y',140,2)
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208101
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6364
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6366
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10645
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6360
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204143
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204144
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203472
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206510
;

-- Dec 27, 2023, 2:39:45 PM IST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 14:39:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207748
;

-- Dec 27, 2023, 3:09:17 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (216312,0,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',558,'EntityType','@SQL=select get_sysconfig(''DEFAULT_ENTITYTYPE'',''U'',0,0) from dual',40,'N','N','N','N','N',0,'N',18,389,0,0,'Y',TO_TIMESTAMP('2023-12-27 15:09:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 15:09:16','YYYY-MM-DD HH24:MI:SS'),100,1682,'Y','N','@EntityType@=D','D','N','N','N','Y','cd354f0b-2778-45e2-ae86-7908c397fb8d','Y',0,'N','N','N','N')
;

-- Dec 27, 2023, 3:09:21 PM IST
UPDATE AD_Column SET FKConstraintName='EntityType_MAttributeValue', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-12-27 15:09:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=216312
;

-- Dec 27, 2023, 3:09:21 PM IST
ALTER TABLE M_AttributeValue ADD COLUMN EntityType VARCHAR(40) DEFAULT NULL 
;

-- Dec 27, 2023, 3:09:21 PM IST
ALTER TABLE M_AttributeValue ADD CONSTRAINT EntityType_MAttributeValue FOREIGN KEY (EntityType) REFERENCES ad_entitytype(entitytype) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 27, 2023, 3:09:36 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208102,'Entity Type','Dictionary Entity Type; Determines ownership and synchronization','The Entity Types "Dictionary", "iDempiere" and "Application" might be automatically synchronized and customizations deleted or overwritten.  

For customizations, copy the entity and select "User"!',463,216312,'Y',40,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-12-27 15:09:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-12-27 15:09:35','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','549ffc5f-de53-4f8e-a0b2-24472dbe0908','Y',90,2)
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=10, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6370
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6367
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6371
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208102
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6374
;

-- Dec 27, 2023, 3:09:53 PM IST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2023-12-27 15:09:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204871
;

-- Update existing record Entity Type
UPDATE M_AttributeSet SET EntityType = 'D' WHERE M_AttributeSet_ID < 1000000;

UPDATE M_AttributeUse SET EntityType = 'D' WHERE  M_AttributeSet_ID  < 1000000 AND M_Attribute_ID < 1000000;

UPDATE M_Attribute SET EntityType = 'D' WHERE M_Attribute_ID < 1000000;

UPDATE M_AttributeValue SET EntityType = 'D' WHERE M_AttributeValue_ID < 1000000;

UPDATE M_AttributeSet SET EntityType = 'U' WHERE M_AttributeSet_ID >= 1000000;

UPDATE M_AttributeUse SET EntityType = 'U' WHERE  M_AttributeSet_ID  >= 1000000 OR M_Attribute_ID >= 1000000;

UPDATE M_Attribute SET EntityType = 'U' WHERE M_Attribute_ID >= 1000000;

UPDATE M_AttributeValue SET EntityType = 'U' WHERE M_AttributeValue_ID >= 1000000;

-- 01-Oct-2024, 11:32:59 PM IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('M','Table Attributes',0,0,'Y',TO_TIMESTAMP('2024-10-01 23:32:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-10-01 23:32:58','YYYY-MM-DD HH24:MI:SS'),100,200906,'TableAttribute','D','b4a225ad-d48b-4cf2-a9c8-a3ce54406c6d')
;

-- Nov 24, 2024, 6:19:50 PM CET
UPDATE AD_ToolBarButton SET SeqNo=230, IsShowMore='Y',Updated=TO_TIMESTAMP('2024-11-24 18:19:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200133
;


-- Dec 30, 2024, 6:34:35 PM IST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200423,'Table Attribute Set','AD_TableAttributeSet',0,'4',0,0,'Y',TO_TIMESTAMP('2024-12-30 18:34:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:34:32','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','7cb38526-36c2-4be0-a6d8-0b7ecbd76182','N','N','N','N','N','N','N')
;

-- Dec 30, 2024, 6:35:05 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217014,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200423,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:04','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','dd2d2f32-c886-4fec-8f5c-c56550493c4e','N')
;

-- Dec 30, 2024, 6:35:09 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217015,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200423,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:05','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','a106f72d-1b3a-486d-a9b9-b0f627b80157','N')
;

-- Dec 30, 2024, 6:35:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217016,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200423,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:09','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','358b5d24-d470-4cbe-9966-00f7804683e8','N')
;

-- Dec 30, 2024, 6:35:10 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217017,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200423,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','35b38bff-3573-4ed4-af80-c6bbacff0c92','N')
;

-- Dec 30, 2024, 6:35:11 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217018,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200423,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:10','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','e4e9da02-3ca0-41cd-92e0-bbe357eaddea','N')
;

-- Dec 30, 2024, 6:35:12 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217019,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200423,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:11','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','b3cd1409-119a-416f-ad91-85372dc0c08c','N')
;

-- Dec 30, 2024, 6:35:13 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217020,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200423,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:12','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','6188f193-9d54-4adc-a979-de925fd48a41','N')
;

-- Dec 30, 2024, 6:35:14 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203981,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:13','YYYY-MM-DD HH24:MI:SS'),100,'AD_TableAttributeSet_ID','Table Attribute Set','Table Attribute Set','D','0aa19adf-e0ff-42a8-9ab7-626351c0d40b')
;

-- Dec 30, 2024, 6:35:15 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217021,0.0,'Table Attribute Set',200423,'AD_TableAttributeSet_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:14','YYYY-MM-DD HH24:MI:SS'),100,203981,'N','N','D','N','a1b8677d-1f38-44a8-bd17-4b40769c116e','N')
;

-- Dec 30, 2024, 6:35:15 PM IST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203982,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,'AD_TableAttributeSet_UU','AD_TableAttributeSet_UU','AD_TableAttributeSet_UU','D','02ac8c7a-0651-435f-a78b-f905e7f35d7a')
;

-- Dec 30, 2024, 6:35:16 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217022,0.0,'AD_TableAttributeSet_UU',200423,'AD_TableAttributeSet_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-30 18:35:15','YYYY-MM-DD HH24:MI:SS'),100,203982,'Y','N','D','N','673ec975-7cd8-4bbf-b373-a5e7d4561439','N')
;

-- Dec 30, 2024, 6:35:17 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201280,'bd771f97-35b1-40e7-b596-acfae67cbb26',TO_TIMESTAMP('2024-12-30 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TableAttributeSet_UU_idx',TO_TIMESTAMP('2024-12-30 18:35:16','YYYY-MM-DD HH24:MI:SS'),100,200423,'Y','Y','N','N')
;

-- Dec 30, 2024, 6:35:18 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201744,'9d9113e4-1c01-4d9e-becc-55b4fa66f730',TO_TIMESTAMP('2024-12-30 18:35:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-12-30 18:35:17','YYYY-MM-DD HH24:MI:SS'),100,217022,201280,10)
;

-- Dec 31, 2024, 12:03:02 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217023,0,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',200423,'M_AttributeSet_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-31 12:02:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 12:02:58','YYYY-MM-DD HH24:MI:SS'),100,2017,'Y','N','D','N','N','N','Y','37d3699e-e284-4edc-9fbc-23753ff1e61f','Y',0,'N','N','N','N')
;

-- Dec 31, 2024, 12:03:47 PM IST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217024,0,'Table','Database Table information','The Database Table provides the information of the table definition',200423,'AD_Table_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2024-12-31 12:03:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 12:03:43','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','N','N','Y','e413ec9c-a549-46a8-82eb-6e480a8408f7','Y',0,'N','N','N','N','N')
;

-- Dec 31, 2024, 12:03:52 PM IST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2024-12-31 12:03:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217014
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217015
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET FKConstraintName='ADTable_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217017
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET FKConstraintName='MAttributeSet_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217023
;

-- Dec 31, 2024, 12:03:56 PM IST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADTableAttributeSet', FKConstraintType='N',Updated=TO_TIMESTAMP('2024-12-31 12:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217019
;

-- Dec 31, 2024, 12:03:56 PM IST
CREATE TABLE AD_TableAttributeSet (AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, AD_Table_ID NUMERIC(10) NOT NULL, AD_TableAttributeSet_ID NUMERIC(10) NOT NULL, AD_TableAttributeSet_UU VARCHAR(36) DEFAULT NULL , Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, M_AttributeSet_ID NUMERIC(10) NOT NULL, Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_TableAttributeSet_Key PRIMARY KEY (AD_TableAttributeSet_ID), CONSTRAINT AD_TableAttributeSet_UU_idx UNIQUE (AD_TableAttributeSet_UU))
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT ADClient_ADTableAttributeSet FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT ADOrg_ADTableAttributeSet FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT ADTable_ADTableAttributeSet FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT CreatedBy_ADTableAttributeSet FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT MAttributeSet_ADTableAttributeSet FOREIGN KEY (M_AttributeSet_ID) REFERENCES m_attributeset(m_attributeset_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:03:56 PM IST
ALTER TABLE AD_TableAttributeSet ADD CONSTRAINT UpdatedBy_ADTableAttributeSet FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Dec 31, 2024, 12:06:50 PM IST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201281,'b7d6c286-ac1e-4a41-a659-e8ef70361dc7',TO_TIMESTAMP('2024-12-31 12:06:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_TableAttributeSet_AttributeSet_Table',TO_TIMESTAMP('2024-12-31 12:06:46','YYYY-MM-DD HH24:MI:SS'),100,200423,'N','Y','N','N','N')
;

-- Dec 31, 2024, 12:07:02 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201745,'a5000058-2f8f-4b8c-9b1a-20337922afda',TO_TIMESTAMP('2024-12-31 12:07:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-12-31 12:07:01','YYYY-MM-DD HH24:MI:SS'),100,217023,201281,10)
;

-- Dec 31, 2024, 12:07:11 PM IST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201746,'11c240af-e3c7-4668-b977-b57cbeeffe50',TO_TIMESTAMP('2024-12-31 12:07:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2024-12-31 12:07:10','YYYY-MM-DD HH24:MI:SS'),100,217024,201281,20)
;

-- Dec 31, 2024, 12:07:19 PM IST
CREATE UNIQUE INDEX AD_TableAttributeSet_AttributeSet_Table ON AD_TableAttributeSet (M_AttributeSet_ID,AD_Table_ID)
;

-- Dec 31, 2024, 1:29:47 PM IST
UPDATE AD_Table SET Description='Creates a link between tables and attribute sets for flexible extensions. A table can have multiple attribute sets.', Help='Links system tables (AD_Table) with attribute sets (M_AttributeSet) to allow multiple attribute sets per table, enabling extensibility and avoiding plugin conflicts.',Updated=TO_TIMESTAMP('2024-12-31 13:29:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200423
;

-- Dec 31, 2024, 1:36:32 PM IST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200388,'Table Attribute Set',100,130,'Y',200423,0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:31','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','81067d1d-af66-4ab4-b564-7e95c15914ab','B','N','Y',0)
;

-- Dec 31, 2024, 1:36:48 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208681,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200388,217014,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d227418b-31fd-4aa3-9226-a42e7ae699d3','N',2)
;

-- Dec 31, 2024, 1:36:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208682,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200388,217015,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7e6adce9-ffd4-43f0-85e3-62f6155fc0c1','Y','N',4,2)
;

-- Dec 31, 2024, 1:36:49 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208683,'Table Attribute Set',200388,217021,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','208551a6-2bd2-4014-a629-8f3853b30b89','N',2)
;

-- Dec 31, 2024, 1:36:50 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208684,'AD_TableAttributeSet_UU',200388,217022,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5aa410f9-1e9e-4cf3-89bc-69009a4cb974','N',2)
;

-- Dec 31, 2024, 1:36:51 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208685,'Attribute Set','Product Attribute Set','Define Product Attribute Sets to add additional attributes and values to the product. You need to define a Attribute Set if you want to enable Serial and Lot Number tracking.',200388,217023,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f8253d62-00ed-4237-953d-b1db3af7bbca','Y',10,2)
;

-- Dec 31, 2024, 1:36:52 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208686,'Table','Database Table information','The Database Table provides the information of the table definition',200388,217024,'Y',10,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','75583812-2e5e-4032-90f4-d6d1d8973208','Y',20,2)
;

-- Dec 31, 2024, 1:36:53 PM IST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208687,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200388,217020,'Y',1,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2024-12-31 13:36:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-31 13:36:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7f6fc0ab-96b7-4c4e-964c-901caa6b8e38','Y',30,2,2)
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, XPosition=1,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208686
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208685
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208684
;

-- Dec 31, 2024, 1:37:23 PM IST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2024-12-31 13:37:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208683
;

-- Dec 31, 2024, 2:23:59 PM IST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200239, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200239)
;

-- Dec 31, 2024, 2:32:33 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200047,Updated=TO_TIMESTAMP('2024-12-31 14:32:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

-- Dec 31, 2024, 3:05:43 PM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200180,Updated=TO_TIMESTAMP('2024-12-31 15:05:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217023
;

-- Jan 1, 2025, 5:32:10 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_TableAttributeSet',1000000,'N','N','Table AD_TableAttributeSet','Y','Y',0,0,TO_TIMESTAMP('2025-01-01 17:32:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-01 17:32:09','YYYY-MM-DD HH24:MI:SS'),100,200494,'Y',1000000,1,200000,'8e73e118-776a-4f88-9270-076a2120b31a')
;

-- Jan 1, 2025, 5:32:43 PM IST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('DocumentNo_AD_TableAttribute',1000000,'N','N','DocumentNo/Value for Table AD_TableAttribute','Y','N',11,0,TO_TIMESTAMP('2025-01-01 17:32:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-01 17:32:42','YYYY-MM-DD HH24:MI:SS'),100,200515,'Y',1000000,1,200000,'5cce385d-98c4-4efc-80a1-6ab2958be900')
;

-- Mar 1, 2025, 1:36:34 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Extra Attributes',0,0,'Y',TO_TIMESTAMP('2025-03-01 13:36:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-03-01 13:36:33','YYYY-MM-DD HH24:MI:SS'),100,200940,'AttributeForm','D','26116a47-860b-43a8-920a-54cface6ade9')
;

-- Mar 1, 2025, 1:55:06 PM CET
UPDATE AD_Column SET IsParent='Y', AD_Reference_ID=30, IsUpdateable='N',Updated=TO_TIMESTAMP('2025-03-01 13:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217024
;

