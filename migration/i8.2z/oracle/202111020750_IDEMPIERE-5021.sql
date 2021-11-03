SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5021 Implement Storage Reservation Log
-- Nov 1, 2021, 4:11:40 PM MYT
INSERT INTO AD_Table (AD_Table_ID,Name,Description,TableName,AccessLevel,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSecurityEnabled,IsDeleteable,IsHighVolume,IsView,EntityType,IsChangeLog,ReplicationType,AD_Table_UU,Processing) VALUES (200281,'Storage Reservation Log','Log for every storage reservation quantity change','M_StorageReservationLog','3',0,0,'Y',TO_DATE('2021-11-01 16:11:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:40','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','N','N','D','Y','L','f083f790-17a7-44f6-a900-5bc0b47df0da','N')
;

-- Nov 1, 2021, 4:11:41 PM MYT
INSERT INTO AD_Sequence (Name,CurrentNext,IsAudited,StartNewYear,Description,IsActive,IsTableID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,Updated,UpdatedBy,AD_Sequence_ID,IsAutoSequence,StartNo,IncrementNo,CurrentNextSys,AD_Sequence_UU) VALUES ('M_StorageReservationLog',1000000,'N','N','Table M_StorageReservationLog','Y','Y',0,0,TO_DATE('2021-11-01 16:11:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:40','YYYY-MM-DD HH24:MI:SS'),100,200350,'Y',1000000,1,200000,'471af497-3bb2-44e6-bca0-2ccfcb3ab230')
;

-- Nov 1, 2021, 4:11:42 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,ReadOnlyLogic,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214597,0.0,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200281,'AD_Client_ID','@#AD_Client_ID@',10,'N','N','Y','N','N','N',30,0,0,'Y',TO_DATE('2021-11-01 16:11:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:41','YYYY-MM-DD HH24:MI:SS'),100,102,'N','N','1=1','D','N','249231e5-2e52-4de9-b7fc-b6eea6adeb2f','N')
;

-- Nov 1, 2021, 4:11:42 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214598,0.0,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200281,'AD_Org_ID','@AD_Org_ID@',10,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2021-11-01 16:11:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:42','YYYY-MM-DD HH24:MI:SS'),100,113,'N','N','D','N','8e62da06-8682-4e68-9002-bd24f9b43133','N')
;

-- Nov 1, 2021, 4:11:43 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214599,0.0,'Created','Date this record was created','The Created field indicates the date that this record was created.',200281,'Created',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2021-11-01 16:11:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:42','YYYY-MM-DD HH24:MI:SS'),100,245,'N','N','D','N','6f3fc480-798a-43d6-8b0c-6fc5c863ae23','N')
;

-- Nov 1, 2021, 4:11:44 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214600,0.0,'Created By','User who created this records','The Created By field indicates the user who created this record.',200281,'CreatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2021-11-01 16:11:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:43','YYYY-MM-DD HH24:MI:SS'),100,246,'N','N','D','N','2775c01e-244f-4518-b7fe-d6b1a79f9aa1','N')
;

-- Nov 1, 2021, 4:11:44 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214601,0.0,'Updated','Date this record was updated','The Updated field indicates the date that this record was updated.',200281,'Updated',7,'N','N','Y','N','N','N',16,0,0,'Y',TO_DATE('2021-11-01 16:11:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:44','YYYY-MM-DD HH24:MI:SS'),100,607,'N','N','D','N','c129d34e-07f8-49e5-acf4-119786bf2d5c','N')
;

-- Nov 1, 2021, 4:11:45 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214602,0.0,'Updated By','User who updated this records','The Updated By field indicates the user who updated this record.',200281,'UpdatedBy',10,'N','N','Y','N','N','N',30,110,0,0,'Y',TO_DATE('2021-11-01 16:11:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:44','YYYY-MM-DD HH24:MI:SS'),100,608,'N','N','D','N','139ce33f-773a-4aed-89cf-f61723aacb72','N')
;

