-- May 15, 2021, 1:07:02 PM CEST
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200017,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:07:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:07:02','YYYY-MM-DD HH24:MI:SS'),100,'Payment Selection',426,'U','C_PaySelection a','N','057071a7-2467-44ac-b0d2-0fe91b76d46f','N','N','N',90,'Y',0,'Y',0)
;

-- May 15, 2021, 1:07:49 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200186,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:07:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:07:49','YYYY-MM-DD HH24:MI:SS'),100,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200017,'U','a.AD_Client_ID',10,'Y','N',102,19,'7a01d022-900b-4c57-b4a2-aeab4801a4a0',129,'Y','AD_Client_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:07:49 PM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2021-05-15 13:07:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200017
;

-- May 15, 2021, 1:08:25 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200187,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:08:25','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200017,'U','a.AD_Org_ID',20,'Y','N',113,19,'f5e1e8b6-5395-4755-a799-207c18fbf477',130,'Y','AD_Org_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:08:54 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200188,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:08:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:08:54','YYYY-MM-DD HH24:MI:SS'),100,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200017,'U','a.Name',30,'Y','Y',469,10,'bb88cf75-09b6-498f-9726-4b40da6f2ed5','Y','Name','Like','Upper','Y',10,'N','N','Y','N')
;

-- May 15, 2021, 1:09:52 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200189,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:09:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:09:52','YYYY-MM-DD HH24:MI:SS'),100,'Description','Optional short description of the record','A description is limited to 255 characters.',200017,'U','a.Description',40,'Y','Y',275,10,'9abc00da-e002-41f0-9947-aa77b2a74fa1','Y','Description','Like','Upper','N',20,'N','N','Y','N')
;

-- May 15, 2021, 1:10:28 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200190,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:10:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:10:28','YYYY-MM-DD HH24:MI:SS'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200017,'U','a.IsActive',50,'Y','N',348,20,'95f606af-116e-4a14-9c44-48acb0ac1491','Y','IsActive','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:11:00 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200191,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200017,'U','a.C_BankAccount_ID',60,'Y','N',836,19,'47d61bd5-0bd8-4171-87fd-d516ad4be13b','Y','C_BankAccount_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:11:33 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200192,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:11:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:11:33','YYYY-MM-DD HH24:MI:SS'),100,'Payment date','Date Payment made','The Payment Date indicates the date the payment was made.',200017,'U','a.PayDate',70,'Y','N',1538,15,'569d1f1c-a7b0-49fc-a8c0-6929598eec58','Y','PayDate','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:12:02 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200193,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:12:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:12:02','YYYY-MM-DD HH24:MI:SS'),100,'Approved','Indicates if this document requires approval','The Approved checkbox indicates if this document requires approval before it can be processed.',200017,'U','a.IsApproved',80,'Y','N',351,20,'4a1244fc-5844-4a5d-868a-19c31eb5a091','Y','IsApproved','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:12:43 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200194,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:12:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:12:43','YYYY-MM-DD HH24:MI:SS'),100,'One Payment Per Invoice',200017,'U','a.IsOnePaymentPerInvoice',90,'Y','N',203288,20,'e4a2ec38-cbbe-41af-bbf5-8168c17e7d42','Y','IsOnePaymentPerInvoice','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:13:11 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200195,0,0,'Y',TO_TIMESTAMP('2021-05-15 13:13:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 13:13:11','YYYY-MM-DD HH24:MI:SS'),100,'Total Amount','Total Amount','The Total Amount indicates the total document amount.',200017,'U','a.TotalAmt',100,'Y','N',1539,12,'cede490b-c693-45b4-85ec-e7e7b5872aa0','Y','TotalAmt','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:12:51 PM CEST
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200018,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:12:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:12:51','YYYY-MM-DD HH24:MI:SS'),100,'Element Value',188,'U','C_ElementValue a','N','04072da3-1e85-4226-9917-87d759495dd9','N','N','N',100,'Y',0,'Y',0)
;

-- May 15, 2021, 4:13:18 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200196,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:13:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:13:18','YYYY-MM-DD HH24:MI:SS'),100,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200018,'U','a.AD_Client_ID',10,'Y','N',102,19,'af7649dc-ce7f-4ac3-a16c-ae7f560a94f6',129,'Y','AD_Client_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:13:18 PM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2021-05-15 16:13:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200018
;

