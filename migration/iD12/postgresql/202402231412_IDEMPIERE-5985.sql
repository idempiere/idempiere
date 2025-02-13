-- IDEMPIERE-5985: Reactivation of Payments
SELECT register_migration_script('202402231412_IDEMPIERE-5985.sql') FROM dual;

-- Feb 23, 2024, 2:12:23 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate payment: payment is allocated',0,0,'Y',TO_TIMESTAMP('2024-02-23 14:12:23','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-23 14:12:23','YYYY-MM-DD HH24:MI:SS'),100,200871,'PaymentReactivationFailedAllocationLine','D','7eb77729-a6b0-4af8-8e86-9ae3f60b7437')
;

-- Feb 23, 2024, 2:13:18 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate payment: payment is used on a bank statement line',0,0,'Y',TO_TIMESTAMP('2024-02-23 14:13:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-23 14:13:17','YYYY-MM-DD HH24:MI:SS'),100,200872,'PaymentReactivationFailedBankStatementLine','D','e4bd2203-d1bb-4526-9b1d-261e4e0582e4')
;

-- Feb 23, 2024, 2:13:32 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate payment: payment is used in a bank transfer',0,0,'Y',TO_TIMESTAMP('2024-02-23 14:13:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-23 14:13:31','YYYY-MM-DD HH24:MI:SS'),100,200873,'PaymentReactivationFailedBankTransfer','D','f9a1d305-1da1-4ef2-b7d8-c932491a2810')
;

-- Feb 23, 2024, 2:13:42 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate payment: payment is used on a dunning run line',0,0,'Y',TO_TIMESTAMP('2024-02-23 14:13:42','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-23 14:13:42','YYYY-MM-DD HH24:MI:SS'),100,200874,'PaymentReactivationFailedDunningLine','D','346a7d10-9a4a-45e5-a6c7-b40436944e25')
;

-- Feb 23, 2024, 2:13:49 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not reactivate payment: payment is used on a request',0,0,'Y',TO_TIMESTAMP('2024-02-23 14:13:49','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-02-23 14:13:49','YYYY-MM-DD HH24:MI:SS'),100,200875,'PaymentReactivationFailedRequest','D','4f09002b-4f40-42f1-a51b-fcb94c81cc99')
;

