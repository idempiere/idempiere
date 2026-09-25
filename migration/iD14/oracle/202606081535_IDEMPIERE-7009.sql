-- IDEMPIERE-7009
SELECT register_migration_script('202606081535_IDEMPIERE-7009.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 28, 2026, 10:18:40 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200445,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)','C_SalesPipeline','3',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','N','D','Y','L','019e6daa-084f-7079-8723-d45a5a208550','N')
;

-- May 28, 2026, 10:18:40 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_SalesPipeline',1000000,'N','N','Table C_SalesPipeline','Y','Y',0,0,TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,200536,'Y',1000000,1,200000,'019e6daa-0979-7e12-b62b-019189609327')
;

-- May 28, 2026, 10:18:40 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217581,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200445,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','019e6daa-0a8f-7a9c-acf0-4a90ac4ebd7f','N')
;

-- May 28, 2026, 10:18:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217582,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200445,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:40','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','019e6daa-0ba1-7e32-a029-e5b88753a9ad','N')
;

-- May 28, 2026, 10:18:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217583,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200445,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','019e6daa-0ca6-72ac-8bbe-ca6688eb327f','N')
;

-- May 28, 2026, 10:18:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217584,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200445,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','019e6daa-0da0-75fc-80d5-3c2213e1f74a','N')
;

-- May 28, 2026, 10:18:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217585,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200445,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','019e6daa-0e99-7ed5-8cfd-de1e84318a4d','N')
;

-- May 28, 2026, 10:18:42 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217586,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200445,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:41','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','019e6daa-0f98-7a3c-aded-04c2731d0006','N')
;

-- May 28, 2026, 10:18:42 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217587,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200445,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','019e6daa-1099-7187-8772-1ed0c4d902f3','N')
;

-- May 28, 2026, 10:18:42 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (204105,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,'C_SalesPipeline_ID','Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)','Sales Pipeline','D','019e6daa-118e-76c3-8a79-6f081d17f957')
;

-- May 28, 2026, 10:18:42 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217588,0.0,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',200445,'C_SalesPipeline_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,204105,'N','N','D','N','019e6daa-12a7-7ddf-8230-8431fccfdb92','N')
;

-- May 28, 2026, 10:18:43 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204106,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:42','YYYY-MM-DD HH24:MI:SS'),10,'C_SalesPipeline_UU','C_SalesPipeline_UU','C_SalesPipeline_UU','D','019e6daa-13ab-7db5-88d1-6b7bdb946ade')
;

-- May 28, 2026, 10:18:43 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217589,0.0,'C_SalesPipeline_UU',200445,'C_SalesPipeline_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:43','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:43','YYYY-MM-DD HH24:MI:SS'),10,204106,'Y','N','D','N','019e6daa-14ae-7080-9132-6ab2e920b51d','N')
;

-- May 28, 2026, 10:18:43 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201317,'019e6daa-15a4-75c6-831a-507fb70e648c',TO_TIMESTAMP('2026-05-28 10:18:43','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','C_SalesPipeline_UU_idx',TO_TIMESTAMP('2026-05-28 10:18:43','YYYY-MM-DD HH24:MI:SS'),10,200445,'Y','Y','N','N')
;

-- May 28, 2026, 10:18:44 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201815,'019e6daa-16a3-7bee-a5fb-0fded712c6a7',TO_TIMESTAMP('2026-05-28 10:18:43','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-05-28 10:18:43','YYYY-MM-DD HH24:MI:SS'),10,217589,201317,10)
;

-- May 28, 2026, 10:18:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (217590,0.0,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200445,'Value',40,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,620,'Y','Y','D','N','019e6daa-17a7-738b-8a33-00459acd65f7',10,'N')
;

-- May 28, 2026, 10:18:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (217591,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200445,'Name',60,'N','N','Y','Y','Y','N',10,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','019e6daa-18a9-7097-b4c5-4fa6eaad7ef2',20,'N')
;

-- May 28, 2026, 10:18:44 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217592,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200445,'Description',255,'N','N','N','Y','N','N',10,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','N','D','N','019e6daa-19a5-7e1d-8564-c6b84367fcef','N')
;

-- May 28, 2026, 10:18:45 AM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200446,'Sales Pipeline Trl','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.) Trl','C_SalesPipeline_Trl','3',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:44','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','N','D','Y','L','019e6daa-1a9c-749d-beeb-b7f53ba056e1','N')
;

-- May 28, 2026, 10:18:45 AM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_SalesPipeline_Trl',1000000,'N','N','Table C_SalesPipeline_Trl','Y','Y',0,0,TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,200537,'Y',1000000,1,200000,'019e6daa-1b97-7dfb-a4cc-3d051e6a8e2f')
;

-- May 28, 2026, 10:18:45 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217593,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200446,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,102,'N','N','1=1','D','N','019e6daa-1c8a-73cf-95f3-5626eaa94b37','N')
;

-- May 28, 2026, 10:18:45 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217594,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200446,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,113,'N','N','D','N','019e6daa-1d7b-7e0f-b033-6cbc22f2e5a2','N')
;

