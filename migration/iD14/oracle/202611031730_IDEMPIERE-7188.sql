-- IDEMPIERE-7188 - Payment Selection (manual) Info Window Conversion
SELECT register_migration_script('202611031730_IDEMPIERE-7188.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- 1. Validation Rule for PaymentRule based on BankAccountDoc
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Type,Code,EntityType,AD_Val_Rule_UU) 
VALUES (200211,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:30:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:30:00','YYYY-MM-DD HH24:MI:SS'),100,'C_BankAccountDoc PaymentRule of BankAccount','Payment rules configured for the bank account','S','AD_Ref_List.Value IN (SELECT PaymentRule FROM C_BankAccountDoc WHERE C_BankAccount_ID=@C_BankAccount_ID@ AND IsActive=''Y'')','D','01a1a6ad-c0fe-77e4-85b6-bfad85b4c01c')
;

-- Validation Rule for Bank Account with active BankAccountDoc
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Type,Code,EntityType,AD_Val_Rule_UU) 
VALUES (200212,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:30:08','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:30:08','YYYY-MM-DD HH24:MI:SS'),100,'C_BankAccount with active BankAccountDoc','Bank accounts having an active bank account document','S','C_BankAccount.IsActive=''Y'' AND EXISTS (SELECT 1 FROM C_BankAccountDoc d WHERE d.C_BankAccount_ID=C_BankAccount.C_BankAccount_ID AND d.IsActive=''Y'')','D','a282714d-18a3-4d2d-b056-bae9f93e0932')
;

-- 2. Create Info Window
INSERT INTO AD_InfoWindow (AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Table_ID,EntityType,FromClause,WhereClause,OrderByClause,Processing,AD_InfoWindow_UU,IsDefault,IsDistinct,IsValid,SeqNo,IsShowInDashboard,MaxQueryRecords,isLoadPageNum,PagingSize) 
VALUES (200026,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:30:16','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:30:16','YYYY-MM-DD HH24:MI:SS'),100,'Payment Selection (manual)','Select and generate payments from open invoices',318,'D',
'C_Invoice_v i 
INNER JOIN C_BPartner bp ON (i.C_BPartner_ID = bp.C_BPartner_ID) 
INNER JOIN C_Currency c ON (i.C_Currency_ID = c.C_Currency_ID) 
INNER JOIN C_PaymentTerm p ON (i.C_PaymentTerm_ID = p.C_PaymentTerm_ID)',
'i.DocStatus IN (''CO'', ''CL'') 
AND i.IsPaid = ''N'' 
AND invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID) != 0 
AND (i.C_InvoicePaySchedule_ID > 0 
	OR NOT EXISTS (
		SELECT 1 
		FROM C_PaySelectionLine psl 
		INNER JOIN C_PaySelectionCheck psc ON (psl.C_PaySelectionCheck_ID = psc.C_PaySelectionCheck_ID) 
		LEFT OUTER JOIN C_Payment pmt ON (pmt.C_Payment_ID = psc.C_Payment_ID) 
		WHERE psl.C_Invoice_ID = i.C_Invoice_ID 
		AND psl.IsActive = ''Y'' 
		AND (pmt.DocStatus IS NULL OR pmt.DocStatus NOT IN (''VO'', ''RE''))
	))',
'i.DueDate, bp.Name, i.C_Invoice_ID','N','9c1a35a8-d206-4cd8-950d-23e6627d8166','N','N','Y',30,'N',0,'Y',0)
;

-- 3. Create Info Columns
-- AD_Org_ID (Search Criteria only)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,DefaultValue) 
VALUES (200295,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:31:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:31:04','YYYY-MM-DD HH24:MI:SS'),100,'Organization','Organizational entity within client','An organization is a unit of your client or legal entity - examples are store, department.',200026,'D','i.AD_Org_ID',0,'N','Y',113,19,'2a266b03-7d37-4da4-82d9-282e9fe9b732',104,'Y','AD_Org_ID','=','N',10,'N','N','Y','@#AD_Org_ID@')
;

-- C_BankAccount_ID (Search Criteria only)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200296,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:31:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:31:37','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200026,'D','0',0,'N','Y',836,19,'d1a184ab-9c5c-4bd5-b396-9930884b1b7e',200212,'Y','C_BankAccount_ID','=','N',20,'Y','N','N')
;

