-- IDEMPIERE-7018 https://idempiere.atlassian.net/browse/IDEMPIERE-7018
-- Purpose: Add Display Logic for Fields User Element 1 and 2, in both, To and From groups.
-- Impact: Add Display Logic on Fields in C_BankTransfer (Fields with display logic modified: To_User1_ID, To_User2_ID, From_User1_ID, From_User2_ID)
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

