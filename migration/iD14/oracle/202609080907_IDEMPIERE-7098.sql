-- IDEMPIERE-7098
-- Adds the validation message for scheduler supervisors that do not have at least one active role.
SELECT register_migration_script('202609080907_IDEMPIERE-7098.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 8, 2026, 9:07:38 AM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','The selected Supervisor must have at least one active role.',0,0,'Y',TO_TIMESTAMP('2026-09-08 09:07:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-09-08 09:07:37','YYYY-MM-DD HH24:MI:SS'),100,201063,'SchedulerSupervisorMustHaveRole','D','01a080ea-aba1-7c16-92d4-771e679ba8e8')
;

