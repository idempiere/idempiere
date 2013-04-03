-- Apr 1, 2013 5:46:56 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-04-01 17:46:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54045
;

-- Apr 1, 2013 5:50:42 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsActive='N',Updated=TO_TIMESTAMP('2013-04-01 17:50:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54040
;

-- Apr 1, 2013 5:52:51 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Window SET IsActive='N',Updated=TO_TIMESTAMP('2013-04-01 17:52:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=53012
;

SELECT register_migration_script('201304011830_IDEMPIERE-362.sql') FROM dual
;

