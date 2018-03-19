-- Sep 11, 2012 5:02:55 PM COT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200019,'D','S','Y','Show reset password button on login panel','9b0ac996-a542-44e5-9777-a284402a9788',TO_DATE('2012-09-11 17:02:54','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-09-11 17:02:54','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'LOGIN_SHOW_RESETPASSWORD')
;

SELECT register_migration_script('909_IDEMPIERE-375.sql') FROM dual
;

