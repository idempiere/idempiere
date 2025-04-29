-- IDEMPIERE-6520 - Allow to use barcode in print format items for script types
SELECT register_migration_script('202504291354_IDEMPIERE-6520.sql') FROM dual;

-- Apr 29, 2025, 1:54:31 PM CEST
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=F|@PrintFormatType@=S',Updated=TO_TIMESTAMP('2025-04-29 13:54:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13016
;

-- Apr 29, 2025, 1:55:06 PM CEST
UPDATE AD_Field SET DisplayLogic='(@PrintFormatType@=F|@PrintFormatType@=S) & @BarcodeType@!''''',Updated=TO_TIMESTAMP('2025-04-29 13:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204351
;