-- PayDate (Search Criteria only, used by amount columns, status line and process parameter)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,DefaultValue) 
VALUES (200314,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:32:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:32:26','YYYY-MM-DD HH24:MI:SS'),100,'Payment Date','Date of Payment','The Payment Date indicates the date the payment is executed.',200026,'D','0',0,'N','Y',1538,15,'bd2ee285-52f1-4a1f-b76e-355b5c63cbfc','Y','PayDate','=','N',25,'Y','N','N','@#Date@')
;

-- PositiveBalance (Search Criteria only)
-- Expression is 'Y' when the business partner's open balance is positive, else 'N'.
-- Operator >= : checked ('Y') keeps only positive balances, unchecked ('N') keeps all.
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,DefaultValue) 
VALUES (200315,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:33:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:33:17','YYYY-MM-DD HH24:MI:SS'),100,'Only positive balance','Include only positive balance','Exclude business partners whose total open amount is zero or negative.',200026,'D','CASE WHEN (SELECT SUM(invoiceOpen(i1.C_Invoice_ID, i1.C_InvoicePaySchedule_ID)) FROM C_Invoice_v i1 WHERE i1.C_BPartner_ID = i.C_BPartner_ID AND i1.IsSOTrx = i.IsSOTrx AND i1.IsPaid = ''N'' AND i1.DocStatus IN (''CO'', ''CL'') AND i1.AD_Client_ID = i.AD_Client_ID) > 0 THEN ''Y'' ELSE ''N'' END',0,'N','Y',203357,20,'a02dd44d-c9ca-4b69-9f2e-cf5ca172997e','Y','PositiveBalance','>=','N',90,'N','N','N','Y')
;

-- C_BP_Group_ID (Search Criteria only)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200297,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:33:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:33:31','YYYY-MM-DD HH24:MI:SS'),100,'Business Partner Group','Business Partner Group','The Business Partner Group allows you to group Business Partners together for reporting purposes.',200026,'D','bp.C_BP_Group_ID',0,'N','Y',1383,19,'08d6dc08-4465-4b35-9efa-b2e15ec620ee','Y','C_BP_Group_ID','=','N',30,'N','N','Y')
;

-- C_DocType_ID (Search Criteria only)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200299,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:34:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:34:17','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules.',200026,'D','i.C_DocType_ID',0,'N','Y',196,19,'8048a01e-96f5-41ab-b460-867e4efc8e72',173,'Y','C_DocType_ID','=','N',50,'N','N','Y')
;

-- IsSOTrx (Search Criteria only)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly,DefaultValue) 
VALUES (200308,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:34:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:34:36','YYYY-MM-DD HH24:MI:SS'),100,'Sales Transaction','This is a Sales Transaction','Indicates if this transaction is a sales transaction or a purchase transaction.',200026,'D','i.IsSOTrx',0,'N','Y',1106,20,'18f3e574-bf74-4f6a-b655-3c4756e07c8c','Y','IsSOTrx','=','N',80,'N','N','Y','N')
;

-- PaymentRule (Hidden)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_InfoColumn_UU,AD_Val_Rule_ID,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200307,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:35:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:35:09','YYYY-MM-DD HH24:MI:SS'),100,'Payment Method','How you pay the invoice or get paid','The Payment Rule indicates the method of payment.',200026,'D','i.PaymentRule',0,'N','N',1143,17,195,'8aa452f6-52df-4b8c-98b9-c060d212e477',200211,'Y','PaymentRule','=','N',0,'N','N','Y')
;

-- 1. DueDate (Grid Col 1)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200302,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:35:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:35:26','YYYY-MM-DD HH24:MI:SS'),100,'Due Date','Date when the payment is due','The Due Date indicates the date when the payment is due according to the payment terms.',200026,'D','i.DueDate',10,'Y','Y',2000,15,'08546295-dae9-49ad-ad6c-a2ca5bcfc18b','Y','DueDate','<=','Trunc','N',70,'N','N','Y')
;

-- 2. C_BPartner_ID (Grid Col 2)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200298,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:35:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:35:52','YYYY-MM-DD HH24:MI:SS'),100,'Business Partner','Identifies a Business Partner','A Business Partner is anyone with whom you transact.',200026,'D','i.C_BPartner_ID',20,'Y','Y',187,30,'f7612493-477c-42ba-b641-a79798898a6e','Y','C_BPartner_ID','=','N',40,'N','N','Y')
;

-- 3. DocumentNo (Grid Col 3)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,QueryOperator,QueryFunction,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200300,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:36:09','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:36:09','YYYY-MM-DD HH24:MI:SS'),100,'Document No','Document sequence number of the document','The document number is usually automatically generated by the system.',200026,'D','i.DocumentNo',30,'Y','Y',290,10,'6c0d24c1-71d4-4956-a845-8383c5ae75ee','Y','DocumentNo','Like','Upper','N',60,'N','N','Y')
;

-- 4. DateInvoiced (Grid Col 4)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200301,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:36:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:36:15','YYYY-MM-DD HH24:MI:SS'),100,'Date Invoiced','Date printed on Invoice','The Date Invoice indicates the date printed on the invoice.',200026,'D','i.DateInvoiced',40,'Y','N',267,15,'3c149ba1-ef42-4590-baf2-7d06941d6544','Y','DateInvoiced','N',0,'N','N','Y')
;

-- 5. C_Currency_ID (Grid Col 5)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200303,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:36:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:36:27','YYYY-MM-DD HH24:MI:SS'),100,'Currency','The Currency for this record','The Currency defines the currency for this document.',200026,'D','i.C_Currency_ID',50,'Y','N',193,19,'6b4e740a-14e1-40a0-8f1e-029db0031f5a','Y','C_Currency_ID','N',0,'N','N','Y')
;

-- 6. GrandTotal (Grid Col 6)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200304,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:37:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:37:13','YYYY-MM-DD HH24:MI:SS'),100,'Total Amount','Total of all document lines with tax','Total Amount includes tax and all lines.',200026,'D','i.GrandTotal',60,'Y','N',316,12,'7930f302-e972-4b69-a8aa-1f227824bfcb','Y','GrandTotal','N',0,'N','N','Y')
;

-- 7. DiscountAmt (Grid Col 7)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200310,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:37:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:37:28','YYYY-MM-DD HH24:MI:SS'),100,'Discount Amount','Calculated amount of discount','The Discount Amount indicates the amount of discount allocated.',200026,'D','invoiceDiscount(i.C_Invoice_ID, COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate()), i.C_InvoicePaySchedule_ID)',70,'Y','N',1395,12,'50e271a4-93ab-4e3e-b769-cf6c17246532','Y','DiscountAmt','N',0,'N','N','Y')
;

