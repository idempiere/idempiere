-- Nov 7, 2012 2:27:45 PM COT
-- IDEMPIERE-457
INSERT INTO AD_Form (AccessLevel,Classname,AD_Form_ID,IsBetaFunctionality,EntityType,AD_Form_UU,Name,AD_Org_ID,UpdatedBy,CreatedBy,Updated,Created,AD_Client_ID,IsActive) VALUES ('4','org.compiere.apps.form.VTabEditor',200005,'N','D','4f5be293-6016-4bb5-9a7f-114018d1f1b7','Tab Editor',0,100,100,TO_DATE('2012-11-07 14:27:44','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-07 14:27:44','YYYY-MM-DD HH24:MI:SS'),0,'Y')
;

-- Nov 7, 2012 2:27:45 PM COT
-- IDEMPIERE-457
INSERT INTO AD_Form_Trl (AD_Language,AD_Form_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Form_Trl_UU ) SELECT l.AD_Language,t.AD_Form_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Form t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Form_ID=200005 AND NOT EXISTS (SELECT * FROM AD_Form_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Form_ID=t.AD_Form_ID)
;

-- Nov 7, 2012 2:28:05 PM COT
-- IDEMPIERE-457
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,AD_Form_ID,Name,Value,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy) VALUES ('N',200015,'N','N','0649c86f-a16d-427b-99d3-ee13408ff5c2','4','N','N',0,0,'Y','D',200005,'Tab Editor','TabEditor',0,0,TO_DATE('2012-11-07 14:28:04','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-07 14:28:04','YYYY-MM-DD HH24:MI:SS'),'Y',100)
;

-- Nov 7, 2012 2:28:05 PM COT
-- IDEMPIERE-457
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200015 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 7, 2012 2:28:21 PM COT
-- IDEMPIERE-457
INSERT INTO AD_ToolBarButton (Action,AD_Tab_ID,AD_Process_ID,SeqNo,IsCustomization,Name,ComponentName,AD_Client_ID,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,IsActive,AD_ToolBarButton_UU) VALUES ('W',106,200015,10,'N','Tab Editor','TabEditor',0,0,TO_DATE('2012-11-07 14:28:20','YYYY-MM-DD HH24:MI:SS'),100,200068,TO_DATE('2012-11-07 14:28:20','YYYY-MM-DD HH24:MI:SS'),100,'Y','ec63158f-8f95-4b24-a1ce-3caf0e1e738d')
;

-- Nov 7, 2012 2:29:45 PM COT
-- IDEMPIERE-457
UPDATE AD_ToolBarButton SET DisplayLogic='@IsSortTab@=N',Updated=TO_DATE('2012-11-07 14:29:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200068
;

-- Nov 12, 2012 6:03:28 PM COT
-- IDEMPIERE-457 Tab Editor (to ease positioning of fields)
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Property',200112,'D','8fefc045-b3aa-4bcf-a4ca-4db079842a67','Property','Y',TO_DATE('2012-11-12 18:03:27','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-12 18:03:27','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 12, 2012 6:03:29 PM COT
-- IDEMPIERE-457 Tab Editor (to ease positioning of fields)
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200112 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 12, 2012 6:03:53 PM COT
-- IDEMPIERE-457 Tab Editor (to ease positioning of fields)
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Visible Fields',200113,'D','fbf72d95-345c-4506-a8fc-cb275c885cdd','VisibleFields','Y',TO_DATE('2012-11-12 18:03:53','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-12 18:03:53','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 12, 2012 6:03:53 PM COT
-- IDEMPIERE-457 Tab Editor (to ease positioning of fields)
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200113 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

-- Nov 12, 2012 6:04:15 PM COT
-- IDEMPIERE-457 Tab Editor (to ease positioning of fields)
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,EntityType,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,AD_Client_ID,AD_Org_ID,Created) VALUES ('I','Non Visible Fields',200114,'D','1e160a14-8b90-45c1-8a12-db2f9531add2','NonVisibleFields','Y',TO_DATE('2012-11-12 18:04:14','YYYY-MM-DD HH24:MI:SS'),100,100,0,0,TO_DATE('2012-11-12 18:04:14','YYYY-MM-DD HH24:MI:SS'))
;

-- Nov 12, 2012 6:04:15 PM COT
-- IDEMPIERE-457 Tab Editor (to ease positioning of fields)
INSERT INTO AD_Message_Trl (AD_Language,AD_Message_ID, MsgText,MsgTip, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Message_Trl_UU ) SELECT l.AD_Language,t.AD_Message_ID, t.MsgText,t.MsgTip, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Message t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Message_ID=200114 AND NOT EXISTS (SELECT * FROM AD_Message_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Message_ID=t.AD_Message_ID)
;

SELECT register_migration_script('201211121807_IDEMPIERE-457.sql') FROM dual
;

