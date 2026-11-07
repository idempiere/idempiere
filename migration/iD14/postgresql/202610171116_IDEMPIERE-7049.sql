-- IDEMPIERE-7049 Asset Addition - Document Type mandatory  
SELECT register_migration_script('202610171116_IDEMPIERE-7049.sql') FROM dual;

-- Oct 17, 2026, 11:16:56 AM WIB
UPDATE AD_Field SET MandatoryLogic='1=1',Updated=TO_TIMESTAMP('2026-10-17 11:16:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201893
;

