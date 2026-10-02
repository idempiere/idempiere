-- IDEMPIERE-7131
SELECT register_migration_script('202610021315_IDEMPIERE-7131.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 2, 2026, 1:15:03 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Saved query "{0}" has an invalid tab reference "{1}". Delete the query and create it again.',0,0,'Y',TO_TIMESTAMP('2026-10-02 13:15:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-10-02 13:15:03','YYYY-MM-DD HH24:MI:SS'),100,201070,'SavedQueryInvalidTab','D','01a0fc53-2aa6-7151-aa47-6f2e332b5def')
;

