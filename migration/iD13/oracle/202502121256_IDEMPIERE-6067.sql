-- IDEMPIERE-6067
SELECT register_migration_script('202502121256_IDEMPIERE-6067.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 12, 2025, 12:56:41 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate invoice: invoice is allocated',0,0,'Y',TO_TIMESTAMP('2025-02-12 12:56:40','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-12 12:56:40','YYYY-MM-DD HH24:MI:SS'),10,200935,'InvoiceReactivationFailedAllocationLine','D','053026a2-cce7-47fe-b3d1-b43d65549b71')
;

-- Feb 12, 2025, 12:57:50 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate invoice: invoice is used on a Match Invoice record',0,0,'Y',TO_TIMESTAMP('2025-02-12 12:57:50','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-12 12:57:50','YYYY-MM-DD HH24:MI:SS'),10,200936,'InvoiceReactivationFailedMatchInvoice','D','06cc4b28-08c4-456f-bdf1-133bb242aa73')
;

-- Feb 12, 2025, 12:58:02 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate invoice: invoice is used on a Match PO record',0,0,'Y',TO_TIMESTAMP('2025-02-12 12:58:02','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-02-12 12:58:02','YYYY-MM-DD HH24:MI:SS'),10,200937,'InvoiceReactivationFailedMatchPO','D','8e9726ff-39a3-44e5-84ce-c200068fbff6')
;

