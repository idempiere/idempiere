-- IDEMPIERE-6883 Commission Run is zooming to Purchase Invoice
SELECT register_migration_script('202602271822_IDEMPIERE-6883.sql') FROM dual;

-- Feb 27, 2026, 6:22:18 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Price List Including Tax with Summary Tax not Allowed',0,0,'Y',TO_TIMESTAMP('2026-02-27 18:22:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-02-27 18:22:17','YYYY-MM-DD HH24:MI:SS'),100,200993,'PriceListIncludingTaxWithSummaryTaxNotAllowed','D','019ca01f-65f1-7630-b67d-db079217afec')
;

