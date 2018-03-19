-- Jul 31, 2013 9:00:38 AM COT
-- IDEMPIERE-840 Improvement to Request model class
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Sent by iDempiereMail',200218,'D','e1049e33-cbdc-4fc4-94fa-9e99f6bb07cc','RequestSentBy','Y',TO_TIMESTAMP('2013-07-31 09:00:30','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_TIMESTAMP('2013-07-31 09:00:30','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 31, 2013 9:00:38 AM COT
-- IDEMPIERE-840 Improvement to Request model class
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200218 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201307310904_IDEMPIERE-840.sql') FROM dual
;

