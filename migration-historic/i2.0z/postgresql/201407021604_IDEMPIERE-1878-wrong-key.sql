-- May 27, 2014 10:33:16 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
ALTER TABLE AD_PrintFormat_Trl DROP CONSTRAINT AD_PrintFormat_Trl_Key
;

ALTER TABLE AD_PrintFormat_Trl ADD CONSTRAINT AD_PrintFormat_Trl_Key PRIMARY KEY (AD_PrintFormat_ID, AD_Language)
;

SELECT register_migration_script('201407021604_IDEMPIERE-1878-wrong-key.sql') FROM dual
;
