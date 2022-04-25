SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4364 Advanced Search - Allow select column from window tabs
-- Nov 1, 2021, 11:09:11 AM CET
UPDATE AD_Column SET FieldLength=4000, AD_Reference_ID=10,Updated=TO_DATE('2021-11-01 11:09:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=14361
;

-- Nov 1, 2021, 11:09:14 AM CET
ALTER TABLE AD_UserQuery MODIFY Code VARCHAR2(4000 CHAR) DEFAULT NULL 
;

SELECT register_migration_script('202111011110_IDEMPIERE-4364.sql') FROM dual
;

