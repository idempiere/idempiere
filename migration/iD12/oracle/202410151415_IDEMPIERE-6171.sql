-- IDEMPIERE-6171 Request and request group window is showing fields for de-activated window
SELECT register_migration_script('202410151415_IDEMPIERE-6171.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 15, 2024, 2:15:37 PM MYT
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2024-10-15 14:15:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12748
;

-- Oct 15, 2024, 2:16:28 PM MYT
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2024-10-15 14:16:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207655
;

-- Oct 15, 2024, 2:19:30 PM MYT
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2024-10-15 14:19:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12006
;

