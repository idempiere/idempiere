-- IDEMPIERE-6805 MUserRole should disallow assignment of role template to user
SELECT register_migration_script('202601031210_IDEMPIERE-6805.sql') FROM dual;

-- Jan 3, 2026, 12:10:36 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Template roles cannot be assigned directly to users.','This is a template role. To assign these permissions, please create a standard role from this template.',0,0,'Y',TO_TIMESTAMP('2026-01-03 12:10:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-01-03 12:10:35','YYYY-MM-DD HH24:MI:SS'),100,200987,'CannotAssignRoleTemplateToUser','D','019b820c-cf7f-7e16-be77-784af2fa9714')
;

