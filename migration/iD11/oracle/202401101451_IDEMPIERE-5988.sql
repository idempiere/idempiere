-- IDEMPIERE-5988 Wrong DisplayLogic in Discount, Write-off, Over/Under Payment fields
SELECT register_migration_script('202401101451_IDEMPIERE-5988.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 10, 2024, 2:51:50 PM CET
UPDATE AD_Field SET DisplayLogic='@C_Invoice_ID:0@^0',Updated=TO_TIMESTAMP('2024-01-10 14:51:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4131
;

-- Jan 10, 2024, 2:51:54 PM CET
UPDATE AD_Field SET DisplayLogic='@C_Invoice_ID:0@^0',Updated=TO_TIMESTAMP('2024-01-10 14:51:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5117
;

-- Jan 10, 2024, 2:51:57 PM CET
UPDATE AD_Field SET DisplayLogic='@C_Invoice_ID:0@^0',Updated=TO_TIMESTAMP('2024-01-10 14:51:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5736
;

-- Jan 10, 2024, 2:52:02 PM CET
UPDATE AD_Field SET DisplayLogic='@IsOverUnderPayment@=Y & @C_Invoice_ID:0@^0',Updated=TO_TIMESTAMP('2024-01-10 14:52:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5737
;

-- Jan 10, 2024, 2:53:10 PM CET
UPDATE AD_Field SET DisplayLogic='@C_Invoice_ID:0@^0',Updated=TO_TIMESTAMP('2024-01-10 14:53:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205800
;

-- Jan 10, 2024, 2:53:13 PM CET
UPDATE AD_Field SET DisplayLogic='@C_Invoice_ID:0@^0',Updated=TO_TIMESTAMP('2024-01-10 14:53:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205801
;

