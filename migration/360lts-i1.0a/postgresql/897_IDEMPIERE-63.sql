-- Aug 29, 2012 6:44:34 PM COT
-- IDEMPIERE-63 Document number is updated again when document completed after reactivation
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Document type cannot be changed when overwrite document number on complete is set and the document was already processed',200025,'D','1bc9f344-4855-473d-a058-424dfd6d9a1e','CannotChangeProcessedDocType','Y',TO_TIMESTAMP('2012-08-29 18:44:33','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-08-29 18:44:33','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 29, 2012 6:44:34 PM COT
-- IDEMPIERE-63 Document number is updated again when document completed after reactivation
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200025 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Aug 29, 2012 6:44:57 PM COT
-- IDEMPIERE-63 Document number is updated again when document completed after reactivation
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Date cannot be changed when overwrite date on complete is set and the document was already processed',200026,'D','81bf5a40-ae47-4dcf-9be3-9d04d0c9116f','CannotChangeProcessedDate','Y',TO_TIMESTAMP('2012-08-29 18:44:56','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-08-29 18:44:56','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 29, 2012 6:44:57 PM COT
-- IDEMPIERE-63 Document number is updated again when document completed after reactivation
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200026 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='897_IDEMPIERE-63.sql'
WHERE LastMigrationScriptApplied<'897_IDEMPIERE-63.sql'
   OR LastMigrationScriptApplied IS NULL
;

