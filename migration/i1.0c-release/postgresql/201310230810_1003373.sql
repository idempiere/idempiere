-- Oct 23, 2013 6:07:31 PM MYT
-- 1003373 Lookup Box on Dashboard Preference window doesn't have fields
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_TIMESTAMP('2013-10-23 18:07:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200327
;

-- Oct 23, 2013 6:07:44 PM MYT
-- 1003373 Lookup Box on Dashboard Preference window doesn't have fields
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_TIMESTAMP('2013-10-23 18:07:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200328
;

-- Oct 23, 2013 6:08:14 PM MYT
-- 1003373 Lookup Box on Dashboard Preference window doesn't have fields
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_TIMESTAMP('2013-10-23 18:08:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200350
;

SELECT register_migration_script('201310230810_1003373.sql') FROM dual
;

