-- IDEMPIERE-3532 - Remove hardcoded values for InfoInvoiceWindow (BPartnerID / IsSOTrx) and InfoPaymentWindow (IsSOTrx)
-- Oct 27, 2017 5:16:12 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@C_BPartner_ID@',Updated=TO_TIMESTAMP('2017-10-27 17:16:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_InfoColumn_ID=200052
;

-- Oct 27, 2017 5:16:25 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@IsSOTrx:Y@',Updated=TO_TIMESTAMP('2017-10-27 17:16:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_InfoColumn_ID=200066
;

-- Oct 27, 2017 5:17:29 PM CEST
UPDATE AD_InfoColumn SET DefaultValue='@IsSOTrx:Y@',Updated=TO_TIMESTAMP('2017-10-27 17:17:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_InfoColumn_ID=200085
;

-- Nov 8, 2017 11:04:30 AM CET
UPDATE AD_InfoColumn SET DefaultValue='@C_BPartner_ID@',Updated=TO_TIMESTAMP('2017-11-08 11:04:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200039
;

-- Nov 8, 2017 11:04:58 AM CET
UPDATE AD_InfoColumn SET DefaultValue='@IsSOTrx:Y@',Updated=TO_TIMESTAMP('2017-11-08 11:04:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200051
;

-- Nov 8, 2017 11:05:07 AM CET
UPDATE AD_InfoColumn SET DefaultValue='@IsSOTrx:Y@',Updated=TO_TIMESTAMP('2017-11-08 11:05:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200078
;

-- Nov 8, 2017 11:07:22 AM CET
UPDATE AD_InfoColumn SET DefaultValue='@SQL=SELECT CASE ''@BaseTable_ID:0@'' WHEN ''335'' THEN ''N'' ELSE '''' END AS DefaultValue FROM DUAL',Updated=TO_TIMESTAMP('2017-11-08 11:07:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200065
;

SELECT register_migration_script('201710271720_IDEMPIERE-3532.sql') FROM dual
;
