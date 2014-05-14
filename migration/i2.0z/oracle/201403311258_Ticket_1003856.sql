SET SQLBLANKLINES ON
SET DEFINE OFF

-- Mar 28, 2014 6:34:26 PM SGT
-- Ticket #1003856: Run report as a background job
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsRunAsJob',202694,'Run as Job','Run as Job','c52c9e5a-da3e-401d-8f52-e58f557a56f2',TO_DATE('2014-03-28 18:34:24','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-28 18:34:24','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Mar 28, 2014 6:35:05 PM SGT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,EntityType) VALUES (0,'N',0,211199,'Y','N','N',0,'N',1,'N','N','N','Y','e67be641-2f1b-4c6b-9c8a-a6788940a686','Y','IsRunAsJob','N','Run as Job','Y',TO_DATE('2014-03-28 18:35:03','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-03-28 18:35:03','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'N','N','N',202694,20,282,'D')
;

-- Mar 28, 2014 6:38:03 PM SGT
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Name,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('IsJobProcessing',202695,'Job Processing','Job Processing','54265662-ebe2-4521-ba7e-8a9f9a96bcab',TO_DATE('2014-03-28 18:38:02','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-28 18:38:02','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Mar 28, 2014 6:38:22 PM SGT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,DefaultValue,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID,EntityType) VALUES (0,'N',0,211200,'Y','N','N',0,'N',1,'N','N','N','Y','922b7724-599a-49c8-a053-0f8f4b8e2156','Y','IsJobProcessing','N','Job Processing','Y',TO_DATE('2014-03-28 18:38:21','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-03-28 18:38:21','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'N','N','N',202695,20,282,'D')
;

-- Mar 28, 2014 6:38:42 PM SGT
INSERT INTO AD_Column (SeqNoSelection,IsSyncDatabase,Version,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,IsEncrypted,IsSecure,AD_Element_ID,AD_Reference_ID,AD_Reference_Value_ID,AD_Table_ID,EntityType) VALUES (0,'N',0,211201,'N','N','N',0,'N',2,'N','N','N','Y','5c07ac2d-8342-4e86-ae06-5109f872a16b','Y','NotificationType','Type of Notifications','Emails or Notification sent out for Request Updates, etc.','Notification Type','Y',TO_DATE('2014-03-28 18:38:41','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_DATE('2014-03-28 18:38:41','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'N','N',2755,17,200026,282,'D')
;

-- Mar 28, 2014 6:43:27 PM SGT
ALTER TABLE AD_PInstance ADD IsRunAsJob CHAR(1) DEFAULT 'N'
;

-- Mar 28, 2014 6:43:44 PM SGT
ALTER TABLE AD_PInstance ADD IsJobProcessing CHAR(1) DEFAULT 'N'
;

-- Mar 28, 2014 6:43:51 PM SGT
ALTER TABLE AD_PInstance ADD NotificationType VARCHAR2(2) DEFAULT NULL 
;

-- Mar 28, 2014 6:44:35 PM SGT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,AD_Client_ID,ColumnSpan,AD_Column_ID) VALUES ('N',663,36,'N','N',110,'Y',202844,'N','D','AD_PInstance_UU','3540b3cc-efe6-4509-bafc-a15c59c9d7f8','N','N',100,0,TO_DATE('2014-03-28 18:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-28 18:44:34','YYYY-MM-DD HH24:MI:SS'),'Y','N',0,2,60451)
;

-- Mar 28, 2014 6:44:36 PM SGT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID) VALUES ('N',663,1,'N','N',120,'Y',202845,'N','D','Run as Job','72ecc44d-a61b-44b9-a94a-14bd270dbf22','Y','N',100,0,TO_DATE('2014-03-28 18:44:35','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-28 18:44:35','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,211199)
;

-- Mar 28, 2014 6:44:37 PM SGT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,EntityType,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,XPosition,AD_Client_ID,ColumnSpan,AD_Column_ID) VALUES ('N',663,1,'N','N',130,'Y',202846,'N','D','Job Processing','96118891-6592-4f41-8ba0-05057e17d60e','Y','N',100,0,TO_DATE('2014-03-28 18:44:36','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-28 18:44:36','YYYY-MM-DD HH24:MI:SS'),'Y',2,0,2,211200)
;

-- Mar 28, 2014 6:44:38 PM SGT
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,EntityType,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,AD_Client_ID,ColumnSpan,AD_Column_ID) VALUES ('N',663,2,'N','N',140,'Y',202847,'N','Emails or Notification sent out for Request Updates, etc.','D','Type of Notifications','Notification Type','d76699c8-2abe-4f62-9e10-6e10fd5dba20','Y','N',100,0,TO_DATE('2014-03-28 18:44:37','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-28 18:44:37','YYYY-MM-DD HH24:MI:SS'),'Y',0,2,211201)
;

-- Mar 28, 2014 6:45:04 PM SGT
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=202844
;

-- Mar 28, 2014 6:45:04 PM SGT
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=202845
;

-- Mar 28, 2014 6:45:04 PM SGT
UPDATE AD_Field SET SeqNo=120,IsDisplayed='Y' WHERE AD_Field_ID=202847
;

-- Mar 28, 2014 6:45:11 PM SGT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=202845
;

-- Mar 28, 2014 6:45:11 PM SGT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y' WHERE AD_Field_ID=202847
;

-- Mar 28, 2014 6:45:11 PM SGT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y' WHERE AD_Field_ID=202846
;

-- Mar 28, 2014 6:46:01 PM SGT
INSERT INTO AD_FieldGroup (FieldGroupType,EntityType,IsCollapsedByDefault,Name,AD_FieldGroup_UU,AD_FieldGroup_ID,Created,CreatedBy,Updated,AD_Org_ID,UpdatedBy,IsActive,AD_Client_ID) VALUES ('C','D','N','Background Job','3be13370-89e4-42b3-8220-370ce497466a',200018,TO_DATE('2014-03-28 18:46:00','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-28 18:46:00','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',0)
;

-- Mar 28, 2014 6:46:18 PM SGT
UPDATE AD_Field SET AD_FieldGroup_ID=200018,Updated=TO_DATE('2014-03-28 18:46:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202847
;

-- Mar 28, 2014 6:46:22 PM SGT
UPDATE AD_Field SET AD_FieldGroup_ID=200018,Updated=TO_DATE('2014-03-28 18:46:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202845
;

-- Mar 28, 2014 6:46:28 PM SGT
UPDATE AD_Field SET AD_FieldGroup_ID=200018,Updated=TO_DATE('2014-03-28 18:46:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202846
;

-- Mar 28, 2014 6:46:44 PM SGT
UPDATE AD_Field SET IsSameLine='Y', XPosition=4,Updated=TO_DATE('2014-03-28 18:46:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202847
;

-- Mar 28, 2014 6:49:07 PM SGT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Updated,Created,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200047,'C','Y','feb88039-2fe8-47e5-a7be-c3a634674f0b',TO_DATE('2014-03-28 18:49:06','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-28 18:49:06','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'BACKGROUND_JOB_ALLOWED',0,'D')
;

-- Mar 28, 2014 6:49:31 PM SGT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Updated,Created,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200048,'C','N','f2fd6f9b-d8bb-4ade-9857-78ba68951776',TO_DATE('2014-03-28 18:49:30','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-28 18:49:30','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'BACKGROUND_JOB_BY_DEFAULT',0,'D')
;

-- Mar 28, 2014 6:50:36 PM SGT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Updated,Created,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200049,'S','20','0a24332e-a83a-465a-903f-6f3d7caea306',TO_DATE('2014-03-28 18:50:35','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-28 18:50:35','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'BACKGROUND_JOB_MAX_IN_SYSTEM',0,'D')
;

-- Mar 28, 2014 6:51:09 PM SGT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Updated,Created,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200050,'C','10','d2d149e8-e642-4691-8ed3-8a875ee9b1ed',TO_DATE('2014-03-28 18:51:08','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-28 18:51:08','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'BACKGROUND_JOB_MAX_PER_CLIENT',0,'D')
;

-- Mar 28, 2014 6:52:26 PM SGT
INSERT INTO AD_SysConfig (AD_SysConfig_ID,ConfigurationLevel,Value,AD_SysConfig_UU,Updated,Created,AD_Org_ID,CreatedBy,IsActive,UpdatedBy,Name,AD_Client_ID,EntityType) VALUES (200051,'C','10','b0697150-68d7-4cfe-b103-f626db07793a',TO_DATE('2014-03-28 18:52:25','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2014-03-28 18:52:25','YYYY-MM-DD HH24:MI:SS'),0,100,'Y',100,'BACKGROUND_JOB_MAX_PER_USER',0,'D')
;

-- Mar 28, 2014 6:53:28 PM SGT
UPDATE AD_SysConfig SET Value='5',Updated=TO_DATE('2014-03-28 18:53:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200051
;

-- Mar 28, 2014 6:54:11 PM SGT
UPDATE AD_SysConfig SET ConfigurationLevel='S',Updated=TO_DATE('2014-03-28 18:54:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200050
;

-- Mar 28, 2014 6:58:22 PM SGT
INSERT INTO PA_DashboardContent (Line,PA_DashboardContent_ID,ColumnNo,IsCollapsible,GoalDisplay,Description,Name,PA_DashboardContent_UU,IsShowInDashboard,AD_Org_ID,Created,CreatedBy,Updated,AD_Client_ID,UpdatedBy,IsActive,IsEmbedReportContent,IsCollapsedByDefault,AD_Role_ID,IsShowinLogin,ZulFilePath,AD_User_ID) VALUES (3.000000000000,200002,0,'Y','T','Running Jobs','Running Jobs','e3fb872e-ce14-4029-830b-2d21a556fc60','Y',0,TO_DATE('2014-03-28 18:58:20','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2014-03-28 18:58:20','YYYY-MM-DD HH24:MI:SS'),0,100,'Y','N','N',0,'Y','/zul/runningJobs.zul',0)
;

-- Mar 28, 2014 7:57:19 PM SGT
-- Ticket #1003856: Run report as a background job
UPDATE AD_Column SET AD_Reference_Value_ID=344,Updated=TO_DATE('2014-03-28 19:57:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=211201
;

-- Mar 28, 2014 7:58:52 PM SGT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,EntityType,AD_Client_ID,AD_Org_ID) VALUES ('E','Exceed maximum number of running jobs allowed per user',200263,'82593e5f-86c6-45c5-bc38-4d9d5b2c8609','BackgroundJobExceedMaxPerUser','Y',TO_DATE('2014-03-28 19:58:49','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-28 19:58:49','YYYY-MM-DD HH24:MI:SS'),'D',0,0)
;

-- Mar 28, 2014 7:59:12 PM SGT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,EntityType,AD_Client_ID,AD_Org_ID) VALUES ('E','Exceed maximum number of running jobs allowed per client',200264,'fcebfad5-8283-498e-a835-b42bf0a0219a','BackgroundJobExceedMaxPerClient','Y',TO_DATE('2014-03-28 19:59:11','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-28 19:59:11','YYYY-MM-DD HH24:MI:SS'),'D',0,0)
;

-- Mar 28, 2014 7:59:51 PM SGT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,EntityType,AD_Client_ID,AD_Org_ID) VALUES ('E','Exceed maximum number of running jobs allowed in the system',200265,'405ea4c2-5a19-42fa-a5ff-f22601453f7f','BackgroundJobExceedMaxInSystem','Y',TO_DATE('2014-03-28 19:59:50','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-28 19:59:50','YYYY-MM-DD HH24:MI:SS'),'D',0,0)
;

-- Mar 28, 2014 8:00:19 PM SGT
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,EntityType,AD_Client_ID,AD_Org_ID) VALUES ('I','The process has been scheduled as job. The status of the process will be sent as notification to owner of the process.',200266,'dc68fd3b-0ce8-416c-a286-37f192a90f7d','BackgroundJobScheduled','Y',TO_DATE('2014-03-28 20:00:18','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-28 20:00:18','YYYY-MM-DD HH24:MI:SS'),'D',0,0)
;

-- Mar 28, 2014 9:03:01 PM SGT
-- Ticket #1003856: Run report as a background job
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Value,IsActive,Updated,CreatedBy,UpdatedBy,Created,EntityType,AD_Client_ID,AD_Org_ID) VALUES ('I','Background Job',200267,'530545f2-f32c-4072-8bd1-d9ca65f31f65','BackgroundJob','Y',TO_DATE('2014-03-28 21:02:59','YYYY-MM-DD HH24:MI:SS'),100,100,TO_DATE('2014-03-28 21:02:59','YYYY-MM-DD HH24:MI:SS'),'D',0,0)
;

-- Mar 31, 2014 5:54:16 PM SGT
-- Ticket #1003856: Run report as a background job
DELETE  FROM  AD_Field_Trl WHERE AD_Field_ID=202846
;

-- Mar 31, 2014 5:54:16 PM SGT
DELETE FROM AD_Field WHERE AD_Field_ID=202846
;

-- Mar 31, 2014 5:54:49 PM SGT
DELETE  FROM  AD_Column_Trl WHERE AD_Column_ID=211200
;

-- Mar 31, 2014 5:54:49 PM SGT
DELETE FROM AD_Column WHERE AD_Column_ID=211200
;

-- Mar 31, 2014 5:54:56 PM SGT
DELETE  FROM  AD_Element_Trl WHERE AD_Element_ID=202695
;

-- Mar 31, 2014 5:54:56 PM SGT
DELETE FROM AD_Element WHERE AD_Element_ID=202695
;

ALTER TABLE AD_PInstance DROP COLUMN IsJobProcessing
;

SELECT register_migration_script('201403311258_Ticket_1003856.sql') FROM dual
;