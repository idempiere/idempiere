-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Apr 18, 2019, 2:24:04 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutGLJournal.period',Updated=TO_TIMESTAMP('2019-04-18 14:24:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1619
;

-- Apr 18, 2019, 2:24:15 PM CEST
UPDATE AD_Column SET Callout='org.compiere.model.CalloutGLJournal.period',Updated=TO_TIMESTAMP('2019-04-18 14:24:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=1643
;

SELECT register_migration_script('201904181424_IDEMPIERE-3874.sql') FROM dual
;

