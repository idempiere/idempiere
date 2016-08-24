-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Aug 15, 2016 10:12:48 AM BRT
UPDATE AD_Column SET IsAllowCopy='N',Updated=TO_TIMESTAMP('2016-08-15 10:12:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=3075
;

SELECT register_migration_script('20160815103455_IDEMPIERE-3158.sql') FROM dual
;
