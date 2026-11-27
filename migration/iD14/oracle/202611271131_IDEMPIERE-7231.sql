-- IDEMPIERE-7231 Support Charge-based posting for manual (non-material) Cost Elements (Burden, Overhead, Resource, Outside Processing)
SELECT register_migration_script('202611271131_IDEMPIERE-7231.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 27, 2026, 11:31:18 AM MYT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions,IsPartition,CreatePartition) VALUES (200452,'Manual Cost Detail','Manual Cost Element Charge Posting','M_ManualCostDetail',0,'3',0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:17','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','01a21b0e-b5cf-7abe-82fc-2e726ac16cbc','N','N','N','N','N','N','N')
;

-- Nov 27, 2026, 11:31:19 AM MYT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU,IsUUIDSeq,IsAllowSequenceGaps) VALUES ('M_ManualCostDetail',1000000,'N','N','Table M_ManualCostDetail','Y','Y',0,0,TO_TIMESTAMP('2026-11-27 11:31:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:18','YYYY-MM-DD HH24:MI:SS'),100,200541,'Y',1000000,1,200000,'01a21b0e-b893-7b48-a9b8-cd638d3538da','N','Y')
;

-- Nov 27, 2026, 11:31:32 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217678,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200452,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:32','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','01a21b0e-edd0-7a77-bacb-fa72f04d0799','N')
;

-- Nov 27, 2026, 11:31:33 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217679,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200452,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:32','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','01a21b0e-f02d-7a7d-a23e-b153a0682508','N')
;

-- Nov 27, 2026, 11:31:34 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217680,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200452,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:33','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','01a21b0e-f298-7e8a-8ac9-ec9fd5ad745a','N')
;

-- Nov 27, 2026, 11:31:34 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217681,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200452,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:34','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','01a21b0e-f4fe-779e-aa50-c5465b0bcbb7','N')
;

-- Nov 27, 2026, 11:31:35 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217682,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200452,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:34','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','01a21b0e-f761-71b0-8785-db8b036db7b1','N')
;

-- Nov 27, 2026, 11:31:36 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217683,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200452,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:35','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','01a21b0e-f9c9-77c1-aada-0db4f393f0cc','N')
;

-- Nov 27, 2026, 11:31:36 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217684,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200452,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:36','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','01a21b0e-fc2e-704c-9c08-98ef50d35ce1','N')
;

-- Nov 27, 2026, 11:31:37 AM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204136,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:36','YYYY-MM-DD HH24:MI:SS'),100,'M_ManualCostDetail_ID','Manual Cost Detail','Manual Cost Element Charge Posting','Manual Cost Detail','D','01a21b0e-fe94-7d41-aedd-6c9fde8e59c2')
;

-- Nov 27, 2026, 11:31:37 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217685,0.0,'Manual Cost Detail','Manual Cost Element Charge Posting',200452,'M_ManualCostDetail_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:37','YYYY-MM-DD HH24:MI:SS'),100,204136,'N','N','D','N','01a21b0f-015a-775f-a2cc-325321c64873','N')
;

-- Nov 27, 2026, 11:31:38 AM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204137,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:37','YYYY-MM-DD HH24:MI:SS'),100,'M_ManualCostDetail_UU','M_ManualCostDetail_UU','M_ManualCostDetail_UU','D','01a21b0f-0428-7837-9d36-2c7fce80ce07')
;

-- Nov 27, 2026, 11:31:39 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217686,0.0,'M_ManualCostDetail_UU',200452,'M_ManualCostDetail_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:38','YYYY-MM-DD HH24:MI:SS'),100,204137,'Y','N','D','N','01a21b0f-0694-77f3-81aa-015d357931a4','N')
;

-- Nov 27, 2026, 11:31:39 AM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201327,'01a21b0f-08fa-729c-b66c-52bad405f5e8',TO_TIMESTAMP('2026-11-27 11:31:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ManualCostDetail_UU_idx',TO_TIMESTAMP('2026-11-27 11:31:39','YYYY-MM-DD HH24:MI:SS'),100,200452,'Y','Y','N','N')
;

-- Nov 27, 2026, 11:31:40 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201836,'01a21b0f-0b5a-7cd3-9ef2-0a61f98c03b9',TO_TIMESTAMP('2026-11-27 11:31:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:31:39','YYYY-MM-DD HH24:MI:SS'),100,217686,201327,10)
;

-- Nov 27, 2026, 11:31:41 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217687,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200452,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:31:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:31:40','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','N','D','N','01a21b0f-0dc8-7dc4-bdd0-d8cad8414769','N')
;

-- Nov 27, 2026, 11:32:09 AM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217678
;

-- Nov 27, 2026, 11:32:09 AM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217679
;

-- Nov 27, 2026, 11:32:09 AM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217681
;

-- Nov 27, 2026, 11:32:09 AM MYT
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:32:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217683
;

