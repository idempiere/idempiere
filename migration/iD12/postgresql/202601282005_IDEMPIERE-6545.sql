--     IDEMPIERE-6545  Translation tabs must not allow delete
SELECT register_migration_script('202601282005_IDEMPIERE-6545.sql') FROM dual;

-- Jan 28, 2026, 8:05:20 PM CET
UPDATE AD_Tab SET IsInsertRecord='Y',Updated=TO_TIMESTAMP('2026-01-28 20:05:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200302
;

