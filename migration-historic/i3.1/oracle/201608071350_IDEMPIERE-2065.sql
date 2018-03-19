SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-2065 flag Pay Schedule valid of invoice customer is not update in some case, make invoice not list in search when payment
-- Aug 7, 2016 1:50:22 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2016-08-07 13:50:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=10326
;

-- Aug 7, 2016 1:50:27 PM CEST
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_DATE('2016-08-07 13:50:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=60152
;

SELECT register_migration_script('201608071350_IDEMPIERE-2065.sql') FROM dual
;

