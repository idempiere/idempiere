-- IDEMPIERE-5229 After migrate helper (FHCA-4070)
SELECT register_migration_script('202301131932_IDEMPIERE-5229.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 13, 2023, 7:32:52 PM CET
UPDATE AD_Column SET IsIdentifier='N', SeqNo=NULL,Updated=TO_TIMESTAMP('2023-01-13 19:32:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=8584
;

-- Jan 13, 2023, 9:27:27 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200149,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:26','YYYY-MM-DD HH24:MI:SS'),100,'Verify Migration Process','This process helps to verify if everything is OK after a migration and discover possible customizations lost','The Date To parameter serves to filter the change audit records, in case you want to detect changes just until some date, when empty it process all change audit records','N','VerifyMigration','N','org.idempiere.process.VerifyMigration','4','D',33,77,'N','Y','N','b85e55fb-9cd1-4db8-8978-1fef6a2b92f5','P')
;

-- Jan 13, 2023, 9:27:27 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) VALUES (200418,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:27','YYYY-MM-DD HH24:MI:SS'),100,'Date To','Last Date to verify Change Log','The change log is verified until this date (useful for example to exclude the application of some 2Packs)',200149,10,15,'N',10,'N','DateTo','N','D',1582,'2b2be270-98d5-4051-ae88-a872957b7ed3','N','N')
;

-- Jan 13, 2023, 9:27:28 PM CET
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200137,'Verify Migration',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:27','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N','N','3abf93ee-024e-4edc-8fe0-38906f0e4853')
;

-- Jan 13, 2023, 9:27:28 PM CET
INSERT INTO AD_Table (AD_Table_ID,Name,Description,AD_Window_ID,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,IsCentrallyMaintained,AD_Table_UU,Processing,IsShowInDrillOptions) VALUES (200382,'Verify Migration','Verify Migration Helper',200137,'AD_VerifyMigration','4',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:28','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','Y','2dc9992b-f4ca-4bb7-9632-3c51b3001c22','N','Y')
;

-- Jan 13, 2023, 9:27:28 PM CET
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_VerifyMigration',1000000,'N','N','Table AD_VerifyMigration','Y','Y',0,0,TO_TIMESTAMP('2023-01-13 21:27:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:28','YYYY-MM-DD HH24:MI:SS'),100,200452,'Y',1000000,1,200000,'5f2776f9-0a69-4cd0-be28-5c4b9108e3fd')
;

-- Jan 13, 2023, 9:27:29 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203778,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:28','YYYY-MM-DD HH24:MI:SS'),100,'AD_VerifyMigration_ID','Verify Migration','Verify Migration Helper','Verify Migration','D','15ff32ea-70d8-412e-b764-320b75ca9451')
;

-- Jan 13, 2023, 9:27:29 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215741,0.0,'Verify Migration','Verify Migration Helper',200382,'AD_VerifyMigration_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:29','YYYY-MM-DD HH24:MI:SS'),100,203778,'N','N','D','Y','N','N','Y','6a2b7312-3b39-4467-bfc4-8e931976c32c','N','N','N','N','N')
;

-- Jan 13, 2023, 9:27:29 PM CET
CREATE TABLE AD_VerifyMigration (AD_VerifyMigration_ID NUMBER(10) NOT NULL, CONSTRAINT AD_VerifyMigration_Key PRIMARY KEY (AD_VerifyMigration_ID))
;

-- Jan 13, 2023, 9:27:29 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215742,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200382,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:29','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','Y','N','N','Y','16e8b845-e0d8-4974-9408-f342ae9a6f84','N','N','N','ADClient_ADVerifyMigration','N','N')
;

-- Jan 13, 2023, 9:27:30 PM CET
ALTER TABLE AD_VerifyMigration ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Jan 13, 2023, 9:27:30 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215743,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200382,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:30','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','a98d0040-73a8-4b23-9ac5-6f409b9df1bc','N','N','N','ADOrg_ADVerifyMigration','N','N')
;

-- Jan 13, 2023, 9:27:30 PM CET
ALTER TABLE AD_VerifyMigration ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jan 13, 2023, 9:27:30 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215744,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200382,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:30','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','46894a6b-8bcc-4886-a822-b426fc605136','N','N','N','N','N')
;

-- Jan 13, 2023, 9:27:30 PM CET
ALTER TABLE AD_VerifyMigration ADD Created DATE NOT NULL
;

-- Jan 13, 2023, 9:27:31 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215745,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200382,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:30','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','0c631d37-2e5b-4726-9256-92cf06dea9fc','N','N','N','CreatedBy_ADVerifyMigration','N','N')
;

-- Jan 13, 2023, 9:27:31 PM CET
ALTER TABLE AD_VerifyMigration ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jan 13, 2023, 9:27:31 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215746,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200382,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:31','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','ffd05151-3cba-4c4b-b2ad-3c667dcb5d3a','N','N','N','N','N')
;

-- Jan 13, 2023, 9:27:31 PM CET
ALTER TABLE AD_VerifyMigration ADD Updated DATE NOT NULL
;

-- Jan 13, 2023, 9:27:31 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215747,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200382,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:31','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','6e4ed7d7-b816-4dc3-b1a1-b9efdc35d829','N','N','N','UpdatedBy_ADVerifyMigration','N','N')
;

-- Jan 13, 2023, 9:27:31 PM CET
ALTER TABLE AD_VerifyMigration ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jan 13, 2023, 9:27:32 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215748,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200382,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:31','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','5f7a10aa-58ec-435e-8b01-614881ac9054','N','N','N','N','N')
;

-- Jan 13, 2023, 9:27:32 PM CET
ALTER TABLE AD_VerifyMigration ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jan 13, 2023, 9:27:32 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203779,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:32','YYYY-MM-DD HH24:MI:SS'),100,'AD_VerifyMigration_UU','AD_VerifyMigration_UU','AD_VerifyMigration_UU','D','b36386a6-ea21-4219-b11c-d2801978e36f')
;

-- Jan 13, 2023, 9:27:32 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215749,0.0,'AD_VerifyMigration_UU',200382,'AD_VerifyMigration_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:32','YYYY-MM-DD HH24:MI:SS'),100,203779,'Y','N','D','Y','N','N','Y','1c6f8685-7c86-4ea2-8058-20ff3abb45b6','N','N','N','N','N')
;

