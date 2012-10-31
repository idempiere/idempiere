-- Oct 7, 2012 7:15:57 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,IsActive,AD_ToolBarButton_UU) VALUES ('zk Window - File Import','FileImport','org.idempiere.ui.window','N',0,0,0,0,TO_TIMESTAMP('2012-10-07 19:15:57','YYYY-MM-DD HH24:MI:SS'),100,200067,TO_TIMESTAMP('2012-10-07 19:15:57','YYYY-MM-DD HH24:MI:SS'),100,'Y','afdd17a6-5fd1-411e-8596-5310aa68785f')
;

-- Oct 25, 2012 11:42:24 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Field {0} not found',200082,'D','a41866df-ebaf-4ea4-a5be-694b21d076c6','FieldNotFound','Y',TO_TIMESTAMP('2012-10-25 23:42:22','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:42:22','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:42:24 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200082 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:43:32 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','{0} not a window field',200083,'D','ff2e000e-330e-40d7-8da2-37c558c02fae','NotAWindowField','Y',TO_TIMESTAMP('2012-10-25 23:43:31','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:43:31','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:43:32 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200083 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:45:01 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','{0} is readonly',200084,'D','914303a5-b1b7-46db-9d3d-953258f1815c','FieldIsReadOnly','Y',TO_TIMESTAMP('2012-10-25 23:45:00','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:45:00','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:45:01 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200084 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:45:50 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','{0} is not displayed',200085,'D','6406807b-ead4-4bbe-9221-8d3936e77f22','FieldNotDisplayed','Y',TO_TIMESTAMP('2012-10-25 23:45:49','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:45:49','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:45:50 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200085 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:46:55 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','{0} not resolved = ({1})',200086,'D','bbaa12b8-df37-4a2a-812f-144bbfdef1a9','ForeignNotResolved','Y',TO_TIMESTAMP('2012-10-25 23:46:53','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:46:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:46:55 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200086 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:48:44 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','ERROR: {0} parent cannot be changed',200087,'D','a47623df-6f91-42ad-9172-2459a680c3cf','ParentCannotChange','Y',TO_TIMESTAMP('2012-10-25 23:48:43','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:48:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:48:44 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200087 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:49:42 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','ERROR: {0} not editable',200088,'D','78a73537-7dee-44cc-b66d-76cfba2fb199','FieldNotEditable','Y',TO_TIMESTAMP('2012-10-25 23:49:40','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:49:40','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:49:42 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200088 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:50:46 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Successfully saved [{0}]',200089,'D','9d255a1a-e4ea-402b-98ee-ad168603b4c5','SuccessfullySaved','Y',TO_TIMESTAMP('2012-10-25 23:50:45','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-10-25 23:50:45','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 25, 2012 11:50:46 PM COT
-- IDEMPIERE-454 Easy import
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200089 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 25, 2012 11:50:57 PM COT
-- IDEMPIERE-454 Easy import
UPDATE AD_Message SET MsgType='I',Updated=TO_TIMESTAMP('2012-10-25 23:50:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200089
;

SELECT register_migration_script('928_IDEMPIERE-454.sql') FROM dual
;

