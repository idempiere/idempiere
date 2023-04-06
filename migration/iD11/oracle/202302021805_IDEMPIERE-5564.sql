-- IDEMPIERE-5564 - Improve the message thrown by Import CSV Process when a field does not exist in the tab
SELECT register_migration_script('202302021805_IDEMPIERE-5564.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Feb 2, 2023, 6:05:41 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Field {0} not found in tab {1}',0,0,'Y',TO_TIMESTAMP('2023-02-02 18:05:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-02-02 18:05:40','YYYY-MM-DD HH24:MI:SS'),100,200820,'FieldNotFoundInTab','D','a57c6e74-95bc-4196-9738-9a9b332dca19')
;

