-- IDEMPIERE-5304
SELECT register_migration_script('202205261621_IDEMPIERE-5304.sql') FROM dual;

-- May 26, 2022, 4:21:54 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Business Partner is different from Invoice - Business Partner',0,0,'Y',TO_TIMESTAMP('2022-05-26 16:21:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-26 16:21:53','YYYY-MM-DD HH24:MI:SS'),100,200757,'BPDifferentFromBPInvoice','D','a67cc8e4-94e3-449e-aacb-55a45ae7f4fd')
;

-- May 26, 2022, 4:22:12 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Business Partner is different from Order - Business Partner',0,0,'Y',TO_TIMESTAMP('2022-05-26 16:22:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-05-26 16:22:12','YYYY-MM-DD HH24:MI:SS'),100,200758,'BPDifferentFromBPOrder','D','d7547154-6d4f-490f-ba2f-c90ef83604c0')
;

