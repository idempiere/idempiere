SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3153 Allow negative BOM Product lines for co/by-products
-- Aug 7, 2016 12:51:02 PM CEST
UPDATE AD_Column SET ValueMin=NULL,Updated=TO_DATE('2016-08-07 12:51:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4723
;

SELECT register_migration_script('201608071251_IDEMPIERE-3153.sql') FROM dual
;

