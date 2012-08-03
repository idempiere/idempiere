-- Aug 1, 2012 4:43:04 PM COT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Select Role',200009,'D','15bdd556-85d4-4518-87e9-4ab298c49bb0','SelectRole','Y',TO_DATE('2012-08-01 16:43:01','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_DATE('2012-08-01 16:43:01','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 1, 2012 4:43:04 PM COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200009 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='859_IDEMPIERE-354.sql'
WHERE LastMigrationScriptApplied<'859_IDEMPIERE-354.sql'
   OR LastMigrationScriptApplied IS NULL
;