-- May 28, 2026, 10:18:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217595,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200446,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:45','YYYY-MM-DD HH24:MI:SS'),10,245,'N','N','D','N','019e6daa-1e70-71df-a615-9ffba1e26324','N')
;

-- May 28, 2026, 10:18:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217596,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200446,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,246,'N','N','D','N','019e6daa-1f62-74bc-96dd-584fde3743ac','N')
;

-- May 28, 2026, 10:18:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217597,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200446,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,607,'N','N','D','N','019e6daa-205e-7166-a507-eba1fba57a1e','N')
;

-- May 28, 2026, 10:18:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217598,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200446,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,608,'N','N','D','N','019e6daa-2151-7e07-93a4-0024f6d7e613','N')
;

-- May 28, 2026, 10:18:46 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217599,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200446,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,348,'Y','N','D','N','019e6daa-224d-783d-abfb-da128f296afc','N')
;

-- May 28, 2026, 10:18:47 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton,FKConstraintType) VALUES (217600,0.0,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',200446,'C_SalesPipeline_ID',10,'N','Y','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:46','YYYY-MM-DD HH24:MI:SS'),10,204105,'N','N','D','N','019e6daa-234f-7881-ac8d-f144ef76464a','N','C')
;

-- May 28, 2026, 10:18:47 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204107,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,'C_SalesPipeline_Trl_UU','C_SalesPipeline_Trl_UU','C_SalesPipeline_Trl_UU','D','019e6daa-2447-73c9-9bc8-25c4d1924805')
;

-- May 28, 2026, 10:18:47 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217601,0.0,'C_SalesPipeline_Trl_UU',200446,'C_SalesPipeline_Trl_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,204107,'Y','N','D','N','019e6daa-253e-79b6-ab1e-8239fc145034','N')
;

-- May 28, 2026, 10:18:47 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201318,'019e6daa-2639-735b-93aa-965e71d04dc6',TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','C_SalesPipeline_Trl_UU_idx',TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,200446,'Y','Y','N','N')
;

-- May 28, 2026, 10:18:48 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201816,'019e6daa-2728-7a9d-90e0-0256b0d7f298',TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-05-28 10:18:47','YYYY-MM-DD HH24:MI:SS'),10,217601,201318,10)
;

-- May 28, 2026, 10:18:48 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217602,0.0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200446,'AD_Language',6,'N','Y','Y','N','N','N',18,106,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,109,'N','N','D','N','019e6daa-2821-7824-ab60-602a2422edab','N')
;

-- May 28, 2026, 10:18:48 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217603,0.0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200446,'IsTranslated','N',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,420,'Y','N','D','N','019e6daa-2913-7b1d-94e6-32f902cb85e9','N')
;

-- May 28, 2026, 10:18:48 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (217604,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200446,'Name',60,'N','N','Y','N','Y','N',10,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,469,'Y','Y','D','N','019e6daa-2a0d-7302-908c-6bdd15774811',10,'N')
;

-- May 28, 2026, 10:18:49 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217605,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200446,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:18:48','YYYY-MM-DD HH24:MI:SS'),10,275,'Y','N','D','N','019e6daa-2b07-7738-8c21-bd583ce9d53f','N')
;

-- May 28, 2026, 10:18:49 AM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201319,'019e6daa-2c03-7b80-a2d9-53752eb6834c',TO_TIMESTAMP('2026-05-28 10:18:49','YYYY-MM-DD HH24:MI:SS'),10,'D','Y','C_SalesPipeline_Trl_pkey',TO_TIMESTAMP('2026-05-28 10:18:49','YYYY-MM-DD HH24:MI:SS'),10,200446,'Y','Y','N','Y')
;

-- May 28, 2026, 10:18:49 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201817,'019e6daa-2d04-7562-ac2a-ed3a18d40549',TO_TIMESTAMP('2026-05-28 10:18:49','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-05-28 10:18:49','YYYY-MM-DD HH24:MI:SS'),10,217602,201319,10)
;

-- May 28, 2026, 10:18:49 AM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201818,'019e6daa-2df1-7863-aafd-07d6941c18ce',TO_TIMESTAMP('2026-05-28 10:18:49','YYYY-MM-DD HH24:MI:SS'),10,'D','Y',TO_TIMESTAMP('2026-05-28 10:18:49','YYYY-MM-DD HH24:MI:SS'),10,217600,201319,20)
;

-- May 28, 2026, 10:19:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CSalesPipeline', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217581
;

-- May 28, 2026, 10:19:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CSalesPipeline', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217582
;

-- May 28, 2026, 10:19:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CSalesPipeline', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217584
;

-- May 28, 2026, 10:19:31 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CSalesPipeline', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217586
;

-- May 28, 2026, 10:19:31 AM CEST
CREATE TABLE C_SalesPipeline (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_SalesPipeline_ID NUMBER(10) NOT NULL, C_SalesPipeline_UU VARCHAR2/*UUID*/(36) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, Value VARCHAR2(40 CHAR) DEFAULT NULL , CONSTRAINT C_SalesPipeline_Key PRIMARY KEY (C_SalesPipeline_ID), CONSTRAINT C_SalesPipeline_UU_idx UNIQUE (C_SalesPipeline_UU))
;

