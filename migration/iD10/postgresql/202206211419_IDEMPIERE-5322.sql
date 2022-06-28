-- IDEMPIERE-5322
SELECT register_migration_script('202206211419_IDEMPIERE-5322.sql') FROM dual;

-- Jun 21, 2022, 2:19:12 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable) VALUES (200350,'Document Rounding Rule','C_DocRoundingRule',0,'3',0,0,'Y',TO_TIMESTAMP('2022-06-21 14:19:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:19:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','0b435946-1a08-4db1-a99b-7a2ff4943f6e','N','N','N','N')
;

-- Jun 21, 2022, 2:19:13 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_DocRoundingRule',1000000,'N','N','Table C_DocRoundingRule','Y','Y',0,0,TO_TIMESTAMP('2022-06-21 14:19:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:19:12','YYYY-MM-DD HH24:MI:SS'),100,200418,'Y',1000000,1,200000,'4027781d-1c53-41a5-9ad5-e11e0b20e57a')
;

-- Jun 21, 2022, 2:20:31 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214939,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200350,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:20:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:20:31','YYYY-MM-DD HH24:MI:SS'),100,102,'Y','N','D','N','N','N','Y','8f10ad20-83f2-4566-a3a5-31e9034df300','N',0,'N','N','D','N')
;

-- Jun 21, 2022, 2:20:35 PM CEST
CREATE TABLE C_DocRoundingRule (AD_Client_ID NUMERIC(10) NOT NULL)
;

-- Jun 21, 2022, 2:21:33 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214940,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200350,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:21:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:21:33','YYYY-MM-DD HH24:MI:SS'),100,113,'Y','N','D','N','N','N','Y','e84ac2f5-5939-42cc-8dcc-1eb6e4bf3429','N',0,'N','N','D','N')
;

-- Jun 21, 2022, 2:21:36 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN AD_Org_ID NUMERIC(10) NOT NULL
;

-- Jun 21, 2022, 2:23:38 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214941,0,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200350,'C_Currency_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:23:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:23:38','YYYY-MM-DD HH24:MI:SS'),100,193,'Y','N','D','N','N','N','Y','6bb9a1a1-2d90-4848-8f38-138ede0b7d1f','Y',0,'N','N','N','N')
;

-- Jun 21, 2022, 2:23:42 PM CEST
UPDATE AD_Column SET FKConstraintName='CCurrency_CDocRoundingRule', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-06-21 14:23:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214941
;

-- Jun 21, 2022, 2:23:42 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN C_Currency_ID NUMERIC(10) NOT NULL
;

-- Jun 21, 2022, 2:23:42 PM CEST
ALTER TABLE C_DocRoundingRule ADD CONSTRAINT CCurrency_CDocRoundingRule FOREIGN KEY (C_Currency_ID) REFERENCES c_currency(c_currency_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 21, 2022, 2:26:10 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203603,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:26:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:26:09','YYYY-MM-DD HH24:MI:SS'),100,'C_DocRoundingRule_ID','Document Rounding Rule','Document Rounding Rule','D','51c15c47-e83f-441d-8789-eac70db3cca4')
;

-- Jun 21, 2022, 2:28:22 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214942,0,'Document Rounding Rule',200350,'C_DocRoundingRule_ID',22,'Y','N','Y','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:28:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:28:21','YYYY-MM-DD HH24:MI:SS'),100,203603,'N','N','D','N','N','N','Y','70e80e3d-86aa-43c1-915f-0abbe43950e6','N',0,'N','N','N','N')
;

-- Jun 21, 2022, 2:28:25 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN C_DocRoundingRule_ID NUMERIC(10) NOT NULL
;

-- Jun 21, 2022, 2:28:25 PM CEST
ALTER TABLE C_DocRoundingRule ADD CONSTRAINT C_DocRoundingRule_Key PRIMARY KEY (C_DocRoundingRule_ID)
;

-- Jun 21, 2022, 2:29:55 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203604,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:29:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:29:55','YYYY-MM-DD HH24:MI:SS'),100,'C_DocRoundingRule_UU','C_DocRoundingRule_UU','C_DocRoundingRule_UU','D','9d556ee2-e76d-451d-b4fa-097fb32a9b0f')
;

