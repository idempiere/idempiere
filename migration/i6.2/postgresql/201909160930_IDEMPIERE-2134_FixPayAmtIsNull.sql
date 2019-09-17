-- IDEMPIERE-2134 - Issues found on Payment Selection process : PayAmt is null
-- 2019-09-16 09:28:03
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Could not find Payment Amount for some invoices, maybe currency rate is not configured',0,0,'Y',TO_TIMESTAMP('2019-09-16 09:28:02','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2019-09-16 09:28:02','YYYY-MM-DD HH24:MI:SS'),0,200563,'PaySelectionPayAmtIsNull','D','6a5563d2-ddcc-4244-a6e8-3a85d93e08b1')
;

SELECT register_migration_script('201909160930_IDEMPIERE-2134_FixPayAmtIsNull.sql') FROM dual
;
