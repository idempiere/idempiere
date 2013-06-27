-- Jun 1, 2013 10:06:30 AM COT
-- IDEMPIERE-1004 Account Info title translation
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','Posting',200177,'D','fa29733a-5b1d-44b4-b1e1-875e3fb18e4f','Posting','Y',TO_DATE('2013-06-01 10:06:28','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-06-01 10:06:28','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jun 1, 2013 10:06:30 AM COT
-- IDEMPIERE-1004 Account Info title translation
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200177 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201306011007_IDEMPIERE-1004.sql') FROM dual
;

