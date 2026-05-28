-- IDEMPIERE-7018 https://idempiere.atlassian.net/browse/IDEMPIERE-7018
SELECT register_migration_script('202605281021_IDEMPIERE-7018.sql') FROM dual;

-- May 28, 2026, 10:21:45 AM BRT
UPDATE AD_Field SET DisplayLogic='@$Element_U1@=Y',Updated=TO_TIMESTAMP('2026-05-28 10:21:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209183
;

-- May 28, 2026, 10:21:50 AM BRT
UPDATE AD_Field SET DisplayLogic='@$Element_U1@=Y',Updated=TO_TIMESTAMP('2026-05-28 10:21:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209186
;

-- May 28, 2026, 10:21:57 AM BRT
UPDATE AD_Field SET DisplayLogic='@$Element_U2@=Y',Updated=TO_TIMESTAMP('2026-05-28 10:21:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209185
;

-- May 28, 2026, 10:22:02 AM BRT
UPDATE AD_Field SET DisplayLogic='@$Element_U2@=Y',Updated=TO_TIMESTAMP('2026-05-28 10:22:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=209184
;