-- Nov 1, 2021, 4:11:46 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214603,0.0,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200281,'IsActive','Y',1,'N','N','Y','N','N','N',20,0,0,'Y',TO_DATE('2021-11-01 16:11:45','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:45','YYYY-MM-DD HH24:MI:SS'),100,348,'Y','N','D','N','843d30d4-dc13-4c60-882f-ba07b6c00e3f','N')
;

-- Nov 1, 2021, 4:11:46 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,PrintName,EntityType,AD_Element_UU) VALUES (203546,0,0,'Y',TO_DATE('2021-11-01 16:11:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:46','YYYY-MM-DD HH24:MI:SS'),100,'M_StorageReservationLog_ID','Storage Reservation Log','Log for every storage reservation quantity change','Storage Reservation Log','D','b61ac326-87a1-4205-8249-0e2e6804b1d0')
;

-- Nov 1, 2021, 4:11:47 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214604,0.0,'Storage Reservation Log','Log for every storage reservation quantity change',200281,'M_StorageReservationLog_ID',22,'Y','N','Y','N','N','N',13,0,0,'Y',TO_DATE('2021-11-01 16:11:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:46','YYYY-MM-DD HH24:MI:SS'),100,203546,'N','N','D','N','8fedbd22-6622-4431-945f-6303d2b62cb8','N')
;

-- Nov 1, 2021, 4:11:48 PM MYT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203547,0,0,'Y',TO_DATE('2021-11-01 16:11:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:47','YYYY-MM-DD HH24:MI:SS'),100,'M_StorageReservationLog_UU','M_StorageReservationLog_UU','M_StorageReservationLog_UU','D','2483d8d8-e1fd-412e-b019-573ae9a8127c')
;

-- Nov 1, 2021, 4:11:48 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214605,0.0,'M_StorageReservationLog_UU',200281,'M_StorageReservationLog_UU',36,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-11-01 16:11:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:48','YYYY-MM-DD HH24:MI:SS'),100,203547,'Y','N','D','N','f1d8bfb7-d607-4e47-bc37-f684ea6477d3','N')
;

-- Nov 1, 2021, 4:11:49 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,IsToolbarButton) VALUES (214606,0.0,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200281,'C_DocType_ID',22,'N','N','Y','N','N','N',19,0,0,'Y',TO_DATE('2021-11-01 16:11:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:48','YYYY-MM-DD HH24:MI:SS'),100,196,'Y','N','D','N','a150655d-fe3a-4fd2-9812-5b750262dee4','N')
;

-- Nov 1, 2021, 4:11:49 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsAlwaysUpdateable,AD_Column_UU,SeqNoSelection,IsToolbarButton) VALUES (214607,0.0,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200281,'DocumentNo',30,'N','N','N','N','N','N',10,0,0,'Y',TO_DATE('2021-11-01 16:11:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:11:49','YYYY-MM-DD HH24:MI:SS'),100,290,'Y','Y','D','N','a653de82-d41f-4d27-878a-e1c4eeaafdd5',10,'N')
;

-- Nov 1, 2021, 4:12:28 PM MYT
UPDATE AD_Table SET IsDeleteable='N', IsChangeLog='N',Updated=TO_DATE('2021-11-01 16:12:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200281
;

-- Nov 1, 2021, 4:13:54 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214608,0,'Line','Line No',200281,'LineNo',10,'N','N','N','N','N',0,'N',11,0,0,'Y',TO_DATE('2021-11-01 16:13:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:13:53','YYYY-MM-DD HH24:MI:SS'),100,2945,'N','N','D','N','N','N','N','cdaa2197-58a5-4d46-a7ed-b972f18302df','N',0,'N','N','N')
;

