-- IDEMPIERE-5302
SELECT register_migration_script('202207081747_IDEMPIERE-5302.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 12, 2022, 9:14:27 AM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203568,0,0,'Y',TO_TIMESTAMP('2022-07-12 09:14:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-12 09:14:27','YYYY-MM-DD HH24:MI:SS'),100,'IsShowInDrillOptions','Show In Drill Options','This parameter enables the table to be displayed in Drill Assistant - Table tab','Show In Drill Options','D','6a1f3c17-a045-4c39-9cb9-ecebb729fc85')
;

-- Jul 12, 2022, 9:32:52 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214721,0,'Show In Drill Options','This parameter enables the table to be displayed in Drill Assistant - Table tab',100,'IsShowInDrillOptions','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-07-12 09:32:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-12 09:32:52','YYYY-MM-DD HH24:MI:SS'),100,203568,'Y','N','D','N','N','N','Y','ab5fc669-6971-4f08-a7f3-160796cc2a36','Y',0,'N','N','N','N')
;

-- Jul 12, 2022, 9:32:57 AM CEST
ALTER TABLE AD_Table ADD IsShowInDrillOptions CHAR(1) DEFAULT 'Y' CHECK (IsShowInDrillOptions IN ('Y','N'))
;

-- Jul 12, 2022, 9:34:27 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206920,'Show In Drill Options','This parameter enables the table to be displayed in Drill Assistant - Table tab',100,214721,'Y',0,240,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-12 09:34:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-12 09:34:27','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','42f5e58a-7493-4fe5-bd33-7260ab2d1d68','Y',200,1,1,1,'N','N','N','N')
;

-- Jul 12, 2022, 9:34:45 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-07-12 09:34:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206920
;

