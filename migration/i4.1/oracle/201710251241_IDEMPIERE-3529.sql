SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3529 - Add parameters to InvoicePrint process
-- Oct 25, 2017 12:09:30 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200219,0,0,'Y',TO_DATE('2017-10-25 12:09:30','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-10-25 12:09:30','YYYY-MM-DD HH24:MI:SS'),100,'Document Type','Document type or rules','The Document Type determines document sequence and processing rules',200,60,19,170,'N',124,0,'N','C_DocType_ID','Y','D',196,'554013bb-d6c0-4795-a9c6-aa2cb6dfc2bf','N')
;

-- Oct 25, 2017 12:16:28 PM CEST
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,AD_Process_Para_UU,IsEncrypted) VALUES (200220,0,0,'Y',TO_DATE('2017-10-25 12:16:28','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-10-25 12:16:28','YYYY-MM-DD HH24:MI:SS'),100,'Paid','The document is paid',200,70,17,319,'N',0,'N','IsPaid','Y','D',1402,'7d2f7567-fb4f-44b0-a098-ddaa81ca7a4f','N')
;

SELECT register_migration_script('201710251241_IDEMPIERE-3529.sql') FROM dual
;
