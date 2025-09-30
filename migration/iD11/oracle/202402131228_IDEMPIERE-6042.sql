-- IDEMPIERE-6042 Improvements to Payment window
SELECT register_migration_script('202402131228_IDEMPIERE-6042.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 13, 2024, 12:28:11 PM CET
UPDATE AD_Field SET MandatoryLogic='@IsOverrideCurrencyRate@=Y',Updated=TO_TIMESTAMP('2024-02-13 12:28:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205669
;

-- Feb 13, 2024, 12:28:15 PM CET
UPDATE AD_Field SET MandatoryLogic='@IsOverrideCurrencyRate@=Y',Updated=TO_TIMESTAMP('2024-02-13 12:28:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205670
;

