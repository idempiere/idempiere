-- IDEMPIERE-1963
SELECT register_migration_script('202207131220_IDEMPIERE-1963.sql') FROM dual;

-- Jun 5, 2014 12:06:49 PM CEST
-- IDEMPIERE-1963 Migrate Special form Generate Shipmnets manual to Info Window
INSERT INTO AD_Table (DatabaseViewDrop,ImportTable,CopyColumnsFromTable,LoadSeq,Created,IsView,EntityType,Name,IsActive,CreatedBy,UpdatedBy,Processing,IsSecurityEnabled,AccessLevel,IsHighVolume,IsChangeLog,ReplicationType,AD_Table_UU,IsCentrallyMaintained,IsDeleteable,TableName,Description,AD_Org_ID,Updated,AD_Client_ID,AD_Table_ID) VALUES ('N','N','N',0,TO_TIMESTAMP('2014-06-05 12:06:47','YYYY-MM-DD HH24:MI:SS'),'Y','D','Generate Shipments (manual)','Y',100,100,'N','N','3','N','N','L','f6074243-cdc6-44b2-98a6-676ab245e5f9','Y','N','RV_GenerateShipmetns_Manual','SQL View used in Info Window Generate Shipments (manual)',0,TO_TIMESTAMP('2014-06-05 12:06:47','YYYY-MM-DD HH24:MI:SS'),0,200131)
;

-- Jun 5, 2014 12:06:50 PM CEST
INSERT INTO AD_Sequence (StartNewYear,Created,IsAutoSequence,UpdatedBy,StartNo,CurrentNextSys,IsTableID,CurrentNext,IsAudited,AD_Sequence_ID,Description,IncrementNo,AD_Sequence_UU,Name,AD_Org_ID,CreatedBy,Updated,IsActive,AD_Client_ID) VALUES ('N',TO_TIMESTAMP('2014-06-05 12:06:49','YYYY-MM-DD HH24:MI:SS'),'Y',100,1000000,200000,'Y',1000000,'N',200178,'Table RV_GenerateShipmetns_Manual',1,'2e8bc0db-c25f-4628-8854-343d7d15ef8c','RV_GenerateShipmetns_Manual',0,100,TO_TIMESTAMP('2014-06-05 12:06:49','YYYY-MM-DD HH24:MI:SS'),'Y',0)
;

