-- IDEMPIERE-6640 DBA - Tuning AD_Attachment (FHCA-3962)
-- This migration creates the AD_AttachmentFile table to store attachment file metadata
-- as an alternative to storing the list in XML within AD_Attachment.BinaryData.
-- It also creates the corresponding UI tab under the Attachment window.
SELECT register_migration_script('202507311636_IDEMPIERE-6640.sql') FROM dual;

-- Jul 31, 2025, 4:36:36 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200432,'Attachment File','AD_AttachmentFile','6',0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','19dd11ca-6f3a-4207-8389-c21e406937fe','N')
;

-- Jul 31, 2025, 4:36:36 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_AttachmentFile',1000000,'N','N','Table AD_AttachmentFile','Y','Y',0,0,TO_TIMESTAMP('2025-07-31 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,200522,'Y',1000000,1,200000,'9612202a-6647-43a1-9fe3-819dbb038c0c')
;

-- Jul 31, 2025, 4:36:37 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217143,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200432,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:36','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','59736e4d-7fda-4a68-8d8c-4bbf8fa94aef','N')
;

-- Jul 31, 2025, 4:36:37 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217144,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200432,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','8625bf07-4747-4391-97c3-3b665899aaa6','N')
;

-- Jul 31, 2025, 4:36:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217145,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200432,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:37','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','906c449a-a0d1-44ef-a5c0-ba4c322e3fa5','N')
;

-- Jul 31, 2025, 4:36:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217146,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200432,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:38','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','46188d9e-85f5-481b-9be0-cd197016abdc','N')
;

-- Jul 31, 2025, 4:36:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217147,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200432,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:38','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','c0b60eb5-ac45-4332-8ef1-9341a15400d8','N')
;

-- Jul 31, 2025, 4:36:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217148,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200432,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:38','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','afc29148-42a1-44e5-a460-c0f0019506ed','N')
;

-- Jul 31, 2025, 4:36:39 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217149,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200432,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:39','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','f10ce507-0f63-4822-9e53-0c4ebb6c2004','N')
;

-- Jul 31, 2025, 4:36:39 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204015,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:39','YYYY-MM-DD HH24:MI:SS'),100,'AD_AttachmentFile_UU','AD_AttachmentFile_UU','AD_AttachmentFile_UU','D','55cbc517-957d-459a-b9cf-831b2d1a6f15')
;

-- Jul 31, 2025, 4:36:40 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217150,0.0,'AD_AttachmentFile_UU',200432,'AD_AttachmentFile_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:36:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:36:39','YYYY-MM-DD HH24:MI:SS'),100,204015,'Y','N','D','N','a71575bb-e717-4894-beba-5fc59f318b06','N')
;

-- Jul 31, 2025, 4:36:40 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201290,'8c2c30e7-3dc9-43ce-9f79-75e28e54216d',TO_TIMESTAMP('2025-07-31 16:36:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_AttachmentFile_UU_idx',TO_TIMESTAMP('2025-07-31 16:36:40','YYYY-MM-DD HH24:MI:SS'),100,200432,'Y','Y','N','Y')
;

-- Jul 31, 2025, 4:36:40 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201765,'ef04eaf9-f272-410e-afe8-89f364800739',TO_TIMESTAMP('2025-07-31 16:36:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2025-07-31 16:36:40','YYYY-MM-DD HH24:MI:SS'),100,217150,201290,10)
;

-- Jul 31, 2025, 4:37:34 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217151,0,'Attachment','Attachment for the document','Attachment can be of any document/file type and can be attached to any record in the system.',200432,'AD_Attachment_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:37:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:37:34','YYYY-MM-DD HH24:MI:SS'),100,101,'N','N','D','N','N','N','Y','af0136ad-5bb8-4219-bf7b-e3a375e5ff8d','Y',0,'N','N','N','N')
;

