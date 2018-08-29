SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-3769 : IBAN : Invalid message is not translated - force to uppercase
-- Aug 1, 2018 8:56:43 AM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','IBAN is invalid',0,0,'Y',TO_DATE('2018-08-01 08:56:42','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2018-08-01 08:56:42','YYYY-MM-DD HH24:MI:SS'),0,200480,'InvalidIBAN','D','4cc792d9-9af0-4e37-b90a-7dcc9f5e82ec')
;

SELECT register_migration_script('201808010900_IDEMPIERE-3769.sql') FROM dual
;