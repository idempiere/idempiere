SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1052: Improve Performance using Search instead of Table/Table Direct
-- Jul 30, 2018 4:01:01 PM CEST
UPDATE AD_Column SET AD_Reference_ID=30, FKConstraintType=NULL,Updated=TO_DATE('2018-07-30 16:01:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200590
;

-- Jul 30, 2018 4:01:07 PM CEST
UPDATE AD_Column SET AD_Reference_ID=30, IsUpdateable='N',Updated=TO_DATE('2018-07-30 16:01:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200588
;

-- Jul 30, 2018 4:01:21 PM CEST
UPDATE AD_Column SET AD_Reference_ID=30, FKConstraintType=NULL,Updated=TO_DATE('2018-07-30 16:01:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200593
;

-- Jul 30, 2018 4:01:33 PM CEST
UPDATE AD_Column SET AD_Reference_ID=30, FKConstraintType=NULL,Updated=TO_DATE('2018-07-30 16:01:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200595
;

SELECT register_migration_script('201807301600_IDEMPIERE-1052.sql') FROM dual
;