-- Nov 27, 2026, 11:32:09 AM MYT
CREATE TABLE M_ManualCostDetail (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, M_ManualCostDetail_ID NUMBER(10) NOT NULL, M_ManualCostDetail_UU VARCHAR2/*UUID*/(36) DEFAULT NULL , Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT M_ManualCostDetail_Key PRIMARY KEY (M_ManualCostDetail_ID), CONSTRAINT M_ManualCostDetail_UU_idx UNIQUE (M_ManualCostDetail_UU))
;

-- Nov 27, 2026, 11:32:09 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT ADClient_MManualCostDetail FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:32:09 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT ADOrg_MManualCostDetail FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:32:09 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT CreatedBy_MManualCostDetail FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:32:09 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT UpdatedBy_MManualCostDetail FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:34:29 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217688,0,'Accounting Schema','Rules for accounting','An Accounting Schema defines the rules used in accounting such as costing method, currency and calendar',200452,'C_AcctSchema_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:34:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:34:28','YYYY-MM-DD HH24:MI:SS'),100,181,'N','N','D','N','N','N','Y','01a21b11-a036-7475-9e59-acca74f5b0c0','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:34:38 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217689,0,'Table','Database Table information','The Database Table provides the information of the table definition',200452,'AD_Table_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:34:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:34:37','YYYY-MM-DD HH24:MI:SS'),100,126,'N','N','D','N','N','N','Y','01a21b11-c146-768b-a876-c1b2a63d5ed9','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:34:46 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217690,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200452,'Record_ID',10,'N','N','Y','N','N',0,'N',200202,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:34:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:34:46','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','N','N','N','Y','01a21b11-e2e5-78fd-9687-868b355b9e6d','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:34:49 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217691,0,'Line ID','Transaction line ID (internal)','Internal link',200452,'Line_ID',10,'N','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:34:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:34:48','YYYY-MM-DD HH24:MI:SS'),100,1738,'N','N','D','N','N','N','Y','01a21b11-ec2f-7404-bada-7c4024db7f43','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:34:50 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217692,0,'Cost Element','Product Cost Element',200452,'M_CostElement_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:34:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:34:50','YYYY-MM-DD HH24:MI:SS'),100,2700,'N','N','D','N','N','N','Y','01a21b11-f2fe-73d1-834a-b5fe00760468','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:34:52 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217693,0,'Charge','Additional document charges','The Charge indicates a type of Charge (Handling, Shipping, Restocking)',200452,'C_Charge_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:34:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:34:52','YYYY-MM-DD HH24:MI:SS'),100,968,'N','N','D','N','N','N','Y','01a21b11-fa27-7953-a4de-5b19ef0fc680','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:25 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217694,0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200452,'M_Product_ID',10,'N','N','N','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:35:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:35:24','YYYY-MM-DD HH24:MI:SS'),100,454,'N','N','D','N','N','N','Y','01a21b12-7a2b-7bf3-abea-d68b896ceb05','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:27 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217695,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200452,'M_AttributeSetInstance_ID',10,'N','N','N','N','N',0,'N',35,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:35:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:35:26','YYYY-MM-DD HH24:MI:SS'),100,2019,'N','N','D','N','N','N','Y','01a21b12-82f9-7aa0-93f0-cdd67e7dff03','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:29 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217696,0,'Combination','Valid Account Combination','The Combination identifies a valid combination of element which represent a GL account.',200452,'C_ValidCombination_ID',10,'N','N','Y','N','N',0,'N',25,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:35:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:35:29','YYYY-MM-DD HH24:MI:SS'),100,222,'N','N','D','N','N','N','Y','01a21b12-8b97-7e68-a0e5-836dab9a8afa','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:32 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217697,0,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200452,'DateAcct',7,'N','N','Y','N','N',0,'N',15,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:35:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:35:31','YYYY-MM-DD HH24:MI:SS'),100,263,'N','N','D','N','N','N','Y','01a21b12-9417-7c3d-ab96-119ee3ddf114','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:34 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217698,0,'Amount','Amount','Amount',200452,'Amt',22,'N','N','Y','N','N',0,'N',12,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:35:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:35:33','YYYY-MM-DD HH24:MI:SS'),100,160,'N','N','D','N','N','N','Y','01a21b12-9c14-793b-9413-96c2b0e5e379','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:35 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217699,0,'Quantity','Quantity','The Quantity indicates the number of a specific product or item for this document.',200452,'Qty',22,'N','N','N','N','N',0,'N',29,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:35:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:35:35','YYYY-MM-DD HH24:MI:SS'),100,526,'N','N','D','N','N','N','Y','01a21b12-a2bd-7074-a0d2-f5c395df6b51','Y',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:37 AM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217700,0,'Reversal Line','Use to keep the reversal line ID for reversing costing purpose',326,'ReversalLine_ID',10,'N','N','N','N','N',0,'N',18,297,0,0,'Y',TO_TIMESTAMP('2026-11-27 11:35:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-27 11:35:37','YYYY-MM-DD HH24:MI:SS'),100,53689,'N','N','D','N','N','N','Y','01a21b12-aa38-7b46-9518-1fecd622c327','N',0,'N','N','N','N')
;