-- 8. WriteOffAmt (Grid Col 8)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200311,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:38:22','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:38:22','YYYY-MM-DD HH24:MI:SS'),100,'Write-off Amount','Amount to write-off','The Write Off Amount indicates the amount to be written off.',200026,'D','invoiceWriteOff(i.C_Invoice_ID)',80,'Y','N',1450,12,'78cf1815-46b7-4467-b501-c9fe93f0b093','Y','WriteOffAmt','N',0,'N','N','Y')
;

-- 9. DiscountDate (Grid Col 9)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200306,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:39:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:39:15','YYYY-MM-DD HH24:MI:SS'),100,'Discount Date','Last day for early payment discount','The last date on which the payment discount can be taken.',200026,'D','COALESCE((SELECT ips.DiscountDate FROM C_InvoicePaySchedule ips WHERE ips.C_InvoicePaySchedule_ID = i.C_InvoicePaySchedule_ID), i.DateInvoiced + p.DiscountDays + p.GraceDays)',90,'Y','N',1998,15,'fb1eb2a3-8f17-4884-ae0b-358512b588a2','Y','DiscountDate','N',0,'N','N','Y')
;

-- 10. DueAmt (Grid Col 10 - Converted to Bank Account Currency)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200309,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:39:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:39:40','YYYY-MM-DD HH24:MI:SS'),100,'Amount Due (Bank Curr)','Amount due converted to Bank Account Currency','The Amount Due indicates the open amount converted to the Bank Account currency.',200026,'D','COALESCE(currencyConvertInvoice(i.C_Invoice_ID, (SELECT C_Currency_ID FROM C_BankAccount WHERE C_BankAccount_ID=@C_BankAccount_ID@), invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID), COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate())), invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID))',100,'Y','N',1999,12,'45fc6b72-23c1-4b72-972a-9e1205164d93','N','DueAmt','N',0,'N','N','Y')
;