-- Jun 21, 2022, 2:38:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214943,0,'C_DocRoundingRule_UU',200350,'C_DocRoundingRule_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:38:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:38:42','YYYY-MM-DD HH24:MI:SS'),100,203604,'Y','N','D','N','N','N','Y','4187b3c2-d653-4556-8a75-2537fcfdb28a','N',0,'N','N','N','N')
;

-- Jun 21, 2022, 2:39:07 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214944,0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200350,'C_DocType_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:39:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:39:06','YYYY-MM-DD HH24:MI:SS'),100,196,'Y','N','D','N','N','N','Y','490cba45-c615-4a3a-b0ca-69d9fda43184','Y',0,'N','N','N')
;

-- Jun 21, 2022, 2:39:22 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN C_DocRoundingRule_UU VARCHAR(36) DEFAULT NULL 
;

-- Jun 21, 2022, 2:39:22 PM CEST
ALTER TABLE C_DocRoundingRule ADD CONSTRAINT C_DocRoundingRule_UU_idx UNIQUE (C_DocRoundingRule_UU)
;

-- Jun 21, 2022, 2:39:22 PM CEST
UPDATE AD_Column SET FKConstraintName='CDocType_CDocRoundingRule', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-06-21 14:39:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214944
;

-- Jun 21, 2022, 2:39:22 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN C_DocType_ID NUMERIC(10) NOT NULL
;

-- Jun 21, 2022, 2:39:22 PM CEST
ALTER TABLE C_DocRoundingRule ADD CONSTRAINT CDocType_CDocRoundingRule FOREIGN KEY (C_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 21, 2022, 2:39:29 PM CEST
INSERT INTO t_alter_column values('c_docroundingrule','C_DocType_ID','NUMERIC(10)',null,null)
;

-- Jun 21, 2022, 2:40:05 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214945,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200350,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:40:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:40:05','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','N','N','Y','1e60d1b8-f2fc-4022-a682-4ba11dcc8a7b','N',0,'N','N','N')
;

-- Jun 21, 2022, 2:40:08 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN Created TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Jun 21, 2022, 2:40:36 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214946,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200350,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:40:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:40:36','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','N','N','Y','163c2bcf-0160-4a3f-939a-9eeb3c8d30e3','N',0,'N','N','D','N')
;

-- Jun 21, 2022, 2:41:13 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214947,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200350,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:41:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:41:13','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','N','N','N','Y','e88e332e-3dbb-4603-b2e7-1577e0613625','Y',10,'N','N','N')
;

-- Jun 21, 2022, 2:41:16 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN CreatedBy NUMERIC(10) NOT NULL
;

-- Jun 21, 2022, 2:41:16 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN Description VARCHAR(255) DEFAULT NULL 
;

-- Jun 21, 2022, 2:43:24 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214948,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200350,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:43:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:43:24','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','N','N','Y','42587fc2-235c-410d-ac20-4c90d33b1098','N',0,'N','N','N')
;

-- Jun 21, 2022, 2:43:29 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jun 21, 2022, 2:44:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214949,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200350,'Name',60,'N','N','Y','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:44:32','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','N','N','N','Y','95020cf8-e07a-4e35-b47a-f88c7c3111d4','Y',20,'N','N','N')
;

-- Jun 21, 2022, 2:44:35 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN Name VARCHAR(60) NOT NULL
;

-- Jun 21, 2022, 2:47:23 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203605,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:47:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:47:22','YYYY-MM-DD HH24:MI:SS'),100,'RoundingRule','Rounding Rule','Rounding Rule','D','5568e28b-8289-4d4a-a306-53a90802ac5a')
;

-- Jun 21, 2022, 2:49:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214950,0,'Rounding Rule',200350,'RoundingRule',22,'N','N','Y','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:49:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:49:42','YYYY-MM-DD HH24:MI:SS'),100,203605,'Y','N','D','N','N','N','Y','6f174e37-f4b9-41e7-af32-352be6f4e12e','Y',0,'N','N','N','N')
;

