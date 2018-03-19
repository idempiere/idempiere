-- May 17, 2013 11:59:06 AM COT
-- IDEMPIERE-933 Window Customization Security Hole
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','The reference of an encrypted field cannot be changed',200175,'D','f09382d4-62bb-48a8-abb9-d71ec5fbc5fe','NotChangeReference','Y',TO_DATE('2013-05-17 11:59:05','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-05-17 11:59:05','YYYY-MM-DD HH24:MI:SS'),0)
;

-- May 17, 2013 11:59:06 AM COT
-- IDEMPIERE-933 Window Customization Security Hole
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200175 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201305171202_IDEMPIERE-933.sql') FROM dual
;
