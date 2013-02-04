-- Feb 1, 2013 6:50:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,WhereClause,IsDefault,IsDistinct,OrderByClause,IsValid) VALUES ('N','C_Invoice_v i','2fa03895-f3d2-441f-bcba-5e7854260e53',200003,318,'D','Invoice Info',0,0,TO_DATE('2013-02-01 06:50:57','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-01 06:50:57','YYYY-MM-DD HH24:MI:SS'),100,100,'Y',NULL,'Y','N','2,3,4,5','N')
;

-- Feb 1, 2013 6:50:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('a3c7acff-9116-4d95-a905-7fe1d7167141',TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,50002,200003,0,0,TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 6:50:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('110f07e6-155b-4323-a8ab-d4960c3f2cf3',TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,0,200003,0,0,TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 6:50:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('46efe429-c38a-4af8-b856-b4cba63a7698',TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,102,200003,11,0,TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 6:50:59 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('ce19ac6b-c549-4b54-9fbe-dd9f196e7d1f',TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,103,200003,11,0,TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 6:51:00 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('bd739160-6bcd-4a7c-a549-e13c900db538',TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,50001,200003,0,0,TO_DATE('2013-02-01 06:50:59','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 6:51:17 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Preference SET Value='Y',Updated=TO_DATE('2013-02-01 06:51:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000020
;

-- Feb 1, 2013 6:53:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','a8e309a2-00e9-488e-aa86-6b4f6d4eb464',30,200052,'Y','D','Identifies a Business Partner',TO_DATE('2013-02-01 06:53:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 06:53:41','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Business Partner ',230,'Y','C_BPartner_ID','Y','Y',187,10,'=','i.C_BPartner_ID','N',20)
;

-- Feb 1, 2013 6:55:08 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Date Invoice indicates the date printed on the invoice.','bb7f6d7c-f767-49bc-9753-0ac0b6bc7014',15,200053,'N','D','Date printed on Invoice',TO_DATE('2013-02-01 06:55:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 06:55:07','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Date Invoiced','Y','DateInvoiced','Y','Y',267,20,'=','Trunc','i.DateInvoiced','N',0)
;

-- Feb 1, 2013 6:57:08 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Date Invoice indicates the date printed on the invoice.','16bfb2ec-0682-49a8-ba4f-9f43f9e82ccc',15,200054,'Y','D','Date printed on Invoice',TO_DATE('2013-02-01 06:57:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 06:57:06','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Date Invoiced','Y','DateInvoiced','N','Y',267,30,'=','Trunc','i.DateInvoiced AS DateInvoicedFrom','N',40)
;

-- Feb 1, 2013 6:58:10 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Date Invoice indicates the date printed on the invoice.','8ddafe44-07f1-436a-aa76-eab71c34c1ad',15,200055,'Y','D','Date printed on Invoice',TO_DATE('2013-02-01 06:58:09','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 06:58:09','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Date Invoiced','Y','DateInvoiced','N','Y',267,40,'=','Trunc','i.DateInvoiced AS DateInvoicedTo','N',70)
;

-- Feb 1, 2013 6:58:17 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET SeqNoSelection=60,Updated=TO_DATE('2013-02-01 06:58:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200054
;

-- Feb 1, 2013 6:59:07 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'Date when the payment is due without deductions or discount','a377ccc1-277b-4aa6-98e4-d0a324b7094e',15,200056,'N','D','Date when the payment is due',TO_DATE('2013-02-01 06:59:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 06:59:06','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Due Date','Y','DueDate','Y','Y',2000,50,'=','Trunc','i.DueDate','N',0)
;

-- Feb 1, 2013 6:59:52 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','17b1895e-0dbc-44f9-84aa-83ee1142da06',10,200057,'Y','D','Document sequence number of the document',TO_DATE('2013-02-01 06:59:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 06:59:51','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Document No','Y','DocumentNo','Y','Y',290,60,'Like','Upper','i.DocumentNo','Y',10)
;

-- Feb 1, 2013 7:02:52 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'Indicates the Currency to be used when processing or reporting on this record','571b3075-c68a-400e-af69-9b5924f7f775',19,200058,'N','D','The Currency for this record',TO_DATE('2013-02-01 07:02:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:02:51','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Currency','Y','C_Currency_ID','Y','Y',193,70,'=','i.C_Currency_ID','N',0)
;

-- Feb 1, 2013 7:15:14 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Grand Total displays the total amount including Tax and Freight in document currency','720c9a01-c2de-4411-b62f-6ee1b5eb28a5',37,200059,'N','D','Total amount of document',TO_DATE('2013-02-01 07:15:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:15:13','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Grand Total','Y','GrandTotal','Y','Y',316,80,'=','i.GrandTotal','N',0)
;

-- Feb 1, 2013 7:16:28 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Grand Total displays the total amount including Tax and Freight in document currency','681d099d-d477-49aa-a17b-270e86826d1a',37,200060,'Y','D','Total amount of document',TO_DATE('2013-02-01 07:16:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:16:27','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Grand Total','Y','GrandTotal','N','Y',316,90,'=','i.GrandTotal AS GrandTotalFrom','N',90)
;

-- Feb 1, 2013 7:17:09 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Grand Total displays the total amount including Tax and Freight in document currency','eed2dedd-386e-46be-91ae-1e4cab7dc46f',37,200061,'Y','D','Total amount of document',TO_DATE('2013-02-01 07:17:08','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:17:08','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Grand Total','Y','GrandTotal','Y','Y',316,100,'=','i.GrandTotal AS GrandTotalTo','N',100)
;

-- Feb 1, 2013 7:17:20 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET QueryOperator='>=',Updated=TO_DATE('2013-02-01 07:17:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200060
;

-- Feb 1, 2013 7:17:32 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET QueryOperator='<=',Updated=TO_DATE('2013-02-01 07:17:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200061
;

-- Feb 1, 2013 7:17:56 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET QueryOperator='>=',Updated=TO_DATE('2013-02-01 07:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200054
;

-- Feb 1, 2013 7:18:03 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET QueryOperator='<=',Updated=TO_DATE('2013-02-01 07:18:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200055
;

-- Feb 1, 2013 7:19:05 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'fa1d22f9-1a89-4c41-abe5-f8781f7f9ab5',37,200062,'N','D',TO_DATE('2013-02-01 07:19:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:19:04','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Converted','Y','ConvertedAmount','Y','Y',110,'=','currencyBase(i.GrandTotal, i.C_Currency_ID, i.DateAcct, i.AD_Client_ID, i.AD_Org_ID) AS ConvertedAmount','N',0)
;

-- Feb 1, 2013 7:20:17 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'bf0484ef-3f9f-445e-ac1e-f61f0535836d',37,200063,'N','D','Open item amount',TO_DATE('2013-02-01 07:20:16','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:20:16','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Open Amount','Y','OpenAmt','Y','Y',1526,120,'=','invoiceOpen(i.C_Invoice_ID,i.C_InvoicePaySchedule_ID) AS OpenAmt','N',0)
;

-- Feb 1, 2013 7:22:01 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'73647164-8141-49eb-8844-9c9435d66e59',20,200064,'N','D','The document is paid',TO_DATE('2013-02-01 07:22:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:22:00','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Paid','Y','IsPaid','Y','Y',1402,130,'=','i.IsPaid','N',0)
;

-- Feb 1, 2013 7:22:45 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'4fef4a3d-d9c6-4992-85aa-9d519e5240aa',17,200065,'Y','D','The document is paid',TO_DATE('2013-02-01 07:22:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:22:44','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Paid',319,'Y','IsPaid','N','Y',1402,140,'=','i.IsPaid','N',40)
;

-- Feb 1, 2013 7:23:42 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Sales Transaction checkbox indicates if this item is a Sales Transaction.','7e328835-a762-4201-a556-2a8a868dd979',20,200066,'Y','D','This is a Sales Transaction',TO_DATE('2013-02-01 07:23:41','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:23:41','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Sales Transaction','Y','IsSOTrx','Y','Y',1106,150,'=','i.IsSOTrx','N',30)
;

-- Feb 1, 2013 7:24:29 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'A description is limited to 255 characters.','f4ba9e09-0dd9-4f91-8530-07b0213b22bc',10,200067,'Y','D','Optional short description of the record',TO_DATE('2013-02-01 07:24:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:24:28','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Description','Y','Description','Y','Y',275,160,'Like','Upper','i.Description','N',50)
;

-- Feb 1, 2013 7:26:20 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The business partner order reference is the order reference for this specific transaction; Often Purchase Order numbers are given to print on Invoices for easier reference.  A standard number can be defined in the Business Partner (Customer) window.','1a1732a8-2199-47d0-9ed4-cc880c3b3809',10,200068,'N','D','Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner',TO_DATE('2013-02-01 07:26:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:26:19','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Order Reference','Y','POReference','Y','Y',952,170,'Like','Upper','i.POReference','N',0)
;

-- Feb 1, 2013 7:29:12 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Order is a control document.  The  Order is complete when the quantity ordered is the same as the quantity shipped and invoiced.  When you close an order, unshipped (backordered) quantities are cancelled.','d3dc6931-1309-47f1-a32e-900f7d5fbf69',30,200069,'Y','D','Order',TO_DATE('2013-02-01 07:29:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:29:11','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Order','Y','C_Order_ID','N','Y',558,180,'=','i.C_Order_ID','N',80)
;

-- Feb 1, 2013 7:32:25 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200003,'The Invoice Payment Schedule determines when partial payments are due.','3285bdfc-e6d9-4f3f-8345-48f3ddd1f034',19,200070,'N','D','Invoice Payment Schedule',TO_DATE('2013-02-01 07:32:24','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 07:32:24','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Invoice Payment Schedule','Y','C_InvoicePaySchedule_ID','Y','Y',1995,190,'=','i.C_InvoicePaySchedule_ID','N',0)
;

-- Feb 1, 2013 7:32:52 AM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2013-02-01 07:32:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200003
;

-- Feb 1, 2013 3:31:12 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Preference SET Value='N',Updated=TO_DATE('2013-02-01 15:31:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000020
;

-- Feb 1, 2013 3:31:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,IsDefault,IsDistinct,OrderByClause,IsValid) VALUES ('N','M_InOut i','65ce8228-dafb-4597-a74c-e2315d5882c2',200004,319,'D','Shipment Info',0,0,TO_DATE('2013-02-01 15:31:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-01 15:31:40','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','Y','N','2,3,4','N')
;

-- Feb 1, 2013 3:31:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('41c7ae42-10f3-4ec0-b0ca-c0b229425641',TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,50002,200004,0,0,TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 3:31:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('21e755aa-d64d-481a-abda-b48127002345',TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,0,200004,0,0,TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 3:31:42 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('3e0be343-66e4-4e2e-bf4d-7ee30481d56d',TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,102,200004,11,0,TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 3:31:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('bf894825-af3b-4501-a791-ebeb9036c8a3',TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,103,200004,11,0,TO_DATE('2013-02-01 15:31:42','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 3:31:43 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('e3a580a7-0093-4784-9e78-7b9c525871eb',TO_DATE('2013-02-01 15:31:43','YYYY-MM-DD HH24:MI:SS'),100,50001,200004,0,0,TO_DATE('2013-02-01 15:31:43','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 3:31:55 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_Preference SET Value='Y',Updated=TO_DATE('2013-02-01 15:31:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Preference_ID=1000020
;

-- Feb 1, 2013 3:32:56 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','0341cf14-a0ea-4b41-b600-936c8ee1e176',30,200071,'Y','D','Identifies a Business Partner',TO_DATE('2013-02-01 15:32:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:32:55','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Business Partner ',230,'Y','C_BPartner_ID','Y','Y',187,10,'=','i.C_BPartner_ID','N',20)
;

-- Feb 1, 2013 3:34:01 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'The Movement Date indicates the date that a product moved in or out of inventory.  This is the result of a shipment, receipt or inventory movement.','14fea162-ebdc-42bc-95fc-f99ed57791f5',15,200072,'N','D','Date a product was moved in or out of inventory',TO_DATE('2013-02-01 15:34:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:34:00','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Movement Date','Y','MovementDate','Y','Y',1037,20,'=','Trunc','i.MovementDate','Y',0)
;

-- Feb 1, 2013 3:34:57 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'The Movement Date indicates the date that a product moved in or out of inventory.  This is the result of a shipment, receipt or inventory movement.','46355f65-5ca7-4d74-b29b-75431012f2e6',15,200073,'Y','D','Date a product was moved in or out of inventory',TO_DATE('2013-02-01 15:34:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:34:56','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Movement Date','Y','MovementDate','Y','Y',1037,30,'>=','Trunc','i.MovementDate AS MovementDateFrom','N',50)
;

-- Feb 1, 2013 3:36:11 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'The Movement Date indicates the date that a product moved in or out of inventory.  This is the result of a shipment, receipt or inventory movement.','eab7cfd8-49e9-4347-8af8-7a8b7cc380a2',15,200074,'Y','D','Date a product was moved in or out of inventory',TO_DATE('2013-02-01 15:36:10','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:36:10','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Movement Date','Y','MovementDate','N','Y',1037,40,'<=','Trunc','i.MovementDate AS MovementDateTo','N',60)
;

-- Feb 1, 2013 3:36:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_DATE('2013-02-01 15:36:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200073
;

-- Feb 1, 2013 3:37:27 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','0cc5a109-8387-489d-875e-f86f912494ef',10,200075,'Y','D','Document sequence number of the document',TO_DATE('2013-02-01 15:37:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:37:26','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Document No','Y','DocumentNo','Y','Y',290,50,'Like','Upper','i.DocumentNo','Y',10)
;

-- Feb 1, 2013 3:38:08 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'A description is limited to 255 characters.','efb27932-6556-4283-abf0-1bdc0f3d2bea',14,200076,'Y','D','Optional short description of the record',TO_DATE('2013-02-01 15:38:07','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:38:07','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Description','Y','Description','Y','Y',275,60,'Like','Upper','i.Description','N',40)
;

-- Feb 1, 2013 3:39:58 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'The business partner order reference is the order reference for this specific transaction; Often Purchase Order numbers are given to print on Invoices for easier reference.  A standard number can be defined in the Business Partner (Customer) window.','16523c57-e228-4ec7-a92b-f4d2cb02e8d6',10,200077,'Y','D','Transaction Reference Number (Sales Order, Purchase Order) of your Business Partner',TO_DATE('2013-02-01 15:39:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:39:57','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Order Reference','Y','POReference','Y','Y',952,70,'Like','Upper','i.POReference','N',70)
;

-- Feb 1, 2013 3:40:27 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200004,'The Sales Transaction checkbox indicates if this item is a Sales Transaction.','a2c9fd03-d020-4d08-9e37-a3ab48eddb24',20,200078,'Y','D','This is a Sales Transaction',TO_DATE('2013-02-01 15:40:26','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 15:40:26','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Sales Transaction','Y','IsSOTrx','Y','Y',1106,80,'=','i.IsSOTrx','N',30)
;

-- Feb 1, 2013 3:40:55 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2013-02-01 15:40:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200004
;

-- Feb 1, 2013 4:23:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,IsDefault,IsDistinct,OrderByClause,IsValid) VALUES ('N','C_Payment_v p','87b9dee7-f07c-46b7-acb2-f8ac48928f4b',200005,335,'D','Payment Info',0,0,TO_DATE('2013-02-01 16:23:52','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-01 16:23:52','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','Y','N','2,3,4','N')
;

-- Feb 1, 2013 4:23:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('01453b94-440e-4bbc-ba5f-2689d2dabf37',TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,50002,200005,0,0,TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 4:23:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('480ca9db-4bb5-44af-8a73-5b9547a5ac90',TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,0,200005,0,0,TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 4:23:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('9a141601-7866-4741-a9ac-3b67911a5779',TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,102,200005,11,0,TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 4:23:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('5a5acac3-6405-452a-bb8e-d1e1c96bff60',TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,103,200005,11,0,TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 4:23:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('f97ce3b6-4775-4084-b66a-1be8d8baf34d',TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,50001,200005,0,0,TO_DATE('2013-02-01 16:23:54','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 4:26:31 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The Bank Account identifies an account at this Bank.','da2a6b0a-1d34-452b-8e6b-c6a525b87292',10,200079,'N','D','Account at the Bank',TO_DATE('2013-02-01 16:26:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:26:30','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Bank Account','Y','C_BankAccount_ID','Y','Y',836,10,'Like','Upper','(SELECT b.Name || '' '' || ba.AccountNo FROM C_Bank b, C_BankAccount ba WHERE b.C_Bank_ID=ba.C_Bank_ID AND ba.C_BankAccount_ID=p.C_BankAccount_ID) AS BankAccount','N',0)
;

-- Feb 1, 2013 4:27:22 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','09b655fb-897f-448a-bcd0-b6961977e4a4',30,200080,'Y','D','Identifies a Business Partner',TO_DATE('2013-02-01 16:27:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:27:20','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Business Partner ',230,'Y','C_BPartner_ID','Y','Y',187,20,'=','p.C_BPartner_ID','N',20)
;

-- Feb 1, 2013 4:28:01 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The Transaction Date indicates the date of the transaction.','1baa7020-f735-4607-911a-c6cad4edc841',15,200081,'N','D','Transaction Date',TO_DATE('2013-02-01 16:28:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:28:00','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Transaction Date','Y','DateTrx','Y','Y',1297,30,'p.DateTrx','N',0)
;

-- Feb 1, 2013 4:28:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The Transaction Date indicates the date of the transaction.','59d0284d-9756-4faa-a4ab-0795b1b93bb4',15,200082,'Y','D','Transaction Date',TO_DATE('2013-02-01 16:28:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:28:43','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Transaction Date','Y','DateTrx','N','Y',1297,40,'>=','Trunc','p.DateTrx AS DateTrxFrom','N',40)
;

-- Feb 1, 2013 4:29:07 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The Transaction Date indicates the date of the transaction.','85f2e296-8eeb-4a09-ad70-7c07a5dd3e8e',15,200083,'Y','D','Transaction Date',TO_DATE('2013-02-01 16:29:06','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:29:06','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Transaction Date','Y','DateTrx','N','Y',1297,50,'<=','Trunc','p.DateTrx AS DateTrxTo','N',50)
;

-- Feb 1, 2013 4:29:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The document number is usually automatically generated by the system and determined by the document type of the document. If the document is not saved, the preliminary number is displayed in "<>".

If the document type of your document has no automatic document sequence defined, the field is empty if you create a new document. This is for documents which usually have an external number (like vendor invoice).  If you leave the field empty, the system will generate a document number for you. The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','4ca6e0cc-704e-42fc-9680-d41df28b5940',10,200084,'Y','D','Document sequence number of the document',TO_DATE('2013-02-01 16:29:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:29:53','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Document No','Y','DocumentNo','Y','Y',290,60,'Like','Upper','p.DocumentNo','Y',10)
;

-- Feb 1, 2013 4:30:41 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'1a9bbc1f-42c4-4b8d-a611-221dddf5752c',20,200085,'Y','D','This is a sales transaction (receipt)',TO_DATE('2013-02-01 16:30:40','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:30:40','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Receipt','Y','IsReceipt','Y','Y',1634,70,'=','p.IsReceipt','N',30)
;

-- Feb 1, 2013 4:31:04 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'Indicates the Currency to be used when processing or reporting on this record','292d0f6e-01b9-4ede-a656-dc9db8ed1f1f',19,200086,'N','D','The Currency for this record',TO_DATE('2013-02-01 16:31:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:31:03','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Currency','Y','C_Currency_ID','Y','Y',193,80,'p.C_Currency_ID','N',0)
;

-- Feb 1, 2013 4:31:41 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','b0e600fa-982f-4bbc-b13f-c5cb52061e6b',12,200087,'N','D','Amount being paid',TO_DATE('2013-02-01 16:31:39','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:31:39','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Payment amount','Y','PayAmt','Y','Y',1477,90,'p.PayAmt','N',0)
;

-- Feb 1, 2013 4:32:12 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','9a4397bf-3859-4103-bf0b-a3dd029e834a',12,200088,'Y','D','Amount being paid',TO_DATE('2013-02-01 16:32:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:32:11','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Payment amount','Y','PayAmt','N','Y',1477,100,'>=','p.PayAmt AS PayAmtFrom','N',60)
;

-- Feb 1, 2013 4:32:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'Indicates the amount this payment is for.  The payment amount can be for single or multiple invoices or a partial payment for an invoice.','4f917764-34e3-47f7-961d-936036246cf2',12,200089,'Y','D','Amount being paid',TO_DATE('2013-02-01 16:32:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:32:36','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Payment amount','Y','PayAmt','N','Y',1477,110,'<=','p.PayAmt AS PayAmtTo','N',70)
;

-- Feb 1, 2013 4:33:45 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'9d98f849-75c7-41d4-9759-3dcdeb3fd86a',12,200090,'N','D',TO_DATE('2013-02-01 16:33:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:33:44','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Converted','Y','ConvertedAmount','Y','Y',120,'=','currencyBase(p.PayAmt,p.C_Currency_ID,p.DateTrx, p.AD_Client_ID,p.AD_Org_ID) AS ConvertedAmount','N',0)
;

-- Feb 1, 2013 4:34:54 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The Discount Amount indicates the discount amount for a document or line.','7ac58a48-b879-4308-96e6-2f8af97a6315',12,200091,'N','D','Calculated amount of discount',TO_DATE('2013-02-01 16:34:53','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:34:53','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Discount Amount','Y','DiscountAmt','Y','Y',1395,130,'p.DiscountAmt','N',0)
;

-- Feb 1, 2013 4:35:13 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The Write Off Amount indicates the amount to be written off as uncollectible.','5658d299-2912-4781-bcef-c3cb74e73a27',12,200092,'N','D','Amount to write-off',TO_DATE('2013-02-01 16:35:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:35:12','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Write-off Amount','Y','WriteOffAmt','Y','Y',1450,140,'p.WriteOffAmt','N',0)
;

-- Feb 1, 2013 4:35:28 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200005,'The Allocated checkbox indicates if a payment has been allocated or associated with an invoice or invoices.','16b7cd0d-3846-42f7-8400-d6febb758bc3',20,200093,'N','D','Indicates if the payment has been allocated',TO_DATE('2013-02-01 16:35:27','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 16:35:27','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Allocated','Y','IsAllocated','Y','Y',1508,150,'p.IsAllocated','N',0)
;

-- Feb 1, 2013 4:36:04 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2013-02-01 16:36:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200005
;

-- Feb 1, 2013 5:35:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,WhereClause,IsDefault,IsDistinct,IsValid) VALUES ('N','S_ResourceAssignment ra
INNER JOIN S_Resource r ON (ra.S_Resource_ID=r.S_Resource_ID)
INNER JOIN S_ResourceType rt ON (r.S_ResourceType_ID=rt.S_ResourceType_ID)
INNER JOIN C_UOM uom ON (rt.C_UOM_ID=uom.C_UOM_ID)','a79f55fb-97b0-4fb1-b666-43148ad82a08',200006,485,'D','Info Resource Assignment',0,0,TO_DATE('2013-02-01 17:35:31','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-01 17:35:31','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','rt.Name,r.Name,ra.AssignDateFrom','Y','N','N')
;

-- Feb 1, 2013 5:35:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('17a5f650-9049-4f2c-9a8a-851adfde6710',TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,50002,200006,0,0,TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 5:35:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('a561e816-d6be-4dfa-beb0-e21a2e4b5b7a',TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,0,200006,0,0,TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 5:35:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('89c34226-1698-43a5-aea6-bfd37446e974',TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,102,200006,11,0,TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 5:35:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('0de49cf7-b149-4d0f-afb8-363c127b5372',TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,103,200006,11,0,TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 5:35:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('bf31ae8a-65a6-433b-ba82-a90fb516d823',TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,50001,200006,0,0,TO_DATE('2013-02-01 17:35:33','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 5:47:14 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET Name='Resource Info',Updated=TO_DATE('2013-02-01 17:47:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200006
;

-- Feb 1, 2013 5:50:56 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'d82b1f70-7216-4cbb-8b11-143f1f4712b4',30,200094,'Y','D',TO_DATE('2013-02-01 17:50:55','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 17:50:55','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Resource Type','Y','S_ResourceType_ID','Y','Y',1779,10,'=','r.S_ResourceType_ID','N',10)
;

-- Feb 1, 2013 5:56:58 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'8454a23b-a2a6-4e6d-baf0-05121ee60d69',30,200095,'Y','D','Resource',TO_DATE('2013-02-01 17:56:57','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 17:56:57','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Resource','Y','S_Resource_ID','Y','Y',1777,20,'=','ra.S_Resource_ID','N',20)
;

-- Feb 1, 2013 5:59:44 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'Assignment start','96b7bc9c-5ad8-452a-91ae-386d03af459e',16,200096,'N','D','Assign resource from',TO_DATE('2013-02-01 17:59:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 17:59:42','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Assign From','Y','AssignDateFrom','Y','Y',1754,30,'=','ra.AssignDateFrom','N',0)
;

-- Feb 1, 2013 6:00:39 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'Assignment start','949022a6-c556-4b03-8c79-b47f70f19b55',15,200097,'Y','D','Assign resource from',TO_DATE('2013-02-01 18:00:38','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 18:00:38','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Assign From','Y','AssignDateFrom','N','Y',1754,40,'=','Trunc','ra.AssignDateFrom','N',30)
;

-- Feb 1, 2013 6:01:29 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'The Quantity indicates the number of a specific product or item for this document.','b5c98913-c671-432a-9c30-cff270c2e885',29,200098,'N','D','Quantity',TO_DATE('2013-02-01 18:01:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 18:01:28','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Quantity','Y','Qty','Y','Y',526,50,'ra.Qty','N',0)
;

-- Feb 1, 2013 6:02:04 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'The UOM defines a unique non monetary Unit of Measure','79115caf-1198-4b7d-8686-22891387ac1c',19,200099,'N','D','Unit of Measure',TO_DATE('2013-02-01 18:02:03','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 18:02:03','YYYY-MM-DD HH24:MI:SS'),0,0,100,'UOM','Y','C_UOM_ID','Y','Y',215,60,'rt.C_UOM_ID','N',0)
;

-- Feb 1, 2013 6:02:35 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'Assignment end','faf5f6f0-03ed-45b0-a1cf-06a3e3da4198',16,200100,'N','D','Assign resource until',TO_DATE('2013-02-01 18:02:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 18:02:34','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Assign To','Y','AssignDateTo','Y','Y',1755,70,'ra.AssignDateTo','N',0)
;

-- Feb 1, 2013 6:03:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'Assignment end','1c79b0f1-45a7-4085-9ee0-9f366135db2a',15,200101,'Y','D','Assign resource until',TO_DATE('2013-02-01 18:03:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 18:03:19','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Assign To','Y','AssignDateTo','N','Y',1755,80,'<=','Trunc','ra.AssignDateTo','N',40)
;

-- Feb 1, 2013 6:03:51 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200006,'Resource assignment is confirmed','aed19869-3b74-410e-bb7c-82818067543f',20,200102,'N','D','Assignment is confirmed',TO_DATE('2013-02-01 18:03:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 18:03:50','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Confirmed','Y','IsConfirmed','Y','Y',1763,90,'ra.IsConfirmed','N',0)
;

-- Feb 1, 2013 6:04:40 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET WhereClause=NULL, OrderByClause='rt.Name,r.Name,ra.AssignDateFrom',Updated=TO_DATE('2013-02-01 18:04:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200006
;

-- Feb 1, 2013 6:04:45 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2013-02-01 18:04:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200006
;

-- Feb 1, 2013 6:05:33 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET QueryOperator='>=',Updated=TO_DATE('2013-02-01 18:05:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200097
;

-- Feb 1, 2013 8:54:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow (Processing,FromClause,AD_InfoWindow_UU,AD_InfoWindow_ID,AD_Table_ID,EntityType,Name,AD_Client_ID,AD_Org_ID,Created,Updated,UpdatedBy,CreatedBy,IsActive,IsDefault,IsDistinct,OrderByClause,IsValid) VALUES ('N','A_ASSET a
LEFT OUTER JOIN M_Product p ON (a.M_Product_ID=p.M_Product_ID)
LEFT OUTER JOIN C_BPartner bp ON (a.C_BPartner_ID=bp.C_BPartner_ID)
LEFT OUTER JOIN AD_User u ON (a.AD_User_ID=u.AD_User_ID)','ee3c56b0-7ce6-4a87-8e2d-8f3949b44cfe',200007,539,'D','Asset Info',0,0,TO_DATE('2013-02-01 20:54:36','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-02-01 20:54:36','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','Y','N','a.Value','N')
;

-- Feb 1, 2013 8:54:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('219211f2-74d8-44e3-9f19-4dcc7dd69ea5',TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,50002,200007,0,0,TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 8:54:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('524a55f4-480d-4018-a56f-adcd40edf0a1',TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,0,200007,0,0,TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 8:54:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('0f739fc0-0f22-4135-aa41-4dc1b425ddc0',TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,102,200007,11,0,TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 8:54:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('049f1b7b-3c6d-450e-9f53-a67be99fff17',TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,103,200007,11,0,TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 8:54:37 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoWindow_Access (AD_InfoWindow_Access_UU,Updated,UpdatedBy,AD_Role_ID,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive) VALUES ('04ab7578-8a89-47aa-9c17-d6fe29cd511d',TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,50001,200007,0,0,TO_DATE('2013-02-01 20:54:37','YYYY-MM-DD HH24:MI:SS'),100,'Y')
;

-- Feb 1, 2013 8:55:51 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).','29509b6e-f4db-4837-8e6f-9477e5bdbd74',10,200103,'Y','D','Search key for the record in the format required - must be unique',TO_DATE('2013-02-01 20:55:50','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 20:55:50','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Search Key','Y','Value','Y','Y',620,10,'Like','Upper','a.Value','Y',10)
;

-- Feb 1, 2013 8:57:22 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,QueryFunction,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.','aed603b1-71e3-4078-a9d6-95d9e942a9c2',10,200104,'Y','D','Alphanumeric identifier of the entity',TO_DATE('2013-02-01 20:57:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 20:57:21','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Name','Y','Name','Y','Y',469,20,'Like','Upper','a.Name','Y',40)
;

-- Feb 1, 2013 8:58:02 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'Identifies an item which is either purchased or sold in this organization.','76c53a60-2180-45d2-92b8-ef021ad8e6c5',30,200105,'Y','D','Product, Service, Item',TO_DATE('2013-02-01 20:58:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 20:58:01','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Product',231,'Y','M_Product_ID','Y','Y',454,30,'=','a.M_Product_ID','N',30)
;

-- Feb 1, 2013 8:58:24 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,QueryOperator,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'A Business Partner is anyone with whom you transact.  This can include Vendor, Customer, Employee or Salesperson','a2fff347-152a-493e-bad2-37db3897d4b1',30,200106,'Y','D','Identifies a Business Partner',TO_DATE('2013-02-01 20:58:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 20:58:23','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Business Partner ',230,'Y','C_BPartner_ID','Y','Y',187,40,'=','a.C_BPartner_ID','N',20)
;

-- Feb 1, 2013 8:58:53 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'The User identifies a unique user in the system. This could be an internal user or a business partner contact','41b64b80-d439-4ebc-8dbd-cf6ba5989a1a',19,200107,'N','D','User within the system - Internal or Business Partner Contact',TO_DATE('2013-02-01 20:58:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 20:58:52','YYYY-MM-DD HH24:MI:SS'),0,0,100,'User/Contact',123,'Y','AD_User_ID','Y','Y',138,50,'a.AD_User_ID','N',0)
;

-- Feb 1, 2013 8:59:20 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'The date when the asset was put into service - usually used as start date for depreciation.','53835ba3-98bf-402f-9616-306260b15366',15,200108,'N','D','Date when Asset was put into service',TO_DATE('2013-02-01 20:59:19','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 20:59:19','YYYY-MM-DD HH24:MI:SS'),0,0,100,'In Service Date','Y','AssetServiceDate','Y','Y',1934,60,'a.AssetServiceDate','N',0)
;

-- Feb 1, 2013 8:59:47 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,Help,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'Date when the normal guarantee or availability expires','b69e5993-2c1e-46ee-9e42-f4b99ce2bfb9',15,200109,'N','D','Date when guarantee expires',TO_DATE('2013-02-01 20:59:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 20:59:46','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Guarantee Date','Y','GuaranteeDate','Y','Y',1936,70,'a.GuaranteeDate','N',0)
;

-- Feb 1, 2013 9:00:02 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
INSERT INTO AD_InfoColumn (AD_InfoWindow_ID,AD_InfoColumn_UU,AD_Reference_ID,AD_InfoColumn_ID,IsQueryCriteria,EntityType,Description,Created,CreatedBy,Updated,AD_Client_ID,AD_Org_ID,UpdatedBy,Name,IsCentrallyMaintained,ColumnName,IsDisplayed,IsActive,AD_Element_ID,SeqNo,SelectClause,IsIdentifier,SeqNoSelection) VALUES (200007,'39d94f86-9901-4479-8d69-86f2bb05afed',10,200110,'N','D','Version Number',TO_DATE('2013-02-01 21:00:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-02-01 21:00:01','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Version No','Y','VersionNo','Y','Y',1949,80,'a.VersionNo','N',0)
;

-- Feb 1, 2013 9:00:15 PM MYT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2013-02-01 21:00:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200007
;

SELECT register_migration_script('201302040742_IDEMPIERE-325.sql') FROM dual
;