-- Jun 21, 2022, 2:49:45 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN RoundingRule VARCHAR(22) NOT NULL
;

-- Jun 21, 2022, 2:50:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214951,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200350,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:50:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:50:17','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','N','N','Y','c2bc9d37-1748-430b-8e2a-328221347f94','N',0,'N','N','N')
;

-- Jun 21, 2022, 2:50:30 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN Updated TIMESTAMP DEFAULT statement_timestamp() NOT NULL
;

-- Jun 21, 2022, 2:51:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214952,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200350,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:51:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:51:01','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','N','N','Y','46f4ebc0-4223-43fa-a9e6-a868336c3923','N',0,'N','N','D','N')
;

-- Jun 21, 2022, 2:51:05 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN UpdatedBy NUMERIC(10) NOT NULL
;

-- Jun 21, 2022, 2:51:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214953,0,'Payment Rule','How you pay the invoice','The Payment Rule indicates the method of invoice payment.',200350,'PaymentRule',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:51:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:51:32','YYYY-MM-DD HH24:MI:SS'),100,1143,'N','N','D','N','N','N','Y','54a2c006-174b-4779-9838-0c3587666815','Y',0,'N','N','N')
;

-- Jun 21, 2022, 2:51:36 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN PaymentRule CHAR(1) DEFAULT NULL CHECK (PaymentRule IN ('Y','N'))
;

-- Jun 21, 2022, 2:52:10 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214954,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200350,'C_Charge_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:52:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:52:09','YYYY-MM-DD HH24:MI:SS'),100,968,'Y','N','D','N','N','N','Y','a29258ec-8a73-4d24-822a-94bb67a9e945','Y',0,'N','N','N')
;

-- Jun 21, 2022, 2:52:13 PM CEST
UPDATE AD_Column SET FKConstraintName='CCharge_CDocRoundingRule', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-06-21 14:52:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214954
;

-- Jun 21, 2022, 2:52:13 PM CEST
ALTER TABLE C_DocRoundingRule ADD COLUMN C_Charge_ID NUMERIC(10) NOT NULL
;

-- Jun 21, 2022, 2:52:13 PM CEST
ALTER TABLE C_DocRoundingRule ADD CONSTRAINT CCharge_CDocRoundingRule FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 21, 2022, 2:52:52 PM CEST
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2022-06-21 14:52:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214953
;

-- Jun 21, 2022, 2:59:05 PM CEST
UPDATE AD_Tab SET SeqNo=30,Updated=TO_TIMESTAMP('2022-06-21 14:59:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=230
;

-- Jun 21, 2022, 2:59:54 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200323,'Document Rounding Rule',135,20,'Y',200350,0,0,'Y',TO_TIMESTAMP('2022-06-21 14:59:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 14:59:54','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',1,'N','D','Y','N','0f1adc57-8099-4043-ab1c-44d90bdd0fa5','B','N','Y',0)
;

-- Jun 21, 2022, 3:01:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207081,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200323,214939,'Y',0,10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:01:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:01:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a426a725-4804-4d1a-8907-8ed0e0ea1434','Y',10,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:02:02 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207082,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200323,214940,'Y',0,20,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:02:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:02:01','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','3deb2cb9-229f-4f37-951b-f63a215fa5ef','Y','Y',20,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:02:18 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207083,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200323,214944,'Y',0,30,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:02:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:02:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fa4f2f6c-561c-4185-8193-570604fe60ed','Y',30,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:02:37 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207084,'Rounding Rule',200323,214950,'Y',0,40,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:02:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:02:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','15e327ff-0b6e-42a9-a4eb-9891213f58cd','Y',40,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:02:49 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207085,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200323,214949,'Y',0,50,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:02:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:02:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2c28e33c-2795-4a98-bfbb-c86d2b46a78a','Y',50,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:02:59 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207086,'Description','Optional short description of the record','A description is limited to 255 characters.',200323,214947,'Y',0,60,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:02:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:02:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','738f09a2-32ea-425b-bd62-8ff46a4896ec','Y',60,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:03:15 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207087,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200323,214941,'Y',0,70,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:03:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:03:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e620ec2c-c1ff-45f3-b70f-84ad2374ecfb','Y',70,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:03:28 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207088,'Payment Rule','How you pay the invoice','The Payment Rule indicates the method of invoice payment.',200323,214953,'Y',0,80,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:03:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:03:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','abab1441-cf23-476a-9943-0a1ffe4a3c1d','Y',80,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:03:41 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207089,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200323,214948,'Y',0,90,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:03:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:03:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eaebd96b-000f-46cc-a930-1e7c4586565b','Y',90,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:04:02 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207090,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200323,214954,'Y',0,100,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-21 15:04:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-21 15:04:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3dbdf3cb-93f5-4a2f-9cee-b880ce2acd58','Y',100,1,1,1,'N','N','N','N')
;

