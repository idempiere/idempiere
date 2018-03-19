-- Aug 22, 2012 8:29:01 PM COT
-- IDEMPIERE-377 Improve current search dialog box
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Saved Query',200015,'D','5858f98d-e767-41a4-9691-6f762e8e1c71','SavedQuery','Y',TO_TIMESTAMP('2012-08-22 20:29:00','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-08-22 20:29:00','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 22, 2012 8:29:01 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200015 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='890_IDEMPIERE-377.sql'
WHERE LastMigrationScriptApplied<'890_IDEMPIERE-377.sql'
   OR LastMigrationScriptApplied IS NULL
;
