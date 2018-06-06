-- IDEMPIERE-3651 Report Column Set=>Report Column=>User Element List1 not displaying User1_ID values
-- Jun 4, 2018 12:51:33 PM CEST
UPDATE AD_Column SET AD_Val_Rule_ID=258,Updated=TO_TIMESTAMP('2018-06-04 12:51:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6026
;

SELECT register_migration_script('201806041252_IDEMPIERE-3651.sql') FROM dual
;

