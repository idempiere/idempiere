-- Sep 30, 2013 6:48:37 PM SGT
-- IDEMPIERE-569 Ticket #1001758: Improve shipping configuration to support external services
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2013-09-30 18:48:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=444
;

-- Sep 30, 2013 6:48:42 PM SGT
-- IDEMPIERE-569 Ticket #1001758: Improve shipping configuration to support external services
UPDATE AD_Window SET IsActive='N',Updated=TO_TIMESTAMP('2013-09-30 18:48:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=319
;

SELECT register_migration_script('201309301851_IDEMPIERE-569.sql') FROM dual
;