-- Sep 5, 2012 6:21:41 PM COT
-- IDEMPIERE-377 Improve current search dialog box
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Name is required',200035,'D','303c9cf1-6159-4b47-82ff-9d10eed69845','NeedsName','Y',TO_DATE('2012-09-05 18:21:40','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-05 18:21:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 5, 2012 6:21:41 PM COT
-- IDEMPIERE-377 Improve current search dialog box
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200035 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 5, 2012 6:22:20 PM COT
-- IDEMPIERE-377 Improve current search dialog box
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','New Query',200036,'D','b12c3245-60f6-4da7-aa47-793370395735','New Query','Y',TO_DATE('2012-09-05 18:22:20','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-09-05 18:22:20','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 5, 2012 6:22:20 PM COT
-- IDEMPIERE-377 Improve current search dialog box
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200036 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('903_IDEMPIERE-377.sql') FROM dual
;

