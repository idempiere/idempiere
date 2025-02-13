-- IDEMPIERE-6317
SELECT register_migration_script('202411260821_IDEMPIERE-6317.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Nov 26, 2024, 8:34:46 AM BRT
UPDATE AD_Message SET Value='Can''t Save Tenant Level',Updated=TO_TIMESTAMP('2024-11-26 08:34:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=53010
;

-- Nov 26, 2024, 8:36:49 AM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','This is a system or tenant parameter, you can''t save it as organization parameter',0,0,'Y',TO_TIMESTAMP('2024-11-26 08:36:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-26 08:36:48','YYYY-MM-DD HH24:MI:SS'),100,200914,'ThisIsSystemOrTenantParameter','D','8980c935-1c23-4d83-8b26-70eb3a749797')
;

-- Nov 26, 2024, 8:38:56 AM BRT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','This is a system parameter, you can''t save it as tenant parameter',0,0,'Y',TO_TIMESTAMP('2024-11-26 08:38:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-11-26 08:38:55','YYYY-MM-DD HH24:MI:SS'),100,200915,'ThisIsSystemParameter','D','6e6b2060-ec2d-4d87-b499-7250e93f7cec')
;

