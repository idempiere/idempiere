-- IDEMPIERE-5860 Recent Item of Window Customization is usually empty
SELECT register_migration_script('202309201029_IDEMPIERE-5860.sql') FROM dual;

-- Sep 20, 2023, 10:29:54 AM CEST
UPDATE AD_Window SET TitleLogic='@AD_Window_ID<Name>@',Updated=TO_TIMESTAMP('2023-09-20 10:29:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=229
;

-- Sep 20, 2023, 11:44:54 AM CEST
UPDATE AD_Window SET TitleLogic='@AD_Process_ID<Name>@',Updated=TO_TIMESTAMP('2023-09-20 11:44:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200095
;

-- Sep 20, 2023, 11:45:19 AM CEST
UPDATE AD_Window SET TitleLogic='@AD_InfoWindow_ID<Name>@',Updated=TO_TIMESTAMP('2023-09-20 11:45:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200110
;