-- May 28, 2026, 10:19:31 AM CEST
ALTER TABLE C_SalesPipeline ADD CONSTRAINT ADClient_CSalesPipeline FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:31 AM CEST
ALTER TABLE C_SalesPipeline ADD CONSTRAINT ADOrg_CSalesPipeline FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:31 AM CEST
ALTER TABLE C_SalesPipeline ADD CONSTRAINT CreatedBy_CSalesPipeline FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:31 AM CEST
ALTER TABLE C_SalesPipeline ADD CONSTRAINT UpdatedBy_CSalesPipeline FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:37 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CSalesPipelineTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217593
;

-- May 28, 2026, 10:19:37 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADLanguage_CSalesPipelineTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217602
;

-- May 28, 2026, 10:19:37 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CSalesPipelineTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217594
;

-- May 28, 2026, 10:19:37 AM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='CSalesPipeline_CSalesPipelineTrl', FKConstraintType='C',Updated=TO_TIMESTAMP('2026-05-28 10:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217600
;

-- May 28, 2026, 10:19:37 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CSalesPipelineTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217596
;

-- May 28, 2026, 10:19:37 AM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CSalesPipelineTrl', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:19:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217598
;

-- May 28, 2026, 10:19:37 AM CEST
CREATE TABLE C_SalesPipeline_Trl (AD_Client_ID NUMBER(10) NOT NULL, AD_Language VARCHAR2(6 CHAR) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_SalesPipeline_ID NUMBER(10) NOT NULL, C_SalesPipeline_Trl_UU VARCHAR2/*UUID*/(36) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, Description VARCHAR2(255 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsTranslated CHAR(1) DEFAULT 'N' CHECK (IsTranslated IN ('Y','N')) NOT NULL, Name VARCHAR2(60 CHAR) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT C_SalesPipeline_Trl_UU_idx UNIQUE (C_SalesPipeline_Trl_UU))
;

-- May 28, 2026, 10:19:37 AM CEST
ALTER TABLE C_SalesPipeline_Trl ADD CONSTRAINT ADClient_CSalesPipelineTrl FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:37 AM CEST
ALTER TABLE C_SalesPipeline_Trl ADD CONSTRAINT ADLanguage_CSalesPipelineTrl FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:37 AM CEST
ALTER TABLE C_SalesPipeline_Trl ADD CONSTRAINT ADOrg_CSalesPipelineTrl FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:37 AM CEST
ALTER TABLE C_SalesPipeline_Trl ADD CONSTRAINT CSalesPipeline_CSalesPipelineTrl FOREIGN KEY (C_SalesPipeline_ID) REFERENCES c_salespipeline(c_salespipeline_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:37 AM CEST
ALTER TABLE C_SalesPipeline_Trl ADD CONSTRAINT CreatedBy_CSalesPipelineTrl FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:37 AM CEST
ALTER TABLE C_SalesPipeline_Trl ADD CONSTRAINT UpdatedBy_CSalesPipelineTrl FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:19:46 AM CEST
ALTER TABLE C_SalesPipeline_Trl ADD CONSTRAINT C_SalesPipeline_Trl_pkey PRIMARY KEY (AD_Language,C_SalesPipeline_ID)
;

-- May 28, 2026, 10:23:01 AM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,IsBetaFunctionality,AD_Window_UU) VALUES (200164,'Sales Pipeline',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:00','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:00','YYYY-MM-DD HH24:MI:SS'),10,'M','N','D','Y','N','N','019e6dae-0330-7c11-8a0e-bbae7f57e4fc')
;

-- May 28, 2026, 10:23:01 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200424,'Sales Pipeline',200164,10,'Y',200445,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:01','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:01','YYYY-MM-DD HH24:MI:SS'),10,'N','N','N','C_SalesPipeline.Value','N',0,'N','D','Y','N','019e6dae-0478-7333-b495-a62f90f212a4')
;

-- May 28, 2026, 10:23:01 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209187,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200424,217581,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:01','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:01','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-059b-77d5-929c-92a6b703ab4c','N',2)
;

-- May 28, 2026, 10:23:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209188,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200424,217582,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:01','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:01','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-06ab-7dfb-9cfa-4314c200bb58','Y','Y',10,4,2)
;

-- May 28, 2026, 10:23:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209189,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200424,217590,'Y',40,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-0825-7af5-bb24-4c7274850615','Y',20,2)
;

-- May 28, 2026, 10:23:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209190,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200424,217591,'Y',60,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-091e-7260-9418-501294c73c69','Y',30,5)
;

-- May 28, 2026, 10:23:02 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209191,'Description','Optional short description of the record','A description is limited to 255 characters.',200424,217592,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-0a27-7545-b9f9-12fe5ad74de9','Y',40,5)
;

-- May 28, 2026, 10:23:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209192,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',200424,217588,'N',22,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:02','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-0b25-7f62-84ab-dabdb360d50e','N',2)
;

-- May 28, 2026, 10:23:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209193,'C_SalesPipeline_UU',200424,217589,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:03','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:03','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-0c1d-795d-a201-eb82a72bd9ef','N',2)
;

-- May 28, 2026, 10:23:03 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209194,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200424,217587,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:03','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:03','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-0d0a-7961-9194-60d887d8ac66','Y',50,2,2)
;

-- May 28, 2026, 10:23:03 AM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,AD_Menu_UU) VALUES (200254,'Sales Pipeline','W',200164,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:03','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:03','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N','D','019e6dae-0dfe-7e84-9205-0f282f08b6f4')
;

-- May 28, 2026, 10:23:03 AM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 10, getDate(), 10,t.AD_Tree_ID, 200254, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200254)
;

-- May 28, 2026, 10:23:03 AM CEST
UPDATE AD_Table SET AD_Window_ID=200164,Updated=TO_TIMESTAMP('2026-05-28 10:23:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200445
;

-- May 28, 2026, 10:23:40 AM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200425,'Sales Pipeline Trl',200164,20,'Y',200446,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','N',217600,'C_SalesPipeline_Trl.AD_Language','N',1,'N','D','N','N','019e6dae-9c53-781d-ae16-31ac5ca42962')
;

-- May 28, 2026, 10:23:40 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209195,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200425,217593,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-9d5d-70fd-8108-a55748a111d4','N',2)
;

-- May 28, 2026, 10:23:40 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209196,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200425,217594,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-9e60-7c24-83fb-46b406b1cce4','Y','Y',10,4,2)
;

-- May 28, 2026, 10:23:41 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209197,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',200425,217600,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:40','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-9f5c-7f26-a858-0c5c40b1add8','Y',20,2)
;

-- May 28, 2026, 10:23:41 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209198,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200425,217602,'Y',6,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-a059-74e3-86e1-f5c0a0d3646c','Y',30,2)
;

-- May 28, 2026, 10:23:41 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209199,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200425,217604,'Y',60,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-a147-7ac5-8067-3937ebeff8ad','Y',40,5)
;

-- May 28, 2026, 10:23:41 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209200,'Description','Optional short description of the record','A description is limited to 255 characters.',200425,217605,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-a240-7c64-abe2-22c56d4b422f','Y',50,5)
;

-- May 28, 2026, 10:23:42 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209201,'C_SalesPipeline_Trl_UU',200425,217601,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:41','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-a32f-7751-b068-09687653f85a','N',2)
;

-- May 28, 2026, 10:23:42 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209202,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200425,217603,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:42','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-a41f-73da-b85b-0f8dce94faff','Y',60,2,2)
;

-- May 28, 2026, 10:23:42 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209203,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200425,217599,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:23:42','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:23:42','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dae-a516-70df-86ef-9ecaa3455d2f','Y',70,2,2)
;

-- May 28, 2026, 10:23:42 AM CEST
UPDATE AD_Table SET AD_Window_ID=200164,Updated=TO_TIMESTAMP('2026-05-28 10:23:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Table_ID=200446
;

-- May 28, 2026, 10:24:15 AM CEST
UPDATE AD_Tab SET Name='Translation',Updated=TO_TIMESTAMP('2026-05-28 10:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tab_ID=200425
;

-- May 28, 2026, 10:26:12 AM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU,ShowInactive) VALUES (200287,'C_SalesStage - for C_Opportunity','T',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:26:12','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:26:12','YYYY-MM-DD HH24:MI:SS'),10,'D','N','019e6db0-ee60-75bb-8e2f-7f49158da6f6','N')
;

-- May 28, 2026, 10:26:47 AM CEST
INSERT INTO AD_Ref_Table (AD_Reference_ID,AD_Table_ID,AD_Key,AD_Display,WhereClause,OrderByClause,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsValueDisplayed,EntityType,AD_Ref_Table_UU,IsDisplayIdentifier) VALUES (200287,53338,62154,62154,'C_SalesStage.IsActive=''Y''','(
    SELECT sps.SeqNo
    FROM C_SalesPipelineStage sps
    WHERE sps.C_SalesStage_ID = C_SalesStage.C_SalesStage_ID
    AND sps.C_SalesPipeline_ID = @C_SalesPipeline_ID:0@
)',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:26:47','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:26:47','YYYY-MM-DD HH24:MI:SS'),10,'N','D','019e6db1-7706-7f83-b8cc-5b73e3b58de4','N')
;

-- May 28, 2026, 10:27:05 AM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200209,'C_SalesStage for Opportunity','S','EXISTS (
    SELECT 1
    FROM C_SalesPipelineStage sps
    WHERE sps.C_SalesPipeline_ID = @C_SalesPipeline_ID:0@
    AND sps.C_SalesStage_ID = C_SalesStage.C_SalesStage_ID
)',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:27:04','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:27:04','YYYY-MM-DD HH24:MI:SS'),10,'D','019e6db1-bc58-7448-890a-4bcc062536e8')
;

