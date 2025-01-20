-- IDEMPIERE-5136 - Window Title Logic
SELECT register_migration_script('202501171818_IDEMPIERE-5136_WindowTitleLogic.sql') FROM dual;

-- Jan 17, 2025, 6:19:26 PM CET
UPDATE AD_Window SET TitleLogic='@AD_Message_ID<Value>@',Updated=TO_TIMESTAMP('2025-01-17 18:19:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200120
;

