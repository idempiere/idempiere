-- IDEMPIERE-6520 - Allow to use barcode in print format items for script types
SELECT register_migration_script('202504291354_IDEMPIERE-6520.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 29, 2025, 1:54:31 PM CEST
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=F|@PrintFormatType@=S',Updated=TO_TIMESTAMP('2025-04-29 13:54:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13016
;

-- Apr 29, 2025, 1:55:06 PM CEST
UPDATE AD_Field SET DisplayLogic='(@PrintFormatType@=F|@PrintFormatType@=S) & @BarcodeType@!''''',Updated=TO_TIMESTAMP('2025-04-29 13:55:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204351
;

-- Apr 29, 2025, 9:04:01 PM CEST
UPDATE AD_Field SET DisplayLogic='(@PrintFormatType@=F|@PrintFormatType@=S) & @IsForm@=Y',Updated=TO_TIMESTAMP('2025-04-29 21:04:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6273
;

-- Apr 29, 2025, 9:04:27 PM CEST
UPDATE AD_Field SET DisplayLogic='@IsForm@=N & (@PrintFormatType@=F|@PrintFormatType@=S)',Updated=TO_TIMESTAMP('2025-04-29 21:04:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56378
;

-- Apr 29, 2025, 9:05:09 PM CEST
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=F|@PrintFormatType@=S',Updated=TO_TIMESTAMP('2025-04-29 21:05:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5805
;

-- Apr 29, 2025, 9:05:35 PM CEST
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=F|@PrintFormatType@=S|@PrintFormatType@=T',Updated=TO_TIMESTAMP('2025-04-29 21:05:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5688
;

-- Apr 29, 2025, 9:06:02 PM CEST
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=F | @PrintFormatType@=S | @PrintFormatType@=T | @PrintFormatType@=R | @PrintFormatType@=L',Updated=TO_TIMESTAMP('2025-04-29 21:06:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5682
;

-- Apr 29, 2025, 9:06:18 PM CEST
UPDATE AD_Field SET DisplayLogic='@PrintFormatType@=F | @PrintFormatType@=S | @PrintFormatType@=T',Updated=TO_TIMESTAMP('2025-04-29 21:06:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5686
;

