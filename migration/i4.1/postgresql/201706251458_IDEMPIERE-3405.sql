-- IDEMPIERE-3405
-- Jun 25, 2017 2:58:01 PM CEST
UPDATE AD_Val_Rule SET Code='(C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND C_DocType.IsSOTrx=''@IsSOTrx@''  AND C_DocType.AD_Client_ID=@#AD_Client_ID@) OR C_DocType.C_DocType_ID=0',Updated=TO_TIMESTAMP('2017-06-25 14:58:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200097
;

-- Jun 25, 2017 2:58:15 PM CEST
UPDATE AD_Val_Rule SET Code='(C_DocType.DocBaseType IN (''SOO'', ''POO'') AND C_DocType.IsSOTrx=''@IsSOTrx@'' AND COALESCE(C_DocType.DocSubTypeSO,'' '')<>''RM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@) OR C_DocType.C_DocType_ID=0',Updated=TO_TIMESTAMP('2017-06-25 14:58:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200096
;

SELECT register_migration_script('201706251458_IDEMPIERE-3405.sql') FROM dual
;

