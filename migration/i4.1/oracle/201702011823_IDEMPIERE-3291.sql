SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3291 - Increase length of ConstantValue in WS_WebService_Para
-- Feb 1, 2017 6:17:46 PM CET
UPDATE AD_Column SET FieldLength=2000,Updated=TO_DATE('2017-02-01 18:17:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=56745
;

-- Feb 1, 2017 6:17:51 PM CET
ALTER TABLE WS_WebService_Para MODIFY ConstantValue NVARCHAR2(2000) DEFAULT NULL 
;


SELECT register_migration_script('201702011823_IDEMPIERE-3291.sql') FROM dual
;
