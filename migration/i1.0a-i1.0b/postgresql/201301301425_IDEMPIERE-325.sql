-- Jan 30, 2013 4:14:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,IsDefault,IsDistinct,OrderByClause,IsValid) VALUES ('N','C_Order o','9a8cdbc5-2563-47ac-9f64-971723128db5',200002,259,'D','Order Info',0,0,TO_TIMESTAMP('2013-01-30 16:14:17','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-01-30 16:14:17','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','N','N','2,3,4','N')
;

-- Jan 30, 2013 4:14:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('fe226ae2-ce32-41fa-a880-69683ce3fc0e',TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,50002,200002,0,0,TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 30, 2013 4:14:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('24827c4b-5900-4a37-ab7e-de10aecc00d0',TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,0,200002,0,0,TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 30, 2013 4:14:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('9b4e2d38-3585-494e-b321-29f3b0eefb79',TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,102,200002,11,0,TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 30, 2013 4:14:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('a26e76bd-c222-42f9-93d7-a07dfd82e26b',TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,103,200002,11,0,TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 30, 2013 4:14:21 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('609534dd-c820-471f-b901-d565b677192d',TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,50001,200002,0,0,TO_TIMESTAMP('2013-01-30 16:14:20','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Jan 30, 2013 4:17:05 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200002,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','4a3dc535-a44a-42e4-bf1c-4be76639cf10',30,200039,'Y','D','Identifies a Business Partner',TO_TIMESTAMP('2013-01-30 16:17:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:17:04','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Business Partner ',230,'Y','C_BPartner_ID','Y','Y',187,10,'=','o.C_BPartner_ID')
;

-- Jan 30, 2013 4:17:56 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200002,'Indicates the Date an item was ordered.','18041344-a196-4a51-bfdd-a7e726641c21',15,200040,'N','D','Date of Order',TO_TIMESTAMP('2013-01-30 16:17:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:17:55','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Date Ordered','Y','DateOrdered','Y','Y',268,20,'=','Trunc','o.DateOrdered')
;

-- Jan 30, 2013 4:44:25 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200002,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','ad9d5345-b85f-4712-a43c-781c491b5e6f',10,200041,'Y','D','Document sequence number of the document',TO_TIMESTAMP('2013-01-30 16:44:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:44:23','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Document No','Y','DocumentNo','Y','Y',290,30,'Like','Upper','o.DocumentNo')
;

-- Jan 30, 2013 4:45:26 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200002,'Indicates the Currency to be used when processing or reporting on this record','18b59430-dfcd-4a0a-b152-2c28051fb220',19,200042,'N','D','The Currency for this record',TO_TIMESTAMP('2013-01-30 16:45:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:45:25','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Currency','Y','C_Currency_ID','Y','Y',193,40,'o.C_Currency_ID')
;

-- Jan 30, 2013 4:45:45 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200002,'A description is limited to 255 characters.','a94c3237-9b61-4b1f-b3b8-726c7316fb9b',14,200043,'Y','D','Optional short description of the record',TO_TIMESTAMP('2013-01-30 16:45:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:45:45','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Description','Y','Description','N','Y',275,50,'Like','Upper','o.Description')
;

-- Jan 30, 2013 4:47:01 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200002,'Indicates the Date an item was ordered.','175d4ba8-a123-49d8-b068-18455285792d',15,200044,'Y','D','Date of Order',TO_TIMESTAMP('2013-01-30 16:47:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:47:00','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Date Ordered','Y','DateOrdered','N','Y',268,60,'>=','Trunc','o.DateOrdered AS DateOrderedFrom')
;

-- Jan 30, 2013 4:47:41 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200002,'Indicates the Date an item was ordered.','8a87c928-0764-40d1-b47d-2ba2b9f70835',15,200045,'Y','D','Date of Order',TO_TIMESTAMP('2013-01-30 16:47:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:47:40','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Date Ordered','Y','DateOrdered','N','Y',268,70,'<=','Trunc','o.DateOrdered AS DateOrderedTo')
;

-- Jan 30, 2013 4:48:22 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause) VALUES (200002,'The business partner order reference is the order reference for this specific transaction; Often Purchase Order numbers are given to print on Invoices for easier reference.  A standard number can be defined in the Business Partner (Customer) window.','386f401d-1557-4b6c-9e99-052ecb0cdc4f',10,200046,'Y','D','Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner',TO_TIMESTAMP('2013-01-30 16:48:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:48:21','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Order Reference','Y','POReference','N','Y',952,80,'Like','Upper','o.POReference')
;

-- Jan 30, 2013 4:48:47 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause) VALUES (200002,'The Grand Total displays the total amount including Tax and Freight in document currency','dda56d4d-8134-48de-b789-5c0944674206',12,200047,'N','D','Total amount of document',TO_TIMESTAMP('2013-01-30 16:48:46','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:48:46','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Grand Total','Y','GrandTotal','Y','Y',316,90,'o.GrandTotal')
;

-- Jan 30, 2013 4:49:15 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200002,'The Grand Total displays the total amount including Tax and Freight in document currency','90715dc1-ad0e-4eab-83ce-fb8c44f3206e',12,200048,'Y','D','Total amount of document',TO_TIMESTAMP('2013-01-30 16:49:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:49:14','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Grand Total','Y','GrandTotal','N','Y',316,100,'>=','o.GrandTotal AS GrandTotalFrom')
;

-- Jan 30, 2013 4:49:38 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200002,'The Grand Total displays the total amount including Tax and Freight in document currency','5a6de2e4-4587-4c61-b7b6-2c3e62c70e20',12,200049,'Y','D','Total amount of document',TO_TIMESTAMP('2013-01-30 16:49:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:49:37','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Grand Total','Y','GrandTotal','N','Y',316,110,'<=','o.GrandTotal AS GrandTotalTo')
;

-- Jan 30, 2013 4:50:52 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause) VALUES (200002,'d12130dc-c065-473a-bd63-517d90ddfc24',12,200050,'N','D',TO_TIMESTAMP('2013-01-30 16:50:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:50:51','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Converted','Y','ConvertedAmount','Y','Y',120,'=','currencyBase(o.GrandTotal,o.C_Currency_ID,o.DateAcct, o.AD_Client_ID,o.AD_Org_ID) AS ConvertedAmount')
;

-- Jan 30, 2013 4:51:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause) VALUES (200002,'The Sales Transaction checkbox indicates if this item is a Sales Transaction.','e06299a7-3ea5-463e-85c5-b3fe83e019fd',20,200051,'Y','D','This is a Sales Transaction',TO_TIMESTAMP('2013-01-30 16:51:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-01-30 16:51:42','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Sales Transaction','Y','IsSOTrx','Y','Y',1106,130,'=','o.IsSOTrx')
;

-- Jan 30, 2013 4:53:56 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='Y', SeqNo=130,Updated=TO_TIMESTAMP('2013-01-30 16:53:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200046
;

-- Jan 30, 2013 4:54:11 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='Y', SeqNo=120,Updated=TO_TIMESTAMP('2013-01-30 16:54:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200043
;

-- Jan 30, 2013 4:54:25 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=80,Updated=TO_TIMESTAMP('2013-01-30 16:54:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200047
;

-- Jan 30, 2013 4:54:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=90,Updated=TO_TIMESTAMP('2013-01-30 16:54:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200048
;

-- Jan 30, 2013 4:54:32 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=100,Updated=TO_TIMESTAMP('2013-01-30 16:54:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200049
;

-- Jan 30, 2013 4:54:45 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=110,Updated=TO_TIMESTAMP('2013-01-30 16:54:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200050
;

-- Jan 30, 2013 4:54:50 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=50,Updated=TO_TIMESTAMP('2013-01-30 16:54:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200044
;

-- Jan 30, 2013 4:54:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=60,Updated=TO_TIMESTAMP('2013-01-30 16:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200045
;

-- Jan 30, 2013 4:54:57 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=70,Updated=TO_TIMESTAMP('2013-01-30 16:54:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200047
;

-- Jan 30, 2013 4:55:00 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=80,Updated=TO_TIMESTAMP('2013-01-30 16:55:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200048
;

-- Jan 30, 2013 4:55:03 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=90,Updated=TO_TIMESTAMP('2013-01-30 16:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200049
;

-- Jan 30, 2013 4:55:06 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=100,Updated=TO_TIMESTAMP('2013-01-30 16:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200050
;

-- Jan 30, 2013 4:55:19 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNo=110,Updated=TO_TIMESTAMP('2013-01-30 16:55:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200051
;

-- Jan 30, 2013 4:55:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsDefault='Y',Updated=TO_TIMESTAMP('2013-01-30 16:55:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200002
;

-- Jan 30, 2013 4:56:19 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2013-01-30 16:56:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200002
;

-- Jan 30, 2013 5:47:22 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',1,897,208444,'D','Y','N','N',0,'N',1,'N',20,'N',382,'N','Y','40c556b6-f818-4ea6-9ae6-9ece30ba938b','Y','IsIdentifier','This column is part of the record identifier','N','The Identifier checkbox indicates that this column is part of the identifier or key for this table.  ','Identifier','Y',TO_TIMESTAMP('2013-01-30 17:47:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-30 17:47:21','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Jan 30, 2013 5:47:38 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoColumn ADD COLUMN IsIdentifier CHAR(1) DEFAULT 'N' CHECK (IsIdentifier IN ('Y','N')) NOT NULL
;

-- Jan 30, 2013 5:50:05 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,IsToolbarButton,IsAlwaysUpdateable,IsEncrypted) VALUES (0,'N',1,897,208445,'D','N','N','N',0,'N',10,'N',11,'N',200096,'N','Y','29bb3f29-299c-46b8-9e08-372083702d1e','Y','SeqNoSelection','Selection Column Sequence','For ordering sequence of selection column','Selection Column Sequence','Y',TO_TIMESTAMP('2013-01-30 17:50:04','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-01-30 17:50:04','YYYY-MM-DD HH24:MI:SS'),100,0,'N','N','N')
;

-- Jan 30, 2013 5:50:13 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
ALTER TABLE AD_InfoColumn ADD COLUMN SeqNoSelection NUMERIC(10) DEFAULT NULL 
;

-- Jan 30, 2013 6:00:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',844,0,'N','N',208444,220,'Y',201719,'N','The Identifier checkbox indicates that this column is part of the identifier or key for this table.  ','@IsQueryCriteria@=Y','D','This column is part of the record identifier','Identifier','Y','N','b79dad18-0a75-4cc3-a8dc-2bcaec0b6e97',100,0,TO_TIMESTAMP('2013-01-30 18:00:52','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-30 18:00:52','YYYY-MM-DD HH24:MI:SS'),'Y','Y',130,1,'N')
;

-- Jan 30, 2013 6:01:39 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_Field (ColumnSpan,NumLines,SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,DisplayLogic,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry) VALUES (2,1,0,'N',844,0,'N','N',208445,230,'Y',201720,'N','For ordering sequence of selection column','@IsQueryCriteria@=Y','D','Selection Column Sequence','Selection Column Sequence','Y','N','99b2daa0-13cd-42a9-bc74-fbe704e3c449',100,0,TO_TIMESTAMP('2013-01-30 18:01:37','YYYY-MM-DD HH24:MI:SS'),0,100,TO_TIMESTAMP('2013-01-30 18:01:37','YYYY-MM-DD HH24:MI:SS'),'Y','Y',140,1,'N')
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=150, IsDisplayed='Y', XPosition=2,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201719
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET ColumnSpan=2, SeqNo=160, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201720
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201625
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201635
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201636
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13603
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201622
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201623
;

-- Jan 30, 2013 6:02:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2013-01-30 18:02:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13597
;

-- Jan 30, 2013 9:58:17 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=20,Updated=TO_TIMESTAMP('2013-01-30 21:58:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200039
;

-- Jan 30, 2013 9:58:21 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=10,Updated=TO_TIMESTAMP('2013-01-30 21:58:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200041
;

-- Jan 30, 2013 9:58:24 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=50,Updated=TO_TIMESTAMP('2013-01-30 21:58:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200044
;

-- Jan 30, 2013 9:58:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=60,Updated=TO_TIMESTAMP('2013-01-30 21:58:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200045
;

-- Jan 30, 2013 9:58:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=80,Updated=TO_TIMESTAMP('2013-01-30 21:58:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200048
;

-- Jan 30, 2013 9:58:36 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=90,Updated=TO_TIMESTAMP('2013-01-30 21:58:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200049
;

-- Jan 30, 2013 9:58:40 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=30,Updated=TO_TIMESTAMP('2013-01-30 21:58:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200051
;

-- Jan 30, 2013 9:58:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=40,Updated=TO_TIMESTAMP('2013-01-30 21:58:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200043
;

-- Jan 30, 2013 9:58:49 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=70,Updated=TO_TIMESTAMP('2013-01-30 21:58:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200046
;

-- Jan 30, 2013 10:00:00 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Column SET DefaultValue='0',Updated=TO_TIMESTAMP('2013-01-30 22:00:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=208445
;

-- Jan 30, 2013 10:00:10 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO t_alter_column values('ad_infocolumn','SeqNoSelection','NUMERIC(10)',null,'0')
;

-- Jan 30, 2013 10:08:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsIdentifier='Y',Updated=TO_TIMESTAMP('2013-01-30 22:08:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200023
;

-- Jan 30, 2013 10:08:40 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsIdentifier='Y',Updated=TO_TIMESTAMP('2013-01-30 22:08:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200024
;

-- Jan 30, 2013 10:09:46 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsIdentifier='Y',Updated=TO_TIMESTAMP('2013-01-30 22:09:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200000
;

-- Jan 30, 2013 10:09:58 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsIdentifier='Y',Updated=TO_TIMESTAMP('2013-01-30 22:09:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200001
;

-- Jan 30, 2013 10:10:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsIdentifier='Y',Updated=TO_TIMESTAMP('2013-01-30 22:10:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200041
;

UPDATE AD_InfoColumn SET SeqNoSelection = 0 WHERE SeqNoSelection IS NULL
;

SELECT register_migration_script('201301301425_IDEMPIERE-325.sql') FROM dual
;

