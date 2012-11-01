-- Jul 12, 2012 4:35:39 PM CEST
-- IDEMPIERE-338 Translation of Doc messages
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200006,0,TO_DATE('2012-07-12 16:35:37','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Cannot post inactive document','I',TO_DATE('2012-07-12 16:35:37','YYYY-MM-DD HH24:MI:SS'),100,'CannotPostInactiveDocument')
;

-- Jul 12, 2012 4:35:39 PM CEST
-- IDEMPIERE-338 Translation of Doc messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200006 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 12, 2012 4:35:51 PM CEST
-- IDEMPIERE-338 Translation of Doc messages
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200007,0,TO_DATE('2012-07-12 16:35:50','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Cannot Lock - ReSubmit','I',TO_DATE('2012-07-12 16:35:50','YYYY-MM-DD HH24:MI:SS'),100,'CannotLockReSubmit')
;

-- Jul 12, 2012 4:35:51 PM CEST
-- IDEMPIERE-338 Translation of Doc messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200007 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 12, 2012 4:35:59 PM CEST
-- IDEMPIERE-338 Translation of Doc messages
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200008,0,TO_DATE('2012-07-12 16:35:59','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Cannot Lock - ReSubmit or RePost with Force','I',TO_DATE('2012-07-12 16:35:59','YYYY-MM-DD HH24:MI:SS'),100,'CannotLockReSubmitOrRePostWithForce')
;

-- Jul 12, 2012 4:35:59 PM CEST
-- IDEMPIERE-338 Translation of Doc messages
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200008 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='852_IDEMPIERE-338.sql'
WHERE LastMigrationScriptApplied<'852_IDEMPIERE-338.sql'
   OR LastMigrationScriptApplied IS NULL
;

