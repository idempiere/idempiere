--     IDEMPIERE-6809  Session Fixation Vulnerability in iDempiere WebUI
SELECT register_migration_script('202601312233_IDEMPIERE-6809.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jan 31, 2026, 10:33:36 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200292,0,0,TO_TIMESTAMP('2026-01-31 22:33:35','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-01-31 22:33:35','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SESSION_FINGERPRINT_ENABLED','Y','Defines if session fingerprinting is enabled for security','D','S','019c15f9-c3e7-734a-ae18-cb76d0d1065e')
;

-- Jan 31, 2026, 10:35:20 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200293,0,0,TO_TIMESTAMP('2026-01-31 22:35:20','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-01-31 22:35:20','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SESSION_FINGERPRINT_CHECK_ACCEPT_LANGUAGE','S','Defines action when Accept-Language varies -> (N)othing | (W)arning | (L)og Severe | (S)top','D','S','019c15fb-5aed-7ca2-92b3-f829d88c55cb')
;

-- Jan 31, 2026, 10:35:49 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200294,0,0,TO_TIMESTAMP('2026-01-31 22:35:49','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-01-31 22:35:49','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SESSION_FINGERPRINT_CHECK_USER_AGENT','S','Defines action when User Agent varies -> (N)othing | (W)arning | (L)og Severe | (S)top','D','S','019c15fb-cea9-7415-9ea8-a580d24a5769')
;

-- Jan 31, 2026, 10:36:31 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200295,0,0,TO_TIMESTAMP('2026-01-31 22:36:31','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2026-01-31 22:36:31','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZK_SESSION_FINGERPRINT_CHECK_IP','L','Defines action when IP Address varies -> (N)othing | (W)arning | (L)og Severe | (S)top','D','S','019c15fc-7216-7163-ba18-43efd17ba455')
;

-- Feb 1, 2026, 4:15:22 PM CET
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_TIMESTAMP('2026-02-01 16:15:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=777
;