-- Jun 21, 2022, 3:06:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=20, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-21 15:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207082
;

-- Jun 21, 2022, 3:06:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-21 15:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207084
;

-- Jun 21, 2022, 3:06:24 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-21 15:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207085
;

-- Jun 21, 2022, 3:06:24 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-21 15:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207086
;

-- Jun 21, 2022, 3:06:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-21 15:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207088
;

-- Jun 21, 2022, 3:06:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-21 15:06:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207089
;

-- Jun 21, 2022, 3:07:12 PM CEST
UPDATE AD_Column SET AD_Reference_ID=200012,Updated=TO_TIMESTAMP('2022-06-21 15:07:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214953
;

-- Jun 21, 2022, 3:18:24 PM CEST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_TIMESTAMP('2022-06-21 15:18:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214944
;

-- Jun 22, 2022, 2:50:58 PM CEST
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=155,Updated=TO_TIMESTAMP('2022-06-22 14:50:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214950
;

-- Jun 23, 2022, 9:20:00 AM CEST
INSERT INTO t_alter_column values('c_docroundingrule','C_DocType_ID','NUMERIC(10)',null,null)
;

-- Jun 23, 2022, 9:20:00 AM CEST
INSERT INTO t_alter_column values('c_docroundingrule','RoundingRule','VARCHAR(22)',null,null)
;

-- Jun 23, 2022, 9:20:00 AM CEST
INSERT INTO t_alter_column values('c_docroundingrule','PaymentRule','CHAR(1)',null,'NULL')
;

-- Jun 23, 2022, 9:20:00 AM CEST
ALTER TABLE C_DocRoundingRule  DROP CONSTRAINT c_docroundingrule_paymentrule_check
;

-- Jun 23, 2022, 12:01:40 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203606,0,0,'Y',TO_TIMESTAMP('2022-06-23 12:01:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 12:01:40','YYYY-MM-DD HH24:MI:SS'),100,'CurrencyRoundAmt','Currency Round','Currency Round','D','1dec23c8-d3ac-4a7b-b5f6-3331ee802f5b')
;

-- Jun 23, 2022, 12:03:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214960,0,'Currency Round',259,'CurrencyRoundAmt',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2022-06-23 12:03:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 12:03:16','YYYY-MM-DD HH24:MI:SS'),100,203606,'Y','N','D','N','N','N','Y','0d35aa88-0e26-41a3-ac8d-61a9c43df8ec','Y',0,'N','N','N','N')
;

-- Jun 23, 2022, 12:03:27 PM CEST
ALTER TABLE C_Order ADD COLUMN CurrencyRoundAmt NUMERIC DEFAULT 0
;

-- Jun 23, 2022, 12:04:38 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207095,'Currency Round',186,214960,'Y',0,580,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-23 12:04:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 12:04:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','594a7dff-90bd-4100-9793-1fc46fe50b0f','Y',580,1,1,1,'N','N','N','N')
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207095
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201827
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201613
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1104
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1077
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1103
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8653
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1098
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3272
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2112
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2109
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3113
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1099
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56906
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2593
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2589
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1324
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7038
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7826
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7825
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1112
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1113
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=500, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1082
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=510, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1084
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=520, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60922
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=530, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6560
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=540, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1083
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=550, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58037
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=560, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3660
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=570, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60972
;

-- Jun 23, 2022, 12:05:07 PM CEST
UPDATE AD_Field SET SeqNo=580, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200756
;

-- Jun 23, 2022, 12:07:09 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214961,0,'Currency Round',318,'CurrencyRoundAmt',22,'N','N','N','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2022-06-23 12:07:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 12:07:09','YYYY-MM-DD HH24:MI:SS'),100,203606,'Y','N','D','N','N','N','Y','4f36e5ee-489a-46ea-b4eb-5bddb1a9caa5','Y',0,'N','N','N','N')
;

