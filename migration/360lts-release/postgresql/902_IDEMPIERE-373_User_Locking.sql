-- Sep 5, 2012 2:19:04 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','User account ''{0}'' is locked, please contact the system administrator',200032,'D','4953cc21-e6db-40c6-bc8c-58f089e4786a','UserAccountLocked','Y',TO_TIMESTAMP('2012-09-05 14:19:02','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-05 14:19:02','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 5, 2012 2:19:05 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200032 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 5, 2012 2:19:26 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Reached the maximum number of login attempts, user account ''{0}'' is locked',200033,'D','f8a4fc39-5346-4064-8f3a-436fcac03920','ReachedMaxLoginAttempts','Y',TO_TIMESTAMP('2012-09-05 14:19:25','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-05 14:19:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 5, 2012 2:19:26 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200033 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 5, 2012 2:19:44 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Invalid User ID or Password (Login Attempts: {0} / {1})',200034,'D','77c2348b-0910-43aa-a6c0-f3c143a52de4','FailedLoginAttempt','Y',TO_TIMESTAMP('2012-09-05 14:19:43','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-05 14:19:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 5, 2012 2:19:44 PM SGT
-- IDEMPIERE-373 Implement User Locking
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200034 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('902_IDEMPIERE-373_User_Locking.sql') FROM dual