-- May 28, 2026, 10:28:02 AM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200209, AD_Reference_Value_ID=200287,Updated=TO_TIMESTAMP('2026-05-28 10:28:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=62166
;

-- May 28, 2026, 10:45:14 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217619,0,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',53337,'C_SalesPipeline_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-05-28 10:45:13','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:45:13','YYYY-MM-DD HH24:MI:SS'),10,204105,'Y','N','D','N','N','N','Y','019e6dc2-5a65-782b-bedb-db0b7b709cf8','Y',0,'N','N','N','N','N')
;

-- May 28, 2026, 10:45:15 AM CEST
UPDATE AD_Column SET FKConstraintName='CSalesPipeline_COpportunity', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-05-28 10:45:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217619
;

-- May 28, 2026, 10:45:15 AM CEST
ALTER TABLE C_Opportunity ADD C_SalesPipeline_ID NUMBER(10) DEFAULT NULL 
;

-- May 28, 2026, 10:45:15 AM CEST
ALTER TABLE C_Opportunity ADD CONSTRAINT CSalesPipeline_COpportunity FOREIGN KEY (C_SalesPipeline_ID) REFERENCES c_salespipeline(c_salespipeline_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 28, 2026, 10:45:24 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209213,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',53431,217619,'Y',22,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 10:45:24','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 10:45:24','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6dc2-8434-76f2-b325-c2e8e3a53501','Y',190,2)
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209213
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62167
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62183
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62168
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62181
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62182
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62179
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62176
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62177
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62372
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62173
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62174
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62171
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62371
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62170
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=62172
;

-- May 28, 2026, 10:45:35 AM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-05-28 10:45:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=204756
;

-- May 28, 2026, 11:05:28 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=14,Updated=TO_TIMESTAMP('2026-05-28 11:05:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200233
;

-- May 28, 2026, 11:05:28 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=15,Updated=TO_TIMESTAMP('2026-05-28 11:05:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200232
;

-- May 28, 2026, 11:05:28 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=53363, SeqNo=2,Updated=TO_TIMESTAMP('2026-05-28 11:05:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=200254
;

-- May 28, 2026, 11:05:28 AM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=53363, SeqNo=6,Updated=TO_TIMESTAMP('2026-05-28 11:05:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Tree_ID=10 AND Node_ID=53360
;

-- May 28, 2026, 1:28:21 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217620,0,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200445,'IsDefault','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2026-05-28 13:28:21','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 13:28:21','YYYY-MM-DD HH24:MI:SS'),10,1103,'Y','N','D','N','N','N','Y','019e6e57-b172-765d-86da-b0d11fa1eb77','Y',0,'N','N','N','N')
;

-- May 28, 2026, 1:28:22 PM CEST
ALTER TABLE C_SalesPipeline ADD IsDefault CHAR(1) DEFAULT 'N' CHECK (IsDefault IN ('Y','N')) NOT NULL
;

-- May 28, 2026, 1:28:31 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209214,'Default','Default value','The Default Checkbox indicates if this record will be used as a default value.',200424,217620,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-05-28 13:28:31','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2026-05-28 13:28:31','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','019e6e57-da86-7a5b-964f-ae70c6e65e61','Y',60,2,2)
;

-- May 28, 2026, 1:28:38 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-05-28 13:28:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209193
;

-- May 28, 2026, 1:28:38 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-05-28 13:28:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=209192
;

-- Jun 8, 2026, 2:19:18 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200448,'Sales Pipeline / Sales Stage','Link between Sales Pipeline and Sales Stages','C_SalesPipelineStage','3',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','019ea72c-4b00-78ad-b956-739d619a665a','N')
;

-- Jun 8, 2026, 2:19:18 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('C_SalesPipelineStage',1000000,'N','N','Table C_SalesPipelineStage','Y','Y',0,0,TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,200539,'Y',1000000,1,200000,'019ea72c-4c00-7dfc-84e1-54151dc2f5ea')
;

-- Jun 8, 2026, 2:19:18 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217621,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200448,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','019ea72c-4d02-7eea-8aa4-3cc26fb9be2d','N')
;

-- Jun 8, 2026, 2:19:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217622,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200448,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:18','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','019ea72c-4e0f-734b-b904-06aabfc6fc38','N')
;

-- Jun 8, 2026, 2:19:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217623,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200448,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','019ea72c-4f0a-7cd2-b7a5-3aee140538df','N')
;

-- Jun 8, 2026, 2:19:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217624,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200448,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','019ea72c-5009-7466-9d49-d363a2f826ab','N')
;

-- Jun 8, 2026, 2:19:19 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217625,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200448,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','019ea72c-5105-7847-b595-f2cd0cd0e506','N')
;

-- Jun 8, 2026, 2:19:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217626,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200448,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:19','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','019ea72c-5201-7c2f-acff-e452fbe525b1','N')
;

-- Jun 8, 2026, 2:19:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217627,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200448,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','019ea72c-530a-7b5d-9ba4-320e0614a465','N')
;

-- Jun 8, 2026, 2:19:20 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (204110,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,'C_SalesPipelineStage_UU','C_SalesPipelineStage_UU','C_SalesPipelineStage_UU','D','019ea72c-5403-7d0b-8b19-ff453bbce52d')
;

-- Jun 8, 2026, 2:19:20 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (217628,0.0,'C_SalesPipelineStage_UU',200448,'C_SalesPipelineStage_UU',36,'N','N','N','N','N','N',200231,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,204110,'Y','N','D','N','019ea72c-5511-77d4-9dda-7d1902d7bbb8','N')
;

-- Jun 8, 2026, 2:19:21 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201322,'019ea72c-5601-7e9f-86ff-5d977d3836c2',TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SalesPipelineStage_UU_idx',TO_TIMESTAMP('2026-06-08 14:19:20','YYYY-MM-DD HH24:MI:SS'),100,200448,'Y','Y','N','Y')
;

-- Jun 8, 2026, 2:19:21 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201822,'019ea72c-5706-7db6-993d-ec7b0a5f69e3',TO_TIMESTAMP('2026-06-08 14:19:21','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-08 14:19:21','YYYY-MM-DD HH24:MI:SS'),100,217628,201322,10)
;

-- Jun 8, 2026, 2:19:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217629,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200448,'SeqNo','@SQL=SELECT NVL(MAX(SeqNo), 0) + 10 AS DefaultValue FROM C_SalesPipelineStage WHERE C_SalesPipeline_ID =@C_SalesPipeline_ID@',22,'N','N','Y','N','N',0,'N',11,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:19:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:19:57','YYYY-MM-DD HH24:MI:SS'),100,566,'Y','N','D','N','N','N','Y','019ea72c-e2e1-7a28-bbdf-81e3d9e68cfd','N',0,'N','N','N','N')
;

-- Jun 8, 2026, 2:20:06 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217630,0,'Probability',200448,'Probability',10,'N','N','Y','N','N',0,'N',22,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:20:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:20:06','YYYY-MM-DD HH24:MI:SS'),100,54396,'Y','N','D','N','N','N','Y','019ea72d-0651-7aed-ac38-aa28080f0d4e','Y',0,'N','N','N','N')
;

-- Jun 8, 2026, 2:20:07 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADClient_CSalesPipelineStage', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-06-08 14:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217621
;

-- Jun 8, 2026, 2:20:07 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='ADOrg_CSalesPipelineStage', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-06-08 14:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217622
;

-- Jun 8, 2026, 2:20:07 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='CreatedBy_CSalesPipelineStage', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-06-08 14:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217624
;

-- Jun 8, 2026, 2:20:07 PM CEST
UPDATE AD_Column SET IsAllowCopy='N', FKConstraintName='UpdatedBy_CSalesPipelineStage', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-06-08 14:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217626
;

-- Jun 8, 2026, 2:20:07 PM CEST
CREATE TABLE C_SalesPipelineStage (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, C_SalesPipelineStage_UU VARCHAR2/*UUID*/(36) DEFAULT NULL , Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, Probability NUMBER NOT NULL, SeqNo NUMBER(10) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT C_SalesPipelineStage_UU_idx UNIQUE (C_SalesPipelineStage_UU))
;

-- Jun 8, 2026, 2:20:07 PM CEST
ALTER TABLE C_SalesPipelineStage ADD CONSTRAINT ADClient_CSalesPipelineStage FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 8, 2026, 2:20:07 PM CEST
ALTER TABLE C_SalesPipelineStage ADD CONSTRAINT ADOrg_CSalesPipelineStage FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 8, 2026, 2:20:07 PM CEST
ALTER TABLE C_SalesPipelineStage ADD CONSTRAINT CreatedBy_CSalesPipelineStage FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 8, 2026, 2:20:07 PM CEST
ALTER TABLE C_SalesPipelineStage ADD CONSTRAINT UpdatedBy_CSalesPipelineStage FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 8, 2026, 2:20:55 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,IsKey) VALUES (0,0,201323,'019ea72d-c67f-7916-aa38-f100f221a124',TO_TIMESTAMP('2026-06-08 14:20:55','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','C_SalesPipelineStage_Unique',TO_TIMESTAMP('2026-06-08 14:20:55','YYYY-MM-DD HH24:MI:SS'),100,200448,'N','Y','N','Y')
;

-- Jun 8, 2026, 2:21:22 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml,IsPartitionKey) VALUES (217631,0,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',200448,'C_SalesPipeline_ID',22,'N','Y','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:21:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:21:22','YYYY-MM-DD HH24:MI:SS'),100,204105,'N','N','D','N','N','N','Y','019ea72e-3192-759a-b64f-ce20845179cb','N',0,'N','N','N','N','N')
;

-- Jun 8, 2026, 2:21:33 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217632,0,'Sales Stage','Stages of the sales process','Define what stages your sales process will move through',200448,'C_SalesStage_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:21:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:21:33','YYYY-MM-DD HH24:MI:SS'),100,55289,'Y','N','D','N','N','N','Y','019ea72e-5c11-7698-a1c8-c8375aa50835','Y',0,'N','N','N','N')
;