-- Nov 27, 2026, 11:35:51 AM MYT
UPDATE AD_Column SET FKConstraintType='O',Updated=TO_TIMESTAMP('2026-11-27 11:35:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217690
;

-- Nov 27, 2026, 11:36:22 AM MYT
UPDATE AD_Column SET FKConstraintName='CAcctSchema_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217688
;

-- Nov 27, 2026, 11:36:22 AM MYT
ALTER TABLE M_ManualCostDetail ADD C_AcctSchema_ID NUMBER(10) NOT NULL
;

-- Nov 27, 2026, 11:36:22 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT CAcctSchema_MManualCostDetail FOREIGN KEY (C_AcctSchema_ID) REFERENCES c_acctschema(c_acctschema_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY Created DATE
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY Updated DATE
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY IsActive CHAR(1) DEFAULT 'Y'
;

-- Nov 27, 2026, 11:36:39 AM MYT
UPDATE M_ManualCostDetail SET IsActive='Y' WHERE IsActive IS NULL
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY M_ManualCostDetail_ID NUMBER(10)
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY M_ManualCostDetail_UU VARCHAR2/*UUID*/(36) DEFAULT NULL 
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY AD_Client_ID NUMBER(10)
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY AD_Org_ID NUMBER(10)
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY CreatedBy NUMBER(10)
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY UpdatedBy NUMBER(10)
;

-- Nov 27, 2026, 11:36:39 AM MYT
UPDATE AD_Column SET FKConstraintName='ADTable_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217689
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD AD_Table_ID NUMBER(10) NOT NULL
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT ADTable_MManualCostDetail FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD Line_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2026, 11:36:39 AM MYT
UPDATE AD_Column SET FKConstraintName='MCostElement_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217692
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD M_CostElement_ID NUMBER(10) NOT NULL
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT MCostElement_MManualCostDetail FOREIGN KEY (M_CostElement_ID) REFERENCES m_costelement(m_costelement_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:36:39 AM MYT
UPDATE AD_Column SET FKConstraintName='CCharge_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217693
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD C_Charge_ID NUMBER(10) NOT NULL
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT CCharge_MManualCostDetail FOREIGN KEY (C_Charge_ID) REFERENCES c_charge(c_charge_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:36:39 AM MYT
UPDATE AD_Column SET FKConstraintName='MProduct_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217694
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD M_Product_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT MProduct_MManualCostDetail FOREIGN KEY (M_Product_ID) REFERENCES m_product(m_product_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail MODIFY C_AcctSchema_ID NUMBER(10)
;

-- Nov 27, 2026, 11:36:39 AM MYT
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217695
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD M_AttributeSetInstance_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT MAttributeSetInstance_MManualCostDetail FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:36:39 AM MYT
UPDATE AD_Column SET FKConstraintName='CValidCombination_MManualCostDetail', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217696
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD C_ValidCombination_ID NUMBER(10) NOT NULL
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD CONSTRAINT CValidCombination_MManualCostDetail FOREIGN KEY (C_ValidCombination_ID) REFERENCES c_validcombination(c_validcombination_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD DateAcct DATE NOT NULL
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD Amt NUMBER NOT NULL
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD Qty NUMBER DEFAULT NULL 
;

-- Nov 27, 2026, 11:36:39 AM MYT
ALTER TABLE M_ManualCostDetail ADD Record_ID NUMBER(10) NOT NULL
;

-- Nov 27, 2026, 11:36:56 AM MYT
UPDATE AD_Column SET FKConstraintName='ReversalLine_MProductionLine', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-11-27 11:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217700
;

-- Nov 27, 2026, 11:36:56 AM MYT
ALTER TABLE M_ProductionLine ADD ReversalLine_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 27, 2026, 11:36:56 AM MYT
ALTER TABLE M_ProductionLine ADD CONSTRAINT ReversalLine_MProductionLine FOREIGN KEY (ReversalLine_ID) REFERENCES m_productionline(m_productionline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 27, 2026, 11:40:11 AM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201328,'01a21b16-d718-7089-974b-17d1f6ae6277',TO_TIMESTAMP('2026-11-27 11:40:10','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ManualCostDetail_Record',TO_TIMESTAMP('2026-11-27 11:40:10','YYYY-MM-DD HH24:MI:SS'),100,200452,'N','N','N','N','N')
;

-- Nov 27, 2026, 11:40:12 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201837,'01a21b16-d9a7-7803-b61f-255e657323f0',TO_TIMESTAMP('2026-11-27 11:40:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:40:11','YYYY-MM-DD HH24:MI:SS'),100,217689,201327,10)
;

-- Nov 27, 2026, 11:40:12 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201838,'01a21b16-dc01-7187-873f-623ae146fae1',TO_TIMESTAMP('2026-11-27 11:40:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:40:12','YYYY-MM-DD HH24:MI:SS'),100,217690,201327,20)
;

-- Nov 27, 2026, 11:40:13 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201839,'01a21b16-de58-7392-bf15-cb0dd6e7fbcd',TO_TIMESTAMP('2026-11-27 11:40:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:40:12','YYYY-MM-DD HH24:MI:SS'),100,217688,201327,30)
;

-- Nov 27, 2026, 11:40:14 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201840,'01a21b16-e164-7f18-921e-94753c17e70a',TO_TIMESTAMP('2026-11-27 11:40:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:40:13','YYYY-MM-DD HH24:MI:SS'),100,217691,201327,40)
;

-- Nov 27, 2026, 11:40:46 AM MYT
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201329,'01a21b17-5e9f-72a4-b44d-31457a7fa838',TO_TIMESTAMP('2026-11-27 11:40:45','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','M_ManualCostDetail_DateAcct',TO_TIMESTAMP('2026-11-27 11:40:45','YYYY-MM-DD HH24:MI:SS'),100,200452,'N','N','N','N','N')
;

-- Nov 27, 2026, 11:41:10 AM MYT
DELETE FROM AD_IndexColumn WHERE AD_IndexColumn_UU='01a21b16-d9a7-7803-b61f-255e657323f0'
;

-- Nov 27, 2026, 11:41:19 AM MYT
DELETE FROM AD_IndexColumn WHERE AD_IndexColumn_UU='01a21b16-dc01-7187-873f-623ae146fae1'
;

-- Nov 27, 2026, 11:41:27 AM MYT
DELETE FROM AD_IndexColumn WHERE AD_IndexColumn_UU='01a21b16-de58-7392-bf15-cb0dd6e7fbcd'
;

-- Nov 27, 2026, 11:41:35 AM MYT
DELETE FROM AD_IndexColumn WHERE AD_IndexColumn_UU='01a21b16-e164-7f18-921e-94753c17e70a'
;

-- Nov 27, 2026, 11:41:50 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201841,'01a21b18-5a44-7a33-a373-8b53e6208789',TO_TIMESTAMP('2026-11-27 11:41:49','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:41:49','YYYY-MM-DD HH24:MI:SS'),100,217689,201328,10)
;

-- Nov 27, 2026, 11:41:52 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201842,'01a21b18-60e6-7d22-b86b-d8df2c302f9b',TO_TIMESTAMP('2026-11-27 11:41:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:41:51','YYYY-MM-DD HH24:MI:SS'),100,217690,201328,20)
;

-- Nov 27, 2026, 11:41:53 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201843,'01a21b18-6701-77d3-ab73-f82decb48ec1',TO_TIMESTAMP('2026-11-27 11:41:53','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:41:53','YYYY-MM-DD HH24:MI:SS'),100,217688,201328,30)
;

