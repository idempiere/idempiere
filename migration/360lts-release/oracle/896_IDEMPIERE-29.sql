-- Aug 29, 2012 9:03:37 AM COT
-- IDEMPIERE-29 Improvement on full location
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Show Location',200024,'D','9ddf0097-1eb7-4e6f-88a0-1dfdd6334097','ShowLocation','Y',TO_DATE('2012-08-29 09:03:36','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-08-29 09:03:36','YYYY-MM-DD HH24:MI:SS'))
;

-- Aug 29, 2012 9:03:37 AM COT
-- IDEMPIERE-29 Improvement on full location
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200024 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='896_IDEMPIERE-29.sql'
WHERE LastMigrationScriptApplied<'896_IDEMPIERE-29.sql'
   OR LastMigrationScriptApplied IS NULL
;