-- Jun 8, 2026, 2:21:36 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2026-06-08 14:21:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217632
;

-- Jun 8, 2026, 2:21:37 PM CEST
UPDATE AD_Column SET FKConstraintName='CSalesStage_CSalesPipelineStage', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-06-08 14:21:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217632
;

-- Jun 8, 2026, 2:21:37 PM CEST
ALTER TABLE C_SalesPipelineStage ADD C_SalesStage_ID NUMBER(10) NOT NULL
;

-- Jun 8, 2026, 2:21:37 PM CEST
ALTER TABLE C_SalesPipelineStage ADD CONSTRAINT CSalesStage_CSalesPipelineStage FOREIGN KEY (C_SalesStage_ID) REFERENCES c_salesstage(c_salesstage_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 8, 2026, 2:21:37 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='CSalesPipeline_CSalesPipelineStage', FKConstraintType='N',Updated=TO_TIMESTAMP('2026-06-08 14:21:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=217631
;

-- Jun 8, 2026, 2:21:37 PM CEST
ALTER TABLE C_SalesPipelineStage ADD C_SalesPipeline_ID NUMBER(10) NOT NULL
;

-- Jun 8, 2026, 2:21:37 PM CEST
ALTER TABLE C_SalesPipelineStage ADD CONSTRAINT CSalesPipeline_CSalesPipelineStage FOREIGN KEY (C_SalesPipeline_ID) REFERENCES c_salespipeline(c_salespipeline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jun 8, 2026, 2:21:49 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201823,'019ea72e-97b7-750e-bf92-8a374892b043',TO_TIMESTAMP('2026-06-08 14:21:48','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-08 14:21:48','YYYY-MM-DD HH24:MI:SS'),100,217631,201323,10)
;

-- Jun 8, 2026, 2:21:51 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201824,'019ea72e-a257-7c08-bc82-34b52226cc2c',TO_TIMESTAMP('2026-06-08 14:21:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2026-06-08 14:21:51','YYYY-MM-DD HH24:MI:SS'),100,217632,201323,20)
;

-- Jun 8, 2026, 2:21:55 PM CEST
CREATE UNIQUE INDEX C_SalesPipelineStage_Unique ON C_SalesPipelineStage (C_SalesPipeline_ID,C_SalesStage_ID)
;

-- Jun 8, 2026, 2:22:11 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsTranslationTab,IsReadOnly,AD_Column_ID,OrderByClause,Processing,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU) VALUES (200427,'Sales Pipeline / Sales Stage',200164,30,'Y',200448,0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N',217631,'C_SalesPipelineStage.Created DESC','N',1,'N','D','Y','N','019ea72e-ed67-7f98-9565-bca124bd2287')
;

-- Jun 8, 2026, 2:22:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209215,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200427,217621,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-ee9d-76d3-a9f7-a01a441e2df4','N',2)
;

-- Jun 8, 2026, 2:22:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209216,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200427,217622,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-efb1-7c66-b00c-bb5853f2bb17','Y','Y',10,4,2)
;

-- Jun 8, 2026, 2:22:11 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209217,'Sales Pipeline','Defines a sales pipeline (e.g. "Standard Sales", "Complex Project", etc.)',200427,217631,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-f0b2-7de1-a575-e7f68fa8cbe9','Y',20,2)
;

-- Jun 8, 2026, 2:22:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (209218,'C_SalesPipelineStage_UU',200427,217628,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:11','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-f1ba-7dcc-9de4-26323150d3a1','N',2)
;

-- Jun 8, 2026, 2:22:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209219,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200427,217629,'Y',22,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-f2ca-7aae-a015-d7f3d636b727','Y',30,2)
;

-- Jun 8, 2026, 2:22:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209220,'Probability',200427,217630,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-f3bc-7233-bb37-477fed70cd31','Y',40,2)
;

-- Jun 8, 2026, 2:22:12 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (209221,'Sales Stage','Stages of the sales process','Define what stages your sales process will move through',200427,217632,'Y',22,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-f4b5-77dd-bd22-0d72a56658e9','Y',50,2)
;

-- Jun 8, 2026, 2:22:13 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (209222,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200427,217627,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:22:12','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','019ea72e-f5ae-7c22-9d92-6b836638f266','Y',60,2,2)
;

-- Jun 8, 2026, 2:22:13 PM CEST
UPDATE AD_Table SET AD_Window_ID=200164,Updated=TO_TIMESTAMP('2026-06-08 14:22:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200448
;

-- Jun 8, 2026, 2:23:07 PM CEST
UPDATE AD_Tab SET OrderByClause='C_SalesPipelineStage.SeqNo, C_SalesPipelineStage.Created DESC',Updated=TO_TIMESTAMP('2026-06-08 14:23:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200427
;

-- Jun 8, 2026, 2:23:20 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=40,Updated=TO_TIMESTAMP('2026-06-08 14:23:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209221
;

-- Jun 8, 2026, 2:23:20 PM CEST
UPDATE AD_Field SET IsDisplayedGrid='Y', SeqNoGrid=50,Updated=TO_TIMESTAMP('2026-06-08 14:23:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209220
;

-- Jun 8, 2026, 2:23:41 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2026-06-08 14:23:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209219
;

-- Jun 8, 2026, 2:23:41 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, XPosition=1,Updated=TO_TIMESTAMP('2026-06-08 14:23:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209221
;

-- Jun 8, 2026, 2:23:41 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=4,Updated=TO_TIMESTAMP('2026-06-08 14:23:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209220
;

-- Jun 8, 2026, 2:23:41 PM CEST
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2026-06-08 14:23:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209218
;

-- Jun 8, 2026, 2:30:50 PM CEST
-- Insert Default Pipeline for GW
INSERT INTO C_SalesPipeline (AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,IsActive,C_SalesPipeline_ID,C_SalesPipeline_UU,Value,Name,IsDefault) VALUES (11,0,TO_TIMESTAMP('2026-06-08 14:30:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-06-08 14:30:50','YYYY-MM-DD HH24:MI:SS'),100,'Y',200000,'019ea736-db6b-7afb-9d17-c19473382160','Default','Default','Y')
;




DECLARE
    v_sequenceSP_ID NUMBER;
    v_salesPipeline_ID NUMBER;
    v_pipeline_id NUMBER;
    v_seqno NUMBER;

BEGIN

    -- Get sequence
    SELECT AD_Sequence_ID INTO v_sequenceSP_ID FROM AD_Sequence WHERE Name = 'C_SalesPipeline' AND IsActive = 'Y' AND IsTableID = 'Y' AND IsAutoSequence = 'Y' AND AD_Client_ID = 0;

    -- Loop clients
    FOR v_client IN (
        SELECT AD_Client_ID
        FROM AD_Client
        WHERE AD_Client_ID > 0
        AND AD_Client_ID NOT IN (SELECT AD_Client_ID FROM C_SalesPipeline WHERE IsDefault = 'Y')
    )
    LOOP

		AD_Sequence_Next ('C_SalesPipeline', v_client.AD_Client_ID, v_salesPipeline_ID);

        -- Insert Pipeline
        INSERT INTO C_SalesPipeline (
            C_SalesPipeline_ID,
            C_SalesPipeline_UU,
            AD_Client_ID,
            AD_Org_ID,
            IsActive,
            Created,
            CreatedBy,
            Updated,
            UpdatedBy,
            Name,
            Value,
            IsDefault
        )
        VALUES (
            v_salesPipeline_ID,
            Generate_UUID(),
            v_client.AD_Client_ID,
            0,
            'Y',
            SYSDATE,
            100,
            SYSDATE,
            100,
            'Default',
            'Default',
            'Y'
        )
        RETURNING C_SalesPipeline_ID INTO v_pipeline_id;

        v_seqno := 10;

        -- Loop stages
        FOR rec IN (
            SELECT C_SalesStage_ID, Probability
            FROM C_SalesStage
            WHERE IsActive = 'Y'
            ORDER BY Value
        )
        LOOP

            INSERT INTO C_SalesPipelineStage (
                C_SalesPipelineStage_UU,
                AD_Client_ID,
                AD_Org_ID,
                IsActive,
                Created,
                CreatedBy,
                Updated,
                UpdatedBy,
                C_SalesPipeline_ID,
                C_SalesStage_ID,
                SeqNo,
                Probability
            )
            VALUES (
                Generate_UUID(),
                v_client.AD_Client_ID,
                0,
                'Y',
                SYSDATE,
                100,
                SYSDATE,
                100,
                v_pipeline_id,
                rec.C_SalesStage_ID,
                v_seqno,
                rec.Probability
            );

            v_seqno := v_seqno + 10;

        END LOOP;

		UPDATE C_Opportunity SET C_SalesPipeline_ID = v_pipeline_id WHERE AD_Client_ID = v_client.AD_Client_ID;

    END LOOP;

END;
/



-- May 28, 2026, 2:01:48 PM CEST
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2026-05-28 14:01:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217619
;

-- May 28, 2026, 2:01:50 PM CEST
ALTER TABLE C_Opportunity MODIFY C_SalesPipeline_ID NUMBER(10)
;

-- May 28, 2026, 2:01:50 PM CEST
ALTER TABLE C_Opportunity MODIFY C_SalesPipeline_ID NOT NULL
;

-- Jun 8, 2026, 3:33:21 PM CEST
UPDATE AD_Column SET DefaultValue='0',Updated=TO_TIMESTAMP('2026-06-08 15:33:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=62162
;

-- Jun 8, 2026, 3:33:22 PM CEST
ALTER TABLE C_SalesStage MODIFY Probability NUMBER DEFAULT 0
;

-- Jun 8, 2026, 3:33:22 PM CEST
UPDATE C_SalesStage SET Probability=0 WHERE Probability IS NULL
;

-- Jun 8, 2026, 3:33:25 PM CEST
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2026-06-08 15:33:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=62162
;

-- Jun 10, 2026, 6:45:52 AM CEST
UPDATE AD_Column SET IsParent='N',Updated=TO_TIMESTAMP('2026-06-10 06:45:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Column_ID=217631
;
