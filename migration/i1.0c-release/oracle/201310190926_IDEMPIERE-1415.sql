SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 19, 2013 9:24:48 AM COT
-- IDEMPIERE-1415 Disable Cash Journal Line field in the Invoice/Allocation window
UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N',Updated=TO_DATE('2013-10-19 09:24:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4371
;

-- Oct 19, 2013 9:25:01 AM COT
-- IDEMPIERE-1415 Disable Cash Journal Line field in the Invoice/Allocation window
UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N',Updated=TO_DATE('2013-10-19 09:25:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11032
;

-- Oct 19, 2013 9:25:11 AM COT
-- IDEMPIERE-1415 Disable Cash Journal Line field in the Invoice/Allocation window
UPDATE AD_Field SET IsDisplayed='N', IsDisplayedGrid='N',Updated=TO_DATE('2013-10-19 09:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11049
;

SELECT register_migration_script('201310190926_IDEMPIERE-1415.sql') FROM dual
;