-- Jun 23, 2022, 12:09:00 PM CEST
ALTER TABLE C_Invoice ADD COLUMN CurrencyRoundAmt NUMERIC DEFAULT 0
;

-- Jun 23, 2022, 12:10:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207096,'Currency Round',263,214961,'Y',0,470,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-23 12:10:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 12:10:33','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bee6bc6d-ab1f-4ba6-aa66-4446a87448e9','Y',460,1,1,1,'N','N','N','N')
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205806
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205807
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2763
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3273
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2953
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2956
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207096
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3112
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2774
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4244
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2775
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2764
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2768
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6935
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7794
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7795
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2786
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2780
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2778
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2771
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8657
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10485
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6564
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2777
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3663
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3899
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13700
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53257
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=53258
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60970
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200050
;

-- Jun 23, 2022, 12:11:06 PM CEST
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 12:11:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206135
;

-- Jun 23, 2022, 12:17:05 PM CEST
ALTER TABLE C_DocRoundingRule DROP COLUMN C_Charge_ID
;

-- Jun 23, 2022, 12:17:25 PM CEST
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=214954
;

-- Jun 23, 2022, 12:17:25 PM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=214954
;

-- Jun 23, 2022, 12:19:23 PM CEST
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=207090
;

-- Jun 23, 2022, 12:19:23 PM CEST
DELETE FROM AD_Field WHERE AD_Field_ID=207090
;

-- Jun 23, 2022, 12:19:38 PM CEST
DELETE FROM AD_Column_Trl WHERE AD_Column_ID=214954
;

-- Jun 23, 2022, 12:19:38 PM CEST
DELETE FROM AD_Column WHERE AD_Column_ID=214954
;

-- Jun 23, 2022, 4:23:59 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203607,0,0,'Y',TO_TIMESTAMP('2022-06-23 16:23:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 16:23:59','YYYY-MM-DD HH24:MI:SS'),100,'RoundingGain_Acct','Rounding Gain Acct','Rounding Gain Account','The Rounding Gain Account indicates the account to be used when recording gains achieved from currency rounding that have been realized.','Rounding Gain Acct','D','386dc43f-53ed-42f7-ac98-b3ac4ae218f4')
;

-- Jun 23, 2022, 4:28:26 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203608,0,0,'Y',TO_TIMESTAMP('2022-06-23 16:28:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 16:28:25','YYYY-MM-DD HH24:MI:SS'),100,'RoundingLoss_Acct','Rounding Loss Acct','Rounding Loss Account','The Rounding Loss Account indicates the account to be used when recording losses incurred from currency rounding that have yet to be realized.','Rounding Loss Acct','D','f0ddff56-238b-4247-be07-6d8eb0a0b27f')
;

-- Jun 23, 2022, 5:00:08 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214965,0,'Rounding Gain Acct','Rounding Gain Account','The Rounding Gain Account indicates the account to be used when recording gains achieved from currency rounding that have been realized.',315,'RoundingGain_Acct',22,'N','N','N','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2022-06-23 17:00:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 17:00:07','YYYY-MM-DD HH24:MI:SS'),100,203607,'Y','N','D','N','N','N','Y','cf689e42-9069-4076-b724-ba7bf0bdd988','Y',0,'N','N','N','N')
;

-- Jun 23, 2022, 5:00:13 PM CEST
UPDATE AD_Column SET FKConstraintName='RoundingGainAcct_CAcctSchemaDe', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-06-23 17:00:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214965
;

-- Jun 23, 2022, 5:00:13 PM CEST
ALTER TABLE C_AcctSchema_Default ADD COLUMN RoundingGain_Acct NUMERIC(10) DEFAULT NULL 
;

