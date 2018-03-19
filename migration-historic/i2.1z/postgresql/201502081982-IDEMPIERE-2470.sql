-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Aug 2, 2015 3:17:29 AM WITA
UPDATE AD_SysConfig SET ConfigurationLevel='C',Updated=TO_TIMESTAMP('2015-08-02 03:17:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=50018
;
SELECT register_migration_script('201502081982-IDEMPIERE-2470.sql') FROM dual
;
