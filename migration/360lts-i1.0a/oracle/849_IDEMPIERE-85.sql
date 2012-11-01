-- Jul 4, 2012 10:38:00 AM CEST
-- IDEMPIERE-85 Add confirmation on TreeMaintenance when moving all nodes
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200004,0,TO_DATE('2012-07-04 10:37:58','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Add all items on tree ?','I',TO_DATE('2012-07-04 10:37:58','YYYY-MM-DD HH24:MI:SS'),100,'TreeAddAllItems')
;

-- Jul 4, 2012 10:38:00 AM CEST
-- IDEMPIERE-85 Add confirmation on TreeMaintenance when moving all nodes
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200004 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Jul 4, 2012 10:38:19 AM CEST
-- IDEMPIERE-85 Add confirmation on TreeMaintenance when moving all nodes
INSERT INTO AD_Message (AD_Client_ID,AD_Message_ID,AD_Org_ID,Created,CreatedBy,EntityType,IsActive,MsgText,MsgType,Updated,UpdatedBy,Value) VALUES (0,200005,0,TO_DATE('2012-07-04 10:38:19','YYYY-MM-DD HH24:MI:SS'),100,'D','Y','Remove all items from tree ?','I',TO_DATE('2012-07-04 10:38:19','YYYY-MM-DD HH24:MI:SS'),100,'TreeRemoveAllItems')
;

-- Jul 4, 2012 10:38:19 AM CEST
-- IDEMPIERE-85 Add confirmation on TreeMaintenance when moving all nodes
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

UPDATE AD_System
  SET LastMigrationScriptApplied='849_IDEMPIERE-85.sql'
WHERE LastMigrationScriptApplied<'849_IDEMPIERE-85.sql'
   OR LastMigrationScriptApplied IS NULL
;

