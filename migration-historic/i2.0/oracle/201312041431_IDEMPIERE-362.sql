SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 4, 2013 2:25:37 PM SGT
-- IDEMPIERE-362 Hide things that don't work on iDempiere
UPDATE AD_Field SET IsActive='N',Updated=TO_DATE('2013-12-04 14:25:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3853
;

-- Dec 4, 2013 2:27:42 PM SGT
UPDATE AD_Field SET IsActive='N',Updated=TO_DATE('2013-12-04 14:27:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3927
;

SELECT register_migration_script('201312041431_IDEMPIERE-362.sql') FROM dual
;
