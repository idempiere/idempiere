-- IDEMPIERE-3532 - Remove hardcoded values for InfoInvoiceWindow (BPartnerID / IsSOTrx) and InfoPaymentWindow (IsSOTrx)
-- Oct 27, 2017 5:16:12 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@C_BPartner_ID@',Updated=TO_TIMESTAMP('2017-10-27 17:16:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_InfoColumn_ID=200052
;

-- Oct 27, 2017 5:16:25 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@SQL=SELECT ''@IsSOTrx:Y@'' AS DefaultValue FROM  DUAL',Updated=TO_TIMESTAMP('2017-10-27 17:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_InfoColumn_ID=200066
;

-- Oct 27, 2017 5:17:29 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@SQL=SELECT ''@IsSOTrx:Y@'' AS DefaultValue FROM  DUAL',Updated=TO_TIMESTAMP('2017-10-27 17:17:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_InfoColumn_ID=200085
;


SELECT register_migration_script('201705041136_IDEMPIERE-3338.sql') FROM dual
;