-- Jun 24, 2022, 4:18:53 PM CEST
UPDATE AD_Table SET IsShowInDrillOptions = 'Y', UPDATED=TO_TIMESTAMP('2022-06-16 15:29:52','YYYY-MM-DD HH24:MI:SS')
WHERE TableName IN('C_AllocationHdr','C_AllocationLine','C_BankStatement','C_BankStatementLine','C_BankTransfer','C_Invoice','C_InvoiceLine','C_Order','C_OrderLine','C_Payment','C_PaymentAllocate',
'C_Project','C_ProjectLine','C_ProjectIssue','C_RfQ','C_RfQLine','GL_Journal','GL_JournalLine','M_InOut','M_InOutLine','M_Inventory','M_InventoryLine','M_Movement','M_MovementLine',
'M_Production','M_ProductionLine','M_Requisition','M_RequisitionLine','M_RMA','M_RMALine','R_Request')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200335,'Drill Rule','AD_Process_DrillRule',0,'6',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','83361033-2aa3-41d6-9de5-1ce897245dde','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Process_DrillRule',1000000,'N','N','Table AD_Process_DrillRule','Y','Y',0,0,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,200423,'Y',1000000,1,200000,'e50a70e3-a576-4660-8ac1-b73403a6b897')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203569,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_ID','Drill Rule','Drill Rule','D','0c9e8965-941a-46f7-be4e-5794df9dfc9d')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214722,0.0,'Drill Rule',200335,'AD_Process_DrillRule_ID',10,'Y','N','Y','N','N','N',13,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,203569,'N','N','D','Y','N','N','Y','afd2c9af-9c8d-4fb9-b4ea-88626a1ef43d','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
CREATE TABLE AD_Process_DrillRule (AD_Process_DrillRule_ID NUMBER(10) NOT NULL, CONSTRAINT AD_Process_DrillRule_Key PRIMARY KEY (AD_Process_DrillRule_ID))
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214723,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200335,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','dcbbbea4-8ccd-4c07-8964-0d8d9f6b10f1','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214724,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200335,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','a0b49fe9-f6ce-4ea6-b317-ae979c02d027','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214725,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200335,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','feaf7550-5361-45f1-9986-2deb5187727e','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214726,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200335,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','d3772d17-fb70-4cbc-af0c-cc2a54b7813f','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214727,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200335,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','c629839b-dc5a-4238-9087-b9500fa241de','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214728,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200335,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','0a2b4e06-7142-455a-ac49-7637be07716b','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214729,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200335,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','82ea3b7f-7165-4d7b-98b7-35a20c1bd315','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214730,0.0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200335,'Name',60,'N','N','Y','Y','Y','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','3a29e5d3-8271-4a43-b5c2-19547c78f295','Y',10,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD Name VARCHAR2(60 CHAR) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214731,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200335,'Description',255,'N','N','N','Y','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','907cdb65-3239-4d65-bcc4-fbefb10ea218','Y',20,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214732,0.0,'Show Help',200335,'ShowHelp','S',1,'N','N','N','N','N','N',17,50007,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,50038,'Y','N','D','Y','N','N','Y','74c04cf6-c00f-495a-80f1-66dc036be9e4','Y','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD ShowHelp CHAR(1) DEFAULT 'S'
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Callout,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214733,0.0,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200335,128,'AD_Process_ID',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'org.cloudempiere.model.CalloutProcessDrillRule.process',117,'Y','N','D','Y','N','N','Y','c7b4d348-fca5-4442-9575-c0046d000a89','Y','N','N','adprocess_addrillrule','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Process_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214734,0.0,'Table','Database Table information','The Database Table provides the information of the table definition',200335,'AD_Table_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','Y','N','N','Y','ac425e9f-2a69-45f1-aa44-cd82ea080ea2','Y','N','N','adtable_addrillrule','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Table_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200158,'AD_ReportView of AD_Table','S','AD_ReportView.AD_Table_ID = @AD_Table_ID@',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'D','cd974660-b27f-499c-a6e9-e9f959510395')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214735,0.0,'Report View','View used to generate this report','The Report View indicates the view used to generate this report.',200335,200158,'AD_ReportView_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,1252,'Y','N','D','Y','N','N','Y','67f6721b-a7b9-4c0e-b704-0a82534ec640','Y','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_ReportView_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200159,'AD_PrintFormat of AD_ReportView','S','AD_PrintFormat.AD_ReportView_ID = @AD_ReportView_ID@',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'D','83bb8e51-dc05-47b8-b3e0-f0d54d410e63')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214736,0.0,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200335,200159,'AD_PrintFormat_ID',10,'N','N','N','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,1790,'Y','N','D','Y','N','N','Y','bf68bfcd-02cd-4507-a6f5-46ac33bbe525','Y','N','N','adprintformat_addrillrule','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_PrintFormat_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203570,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_UU','AD_Process_DrillRule_UU','AD_Process_DrillRule_UU','D','deb41a28-7518-4e08-93d4-f574052eca6c')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214738,0.0,'AD_Process_DrillRule_UU',200335,'AD_Process_DrillRule_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,203570,'N','N','D','Y','N','N','Y','cd5833a4-a634-49af-a711-3f207a5223f5','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Process_DrillRule_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT AD_Process_DrillRule_UU_idx UNIQUE (AD_Process_DrillRule_UU)
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214967,0,'Process Parameter',200335,186,'AD_Process_Para_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,118,'Y','N','D','Y','N','N','Y','a793c423-1a45-4fd7-95a0-d03bfb6c6f94','Y',0,'N','N','ADProcessPara_ADProcessDrillRu','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule ADD AD_Process_Para_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201125,'16ae8995-7124-4e4d-8dda-ce553170406c',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_process_drillrule_uu_idx',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,200335,'N','Y','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201506,'d2686c3e-6ebf-49c1-a304-8a63c5f1daa0',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,214738,201125,10)
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200336,'Drill Rule Parameter','AD_Process_DrillRule_Para',0,'6',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','Y','L','N','Y','1c5204bd-d8e8-4cc6-ab2d-e11735e1ff3c','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Process_DrillRule_Para',1000000,'N','N','Table AD_Process_DrillRule_Para','Y','Y',0,0,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,200424,'Y',1000000,1,200000,'e72153a2-3cd2-462a-8b79-308730a66acf')
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214739,0.0,'Drill Rule',200336,'AD_Process_DrillRule_ID',10,'N','Y','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,203569,'N','N','D','Y','N','N','Y','cc9d25da-cd10-4a46-b598-49bfa88a5fef','Y','N','N','adprocess_addrillrulepara','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
CREATE TABLE AD_Process_DrillRule_Para (AD_Process_DrillRule_ID NUMBER(10) NOT NULL)
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214741,0.0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200336,129,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','1a2c8dc6-66f5-438c-89bf-df56e12e708e','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD AD_Client_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214742,0.0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200336,104,'AD_Org_ID','@#AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','4c8313ac-11d5-4fab-aba2-1ca5ecb34155','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214743,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200336,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','dfcfb4b4-38f9-4b8e-8c5c-811c1bdcd58d','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214744,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200336,'Created','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','30b678ab-40aa-468e-9a2d-9108d38bdcc1','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214745,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200336,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','c5875da8-08c5-4d3d-a99b-b80459d286dc','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214746,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200336,'Updated','SYSDATE',29,'N','N','Y','N','N','N',16,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','418403df-269d-4cd1-9aca-2d335a230ccb','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214747,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200336,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','f3f1a606-2119-4671-8c13-d96a12441570','N','N','N','D','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214748,0.0,'Default Parameter','Default value of the parameter','The default value can be a variable like @#Date@ ',200336,'ParameterDefault',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,2419,'Y','N','D','Y','N','N','Y','c37de7ce-4091-4f0d-b38e-d23770c5db4d','Y','N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD ParameterDefault VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:56 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214749,0.0,'Description','Optional short description of the record','A description is limited to 255 characters.',200336,'Description',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','7503a18e-7cde-422f-a911-f06143d187c4','Y',10,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:56 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203572,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:56','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_Para_UU','AD_Process_DrillRule_Para_UU','AD_Process_DrillRule_Para_UU','D','7db65d50-a7f5-4c47-b7a2-365568ae7551')
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214750,0.0,'AD_Process_DrillRule_Para_UU',200336,'AD_Process_DrillRule_Para_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,203572,'N','N','D','Y','N','N','Y','ac660503-7779-406e-81d1-5d1bab1241f9','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD AD_Process_DrillRule_Para_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD CONSTRAINT AD_Process_DrillRule_Parauuidx UNIQUE (AD_Process_DrillRule_Para_UU)
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214751,0.0,'Default To Parameter','Default value of the to parameter','The default value can be a variable like @#Date@ ',200336,'ParameterToDefault',255,'N','N','N','N','N','N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,202621,'Y','N','D','Y','N','N','Y','82c6f4d8-e611-4b13-944f-2bf5f42bd768','Y','N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD ParameterToDefault VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214753,0.0,'Process Parameter',200336,186,'AD_Process_Para_ID',10,'N','Y','Y','N','N','N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,118,'N','N','D','Y','N','N','Y','baeb0d20-439e-46aa-b4e7-0eb81a391b63','Y','N','N','adprocesspara_addrillrulepara','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD AD_Process_Para_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201126,'bef2bd46-27dd-4443-bd5c-d3f383ebb846',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','ad_process_drillrule_para_uu_idx',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,200336,'N','Y','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201507,'2c3d88d2-f91b-4084-b015-b9b3db519088',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,214750,201126,10)
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Table (AD_Table_ID,Name,TableName,LoadSeq,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,ImportTable,IsChangeLog,ReplicationType,CopyColumnsFromTable,IsCentrallyMaintained,AD_Table_UU,Processing,DatabaseViewDrop,CopyComponentsFromView,CreateWindowFromTable,IsShowInDrillOptions) VALUES (200349,'Drill Rule Trl','AD_Process_DrillRule_Trl',0,'3',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','N','N','L','N','Y','238cf5eb-d915-48d0-a1e6-df5cb52415e7','N','N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('AD_Process_DrillRule_Trl',1000000,'N','N','Table AD_Process_DrillRule_Trl','Y','Y',0,0,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,200425,'Y',1000000,1,200000,'8e76ab69-cb0f-4d81-911d-f0469520d5ac')
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214917,0,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200349,129,'AD_Client_ID','@#AD_Client_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','D','Y','N','N','Y','0aa5cf91-1216-472a-8cc4-cbdea568233e','N',0,'N','N','D','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
CREATE TABLE AD_Process_DrillRule_Trl (AD_Client_ID NUMBER(10) NOT NULL)
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214918,0,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200349,'AD_Language',6,'N','N','Y','N','N',0,'N',18,106,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,109,'N','N','D','Y','N','N','Y','623d0880-7b03-4357-96cf-4102d2c1d037','Y',0,'N','N','adlanguage_adprocessdrillrulet','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Language VARCHAR2(6 CHAR) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214919,0,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200349,104,'AD_Org_ID','@#AD_Org_ID@',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','Y','N','N','Y','bd5074ec-a162-4337-854f-b3ab811f4b54','N',0,'N','N','D','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Org_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214920,0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200349,'Created','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','Y','N','N','Y','76b1ed53-f6d3-4554-9922-412c14df029e','N',0,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Created DATE DEFAULT SYSDATE NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214921,0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200349,'CreatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','Y','N','N','Y','80299531-63d4-4d73-a474-d66207e25a70','N',0,'N','N','D','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CreatedBy NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214922,0,'Description','Optional short description of the record','A description is limited to 255 characters.',200349,'Description',255,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,275,'Y','Y','D','Y','N','N','Y','1daf3f54-2df8-48bf-a87e-892cb8f4df02','Y',10,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Description VARCHAR2(255 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214923,0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200349,'IsActive','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','Y','N','N','Y','a7ec7506-a7ba-42ae-b1dc-bec723ce7e3b','N',0,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214924,0,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200349,'IsTranslated',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,420,'Y','N','D','Y','N','N','Y','27f2296d-a28a-4849-b879-ec434e650c34','Y',0,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD IsTranslated CHAR(1) CHECK (IsTranslated IN ('Y','N')) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203600,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,'AD_Process_DrillRule_Trl_UU','AD_Process_DrillRule_Trl_UU','AD_Process_DrillRule_Trl_UU','D','4af8145b-0ba4-499f-b4af-222bc88e2891')
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214925,0,'AD_Process_DrillRule_Trl_UU',200349,'AD_Process_DrillRule_Trl_UU',36,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,203600,'Y','N','D','Y','N','N','Y','f1a207cd-ca7e-41c9-ae44-97c928127861','N',0,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Process_DrillRule_Trl_UU VARCHAR2(36 CHAR) DEFAULT NULL 
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT AD_Process_DrillRule_Trl_uuidx UNIQUE (AD_Process_DrillRule_Trl_UU)
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214926,0,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200349,'Name',255,'N','N','Y','N','Y',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,469,'Y','Y','D','Y','N','N','Y','3e17c966-5575-47bc-8b4a-fa6ea20e47fb','Y',20,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Name VARCHAR2(255 CHAR) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214927,0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200349,'Updated','SYSDATE',7,'N','N','Y','N','N',0,'N',16,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','Y','N','N','Y','65b7c93a-997a-42a4-818a-5c5a1825e012','N',0,'N','N','N','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD Updated DATE DEFAULT SYSDATE NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214928,0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200349,'UpdatedBy',22,'N','N','Y','N','N',0,'N',30,110,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','Y','N','N','Y','56503a67-4f6d-4086-83e2-daef40e53de1','N',0,'N','N','D','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD UpdatedBy NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType,IsHtml) VALUES (214929,0,'Drill Rule',200349,'AD_Process_DrillRule_ID',22,'N','Y','Y','N','N',0,'N',30,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,203569,'N','N','D','Y','N','N','Y','6cba0265-b5f8-4134-850d-d6aa6b042a67','Y',0,'N','N','adprocessdrillrule_trl','C','N')
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD AD_Process_DrillRule_ID NUMBER(10) NOT NULL
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_TableIndex (AD_Client_ID,AD_Org_ID,AD_TableIndex_ID,AD_TableIndex_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,IsCreateConstraint,IsUnique,Processing,TableIndexDrop,IsKey) VALUES (0,0,201122,'d60d3d3f-33ce-4186-b160-b567ae53e478',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','AD_Process_DrillRule_Trl_pkey',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,200349,'Y','Y','N','N','Y')
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201499,'85a6b307-66bb-4905-a9c6-7eff6e438b6d',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,214929,201122,10)
;

