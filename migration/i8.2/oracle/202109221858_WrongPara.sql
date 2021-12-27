SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 22, 2021, 6:47:11 PM CEST
UPDATE AD_Process_Para SET ColumnName='IsUseActivityDimension',Updated=TO_DATE('2021-09-22 18:47:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=200085
;

SELECT register_migration_script('202109221858_WrongPara.sql') FROM dual
;

