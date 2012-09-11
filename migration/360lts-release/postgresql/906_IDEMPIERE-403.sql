-- Sep 10, 2012 6:08:27 PM COT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Language',null,200056,'D','5fd902a0-50b8-43f7-a611-b20f418bf0ae','Language','Y',TO_TIMESTAMP('2012-09-10 18:08:26','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_TIMESTAMP('2012-09-10 18:08:26','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 6:08:27 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200056 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 10, 2012 6:11:10 PM COT
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Role',null,200057,'D','b4f75e67-4543-4834-8a06-f8202384b3cf','Role','Y',TO_TIMESTAMP('2012-09-10 18:11:09','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_TIMESTAMP('2012-09-10 18:11:09','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 10, 2012 6:11:10 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200057 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('906_IDEMPIERE-403.sql') FROM dual
;
