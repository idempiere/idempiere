SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 26, 2013 1:13:43 PM COT
-- IDEMPIERE-136 Tenant base language improvement
INSERT INTO AD_FieldGroup (FieldGroupType,EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_UU,AD_FieldGroup_ID,AD_Client_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive) VALUES ('C','D','Y','Technical','700085b2-dfb4-49ad-85e8-fcc27b9b8f2d',200015,0,TO_DATE('2013-03-26 13:13:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-26 13:13:42','YYYY-MM-DD HH24:MI:SS'),0,100,'Y')
;

-- Mar 26, 2013 1:13:43 PM COT
INSERT INTO AD_FieldGroup_Trl (AD_Language,AD_FieldGroup_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_FieldGroup_Trl_UU ) SELECT l.AD_Language,t.AD_FieldGroup_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_FieldGroup t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_FieldGroup_ID=200015 AND NOT EXISTS (SELECT * FROM AD_FieldGroup_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_FieldGroup_ID=t.AD_FieldGroup_ID)
;

-- Mar 26, 2013 1:14:50 PM COT
UPDATE AD_Field SET SeqNo=200, AD_FieldGroup_ID=200015,Updated=TO_DATE('2013-03-26 13:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11024
;

-- Mar 26, 2013 1:14:50 PM COT
UPDATE AD_Field SET SeqNo=210, AD_FieldGroup_ID=200015,Updated=TO_DATE('2013-03-26 13:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54238
;

-- Mar 26, 2013 1:14:50 PM COT
UPDATE AD_Field SET SeqNo=220, AD_FieldGroup_ID=200015,Updated=TO_DATE('2013-03-26 13:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=54680
;

-- Mar 26, 2013 1:14:50 PM COT
UPDATE AD_Field SET SeqNo=230, AD_FieldGroup_ID=200015,Updated=TO_DATE('2013-03-26 13:14:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200096
;

-- Mar 26, 2013 1:18:52 PM COT
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value) VALUES ('N',200039,'N','N','448fa1f7-ca47-400e-b535-4827974e705d','4','N','N',0,0,'Y','D','Verify Language Configuration',0,0,TO_DATE('2013-03-26 13:18:51','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-26 13:18:51','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.idempiere.process.VerifyLanguageConfiguration','VerifyLanguageConfiguration')
;

-- Mar 26, 2013 1:18:52 PM COT
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200039 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Mar 26, 2013 1:19:04 PM COT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,IsCentrallyMaintained,Name,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200047,'N','N','N',200039,'D','Y','Verify Language Configuration','P','48ebb9f8-189a-4497-8230-d87595f529a5','Y',0,100,TO_DATE('2013-03-26 13:19:03','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-03-26 13:19:03','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 26, 2013 1:19:04 PM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200047 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 26, 2013 1:19:04 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200047, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200047)
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 26, 2013 1:19:40 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 26, 2013 1:21:15 PM COT
INSERT INTO AD_Process (CopyFromProcess,Help,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Description,Name,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Classname,Value) VALUES ('N','In order to enable en_US as a translation you can enable any other language as base language.
If you don''t want to have a base language choose a language that won''t be used for login.
If all languages are going to be used as login, create a xx_XX language not login and use it as base.',200040,'N','N','9220f1d3-fb15-4a0b-8d14-ebe57681ff39','4','N','N',0,0,'Y','D','Change Base Language','Change Base Language',0,0,TO_DATE('2013-03-26 13:21:14','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-26 13:21:14','YYYY-MM-DD HH24:MI:SS'),'Y',100,'org.idempiere.process.ChangeBaseLanguage','ChangeBaseLanguage')
;

-- Mar 26, 2013 1:21:15 PM COT
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200040 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Mar 26, 2013 1:23:43 PM COT
INSERT INTO AD_Reference (AD_Reference_ID,Name,EntityType,AD_Reference_UU,IsOrderByValue,Description,ValidationType,AD_Client_ID,AD_Org_ID,CreatedBy,Updated,IsActive,Created,UpdatedBy) VALUES (200069,'AD_Language NOT System/Base','D','ad7b3ed9-6c90-430e-937f-b42ecd6fe1b0','N','Language not system neither base','T',0,0,100,TO_DATE('2013-03-26 13:23:42','YYYY-MM-DD HH24:MI:SS'),'Y',TO_DATE('2013-03-26 13:23:42','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 26, 2013 1:23:43 PM COT
INSERT INTO AD_Reference_Trl (AD_Language,AD_Reference_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Reference_Trl_UU ) SELECT l.AD_Language,t.AD_Reference_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Reference t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Reference_ID=200069 AND NOT EXISTS (SELECT * FROM AD_Reference_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Reference_ID=t.AD_Reference_ID)
;

-- Mar 26, 2013 1:26:25 PM COT
INSERT INTO AD_Ref_Table (IsValueDisplayed,WhereClause,AD_Reference_ID,AD_Key,AD_Display,EntityType,AD_Table_ID,AD_Ref_Table_UU,CreatedBy,Updated,Created,AD_Client_ID,UpdatedBy,AD_Org_ID,IsActive) VALUES ('N','NOT (AD_Language.IsSystemLanguage=''Y'' OR AD_Language.IsBaseLanguage=''Y'')',200069,203,204,'D',111,'5c394413-3298-4a5d-8ea0-1a5e56b7ef7e',100,TO_DATE('2013-03-26 13:26:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2013-03-26 13:26:25','YYYY-MM-DD HH24:MI:SS'),0,100,0,'Y')
;

-- Mar 26, 2013 1:27:23 PM COT
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,Help,AD_Process_ID,AD_Reference_ID,IsMandatory,AD_Reference_Value_ID,EntityType,Name,ColumnName,Description,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',109,200063,'b3214e91-98da-4e45-ae86-56ae3a2304fc','The Language identifies the language to use for display and formatting',200040,18,'Y',200069,'D','Language','AD_Language','Language for this entity',10,'Y',10,'Y',100,TO_DATE('2013-03-26 13:27:21','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2013-03-26 13:27:21','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Mar 26, 2013 1:27:23 PM COT
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200063 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Mar 26, 2013 1:27:58 PM COT
INSERT INTO AD_Menu (AD_Menu_ID,IsSummary,IsSOTrx,IsReadOnly,AD_Process_ID,EntityType,IsCentrallyMaintained,Name,Action,AD_Menu_UU,IsActive,AD_Client_ID,CreatedBy,Updated,AD_Org_ID,Created,UpdatedBy) VALUES (200048,'N','N','N',200040,'D','Y','Change Base Language','P','5e18df98-6bc1-4a2d-afd6-f6345f8e9e03','Y',0,100,TO_DATE('2013-03-26 13:27:57','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2013-03-26 13:27:57','YYYY-MM-DD HH24:MI:SS'),100)
;

-- Mar 26, 2013 1:27:58 PM COT
INSERT INTO AD_Menu_Trl (AD_Language,AD_Menu_ID, Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Menu_Trl_UU ) SELECT l.AD_Language,t.AD_Menu_ID, t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Menu t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Menu_ID=200048 AND NOT EXISTS (SELECT * FROM AD_Menu_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Menu_ID=t.AD_Menu_ID)
;

-- Mar 26, 2013 1:27:58 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200048, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200048)
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=161
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=367
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=456
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=501
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=326
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=566
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=392
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=113
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=220
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=351
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=289
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=302
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=303
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200047
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200048
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=321
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=461
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53193
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=18, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53322
;

-- Mar 26, 2013 1:28:04 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=155, SeqNo=19, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=383
;

-- Mar 26, 2013 1:28:41 PM COT
UPDATE AD_Process SET Help='In order to enable en_US as a translation you can enable any other language as base language.
If you don''t want to have a base language choose a language that won''t be used for login.
If all languages are going to be used as login, create a xx_XX language not login and use it as base.
Please note that base language cannot be a system language.',Updated=TO_DATE('2013-03-26 13:28:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200040
;

-- Mar 26, 2013 1:28:41 PM COT
UPDATE AD_Process_Trl SET IsTranslated='N' WHERE AD_Process_ID=200040
;

-- Mar 26, 2013 1:28:41 PM COT
UPDATE AD_Menu SET Name='Change Base Language', Description='Change Base Language', IsActive='Y',Updated=TO_DATE('2013-03-26 13:28:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200048
;

-- Mar 26, 2013 1:28:41 PM COT
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=200048
;

-- Mar 26, 2013 1:33:05 PM COT
INSERT INTO AD_TreeNodeMM (AD_Client_ID,AD_Org_ID, IsActive,Created,CreatedBy,Updated,UpdatedBy, AD_Tree_ID, Node_ID, Parent_ID, SeqNo, AD_TreeNodeMM_UU) SELECT t.AD_Client_ID, 0, 'Y', SysDate, 100, SysDate, 100,t.AD_Tree_ID, 200049, 0, 999, Generate_UUID() FROM AD_Tree t WHERE t.AD_Client_ID=0 AND t.IsActive='Y' AND t.IsAllNodes='Y' AND t.TreeType='MM' AND NOT EXISTS (SELECT * FROM AD_TreeNodeMM e WHERE e.AD_Tree_ID=t.AD_Tree_ID AND Node_ID=200049)
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=334
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=498
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=224
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=145
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=336
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=341
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=144
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=170
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=465
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=101
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=294
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=395
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=296
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=221
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=14, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=233
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=15, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=290
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=16, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=109
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=161, SeqNo=17, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=50008
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Mar 26, 2013 1:35:39 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=218
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=153
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=263
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=166
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=203
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53242
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=236
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=183
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=160
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=278
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=345
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53296
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53014
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=0, SeqNo=13, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53108
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200049
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Mar 26, 2013 1:35:47 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200049
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Mar 26, 2013 1:36:03 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200049
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Mar 26, 2013 1:36:10 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=0, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=261
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=1, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53202
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=2, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=225
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=3, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200026
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=4, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200009
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=5, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=148
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=6, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=529
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=7, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=397
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=8, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=532
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=9, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=53084
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=10, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=514
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=11, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200049
;

-- Mar 26, 2013 1:36:13 PM COT
UPDATE AD_TreeNodeMM SET Parent_ID=156, SeqNo=12, Updated=SysDate WHERE AD_Tree_ID=10 AND Node_ID=200027
;

-- Mar 27, 2013 10:12:17 PM COT
-- IDEMPIERE-136 Tenant base language improvement
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','If you change the client language is recommended that you run the Synchronize Doc Translation after that',200157,'D','2ef34f79-6d6d-4ac7-a9ac-d119491bddbf','ClientLanguageWarning','Y',TO_DATE('2013-03-27 22:12:16','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2013-03-27 22:12:16','YYYY-MM-DD HH24:MI:SS'))
;

-- Mar 27, 2013 10:12:17 PM COT
-- IDEMPIERE-136 Tenant base language improvement
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200157 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Mar 27, 2013 10:15:13 PM COT
-- IDEMPIERE-136 Tenant base language improvement
UPDATE AD_Process SET Help='This applies to the client defined document translations, e.g. for UoM, Payment Terms, Product Info, etc.<br>
<br>
If the current client has multi-lingual documents enabled, then the main record is copied to the client language (defined in Client window).  BE CAREFUL as this option can potentially damage data you modified, it is recommended to take a backup and plan carefully what you''re doing if this is the first time running this process.<br>
<br>
If the current client has not multi-lingual documents enabled, the translations for documents are synchronized with the main record (i.e. it copies the content of the main record to the translation records).  This process is necessary when swiching to a mono-lingual environment as there the terminoligy is maintained not in the translation records.',Updated=TO_DATE('2013-03-27 22:15:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=321
;

-- 27/03/2013 10:31:51 PM COT
-- IDEMPIERE-136 Tenant base language improvement
UPDATE AD_Language SET IsLoginLocale='Y',Updated=TO_DATE('2013-03-27 22:31:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Language_ID=192
;

-- Mar 27, 2013 10:39:25 PM COT
-- IDEMPIERE-136 Tenant base language improvement
UPDATE AD_Column SET Callout='org.compiere.model.CalloutClient.clientLanguageWarning',Updated=TO_DATE('2013-03-27 22:39:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=6556
;

SELECT register_migration_script('201303261336_IDEMPIERE-136.sql') FROM dual
;

