-- IDEMPIERE-3714 Shipment Parameter on Generate Invoices
-- 16/05/2018 15h44min26s BRT
INSERT INTO AD_Process_Para (AD_Process_Para_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,AD_Process_ID,SeqNo,AD_Reference_ID,AD_Reference_Value_ID,IsRange,AD_Val_Rule_ID,FieldLength,IsMandatory,ColumnName,IsCentrallyMaintained,EntityType,AD_Element_ID,DisplayLogic,AD_Process_Para_UU,IsEncrypted) VALUES (200227,0,0,'Y',TO_TIMESTAMP('2018-05-16 15:44:25','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-05-16 15:44:25','YYYY-MM-DD HH24:MI:SS'),100,'Shipment/Receipt','Material Shipment Document','The Material Shipment / Receipt ',119,70,30,337,'N',52055,0,'N','M_InOut_ID','Y','D',1025,'@C_Order_ID@<1','4bedf18d-4f2a-46cb-8cc1-11f7a739ecff','N')
;

SELECT register_migration_script('201805161551_IDEMPIERE-3714.sql') FROM dual
;
