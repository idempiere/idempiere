-- Jun 2, 2013 1:51:02 PM CEST
-- IDEMPIERE-1009 Translation of tree popup
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200178,'8619a78f-92b8-4f84-b2ea-8cea0a7af2e5',0,TO_DATE('2013-06-02 13:51:01','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Move into','I',TO_DATE('2013-06-02 13:51:01','YYYY-MM-DD HH24:MI:SS'),100,'MoveInto')
;

-- Jun 2, 2013 1:51:03 PM CEST
-- IDEMPIERE-1009 Translation of tree popup
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200178 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jun 2, 2013 1:51:19 PM CEST
-- IDEMPIERE-1009 Translation of tree popup
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Message_UU,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200179,'91f51d98-8afb-4a08-ba21-f4b24fa8da04',0,TO_DATE('2013-06-02 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Insert after','I',TO_DATE('2013-06-02 13:51:19','YYYY-MM-DD HH24:MI:SS'),100,'InsertAfter')
;

-- Jun 2, 2013 1:51:19 PM CEST
-- IDEMPIERE-1009 Translation of tree popup
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200179 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

