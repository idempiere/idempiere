-- Apr 3, 2013 5:10:09 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsActive='Y',Updated=TO_DATE('2013-04-03 17:10:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5346
;

-- Apr 3, 2013 5:12:43 PM COT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsActive='N',Updated=TO_DATE('2013-04-03 17:12:43','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12164
;

SELECT register_migration_script('201304031714_IDEMPIERE-362.sql') FROM dual
;

