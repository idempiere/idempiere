-- Sep 19, 2013 10:36:56 AM MYT
-- IDEMPIERE-1064 Control dashboard access by role
UPDATE AD_Field SET AD_Reference_ID=30, AD_Reference_Value_ID=162,Updated=TO_TIMESTAMP('2013-09-19 10:36:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202328
;

SELECT register_migration_script('201309190245_IDEMPIERE-1180.sql') FROM dual
;