-- Jul 31, 2025, 4:38:12 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217152,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200432,'SeqNo',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:38:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:38:12','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','f64bdb77-4376-46fe-b825-7574edd94f18','Y',0,'N','N','N','N')
;

-- Jul 31, 2025, 4:38:35 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217153,0,'File Name','Name of the local file or URL','Name of a file in the local directory space - or URL (file://.., http://.., ftp://..)',200432,'FileName',1000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:38:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:38:35','YYYY-MM-DD HH24:MI:SS'),100,2295,'Y','Y','D','N','N','N','Y','f7bd01af-56c9-45b8-866e-f750f0b5281b','Y',10,'N','N','N','N')
;

-- Jul 31, 2025, 4:38:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217154,0,'File Size','Size of the File in bytes',200432,'FileSize',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:38:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:38:57','YYYY-MM-DD HH24:MI:SS'),100,3067,'Y','N','D','N','N','N','Y','e8ae48e1-585e-4c9d-bb74-50ea717bee38','Y',0,'N','N','N','N')
;

-- Jul 31, 2025, 4:40:11 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204016,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:39:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:39:32','YYYY-MM-DD HH24:MI:SS'),100,'SHA256Checksum','SHA256 Checksum',NULL,NULL,'SHA256 Checksum','D','53f91140-d608-4e04-97a6-4523128dcf57')
;

-- Jul 31, 2025, 4:41:47 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217155,0,'SHA256 Checksum',200432,'SHA256Checksum',64,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:41:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:41:47','YYYY-MM-DD HH24:MI:SS'),100,204016,'Y','N','D','N','N','N','Y','6ec38302-6ebb-4236-93b8-b422d9bed817','Y',0,'N','N','N','N')
;

-- Jul 31, 2025, 4:42:45 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204017,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:42:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:42:36','YYYY-MM-DD HH24:MI:SS'),100,'MIMEType','MIME Type',NULL,NULL,'MIME Type','D','14561a08-5de5-4cbc-b284-fd7e8d61fabf')
;

-- Jul 31, 2025, 4:42:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217156,0,'MIME Type',200432,'MIMEType',1000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-07-31 16:42:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 16:42:52','YYYY-MM-DD HH24:MI:SS'),100,204017,'Y','N','D','N','N','N','Y','ddfa0f91-e7e5-4428-8564-7518b3c84c3b','Y',0,'N','N','N','N')
;

-- Jul 31, 2025, 6:33:53 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADAttachment_ADAttachmentFile', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-07-31 18:33:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217151
;

-- Jul 31, 2025, 6:33:53 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_ADAttachmentFile', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-07-31 18:33:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217143
;

-- Jul 31, 2025, 6:33:53 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_ADAttachmentFile', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-07-31 18:33:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217144
;

-- Jul 31, 2025, 6:33:53 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_ADAttachmentFile', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-07-31 18:33:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217146
;

-- Jul 31, 2025, 6:33:54 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_ADAttachmentFile', FKConstraintType='N',Updated=TO_TIMESTAMP('2025-07-31 18:33:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217148
;

-- Dec 23, 2025, 10:13:52 PM CET
CREATE TABLE AD_AttachmentFile (AD_AttachmentFile_UU UUID DEFAULT NULL , AD_Attachment_ID NUMERIC(10) DEFAULT NULL , AD_Client_ID NUMERIC(10) NOT NULL, AD_Org_ID NUMERIC(10) NOT NULL, Created TIMESTAMP NOT NULL, CreatedBy NUMERIC(10) NOT NULL, FileName VARCHAR(1000) DEFAULT NULL , FileSize NUMERIC(10) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, SHA256Checksum VARCHAR(64) DEFAULT NULL , MIMEType VARCHAR(1000) DEFAULT NULL , SeqNo NUMERIC(10) DEFAULT NULL , Updated TIMESTAMP NOT NULL, UpdatedBy NUMERIC(10) NOT NULL, CONSTRAINT AD_AttachmentFile_UU_idx PRIMARY KEY (AD_AttachmentFile_UU))
;

