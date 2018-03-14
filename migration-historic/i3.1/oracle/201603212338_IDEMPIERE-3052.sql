SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3052 Advanced Search on doctype on invoices or orders shows all the doctypes
-- Mar 21, 2016 11:38:20 PM CET
UPDATE AD_Val_Rule SET Code='C_DocType.DocBaseType IN (''SOO'', ''POO'') AND C_DocType.IsSOTrx=''@IsSOTrx@'' AND COALESCE(C_DocType.DocSubTypeSO,'' '')<>''RM'' AND C_DocType.AD_Client_ID=@#AD_Client_ID@',Updated=TO_DATE('2016-03-21 23:38:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=133
;

SELECT register_migration_script('201603212338_IDEMPIERE-3052.sql') FROM dual
;

