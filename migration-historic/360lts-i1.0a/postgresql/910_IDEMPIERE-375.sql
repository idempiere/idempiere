-- Sep 12, 2012 6:56:41 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_SysConfig (AD_SysConfig_ID,EntityType,ConfigurationLevel,Value,Description,AD_SysConfig_UU,Created,Updated,AD_Client_ID,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name) VALUES (200020,'D','S','Y','New password must differs from the old password','13b5a576-7b91-471b-8b40-05589dd585f7',TO_TIMESTAMP('2012-09-12 18:56:39','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-09-12 18:56:39','YYYY-MM-DD HH24:MI:SS'),0,0,100,'Y',100,'CHANGE_PASSWORD_MUST_DIFFER')
;

-- Sep 12, 2012 6:57:05 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Column SET FieldLength=1024,Updated=TO_TIMESTAMP('2012-09-12 18:57:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200457
;

-- Sep 12, 2012 6:57:13 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO t_alter_column values('ad_user','SecurityQuestion','VARCHAR(1024)',null,'NULL')
;

-- Sep 12, 2012 6:58:41 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','New Password must differ from Old Password',200066,'U','0d873a03-0980-4725-8a4f-a6954e4ee59e','NewPasswordMustDiffer','Y',TO_TIMESTAMP('2012-09-12 18:58:40','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-12 18:58:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 12, 2012 6:58:41 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200066 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 12, 2012 6:58:45 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
UPDATE AD_Message SET EntityType='D',Updated=TO_TIMESTAMP('2012-09-12 18:58:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200066
;

UPDATE AD_User u SET SecurityQuestion = (
SELECT MAX(m.MsgText) FROM AD_Message m WHERE m.Value = u.SecurityQuestion)  
WHERE u.SecurityQuestion IS NOT NULL;

SELECT register_migration_script('910_IDEMPIERE-375.sql') FROM dual
;