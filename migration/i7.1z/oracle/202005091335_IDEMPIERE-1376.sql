SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-1376 Error message not translated in Validate Business Partner
-- May 9, 2020, 1:29:48 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','No Business Partner/Group selected',0,0,'Y',TO_DATE('2020-05-09 13:29:48','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-05-09 13:29:48','YYYY-MM-DD HH24:MI:SS'),100,200613,'BPartnerGroupNotSelected','D','83b41219-8ef2-4a58-87f0-bca896cdb8f8')
;

SELECT register_migration_script('202005091335_IDEMPIERE-1376.sql') FROM dual
;