-- May 15, 2021, 4:13:40 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200197,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:13:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:13:39','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200018,'U','a.AD_Org_ID',20,'Y','N',113,19,'20d5889b-8a2e-4360-8f79-03d2b7c51900',104,'Y','AD_Org_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:14:40 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200198,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:14:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:14:40','YYYY-MM-DD HH24:MI:SS'),100,'Element','Accounting Element','The Account Element uniquely identifies an Account Type.  These are commonly known as a Chart of Accounts.',200018,'U','a.C_Element_ID',30,'Y','N',199,19,'b31ab2fe-2d02-4575-bec6-4cc35c78643f','Y','C_Element_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:17:51 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200199,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:17:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:17:51','YYYY-MM-DD HH24:MI:SS'),100,'Search Key','Search key for the record in the format required - must be unique','A search key allows you a fast method of finding a particular record.
If you leave the search key empty, the system automatically creates a numeric number.  The document sequence used for this fallback number is defined in the "Maintain Sequence" window with the name "DocumentNo_<TableName>", where TableName is the actual name of the table (e.g. C_Order).',200018,'U','a.Value',40,'Y','Y',620,10,'a64053ef-99f1-413e-9b2a-126c7e76dd9b','Y','Value','Like','Upper','Y',10,'N','N','Y','N')
;

-- May 15, 2021, 4:18:13 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200200,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:18:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:18:13','YYYY-MM-DD HH24:MI:SS'),100,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200018,'U','a.Name',50,'Y','Y',469,10,'b175cb3d-18bd-46b6-a19c-5726c53c0d10','Y','Name','Like','Upper','Y',20,'N','N','Y','N')
;

-- May 15, 2021, 4:18:32 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200201,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:18:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:18:32','YYYY-MM-DD HH24:MI:SS'),100,'Description','Optional short description of the record','A description is limited to 255 characters.',200018,'U','a.Description',60,'Y','Y',275,10,'0fdb8aa9-94bb-4081-9cef-04cf298a4a6b','Y','Description','Like','Upper','N',30,'N','N','Y','N')
;

