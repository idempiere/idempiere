-- IDEMPIERE-446 Implement Restrictions on Toolbar to the report viewer
-- Oct 11, 2012 15:52:27 AM COT
INSERT INTO AD_Column(Version,AD_Table_ID,AD_Column_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsEncrypted,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Name,IsAllowCopy,CreatedBy,Updated,AD_Org_ID,IsActive,Created,UpdatedBy,AD_Client_ID,SeqNoSelection) VALUES (
0,200004,200603,'D','N','N','N',0,'N',10,'N',19,'N','N',117,'N','Y','06a8ccfc-aa6f-443b-a2f3-665f5584944c','N','Y','N','AD_Process_ID','Process or Report','Process','Y',0,TO_TIMESTAMP('2012-10-11 15:52:27','YYYY-MM-DD HH24:MI:SS'),0,'Y',TO_TIMESTAMP('2012-10-11 15:52:27','YYYY-MM-DD HH24:MI:SS'),0,0,0)
;

-- Oct 11, 2012 15:52:27 AM COT
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200603 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 11, 2012 16:01:18 AM COT
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_FieldGroup_ID,EntityType,Description,Name,IsDisplayed,IsFieldOnly,AD_Field_UU,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines) VALUES (
0,'N',200003,10,'N','N',200603,60,'Y',200615,'N',NULL,'U','Process or Report','Process','Y','N','67334cfb-5b6b-42f4-97ce-faf7e524c97c',0,0,TO_TIMESTAMP('2012-10-11 16:01:18','YYYY-MM-DD HH24:MI:SS'),0,0,TO_TIMESTAMP('2012-10-11 16:37:52','YYYY-MM-DD HH24:MI:SS'),'Y','Y',60,4,2,1)
;

