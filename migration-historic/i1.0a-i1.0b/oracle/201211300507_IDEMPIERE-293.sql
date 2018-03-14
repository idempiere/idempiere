-- Nov 28, 2012 3:45:10 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process (CopyFromProcess,Created,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,Value,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',TO_DATE('2012-11-28 15:45:05','YYYY-MM-DD HH24:MI:SS'),200021,'N','N','1b4a0890-2e4b-4e20-be55-d0248ec4e4c6','4','N','N',0,0,'Y','U','org.adempiere.webui.process.KillCurrentSession','Kill Current Session','Kill Current Session',0,0,TO_DATE('2012-11-28 15:45:05','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Nov 28, 2012 3:45:11 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200021 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 28, 2012 3:47:21 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Element (ColumnName,AD_Element_ID,EntityType,Name,PrintName,AD_Element_UU,AD_Client_ID,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive) VALUES ('TimeOutInSeconds',200256,'U','TimeOutInSeconds','Timeout In Seconds','3a2c3c58-cf06-4624-bd31-332957521736',0,TO_DATE('2012-11-28 15:47:20','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2012-11-28 15:47:20','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y')
;

-- Nov 28, 2012 3:47:21 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Element_Trl (AD_Language,AD_Element_ID, Help,PO_Description,PO_Help,Description,Name,PrintName,PO_Name,PO_PrintName, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Element_Trl_UU ) SELECT l.AD_Language,t.AD_Element_ID, t.Help,t.PO_Description,t.PO_Help,t.Description,t.Name,t.PrintName,t.PO_Name,t.PO_PrintName, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Element t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Element_ID=200256 AND NOT EXISTS (SELECT * FROM AD_Element_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Element_ID=t.AD_Element_ID)
;

-- Nov 28, 2012 3:48:48 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',200256,200044,'a5bc974e-d6b6-403e-8102-82e53950a14c',200021,11,'Y','U','TimeOutInSeconds','TimeOutInSeconds',4,'Y',10,'Y',100,TO_DATE('2012-11-28 15:48:47','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-28 15:48:47','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Nov 28, 2012 3:48:48 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200044 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Nov 28, 2012 3:50:54 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_ToolBarButton (Action,AD_Tab_ID,AD_Process_ID,SeqNo,Name,ComponentName,IsCustomization,AD_Client_ID,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive) VALUES ('W',200025,200021,10,'Kill Current Session','KillCurrentSession','N',0,0,TO_DATE('2012-11-28 15:50:53','YYYY-MM-DD HH24:MI:SS'),100,200073,TO_DATE('2012-11-28 15:50:53','YYYY-MM-DD HH24:MI:SS'),100,'f123c14c-0aa7-4ee9-87ed-3c4ef4ccc961','Y')
;

-- Nov 28, 2012 3:53:26 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process (CopyFromProcess,Created,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,EntityType,Classname,Name,Value,AD_Org_ID,AD_Client_ID,Updated,UpdatedBy,IsActive,CreatedBy) VALUES ('N',TO_DATE('2012-11-28 15:53:25','YYYY-MM-DD HH24:MI:SS'),200022,'N','N','06a44cb0-5782-475b-aeab-63429829c708','4','N','N',0,0,'Y','U','org.adempiere.webui.process.KillAllSession','Kill All Session','Kill All Session',0,0,TO_DATE('2012-11-28 15:53:25','YYYY-MM-DD HH24:MI:SS'),100,'Y',100)
;

-- Nov 28, 2012 3:53:26 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process_Trl (AD_Language,AD_Process_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Trl_UU ) SELECT l.AD_Language,t.AD_Process_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_ID=200022 AND NOT EXISTS (SELECT * FROM AD_Process_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_ID=t.AD_Process_ID)
;

-- Nov 28, 2012 3:55:32 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process_Para (IsRange,AD_Element_ID,AD_Process_Para_ID,AD_Process_Para_UU,AD_Process_ID,AD_Reference_ID,IsMandatory,EntityType,Name,ColumnName,FieldLength,IsCentrallyMaintained,SeqNo,IsActive,UpdatedBy,Updated,CreatedBy,Created,AD_Org_ID,AD_Client_ID,IsEncrypted) VALUES ('N',200256,200045,'c9f241c3-9085-4f3b-a071-e49bdc14541f',200022,11,'N','U','TimeOutInSeconds','TimeOutInSeconds',4,'Y',10,'Y',100,TO_DATE('2012-11-28 15:55:31','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2012-11-28 15:55:31','YYYY-MM-DD HH24:MI:SS'),0,0,'N')
;

-- Nov 28, 2012 3:55:32 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_Process_Para_Trl (AD_Language,AD_Process_Para_ID, Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Process_Para_Trl_UU ) SELECT l.AD_Language,t.AD_Process_Para_ID, t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Process_Para t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Process_Para_ID=200045 AND NOT EXISTS (SELECT * FROM AD_Process_Para_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Process_Para_ID=t.AD_Process_Para_ID)
;

-- Nov 28, 2012 3:57:20 PM GMT+05:30
-- IDEMPIERE-293 Adding ability to kill session from active session winodw
INSERT INTO AD_ToolBarButton (Action,AD_Tab_ID,AD_Process_ID,SeqNo,Name,ComponentName,IsCustomization,AD_Client_ID,AD_Org_ID,Created,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive) VALUES ('W',200025,200022,20,'Kill All Session','KillAllSession','N',0,0,TO_DATE('2012-11-28 15:57:19','YYYY-MM-DD HH24:MI:SS'),100,200074,TO_DATE('2012-11-28 15:57:19','YYYY-MM-DD HH24:MI:SS'),100,'b56e98d9-bbfd-478e-bc11-c3e9cdb9637e','Y')
;


SELECT register_migration_script('201211300507_IDEMPIERE-293.sql') FROM dual
;
