SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jul 10, 2014 6:44:09 PM ICT
-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
DROP INDEX ad_preference_attribute
;

-- Jul 10, 2014 6:44:09 PM ICT
CREATE UNIQUE INDEX ad_preference_attribute ON AD_Preference (PreferenceFor,AD_Process_ID,AD_Client_ID,AD_Org_ID,AD_Window_ID,AD_User_ID,Attribute)
;

SELECT register_migration_script('201407101604_IDEMPIERE-1788-fix-unq-index.sql') FROM dual
;
