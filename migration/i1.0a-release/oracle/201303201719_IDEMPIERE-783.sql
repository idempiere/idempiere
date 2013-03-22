-- Mar 20, 2013 5:15:40 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_DATE('2013-03-20 17:15:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2781
;

-- Mar 20, 2013 5:15:32 PM COT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
UPDATE AD_Column SET IsSelectionColumn='Y',Updated=TO_DATE('2013-03-20 17:15:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=5951
;

SELECT register_migration_script('201303201719_IDEMPIERE-783.sql') FROM dual;
