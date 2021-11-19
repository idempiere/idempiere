SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4858 Helper process "Make Table a Document"
-- Nov 19, 2021, 3:18:02 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Table Index records have been added on the Translation table - do not forget to execute ''Index Validate'' process after you run ''Sync Column''',0,0,'Y',TO_DATE('2021-11-19 15:18:01','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2021-11-19 15:18:01','YYYY-MM-DD HH24:MI:SS'),100,200721,'TrlCreatedSyncColumnValidateIndex','D','81b87d52-17c3-46cd-bfdf-e08cdfc11851')
;

SELECT register_migration_script('202111191531_IDEMPIERE-4858.sql') FROM dual
;

