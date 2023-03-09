-- IDEMPIERE-5622 - Language in Window and Info Window customization should be filtered by log in languages
SELECT register_migration_script('202303091741_IDEMPIERE-5622.sql') FROM dual;

-- Mar 9, 2023, 5:41:26 PM CET
UPDATE AD_Column SET AD_Val_Rule_ID=toRecordId('AD_Val_Rule','534583fc-de63-45fc-b2b6-fcbd21b9a2f6'),Updated=TO_TIMESTAMP('2023-03-09 17:41:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_UU='0e32e607-dbc8-47bd-844f-9bc1fc772b39'
;

-- Mar 9, 2023, 5:41:48 PM CET
UPDATE AD_Column SET AD_Val_Rule_ID=toRecordId('AD_Val_Rule','534583fc-de63-45fc-b2b6-fcbd21b9a2f6'),Updated=TO_TIMESTAMP('2023-03-09 17:41:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_UU='22154794-072c-4240-891e-ad3623df3b93'
;

