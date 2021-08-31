--Updating dynamic validation to User on Role with same client
-- Jul 30, 2021, 12:16:46 AM IST
UPDATE AD_Column SET AD_Val_Rule_ID=200066,Updated=TO_TIMESTAMP('2021-07-30 00:16:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200991
;

SELECT register_migration_script('202107301015_IDEMPIERE-4770.sql') FROM dual
;