-- Jan 13, 2023, 9:27:32 PM CET
ALTER TABLE AD_VerifyMigration ADD AD_VerifyMigration_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:32 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT AD_VerifyMigration_UU_idx UNIQUE (AD_VerifyMigration_UU)
;

-- Jan 13, 2023, 9:27:33 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215750,0.0,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200382,'Help',2000,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:32','YYYY-MM-DD HH24:MI:SS'),100,326,'Y','N','D','Y','N','N','Y','fcc28851-f6f1-45f8-a0ba-060a2c5c4fac','Y','N','N','N','N')
;

-- Jan 13, 2023, 9:27:33 PM CET
ALTER TABLE AD_VerifyMigration ADD Help VARCHAR2(2000 CHAR) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:33 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215751,0,'Process Instance','Instance of the process',200382,'AD_PInstance_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:33','YYYY-MM-DD HH24:MI:SS'),100,114,'N','N','D','Y','N','N','Y','2a8da82d-1548-47a6-8400-97208e1c590c','Y',0,'N','N','ADPInstance_ADVerifyMigration','C','N')
;

-- Jan 13, 2023, 9:27:33 PM CET
ALTER TABLE AD_VerifyMigration ADD AD_PInstance_ID NUMBER(10) NOT NULL
;

-- Jan 13, 2023, 9:27:33 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215752,0,'Table','Database Table information','The Database Table provides the information of the table definition',200382,'AD_Table_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:33','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','Y','N','N','Y','58f467f8-4a14-441f-849b-f30a85e4c69f','Y',0,'N','N','ADTable_ADVerifyMigration','N','N')
;

-- Jan 13, 2023, 9:27:33 PM CET
ALTER TABLE AD_VerifyMigration ADD AD_Table_ID NUMBER(10) NOT NULL
;

-- Jan 13, 2023, 9:27:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215753,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200382,'Record_ID',22,'N','N','N','N','N',0,'N',28,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:33','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','Y','N','N','Y','af6a4094-8a66-413f-b2ad-d4105df3c553','Y',0,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:34 PM CET
ALTER TABLE AD_VerifyMigration ADD Record_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:34 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215754,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200382,'SeqNo',22,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:34','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','Y','N','N','Y','c8a3590d-3940-4edc-bb61-1dc80b6df7f5','Y',0,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:34 PM CET
ALTER TABLE AD_VerifyMigration ADD SeqNo NUMBER(10) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215755,0,'Note','Note for manual entry','The Note allows for entry for additional information regarding a manual entry.',200382,'ManualNote',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:34','YYYY-MM-DD HH24:MI:SS'),100,1587,'Y','N','D','Y','N','N','Y','67ba41a1-8868-4e43-9a52-4aa2d309aabf','Y',0,'N','N','N')
;