-- Jun 23, 2022, 5:00:13 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT RoundingGainAcct_CAcctSchemaDe FOREIGN KEY (RoundingGain_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 23, 2022, 5:00:44 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214966,0,'Rounding Loss Acct','Rounding Loss Account','The Rounding Loss Account indicates the account to be used when recording losses incurred from currency rounding that have yet to be realized.',315,'RoundingLoss_Acct',22,'N','N','N','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2022-06-23 17:00:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 17:00:43','YYYY-MM-DD HH24:MI:SS'),100,203608,'Y','N','D','N','N','N','Y','5a659f01-4bee-4e83-ad65-b6ef72baf8a7','Y',0,'N','N','N','N')
;

-- Jun 23, 2022, 5:00:48 PM CEST
UPDATE AD_Column SET FKConstraintName='RoundingLossAcct_CAcctSchemaDe', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-06-23 17:00:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214966
;

-- Jun 23, 2022, 5:00:48 PM CEST
ALTER TABLE C_AcctSchema_Default ADD COLUMN RoundingLoss_Acct NUMERIC(10) DEFAULT NULL 
;

-- Jun 23, 2022, 5:00:48 PM CEST
ALTER TABLE C_AcctSchema_Default ADD CONSTRAINT RoundingLossAcct_CAcctSchemaDe FOREIGN KEY (RoundingLoss_Acct) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 23, 2022, 5:02:20 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207098,'Rounding Gain Acct','Rounding Gain Account','The Rounding Gain Account indicates the account to be used when recording gains achieved from currency rounding that have been realized.',252,214965,'Y',0,680,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-23 17:02:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 17:02:20','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c1db498b-7440-4478-bd1c-35101d29ac51','Y',790,1,1,1,'N','N','N','N')
;

-- Jun 23, 2022, 5:02:53 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207099,'Rounding Loss Acct','Rounding Loss Account','The Rounding Loss Account indicates the account to be used when recording losses incurred from currency rounding that have yet to be realized.',252,214966,'Y',0,690,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-06-23 17:02:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-06-23 17:02:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8af6cc2c-ae7e-4ef8-915d-05d8627ac7fa','Y',800,1,1,1,'N','N','N','N')
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207098
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207099
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3822
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3853
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3827
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3829
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3828
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2650
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2659
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2649
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2661
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2655
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2657
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12347
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12348
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2656
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2658
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3825
;

-- Jun 23, 2022, 5:03:46 PM CEST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4860
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4861
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4862
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56527
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=58783
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202403
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2662
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3842
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3841
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5132
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5133
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3845
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3844
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3839
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3840
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3836
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3851
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2654
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3835
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3823
;

-- Jun 23, 2022, 5:03:47 PM CEST
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-23 17:03:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204659
;

-- Jun 27, 2022, 1:55:48 PM CEST
UPDATE AD_Column SET DefaultValue='0', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2022-06-27 13:55:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214960
;

-- Jun 27, 2022, 1:56:44 PM CEST
UPDATE AD_Column SET DefaultValue='0', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_TIMESTAMP('2022-06-27 13:56:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214961
;

-- Jun 27, 2022, 2:02:14 PM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207095
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201827
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201613
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1104
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1077
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1103
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8653
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1098
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3272
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2112
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2109
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3113
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1099
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56906
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2593
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2589
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1324
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=440, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7038
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7826
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7825
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1112
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1113
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1082
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=500, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1084
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=510, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=60922
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET SeqNo=520, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6560
;

-- Jun 27, 2022, 2:02:43 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=530, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:02:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207095
;

-- Jun 27, 2022, 2:03:22 PM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsDisplayedGrid='N', IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207096
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3112
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2774
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4244
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2775
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2764
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2768
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6935
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7794
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=7795
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2786
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2780
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2778
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2771
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8657
;

-- Jun 27, 2022, 2:03:42 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:03:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207096
;

-- Jun 27, 2022, 2:06:54 PM CEST
UPDATE AD_Field SET SeqNo=10, IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207081
;

-- Jun 27, 2022, 2:06:54 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207089
;

-- Jun 27, 2022, 2:06:54 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-06-27 14:06:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207084
;

