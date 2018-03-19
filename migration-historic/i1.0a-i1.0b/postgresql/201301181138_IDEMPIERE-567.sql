-- Jan 18, 2013 11:37:40 AM PST
-- IDEMPIERE-567 Move ProductUOMConversionRateValidate sysconfig key to be client configurable
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_TIMESTAMP('2013-01-18 11:37:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50023
;

-- Jan 18, 2013 11:37:44 AM PST
-- IDEMPIERE-567 Move ProductUOMConversionRateValidate sysconfig key to be client configurable
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_TIMESTAMP('2013-01-18 11:37:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50022
;

SELECT register_migration_script('201301181138_IDEMPIERE-567.sql') FROM dual
;