-- May 15, 2021, 4:19:08 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200202,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:19:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:19:08','YYYY-MM-DD HH24:MI:SS'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200018,'U','a.IsActive',70,'Y','N',348,20,'e261693e-363f-44e3-8d2d-111b7c410d7b','Y','IsActive','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:20:33 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200203,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:20:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:20:32','YYYY-MM-DD HH24:MI:SS'),100,'Summary Level','This is a summary entity','A summary entity represents a branch in a tree rather than an end-node. Summary entities are used for reporting and do not have own values.',200018,'U','a.IsSummary',80,'Y','N',416,20,'62ea4e02-a054-4d1d-840f-6d96135a0e2e','Y','IsSummary','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:21:04 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200204,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:21:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:21:03','YYYY-MM-DD HH24:MI:SS'),100,'Account Type','Indicates the type of account','Valid account types are A - Asset, E - Expense, L - Liability, O- Owner''s Equity, R -Revenue and M- Memo.  The account type is used to determine what taxes, if any are applicable, validating payables and receivables for business partners.  Note:  Memo account amounts are ignored when checking for balancing',200018,'U','a.AccountType',90,'Y','N',147,17,'2b2ee91c-0839-4006-acce-8848a5b570df',117,'Y','AccountType','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:21:27 PM CEST
UPDATE AD_WListboxCustomization SET Custom='null=54px,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null',Updated=TO_TIMESTAMP('2021-05-15 16:21:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE ad_wlistboxcustomization_ID=1000225
;

-- May 15, 2021, 4:21:29 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200205,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:21:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:21:29','YYYY-MM-DD HH24:MI:SS'),100,'Post Actual','Actual Values can be posted','The Post Actual indicates if actual values can be posted to this element value.',200018,'U','a.PostActual',100,'Y','N',508,20,'c57168d0-840d-485b-9c46-073904d9f31f','Y','PostActual','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:21:50 PM CEST
UPDATE AD_WListboxCustomization SET Custom='null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null,null=null',Updated=TO_TIMESTAMP('2021-05-15 16:21:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE ad_wlistboxcustomization_ID=1000225
;

-- May 15, 2021, 4:21:53 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200206,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:21:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:21:52','YYYY-MM-DD HH24:MI:SS'),100,'Account Sign','Indicates the Natural Sign of the Account as a Debit or Credit','Indicates if the expected balance for this account should be a Debit or a Credit. If set to Natural, the account sign for an asset or expense account is Debit Sign (i.e. negative if a credit balance).',200018,'U','a.AccountSign',110,'Y','N',146,17,'d1c49971-878a-49e4-8ab8-9c32f27ce1bf',118,'Y','AccountSign','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:22:17 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200207,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:22:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:22:16','YYYY-MM-DD HH24:MI:SS'),100,'Post Budget','Budget values can be posted','The Post Budget indicates if budget values can be posted to this element value.',200018,'U','a.PostBudget',120,'Y','N',509,20,'ff6d58e4-72b5-427c-ae67-22a9f9f7a26b','Y','PostBudget','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:22:41 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200208,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:22:41','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:22:41','YYYY-MM-DD HH24:MI:SS'),100,'Document Controlled','Control account - If an account is controlled by a document, you cannot post manually to it',200018,'U','a.IsDocControlled',130,'Y','N',369,20,'e980c253-b57b-439a-9c54-24c879771d7b','Y','IsDocControlled','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:23:28 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200209,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:23:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:23:28','YYYY-MM-DD HH24:MI:SS'),100,'Post Statistical','Post statistical quantities to this account?',200018,'U','a.PostStatistical',140,'Y','N',511,20,'2f55fd40-e114-4cec-8378-ae2351b1d5d1','Y','PostStatistical','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:23:51 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200210,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:23:51','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:23:51','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Indicates if this is the Bank Account','The Bank Account checkbox indicates if this is account is the bank account.',200018,'U','a.IsBankAccount',150,'Y','N',1100,20,'6ed9a847-5fda-4e59-8853-7b613c125e41','Y','IsBankAccount','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:24:19 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200211,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:24:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:24:19','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200018,'U','a.C_BankAccount_ID',160,'Y','N',836,19,'eed10179-30ca-453b-8eb9-e95f94606436','Y','C_BankAccount_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:24:48 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200212,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:24:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:24:48','YYYY-MM-DD HH24:MI:SS'),100,'Foreign Currency Account','Balances in foreign currency accounts are held in the nominated currency','Balances in foreign currency accounts are held in the nominated currency and translated to functional currency',200018,'U','a.IsForeignCurrency',170,'Y','N',919,20,'3723f10d-6c34-4897-82ca-26cf0a0d38a3','Y','IsForeignCurrency','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:25:35 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200213,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:25:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:25:35','YYYY-MM-DD HH24:MI:SS'),100,'Currency','The Currency for this record','Indicates the Currency to be used when processing or reporting on this record',200018,'U','a.C_Currency_ID',180,'Y','N',193,19,'a97a5e82-0854-4259-a3f9-5c8cce2df2b1','Y','C_Currency_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:26:50 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200214,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:26:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:26:50','YYYY-MM-DD HH24:MI:SS'),100,'Manage Business Partners',200018,'U','a.IsDetailBPartner',190,'Y','N',202614,20,'915e769b-91f1-4f96-9c7e-9e4b718d38ea','Y','IsDetailBPartner','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:27:14 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Reference_Value_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200215,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:27:14','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:27:14','YYYY-MM-DD HH24:MI:SS'),100,'Business Partner Type',200018,'U','a.BPartnerType',200,'Y','N',202616,17,'216567f7-1708-42dc-8ef8-176021de12a0',200076,'Y','BPartnerType','N',0,'N','N','Y','N')
;

-- May 15, 2021, 4:27:44 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200216,0,0,'Y',TO_TIMESTAMP('2021-05-15 16:27:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-05-15 16:27:43','YYYY-MM-DD HH24:MI:SS'),100,'Manage Products',200018,'U','a.IsDetailProduct',210,'Y','N',202615,20,'f94ffa9d-3be9-49a7-a081-1b88efc9f677','Y','IsDetailProduct','N',0,'N','N','Y','N')
;