-- Jul 8, 2022, 5:47:57 PM CEST
INSERT INTO AD_IndexColumn (AD_Client_ID,AD_Org_ID,AD_IndexColumn_ID,AD_IndexColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_Column_ID,AD_TableIndex_ID,SeqNo) VALUES (0,0,201500,'489493fb-35a5-4083-b3df-baa69901cc65',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),100,214918,201122,20)
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT adprocess_addrillrule FOREIGN KEY (AD_Process_ID) REFERENCES ad_process(ad_process_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT adtable_addrillrule FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
UPDATE AD_Column SET FKConstraintName='ADReportView_ADProcessDrillRul', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-07-08 17:47:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214735
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT ADReportView_ADProcessDrillRul FOREIGN KEY (AD_ReportView_ID) REFERENCES ad_reportview(ad_reportview_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT adprintformat_addrillrule FOREIGN KEY (AD_PrintFormat_ID) REFERENCES ad_printformat(ad_printformat_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule ADD CONSTRAINT ADProcessPara_ADProcessDrillRu FOREIGN KEY (AD_Process_Para_ID) REFERENCES ad_process_para(ad_process_para_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD CONSTRAINT adprocess_addrillrulepara FOREIGN KEY (AD_Process_DrillRule_ID) REFERENCES ad_process_drillrule(ad_process_drillrule_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Para ADD CONSTRAINT adprocesspara_addrillrulepara FOREIGN KEY (AD_Process_Para_ID) REFERENCES ad_process_para(ad_process_para_id) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT adlanguage_adprocessdrillrulet FOREIGN KEY (AD_Language) REFERENCES ad_language(ad_language) DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:47:57 PM CEST
ALTER TABLE AD_Process_DrillRule_Trl ADD CONSTRAINT adprocessdrillrule_trl FOREIGN KEY (AD_Process_DrillRule_ID) REFERENCES ad_process_drillrule(ad_process_drillrule_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Jul 8, 2022, 5:48:13 PM CEST
INSERT INTO AD_Window (AD_Window_ID,Name,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,WindowType,Processing,EntityType,IsSOTrx,IsDefault,WinHeight,IsBetaFunctionality,AD_Window_UU) VALUES (200123,'Drill Rule',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),100,'M','N','D','Y','N',0,'N','91407fde-0a29-41fd-b44c-aff7070f94ec')
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='AD_Process_DrillRule_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, IsUpdateable='N', AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214722
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET ColumnName='AD_Client_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214723
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET ColumnName='AD_Org_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214724
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='IsActive', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214725
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Created', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214726
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='CreatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214727
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Updated', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214728
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='UpdatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214729
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET ColumnName='AD_ReportView_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, FKConstraintName=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214735
;

-- Jul 8, 2022, 5:48:13 PM CEST
ALTER TABLE AD_Process_DrillRule MODIFY AD_ReportView_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 8, 2022, 5:48:13 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='AD_Process_DrillRule_UU', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214738
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200308,'Drill Rule',200123,10,'Y',200335,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N','N','N',0,'N','D','Y','N','1c99e0b5-4718-463a-a0e7-bf8432d1b70e','B','N','Y',0)
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206925,'Drill Rule',200308,214722,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6487a092-0a7c-4d9c-9cc7-f6bea064af07','N',1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206932,'AD_Process_DrillRule_UU',200308,214738,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7dcb0cd5-450c-4642-b213-2a0cf2dc2ddb','N',1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206921,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200308,214723,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','5dcf564e-4dfd-4861-94e0-96e072e9c4a9','N',1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206922,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200308,214724,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','860d79ca-5019-4b3f-87f5-411f7715fdc2','Y','N',4,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206923,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200308,214730,'Y',60,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1c1f603b-1d53-4ed4-8b33-0e2c8e285538','Y',10,1,5,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206924,'Description','Optional short description of the record','A description is limited to 255 characters.',200308,214731,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','84693c4f-75a8-4df8-882b-73f357961ae2','Y',20,1,5,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206927,'Process','Process or Report','The Process field identifies a unique Process or Report in the system.',200308,214733,'Y',10,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',114,'D','7c6ecc52-f2b7-42cc-a78e-80ca01928c01','Y',40,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206926,'Show Help',200308,214732,'Y',1,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y',114,'D','e391bd8f-d510-4974-86d3-cb28df01455c','Y',30,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_FieldGroup (AD_FieldGroup_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,EntityType,FieldGroupType,IsCollapsedByDefault,AD_FieldGroup_UU) VALUES (200029,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'Source','D','C','N','7227d406-b09d-4b60-9169-8330e99b724d')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,AD_FieldGroup_ID,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206928,'Table','Database Table information','The Database Table provides the information of the table definition',200308,214734,'Y',10,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y',200029,'D','f351d63e-611f-4a5b-80ed-7e78e73a00cd','Y',50,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206933,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200308,214725,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','221d1536-dd3e-4279-afb9-b2592ab008f3','Y',90,5,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206929,'Report View','View used to generate this report','The Report View indicates the view used to generate this report.',200308,214735,'Y',10,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','117f2b2c-1719-4ff3-b7c5-c8da0b9f2cd0','Y',60,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206930,'Print Format','Data Print Format','The print format determines how data is rendered for print.',200308,214736,'Y',10,100,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','84e95705-785f-44b4-b966-48d10fb766a6','Y',70,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207109,'Process Parameter',200308,214967,'Y',0,110,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6dbd8833-4d79-4312-a7b4-5ccc05af8f12','Y',100,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Table SET AD_Window_ID=200123, AD_Val_Rule_ID=NULL, AD_Org_ID=0, PO_Window_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200336
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET ColumnName='AD_Client_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214741
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET ColumnName='AD_Org_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214742
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='IsActive', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214743
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Created', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214744
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='CreatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214745
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Updated', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214746
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='UpdatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214747
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='AD_Process_DrillRule_Para_UU', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214750
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200309,'Drill Rule Parameter',200123,20,'Y',200336,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','N',214739,'N','N',1,'N','D','Y','N','cf646be0-5bd7-4d8e-9ede-185fec8f6b64','B','N','Y',0)
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206940,'AD_Process_DrillRule_Para_UU',200309,214750,'N',36,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','56105b60-807f-4790-bddb-4d44f1a45706','N',1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206937,'Drill Rule',200309,214739,'N',10,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c375dd96-6b77-4d57-8bd4-3783ad332aa3','Y',20,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206934,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200309,214741,'Y',10,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'Y','Y','D','7a31d9d5-18f9-4901-827e-368ec8d94ee4','N',1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206935,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200309,214742,'Y',10,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','19e03e36-0698-4ec2-bcf1-2a477e02c028','Y','N',4,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206944,'Process Parameter',200309,214753,'Y',10,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3aaa0900-2afb-4fb9-bda7-0e5310e8013e','Y',60,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206942,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200309,214743,'Y',1,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b4bb1db1-e2da-41e2-a573-cb3c1bb4f0a7','Y',50,2,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206939,'Default Parameter','Default value of the parameter','The default value can be a variable like @#Date@ ',200309,214748,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cec431e5-61c2-46d3-b3d6-266b0c10c57b','Y',30,1,5,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206941,'Default To Parameter','Default value of the to parameter','The default value can be a variable like @#Date@ ',200309,214751,'Y',255,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','86b3b8c8-7d82-4ef4-864d-c6cb69b1570f','Y',40,1,5,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206936,'Description','Optional short description of the record','A description is limited to 255 characters.',200309,214749,'Y',255,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5328039c-28f7-41ec-8753-9bd40fef703b','Y',10,1,5,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Table SET AD_Window_ID=200123, AD_Val_Rule_ID=NULL, AD_Org_ID=0, PO_Window_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200349
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200322,'Drill Rule Translation',200123,30,'Y',200349,0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','N','Y','N',214929,'N','N',1,'N','D','N','N','08a5d1fc-e264-48c6-84d3-dad1cbac8811','B','N','Y',0)
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207063,'Tenant','Tenant for this installation.','A Tenant is a company or a legal entity. You cannot share data between Tenants.',200322,214917,'Y',22,10,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','415b39ab-f8a0-4ebd-9205-ff17e323ea62','N',1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207064,'Organization','Organizational entity within tenant','An organization is a unit of your tenant or legal entity - examples are store, department. You can share data between organizations.',200322,214919,'Y',22,20,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ebcd812e-7741-448a-a812-035785229365','Y','Y',10,4,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207065,'Drill Rule',200322,214929,'Y',22,30,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','fbcbc793-12a4-40ea-b738-e0dee2869129','Y',20,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207066,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200322,214926,'Y',255,40,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','79a96976-9ed0-4691-b213-29a827aab39e','Y',30,1,5,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207067,'Description','Optional short description of the record','A description is limited to 255 characters.',200322,214922,'Y',255,50,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ce2cff54-a5c8-4d8c-98f6-1e9de59f3210','Y',40,1,5,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207068,'Language','Language for this entity','The Language identifies the language to use for display and formatting',200322,214918,'Y',6,60,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','83c4f092-7083-436b-8858-3d08663b6efa','Y',50,1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207069,'Translated','This column is translated','The Translated checkbox indicates if this column is translated.',200322,214924,'Y',1,70,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ee3b1016-b121-4f42-a490-9723ec99b431','Y',60,2,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207071,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200322,214923,'Y',1,80,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f63a8890-9ddb-440b-988e-069a95d8a541','Y',70,2,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (207070,'AD_Process_DrillRule_Trl_UU',200322,214925,'N',36,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cd371b09-815e-4df7-bda1-cc5b35867ab9','N',1,2,1,'N','N','N','N')
;

-- Jul 8, 2022, 5:48:14 PM CEST
UPDATE AD_Column SET FKConstraintName='adreportview_adprocessdrillrul', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-07-08 17:48:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214735
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='AD_Process_DrillRule_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, IsUpdateable='N', AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214722
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET ColumnName='AD_Client_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214723
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET ColumnName='AD_Org_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214724
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='IsActive', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214725
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Created', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214726
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='CreatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214727
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Updated', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214728
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='UpdatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214729
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET ColumnName='AD_ReportView_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, FKConstraintName=NULL, PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214735
;

-- Jul 8, 2022, 5:48:30 PM CEST
ALTER TABLE AD_Process_DrillRule MODIFY AD_ReportView_ID NUMBER(10) DEFAULT NULL 
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='AD_Process_DrillRule_UU', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214738
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET ColumnName='AD_Client_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214741
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET ColumnName='AD_Org_ID', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214742
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='IsActive', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214743
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Created', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214744
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='CreatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214745
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='Updated', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214746
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='UpdatedBy', AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214747
;

-- Jul 8, 2022, 5:48:30 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=NULL, ColumnName='AD_Process_DrillRule_Para_UU', AD_Reference_Value_ID=NULL, AD_Org_ID=0, AD_Process_ID=NULL, IsSyncDatabase='Y', AD_Chart_ID=NULL, IsAllowCopy='N', PA_DashboardContent_ID=NULL, AD_Val_Rule_Lookup_ID=NULL,Updated=TO_TIMESTAMP('2022-07-08 17:48:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214750
;

-- Jul 8, 2022, 5:48:31 PM CEST
UPDATE AD_Column SET FKConstraintName='adreportview_adprocessdrillrul', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-07-08 17:48:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214735
;

-- Jul 8, 2022, 5:48:49 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Drill Assistant',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,200744,'DrillAssistant','D','9834ddc4-e261-4a92-84f5-da6ebca72822')
;

-- Jul 8, 2022, 5:48:49 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Drill Column',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,200745,'DrillColumn','D','b36997cf-a012-4e9f-9711-b051b44d05cc')
;

-- Jul 8, 2022, 5:48:49 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Fill Mandatory Drill Rule Parameters',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,200767,'FillMandatoryDrillRulePara','D','115f5fac-3645-4f9f-af30-050dda684d24')
;

-- Jul 8, 2022, 5:48:49 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Drill Key Parameter is Not Set',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,200766,'NoDrillKeyParameterSet','D','afe60283-10a3-446b-a557-b0003c457ee4')
;

-- Jul 8, 2022, 5:48:49 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Cannot find Drill Rule for the selected Column.','You can define new definitions in Drill Rule window.',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,200762,'NoDrillRuleFound','D','6953574e-88f7-4d13-9914-ee36e2dd3bf9')
;

-- Jul 8, 2022, 5:48:49 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Cannot find Drill Across for Column in Tables.','You can enable Drill Across in Application Dictionary as System User in the Table window.',0,0,'Y',TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-08 17:48:49','YYYY-MM-DD HH24:MI:SS'),100,200761,'NoTableWithDrillOptions','D','22c1a70e-5ba7-4d22-a84c-db19c552b693')
;

-- Jul 8, 2022, 5:56:21 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2022-07-08 17:56:21','YYYY-MM-DD HH24:MI:SS'),100,'Captured Process Parameter','Y',200123,'Captured Process Parameter',TO_TIMESTAMP('2022-07-08 17:56:21','YYYY-MM-DD HH24:MI:SS'),100,'N','fe77d924-c795-43ae-b7a3-ba0ad03e0b75','W',200308,200064,10,'D')
;

-- Jul 10, 2022, 4:17:00 PM CEST
INSERT INTO AD_Menu (AD_Menu_ID,Name,Action,AD_Window_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) VALUES (200211,'Drill Rule','W',200123,0,0,'Y',TO_TIMESTAMP('2022-07-10 16:17:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-10 16:17:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','D','Y','776130ae-720c-4638-bfe7-a3d2d46672be')
;

-- Jul 10, 2022, 4:17:00 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', getDate(), 100, getDate(), 100,t.AD_Tree_ID, 200211, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200211)
;

-- Jul 10, 2022, 4:34:39 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=2,Updated=TO_TIMESTAMP('2022-07-10 16:34:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=446
;

-- Jul 10, 2022, 4:34:39 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=3,Updated=TO_TIMESTAMP('2022-07-10 16:34:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200
;

-- Jul 10, 2022, 4:34:39 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=4,Updated=TO_TIMESTAMP('2022-07-10 16:34:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=439
;

-- Jul 10, 2022, 4:34:39 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=5,Updated=TO_TIMESTAMP('2022-07-10 16:34:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53191
;

-- Jul 10, 2022, 4:34:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=6,Updated=TO_TIMESTAMP('2022-07-10 16:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=440
;

-- Jul 10, 2022, 4:34:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=7,Updated=TO_TIMESTAMP('2022-07-10 16:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=594
;

-- Jul 10, 2022, 4:34:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=8,Updated=TO_TIMESTAMP('2022-07-10 16:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53192
;

-- Jul 10, 2022, 4:34:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=9,Updated=TO_TIMESTAMP('2022-07-10 16:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=50009
;

-- Jul 10, 2022, 4:34:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=10,Updated=TO_TIMESTAMP('2022-07-10 16:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=53200
;

-- Jul 10, 2022, 4:34:40 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=456, SeqNo=11,Updated=TO_TIMESTAMP('2022-07-10 16:34:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tree_ID=10 AND Node_ID=200211
;

