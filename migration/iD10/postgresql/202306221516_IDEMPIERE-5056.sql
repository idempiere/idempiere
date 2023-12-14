-- IDEMPIERE-5056 Order and Invoice: Tax lookup interface
SELECT register_migration_script('202306221516_IDEMPIERE-5056.sql') FROM dual;

-- Jun 22, 2023, 3:16:13 PM CEST
UPDATE AD_Field SET DisplayLogic=NULL,Updated=TO_TIMESTAMP('2023-06-22 15:16:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1108
;

