-- Feb 22, 2013 3:02:16 PM COT
-- IDEMPIERE-325 Complete AD based info window ( AD_InfoWindow ) implementation
UPDATE AD_InfoColumn SET IsDisplayed='N',Updated=TO_DATE('2013-02-22 15:02:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_InfoColumn_ID=200061
;

SELECT register_migration_script('201302221504_IDEMPIERE-325.sql') FROM dual
;