-- Oct 11, 2012 16:01:18 AM COT
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200615 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 16, 2012 12:03:47 PM COT
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive,Created) VALUES ('Report - Customize','Customize','org.idempiere.ui.report','N',0,0,0,0,0,200059,TO_TIMESTAMP('2012-10-16 12:03:45','YYYY-MM-DD HH24:MI:SS'),0,'384b207a-387e-4b56-91b5-be73c3f35421','Y',TO_TIMESTAMP('2012-10-16 12:03:45','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 16, 2012 12:04:51 PM COT
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive,Created) VALUES ('Report - Find','Find','org.idempiere.ui.report','N',0,0,0,0,0,200060,TO_TIMESTAMP('2012-10-16 12:04:50','YYYY-MM-DD HH24:MI:SS'),0,'3d4d2b55-2960-40d6-b2cd-58a0013887b4','Y',TO_TIMESTAMP('2012-10-16 12:04:50','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 16, 2012 12:07:20 PM COT
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive,Created) VALUES ('Report - SendMail','SendMail','org.idempiere.ui.report','N',0,0,0,0,0,200061,TO_TIMESTAMP('2012-10-16 12:07:19','YYYY-MM-DD HH24:MI:SS'),0,'6db3b34f-b4af-4935-a9a7-2ec274d3c707','Y',TO_TIMESTAMP('2012-10-16 12:07:19','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 16, 2012 12:08:21 PM COT
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive,Created) VALUES ('Report - Archive','Archive','org.idempiere.ui.report','N',0,0,0,0,0,200062,TO_TIMESTAMP('2012-10-16 12:08:20','YYYY-MM-DD HH24:MI:SS'),0,'d950ba4c-c5eb-4c1f-87cb-4407d5ab9df6','Y',TO_TIMESTAMP('2012-10-16 12:08:20','YYYY-MM-DD HH24:MI:SS'))
;


-- Oct 16, 2012 12:10:01 PM COT
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive,Created) VALUES ('Report - Export','Export','org.idempiere.ui.report','N',0,0,0,0,0,200063,TO_TIMESTAMP('2012-10-16 12:10:00','YYYY-MM-DD HH24:MI:SS'),0,'f616622e-88b4-4b93-83a7-252cd2e03b3d','Y',TO_TIMESTAMP('2012-10-16 12:10:00','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 16, 2012 12:11:05 PM COT
INSERT INTO AD_ToolBarButton (Name,ComponentName,Classname,IsCustomization,KeyStroke_KeyCode,KeyStroke_Modifiers,AD_Client_ID,AD_Org_ID,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,AD_ToolBarButton_UU,IsActive,Created) VALUES ('Report - Refresh','Refresh','org.idempiere.ui.report','N',0,0,0,0,0,200064,TO_TIMESTAMP('2012-10-16 12:11:04','YYYY-MM-DD HH24:MI:SS'),0,'11ef368d-f1b6-43d2-9cc7-046520c3645d','Y',TO_TIMESTAMP('2012-10-16 12:11:04','YYYY-MM-DD HH24:MI:SS'))
;

-- Oct 17, 2012 3:49:00 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200000
;

-- Oct 17, 2012 3:49:07 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200001
;

-- Oct 17, 2012 3:49:13 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200002
;

-- Oct 17, 2012 3:49:17 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200003
;

-- Oct 17, 2012 3:49:21 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200004
;

-- Oct 17, 2012 3:49:51 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200005
;

-- Oct 17, 2012 3:49:55 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200006
;

-- Oct 17, 2012 3:50:00 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200007
;

-- Oct 17, 2012 3:50:04 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200008
;

-- Oct 17, 2012 3:50:08 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200009
;

-- Oct 17, 2012 3:50:12 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200010
;

-- Oct 17, 2012 3:50:16 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200011
;

-- Oct 17, 2012 3:50:20 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200012
;

-- Oct 17, 2012 3:50:24 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200013
;

-- Oct 17, 2012 3:50:28 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200014
;

-- Oct 17, 2012 3:50:33 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200015
;

-- Oct 17, 2012 3:50:36 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200016
;

-- Oct 17, 2012 3:50:40 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200017
;

-- Oct 17, 2012 3:50:44 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200018
;

-- Oct 17, 2012 3:50:47 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200019
;

-- Oct 17, 2012 3:50:51 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200020
;

-- Oct 17, 2012 3:50:55 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200021
;

-- Oct 17, 2012 3:51:00 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200022
;

-- Oct 17, 2012 3:51:04 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200023
;

-- Oct 17, 2012 3:51:07 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200024
;

-- Oct 17, 2012 3:51:11 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200025
;

-- Oct 17, 2012 3:51:15 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200026
;

-- Oct 17, 2012 3:51:19 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200027
;

-- Oct 17, 2012 3:51:23 PM COT
DELETE FROM AD_ToolBarButton WHERE AD_ToolBarButton_ID=200028
;

-- Oct 17, 2012 3:52:04 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Ignore', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:52:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200029
;

-- Oct 17, 2012 3:52:15 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Help', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:52:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200030
;

-- Oct 17, 2012 3:52:34 PM COT
UPDATE AD_ToolBarButton SET Name='Window - New', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:52:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200031
;

-- Oct 17, 2012 3:52:46 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Copy', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:52:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200032
;

-- Oct 17, 2012 3:52:57 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Delete', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:52:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200033
;

-- Oct 17, 2012 3:53:06 PM COT
UPDATE AD_ToolBarButton SET Name='Window - DeleteSelection', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:53:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200034
;

-- Oct 17, 2012 3:53:15 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Save', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:53:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200035
;

-- Oct 17, 2012 3:53:35 PM COT
UPDATE AD_ToolBarButton SET Name='Window - SaveCreate', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:53:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200036
;

-- Oct 17, 2012 3:53:45 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Refresh', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:53:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200037
;

-- Oct 17, 2012 3:53:53 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Find', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:53:53','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200038
;

-- Oct 17, 2012 3:54:03 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Attachment', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:54:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200039
;

-- Oct 17, 2012 3:54:12 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Chat', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:54:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200040
;

-- Oct 17, 2012 3:54:30 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Multi', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:54:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200041
;

-- Oct 17, 2012 3:54:54 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Parent', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:54:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200043
;

-- Oct 17, 2012 3:55:03 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Detail', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:55:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200044
;

-- Oct 17, 2012 3:55:10 PM COT
UPDATE AD_ToolBarButton SET Name='Window - First', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:55:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200045
;

-- Oct 17, 2012 3:55:21 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Previous', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:55:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200046
;

-- Oct 17, 2012 3:55:28 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Next', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:55:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200047
;

-- Oct 17, 2012 3:55:36 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Last', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:55:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200048
;

-- Oct 17, 2012 3:55:46 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Report', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:55:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200049
;

-- Oct 17, 2012 3:55:55 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Archive', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:55:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200050
;

-- Oct 17, 2012 3:56:05 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Print', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:56:05','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200051
;

-- Oct 17, 2012 3:56:15 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Lock', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:56:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200052
;

-- Oct 17, 2012 3:56:22 PM COT
UPDATE AD_ToolBarButton SET Name='Window - ZoomAcross', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:56:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200053
;

-- Oct 17, 2012 3:56:30 PM COT
UPDATE AD_ToolBarButton SET Name='Window - WorkFlow', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:56:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200054
;

-- Oct 17, 2012 3:56:55 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Request', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:56:55','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200055
;

-- Oct 17, 2012 3:57:04 PM COT
UPDATE AD_ToolBarButton SET Name='Window - InfoProduct', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:57:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200056
;

-- Oct 17, 2012 3:57:10 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Export', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:57:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200057
;

-- Oct 17, 2012 3:57:18 PM COT
UPDATE AD_ToolBarButton SET Name='Window - Customize', Classname='org.idempiere.ui.window',Updated=TO_TIMESTAMP('2012-10-17 15:57:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ToolBarButton_ID=200058
;

-- Oct 23, 2012 6:34:54 PM COT
ALTER TABLE AD_ToolBarButtonRestrict ADD COLUMN AD_Process_ID NUMERIC(10) DEFAULT NULL 
;

SELECT register_migration_script('932_IDEMPIERE-446.sql') FROM dual
;
