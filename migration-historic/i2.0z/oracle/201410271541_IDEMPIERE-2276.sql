SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 27, 2014 3:39:07 PM COT
-- IDEMPIERE-2250 Charge on bank transfer not needed
UPDATE AD_Field SET DisplayLogic='@PaymentRule@=''P''',Updated=TO_DATE('2014-10-27 15:39:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3439
;

SELECT register_migration_script('201410271541_IDEMPIERE-2276.sql') FROM dual
;

