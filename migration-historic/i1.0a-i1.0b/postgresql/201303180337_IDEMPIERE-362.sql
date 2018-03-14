-- Mar 18, 2013 11:35:27 AM MYT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 11:35:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=52063
;

-- Mar 18, 2013 11:36:00 AM MYT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsDisplayed='N',Updated=TO_TIMESTAMP('2013-03-18 11:36:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52014
;

-- Mar 18, 2013 11:36:18 AM MYT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-03-18 11:36:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52014
;

SELECT register_migration_script('201303180337_IDEMPIERE-362.sql') FROM dual
;
