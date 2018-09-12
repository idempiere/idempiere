-- IDEMPIERE-3696 Implementing warning to encourage user to change their password before it is expired
-- Apr 24, 2018 9:44:15 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Your password will expire in {0} days',0,0,'Y',TO_TIMESTAMP('2018-04-24 21:44:15','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2018-04-24 21:44:15','YYYY-MM-DD HH24:MI:SS'),0,200453,'YourPasswordWillExpireInDays','D','85f74e09-67bf-4044-a276-a0bb07bb73f9')
;

-- Apr 24, 2018 9:44:22 PM CEST
UPDATE AD_Message SET EntityType='D',Updated=TO_TIMESTAMP('2018-04-24 21:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Message_ID=200453
;

-- Apr 24, 2018 9:44:44 PM CEST
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200117,0,0,TO_TIMESTAMP('2018-04-24 21:44:44','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2018-04-24 21:44:44','YYYY-MM-DD HH24:MI:SS'),0,0,'Y','USER_LOCKING_PASSWORD_NOTIFY_DAY','0','Define a period (before password is expired) where a popup will appears to encourage user to change its password','D','S','92d15407-ddc2-4100-b2ae-bdccca3098d6')
;

SELECT register_migration_script('201804242200_IDEMPIERE-3696.sql') FROM dual
;
