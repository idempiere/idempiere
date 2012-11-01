-- Sep 18, 2012 2:38:36 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Form (AccessLevel,Classname,AD_Form_ID,Help,IsBetaFunctionality,EntityType,AD_Form_UU,Description,Name,AD_Org_ID,UpdatedBy,CreatedBy,Updated,Created,AD_Client_ID,IsActive) VALUES ('1','org.compiere.apps.form.VResetPassword',200001,NULL,'N','D','e2db983d-c11a-46f7-a4f5-fca8167c8d6c','Reset Password','Reset Password',0,100,100,TO_TIMESTAMP('2012-09-18 14:38:34','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2012-09-18 14:38:34','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Sep 18, 2012 2:38:38 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Form_Trl (AD_Language,AD_Form_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Form_Trl_UU ) SELECT l.AD_Language,t.AD_Form_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Form t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Form_ID=200001 AND NOT EXISTS (SELECT * FROM AD_Form_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Form_ID=t.AD_Form_ID)
;

-- Sep 18, 2012 2:39:13 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Form_ID,EntityType,IsCentrallyMaintained,Name,Description,"action",AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200017,'N','N','N',200001,'D','Y','Reset Password','Reset Passwords for User','X','c9aa4c76-894d-4a72-97de-38d0345fd477','Y',0,100,TO_TIMESTAMP('2012-09-18 14:39:12','YYYY-MM-DD HH24:MI:SS'),0,TO_TIMESTAMP('2012-09-18 14:39:12','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Sep 18, 2012 2:39:14 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200017 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Sep 18, 2012 2:39:14 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', CURRENT_TIMESTAMP, 100, CURRENT_TIMESTAMP, 100,t.AD_Tree_ID, 200017, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200017)
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=0, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200002
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=1, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=147
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=2, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53246
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=3, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200017
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=4, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=487
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=5, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200012
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=6, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=150
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=7, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=495
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=8, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=50007
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=9, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=362
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=10, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=200001
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=11, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=475
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=12, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=366
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=13, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=483
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=14, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=368
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=15, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=508
;

-- Sep 18, 2012 2:39:24 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_TreeNodeMM SET Parent_ID=367, SeqNo=16, Updated=CURRENT_TIMESTAMP WHERE AD_Tree_ID=10 AND Node_ID=53348
;

-- Sep 18, 2012 2:39:32 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
DELETE FROM AD_Menu_Trl WHERE AD_Menu_ID=487
;

-- Sep 18, 2012 2:39:33 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
DELETE FROM AD_Menu WHERE AD_Menu_ID=487
;

-- Sep 18, 2012 2:39:33 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
DELETE FROM AD_TreeNodeMM WHERE Node_ID=487 AND EXISTS (SELECT * FROM AD_Tree t WHERE t.AD_Tree_ID=AD_TreeNodeMM.AD_Tree_ID AND t.TreeType='MM')
;

-- Sep 18, 2012 2:48:49 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
UPDATE AD_Form SET AccessLevel='7',Updated=TO_TIMESTAMP('2012-09-18 14:48:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=200001
;

-- Sep 18, 2012 4:32:53 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message (MsgType,MsgText,MsgTip,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','User is Mandatory',NULL,200067,'D','40544a9e-776d-4f96-8ef1-f38de2237027','UserMandatory','Y',TO_TIMESTAMP('2012-09-18 16:32:51','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-18 16:32:51','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 4:32:53 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200067 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 18, 2012 4:35:14 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','New EMail does not match the Confirm New EMail',200068,'D','5046c7a0-0846-4f09-b130-d8280a043775','NewEmailNotMatch','Y',TO_TIMESTAMP('2012-09-18 16:35:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-18 16:35:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 4:35:14 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200068 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 18, 2012 4:35:51 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('E','Confirm New EMail is Mandatory',200069,'D','c9e44d6f-af2e-4306-bb84-2df8258ad79c','NewEmailConfirmMandatory','Y',TO_TIMESTAMP('2012-09-18 16:35:50','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-18 16:35:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 4:35:51 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 18, 2012 4:37:44 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Confirm New EMail',200070,'D','41282b1f-672c-43e0-b823-439b87fa0544','New EMail Confirm','Y',TO_TIMESTAMP('2012-09-18 16:37:43','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-18 16:37:43','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 4:37:44 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200070 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 18, 2012 4:38:20 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','New EMail',200071,'D','6a228718-3a23-46d3-8e0c-97a6511acc50','New EMail','Y',TO_TIMESTAMP('2012-09-18 16:38:19','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-18 16:38:19','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 4:38:20 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200071 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 18, 2012 4:38:36 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','New EMail User',200072,'D','3bf5a60b-20a1-484d-a5f0-11dbe95fcbce','New EMail User','Y',TO_TIMESTAMP('2012-09-18 16:38:35','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-18 16:38:35','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 4:38:36 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200072 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Sep 18, 2012 4:39:03 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','New EMail User Password',200073,'D','cfe2fcb8-81cc-4df5-b187-f1df99f8f842','New EMail User Password','Y',TO_TIMESTAMP('2012-09-18 16:38:59','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_TIMESTAMP('2012-09-18 16:38:59','YYYY-MM-DD HH24:MI:SS'))
;

-- Sep 18, 2012 4:39:03 PM SGT
-- IDEMPIERE-374 Change password must be changed to be a form instead of a process
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200073 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('913_IDEMPIERE-374.sql') FROM dual
;