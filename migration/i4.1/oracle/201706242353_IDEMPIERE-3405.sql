SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3405
-- Jun 24, 2017 11:48:25 PM CEST
UPDATE AD_Val_Rule SET Name='C_DocTypeTarget PO or SO',Updated=TO_DATE('2017-06-24 23:48:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=133
;

-- Jun 24, 2017 11:48:48 PM CEST
UPDATE AD_Val_Rule SET Description='Document Type for orders',Updated=TO_DATE('2017-06-24 23:48:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=133
;

-- Jun 24, 2017 11:49:44 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200096,'C_DocType PO or SO','Document Type for orders','S','(C_DocType.DocBaseType IN (''SOO'', ''POO'') AND C_DocType.IsSOTrx=''@IsSOTrx@'' AND COALESCE(C_DocType.DocSubTypeSO,'' '')<>''RM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@) OR C_DocType_ID=0',0,0,'Y',TO_DATE('2017-06-24 23:49:43','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-06-24 23:49:43','YYYY-MM-DD HH24:MI:SS'),100,'D','7f54de3d-a0cb-4649-aeff-6c8dfa5bd991')
;

-- Jun 24, 2017 11:50:01 PM CEST
UPDATE AD_Val_Rule SET Description='Target Document Type for orders',Updated=TO_DATE('2017-06-24 23:50:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=133
;

-- Jun 24, 2017 11:50:13 PM CEST
UPDATE AD_Val_Rule SET Name='C_DocTypeTarget AR/AP Invoices and Credit Memos', Description='Target Document Type AR/AP Invoice and Credit Memos',Updated=TO_DATE('2017-06-24 23:50:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=124
;

-- Jun 24, 2017 11:50:29 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Description,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200097,'C_DocTypeTarget AR/AP Invoices and Credit Memos','Target Document Type AR/AP Invoice and Credit Memos','S','(C_DocType.DocBaseType IN (''ARI'', ''API'',''ARC'',''APC'') AND C_DocType.IsSOTrx=''@IsSOTrx@''  AND C_DocType.AD_Client_ID=@#AD_Client_ID@) OR C_DocType_ID=0',0,0,'Y',TO_DATE('2017-06-24 23:50:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2017-06-24 23:50:29','YYYY-MM-DD HH24:MI:SS'),100,'D','62aa64dd-3808-4871-954a-783b60943758')
;

-- Jun 24, 2017 11:50:59 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200096,Updated=TO_DATE('2017-06-24 23:50:59','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2172
;

-- Jun 24, 2017 11:52:31 PM CEST
UPDATE AD_Val_Rule SET Name='C_DocType AR/AP Invoices and Credit Memos', Description='Document Type AR/AP Invoice and Credit Memos',Updated=TO_DATE('2017-06-24 23:52:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200097
;

-- Jun 24, 2017 11:52:43 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=200097,Updated=TO_DATE('2017-06-24 23:52:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3493
;

SELECT register_migration_script('201706242353_IDEMPIERE-3405.sql') FROM dual
;

