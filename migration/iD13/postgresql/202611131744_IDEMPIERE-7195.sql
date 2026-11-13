--     IDEMPIERE-7195  2Pack - Improve Package Install logging and error status handling (FHCA-8891)
SELECT register_migration_script('202611131744_IDEMPIERE-7195.sql') FROM dual;

-- Nov 13, 2026, 5:44:22 PM CET
UPDATE AD_Message SET MsgText='Record could not be deleted, inserted or updated - because of dependent records in the table {0} for the column {1}',Updated=TO_TIMESTAMP('2026-11-13 17:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200838
;

-- Nov 13, 2026, 5:44:43 PM CET
UPDATE AD_Message SET MsgText='Record could not be deleted, inserted or updated - because of dependent record',Updated=TO_TIMESTAMP('2026-11-13 17:44:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=216
;

