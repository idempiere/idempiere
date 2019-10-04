-- IDEMPIERE-4060 Implement change scheduler state at scheduler window
-- Oct 4, 2019, 2:16:47 PM MYT
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,ActionClassName,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_ToolBarButton_UU,"action",DisplayLogic,SeqNo,IsAdvancedButton,IsAddSeparator,EntityType) VALUES (0,0,TO_TIMESTAMP('2019-10-04 14:16:44','YYYY-MM-DD HH24:MI:SS'),100,'SchedulerState','Y',200099,'Change Scheduler State',TO_TIMESTAMP('2019-10-04 14:16:44','YYYY-MM-DD HH24:MI:SS'),100,'Y','org.adempiere.webui.scheduler.ChangeStateAction',0,0,'e4011f77-6b09-4644-9781-746b74818962','W','@_WinInfo_AD_Window_ID@=305&@AD_Scheduler_ID@>0',0,'N','N','D')
;

-- Oct 4, 2019, 2:17:56 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Change Scheduler State',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:17:55','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:17:55','YYYY-MM-DD HH24:MI:SS'),100,200564,'org.adempiere.webui.scheduler.ChangeStateAction.label','D','d17e970c-d75e-4577-8862-90c41673c305')
;

-- Oct 4, 2019, 2:18:44 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Not Schedule',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:18:44','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:18:44','YYYY-MM-DD HH24:MI:SS'),100,200565,'SchedulerNotSchedule','D','d71cb5f4-1d4c-4d37-8a9b-2720d36a6670')
;

-- Oct 4, 2019, 2:19:04 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Scheduler Started',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:19:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:19:03','YYYY-MM-DD HH24:MI:SS'),100,200566,'SchedulerStarted','D','5d4b14e5-8300-4885-8dcc-25c438274dd4')
;

-- Oct 4, 2019, 2:19:28 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Scheduler Stopped',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:19:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:19:27','YYYY-MM-DD HH24:MI:SS'),100,200567,'SchedulerStopped','D','6bf707ce-3ca7-4e99-9199-cb9dffee12dc')
;

-- Oct 4, 2019, 2:19:58 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to read current scheduler state',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:19:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:19:57','YYYY-MM-DD HH24:MI:SS'),100,200568,'CantReadCurrentSchedulerState','D','330bb791-8a1b-45d1-8e30-0da31ad7c4ed')
;

-- Oct 4, 2019, 2:21:34 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Add scheduler to server and start it?',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:21:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:21:34','YYYY-MM-DD HH24:MI:SS'),100,200569,'SchedulerAddAndStartPrompt','D','237fef1a-c876-4965-9abd-a64324452ea5')
;

-- Oct 4, 2019, 2:22:04 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Stop scheduler?',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:22:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:22:03','YYYY-MM-DD HH24:MI:SS'),100,200570,'SchedulerStopPrompt','D','3a0c3dbf-a78b-4110-900a-9d09b1e3026d')
;

-- Oct 4, 2019, 2:22:30 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Start scheduler?',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:22:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:22:29','YYYY-MM-DD HH24:MI:SS'),100,200571,'SchedulerStartPrompt','D','eb95b028-d5db-45e4-a911-6c690c3d0f58')
;

-- Oct 4, 2019, 2:23:07 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Scheduler added and started successfully',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:23:07','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:23:07','YYYY-MM-DD HH24:MI:SS'),100,200572,'SchedulerAddedAndStarted','D','1367e586-ac57-4216-9f98-daca4cb961bb')
;

-- Oct 4, 2019, 2:23:48 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to add and start scheduler. Error:',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:23:47','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:23:47','YYYY-MM-DD HH24:MI:SS'),100,200573,'SchedulerAddAndStartFail','D','898a96bf-5b1b-405a-8507-a69ac58e364e')
;

-- Oct 4, 2019, 2:30:12 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Scheduler stopped successfully',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:30:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:30:06','YYYY-MM-DD HH24:MI:SS'),100,200575,'SchedulerStoppedSuccess','D','d918dd12-9578-4160-9212-28af2114b5fe')
;

-- Oct 4, 2019, 2:30:48 PM MYT
UPDATE AD_Message SET Value='SchedulerStopSuccess',Updated=TO_TIMESTAMP('2019-10-04 14:30:48','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200575
;

-- Oct 4, 2019, 2:31:14 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to stop scheduler. Error:',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:31:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:31:13','YYYY-MM-DD HH24:MI:SS'),100,200576,'SchedulerStopFail','D','40ff365f-9a0f-4de6-849f-c6527d844e37')
;

-- Oct 4, 2019, 2:31:38 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Scheduler started successfully',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:31:38','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:31:38','YYYY-MM-DD HH24:MI:SS'),100,200577,'SchedulerStartSuccess','D','fc356061-f311-464b-9962-6a7dbac028dd')
;

-- Oct 4, 2019, 2:32:00 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('E','Failed to start scheduler. Error:',0,0,'Y',TO_TIMESTAMP('2019-10-04 14:32:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 14:32:00','YYYY-MM-DD HH24:MI:SS'),100,200578,'SchedulerStartFail','D','d79f3d08-2d00-4281-b01c-00cdc80f085c')
;

-- IDEMPIERE-4060 Implement change scheduler state at scheduler window
-- Oct 4, 2019, 2:46:01 PM MYT
UPDATE AD_Message SET Value='SchedulerAddAndStartSuccess',Updated=TO_TIMESTAMP('2019-10-04 14:46:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Message_ID=200572
;

-- IDEMPIERE-4060 Implement change scheduler state at scheduler window
-- Oct 4, 2019, 4:43:05 PM MYT
INSERT INTO AD_Message (MsgType,MsgText,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Message_ID,Value,EntityType,AD_Message_UU) VALUES ('I','Change scheduler state',0,0,'Y',TO_TIMESTAMP('2019-10-04 16:43:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-10-04 16:43:04','YYYY-MM-DD HH24:MI:SS'),100,200579,'org.adempiere.webui.scheduler.ChangeStateAction.tooltip','D','241b6ad0-f3ad-4541-9ab9-8c6a163e7f0d')
;

SELECT register_migration_script('201910041600_IDEMPIERE-4060.sql') FROM dual
;
