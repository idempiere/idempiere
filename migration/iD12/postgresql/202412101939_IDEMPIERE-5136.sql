-- IDEMPIERE-5136 Set Messages at tenant level
SELECT register_migration_script('202412101939_IDEMPIERE-5136.sql') FROM dual;

-- Dec 10, 2024, 7:39:54 PM CET
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','<div style="background-color:yellow;">{0,choice,0#Do not forget to set SysConfig MESSAGES_AT_TENANT_LEVEL=Y to enable this feature|1#}</div>',0,0,'Y',TO_TIMESTAMP('2024-12-10 19:39:53','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-12-10 19:39:53','YYYY-MM-DD HH24:MI:SS'),100,200917,'WarnTenantLevelMessages','D','966e06d6-f422-4847-a79e-59ba1c0c4502')
;

-- Dec 11, 2024, 2:42:51 PM CET
INSERT INTO AD_StatusLine (AD_StatusLine_ID,AD_Client_ID,AD_Org_ID,AD_StatusLine_UU,Created,CreatedBy,EntityType,IsActive,Name,Updated,UpdatedBy,AD_Message_ID,SQLStatement) VALUES (200025,0,0,'b77f797e-4746-4025-9377-a248e308c19e',TO_TIMESTAMP('2024-12-11 14:42:51','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','WarnTenantLevelMessages',TO_TIMESTAMP('2024-12-11 14:42:51','YYYY-MM-DD HH24:MI:SS'),100,200917,'SELECT CASE WHEN @AD_Client_ID@=0 OR get_Sysconfig(''MESSAGES_AT_TENANT_LEVEL'', ''NA'', @AD_Client_ID@, 0) = ''Y'' THEN 1 ELSE 0 END FROM DUAL')
;

-- Dec 11, 2024, 2:50:25 PM CET
INSERT INTO AD_StatusLineUsedIn (AD_StatusLineUsedIn_ID,AD_Client_ID,AD_Org_ID,AD_StatusLineUsedIn_UU,AD_StatusLine_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_Window_ID,AD_Tab_ID,IsStatusLine,SeqNo,EntityType) VALUES (200045,0,0,'d0594d4c-5de6-431f-9f79-56ed9f969270',200025,TO_TIMESTAMP('2024-12-11 14:50:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2024-12-11 14:50:25','YYYY-MM-DD HH24:MI:SS'),100,200120,200302,'Y',0,'D')
;

