-- IDEMPIERE-6177
SELECT register_migration_script('202406200834_IDEMPIERE-6177.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 20, 2024, 8:34:16 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Payment Not Allocated',0,0,'Y',TO_TIMESTAMP('2024-06-20 08:34:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-06-20 08:34:15','YYYY-MM-DD HH24:MI:SS'),100,200899,'PaymentNotAllocated','D','74a7869f-a5c8-4a32-b618-c276bdc8c699')
;

