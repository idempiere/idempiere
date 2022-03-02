-- IDEMPIERE-2081 Class OrderLineCreateProduction and OrderLineCreateShipment exception messages are not translated!
SELECT register_migration_script('202203020949_IDEMPIERE-2081.sql') FROM dual;

-- Mar 2, 2022, 9:49:04 AM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Production has already been created: {0}',0,0,'Y',TO_TIMESTAMP('2022-03-02 09:49:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-03-02 09:49:04','YYYY-MM-DD HH24:MI:SS'),100,200732,'ProductionHasAlreadyBeenCreated','D','273dde9a-5130-46d0-9d98-25c241597035')
;

