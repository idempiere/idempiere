-- IDEMPIERE-6394
SELECT register_migration_script('202501191130_IDEMPIERE-6394.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 19, 2025, 11:30:28 AM WIB
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','From Bank Account and To Bank Account must be different {0}',0,0,'Y',TO_TIMESTAMP('2025-01-19 11:30:28','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-19 11:30:28','YYYY-MM-DD HH24:MI:SS'),100,200928,'FromToBankAccountMustDifferent','D','4814ce5d-1bca-43c7-989d-ab5cc08128c4')
;

-- Jan 19, 2025, 11:31:24 AM WIB
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','From Organization does not match the organization of the From Bank Account {0}',0,0,'Y',TO_TIMESTAMP('2025-01-19 11:31:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-01-19 11:31:24','YYYY-MM-DD HH24:MI:SS'),100,200929,'FromOrgNotMatchBankAccount','D','f62be846-b504-41c2-91b1-165e3b0b4d10')
;

