-- IDEMPIERE-5985
SELECT register_migration_script('202508081025_IDEMPIERE-5985.sql') FROM dual;

-- Aug 8, 2025, 10:25:34 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate payment: payment is used on a counter document',0,0,'Y',TO_TIMESTAMP('2025-08-08 10:25:34','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-08-08 10:25:34','YYYY-MM-DD HH24:MI:SS'),10,200961,'PaymentReactivationFailedCounterDocument','D','c817c24d-9c02-4949-b611-996ab9885f66')
;

-- Aug 8, 2025, 10:25:55 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate payment: payment is used on a cash line',0,0,'Y',TO_TIMESTAMP('2025-08-08 10:25:55','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2025-08-08 10:25:55','YYYY-MM-DD HH24:MI:SS'),10,200962,'PaymentReactivationFailedCashLine','D','b73cfa6e-5563-4ddb-b32f-b2a0e07b20ae')
;

