SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3090 Inventory Count Search Key is too short
-- May 5, 2016 11:47:46 AM PDT
UPDATE AD_Process_Para SET FieldLength=40,Updated=TO_DATE('2016-05-05 11:47:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=158
;

-- May 5, 2016 11:48:34 AM PDT
UPDATE AD_Process_Para SET FieldLength=40,Updated=TO_DATE('2016-05-05 11:48:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_Para_ID=123
;

SELECT register_migration_script('201605051202_IDEMPIERE-3090.sql') FROM dual
;