-- Jan 13, 2023, 9:27:35 PM CET
ALTER TABLE AD_VerifyMigration ADD ManualNote VARCHAR2(4000 CHAR) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:35 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203780,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:35','YYYY-MM-DD HH24:MI:SS'),100,'ExpectedValue','Expected Value','Expected Value','D','73340fd3-303b-4c0b-8ee4-d8cf57a35294')
;

-- Jan 13, 2023, 9:27:35 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215756,0,'Expected Value',200382,'ExpectedValue',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:35','YYYY-MM-DD HH24:MI:SS'),100,203780,'N','N','D','Y','N','N','Y','65a2f60c-da8d-4356-a1b4-b0bb0d1e4d2e','Y',0,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:35 PM CET
ALTER TABLE AD_VerifyMigration ADD ExpectedValue VARCHAR2(4000 CHAR) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:36 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203781,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:35','YYYY-MM-DD HH24:MI:SS'),100,'CurrentValue','Current Value','Current Value','D','e225ce48-dddd-4a27-831d-fc0096b72b35')
;

-- Jan 13, 2023, 9:27:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215757,0,'Current Value',200382,'CurrentValue',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:36','YYYY-MM-DD HH24:MI:SS'),100,203781,'N','N','D','Y','N','N','Y','1c53cfe0-ed72-42bd-9bc9-9a97aeb5f40e','Y',0,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:36 PM CET
ALTER TABLE AD_VerifyMigration ADD CurrentValue VARCHAR2(4000 CHAR) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:36 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215758,0,'Priority','Priority of a document','The Priority indicates the importance (high, medium, low) of this document',200382,'PriorityRule',1,'N','N','N','N','N',0,'N',17,154,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:36','YYYY-MM-DD HH24:MI:SS'),100,522,'N','N','D','Y','N','N','Y','89263662-b9a1-48a8-aa6f-df4f5728f24a','Y',0,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:36 PM CET
ALTER TABLE AD_VerifyMigration ADD PriorityRule CHAR(1) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:37 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203782,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:36','YYYY-MM-DD HH24:MI:SS'),100,'IsIgnore','Ignore','Ignore','D','502bf77d-9609-4198-8885-b1c7348ca511')
;

-- Jan 13, 2023, 9:27:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215759,0,'Ignore',200382,'IsIgnore','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:37','YYYY-MM-DD HH24:MI:SS'),100,203782,'Y','N','D','Y','N','N','Y','68d2a2f2-91ce-4a47-913e-c07bab820780','Y',0,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:37 PM CET
ALTER TABLE AD_VerifyMigration ADD IsIgnore CHAR(1) DEFAULT 'N' CHECK (IsIgnore IN ('Y','N')) NOT NULL
;

-- Jan 13, 2023, 9:27:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (215760,0,'Column','Column in the table','Link to the database column of the table',200382,100,'AD_Column_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:37','YYYY-MM-DD HH24:MI:SS'),100,104,'Y','N','D','Y','N','N','Y','bbac0a29-2f4d-451a-8d92-77f0337b591f','Y',0,'N','N','ADColumn_ADVerifyMigration','N','N')
;

-- Jan 13, 2023, 9:27:38 PM CET
ALTER TABLE AD_VerifyMigration ADD AD_Column_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:38 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215761,0,'Change Log','Log of data changes','Log of data changes',200382,'AD_ChangeLog_ID',22,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:38','YYYY-MM-DD HH24:MI:SS'),100,2061,'N','N','D','Y','N','N','Y','d350a090-903b-4ed7-9092-784e326aec0f','Y',0,'N','N','D','N')
;

-- Jan 13, 2023, 9:27:38 PM CET
ALTER TABLE AD_VerifyMigration ADD AD_ChangeLog_ID NUMBER(10) DEFAULT NULL 
;

