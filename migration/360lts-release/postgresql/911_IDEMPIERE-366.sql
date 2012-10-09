-- Sep 17, 2012 5:24:55 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND C_DocType.IsSOTrx=''@IsSOTrx@''  AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:24:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=124
;

-- Sep 17, 2012 5:25:09 PM COT
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''GLD'' AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:25:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=121
;

-- Sep 17, 2012 5:25:14 PM COT
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:25:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=173
;

-- Sep 17, 2012 5:25:30 PM COT
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''MMR'') AND IsSOTrx=''N'' AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:25:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=52054
;

-- Sep 17, 2012 5:25:38 PM COT
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''MMR'', ''MMS'') AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:25:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=125
;

-- Sep 17, 2012 5:25:44 PM COT
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''MMM'' AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:25:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=201
;

-- Sep 17, 2012 5:25:49 PM COT
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''DOO'' AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:25:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=52004
;

-- Sep 17, 2012 5:26:19 PM COT
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''SOO'', ''POO'') AND C_DocType.DocSubTypeSO=''RM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND IsSOTrx=''N'' AND AD_Client_ID=@AD_Client_ID@',Updated=TO_TIMESTAMP('2012-09-17 17:26:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Val_Rule_ID=52066
;

SELECT register_migration_script('911_IDEMPIERE-366.sql') FROM dual
;

