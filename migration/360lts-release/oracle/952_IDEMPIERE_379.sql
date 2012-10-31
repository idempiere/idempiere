-- Oct 2, 2012 12:23:41 PM COT
-- IDEMPIERE-379
INSERT INTO AD_Form (AccessLevel,Classname,AD_Form_ID,IsBetaFunctionality,EntityType,AD_Form_UU,Description,Name,AD_Org_ID,UpdatedBy,CreatedBy,Updated,Created,AD_Client_ID,IsActive) VALUES ('3','org.adempiere.webui.apps.form.WReportCustomization',200002,'N','D','df3440d4-deb8-4e09-8426-4e16c426a6d4','Report Wizard','Report Wizard',0,100,100,TO_DATE('2012-10-02 12:23:40','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-10-02 12:23:40','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Oct 2, 2012 12:23:41 PM COT
-- IDEMPIERE-379
INSERT INTO AD_Form_Trl (AD_Language,AD_Form_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Form_Trl_UU ) SELECT l.AD_Language,t.AD_Form_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Form t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Form_ID=200002 AND NOT EXISTS (SELECT * FROM AD_Form_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Form_ID=t.AD_Form_ID)
;

-- Oct 29, 2012 11:41:16 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Wizard Reports',200090,'D','63eb4702-952c-45b0-a1d4-f1f24da0ab8f','PrintWizard','Y',TO_DATE('2012-10-29 11:41:14','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:41:14','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:41:16 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200090 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 29, 2012 11:43:10 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','DisplayFields of the Report',200091,'D','41e9c752-85f6-4b33-aa65-6eb12485aff4','DisplayFields','Y',TO_DATE('2012-10-29 11:43:09','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:43:09','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:43:10 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200091 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 29, 2012 11:43:35 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Order Fields',200092,'D','ae9db55f-5598-4ca5-a27e-29312287676e','FieldOrder','Y',TO_DATE('2012-10-29 11:43:35','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:43:35','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:43:35 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200092 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 29, 2012 11:43:55 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Sort Criteria',200093,'D','065b283c-eff9-41c2-836d-545357084bf1','SortCriteria','Y',TO_DATE('2012-10-29 11:43:55','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:43:55','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:43:55 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200093 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 29, 2012 11:44:14 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Grouping Criteria',200094,'D','05606939-e721-47cc-8ecf-669545b13927','GroupingCriteria','Y',TO_DATE('2012-10-29 11:44:13','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:44:13','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:44:14 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200094 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 29, 2012 11:44:32 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Summary Fields',200095,'D','24658bb4-e167-422e-8be8-d8abf34fd2bd','SummaryFields','Y',TO_DATE('2012-10-29 11:44:31','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:44:31','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:44:32 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200095 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 29, 2012 11:46:22 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','New Print Format',200096,'D','f2fef925-de44-43f6-ae53-63b3db453056','CreatePrintFormat','Y',TO_DATE('2012-10-29 11:46:21','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:46:21','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:46:22 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200096 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;


-- Oct 29, 2012 11:48:28 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Un select all fields',200099,'D','f3ad42fd-b1aa-494e-ad24-22e96fb15733','DeSelectAll','Y',TO_DATE('2012-10-29 11:48:27','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-29 11:48:27','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 29, 2012 11:48:28 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200099 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Oct 29, 2012 11:56:10 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_ToolBarButton (Name,ComponentName,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,IsActive,AD_ToolBarButton_UU,Action) VALUES ('Zk-ReportWizard','org.idempiere.ui.report','N',0,0,0,0,TO_DATE('2012-10-29 11:56:09','YYYY-MM-DD HH24:MI:SS'),100,200066,TO_DATE('2012-10-29 11:56:09','YYYY-MM-DD HH24:MI:SS'),100,'Y','6009b32b-e28e-4c13-87fc-4df00c5730c9','R')
;

-- Oct 30, 2012 10:00:40 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
UPDATE AD_ToolBarButton SET Name='Report - Wizard', ComponentName='Wizard',Updated=TO_DATE('2012-10-30 10:00:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200066
;

-- Oct 30, 2012 10:08:19 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
UPDATE AD_Message SET MsgText='Copy Print Format',Updated=TO_DATE('2012-10-30 10:08:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200096
;

-- Oct 30, 2012 10:08:19 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200096
;

-- Oct 30, 2012 10:08:56 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
UPDATE AD_Message SET MsgText='Deselect All',Updated=TO_DATE('2012-10-30 10:08:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200099
;

-- Oct 30, 2012 10:08:56 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200099
;

-- Oct 30, 2012 10:11:45 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
UPDATE AD_Message SET MsgText='Fields Displayed',Updated=TO_DATE('2012-10-30 10:11:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200091
;

-- Oct 30, 2012 10:11:45 AM COT
-- IDEMPIERE-379 Reporting wizard for end users
UPDATE AD_Message_Trl SET IsTranslated='N' WHERE AD_Message_ID=200091
;

-- Oct 30, 2012 5:34:18 PM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Run Report',200100,'D','5638ff96-ff60-49f0-9871-004f7fa2420e','Run','Y',TO_DATE('2012-10-30 17:34:15','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-10-30 17:34:15','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 30, 2012 5:34:18 PM COT
-- IDEMPIERE-379 Reporting wizard for end users
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200100 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('923_IDEMPIERE_379.sql') FROM dual
;