-- Jan 13, 2023, 9:27:38 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,Parent_Column_ID,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200346,'Verify Migration',200137,20,'Y',200382,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',215751,'SeqNo','N',1,'N','D','Y','N',2780,'1e6012ab-2683-4b63-b712-e9085a36a54f','B','N','Y',0)
;

-- Jan 13, 2023, 9:27:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207526,'AD_VerifyMigration_UU',200346,215749,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:38','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e058f859-968d-4919-8fa8-29bfaa9cf53c','N',1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207527,'Verify Migration','Verify Migration Helper',200346,215741,'N',22,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','91b8fc90-d0ba-4f5d-b8c4-584026385514','N',1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207528,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200346,215742,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','266bf86f-f666-434e-b783-046c73fd13ac','N',1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:40 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207529,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200346,215743,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','74e9b2bb-9a4e-4198-b336-2a76a9f46948','Y','N',4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:40 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207530,'Process Instance','Instance of the process',200346,215751,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','844b2b69-f9c3-4758-8774-0e23181c3433','Y',50,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:40 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207531,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200346,215754,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c3e97109-7738-41eb-b046-41a319d29146','Y',10,4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207532,'Table','Database Table information','The Database Table provides the information of the table definition',200346,215752,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:40','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','30040b8f-79ef-4d8e-9a4a-e5ac81d147fe','Y',60,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207533,'Priority','Priority of a document','The Priority indicates the importance (high, medium, low) of this document',200346,215758,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:41','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','336cff65-3a7b-442f-b2ad-5e849f9fea0f','Y',110,4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:41 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207534,'Column','Column in the table','Link to the database column of the table',200346,215760,'Y',22,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:41','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','96f9d9ed-360b-4d91-99ae-f730ebe7ad38','Y',70,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:42 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207535,'Change Log','Log of data changes','Log of data changes',200346,215761,'Y',22,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:41','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','c420a6d0-7baf-4207-ae81-baad17af877a','Y',90,4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:42 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207536,'Comment/Help','Comment or Hint','The Help field contains a hint, comment or help about the use of this item.',200346,215750,'Y',2000,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','a227806d-1540-4b4d-9c07-53ea2753519a','Y',20,1,5,2,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207537,'Expected Value',200346,215756,'Y',4000,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:42','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','eff1b5cc-d846-4243-90fb-62720e0cec71','Y',30,1,5,2,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207538,'Current Value',200346,215757,'Y',4000,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','f1f2b0b2-778f-4a28-8d47-20d34cb4c7f1','Y',40,1,5,2,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207539,'Note','Note for manual entry','The Note allows for entry for additional information regarding a manual entry.',200346,215755,'Y',4000,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7ea0d842-04c4-46a6-94a8-f44ee80dd532','Y',100,1,5,3,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:43 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207540,'Ignore',200346,215759,'Y',1,130,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b679e255-bbe5-4a36-afcf-e387c454c244','Y',120,2,1,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207541,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200346,215748,'Y',1,140,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:43','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b07f1120-9c0b-486f-9008-6f28307d0d0e','Y',130,3,1,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:44 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207542,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200346,215753,'Y',22,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:44','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fb495334-ed13-46dc-9264-57efbb330207','Y',80,5,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:44 PM CET
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,WhereClause,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200347,'Verify Migration Process',200137,10,'Y',282,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:44','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y','AD_PInstance.AD_Process_ID IN (SELECT AD_Process_ID FROM AD_Process WHERE AD_Process_UU=''b85e55fb-9cd1-4db8-8978-1fef6a2b92f5'') AND AD_PInstance.IsActive=''Y''','AD_PInstance.AD_Pinstance_ID Desc','N','N',0,'N','D','N','N','83130ef3-47f3-473e-812f-00248f5564ab','B','N','Y',0)
;

-- Jan 13, 2023, 9:27:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207543,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200347,2782,'N',11,0,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:44','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','0173d411-e318-405b-976a-e44cd7f7b69f','Y',60,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207544,'AD_PInstance_UU',200347,60451,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','71fb588c-9e82-4de6-95b8-9516d79f7ffe','N',1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207545,'Process Instance','Instance of the process',200347,2780,'N',14,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c1ef5b3a-2620-491d-a573-48869cf30893','N',0,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:46 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207546,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200347,8225,'N',1,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19a34643-4bb7-4214-814b-2e40fea49625','N',0,2,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:46 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207547,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',200347,211837,'N',0,0,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5a8e2836-5c46-469f-af37-fddf34dcae54','Y',160,1,1,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:47 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207548,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200347,211834,'N',0,0,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:46','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','33fd0e7f-72af-43e4-a744-46a7c129ed97','Y',140,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:47 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207549,'Language ID',200347,211868,'N',0,0,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5ae6d046-31d7-41ce-a62c-dc39fe1c4d9d','Y',150,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:47 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207550,'Report Type',200347,211830,'N',0,0,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:47','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200030,'D','e3642c32-065a-429f-815d-24565d4492c3','Y',130,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207551,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200347,8221,'Y',14,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:47','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','d22e0411-a29a-49c5-9b6f-44a3ce0229f2','Y',10,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207552,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200347,8223,'Y',14,20,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','13f8722e-3dc4-4fb1-ab91-7739da24012c','Y','Y',20,4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207553,'Created','Date this record was created','The Created field indicates the date that this record was created.',200347,2784,'Y',20,30,-1,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','38d33563-0afa-4edb-8d40-b7b2bb2635a4','Y',30,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:48 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207554,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200347,2785,'Y',20,40,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','36d590a5-6fa3-4025-ab6f-e575c602f62f','Y',40,4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207555,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200347,2781,'Y',14,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:48','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7415e08c-30af-4a07-a733-1dba0f390fcb','Y',50,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207556,'User/Contact','User within the system - Internal or Business Partner Contact','The User identifies a unique user in the system. This could be an internal user or a business partner contact',200347,5951,'Y',14,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4008b951-728a-4eb1-87fe-7a746751b610','Y',70,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:49 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207557,'Error Msg',200347,3433,'Y',60,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','316aae80-7c9c-4585-b3f9-7daf29165a0e','Y',80,1,5,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207558,'Result','Result of the action taken','The Result indicates the result of any action taken on this request.',200347,2786,'Y',11,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:49','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0937e43b-92a6-42bb-b388-82bb3a3e0d53','Y',90,1,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207559,'Session','User Session Online or Web','Online or Web Session Information',200347,215639,'Y',22,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b53f1eca-a2b6-482a-a084-bbd74f5aba4b','Y',130,4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:50 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207560,'Processing',200347,2783,'Y',1,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','86313c10-fcba-4896-b917-99e9df4cf4e8','Y',100,2,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207561,'Run as Job',200347,211199,'Y',1,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:50','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200018,'D','53d7de7a-8002-4d0e-aee1-cdb65fa1bd6d','Y',110,2,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:51 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207562,'Notification Type','Type of Notifications','Emails or Notification sent out for Request Updates, etc.',200347,211201,'Y',2,120,'Y','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',200018,'D','0f360d4a-f42c-45dd-bb7d-108365bc4697','Y',120,4,2,1,'N','N','N','N')
;

-- Jan 13, 2023, 9:27:52 PM CET
INSERT INTO AD_ZoomCondition (AD_Client_ID,AD_Org_ID,AD_Table_ID,AD_Window_ID,AD_ZoomCondition_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,SeqNo,WhereClause,Name,AD_ZoomCondition_UU,EntityType) VALUES (0,0,282,200137,200008,TO_TIMESTAMP('2023-01-13 21:27:51','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2023-01-13 21:27:51','YYYY-MM-DD HH24:MI:SS'),100,10,'AD_PInstance.AD_Process_ID IN (SELECT AD_Process_ID FROM AD_Process WHERE AD_Process_UU=''b85e55fb-9cd1-4db8-8978-1fef6a2b92f5'') AND AD_PInstance.IsActive=''Y''','Verify Migration Process','674c89cf-4382-4bc9-ab84-f33f7ad6ca8f','D')
;

