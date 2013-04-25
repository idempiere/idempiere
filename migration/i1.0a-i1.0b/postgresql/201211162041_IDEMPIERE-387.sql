-- Nov 16, 2012 8:41:14 PM COT
-- IDEMPIERE-387 Enable mixed payments on POS Sales Order
UPDATE AD_Column SET AD_Val_Rule_ID=NULL,Updated=TO_TIMESTAMP('2012-11-16 20:41:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=4020
;

SELECT register_migration_script('201211162041_IDEMPIERE-387.sql') FROM dual
;