-- 11. PayAmt (Grid Col 11 - Converted to Bank Account Currency)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200305,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:39:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:39:50','YYYY-MM-DD HH24:MI:SS'),100,'Payment Amount (Bank Curr)','Payment amount converted to Bank Account Currency','The Payment Amount indicates the open amount less discount converted to the Bank Account currency.',200026,'D','COALESCE(currencyConvertInvoice(i.C_Invoice_ID, (SELECT C_Currency_ID FROM C_BankAccount WHERE C_BankAccount_ID=@C_BankAccount_ID@), invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID) - invoiceDiscount(i.C_Invoice_ID, COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate()), i.C_InvoicePaySchedule_ID), COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate())), invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID) - invoiceDiscount(i.C_Invoice_ID, COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate()), i.C_InvoicePaySchedule_ID))',110,'Y','N',1477,12,'defdcbf7-5ce3-4e18-b9d4-560b66b26004','N','PayAmt','N',0,'N','N','Y')
;

-- 12. C_InvoicePaySchedule_ID (Row Key - Hidden)
INSERT INTO AD_InfoColumn (AD_InfoColumn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_InfoWindow_ID,EntityType,SelectClause,SeqNo,IsDisplayed,IsQueryCriteria,AD_Element_ID,AD_Reference_ID,AD_InfoColumn_UU,IsCentrallyMaintained,ColumnName,IsIdentifier,SeqNoSelection,IsMandatory,IsKey,IsReadOnly) 
VALUES (200313,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:40:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:40:24','YYYY-MM-DD HH24:MI:SS'),100,'Invoice Payment Schedule','Invoice Payment Schedule','Invoice Payment Schedule',200026,'D','COALESCE(i.C_InvoicePaySchedule_ID, -i.C_Invoice_ID)',0,'N','N',1995,13,'e03cbdf6-72aa-4c57-85ba-b08bc8827fa1','Y','C_InvoicePaySchedule_ID','N',0,'N','Y','Y')
;

-- 4. Create Element, Process and Parameters
-- AD_Element for IsCreatePayments
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,Description,Help,EntityType,AD_Element_UU) 
VALUES (204134,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:40:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:40:49','YYYY-MM-DD HH24:MI:SS'),100,'IsCreatePayments','Create Payments Immediately','Create Payments Immediately','Create checks / payments immediately','If checked, checks or payments are generated immediately after creating the selection batch.','D','70c24071-e019-4dee-b692-e5af8345a8c8')
;

INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) 
VALUES (200173,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:41:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:41:33','YYYY-MM-DD HH24:MI:SS'),100,'Pay Selection Create From Info Window','Create Payment Selection and Lines from Info Window selection','Processes selected open invoices and creates a payment selection with lines.', 'N','PaySelectionCreateFromInfoWindow','N','org.compiere.process.PaySelectionCreateFromInfoWindow','3','D',0,0,'N','Y','N','8b4d2464-a650-4743-bbce-a069f7ae24d2','P')
;

-- Process Parameters
-- C_BankAccount_ID
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Val_Rule_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) 
VALUES (200523,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:42:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:42:10','YYYY-MM-DD HH24:MI:SS'),100,'Bank Account','Account at the Bank','The Bank Account identifies an account at this Bank.',200173,10,19,200212,'N',10,'Y','@C_BankAccount_ID@','C_BankAccount_ID','Y','D',836,'c2a19245-663e-4998-9822-5f0f7b14027a','N','N')
;

-- PayDate
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) 
VALUES (200524,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:42:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:42:49','YYYY-MM-DD HH24:MI:SS'),100,'Payment Date','Date of Payment','The Payment Date indicates the date the payment is executed.',200173,20,15,'N',0,'Y','@PayDate@;@#Date@','PayDate','Y','D',1538,'ad89cff3-767f-4caf-9e0a-62916a459d2b','N','N')
;

-- PaymentRule
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,AD_Val_Rule_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) 
VALUES (200525,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:43:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:43:35','YYYY-MM-DD HH24:MI:SS'),100,'Payment Method','How you pay the invoice or get paid','The Payment Rule indicates the method of payment.',200173,30,17,195,200211,'N',1,'Y','@PaymentRule@','PaymentRule','Y','D',1143,'ad58f333-36e6-4a80-bf3c-0189f540aa7a','N','N')
;

-- IsOnePaymentPerInvoice
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) 
VALUES (200526,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:44:21','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:44:21','YYYY-MM-DD HH24:MI:SS'),100,'One Payment per Invoice','Create one payment per invoice instead of grouping by partner','If checked, each invoice generates its own payment/check.',200173,40,20,'N',1,'Y','N','IsOnePaymentPerInvoice','Y','D',203288,'6313e021-c2b7-4640-86a5-fbde465750b9','N','N')
;

-- IsCreatePayments
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted,IsAutocomplete) 
VALUES (200527,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:44:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:44:48','YYYY-MM-DD HH24:MI:SS'),100,'Create Payments Immediately','Create checks / payments immediately','If checked, checks or payments are generated immediately after creating the selection batch.',200173,50,20,'N',1,'Y','N','IsCreatePayments','Y','D',204134,'a0de2763-2f87-4b60-875a-8c67719c2085','N','N')
;

-- 5. Link Process to Info Window via AD_InfoProcess
INSERT INTO AD_InfoProcess (AD_InfoProcess_ID,AD_InfoProcess_UU,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,SeqNo,AD_Process_ID,AD_InfoWindow_ID,LayoutType,EntityType) 
VALUES (200016,'21ede3f3-7ec3-4fce-824c-3d987d59a93d',0,0,'Y',TO_TIMESTAMP('2026-11-03 17:45:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:45:06','YYYY-MM-DD HH24:MI:SS'),100,10,200173,200026,'B','D')
;

-- 6. Configure Quick Info Status Line & Message
INSERT INTO AD_Message (AD_Message_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Value,MsgText,MsgType,EntityType,AD_Message_UU) 
VALUES (201072,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:45:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:45:49','YYYY-MM-DD HH24:MI:SS'),100,'PaySelectionQuickInfoTotal','<b>Selected:</b> {0} <br/><b>Bank Balance:</b> {1,number,#,##0.00} {4} <br/><b>Total Pay (Bank Curr):</b> {2,number,#,##0.00} {4} <br/><b>Remaining Bank Balance:</b> {3,number,#,##0.00} {4} <br/>','I','D','9258e453-3149-4ca1-8abc-94dcf2213b50')
;

-- AD_StatusLine
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,AD_Message_ID,SQLStatement,EntityType,AD_StatusLine_UU) 
VALUES (200026,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:46:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:46:05','YYYY-MM-DD HH24:MI:SS'),100,'Pay Selection Info Window Quick Info',201072,
'SELECT COUNT(1), ba.CurrentBalance, COALESCE(SUM(currencyConvertInvoice(i.C_Invoice_ID, ba.C_Currency_ID, invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID) - invoiceDiscount(i.C_Invoice_ID, COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate()), i.C_InvoicePaySchedule_ID), COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate()))), 0), ba.CurrentBalance - COALESCE(SUM(currencyConvertInvoice(i.C_Invoice_ID, ba.C_Currency_ID, invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID) - invoiceDiscount(i.C_Invoice_ID, COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate()), i.C_InvoicePaySchedule_ID), COALESCE(TO_DATE(NULLIF(SUBSTR(''@PayDate@'',1,10),''''),''YYYY-MM-DD''), getDate()))), 0), c.ISO_Code FROM C_Invoice_v i CROSS JOIN C_BankAccount ba JOIN C_Currency c ON (c.C_Currency_ID = ba.C_Currency_ID) WHERE ba.C_BankAccount_ID = @C_BankAccount_ID@ AND COALESCE(i.C_InvoicePaySchedule_ID, -i.C_Invoice_ID) IN (@_IWInfoIDs_Selected@) GROUP BY ba.CurrentBalance, ba.C_Currency_ID, c.ISO_Code',
'D','8a047524-180d-46db-afbc-91f02294fe56')
;

-- AD_StatusLineUsedIn
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_StatusLine_ID,SeqNo,IsStatusLine,AD_InfoWindow_ID,EntityType,AD_StatusLineUsedIn_UU) 
VALUES (200046,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:46:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:46:38','YYYY-MM-DD HH24:MI:SS'),100,200026,10,'N',200026,'D','7e07f743-a938-49e2-a436-c310c64537ce')
;

-- 7. Create Menu
INSERT INTO AD_Menu (AD_Menu_ID,Name,Description,Action,AD_InfoWindow_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsSummary,IsSOTrx,IsReadOnly,EntityType,IsCentrallyMaintained,AD_Menu_UU) 
VALUES (200256,'Payment Selection (manual)','Select and generate payments from open invoices','I',200026,0,0,'Y',TO_TIMESTAMP('2026-11-03 17:47:10','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-11-03 17:47:10','YYYY-MM-DD HH24:MI:SS'),100,'N','N','N','D','Y','01a1a559-41c5-7ff1-87ce-a54ba8d3c875')
;

INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Tree_ID,Node_ID,Parent_ID,SeqNo,AD_TreeNodeMM_UU) 
SELECT t.AD_Client_ID, 0, 'Y', TO_TIMESTAMP('2026-11-03 17:47:29','YYYY-MM-DD HH24:MI:SS'), 100, TO_TIMESTAMP('2026-11-03 17:47:29','YYYY-MM-DD HH24:MI:SS'), 100, t.AD_Tree_ID, 200256, COALESCE(n.Parent_ID, 0), COALESCE(n.SeqNo + 1, 999), 'a3662361-01f3-4fc8-8a8a-47ff75f8fbd5' 
FROM AD_Tree t 
LEFT JOIN AD_TreeNodeMM n ON (n.AD_Tree_ID = t.AD_Tree_ID AND n.Node_ID = 286) 
WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' 
  AND NOT EXISTS (SELECT 1 FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND e.Node_ID=200256)
;

-- 8. Deactivate menu of the replaced Payment Selection (manual) form
UPDATE AD_Menu SET IsActive='N', Updated=TO_TIMESTAMP('2026-11-03 17:48:17','YYYY-MM-DD HH24:MI:SS'), UpdatedBy=100 
WHERE AD_Form_ID IN (SELECT AD_Form_ID FROM AD_Form WHERE Classname='org.compiere.apps.form.VPaySelect') 
  AND AD_Client_ID=0
;
