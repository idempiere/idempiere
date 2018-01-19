-- IDEMPIERE-3529 Add parameters to InvoicePrint process
-- Jan 11, 2018 7:02:29 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200222,0,0,'Y',TO_TIMESTAMP('2018-01-11 19:02:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-11 19:02:28','YYYY-MM-DD HH24:MI:SS'),100,'Printed','Indicates if this document / line is printed','The Printed checkbox indicates if this document or line will included when printing.',200,80,17,319,'N',0,'N','IsPrinted','Y','D',399,'24d72545-9015-4b87-921d-7de97eaa5079','N')
;

-- Jan 11, 2018 7:03:51 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200223,0,0,'Y',TO_TIMESTAMP('2018-01-11 19:03:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-11 19:03:50','YYYY-MM-DD HH24:MI:SS'),100,'Payment Rule','How you pay the invoice','The Payment Rule indicates the method of invoice payment.',200,90,200012,'N',1,'N','PaymentRule','Y','D',1143,'d7b2cef8-86cc-4a2d-91c2-ea452a71ffa3','N')
;

-- Jan 11, 2018 7:05:08 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200224,0,0,'Y',TO_TIMESTAMP('2018-01-11 19:05:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-11 19:05:07','YYYY-MM-DD HH24:MI:SS'),100,'Payment Term','The terms of Payment (timing, discount)','Payment Terms identify the method and timing of payment.',200,100,19,'N',52098,22,'N','C_PaymentTerm_ID','Y','D',204,'77ec6576-ac60-48b8-a072-63af04afd7b5','N')
;

-- Jan 11, 2018 7:06:08 PM CET
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200225,0,0,'Y',TO_TIMESTAMP('2018-01-11 19:06:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-11 19:06:07','YYYY-MM-DD HH24:MI:SS'),100,'Document Status','The current status of the document','The Document Status indicates the status of a document at this time.  If you want to change the document status, use the Document Action field',200,110,17,131,'N',0,'N','DocStatus','Y','D',289,'409de69f-31b2-4742-8339-7a0a30272480','N')
;

SELECT register_migration_script('201801111909_IDEMPIERE-3529.sql') FROM dual
;
