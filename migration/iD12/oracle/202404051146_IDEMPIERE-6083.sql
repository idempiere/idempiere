-- IDEMPIERE-6083 Add Customize Grid View form to Window Customization
SELECT register_migration_script('202404051146_IDEMPIERE-6083.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Apr 5, 2024, 11:46:30 AM MYT
INSERT INTO AD_Form (AD_Form_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Classname,AccessLevel,EntityType,IsBetaFunctionality,AD_Form_UU) VALUES (200019,0,0,'Y',TO_TIMESTAMP('2024-04-05 11:46:19','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-05 11:46:19','YYYY-MM-DD HH24:MI:SS'),100,'Customize Grid View of Tabs in Window Customization','Form to customize the grid view of tabs in window customization','org.adempiere.webui.window.WCustomizeUserDefTabGridView','6','D','N','b6038f33-8ec4-4513-b873-97465e4e2937')
;

-- Apr 5, 2024, 11:51:17 AM MYT
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,IsReport,Value,IsDirectPrint,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,AD_Form_ID,CopyFromProcess,AD_Process_UU,AllowMultipleExecution) VALUES (200162,0,0,'Y',TO_TIMESTAMP('2024-04-05 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2024-04-05 11:51:11','YYYY-MM-DD HH24:MI:SS'),100,'Customize Grid View of Tabs in Window Customization','N','CustomizeGridViewWindowCustomization','N','6','D',0,0,'N','Y',200019,'N','2f37ad7c-9077-4e58-8fbc-52726be2a85a','P')
;

-- Apr 5, 2024, 11:52:28 AM MYT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,Action,AD_Tab_ID,AD_Process_ID,DisplayLogic,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2024-04-05 11:52:26','YYYY-MM-DD HH24:MI:SS'),100,'CustomizeGridView','Y',200134,'Customize Grid View',TO_TIMESTAMP('2024-04-05 11:52:26','YYYY-MM-DD HH24:MI:SS'),100,'N','39e1ede5-4953-4e73-8e74-d9ceb9c4298e','W',394,200162,'@IsActive@=Y',20,'D')
;

-- Apr 5, 2024, 11:54:20 AM MYT
UPDATE AD_Process SET Name='Customize Grid View',Updated=TO_TIMESTAMP('2024-04-05 11:54:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Process_ID=200162
;

-- Apr 5, 2024, 1:33:31 PM MYT
UPDATE AD_Form SET Name='Customize Grid View',Updated=TO_TIMESTAMP('2024-04-05 13:33:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Form_ID=200019
;