-- Nov 27, 2026, 11:41:55 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201844,'01a21b18-6c5f-7ea6-822c-561ce8fa13d0',TO_TIMESTAMP('2026-11-27 11:41:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:41:54','YYYY-MM-DD HH24:MI:SS'),100,217691,201328,40)
;

-- Nov 27, 2026, 11:41:56 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201845,'01a21b18-7270-7297-afbc-d7c07f6b989f',TO_TIMESTAMP('2026-11-27 11:41:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:41:56','YYYY-MM-DD HH24:MI:SS'),100,217678,201329,10)
;

-- Nov 27, 2026, 11:41:58 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201846,'01a21b18-789e-79c8-8195-751235d4b741',TO_TIMESTAMP('2026-11-27 11:41:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:41:57','YYYY-MM-DD HH24:MI:SS'),100,217688,201329,20)
;

-- Nov 27, 2026, 11:42:00 AM MYT
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201847,'01a21b18-7fa3-765c-bd39-0b180dfb64c1',TO_TIMESTAMP('2026-11-27 11:41:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-11-27 11:41:59','YYYY-MM-DD HH24:MI:SS'),100,217697,201329,30)
;

-- Nov 27, 2026, 11:42:06 AM MYT
CREATE INDEX M_ManualCostDetail_Record ON M_ManualCostDetail (AD_Table_ID,Record_ID,C_AcctSchema_ID,Line_ID)
;

-- Nov 27, 2026, 11:42:12 AM MYT
CREATE INDEX M_ManualCostDetail_DateAcct ON M_ManualCostDetail (AD_Client_ID,C_AcctSchema_ID,DateAcct)
;