-- Jan 13, 2023, 9:27:52 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Expected Value differs from Current Value.
The column {0} in record {1} was customized on {2,date,long} by {3}',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:52','YYYY-MM-DD HH24:MI:SS'),100,200816,'VM_ExpectedValueDiffersFromCurrentValue','D','238d0bee-2832-48d1-b894-73918906575a')
;

-- Jan 13, 2023, 9:27:52 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The verify migration process cannot be discarded because it has ignored records.',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:52','YYYY-MM-DD HH24:MI:SS'),100,200817,'VM_HasIgnoredRecords','D','25e5860f-52e6-486c-915a-4a56c807c728')
;

-- Jan 13, 2023, 9:27:53 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Column View does not exist in database.
The custom view column {0} was created on {1,date,long} by {2}',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:52','YYYY-MM-DD HH24:MI:SS'),100,200818,'VM_CustomViewColumnNotInDB','D','ac26a2e6-dfdf-4483-a860-27c0216e9349')
;

-- Jan 13, 2023, 9:27:53 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,AD_Process_ID,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200221,'Verify Migration Process','This process helps to verify if everything is OK after a migration and discover possible customizations lost','P',0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:53','YYYY-MM-DD HH24:MI:SS'),100,'N',200149,'Y','N','D','Y','86cc2dac-ddac-482b-8753-6b332cd99e31')
;

