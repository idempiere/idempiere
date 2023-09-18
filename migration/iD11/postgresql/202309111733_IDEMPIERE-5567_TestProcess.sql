-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202309111733_IDEMPIERE-5567_TestProcess.sql') FROM dual;

-- Sep 11, 2023, 5:33:43 PM CEST
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200155,0,0,'Y',TO_TIMESTAMP('2023-09-11 17:33:43','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 17:33:43','YYYY-MM-DD HH24:MI:SS'),100,'Switch Active Flag on this Test UU and its Details','N','TestUUChangeActive','N','org.idempiere.process.TestUUChangeActive','7','D',0,0,'N','Y','N','eb8d0521-c103-433d-9cad-071968a4d923','P')
;

-- Sep 11, 2023, 5:34:00 PM CEST
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2023-09-11 17:34:00','YYYY-MM-DD HH24:MI:SS'),100,'TestUUChangeActive','Y',200132,'TestUUChangeActive',TO_TIMESTAMP('2023-09-11 17:34:00','YYYY-MM-DD HH24:MI:SS'),100,'N','89679ad7-dead-4697-b7be-5f1080071fd3','W',200348,200155,10,'D')
;

-- Sep 11, 2023, 6:03:39 PM CEST
UPDATE AD_Process SET ShowHelp='S',Updated=TO_TIMESTAMP('2023-09-11 18:03:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200155
;

