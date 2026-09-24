-- IDEMPIERE-7074 Info Window field on Column tab also for Search reference
SELECT register_migration_script('202609020920_IDEMPIERE-7074.sql') FROM dual;

-- Sep 2, 2026, 9:20:00 AM
-- IDEMPIERE-7074 the AD_Column.AD_InfoWindow_ID is now also evaluated for search
-- fields (Search, AD_Reference_ID 30), not only for buttons (28) -
-- make the Info Window field on the Column tab visible for those too
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=28 | @AD_Reference_ID@=30',Updated=TO_TIMESTAMP('2026-09-02 09:20:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207143
;
