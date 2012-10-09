-- Sep 21, 2012 8:07:08 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''SOO'', ''POO'') AND C_DocType.DocSubTypeSO=''RM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND IsSOTrx=''N''',Updated=TO_DATE('2012-09-21 20:07:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52066
;

-- Sep 21, 2012 8:07:15 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARR'', ''APP'')  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:07:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=149
;

-- Sep 21, 2012 8:07:20 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''DOO'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:07:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52004
;

-- Sep 21, 2012 8:07:24 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''MMM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:07:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=201
;

-- Sep 21, 2012 8:07:28 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''MMR'', ''MMS'') AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:07:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=125
;

-- Sep 21, 2012 8:07:42 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''MMR'') AND C_DocType.IsSOTrx=''N'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:07:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52054
;

-- Sep 21, 2012 8:08:05 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''SOO'', ''POO'') AND C_DocType.DocSubTypeSO=''RM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@ AND C_DocType.IsSOTrx=''N''',Updated=TO_DATE('2012-09-21 20:08:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=52066
;

-- Sep 21, 2012 8:08:26 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''MMI'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:08:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=209
;

-- Sep 21, 2012 8:08:30 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''GLJ'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:08:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=102
;

-- Sep 21, 2012 8:08:36 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:08:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=173
;

-- Sep 21, 2012 8:08:41 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType=''GLD'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:08:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=121
;

-- Sep 21, 2012 8:08:47 PM COT
-- IDEMPIERE-366 Improve Role Inheritance
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND C_DocType.IsSOTrx=''@IsSOTrx@''  AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2012-09-21 20:08:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=124
;

SELECT register_migration_script('917_IDEMPIERE-366.sql') FROM dual
;

