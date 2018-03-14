-- Sep 12, 2012 6:08:38 PM MYT
-- IDEMPIERE-369 Master Detail layout improvements
UPDATE AD_Field SET IsDisplayed='N', IsActive='N', IsDisplayedGrid='N',Updated=TO_DATE('2012-09-12 18:08:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6432
;

SELECT register_migration_script('930_IDEMPIERE-369.sql') FROM dual
;

