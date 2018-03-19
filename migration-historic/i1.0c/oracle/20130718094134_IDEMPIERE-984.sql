-- Jul 18, 2013 9:41:34 AM COT
-- IDEMPIERE-984 Change Role and Logout must check for unsaved records on open windows
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Org_ID,Created,AD_Client_ID) VALUES ('I','You''re trying to close this tab.',200208,'D','2955ff22-87ac-401a-b5f8-66be72ad82a2','CloseTabFromBrowser?','Y',TO_DATE('2013-07-18 09:41:33','YYYY-MM-DD HH24:MI:SS'),100,100,0,TO_DATE('2013-07-18 09:41:33','YYYY-MM-DD HH24:MI:SS'),0)
;

-- Jul 18, 2013 9:41:34 AM COT
-- IDEMPIERE-984 Change Role and Logout must check for unsaved records on open windows
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200208 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('20130718094134_IDEMPIERE-984.sql') FROM dual
;

