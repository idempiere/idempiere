-- IDEMPIERE-5136 Set Messages at tenant level
SELECT register_migration_script('202412101939_IDEMPIERE-5136.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Dec 10, 2024, 7:39:54 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Do not forget to enable SysConfig MESSAGES_AT_TENANT_LEVEL to enable this feature',0,0,'Y',TO_TIMESTAMP('2024-12-10 19:39:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-10 19:39:53','YYYY-MM-DD HH24:MI:SS'),100,200917,'WarnTenantLevelMessages','D','966e06d6-f422-4847-a79e-59ba1c0c4502')
;

