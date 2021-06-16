SET SQLBLANKLINES ON
SET DEFINE OFF

-- May 15, 2021, 1:07:02 PM CEST
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Table_ID,EntityType,FromClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) VALUES (200017,0,0,'Y',TO_DATE('2021-05-15 13:07:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:07:02','YYYY-MM-DD HH24:MI:SS'),100,'Payment Selection',426,'U','C_PaySelection a','N','057071a7-2467-44ac-b0d2-0fe91b76d46f','N','N','N',90,'Y',0,'Y',0)
;

-- May 15, 2021, 1:07:49 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200186,0,0,'Y',TO_DATE('2021-05-15 13:07:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:07:49','YYYY-MM-DD HH24:MI:SS'),100,'Client','Client/Tenant for this installation.','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',200017,'U','a.AD_Client_ID',10,'Y','N',102,19,'7a01d022-900b-4c57-b4a2-aeab4801a4a0',129,'Y','AD_Client_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:07:49 PM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_DATE('2021-05-15 13:07:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200017
;

-- May 15, 2021, 1:08:25 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200187,0,0,'Y',TO_DATE('2021-05-15 13:08:25','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:08:25','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',200017,'U','a.AD_Org_ID',20,'Y','N',113,19,'f5e1e8b6-5395-4755-a799-207c18fbf477',130,'Y','AD_Org_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:08:54 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200188,0,0,'Y',TO_DATE('2021-05-15 13:08:54','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:08:54','YYYY-MM-DD HH24:MI:SS'),100,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',200017,'U','a.Name',30,'Y','Y',469,10,'bb88cf75-09b6-498f-9726-4b40da6f2ed5','Y','Name','Like','Upper','Y',10,'N','N','Y','N')
;

-- May 15, 2021, 1:09:52 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200189,0,0,'Y',TO_DATE('2021-05-15 13:09:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:09:52','YYYY-MM-DD HH24:MI:SS'),100,'Description','Optional short description of the record','A description is limited to 255 characters.',200017,'U','a.Description',40,'Y','Y',275,10,'9abc00da-e002-41f0-9947-aa77b2a74fa1','Y','Description','Like','Upper','N',20,'N','N','Y','N')
;

-- May 15, 2021, 1:10:28 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200190,0,0,'Y',TO_DATE('2021-05-15 13:10:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:10:28','YYYY-MM-DD HH24:MI:SS'),100,'Active','The record is active in the system','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',200017,'U','a.IsActive',50,'Y','N',348,20,'95f606af-116e-4a14-9c44-48acb0ac1491','Y','IsActive','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:11:00 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200191,0,0,'Y',TO_DATE('2021-05-15 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:10:59','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200017,'U','a.C_BankAccount_ID',60,'Y','N',836,19,'47d61bd5-0bd8-4171-87fd-d516ad4be13b','Y','C_BankAccount_ID','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:11:33 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200192,0,0,'Y',TO_DATE('2021-05-15 13:11:33','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:11:33','YYYY-MM-DD HH24:MI:SS'),100,'Payment date','Date Payment made','The Payment Date indicates the date the payment was made.',200017,'U','a.PayDate',70,'Y','N',1538,15,'569d1f1c-a7b0-49fc-a8c0-6929598eec58','Y','PayDate','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:12:02 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200193,0,0,'Y',TO_DATE('2021-05-15 13:12:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:12:02','YYYY-MM-DD HH24:MI:SS'),100,'Approved','Indicates if this document requires approval','The Approved checkbox indicates if this document requires approval before it can be processed.',200017,'U','a.IsApproved',80,'Y','N',351,20,'4a1244fc-5844-4a5d-868a-19c31eb5a091','Y','IsApproved','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:12:43 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200194,0,0,'Y',TO_DATE('2021-05-15 13:12:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:12:43','YYYY-MM-DD HH24:MI:SS'),100,'One Payment Per Invoice',200017,'U','a.IsOnePaymentPerInvoice',90,'Y','N',203288,20,'e4a2ec38-cbbe-41af-bbf5-8168c17e7d42','Y','IsOnePaymentPerInvoice','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:13:11 PM CEST
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,IsAutocomplete) VALUES (200195,0,0,'Y',TO_DATE('2021-05-15 13:13:11','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-05-15 13:13:11','YYYY-MM-DD HH24:MI:SS'),100,'Total Amount','Total Amount','The Total Amount indicates the total document amount.',200017,'U','a.TotalAmt',100,'Y','N',1539,12,'cede490b-c693-45b4-85ec-e7e7b5872aa0','Y','TotalAmt','N',0,'N','N','Y','N')
;

-- May 15, 2021, 1:07:49 PM CEST
UPDATE AD_InfoWindow SET IsValid='Y',Updated=TO_TIMESTAMP('2021-05-15 13:07:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoWindow_ID=200017
;
