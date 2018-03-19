-- Jan 17, 2013 5:41:53 PM COT
--  
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Invalid User ID or Password',200135,'D','39bde5a5-da86-4147-a5de-433003a66976','FailedLogin','Y',TO_TIMESTAMP('2013-01-17 17:41:51','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_TIMESTAMP('2013-01-17 17:41:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Jan 17, 2013 5:41:53 PM COT
--  
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200135 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201301181034_TICKET-1002007.sql') FROM dual
;

