-- IDEMPIERE-5116 Recent Item on System Configurator revealing too much information
-- Dec 20, 2021, 8:27:30 PM CET
UPDATE AD_Window SET TitleLogic='@Name@',Updated=TO_TIMESTAMP('2021-12-20 20:27:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=50006
;

SELECT register_migration_script('202112202038_IDEMPIERE-5116.sql') FROM dual
;

