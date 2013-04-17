-- Apr 15, 2013 3:54:49 PM IST
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Process SET AccessLevel='6',Updated=TO_TIMESTAMP('2013-04-15 15:54:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200018
;

SELECT register_migration_script('201304150457_IDEMPIERE-294.sql') FROM dual
;
