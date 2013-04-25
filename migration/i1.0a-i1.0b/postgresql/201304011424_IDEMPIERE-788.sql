-- Apr 1, 2013 2:15:25 PM COT
-- IDEMPIERE-788 Add translation support for popup request window from dashboard calendar 
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Event',200158,'D','8d8f6949-7469-4b37-b058-1a893951f983','Event','Y',TO_TIMESTAMP('2013-04-01 14:15:25','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-04-01 14:15:25','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Apr 1, 2013 2:15:25 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200158 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201304011424_IDEMPIERE-788.sql') FROM dual
;