-- Jan 13, 2023, 9:49:37 PM CET
UPDATE AD_TREENODEMM SET SeqNo=SeqNo+1 WHERE Parent_ID=155 AND SeqNo>=17 AND AD_Tree_ID=10
;

-- Jan 13, 2023, 9:49:37 PM CET
INSERT INTO AD_TreeNodeMM (AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Parent_ID,SeqNo,AD_Tree_ID,Node_ID,AD_Client_ID,AD_TreeNodeMM_UU) VALUES (0,'Y',TO_TIMESTAMP('2023-01-13 21:49:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:49:37','YYYY-MM-DD HH24:MI:SS'),100,155,17,10,200221,0,'94005a21-bc46-45ce-9d30-58f0c41dcd7a')
;

-- Jan 13, 2023, 9:27:53 PM CET
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200222,'Verify Migration','W',200137,0,0,'Y',TO_TIMESTAMP('2023-01-13 21:27:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:27:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','c00cf540-2921-4ec5-894e-9779743b460f')
;

-- Jan 13, 2023, 9:49:37 PM CET
UPDATE AD_TREENODEMM SET SeqNo=SeqNo+1 WHERE Parent_ID=155 AND SeqNo>=18 AND AD_Tree_ID=10
;

-- Jan 13, 2023, 9:49:37 PM CET
INSERT INTO AD_TreeNodeMM (AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Parent_ID,SeqNo,AD_Tree_ID,Node_ID,AD_Client_ID,AD_TreeNodeMM_UU) VALUES (0,'Y',TO_TIMESTAMP('2023-01-13 21:49:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 21:49:37','YYYY-MM-DD HH24:MI:SS'),100,155,18,10,200222,0,'9e40b03b-12ae-4eef-97bb-4f60c0f5d7a5')
;

-- Jan 13, 2023, 9:27:53 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT ADClient_ADVerifyMigration FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 13, 2023, 9:27:53 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT ADOrg_ADVerifyMigration FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 13, 2023, 9:27:53 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT CreatedBy_ADVerifyMigration FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 13, 2023, 9:27:53 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT UpdatedBy_ADVerifyMigration FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 13, 2023, 9:27:53 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT ADPInstance_ADVerifyMigration FOREIGN KEY (AD_PInstance_ID) REFERENCES ad_pinstance(ad_pinstance_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Jan 13, 2023, 9:27:53 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT ADTable_ADVerifyMigration FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 13, 2023, 9:27:53 PM CET
ALTER TABLE AD_VerifyMigration ADD CONSTRAINT ADColumn_ADVerifyMigration FOREIGN KEY (AD_Column_ID) REFERENCES ad_column(ad_column_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jan 13, 2023, 10:22:04 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200150,0,0,'Y',TO_TIMESTAMP('2023-01-13 22:22:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-13 22:22:04','YYYY-MM-DD HH24:MI:SS'),100,'Discard this Verify Migration','Discard the current record of verify migration process','This process discards the current record of verify migration process, deleting all the associated details.  It cannot be discarded when there are records marked as Ignore.','N','DiscardThisVerifyMigration','N','org.idempiere.process.DiscardThisVerifyMigration','4','D',0,0,'N','Y','N','a137f24e-44d7-4856-99cb-110caf5d946b','P')
;

-- Jan 13, 2023, 10:22:46 PM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2023-01-13 22:22:46','YYYY-MM-DD HH24:MI:SS'),100,'DiscardThisVerifyMigration','Y',200129,'DiscardThisVerifyMigration',TO_TIMESTAMP('2023-01-13 22:22:46','YYYY-MM-DD HH24:MI:SS'),100,'N','01430873-c8d6-4969-97d1-bfb865230dc3','W',200347,200150,10,'D')
;

