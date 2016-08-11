SET SQLBLANKLINES ON
SET DEFINE OFF

-- I forgot to set the DICTIONARY_ID_COMMENTS System Configurator
-- Aug 3, 2016 12:25:05 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','{0} resolved multiple times = ({1})',0,0,'Y',TO_DATE('2016-08-03 12:25:05','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2016-08-03 12:25:05','YYYY-MM-DD HH24:MI:SS'),100,200405,'ForeignMultipleResolved','D','3c350f49-c813-4ebc-ae1a-5d4b2fc76faa')
;

SELECT register_migration_script('201608031225_IDEMPIERE-3146.sql') FROM dual
;

