-- Dec 21, 2012 7:16:06 AM EST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Acknowledge',200130,'U','263e6f73-5932-4e07-979f-1482319a6409','Acknowledge','Y',TO_DATE('2012-12-21 07:16:05','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-12-21 07:16:05','YYYY-MM-DD HH24:MI:SS'))
;

-- Dec 21, 2012 7:16:06 AM EST
-- IDEMPIERE-294 Create a mechanism to broadcast messages to clients
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200130 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201212211710_IDEMPIERE-294.sql') FROM dual
;