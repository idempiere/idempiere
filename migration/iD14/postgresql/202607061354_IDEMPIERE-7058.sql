-- IDEMPIERE-7058 : Doc action on suspended workflow, create duplicate workflow process
SELECT register_migration_script('202607061354_IDEMPIERE-7058.sql') FROM dual;

-- 08/10/2025 13:54:27 IST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Assigned to {0}: {1} ',0,0,'Y',TO_TIMESTAMP('2025-10-08 13:54:26','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2025-10-08 13:54:26','YYYY-MM-DD HH24:MI:SS'),100,200970,'AssignedToState','D','5246f65b-3218-49de-aeda-49d311c61518')
;

