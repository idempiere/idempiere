-- Nov 26, 2012 1:55:57 PM COT
-- IDEMPIERE-509 Problem in create new record in the window Production
UPDATE AD_Menu SET IsActive='N',Updated=TO_TIMESTAMP('2012-11-26 13:55:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=228
;

-- Nov 26, 2012 1:56:13 PM COT
-- IDEMPIERE-509 Problem in create new record in the window Production
UPDATE AD_Window SET IsActive='N',Updated=TO_TIMESTAMP('2012-11-26 13:56:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=191
;

SELECT register_migration_script('201211261356_IDEMPIERE-509.sql') FROM dual
;

