-- Jan 26, 2013 12:25:54 PM PST
-- IDEMPIERE-362 Hide things that don't work on iDempiere
-- Hide Dunning Run - Send It button
UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N',Updated=TO_DATE('2013-01-26 12:25:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10618
;

-- Jan 26, 2013 12:32:10 PM PST
-- Hide Access Audit Window
UPDATE AD_Tab SET IsInsertRecord='N', IsActive='N',Updated=TO_DATE('2013-01-26 12:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=53137
;

-- Jan 26, 2013 12:32:16 PM PST
UPDATE AD_Tab SET IsActive='N',Updated=TO_DATE('2013-01-26 12:32:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=651
;

-- Jan 26, 2013 12:32:31 PM PST
UPDATE AD_Menu SET IsActive='N',Updated=TO_DATE('2013-01-26 12:32:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=475
;

-- Jan 26, 2013 12:32:37 PM PST
UPDATE AD_Window SET IsActive='N',Updated=TO_DATE('2013-01-26 12:32:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=326
;

SELECT register_migration_script('201301261235_IDEMPIERE-362.sql') FROM dual
;

