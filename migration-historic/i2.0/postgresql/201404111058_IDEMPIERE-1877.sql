-- Apr 11, 2014 10:56:44 AM COT
-- IDEMPIERE-1877 Product Info Window Implementation broke the usage of barcode reader
UPDATE AD_InfoColumn SET IsIdentifier='Y',Updated=TO_TIMESTAMP('2014-04-11 10:56:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200003
;

-- Apr 11, 2014 10:56:47 AM COT
UPDATE AD_InfoColumn SET IsIdentifier='Y',Updated=TO_TIMESTAMP('2014-04-11 10:56:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200004
;

SELECT register_migration_script('201404111058_IDEMPIERE-1877.sql') FROM dual
;

