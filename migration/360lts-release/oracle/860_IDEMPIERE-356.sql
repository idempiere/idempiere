-- 02-ago-2012 11:56:30 COT
-- Message for Change Role
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Change Role',200010,'D','3270b7fc-6899-4c6d-9d76-bb754ecbee61','changeRole','Y',TO_DATE('2012-08-02 11:56:28','YYYY-MM-DD HH24:MI:SS'),0,0,0,0,TO_DATE('2012-08-02 11:56:28','YYYY-MM-DD HH24:MI:SS'))
;

-- 02-ago-2012 11:56:30 COT
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200010 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;


UPDATE AD_System
  SET LastMigrationScriptApplied='860_IDEMPIERE-356.sql'
WHERE LastMigrationScriptApplied<'860_IDEMPIERE-356.sql'
   OR LastMigrationScriptApplied IS NULL
;
