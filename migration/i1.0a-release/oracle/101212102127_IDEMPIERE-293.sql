-- Dec 10, 2012 10:54:11 AM GMT+05:30
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Save Your Work!!',200119,'U','1112b509-9720-48e0-82d1-a1dd3ae6fa8e','killsession.saveWorkMessage','Y',TO_DATE('2012-12-10 10:54:07','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-10 10:54:07','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 10, 2012 10:54:12 AM GMT+05:30
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200119 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Dec 10, 2012 10:58:29 AM GMT+05:30
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Minutes',200120,'U','2d5c7599-a6b9-4473-8b37-ab218b84a8e6','Minutes','Y',TO_DATE('2012-12-10 10:58:28','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-10 10:58:28','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 10, 2012 10:58:29 AM GMT+05:30
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200120 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Dec 10, 2012 10:58:55 AM GMT+05:30
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Seconds',200121,'U','fc766ea7-3c62-4b35-bb55-42bf44c22185','Seconds','Y',TO_DATE('2012-12-10 10:58:53','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-10 10:58:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 10, 2012 10:58:55 AM GMT+05:30
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200121 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Dec 10, 2012 11:01:26 AM GMT+05:30
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','You will be logged out in',200122,'U','b31b81ec-39c1-4ac6-b9de-47744d10b7a6','killsession.logoutMessage','Y',TO_DATE('2012-12-10 11:01:25','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-10 11:01:25','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 10, 2012 11:01:26 AM GMT+05:30
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200122 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('101212102127_IDEMPIERE-293.sql') FROM dual
;
