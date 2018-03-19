-- Jul 11, 2013 2:11:52 PM MYT
-- IDEMPIERE-1163 Web service role access control not working
UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N',Updated=TO_DATE('2013-07-11 14:11:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56679
;

SELECT register_migration_script('201307110629_IDEMPIERE-1163.sql') FROM dual
;