-- Jul 31, 2025, 6:33:54 PM CEST
ALTER TABLE AD_AttachmentFile ADD CONSTRAINT ADAttachment_ADAttachmentFile FOREIGN KEY (AD_Attachment_ID) REFERENCES ad_attachment(ad_attachment_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 31, 2025, 6:33:54 PM CEST
ALTER TABLE AD_AttachmentFile ADD CONSTRAINT ADClient_ADAttachmentFile FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 31, 2025, 6:33:54 PM CEST
ALTER TABLE AD_AttachmentFile ADD CONSTRAINT ADOrg_ADAttachmentFile FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 31, 2025, 6:33:54 PM CEST
ALTER TABLE AD_AttachmentFile ADD CONSTRAINT CreatedBy_ADAttachmentFile FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 31, 2025, 6:33:54 PM CEST
ALTER TABLE AD_AttachmentFile ADD CONSTRAINT UpdatedBy_ADAttachmentFile FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 31, 2025, 6:36:41 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200398,'Attachment File',128,30,'Y',200432,0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N',217151,'AD_AttachmentFile.Created DESC','N',1,'N','D','Y','N','c4dbf7a9-9de9-42dc-89e7-85282d234c31')
;

-- Jul 31, 2025, 6:36:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208833,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200398,217143,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aa25eb50-ada0-4d6c-ae0e-af57a2753f46','Y',10,2)
;

-- Jul 31, 2025, 6:36:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan) VALUES (208834,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200398,217144,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','40e7787b-7ed6-43ca-bfe0-7d3568e14a96','Y','N',4,2)
;

-- Jul 31, 2025, 6:36:42 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208835,'Attachment','Attachment for the document','Attachment can be of any document/file type and can be attached to any record in the system.',200398,217151,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5e25e14a-15e6-4f7e-bfa5-3e2ac0e10f5c','Y',20,2)
;

-- Jul 31, 2025, 6:36:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (208836,'AD_AttachmentFile_UU',200398,217150,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:42','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','73386284-95da-41e0-a6ff-6ff939dc05b7','N',2)
;

-- Jul 31, 2025, 6:36:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208837,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200398,217152,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f66ff2c2-3cb9-479d-acc8-c95123af4047','Y',30,2)
;

-- Jul 31, 2025, 6:36:43 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208838,'File Name','Name of the local file or URL','Name of a file in the local directory space - or URL (file://.., http://.., ftp://..)',200398,217153,'Y',1000,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6a35527e-e482-4042-bd1b-3cb2f5b948e1','Y',40,5)
;

-- Jul 31, 2025, 6:36:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208839,'File Size','Size of the File in bytes',200398,217154,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','562ac83e-70ee-410c-8a2f-9294518f607e','Y',50,2)
;

-- Jul 31, 2025, 6:36:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208840,'SHA256 Checksum',200398,217155,'Y',64,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','64310170-e745-401b-b0f7-26aab1696595','Y',60,2)
;

-- Jul 31, 2025, 6:36:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208841,'MIME Type',200398,217156,'Y',1000,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f6bf16c2-a19f-4132-9de4-4f884951ac7d','Y',70,5)
;

-- Jul 31, 2025, 6:36:44 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (208842,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200398,217149,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-07-31 18:36:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-07-31 18:36:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e9e4904a-50f2-4abe-b132-93abc52605d0','Y',80,2,2)
;

-- Jul 31, 2025, 6:36:44 PM CEST
UPDATE AD_Table SET AD_Window_ID=128,Updated=TO_TIMESTAMP('2025-07-31 18:36:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200432
;

-- Jul 31, 2025, 6:36:58 PM CEST
UPDATE AD_Tab SET SeqNo=30,Updated=TO_TIMESTAMP('2025-07-31 18:36:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=643
;

-- Jul 31, 2025, 6:37:03 PM CEST
UPDATE AD_Tab SET SeqNo=20,Updated=TO_TIMESTAMP('2025-07-31 18:37:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200398
;

-- Jul 31, 2025, 6:37:59 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2025-07-31 18:37:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208836
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208835
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='N', SeqNoGrid=0,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208833
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=10,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208837
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=20,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208838
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=30,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208839
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208840
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208841
;

-- Jul 31, 2025, 6:38:26 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2025-07-31 18:38:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208842
;

-- Aug 5, 2025, 10:23:56 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200275,'AD_Attachment Title','L',0,0,'Y',TO_TIMESTAMP('2025-08-05 22:23:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:23:55','YYYY-MM-DD HH24:MI:SS'),100,'D','N','a2f51a49-358d-411a-b1cd-4a23bb7cfdb9','N')
;

-- Aug 5, 2025, 10:24:28 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200732,'None',200275,'.',0,0,'Y',TO_TIMESTAMP('2025-08-05 22:24:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:24:28','YYYY-MM-DD HH24:MI:SS'),100,'D','0406ec25-a7ef-450f-bae0-e5f2c25ff7bc')
;

-- Aug 5, 2025, 10:24:38 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200733,'Zip',200275,'zip',0,0,'Y',TO_TIMESTAMP('2025-08-05 22:24:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:24:38','YYYY-MM-DD HH24:MI:SS'),100,'D','47a244f5-666e-40be-be27-1bf55365ee5b')
;

-- Aug 5, 2025, 10:24:49 PM CEST
UPDATE AD_Ref_List SET Name='XML', Value='xml',Updated=TO_TIMESTAMP('2025-08-05 22:24:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200733
;

-- Aug 5, 2025, 10:25:06 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200734,'List in Attachment File',200275,'laf',0,0,'Y',TO_TIMESTAMP('2025-08-05 22:25:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:25:05','YYYY-MM-DD HH24:MI:SS'),100,'D','a1d12235-a0ca-46f9-9377-cc2e49a0cc37')
;

-- Aug 5, 2025, 10:25:23 PM CEST
UPDATE AD_Ref_List SET Name='List in XML',Updated=TO_TIMESTAMP('2025-08-05 22:25:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Ref_List_ID=200733
;

-- Aug 5, 2025, 10:25:34 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200735,'List in ZIP file',200275,'zip',0,0,'Y',TO_TIMESTAMP('2025-08-05 22:25:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:25:33','YYYY-MM-DD HH24:MI:SS'),100,'D','63365afc-26c3-462b-aad7-58199cca473c')
;

-- Aug 5, 2025, 10:26:06 PM CEST
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=200275,Updated=TO_TIMESTAMP('2025-08-05 22:26:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4822
;

-- Aug 5, 2025, 10:27:09 PM CEST
UPDATE AD_Field SET Name='List of Files', Description='Where to find the list of files on this attachment', Help='Where to find the list of files on this attachment, it can be ZIP, XML or in Attachment File', IsCentrallyMaintained='N',Updated=TO_TIMESTAMP('2025-08-05 22:27:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3819
;

-- Aug 5, 2025, 10:27:36 PM CEST
UPDATE AD_Tab SET IsActive='N',Updated=TO_TIMESTAMP('2025-08-05 22:27:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=643
;

-- Aug 5, 2025, 10:49:56 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204018,0,0,'Y',TO_TIMESTAMP('2025-08-05 22:49:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:49:34','YYYY-MM-DD HH24:MI:SS'),100,'FilePath','File Path','Path where the file can be found',NULL,'File Path','D','c4f22c17-654d-4374-8cdf-8dbe29e3217b')
;

-- Aug 5, 2025, 10:50:35 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217157,0,'File Path','Path where the file can be found',200432,'FilePath',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2025-08-05 22:50:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:50:35','YYYY-MM-DD HH24:MI:SS'),100,204018,'Y','N','D','N','N','N','Y','8d4ed8cd-d247-4613-9bea-176a56cac690','Y',0,'N','N','N','N')
;

-- Aug 5, 2025, 10:50:41 PM CEST
ALTER TABLE AD_AttachmentFile ADD COLUMN FilePath VARCHAR(4000) DEFAULT NULL 
;

-- Aug 5, 2025, 10:51:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (208843,'File Path','Path where the file can be found',200398,217157,'Y',4000,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2025-08-05 22:51:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-08-05 22:51:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9b0d3488-628d-4cf3-8b64-c35bc4b9bf41','Y',70,5)
;

-- Aug 5, 2025, 10:51:39 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, XPosition=1,Updated=TO_TIMESTAMP('2025-08-05 22:51:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208843
;

-- Aug 5, 2025, 10:51:39 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2025-08-05 22:51:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208842
;

-- Aug 5, 2025, 10:51:48 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=60,Updated=TO_TIMESTAMP('2025-08-05 22:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208843
;

-- Aug 5, 2025, 10:51:48 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=70,Updated=TO_TIMESTAMP('2025-08-05 22:51:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208842
;

-- Aug 5, 2025, 11:28:53 PM CEST
UPDATE AD_Column SET AD_Reference_ID=22, FKConstraintType=NULL,Updated=TO_TIMESTAMP('2025-08-05 23:28:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217154
;

-- Aug 5, 2025, 11:28:57 PM CEST
INSERT INTO t_alter_column values('ad_attachmentfile','FileSize','NUMERIC',null,'NULL')
;

-- Sep 30, 2025, 1:35:51 AM CEST
UPDATE AD_Field SET SeqNo=70, ColumnSpan=5,Updated=TO_TIMESTAMP('2025-09-30 01:35:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=208840
;

-- Sep 30, 2025, 1:38:48 AM CEST
UPDATE AD_Column SET FormatPattern='#,##0',Updated=TO_TIMESTAMP('2025-09-30 01:38:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217154
;

-- Sep 30, 2025, 1:39:16 AM CEST
UPDATE AD_Tab SET OrderByClause='AD_AttachmentFile.SeqNo',Updated=TO_TIMESTAMP('2025-09-30 01:39:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200398
;

-- Dec 24, 2025, 12:34:18 AM CET
UPDATE AD_Column SET IsAllowLogging='N',Updated=TO_TIMESTAMP('2025-12-24 00:34:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217152
;

-- Dec 24, 2025, 1:02:53 AM CET
UPDATE AD_Tab SET IsReadOnly='Y', IsInsertRecord='N',Updated=TO_TIMESTAMP('2025-12-24 01:02:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200398
;

-- Dec 24, 2025, 8:45:18 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200289,0,0,TO_TIMESTAMP('2025-12-24 20:45:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2025-12-24 20:45:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ATTACHMENT_SAVE_LIST_IN_AD_ATTACHMENTFILE','Y','Defines if the attachment list is saved in the table AD_AttachmentFile.  When N the list is saved as an XML in AD_Attachment.BinaryData','D','C','019b51e4-f57d-7686-81ba-fee6ef3f4a22')
;

-- Dec 24, 2025, 8:46:43 PM CET
UPDATE AD_SysConfig SET ConfigurationLevel='C',Description='It specifies the maximum allowed size, in kilobytes, to upload a file from the client. A zero or negative value uses the zk default limit (5MB). Max size is 2147483647 KB',Updated=TO_TIMESTAMP('2025-12-24 20:46:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200028
;

-- Dec 25, 2025, 8:59:41 PM CET
UPDATE AD_Tab SET DisplayLogic='@Title@=laf',Updated=TO_TIMESTAMP('2025-12-25 20:59:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200398
;

-- Fix wrong sample attachment
UPDATE ad_attachment SET title='.' WHERE ad_attachment_id=100
;

