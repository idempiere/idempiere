-- IDEMPIERE-3647 Better disposal of acknowledge flag in the e-mail dialog
-- 03/03/2018 15h10min45s BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Request a Read Receipt',0,0,'Y',TO_TIMESTAMP('2018-03-03 15:10:44','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2018-03-03 15:10:44','YYYY-MM-DD HH24:MI:SS'),0,200450,'RequestReadReceipt','D','8f7f20d2-e518-4ada-a271-013e4801f648')
;

SELECT register_migration_script('201803031514_IDEMPIERE-3647.sql') FROM dual
;