-- Nov 1, 2021, 4:14:41 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214609,0,'Table','Database Table information','The Database Table provides the information of the table definition',200281,'AD_Table_ID',10,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-11-01 16:14:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:14:40','YYYY-MM-DD HH24:MI:SS'),100,126,'N','N','D','N','N','N','N','cf77d300-4ed4-4a01-a2f2-3d893c1e10de','N',0,'N','N','N','N')
;

-- Nov 1, 2021, 4:15:08 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214610,0,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200281,'Record_ID',22,'N','N','Y','N','N',0,'N',28,0,0,'Y',TO_DATE('2021-11-01 16:15:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:15:08','YYYY-MM-DD HH24:MI:SS'),100,538,'N','N','D','N','N','N','N','4d546245-a3d8-430f-aa41-80aed612341c','N',0,'N','N','N')
;

-- Nov 1, 2021, 4:15:52 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214611,0,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200281,'M_Warehouse_ID',22,'N','N','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2021-11-01 16:15:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:15:51','YYYY-MM-DD HH24:MI:SS'),100,459,'N','N','D','N','N','N','N','81b3afa7-59e1-4de5-9d99-6c935a245381','N',0,'N','N','N')
;

-- Nov 1, 2021, 4:16:17 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214612,0,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200281,231,'M_Product_ID',22,'N','N','Y','N','N',0,'N',30,0,0,'Y',TO_DATE('2021-11-01 16:16:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:16:16','YYYY-MM-DD HH24:MI:SS'),100,454,'N','N','D','N','N','N','N','1eeff8a3-2605-40da-b828-443b3f3b605c','N',0,'N','N','N','N')
;

-- Nov 1, 2021, 4:17:12 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214613,0,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200281,'M_AttributeSetInstance_ID',22,'N','N','Y','N','N',0,'N',35,0,0,'Y',TO_DATE('2021-11-01 16:17:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:17:11','YYYY-MM-DD HH24:MI:SS'),100,2019,'N','N','D','N','N','N','N','e7460d7c-b81a-4ae5-9fef-e62864394269','N',0,'N','N','N','N')
;

-- Nov 1, 2021, 4:17:42 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214614,0,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200281,'IsSOTrx',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-11-01 16:17:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:17:41','YYYY-MM-DD HH24:MI:SS'),100,1106,'N','N','D','N','N','N','N','4d6baf8f-10ea-4670-b4d2-f0c56940b686','N',0,'N','N','N')
;

-- Nov 1, 2021, 4:18:09 PM MYT
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:18:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214597
;

-- Nov 1, 2021, 4:18:15 PM MYT
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:18:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214598
;

-- Nov 1, 2021, 4:18:27 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:18:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214606
;

-- Nov 1, 2021, 4:18:32 PM MYT
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:18:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214599
;

-- Nov 1, 2021, 4:18:38 PM MYT
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:18:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214600
;

-- Nov 1, 2021, 4:19:00 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:19:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214607
;

-- Nov 1, 2021, 4:19:11 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:19:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214603
;

-- Nov 1, 2021, 4:19:43 PM MYT
UPDATE AD_Column SET IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:19:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214604
;

-- Nov 1, 2021, 4:19:51 PM MYT
UPDATE AD_Column SET IsMandatory='Y', IsUpdateable='N', IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:19:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214605
;

-- Nov 1, 2021, 4:20:07 PM MYT
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:20:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214601
;

