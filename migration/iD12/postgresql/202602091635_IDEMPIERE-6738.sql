-- IDEMPIERE-6738
SELECT register_migration_script('202602091635_IDEMPIERE-6738.sql') FROM dual;

-- Feb 9, 2026, 4:35:24 PM CET
UPDATE AD_Tab SET WhereClause='AD_Column.AD_Reference_Value_ID=@AD_Reference_ID:0@',Updated=TO_TIMESTAMP('2026-02-09 16:35:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=773
;