-- Jun 5, 2014 12:07:07 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,DefaultValue,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (102,19,129,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:07','YYYY-MM-DD HH24:MI:SS'),'D','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.','Client',TO_TIMESTAMP('2014-06-05 12:07:07','YYYY-MM-DD HH24:MI:SS'),'@#AD_Client_ID@','N','Y',0.0,200131,'N','N','N','N',10,'N','aef7442b-9240-4e67-b737-a4661cd38e4c','N','AD_Client_ID','Client/Tenant for this installation.',100,100,211278,'N')
;

-- Jun 5, 2014 12:07:08 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,DefaultValue,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (113,19,104,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:07','YYYY-MM-DD HH24:MI:SS'),'D','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','Organization',TO_TIMESTAMP('2014-06-05 12:07:07','YYYY-MM-DD HH24:MI:SS'),'@#AD_Org_ID@','N','Y',0.0,200131,'N','N','N','N',10,'N','c797f36a-c8cb-4c6f-9775-91de32a840c5','N','AD_Org_ID','Organizational entity within client',100,100,211279,'N')
;

-- Jun 5, 2014 12:07:08 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,DefaultValue,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (245,16,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:08','YYYY-MM-DD HH24:MI:SS'),'D','The Created field indicates the date that this record was created.','Created',TO_TIMESTAMP('2014-06-05 12:07:08','YYYY-MM-DD HH24:MI:SS'),'SYSDATE','N','Y',0.0,200131,'N','N','N','N',29,'N','b37345ad-a2ff-4ee7-8145-648789c57492','N','Created','Date this record was created',100,100,211280,'N')
;

-- Jun 5, 2014 12:07:09 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,DefaultValue,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (607,16,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:08','YYYY-MM-DD HH24:MI:SS'),'D','The Updated field indicates the date that this record was updated.','Updated',TO_TIMESTAMP('2014-06-05 12:07:08','YYYY-MM-DD HH24:MI:SS'),'SYSDATE','N','Y',0.0,200131,'N','N','N','N',29,'N','1ae52cd1-9105-46c2-816e-0851ba3f16f0','N','Updated','Date this record was updated',100,100,211281,'N')
;

-- Jun 5, 2014 12:07:09 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,DefaultValue,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (348,20,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:09','YYYY-MM-DD HH24:MI:SS'),'D','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.','Active',TO_TIMESTAMP('2014-06-05 12:07:09','YYYY-MM-DD HH24:MI:SS'),'Y','N','Y',0.0,200131,'N','N','N','N',1,'N','3a073895-b8d5-42ac-90a1-d9e02313f296','N','IsActive','The record is active in the system',100,100,211282,'N')
;

-- Jun 5, 2014 12:07:10 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (459,19,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:09','YYYY-MM-DD HH24:MI:SS'),'D','The Warehouse identifies a unique Warehouse where products are stored or Services are provided.','Warehouse',TO_TIMESTAMP('2014-06-05 12:07:09','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',131089,'N','ff94221f-c7c0-459a-9a56-cbef659cb8ad','N','M_Warehouse_ID','Storage Warehouse and Service Point',100,100,211283,'N')
;

-- Jun 5, 2014 12:07:10 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (187,30,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:10','YYYY-MM-DD HH24:MI:SS'),'D','A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','Business Partner ',TO_TIMESTAMP('2014-06-05 12:07:10','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',10,'N','283b5f15-dd59-4e8e-9f87-5e642952c836','N','C_BPartner_ID','Identifies a Business Partner',100,100,211284,'N')
;

-- Jun 5, 2014 12:07:11 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,FKConstraintType,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (558,30,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:10','YYYY-MM-DD HH24:MI:SS'),'D','The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','Order',TO_TIMESTAMP('2014-06-05 12:07:10','YYYY-MM-DD HH24:MI:SS'),'N','N','Y',0.0,200131,'N','N','N','N',10,'N','dc0c9133-69bf-4da0-94d3-8c2ea3cd5b0e','N','C_Order_ID','Order',100,100,211285,'N')
;

-- Jun 5, 2014 12:07:12 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (1025,30,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:11','YYYY-MM-DD HH24:MI:SS'),'D','The Material Shipment / Receipt ','Shipment/Receipt',TO_TIMESTAMP('2014-06-05 12:07:11','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',131089,'N','d731ba7e-a330-4729-b9c9-8d59fb3e3d27','N','M_InOut_ID','Material Shipment Document',100,100,211286,'N')
;

-- Jun 5, 2014 12:07:13 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (196,19,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:12','YYYY-MM-DD HH24:MI:SS'),'D','The Document Type determines document sequence and processing rules','Document Type',TO_TIMESTAMP('2014-06-05 12:07:12','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',10,'N','3d978f6a-858c-4ec5-8405-0b6db74848f3','N','C_DocType_ID','Document type or rules',100,100,211287,'N')
;

-- Jun 5, 2014 12:07:13 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (290,10,0,0,'Y',TO_TIMESTAMP('2014-06-05 12:07:13','YYYY-MM-DD HH24:MI:SS'),'D','The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','Document No',TO_TIMESTAMP('2014-06-05 12:07:13','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',30,'N','65aadb81-0c55-4ee5-8d45-c5b0593d9b42','N','DocumentNo','Document sequence number of the document',100,100,211288,'N')
;

-- Jun 5, 2014 12:07:14 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (268,16,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:13','YYYY-MM-DD HH24:MI:SS'),'D','Indicates the Date an item was ordered.','Date Ordered',TO_TIMESTAMP('2014-06-05 12:07:13','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',29,'N','c7941a1d-0216-4b09-aa35-96cc29c9ad1b','N','DateOrdered','Date of Order',100,100,211289,'N')
;

-- Jun 5, 2014 12:07:14 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Help,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,Description,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (598,12,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:14','YYYY-MM-DD HH24:MI:SS'),'D','The Total amount displays the total of all lines in document currency','Total Lines',TO_TIMESTAMP('2014-06-05 12:07:14','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',131089,'N','d3f12bfd-0d2e-4e38-bd25-f0d10efc6c45','N','TotalLines','Total of all document lines',100,100,211290,'N')
;

-- Jun 5, 2014 12:07:14 PM CEST
INSERT INTO AD_Element (Created,Updated,EntityType,AD_Client_ID,ColumnName,Name,PrintName,AD_Element_UU,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Element_ID) VALUES (TO_TIMESTAMP('2014-06-05 12:07:14','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-06-05 12:07:14','YYYY-MM-DD HH24:MI:SS'),'D',0,'doctype','doctype','doctype','afbc8890-626e-4273-9d11-e78418bba7b3',0,100,100,'Y',202717)
;

-- Jun 5, 2014 12:07:15 PM CEST
INSERT INTO AD_Column (AD_Element_ID,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsSelectionColumn,Updated,EntityType,Name,Created,IsEncrypted,IsActive,Version,AD_Table_ID,IsMandatory,IsTranslated,IsIdentifier,IsParent,FieldLength,IsKey,AD_Column_UU,IsUpdateable,ColumnName,CreatedBy,UpdatedBy,AD_Column_ID,IsAlwaysUpdateable) VALUES (202717,14,0,0,'N',TO_TIMESTAMP('2014-06-05 12:07:14','YYYY-MM-DD HH24:MI:SS'),'D','doctype',TO_TIMESTAMP('2014-06-05 12:07:14','YYYY-MM-DD HH24:MI:SS'),'N','Y',0.0,200131,'N','N','N','N',2147483647,'N','bc63db78-242b-4275-ba18-0ca36e75bc86','N','doctype',100,100,211291,'N')
;

-- Jun 5, 2014 12:07:40 PM CEST
INSERT INTO AD_InfoWindow (IsDefault,AD_Table_ID,Created,Updated,SeqNo,IsShowInDashboard,MaxQueryRecords,EntityType,Name,IsDistinct,FromClause,Processing,AD_InfoWindow_UU,Description,IsValid,AD_Org_ID,UpdatedBy,CreatedBy,IsActive,AD_Client_ID,AD_InfoWindow_ID) VALUES ('N',200131,TO_TIMESTAMP('2014-06-05 12:07:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2014-06-05 12:07:39','YYYY-MM-DD HH24:MI:SS'),20,'Y',0,'D','Generate Shipments (manual)','N','RV_GenerateShipmetns_Manual a','N','240e290d-77ce-40bb-8f27-a9cfd46746d3','Select and generate shipments','N',0,100,100,'Y',0,200008)
;

-- Jun 5, 2014 12:08:08 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',113,'a.AD_Org_ID',TO_TIMESTAMP('2014-06-05 12:08:08','YYYY-MM-DD HH24:MI:SS'),'D','Organizational entity within client',100,100,'Organization',0,'N',10,'An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.','a401b5af-e5b2-405e-a22f-5f2e042ad69c',19,200116,'N',104,'Y','AD_Org_ID',TO_TIMESTAMP('2014-06-05 12:08:08','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:09:35 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'N','Y',459,'a.M_Warehouse_ID',TO_TIMESTAMP('2014-06-05 12:09:23','YYYY-MM-DD HH24:MI:SS'),'D','Storage Warehouse and Service Point',100,100,'Warehouse','=',0,'N',20,'The Warehouse identifies a unique Warehouse where products are stored or Services are provided.','5594ac73-41a1-42ad-a845-d12509ce248a',19,200117,'Y','Y','M_Warehouse_ID',TO_TIMESTAMP('2014-06-05 12:09:23','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:09:58 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',196,'a.C_DocType_ID',TO_TIMESTAMP('2014-06-05 12:09:57','YYYY-MM-DD HH24:MI:SS'),'D','Document type or rules',100,100,'Document Type',0,'N',30,'The Document Type determines document sequence and processing rules','c68d83d2-fdbb-4a8a-85ca-4ba8181a90c8',19,200118,'N','Y','C_DocType_ID',TO_TIMESTAMP('2014-06-05 12:09:57','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:10:43 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,QueryFunction,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',290,'a.DocumentNo',TO_TIMESTAMP('2014-06-05 12:10:42','YYYY-MM-DD HH24:MI:SS'),'D','Document sequence number of the document',100,100,'Document No','Like',0,'N',40,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','1a06bf7a-14ec-4534-8a8b-a873df866060',10,200119,'Y','Y','Upper','DocumentNo',TO_TIMESTAMP('2014-06-05 12:10:42','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:10:51 PM CEST
UPDATE AD_InfoColumn SET IsQueryCriteria='N',Updated=TO_TIMESTAMP('2014-06-05 12:10:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200119
;

-- Jun 5, 2014 12:11:17 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',187,'a.C_BPartner_ID',TO_TIMESTAMP('2014-06-05 12:11:17','YYYY-MM-DD HH24:MI:SS'),'D','Identifies a Business Partner',100,100,'Business Partner ','=',0,'N',50,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','4f5efb70-0cd5-40bb-a5b8-8229ce7e7f1d',30,200120,'Y','Y','C_BPartner_ID',TO_TIMESTAMP('2014-06-05 12:11:17','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Element SET ColumnName='DocType', Name='Document Type', PrintName='Document Type',Updated=TO_TIMESTAMP('2014-06-05 12:12:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202717
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Column SET ColumnName='DocType', Name='Document Type', Description=NULL, Help=NULL WHERE AD_Element_ID=202717
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Process_Para SET ColumnName='DocType', Name='Document Type', Description=NULL, Help=NULL, AD_Element_ID=202717 WHERE UPPER(ColumnName)='DOCTYPE' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Process_Para SET ColumnName='DocType', Name='Document Type', Description=NULL, Help=NULL WHERE AD_Element_ID=202717 AND IsCentrallyMaintained='Y'
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DocType', Name='Document Type', Description=NULL, Help=NULL WHERE AD_Element_ID=202717 AND IsCentrallyMaintained='Y'
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_Field SET Name='Document Type', Description=NULL, Help=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202717) AND IsCentrallyMaintained='Y'
;

-- Jun 5, 2014 12:12:38 PM CEST
UPDATE AD_PrintFormatItem SET PrintName='Document Type', Name='Document Type' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=202717)
;

-- Jun 5, 2014 12:13:22 PM CEST
UPDATE C_AcctProcessor SET DateLastRun=TO_TIMESTAMP('2014-06-05 12:13:22','YYYY-MM-DD HH24:MI:SS'), DateNextRun=TO_TIMESTAMP('2014-06-05 12:23:22','YYYY-MM-DD HH24:MI:SS'),Updated=TO_TIMESTAMP('2014-06-05 12:13:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_AcctProcessor_ID=100
;

-- Jun 5, 2014 12:13:37 PM CEST
INSERT INTO AD_Reference (AD_Org_ID,Created,EntityType,IsActive,IsOrderByValue,AD_Reference_ID,ValidationType,Name,CreatedBy,Updated,UpdatedBy,AD_Reference_UU,AD_Client_ID) VALUES (0,TO_TIMESTAMP('2014-06-05 12:13:35','YYYY-MM-DD HH24:MI:SS'),'D','Y','N',200085,'L','DocType Generate Shipments (manual)',100,TO_TIMESTAMP('2014-06-05 12:13:35','YYYY-MM-DD HH24:MI:SS'),100,'3be7b948-8b9e-490c-849c-df25ea642a23',0)
;

-- Jun 5, 2014 12:13:46 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_Reference_Value_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,200085,'N','Y',202717,'a.doctype',TO_TIMESTAMP('2014-06-05 12:13:46','YYYY-MM-DD HH24:MI:SS'),'D',100,100,'Document Type','=',0,'N',60,'7502653b-55ef-4384-90b3-dcd224533968',17,200121,'Y','Y','doctype',TO_TIMESTAMP('2014-06-05 12:13:46','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:14:06 PM CEST
INSERT INTO AD_Ref_List (AD_Org_ID,EntityType,Updated,UpdatedBy,AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,IsActive,AD_Client_ID) VALUES (0,'D',TO_TIMESTAMP('2014-06-05 12:14:05','YYYY-MM-DD HH24:MI:SS'),100,200190,200085,'Order','aba7bebd-533e-4c9b-94d0-0a3a014b8335','Order',TO_TIMESTAMP('2014-06-05 12:14:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Jun 5, 2014 12:14:21 PM CEST
INSERT INTO AD_Ref_List (AD_Org_ID,EntityType,Updated,UpdatedBy,AD_Ref_List_ID,AD_Reference_ID,Name,AD_Ref_List_UU,Value,Created,CreatedBy,IsActive,AD_Client_ID) VALUES (0,'D',TO_TIMESTAMP('2014-06-05 12:14:20','YYYY-MM-DD HH24:MI:SS'),100,200191,200085,'Vendor RMA','0390303f-bfa0-4207-93b1-750461733fab','VendorRMA',TO_TIMESTAMP('2014-06-05 12:14:20','YYYY-MM-DD HH24:MI:SS'),100,'Y',0)
;

-- Jun 5, 2014 12:14:45 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,QueryOperator,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,QueryFunction,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',268,'a.DateOrdered',TO_TIMESTAMP('2014-06-05 12:14:44','YYYY-MM-DD HH24:MI:SS'),'D','Date of Order',100,100,'Date Ordered','=',0,'N',70,'Indicates the Date an item was ordered.','f28fce81-2286-4324-8e64-3c9681de7043',15,200122,'N','Y','Trunc','DateOrdered',TO_TIMESTAMP('2014-06-05 12:14:44','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:14:59 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,IsDisplayed,IsActive,AD_Element_ID,SelectClause,Created,EntityType,Description,CreatedBy,UpdatedBy,Name,SeqNoSelection,IsIdentifier,SeqNo,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,IsCentrallyMaintained,ColumnName,Updated,AD_Org_ID,AD_Client_ID) VALUES (200008,'Y','Y',598,'a.TotalLines',TO_TIMESTAMP('2014-06-05 12:14:58','YYYY-MM-DD HH24:MI:SS'),'D','Total of all document lines',100,100,'Total Lines',0,'N',80,'The Total amount displays the total of all lines in document currency','1717aefd-5cea-4190-941e-92ba92986e71',12,200123,'N','Y','TotalLines',TO_TIMESTAMP('2014-06-05 12:14:58','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:20:20 PM CEST
INSERT INTO AD_Menu (EntityType,Created,UpdatedBy,IsSummary,AD_Menu_ID,IsReadOnly,IsCentrallyMaintained,Name,Description,AD_Menu_UU,"action",AD_InfoWindow_ID,IsSOTrx,IsActive,CreatedBy,Updated,AD_Client_ID,AD_Org_ID) VALUES ('D',TO_TIMESTAMP('2014-06-05 12:20:20','YYYY-MM-DD HH24:MI:SS'),100,'N',200081,'N','Y','Generate Shipments (manual)','Select and generate shipments Info Window','ada6b5a5-767c-4243-9f8b-c49c36263072','I',200008,'N','Y',100,TO_TIMESTAMP('2014-06-05 12:20:20','YYYY-MM-DD HH24:MI:SS'),0,0)
;

-- Jun 5, 2014 12:20:20 PM CEST
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', statement_timestamp(), 100, statement_timestamp(), 100,t.AD_Tree_ID, 200081, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200081)
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=346
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53132
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200081
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=193
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=180
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=494
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200031
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200030
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200034
;

-- Jun 5, 2014 12:20:30 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=444
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=0, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=346
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=1, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200081
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=2, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=53132
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=3, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=193
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=4, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=180
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=5, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=494
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=6, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200031
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=7, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200030
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=8, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=200034
;

-- Jun 5, 2014 12:20:33 PM CEST
UPDATE AD_TreeNodeMM SET Parent_ID=459, SeqNo=9, Updated=statement_timestamp() WHERE AD_Tree_ID=10 AND Node_ID=444
;

-- Jun 5, 2014 12:21:50 PM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2014-06-05 12:21:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200008
;

-- Jun 5, 2014 12:27:38 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='Order',Updated=TO_TIMESTAMP('2014-06-05 12:27:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200121
;

-- Jul 13, 2022, 12:20:15 PM CEST
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,FromClause,IsUnionAll) VALUES (0,0,200217,'273dd707-98f4-4d51-addf-189f7ac1c8b6',TO_TIMESTAMP('2022-07-13 12:20:15','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RV_GenerateShipmetns_Manual-010',TO_TIMESTAMP('2022-07-13 12:20:15','YYYY-MM-DD HH24:MI:SS'),100,200131,10,'FROM m_inout_candidate_v ic
JOIN c_order o ON ic.c_order_id = o.c_order_id','Y')
;

-- Jul 13, 2022, 12:23:12 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217326,'a7b4ca83-35a5-43d2-8085-af42fe19a9e5',TO_TIMESTAMP('2022-07-13 12:23:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:23:12','YYYY-MM-DD HH24:MI:SS'),100,200217,'AD_Client_ID','ic.ad_client_id',10)
;

-- Jul 13, 2022, 12:23:38 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217327,'b3580aa8-abcf-45f5-a8b9-272950e07a6e',TO_TIMESTAMP('2022-07-13 12:23:38','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:23:38','YYYY-MM-DD HH24:MI:SS'),100,200217,'AD_Org_ID','ic.ad_org_id',20)
;

-- Jul 13, 2022, 12:23:54 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217328,'4f0fcda4-f13a-4974-96df-24c67de224d3',TO_TIMESTAMP('2022-07-13 12:23:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:23:54','YYYY-MM-DD HH24:MI:SS'),100,200217,'Created','o.created',30)
;

-- Jul 13, 2022, 12:24:04 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217329,'5c226755-196d-437f-9b7e-598d1cce188c',TO_TIMESTAMP('2022-07-13 12:24:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:24:04','YYYY-MM-DD HH24:MI:SS'),100,200217,'Updated','o.updated',40)
;

-- Jul 13, 2022, 12:24:20 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217330,'3782e174-2615-4cd6-aed0-c9d8c1152cb0',TO_TIMESTAMP('2022-07-13 12:24:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:24:19','YYYY-MM-DD HH24:MI:SS'),100,200217,'IsActive','o.isactive',50)
;

-- Jul 13, 2022, 12:24:37 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217331,'6096bda9-c463-4125-a9db-d7eb9c1bbd97',TO_TIMESTAMP('2022-07-13 12:24:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:24:37','YYYY-MM-DD HH24:MI:SS'),100,200217,'M_Warehouse_ID','ic.m_warehouse_id',60)
;

-- Jul 13, 2022, 12:24:56 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217332,'30fd9140-1283-42de-8b6a-f7a232b71986',TO_TIMESTAMP('2022-07-13 12:24:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:24:56','YYYY-MM-DD HH24:MI:SS'),100,200217,'C_BPartner_ID','ic.c_bpartner_id',70)
;

-- Jul 13, 2022, 12:25:28 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217333,'2f87bbf3-2bd2-466b-bb72-cd6e944a85d0',TO_TIMESTAMP('2022-07-13 12:25:28','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:25:28','YYYY-MM-DD HH24:MI:SS'),100,200217,'C_Order_ID','ic.c_order_id',80)
;

-- Jul 13, 2022, 12:25:52 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217334,'d78e0801-d3a5-46d6-a40f-381e728305d9',TO_TIMESTAMP('2022-07-13 12:25:52','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:25:52','YYYY-MM-DD HH24:MI:SS'),100,200217,'M_InOut_ID','NULL::numeric',90)
;

-- Jul 13, 2022, 12:26:11 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217335,'53468289-b0f8-4400-a515-06cd2b9a8b0d',TO_TIMESTAMP('2022-07-13 12:26:11','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:26:11','YYYY-MM-DD HH24:MI:SS'),100,200217,'C_DocType_ID','ic.c_doctype_id',100)
;

-- Jul 13, 2022, 12:26:40 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217336,'97a3f51c-3738-4e29-a751-c17da6e1f911',TO_TIMESTAMP('2022-07-13 12:26:40','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:26:40','YYYY-MM-DD HH24:MI:SS'),100,200217,'DocumentNo','ic.documentno',110)
;

-- Jul 13, 2022, 12:27:00 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217337,'ed8771e4-17eb-4d56-aa01-6c5f9f26df55',TO_TIMESTAMP('2022-07-13 12:27:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:27:00','YYYY-MM-DD HH24:MI:SS'),100,200217,'DateOrdered','ic.dateordered',120)
;

-- Jul 13, 2022, 12:27:19 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217338,'309efaa7-0d5e-4b8d-936b-18b9fe146c66',TO_TIMESTAMP('2022-07-13 12:27:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:27:19','YYYY-MM-DD HH24:MI:SS'),100,200217,'TotalLines','ic.totallines',130)
;

-- Jul 13, 2022, 12:27:55 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217339,'14e2b05f-6fc2-48ba-ae21-5437ff8d5216',TO_TIMESTAMP('2022-07-13 12:27:54','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:27:54','YYYY-MM-DD HH24:MI:SS'),100,200217,'DocType','''Order''::text',140)
;

-- Jul 13, 2022, 12:29:13 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217340,'0bd259fd-c85f-4a4b-9a75-a055d992fed8',TO_TIMESTAMP('2022-07-13 12:29:12','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:29:12','YYYY-MM-DD HH24:MI:SS'),100,200217,'RV_GenerateShipmetns_Manual_ID','ic.c_order_id',150)
;

-- Jul 13, 2022, 12:36:05 PM CEST
INSERT INTO AD_ViewComponent (AD_Client_ID,AD_Org_ID,AD_ViewComponent_ID,AD_ViewComponent_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Table_ID,SeqNo,WhereClause,FromClause,IsUnionAll) VALUES (0,0,200218,'cfd8b407-d282-4e93-9b31-fc8a7395bf5f',TO_TIMESTAMP('2022-07-13 12:36:04','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','RV_GenerateShipmetns_Manual-020',TO_TIMESTAMP('2022-07-13 12:36:04','YYYY-MM-DD HH24:MI:SS'),100,200131,20,'WHERE rma.docstatus = "CO"::bpchar AND dt.docbasetype = "POO"::bpchar AND (EXISTS ( SELECT 1
         FROM m_rma r
    JOIN m_rmaline rl ON r.m_rma_id = rl.m_rma_id
   WHERE r.m_rma_id = rma.m_rma_id AND rl.isactive = "Y"::bpchar AND rl.m_inoutline_id > 0::numeric AND rl.qtydelivered < rl.qty)) AND NOT (EXISTS ( SELECT 1
         FROM m_inout oio
        WHERE oio.m_rma_id = rma.m_rma_id AND (oio.docstatus = ANY (ARRAY["IP"::bpchar, "CO"::bpchar, "CL"::bpchar]))))','FROM m_rma rma
JOIN m_inout io ON rma.inout_id = io.m_inout_id
JOIN c_doctype dt ON io.c_doctype_id = dt.c_doctype_id','Y')
;

-- Jul 13, 2022, 12:37:20 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217341,'dc0335c6-e6a0-4192-b58e-a3a9890df777',TO_TIMESTAMP('2022-07-13 12:37:20','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:37:20','YYYY-MM-DD HH24:MI:SS'),100,200218,'AD_Client_ID','rma.ad_client_id',10)
;

-- Jul 13, 2022, 12:37:46 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217342,'7769359f-1c54-4e6a-9b05-920d5469d022',TO_TIMESTAMP('2022-07-13 12:37:46','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:37:46','YYYY-MM-DD HH24:MI:SS'),100,200218,'AD_Org_ID','rma.ad_org_id',20)
;

-- Jul 13, 2022, 12:37:58 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217343,'2c58adb9-9f1f-4c9b-84c9-67e40aafe3bc',TO_TIMESTAMP('2022-07-13 12:37:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:37:58','YYYY-MM-DD HH24:MI:SS'),100,200218,'Created','io.created',30)
;

-- Jul 13, 2022, 12:38:09 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217344,'5b42964f-23ae-4673-8e47-b034c892e55f',TO_TIMESTAMP('2022-07-13 12:38:08','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:38:08','YYYY-MM-DD HH24:MI:SS'),100,200218,'Updated','io.updated',40)
;

-- Jul 13, 2022, 12:38:22 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217345,'3acbe984-70be-44ec-b116-f30dd9f8add1',TO_TIMESTAMP('2022-07-13 12:38:22','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:38:22','YYYY-MM-DD HH24:MI:SS'),100,200218,'IsActive','io.isactive',50)
;

-- Jul 13, 2022, 12:38:44 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217346,'6cbbee20-ba07-4d4a-a2ff-a6eaee53d034',TO_TIMESTAMP('2022-07-13 12:38:44','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:38:44','YYYY-MM-DD HH24:MI:SS'),100,200218,'M_Warehouse_ID','NULL::numeric',60)
;

-- Jul 13, 2022, 12:39:01 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217347,'d7ae92c7-743e-4ab2-9ad3-08a6138cafd4',TO_TIMESTAMP('2022-07-13 12:39:00','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:39:00','YYYY-MM-DD HH24:MI:SS'),100,200218,'C_BPartner_ID','rma.c_bpartner_id',70)
;

-- Jul 13, 2022, 12:39:17 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217348,'869d160d-12ff-4301-95a7-2cb66072972e',TO_TIMESTAMP('2022-07-13 12:39:17','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:39:17','YYYY-MM-DD HH24:MI:SS'),100,200218,'C_Order_ID','rma.c_order_id',80)
;

-- Jul 13, 2022, 12:39:36 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217349,'f6baf35e-c1e0-4775-9db6-0b4909a2b7de',TO_TIMESTAMP('2022-07-13 12:39:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:39:36','YYYY-MM-DD HH24:MI:SS'),100,200218,'InOut_ID','rma.inout_id',90)
;

-- Jul 13, 2022, 12:39:50 PM CEST
UPDATE AD_ViewColumn SET ColumnName='M_InOut_ID',Updated=TO_TIMESTAMP('2022-07-13 12:39:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ViewColumn_ID=217349
;

-- Jul 13, 2022, 12:40:25 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217350,'aafdcdb6-05c6-4bd4-8398-9cbf2bed295a',TO_TIMESTAMP('2022-07-13 12:40:25','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:40:25','YYYY-MM-DD HH24:MI:SS'),100,200218,'C_DocType_ID','rma.c_doctype_id',100)
;

-- Jul 13, 2022, 12:40:40 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217351,'690bdd95-eaf9-436c-a4b5-077642692206',TO_TIMESTAMP('2022-07-13 12:40:39','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:40:39','YYYY-MM-DD HH24:MI:SS'),100,200218,'DocumentNo','rma.documentno',110)
;

-- Jul 13, 2022, 12:40:56 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217352,'bb5067f9-6b4b-4ab2-99e4-69d8df2e81ad',TO_TIMESTAMP('2022-07-13 12:40:56','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:40:56','YYYY-MM-DD HH24:MI:SS'),100,200218,'DateOrdered','io.dateordered',120)
;

-- Jul 13, 2022, 12:41:13 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217353,'0a4a1f6e-72a2-4ee3-9c47-c561ca0e4636',TO_TIMESTAMP('2022-07-13 12:41:13','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:41:13','YYYY-MM-DD HH24:MI:SS'),100,200218,'TotalLines','0',130)
;

-- Jul 13, 2022, 12:41:36 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217354,'3cfbf6fd-00c2-4c86-be61-11455fa8e55e',TO_TIMESTAMP('2022-07-13 12:41:36','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:41:36','YYYY-MM-DD HH24:MI:SS'),100,200218,'DocType','''VendorRMA''::text',140)
;

-- Jul 13, 2022, 12:42:18 PM CEST
INSERT INTO AD_ViewColumn (AD_Client_ID,AD_Org_ID,AD_ViewColumn_ID,AD_ViewColumn_UU,Created,CreatedBy,EntityType,IsActive,Updated,UpdatedBy,AD_ViewComponent_ID,ColumnName,ColumnSQL,SeqNo) VALUES (0,0,217355,'34cca232-b69d-4f83-8aa6-b0bb2f9a5fc4',TO_TIMESTAMP('2022-07-13 12:42:18','YYYY-MM-DD HH24:MI:SS'),100,'D','Y',TO_TIMESTAMP('2022-07-13 12:42:18','YYYY-MM-DD HH24:MI:SS'),100,200218,'RV_GenerateShipmetns_Manual_ID','rma.inout_id',150)
;

-- Jul 13, 2022, 1:49:11 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203627,0,0,'Y',TO_TIMESTAMP('2022-07-13 13:49:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-13 13:49:11','YYYY-MM-DD HH24:MI:SS'),100,'RV_GenerateShipmetns_Manual_ID','RV_GenerateShipmetns_Manual_ID','RV_GenerateShipmetns_Manual_ID','D','2efb6d3d-6e7e-4ad3-aeec-4c08940f6350')
;

-- Jul 13, 2022, 1:49:54 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215038,0,'RV_GenerateShipmetns_Manual_ID',200131,'RV_GenerateShipmetns_Manual_ID',22,'N','N','N','N','N',0,'N',13,0,0,'Y',TO_TIMESTAMP('2022-07-13 13:49:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-07-13 13:49:53','YYYY-MM-DD HH24:MI:SS'),100,203627,'Y','N','D','N','N','N','Y','803df7e9-c90d-4cb2-915e-32df129d4c1d','Y',0,'N','N','N','N')
;

-- Jul 13, 2022, 2:50:27 PM CEST
CREATE OR REPLACE VIEW RV_GenerateShipmetns_Manual(AD_Client_ID, AD_Org_ID, Created, Updated, IsActive, M_Warehouse_ID, C_BPartner_ID, C_Order_ID, M_InOut_ID, C_DocType_ID, DocumentNo, DateOrdered, TotalLines, DocType, RV_GenerateShipmetns_Manual_ID) AS SELECT ic.ad_client_id AS AD_Client_ID, ic.ad_org_id AS AD_Org_ID, o.created AS Created, o.updated AS Updated, o.isactive AS IsActive, ic.m_warehouse_id AS M_Warehouse_ID, ic.c_bpartner_id AS C_BPartner_ID, ic.c_order_id AS C_Order_ID, NULL::numeric AS M_InOut_ID, ic.c_doctype_id AS C_DocType_ID, ic.documentno AS DocumentNo, ic.dateordered AS DateOrdered, ic.totallines AS TotalLines, 'Order'::text AS DocType, ic.c_order_id AS RV_GenerateShipmetns_Manual_ID FROM m_inout_candidate_v ic JOIN c_order o ON ic.c_order_id = o.c_order_id UNION ALL SELECT rma.ad_client_id AS AD_Client_ID, rma.ad_org_id AS AD_Org_ID, io.created AS Created, io.updated AS Updated, io.isactive AS IsActive, NULL::numeric AS M_Warehouse_ID, rma.c_bpartner_id AS C_BPartner_ID, rma.c_order_id AS C_Order_ID, rma.inout_id AS M_InOut_ID, rma.c_doctype_id AS C_DocType_ID, rma.documentno AS DocumentNo, io.dateordered AS DateOrdered, 0 AS TotalLines, 'VendorRMA'::text AS DocType, rma.inout_id AS RV_GenerateShipmetns_Manual_ID FROM m_rma rma JOIN m_inout io ON rma.inout_id = io.m_inout_id JOIN c_doctype dt ON io.c_doctype_id = dt.c_doctype_id WHERE rma.docstatus = 'CO'::bpchar AND dt.docbasetype = 'POO'::bpchar AND (EXISTS ( SELECT 1 FROM m_rma r JOIN m_rmaline rl ON r.m_rma_id = rl.m_rma_id WHERE r.m_rma_id = rma.m_rma_id AND rl.isactive = 'Y'::bpchar AND rl.m_inoutline_id > 0::numeric AND rl.qtydelivered < rl.qty)) AND NOT (EXISTS ( SELECT 1 FROM m_inout oio WHERE oio.m_rma_id = rma.m_rma_id AND (oio.docstatus = ANY (ARRAY['IP'::bpchar, 'CO'::bpchar, 'CL'::bpchar]))))
;

-- Jul 13, 2022, 4:32:29 PM CEST
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2022-07-13 16:32:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=346
;

