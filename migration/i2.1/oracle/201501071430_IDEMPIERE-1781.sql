SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 7, 2015 2:25:11 PM COT
-- IDEMPIERE-1781:Error when try to change Invoiced mark in Event Windows
UPDATE AD_Column SET AD_Reference_ID=20, AD_Reference_Value_ID=NULL,Updated=TO_DATE('2015-01-07 14:25:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=13507
;

-- Jan 7, 2015 2:25:25 PM COT
UPDATE AD_Field SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2015-01-07 14:25:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11471
;

-- Jan 7, 2015 2:25:36 PM COT
UPDATE AD_Field SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2015-01-07 14:25:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11435
;

SELECT register_migration_script('201501071430_IDEMPIERE-1781.sql') FROM dual
;

