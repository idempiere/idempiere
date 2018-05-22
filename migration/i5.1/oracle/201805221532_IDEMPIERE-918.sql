SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-918
-- May 22, 2018 3:17:13 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,IsServerProcess,ShowHelp,CopyFromProcess,AD_Process_UU) VALUES (200100,0,0,'Y',TO_DATE('2018-05-22 15:17:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 15:17:13','YYYY-MM-DD HH24:MI:SS'),100,'Create Credit Memo','Creates a credit memo based on the invoice.','The invoice should be correct and completed.','N','InvoiceCreateCreditMemo','N','org.idempiere.process.InvoiceCreateCreditMemo','1','D',0,0,'N','N','Y','N','68540275-9c56-4e1b-99f5-d155eb62a12b')
;

-- May 22, 2018 3:22:56 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200118,'C_DocTypeTarget AR/AP Credit Memos','Target Document Type AR/AP Credit Memos','S','C_DocType.DocBaseType IN (''ARC'',''APC'') AND C_DocType.IsSOTrx=''@IsSOTrx@''  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',0,0,'Y',TO_DATE('2018-05-22 15:22:56','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 15:22:56','YYYY-MM-DD HH24:MI:SS'),100,'D','b27e8ab7-8128-43b2-b94d-175c3f77e4cf')
;

-- May 22, 2018 3:24:44 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200228,0,0,'Y',TO_DATE('2018-05-22 15:24:44','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 15:24:44','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200100,10,19,'N',200118,10,'Y','C_DocType_ID','Y','D',196,'0022f86c-0629-4d70-84c3-cc6a506fdf7c','N')
;

-- May 22, 2018 3:28:49 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200229,0,0,'Y',TO_DATE('2018-05-22 15:28:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 15:28:49','YYYY-MM-DD HH24:MI:SS'),100,'Date Invoiced','Date printed on Invoice','The Date Invoice indicates the date printed on the invoice.',200100,20,15,'N',10,'Y','@#Date@','DateInvoiced','Y','D',267,'0c954e16-967b-4b48-9075-8a134b72e2d2','N')
;

-- May 22, 2018 3:29:12 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,DefaultValue,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200230,0,0,'Y',TO_DATE('2018-05-22 15:29:12','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 15:29:12','YYYY-MM-DD HH24:MI:SS'),100,'Account Date','Accounting Date','The Accounting Date indicates the date to be used on the General Ledger account entries generated from this document. It is also used for any currency conversion.',200100,30,15,'N',10,'Y','@#Date@','DateAcct','Y','D',263,'4edbbf7b-c6d3-4b3d-84b7-1591c204b91d','N')
;

-- May 22, 2018 3:30:49 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200231,0,0,'Y',TO_DATE('2018-05-22 15:30:49','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 15:30:49','YYYY-MM-DD HH24:MI:SS'),100,'Document Action','The targeted status of the document','You find the current status in the Document Status field. The options are listed in a popup',200100,40,17,135,'N',219,0,'N','DocAction','Y','D',287,'ce0b15c4-5e79-4dfd-b11b-0992911df4b4','N')
;

-- May 22, 2018 3:32:01 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo) VALUES (0,0,TO_DATE('2018-05-22 15:32:01','YYYY-MM-DD HH24:MI:SS'),100,'InvoiceCustomerCreateCreditMemo','Y',200096,'InvoiceCustomerCreateCreditMemo',TO_DATE('2018-05-22 15:32:01','YYYY-MM-DD HH24:MI:SS'),100,'N','ebf24687-2124-496b-89ee-5d75e05743a3','W',263,200100,'@DocStatus@=''CO'' | @DocStatus@=''CL''',10)
;

-- May 22, 2018 3:32:35 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo) VALUES (0,0,TO_DATE('2018-05-22 15:32:34','YYYY-MM-DD HH24:MI:SS'),100,'InvoiceVendorCreateCreditMemo','Y',200097,'InvoiceVendorCreateCreditMemo',TO_DATE('2018-05-22 15:32:34','YYYY-MM-DD HH24:MI:SS'),100,'N','2e2c53e9-4e1e-4789-8caf-c772e601e107','W',290,200100,'@DocStatus@=''CO'' | @DocStatus@=''CL''',10)
;

-- May 22, 2018 7:25:46 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Invoice has already allocations',0,0,'Y',TO_DATE('2018-05-22 19:25:46','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 19:25:46','YYYY-MM-DD HH24:MI:SS'),100,200471,'InvoiceHasAllocations','D','f0dc5362-437e-4fd9-bdc9-c8b472678765')
;

-- May 22, 2018 7:26:13 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Cannot create a credit memo from a credit memo',0,0,'Y',TO_DATE('2018-05-22 19:26:13','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 19:26:13','YYYY-MM-DD HH24:MI:SS'),100,200472,'CannotCreateCreditMemoFromCreditMemo','D','36370a38-ec58-4e1f-8804-e869a17730ac')
;

-- May 22, 2018 7:26:37 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Credit Memo already exists',0,0,'Y',TO_DATE('2018-05-22 19:26:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2018-05-22 19:26:37','YYYY-MM-DD HH24:MI:SS'),100,200473,'CreditMemoAlreadyExists','D','c67e63fc-4a41-45dc-b52c-317688b125d2')
;

SELECT register_migration_script('201805221532_IDEMPIERE-918.sql') FROM dual
;