-- Nov 1, 2021, 4:20:14 PM MYT
UPDATE AD_Column SET IsAllowLogging='N', IsAllowCopy='N',Updated=TO_DATE('2021-11-01 16:20:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214602
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='ADClient_MStorageReservationLo', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214597
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='ADOrg_MStorageReservationLog', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214598
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='ADTable_MStorageReservationLog', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214609
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='CDocType_MStorageReservationLo', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214606
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='CreatedBy_MStorageReservationL', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214600
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_MStorage', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214613
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='MProduct_MStorageReservationLo', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214612
;

-- Nov 1, 2021, 4:20:27 PM MYT
UPDATE AD_Column SET FKConstraintName='MWH_MSTORAGERESERVATIONLOG', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:20:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214611
;

-- Nov 1, 2021, 4:21:34 PM MYT
UPDATE AD_Column SET FKConstraintName='MWH_MSTORAGERESERVATIONLOG',Updated=TO_DATE('2021-11-01 16:21:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214611
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='ADClient_MStorageReservationLo', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214597
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='ADOrg_MStorageReservationLog', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214598
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='ADTable_MStorageReservationLog', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214609
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='CDocType_MStorageReservationLo', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214606
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='CreatedBy_MStorageReservationL', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214600
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='MAttributeSetInstance_MStorage', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214613
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='MProduct_MStorageReservationLo', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214612
;

-- Nov 1, 2021, 4:21:52 PM MYT
UPDATE AD_Column SET FKConstraintName='UpdatedBy_MStorageReservationL', FKConstraintType='N',Updated=TO_DATE('2021-11-01 16:21:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214602
;

-- Nov 1, 2021, 4:21:52 PM MYT
CREATE TABLE M_StorageReservationLog (AD_Client_ID NUMBER(10) NOT NULL, AD_Org_ID NUMBER(10) NOT NULL, AD_Table_ID NUMBER(10) NOT NULL, C_DocType_ID NUMBER(10) NOT NULL, Created DATE NOT NULL, CreatedBy NUMBER(10) NOT NULL, DocumentNo VARCHAR2(30 CHAR) DEFAULT NULL , IsActive CHAR(1) DEFAULT 'Y' CHECK (IsActive IN ('Y','N')) NOT NULL, IsSOTrx CHAR(1) CHECK (IsSOTrx IN ('Y','N')) NOT NULL, LineNo NUMBER(10) DEFAULT NULL , M_AttributeSetInstance_ID NUMBER(10) NOT NULL, M_Product_ID NUMBER(10) NOT NULL, M_StorageReservationLog_ID NUMBER(10) NOT NULL, M_StorageReservationLog_UU VARCHAR2(36 CHAR) NOT NULL, M_Warehouse_ID NUMBER(10) NOT NULL, Record_ID NUMBER(10) NOT NULL, Updated DATE NOT NULL, UpdatedBy NUMBER(10) NOT NULL, CONSTRAINT M_StorageReservationLog_Key PRIMARY KEY (M_StorageReservationLog_ID), CONSTRAINT M_StorageReservationLog_UU_idx UNIQUE (M_StorageReservationLog_UU))
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT ADClient_MStorageReservationLo FOREIGN KEY (AD_Client_ID) REFERENCES ad_client(ad_client_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT ADOrg_MStorageReservationLog FOREIGN KEY (AD_Org_ID) REFERENCES ad_org(ad_org_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT ADTable_MStorageReservationLog FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT CDocType_MStorageReservationLo FOREIGN KEY (C_DocType_ID) REFERENCES c_doctype(c_doctype_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT CreatedBy_MStorageReservationL FOREIGN KEY (CreatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT MAttributeSetInstance_MStorage FOREIGN KEY (M_AttributeSetInstance_ID) REFERENCES m_attributesetinstance(m_attributesetinstance_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT MProduct_MStorageReservationLo FOREIGN KEY (M_Product_ID) REFERENCES m_product(m_product_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT MWH_MSTORAGERESERVATIONLOG FOREIGN KEY (M_Warehouse_ID) REFERENCES m_warehouse(m_warehouse_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:21:52 PM MYT
ALTER TABLE M_StorageReservationLog ADD CONSTRAINT UpdatedBy_MStorageReservationL FOREIGN KEY (UpdatedBy) REFERENCES ad_user(ad_user_id) DEFERRABLE INITIALLY DEFERRED
;

-- Nov 1, 2021, 4:42:52 PM MYT
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2021-11-01 16:42:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214606
;

-- Nov 1, 2021, 4:42:57 PM MYT
ALTER TABLE M_StorageReservationLog MODIFY C_DocType_ID NUMBER(10) DEFAULT NULL 
;

-- Nov 1, 2021, 4:42:58 PM MYT
ALTER TABLE M_StorageReservationLog MODIFY C_DocType_ID NULL
;

-- Nov 1, 2021, 4:48:01 PM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,WhereClause,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,Parent_Column_ID,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200300,'Reserved Quantity Log',140,160,'N',200281,0,0,'Y',TO_DATE('2021-11-01 16:48:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:00','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y',214612,'M_StorageReservationLog.IsSOTrx=''Y''','M_StorageReservationLog.M_StorageReservationLog_ID Desc','N','N',1,'N','D','N','N',1402,'feec8372-59ab-43ec-9ad7-25c1f5a578a9','B','N','Y',0)
;

-- Nov 1, 2021, 4:48:39 PM MYT
INSERT INTO AD_Tab (AD_Tab_ID,Name,AD_Window_ID,SeqNo,IsSingleRow,AD_Table_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,HasTree,IsInfoTab,IsTranslationTab,IsReadOnly,AD_Column_ID,WhereClause,OrderByClause,Processing,ImportFields,TabLevel,IsSortTab,EntityType,IsInsertRecord,IsAdvancedTab,Parent_Column_ID,AD_Tab_UU,TreeDisplayedOn,IsLookupOnlySelection,IsAllowAdvancedLookup,MaxQueryRecords) VALUES (200301,'Ordered Quantity Log',140,170,'N',200281,0,0,'Y',TO_DATE('2021-11-01 16:48:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:38','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','Y',214612,'M_StorageReservationLog.IsSOTrx=''N''','M_StorageReservationLog.M_StorageReservationLog_ID Desc','N','N',1,'N','D','N','N',1402,'51998887-0e9e-437e-8477-0f9a8684191e','B','N','Y',0)
;

-- Nov 1, 2021, 4:48:51 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206764,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200300,214597,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8f2a4b99-d11b-4f95-a30e-7250097c7f09','N',2)
;

-- Nov 1, 2021, 4:48:52 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206765,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200300,214598,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:51','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0077eb48-4140-4e9b-8b62-e2a25631e751','Y','Y',10,4,2)
;

-- Nov 1, 2021, 4:48:53 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206766,'Storage Reservation Log','Log for every storage reservation quantity change',200300,214604,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0544f98a-7702-452a-b40e-b3c0fca02d34','N',2)
;

-- Nov 1, 2021, 4:48:53 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206767,'M_StorageReservationLog_UU',200300,214605,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ab8f0c15-106a-445f-8122-d3811b04aeda','N',2)
;

-- Nov 1, 2021, 4:48:54 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206768,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200300,214606,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','30010dc2-9113-46c8-99ff-2fc322e937ac','Y',20,2)
;

-- Nov 1, 2021, 4:48:54 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206769,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200300,214607,'Y',30,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','9c25f65e-4097-4e4b-aff4-b29163e0e8d7','Y',30,2)
;

-- Nov 1, 2021, 4:48:55 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206770,'Line','Line No',200300,214608,'Y',10,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','76c3642c-cd76-4541-835e-89bfd9759eaa','Y',40,2)
;

-- Nov 1, 2021, 4:48:56 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206771,'Table','Database Table information','The Database Table provides the information of the table definition',200300,214609,'Y',10,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','414e8e96-ef32-4a0e-be25-91dd429239d4','Y',50,2)
;

-- Nov 1, 2021, 4:48:56 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206772,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200300,214610,'Y',22,70,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','84ba96b9-e4d4-47bf-91a0-2d4196715fec','Y',60,2,2)
;

-- Nov 1, 2021, 4:48:57 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206773,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200300,214611,'Y',22,80,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','c08b5f66-f779-4e35-9781-0fa12cf09d58','Y',70,2)
;

-- Nov 1, 2021, 4:48:58 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206774,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200300,214612,'Y',22,90,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e10c77a3-a5d8-4566-8cf6-b2ffb782d257','Y',80,2)
;

-- Nov 1, 2021, 4:48:58 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206775,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200300,214613,'Y',22,100,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ec100d60-892d-406c-ba32-eba3432c9e65','Y',90,2)
;

-- Nov 1, 2021, 4:48:59 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206776,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200300,214614,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a0d7c2f6-c489-4a08-85cc-1cfbb495e2d1','Y',100,2,2)
;

-- Nov 1, 2021, 4:48:59 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206777,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200300,214603,'Y',1,120,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 16:48:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 16:48:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cd9f1dcf-78d2-44cd-a3a4-aaf4fc18c9e7','Y',110,2,2)
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206777
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206776
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206773
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206774
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206775
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206768
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206769
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206770
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206771
;

-- Nov 1, 2021, 4:51:47 PM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206772
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206776
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206777
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206774
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206773
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206775
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206768
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206769
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206770
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206771
;

-- Nov 1, 2021, 4:52:30 PM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206772
;

-- Nov 1, 2021, 4:53:11 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 16:53:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206775
;

-- Nov 1, 2021, 4:53:23 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 16:53:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206769
;

-- Nov 1, 2021, 5:15:32 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214615,0,'Old Current Quantity','Old current quantity before the processing of M_CostDetail',200281,'OldQty',22,'N','N','Y','N','N',0,'N',29,0,0,'Y',TO_DATE('2021-11-01 17:15:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:15:31','YYYY-MM-DD HH24:MI:SS'),100,200014,'N','N','D','N','N','N','N','5c9ef964-d3e5-4a61-9cd6-895f762126d2','N',0,'N','N','N')
;

-- Nov 1, 2021, 5:17:54 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214616,0,'Delta Quantity','Quantity Difference',200281,'DeltaQty',22,'N','N','Y','N','N',0,'N',29,0,0,'Y',TO_DATE('2021-11-01 17:17:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:17:53','YYYY-MM-DD HH24:MI:SS'),100,2841,'N','N','D','N','N','N','N','a2d5db3f-036a-4298-b278-92a8c53cb566','N',0,'N','N','N')
;

-- Nov 1, 2021, 5:18:20 PM MYT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214617,0,'New Current Quantity','New current quantity after processing of M_CostDetail',200281,'NewQty',22,'N','N','Y','N','N',0,'N',29,0,0,'Y',TO_DATE('2021-11-01 17:18:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:18:20','YYYY-MM-DD HH24:MI:SS'),100,200010,'N','N','D','N','N','N','N','5a78568c-1fd7-44d2-9728-e1ecbbf67e1c','N',0,'N','N','N')
;

-- Nov 1, 2021, 5:18:26 PM MYT
ALTER TABLE M_StorageReservationLog ADD DeltaQty NUMBER NOT NULL
;

-- Nov 1, 2021, 5:18:26 PM MYT
ALTER TABLE M_StorageReservationLog ADD OldQty NUMBER NOT NULL
;

-- Nov 1, 2021, 5:18:26 PM MYT
ALTER TABLE M_StorageReservationLog ADD NewQty NUMBER NOT NULL
;

-- Nov 1, 2021, 5:19:07 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206778,'Old Current Quantity','Old current quantity before the processing of M_CostDetail',200300,214615,'Y',22,110,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:19:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:19:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6a5c24d5-7fd3-4a4c-957b-548d727d650a','Y',90,2)
;

-- Nov 1, 2021, 5:19:07 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206779,'Delta Quantity','Quantity Difference',200300,214616,'Y',22,120,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:19:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:19:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f121b0e5-a6ae-4167-b2a2-fd738bfe5511','Y',100,2)
;

-- Nov 1, 2021, 5:19:08 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206780,'New Current Quantity','New current quantity after processing of M_CostDetail',200300,214617,'Y',22,130,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:19:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:19:07','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','ad36dd22-4b57-4a2b-9239-6ca6031d6ac0','Y',110,2)
;

-- Nov 1, 2021, 5:20:34 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 17:20:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206779
;

-- Nov 1, 2021, 5:21:16 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206781,'Created','Date this record was created','The Created field indicates the date that this record was created.',200300,214599,'Y',0,140,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:15','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:15','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','78df208f-46d5-4932-8a45-8909197f4a6e','Y',120,4,1,1,'N','N','N','N')
;

-- Nov 1, 2021, 5:21:53 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206782,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200301,214597,'Y',10,10,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','cea0abcf-dd59-4fd2-a522-6d8e08a87cc1','N',2)
;

-- Nov 1, 2021, 5:21:54 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsAllowCopy,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206783,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200301,214598,'Y',10,20,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:53','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','0b691628-6a83-48da-8d92-3fa411960615','Y','Y',10,4,2)
;

-- Nov 1, 2021, 5:21:55 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206784,'Storage Reservation Log','Log for every storage reservation quantity change',200301,214604,'N',22,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','3a7adc82-5c27-4e2a-ad26-20c7882daf85','N',2)
;

-- Nov 1, 2021, 5:21:55 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,ColumnSpan) VALUES (206785,'M_StorageReservationLog_UU',200301,214605,'N',36,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d3008574-9e7d-4e50-9256-ee377b64ace2','N',2)
;

-- Nov 1, 2021, 5:21:56 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206786,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200301,214606,'Y',22,30,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:55','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','758c0a72-13d7-484e-b492-cf77258d54c4','Y',20,2)
;

-- Nov 1, 2021, 5:21:57 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206787,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200301,214607,'Y',30,40,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:56','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','4ea111e5-61b2-45b0-b86d-e5548f0b46dc','Y',30,2)
;

-- Nov 1, 2021, 5:21:57 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206788,'Line','Line No',200301,214608,'Y',10,50,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d039e960-dcbb-4292-a56b-6f29db2dda1d','Y',40,2)
;

-- Nov 1, 2021, 5:21:58 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206789,'Table','Database Table information','The Database Table provides the information of the table definition',200301,214609,'Y',10,60,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','d072f339-a9e4-46c5-80d2-5d5ea91b920e','Y',50,2)
;

-- Nov 1, 2021, 5:21:58 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206790,'Record ID','Direct internal record ID','The Record ID is the internal unique identifier of a record. Please note that zooming to the record may not be successful for Orders, Invoices and Shipment/Receipts as sometimes the Sales Order type is not known.',200301,214610,'Y',22,70,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','1203eef6-72a0-412b-993a-6e1e3fc0afad','Y',60,2,2)
;

-- Nov 1, 2021, 5:21:59 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206791,'Warehouse','Storage Warehouse and Service Point','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.',200301,214611,'Y',22,80,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:58','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','a7984a15-e90e-483b-8f35-42a8fbe96654','Y',70,2)
;

-- Nov 1, 2021, 5:22:00 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206792,'Product','Product, Service, Item','Identifies an item which is either purchased or sold in this organization.',200301,214612,'Y',22,90,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:21:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:21:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','eb925639-547e-4466-89a8-79e4860ff869','Y',80,2)
;

-- Nov 1, 2021, 5:22:00 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206793,'Attribute Set Instance','Product Attribute Set Instance','The values of the actual Product Attribute Instances.  The product level attributes are defined on Product level.',200301,214613,'Y',22,100,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:22:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:22:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','af39f813-002b-47f2-b15a-28d765ea8b7e','Y',90,2)
;

-- Nov 1, 2021, 5:22:01 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206794,'Sales Transaction','This is a Sales Transaction','The Sales Transaction checkbox indicates if this item is a Sales Transaction.',200301,214614,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:22:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:22:00','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','df2b0ba6-a82c-4417-91d1-3197a99df373','Y',100,2,2)
;

-- Nov 1, 2021, 5:22:01 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206795,'Old Current Quantity','Old current quantity before the processing of M_CostDetail',200301,214615,'Y',22,120,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:22:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:22:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7a26455b-ab68-4ad3-a498-362faca6ccd6','Y',110,2)
;

-- Nov 1, 2021, 5:22:02 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206796,'Delta Quantity','Quantity Difference',200301,214616,'Y',22,130,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:22:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:22:01','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5adc3f0f-0a9e-48eb-a372-5f6b68d22a29','Y',120,2)
;

-- Nov 1, 2021, 5:22:03 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206797,'New Current Quantity','New current quantity after processing of M_CostDetail',200301,214617,'Y',22,140,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:22:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:22:02','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','78a1d6f4-e4b0-4c3d-a406-af7e4cb2a0f0','Y',130,2)
;

-- Nov 1, 2021, 5:22:03 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206798,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200301,214603,'Y',1,150,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:22:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:22:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','da3db381-f5ed-41ef-be4f-4525dfe35681','Y',140,2,2)
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206798
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206794
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206791
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206792
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206793
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206786
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206787
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206788
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206789
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206790
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206795
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206796
;

-- Nov 1, 2021, 5:22:54 PM MYT
UPDATE AD_Field SET SeqNo=130,IsDisplayed='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206797
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206792
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206794
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206798
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206791
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206793
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206786
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206787
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206788
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206789
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206790
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206795
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206796
;

-- Nov 1, 2021, 5:23:15 PM MYT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=getDate(), UpdatedBy=100 WHERE AD_Field_ID=206797
;

-- Nov 1, 2021, 5:25:03 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 17:25:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206793
;

-- Nov 1, 2021, 5:25:32 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 17:25:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206787
;

-- Nov 1, 2021, 5:25:53 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 17:25:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206772
;

-- Nov 1, 2021, 5:26:05 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 17:26:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206790
;

-- Nov 1, 2021, 5:26:22 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 17:26:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206796
;

-- Nov 1, 2021, 5:29:15 PM MYT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-11-01 17:29:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206781
;

-- Nov 1, 2021, 5:29:30 PM MYT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField,IsQuickForm) VALUES (206799,'Created','Date this record was created','The Created field indicates the date that this record was created.',200301,214599,'Y',0,140,0,'N','N','N','N',0,0,'Y',TO_DATE('2021-11-01 17:29:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-01 17:29:29','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','103b328e-10d8-4712-9250-1405d7c8361b','Y',120,4,2,2,'N','N','N','N')
;

-- Nov 1, 2021, 5:31:03 PM MYT
UPDATE AD_Tab SET OrderByClause='M_StorageReservationLog.M_Warehouse_ID, M_StorageReservationLog.M_AttributeSetInstance_ID, M_StorageReservationLog.M_StorageReservationLog_ID Desc',Updated=TO_DATE('2021-11-01 17:31:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200301
;

-- Nov 1, 2021, 6:17:44 PM MYT
UPDATE AD_Tab SET OrderByClause='M_StorageReservationLog.M_Warehouse_ID, M_StorageReservationLog.M_AttributeSetInstance_ID, M_StorageReservationLog.M_StorageReservationLog_ID Desc',Updated=TO_DATE('2021-11-01 18:17:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200300
;

-- Nov 2, 2021, 9:31:23 PM MYT
UPDATE AD_Column SET FieldLength=255,Updated=TO_DATE('2021-11-02 21:31:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214607
;

-- Nov 2, 2021, 9:31:28 PM MYT
ALTER TABLE M_StorageReservationLog MODIFY DocumentNo VARCHAR2(255 CHAR) DEFAULT NULL 
;

SELECT register_migration_script('202111020750_IDEMPIERE-5021.sql') FROM dual
;

