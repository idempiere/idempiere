-- Feb 11, 2014 5:56:46 PM COT
-- IDEMPIERE-1724 Field C_Charge_ID in table C_OrderLine has wrong dynamic Validation
UPDATE AD_Column SET AD_Val_Rule_ID=52030,Updated=TO_TIMESTAMP('2014-02-11 17:56:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3050
;

SELECT register_migration_script('201402111757_IDEMPIERE-1724.sql') FROM dual
;

