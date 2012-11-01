-- Oct 10, 2012 4:12:00 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Forgot My Password',200074,'D','edbc8af4-43a1-4966-8ee5-c609cf01a90c','ForgotMyPassword','Y',TO_TIMESTAMP('2012-10-10 16:11:57','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-10 16:11:57','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 10, 2012 4:12:00 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200074 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 10, 2012 4:29:44 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Passwords for all tenants using ({0}) as email have been reset',' ',200075,'D','51b49e9a-4c26-486a-ac83-e506ce282ab7','PasswordsForAllTenantsReset','Y',TO_TIMESTAMP('2012-10-10 16:29:43','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-10 16:29:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 10, 2012 4:29:44 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200075 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 10, 2012 4:31:02 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','The new password is now valid for all tenants',' ',200076,'D','be10802e-1a38-45cf-afd9-5bbe1776fead','NewPasswordValidForAllTenants','Y',TO_TIMESTAMP('2012-10-10 16:31:01','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-10 16:31:01','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 10, 2012 4:31:02 PM SGT
-- IDEMPIERE-375 Implement Forgot my Password
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200076 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('931_IDEMPIERE-375.sql') FROM dual
;
