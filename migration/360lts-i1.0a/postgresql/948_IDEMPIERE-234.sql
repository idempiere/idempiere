-- Oct 23, 2012 5:37:00 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-23 17:37:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200068
;

-- Oct 23, 2012 5:42:57 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Window SET Description='Maintain toolbar button access rule', Name='Role Toolbar Button Access',Updated=TO_TIMESTAMP('2012-10-23 17:42:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200001
;

-- Oct 23, 2012 5:42:57 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Window_Trl SET IsTranslated='N' WHERE AD_Window_ID=200001
;

-- Oct 23, 2012 5:42:57 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Menu SET IsActive='Y', Name='Role Toolbar Button Access', Description='Maintain toolbar button access rule',Updated=TO_TIMESTAMP('2012-10-23 17:42:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200001
;

-- Oct 23, 2012 5:42:57 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Menu_Trl SET IsTranslated='N' WHERE AD_Menu_ID=200001
;

-- Oct 23, 2012 5:44:11 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Table SET Description='Toolbar button access rule', Name='Toolbar Button Access',Updated=TO_TIMESTAMP('2012-10-23 17:44:11','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200004
;

-- Oct 23, 2012 5:44:11 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Table_Trl SET IsTranslated='N' WHERE AD_Table_ID=200004
;

-- Oct 23, 2012 5:45:05 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column (Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,CreatedBy,Updated,AD_Org_ID,IsActive,IsAutocomplete,IsAllowLogging,Created,IsUpdateable,AD_Column_UU,IsAlwaysUpdateable,Help,IsAllowCopy,UpdatedBy,DefaultValue,IsEncrypted,ColumnName,Description,Name,AD_Client_ID,AD_Column_ID,SeqNoSelection,IsToolbarButton) VALUES (1,200004,'D','Y','N','N',0,'N',1,'N',20,'N','N',2079,100,TO_TIMESTAMP('2012-10-23 17:45:04','YYYY-MM-DD HH24:MI:SS'),0,'Y','N','Y',TO_TIMESTAMP('2012-10-23 17:45:04','YYYY-MM-DD HH24:MI:SS'),'N','28bc855d-3815-43ec-b3f6-d053ce1368a5','N','If selected (excluded), the role cannot access the data specified.  If not selected (included), the role can ONLY access the data specified. Exclude items represent a negative list (i.e. you don''t have access to the listed items). Include items represent a positive list (i.e. you only have access to the listed items).
<br>You would usually  not mix Exclude and Include. If you have one include rule in your list, you would only have access to that item anyway.','Y',100,'Y','N','IsExclude','Exclude access to the data - if not selected Include access to the data','Exclude',0,200811,0,'N')
;

-- Oct 23, 2012 5:45:06 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200811 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 23, 2012 5:46:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,Help,CreatedBy,Updated,EntityType,IsDisplayed,IsFieldOnly,IsDisplayedGrid,SeqNoGrid,AD_Field_UU,DisplayLength,Description,Name,IsActive,XPosition,ColumnSpan,NumLines) VALUES (0,'N',200003,'N','N',200811,80,'Y',200730,'Y',100,0,TO_TIMESTAMP('2012-10-23 17:46:35','YYYY-MM-DD HH24:MI:SS'),0,'If selected (excluded), the role cannot access the data specified.  If not selected (included), the role can ONLY access the data specified. Exclude items represent a negative list (i.e. you don''t have access to the listed items). Include items represent a positive list (i.e. you only have access to the listed items).
<br>You would usually  not mix Exclude and Include. If you have one include rule in your list, you would only have access to that item anyway.',100,TO_TIMESTAMP('2012-10-23 17:46:35','YYYY-MM-DD HH24:MI:SS'),'D','Y','N','Y',80,'94cefb8d-5e6f-453c-b133-7ab99e7928e4',0,'Exclude access to the data - if not selected Include access to the data','Exclude','Y',2,2,1)
;

-- Oct 23, 2012 5:46:37 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200730 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 23, 2012 5:46:50 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
ALTER TABLE AD_ToolBarButtonRestrict ADD COLUMN IsExclude CHAR(1) DEFAULT 'Y' CHECK (IsExclude IN ('Y','N')) NOT NULL
;

-- Oct 23, 2012 5:50:47 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET MandatoryLogic='@#AD_Client_ID@>0',Updated=TO_TIMESTAMP('2012-10-23 17:50:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200108
;

-- Oct 23, 2012 6:02:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Tab SET Name='Toolbar Button Access',Updated=TO_TIMESTAMP('2012-10-23 18:02:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200003
;

-- Oct 23, 2012 6:03:14 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2012-10-23 18:03:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200108
;

-- Oct 23, 2012 6:03:20 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET IsUpdateable='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-10-23 18:03:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200105
;

-- Oct 23, 2012 6:03:31 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET IsUpdateable='Y', IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-10-23 18:03:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200111
;

-- Oct 23, 2012 6:14:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Table SET Name='Toolbar Button',Updated=TO_TIMESTAMP('2012-10-23 18:14:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Table_ID=200003
;

-- Oct 23, 2012 6:14:21 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Window SET Name='Toolbar Button',Updated=TO_TIMESTAMP('2012-10-23 18:14:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Window_ID=200000
;

-- Oct 23, 2012 6:14:21 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Menu SET IsActive='Y', Name='Toolbar Button', Description=NULL,Updated=TO_TIMESTAMP('2012-10-23 18:14:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Menu_ID=200000
;

-- Oct 23, 2012 6:19:16 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Val_Rule SET Code='AD_Ref_List.Value IN (''W'',''R'')', Name='AD_ToolBarButton Action - Window/Report',Updated=TO_TIMESTAMP('2012-10-23 18:19:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200002
;

-- Oct 23, 2012 6:19:26 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET IsMandatory='Y',Updated=TO_TIMESTAMP('2012-10-23 18:19:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200105
;

-- Oct 23, 2012 6:19:35 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO t_alter_column values('ad_toolbarbuttonrestrict','"action"','CHAR(1)',null,null)
;

-- Oct 23, 2012 6:19:35 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO t_alter_column values('ad_toolbarbuttonrestrict','"action"',null,'NOT NULL',null)
;

-- Oct 23, 2012 6:24:34 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column (Version,AD_Table_ID,EntityType,AD_Reference_Value_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsSyncDatabase,IsKey,AD_Element_ID,CreatedBy,Updated,AD_Org_ID,IsActive,IsAutocomplete,IsAllowLogging,Created,IsUpdateable,AD_Column_UU,IsAlwaysUpdateable,Help,IsAllowCopy,UpdatedBy,DefaultValue,AD_Val_Rule_ID,IsEncrypted,ColumnName,Description,Name,AD_Client_ID,AD_Column_ID,SeqNoSelection,IsToolbarButton) VALUES (1,200003,'D',104,'Y','N','N',0,'N',1,'N',17,'N','N',152,100,TO_TIMESTAMP('2012-10-23 18:24:33','YYYY-MM-DD HH24:MI:SS'),0,'Y','N','Y',TO_TIMESTAMP('2012-10-23 18:24:33','YYYY-MM-DD HH24:MI:SS'),'Y','bd152532-f402-4590-b889-02b79fee52b1','N','The Action field is a drop down list box which indicates the Action to be performed for this Item.','Y',100,'W',200002,'N','Action','Indicates the Action to be performed','Action',0,200812,0,'N')
;

-- Oct 23, 2012 6:24:34 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200812 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 23, 2012 6:24:46 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
ALTER TABLE AD_ToolBarButton ADD COLUMN "action" CHAR(1) DEFAULT 'W' NOT NULL
;

-- Oct 23, 2012 6:27:22 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Val_Rule (Code,Updated,UpdatedBy,Created,EntityType,Name,Type,CreatedBy,AD_Val_Rule_UU,AD_Client_ID,IsActive,AD_Org_ID,AD_Val_Rule_ID) VALUES ('(AD_ToolbarButton.Action=''@Action@'') OR (AD_ToolbarButton.Action||''@Action@''=''RW'' )',TO_TIMESTAMP('2012-10-23 18:27:20','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-10-23 18:27:20','YYYY-MM-DD HH24:MI:SS'),'D','AD_ToolbarButton of Action','S',100,'a6553b61-35ba-4bae-add1-6eeb6851d051',0,'Y',0,200011)
;

-- Oct 23, 2012 6:27:37 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET AD_Val_Rule_ID=200011, IsToolbarButton='N',Updated=TO_TIMESTAMP('2012-10-23 18:27:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200104
;

-- Oct 23, 2012 6:28:44 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,UpdatedBy,AD_Org_ID,Created,AD_Client_ID,Help,CreatedBy,Updated,EntityType,IsDisplayed,IsFieldOnly,IsDisplayedGrid,SeqNoGrid,AD_Field_UU,DisplayLength,Description,Name,IsActive,XPosition,ColumnSpan,NumLines) VALUES (0,'N',200002,'N','N',200812,120,'Y',200731,'N',100,0,TO_TIMESTAMP('2012-10-23 18:28:43','YYYY-MM-DD HH24:MI:SS'),0,'The Action field is a drop down list box which indicates the Action to be performed for this Item.',100,TO_TIMESTAMP('2012-10-23 18:28:43','YYYY-MM-DD HH24:MI:SS'),'D','Y','N','Y',120,'fc97d18a-d3e0-4285-bc9c-bd9fb4f16a71',0,'Indicates the Action to be performed','Action','Y',1,2,1)
;

-- Oct 23, 2012 6:28:44 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200731 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200054
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200731
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200056
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200057
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200051
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200052
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200058
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200059
;

-- Oct 23, 2012 6:29:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=110,IsDisplayed='Y' WHERE AD_Field_ID=200053
;

INSERT INTO t_alter_column values('ad_toolbarbutton','"classname"',null,'NULL',null)
;

UPDATE AD_ToolbarButton SET Classname=NULL WHERE Classname IS NOT NULL
;

-- Oct 24, 2012 4:40:17 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_ToolBarButton SET "action"='R',Updated=TO_TIMESTAMP('2012-10-24 16:40:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200059
;

-- Oct 24, 2012 4:40:20 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_ToolBarButton SET "action"='R',Updated=TO_TIMESTAMP('2012-10-24 16:40:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200060
;

-- Oct 24, 2012 4:40:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_ToolBarButton SET "action"='R',Updated=TO_TIMESTAMP('2012-10-24 16:40:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200061
;

-- Oct 24, 2012 4:40:31 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_ToolBarButton SET "action"='R',Updated=TO_TIMESTAMP('2012-10-24 16:40:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200062
;

-- Oct 24, 2012 4:40:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_ToolBarButton SET "action"='R',Updated=TO_TIMESTAMP('2012-10-24 16:40:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200063
;

-- Oct 24, 2012 4:40:41 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_ToolBarButton SET "action"='R',Updated=TO_TIMESTAMP('2012-10-24 16:40:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200064
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200054
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200056
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200057
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200051
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200052
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200058
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=90,IsDisplayedGrid='Y' WHERE AD_Field_ID=200059
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=100,IsDisplayedGrid='Y' WHERE AD_Field_ID=200053
;

-- Oct 24, 2012 4:43:25 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y' WHERE AD_Field_ID=200731
;

-- Oct 24, 2012 4:44:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200052
;

-- Oct 24, 2012 4:44:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200058
;

-- Oct 24, 2012 4:44:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200059
;

-- Oct 24, 2012 4:44:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200731
;

-- Oct 24, 2012 4:44:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200057
;

-- Oct 24, 2012 4:44:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200051
;

-- Oct 24, 2012 4:44:36 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=80,IsDisplayedGrid='Y' WHERE AD_Field_ID=200053
;

-- Oct 24, 2012 4:45:48 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200052
;

-- Oct 24, 2012 4:45:48 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200058
;

-- Oct 24, 2012 4:45:48 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200059
;

-- Oct 24, 2012 4:45:48 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200053
;

-- Oct 24, 2012 4:49:32 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET DisplayLogic='@Action@=R',Updated=TO_TIMESTAMP('2012-10-24 16:49:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200615
;

-- Oct 24, 2012 4:52:58 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2012-10-24 16:52:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200070
;

-- Oct 24, 2012 4:53:04 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET XPosition=1,Updated=TO_TIMESTAMP('2012-10-24 16:53:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200615
;

-- Oct 24, 2012 5:36:10 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET IsActive='N',Updated=TO_TIMESTAMP('2012-10-24 17:36:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=200087
;

-- Oct 24, 2012 5:37:48 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,200003,'D','N','N','N',0,'N',10,'N',30,'N',125,TO_TIMESTAMP('2012-10-24 17:37:46','YYYY-MM-DD HH24:MI:SS'),'N','Y','0759632a-25f9-48e5-a6e4-13214fa8d57c','Y','N','AD_Tab_ID','Tab within a Window','The Tab indicates a tab that displays within a window.','Tab','Y','Y',100,TO_TIMESTAMP('2012-10-24 17:37:46','YYYY-MM-DD HH24:MI:SS'),0,100,0,200813,'N',0)
;

-- Oct 24, 2012 5:37:48 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200813 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 24, 2012 5:38:55 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,200003,'D','N','N','N',0,'N',10,'N',19,'N',117,TO_TIMESTAMP('2012-10-24 17:38:53','YYYY-MM-DD HH24:MI:SS'),'N','Y','208abde6-b52c-4d25-9051-36e139e6214a','Y','N','AD_Process_ID','Process or Report','The Process field identifies a unique Process or Report in the system.','Process','Y','Y',100,TO_TIMESTAMP('2012-10-24 17:38:53','YYYY-MM-DD HH24:MI:SS'),0,100,0,200814,'N',0)
;

-- Oct 24, 2012 5:38:55 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200814 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 24, 2012 5:41:04 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,200003,'D','N','N','N',0,'N',2000,'N',14,'N',283,TO_TIMESTAMP('2012-10-24 17:41:03','YYYY-MM-DD HH24:MI:SS'),'N','Y','f55fe6cb-34f8-4291-a879-44f8f7b9d7cf','Y','N','DisplayLogic','If the Field is displayed, the result determines if the field is actually displayed','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)','Display Logic','Y','Y',100,TO_TIMESTAMP('2012-10-24 17:41:03','YYYY-MM-DD HH24:MI:SS'),0,100,0,200815,'N',0)
;

-- Oct 24, 2012 5:41:04 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200815 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 24, 2012 5:50:23 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,DefaultValue,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,200003,'D','N','N','N',0,'N',10,'N',11,'N',566,TO_TIMESTAMP('2012-10-24 17:50:22','YYYY-MM-DD HH24:MI:SS'),'N','Y','093d28e9-b81f-4e86-8e43-fcadcf708af6','@SQL=SELECT NVL(MAX(SeqNo),0)+10 AS DefaultValue FROM AD_ToolbarButton WHERE AD_Tab_ID=@AD_Tab_ID@','Y','N','SeqNo','Method of ordering records; lowest number comes first','The Sequence indicates the order of records','Sequence','Y','Y',100,TO_TIMESTAMP('2012-10-24 17:50:22','YYYY-MM-DD HH24:MI:SS'),0,100,0,200816,'N',0)
;

-- Oct 24, 2012 5:50:23 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200816 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 24, 2012 5:50:57 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
ALTER TABLE AD_ToolBarButton ADD COLUMN AD_Tab_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 24, 2012 5:51:08 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
ALTER TABLE AD_ToolBarButton ADD COLUMN AD_Process_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 24, 2012 5:51:28 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
ALTER TABLE AD_ToolBarButton ADD COLUMN DisplayLogic VARCHAR(2000) DEFAULT NULL 
;

-- Oct 24, 2012 5:51:38 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
ALTER TABLE AD_ToolBarButton ADD COLUMN SeqNo NUMERIC(10) DEFAULT NULL 
;

-- Oct 24, 2012 5:54:46 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column (IsSyncDatabase,IsEncrypted,Version,AD_Table_ID,EntityType,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,AD_Val_Rule_ID,IsKey,AD_Element_ID,Created,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,IsAlwaysUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,Updated,AD_Org_ID,UpdatedBy,AD_Client_ID,AD_Column_ID,IsToolbarButton,SeqNoSelection) VALUES ('N','N',1,200004,'D','N','N','N',0,'N',10,'N',19,163,'N',125,TO_TIMESTAMP('2012-10-24 17:54:45','YYYY-MM-DD HH24:MI:SS'),'N','Y','16e082c5-c744-4f85-8a3a-f139690521af','Y','N','AD_Tab_ID','Tab within a Window','The Tab indicates a tab that displays within a window.','Tab','Y','Y',100,TO_TIMESTAMP('2012-10-24 17:54:45','YYYY-MM-DD HH24:MI:SS'),0,100,0,200817,'N',0)
;

-- Oct 24, 2012 5:54:46 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Column_Trl (AD_Language,AD_Column_ID, Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Column_Trl_UU ) SELECT l.AD_Language,t.AD_Column_ID, t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Column t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Column_ID=200817 AND NOT EXISTS (SELECT * FROM AD_Column_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Column_ID=t.AD_Column_ID)
;

-- Oct 24, 2012 5:54:53 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
ALTER TABLE AD_ToolBarButtonRestrict ADD COLUMN AD_Tab_ID NUMERIC(10) DEFAULT NULL 
;

-- Oct 24, 2012 5:58:34 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,DisplayLogic,Name,UpdatedBy,IsActive,XPosition,ColumnSpan,NumLines) VALUES (0,'N',200003,'N','N',200817,90,'Y',200732,'N','The Tab indicates a tab that displays within a window.',0,TO_TIMESTAMP('2012-10-24 17:58:33','YYYY-MM-DD HH24:MI:SS'),'N',90,'D',0,'Tab within a Window','Y','N','0ba360c9-e34d-45a8-a5ff-0dbaf222f82c',100,TO_TIMESTAMP('2012-10-24 17:58:33','YYYY-MM-DD HH24:MI:SS'),0,'@Action@=W','Tab',100,'Y',4,2,1)
;

-- Oct 24, 2012 5:58:34 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200732 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 5:59:09 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200070
;

-- Oct 24, 2012 5:59:09 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200732
;

-- Oct 24, 2012 5:59:09 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200068
;

-- Oct 24, 2012 5:59:09 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=200730
;

-- Oct 24, 2012 6:01:15 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Val_Rule SET Code='((AD_ToolbarButton.Action=''@Action@'') OR (AD_ToolbarButton.Action||''@Action@''=''RW'' )) AND (AD_ToolbarButton.AD_Tab_ID IS NULL OR AD_ToolbarButton.AD_Tab_ID=@AD_Tab_ID@))',Updated=TO_TIMESTAMP('2012-10-24 18:01:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200011
;

-- Oct 24, 2012 6:03:27 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Tab SET SeqNo=90,Updated=TO_TIMESTAMP('2012-10-24 18:03:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=115
;

-- Oct 24, 2012 6:05:49 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Tab (IsSortTab,ImportFields,Processing,AD_Window_ID,SeqNo,AD_Table_ID,HasTree,IsInfoTab,AD_Column_ID,AD_Client_ID,IsInsertRecord,IsAdvancedTab,TabLevel,AD_Tab_UU,EntityType,IsReadOnly,AD_Org_ID,Created,CreatedBy,Updated,Name,OrderByClause,IsSingleRow,IsTranslationTab,UpdatedBy,IsActive,AD_Tab_ID) VALUES ('N','N','N',102,80,200003,'N','N',200813,0,'Y','N',2,'b67bbfa7-d919-431f-88e0-74bf410c321d','D','N',0,TO_TIMESTAMP('2012-10-24 18:05:48','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2012-10-24 18:05:48','YYYY-MM-DD HH24:MI:SS'),'Toolbar Button','SeqNo','N','N',100,'Y',200028)
;

-- Oct 24, 2012 6:05:50 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Tab_Trl (AD_Language,AD_Tab_ID, CommitWarning,Help,Name,Description, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Tab_Trl_UU ) SELECT l.AD_Language,t.AD_Tab_ID, t.CommitWarning,t.Help,t.Name,t.Description, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Tab t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Tab_ID=200028 AND NOT EXISTS (SELECT * FROM AD_Tab_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Tab_ID=t.AD_Tab_ID)
;

-- Oct 24, 2012 6:06:58 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200812,'Y',200733,'N','The Action field is a drop down list box which indicates the Action to be performed for this Item.',0,TO_TIMESTAMP('2012-10-24 18:06:57','YYYY-MM-DD HH24:MI:SS'),'D',0,'Indicates the Action to be performed','Y','N','431eb0bc-d764-4a77-843d-537ea5b0178e',100,TO_TIMESTAMP('2012-10-24 18:06:57','YYYY-MM-DD HH24:MI:SS'),1,'Action',100,'Y')
;

-- Oct 24, 2012 6:06:58 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200733 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:06:59 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200095,'Y',200734,'N',0,TO_TIMESTAMP('2012-10-24 18:06:58','YYYY-MM-DD HH24:MI:SS'),'D',0,'The class name that implements the interface for toolbar actions','Y','N','6420886d-cd75-4159-a1ca-eeae6d3309d7',100,TO_TIMESTAMP('2012-10-24 18:06:58','YYYY-MM-DD HH24:MI:SS'),255,'Action Class Name',100,'Y')
;

-- Oct 24, 2012 6:06:59 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200734 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:06:59 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200096,'Y',200735,'N','Used to get the corresponding message and Icon name prefix',0,TO_TIMESTAMP('2012-10-24 18:06:59','YYYY-MM-DD HH24:MI:SS'),'D',0,'Action name on the toolbar','Y','N','944ffe4d-5a59-4352-99ef-2b6d0349932f',100,TO_TIMESTAMP('2012-10-24 18:06:59','YYYY-MM-DD HH24:MI:SS'),60,'Action Name',100,'Y')
;

-- Oct 24, 2012 6:06:59 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200735 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:00 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200089,'Y',200736,'N','There are two methods of making records unavailable in the system: One is to delete the record, the other is to de-activate the record. A de-activated record is not available for selection, but available for reports.
There are two reasons for de-activating and not deleting records:
(1) The system requires the record for audit purposes.
(2) The record is referenced by other records. E.g., you cannot delete a Business Partner, if there are invoices for this partner record existing. You de-activate the Business Partner and prevent that this record is used for future entries.',0,TO_TIMESTAMP('2012-10-24 18:06:59','YYYY-MM-DD HH24:MI:SS'),'D',0,'The record is active in the system','Y','N','2ed0ef54-e204-4b18-bafa-4f9b8dfb68c6',100,TO_TIMESTAMP('2012-10-24 18:06:59','YYYY-MM-DD HH24:MI:SS'),1,'Active',100,'Y')
;

-- Oct 24, 2012 6:07:00 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200736 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_Org_ID,Created,EntityType,AD_Client_ID,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200204,'Y',200737,'N',0,TO_TIMESTAMP('2012-10-24 18:07:00','YYYY-MM-DD HH24:MI:SS'),'D',0,'Y','N','82384725-b699-4676-9bf9-f41018683484',100,TO_TIMESTAMP('2012-10-24 18:07:00','YYYY-MM-DD HH24:MI:SS'),36,'AD_ToolBarButton_UU',100,'Y')
;

-- Oct 24, 2012 6:07:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200737 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200083,'Y',200738,'N','A Client is a company or a legal entity. You cannot share data between Clients. Tenant is a synonym for Client.',0,TO_TIMESTAMP('2012-10-24 18:07:01','YYYY-MM-DD HH24:MI:SS'),'D',0,'Client/Tenant for this installation.','Y','N','f70ffbf9-81c6-4760-bf65-662157d15d11',100,TO_TIMESTAMP('2012-10-24 18:07:01','YYYY-MM-DD HH24:MI:SS'),22,'Client',100,'Y')
;

-- Oct 24, 2012 6:07:02 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200738 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:03 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_Org_ID,Created,EntityType,AD_Client_ID,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200088,'Y',200739,'N',0,TO_TIMESTAMP('2012-10-24 18:07:02','YYYY-MM-DD HH24:MI:SS'),'D',0,'Y','N','f4d110db-ca5e-475a-9d2c-a2a15df8e228',100,TO_TIMESTAMP('2012-10-24 18:07:02','YYYY-MM-DD HH24:MI:SS'),255,'Component Name',100,'Y')
;

-- Oct 24, 2012 6:07:03 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200739 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:04 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200094,'Y',200740,'N','The migration "resets" the system to the current/original setting.  If selected you can save the customization and re-apply it.  Please note that you need to check, if your customization has no negative side effect in the new release.',0,TO_TIMESTAMP('2012-10-24 18:07:03','YYYY-MM-DD HH24:MI:SS'),'D',0,'The change is a customization of the data dictionary and can be applied after Migration','Y','N','5c33c342-0211-4534-97bb-8fe4187b4d96',100,TO_TIMESTAMP('2012-10-24 18:07:03','YYYY-MM-DD HH24:MI:SS'),1,'Customization',100,'Y')
;

-- Oct 24, 2012 6:07:04 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200740 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:05 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200815,'Y',200741,'N','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',0,TO_TIMESTAMP('2012-10-24 18:07:04','YYYY-MM-DD HH24:MI:SS'),'D',0,'If the Field is displayed, the result determines if the field is actually displayed','Y','N','87d35c66-a9bc-4ce4-9510-4d639edf144e',100,TO_TIMESTAMP('2012-10-24 18:07:04','YYYY-MM-DD HH24:MI:SS'),2000,'Display Logic',100,'Y')
;

-- Oct 24, 2012 6:07:05 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200741 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:06 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200097,'Y',200742,'N',0,TO_TIMESTAMP('2012-10-24 18:07:05','YYYY-MM-DD HH24:MI:SS'),'D',0,'KeyCode for shortcuts','Y','N','105f662c-4c38-4efc-b00f-f092337ba9ee',100,TO_TIMESTAMP('2012-10-24 18:07:05','YYYY-MM-DD HH24:MI:SS'),10,'KeyCode',100,'Y')
;

-- Oct 24, 2012 6:07:06 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200742 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:07 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200098,'Y',200743,'N',0,TO_TIMESTAMP('2012-10-24 18:07:06','YYYY-MM-DD HH24:MI:SS'),'D',0,'Keystroke Modifiers for shortcuts','Y','N','dc6e02fe-97c8-40ca-bca7-ca52b0798401',100,TO_TIMESTAMP('2012-10-24 18:07:06','YYYY-MM-DD HH24:MI:SS'),10,'Keystroke Modifiers',100,'Y')
;

-- Oct 24, 2012 6:07:07 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200743 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:07 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200091,'Y',200744,'N','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',0,TO_TIMESTAMP('2012-10-24 18:07:07','YYYY-MM-DD HH24:MI:SS'),'D',0,'Alphanumeric identifier of the entity','Y','N','4ba69d5b-69bc-4162-9aa2-0bcd7064ae4d',100,TO_TIMESTAMP('2012-10-24 18:07:07','YYYY-MM-DD HH24:MI:SS'),60,'Name',100,'Y')
;

-- Oct 24, 2012 6:07:07 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200744 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:08 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200084,'Y',200745,'N','An organization is a unit of your client or legal entity - examples are store, department. You can share data between organizations.',0,TO_TIMESTAMP('2012-10-24 18:07:07','YYYY-MM-DD HH24:MI:SS'),'D',0,'Organizational entity within client','Y','N','4e365917-a396-4928-a6b7-c861055c9f78',100,TO_TIMESTAMP('2012-10-24 18:07:07','YYYY-MM-DD HH24:MI:SS'),22,'Organization',100,'Y')
;

-- Oct 24, 2012 6:07:08 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200745 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:09 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200814,'Y',200746,'N','The Process field identifies a unique Process or Report in the system.',0,TO_TIMESTAMP('2012-10-24 18:07:08','YYYY-MM-DD HH24:MI:SS'),'D',0,'Process or Report','Y','N','42794be2-2e7c-42cc-924d-4da8314a24fb',100,TO_TIMESTAMP('2012-10-24 18:07:08','YYYY-MM-DD HH24:MI:SS'),10,'Process',100,'Y')
;

-- Oct 24, 2012 6:07:09 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200746 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:10 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200816,'Y',200747,'N','The Sequence indicates the order of records',0,TO_TIMESTAMP('2012-10-24 18:07:09','YYYY-MM-DD HH24:MI:SS'),'D',0,'Method of ordering records; lowest number comes first','Y','N','0f9a9af3-8f38-4f44-88ff-13efca819a8a',100,TO_TIMESTAMP('2012-10-24 18:07:09','YYYY-MM-DD HH24:MI:SS'),10,'Sequence',100,'Y')
;

-- Oct 24, 2012 6:07:10 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200747 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:11 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200813,'Y',200748,'N','The Tab indicates a tab that displays within a window.',0,TO_TIMESTAMP('2012-10-24 18:07:10','YYYY-MM-DD HH24:MI:SS'),'D',0,'Tab within a Window','Y','N','68a5b882-5d9c-4a92-99d1-e13473944b8f',100,TO_TIMESTAMP('2012-10-24 18:07:10','YYYY-MM-DD HH24:MI:SS'),10,'Tab',100,'Y')
;

-- Oct 24, 2012 6:07:11 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200748 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:12 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,AD_Org_ID,Created,IsDisplayedGrid,EntityType,AD_Client_ID,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,Name,UpdatedBy,IsActive) VALUES ('N',200028,'N','N',200090,'Y',200749,'N',0,TO_TIMESTAMP('2012-10-24 18:07:11','YYYY-MM-DD HH24:MI:SS'),'N','D',0,'N','N','ec7e1b7d-2ae5-4214-8465-97d8628b9ac5',100,TO_TIMESTAMP('2012-10-24 18:07:11','YYYY-MM-DD HH24:MI:SS'),22,'ToolBar Button',100,'Y')
;

-- Oct 24, 2012 6:07:12 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200749 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 24, 2012 6:07:44 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200734
;

-- Oct 24, 2012 6:07:44 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field WHERE AD_Field_ID=200734
;

-- Oct 24, 2012 6:07:56 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200735
;

-- Oct 24, 2012 6:07:56 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field WHERE AD_Field_ID=200735
;

-- Oct 24, 2012 6:08:15 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200742
;

-- Oct 24, 2012 6:08:15 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field WHERE AD_Field_ID=200742
;

-- Oct 24, 2012 6:08:21 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field_Trl WHERE AD_Field_ID=200743
;

-- Oct 24, 2012 6:08:21 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
DELETE FROM AD_Field WHERE AD_Field_ID=200743
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200737
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200733
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=0,IsDisplayed='N' WHERE AD_Field_ID=200740
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=10,IsDisplayed='Y' WHERE AD_Field_ID=200738
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=20,IsDisplayed='Y' WHERE AD_Field_ID=200745
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=30,IsDisplayed='Y' WHERE AD_Field_ID=200748
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=40,IsDisplayed='Y' WHERE AD_Field_ID=200744
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=50,IsDisplayed='Y' WHERE AD_Field_ID=200739
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=60,IsDisplayed='Y' WHERE AD_Field_ID=200736
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=70,IsDisplayed='Y' WHERE AD_Field_ID=200747
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=200746
;

-- Oct 24, 2012 6:12:01 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=200741
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200737
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200733
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200738
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200740
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N' WHERE AD_Field_ID=200745
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y' WHERE AD_Field_ID=200748
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y' WHERE AD_Field_ID=200747
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=30,IsDisplayedGrid='Y' WHERE AD_Field_ID=200744
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=40,IsDisplayedGrid='Y' WHERE AD_Field_ID=200739
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=50,IsDisplayedGrid='Y' WHERE AD_Field_ID=200746
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=60,IsDisplayedGrid='Y' WHERE AD_Field_ID=200741
;

-- Oct 24, 2012 6:13:43 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET SeqNoGrid=70,IsDisplayedGrid='Y' WHERE AD_Field_ID=200736
;

-- Oct 24, 2012 6:17:56 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Tab SET WhereClause='AD_ToolBarButton.AD_Tab_ID IS NULL',Updated=TO_TIMESTAMP('2012-10-24 18:17:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200002
;

-- Oct 24, 2012 9:04:04 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:04:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200738
;

-- Oct 24, 2012 9:04:16 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:04:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200745
;

-- Oct 24, 2012 9:04:27 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:04:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200748
;

-- Oct 24, 2012 9:04:40 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:04:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200744
;

-- Oct 24, 2012 9:04:51 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:04:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200739
;

-- Oct 24, 2012 9:05:00 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET XPosition=2, ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:05:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200736
;

-- Oct 24, 2012 9:05:14 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:05:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200747
;

-- Oct 24, 2012 9:05:17 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET ColumnSpan=2,Updated=TO_TIMESTAMP('2012-10-24 21:05:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200746
;

-- Oct 24, 2012 9:05:23 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET ColumnSpan=5, NumLines=3,Updated=TO_TIMESTAMP('2012-10-24 21:05:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200741
;

-- Oct 24, 2012 9:06:12 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Tab SET SeqNo=80,Updated=TO_TIMESTAMP('2012-10-24 21:06:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=115
;

-- Oct 24, 2012 9:06:17 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Tab SET SeqNo=90,Updated=TO_TIMESTAMP('2012-10-24 21:06:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Tab_ID=200028
;

-- Oct 24, 2012 9:34:31 PM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Val_Rule SET Code='(((AD_ToolbarButton.Action=''@Action@'') OR (AD_ToolbarButton.Action||''@Action@''=''RW'' )) AND (coalesce(AD_ToolbarButton.AD_Tab_ID,0)=@AD_Tab_ID:0@))',Updated=TO_TIMESTAMP('2012-10-24 21:34:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Val_Rule_ID=200011
;

-- Oct 27, 2012 10:19:50 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,AD_Org_ID,Created,IsDisplayedGrid,SeqNoGrid,EntityType,AD_Client_ID,Description,IsDisplayed,IsFieldOnly,AD_Field_UU,CreatedBy,Updated,DisplayLength,DisplayLogic,Name,UpdatedBy,IsActive,XPosition,ColumnSpan,NumLines) VALUES (0,'N',200002,'N','N',200815,90,'Y',200753,'N','format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
@AD_Table_ID@=14 | @Language@!GERGER <br>
@PriceLimit@>10 | @PriceList@>@PriceActual@<br>
@Name@>J<br>
Strings may be in single quotes (optional)',0,TO_TIMESTAMP('2012-10-27 10:19:47','YYYY-MM-DD HH24:MI:SS'),'N',90,'D',0,'If the Field is displayed, the result determines if the field is actually displayed','Y','N','5091d500-3614-4ffb-8655-36f64d0b12be',100,TO_TIMESTAMP('2012-10-27 10:19:47','YYYY-MM-DD HH24:MI:SS'),0,'@IsCustomization@=Y','Display Logic',100,'Y',1,5,3)
;

-- Oct 27, 2012 10:19:50 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
INSERT INTO AD_Field_Trl (AD_Language,AD_Field_ID, Help,Description,Name, IsTranslated,AD_Client_ID,AD_Org_ID,Created,Createdby,Updated,UpdatedBy,AD_Field_Trl_UU ) SELECT l.AD_Language,t.AD_Field_ID, t.Help,t.Description,t.Name, 'N',t.AD_Client_ID,t.AD_Org_ID,t.Created,t.Createdby,t.Updated,t.UpdatedBy,Generate_UUID() FROM AD_Language l, AD_Field t WHERE l.IsActive='Y' AND l.IsSystemLanguage='Y' AND l.IsBaseLanguage='N' AND t.AD_Field_ID=200753 AND NOT EXISTS (SELECT * FROM AD_Field_Trl tt WHERE tt.AD_Language=l.AD_Language AND tt.AD_Field_ID=t.AD_Field_ID)
;

-- Oct 27, 2012 10:24:14 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Element SET Help='The OSGi service component name that implements the IAction interface for toolbar action', Name='Service Component Name', Description='The service component name that implements the interface for toolbar actions', PrintName='Service Component Name',Updated=TO_TIMESTAMP('2012-10-27 10:24:14','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=200018
;

-- Oct 27, 2012 10:24:14 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Element_Trl SET IsTranslated='N' WHERE AD_Element_ID=200018
;

-- Oct 27, 2012 10:24:14 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Column SET ColumnName='ActionClassName', Name='Service Component Name', Description='The service component name that implements the interface for toolbar actions', Help='The OSGi service component name that implements the IAction interface for toolbar action' WHERE AD_Element_ID=200018
;

-- Oct 27, 2012 10:24:15 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Process_Para SET ColumnName='ActionClassName', Name='Service Component Name', Description='The service component name that implements the interface for toolbar actions', Help='The OSGi service component name that implements the IAction interface for toolbar action', AD_Element_ID=200018 WHERE UPPER(ColumnName)='ACTIONCLASSNAME' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 27, 2012 10:24:15 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Process_Para SET ColumnName='ActionClassName', Name='Service Component Name', Description='The service component name that implements the interface for toolbar actions', Help='The OSGi service component name that implements the IAction interface for toolbar action' WHERE AD_Element_ID=200018 AND IsCentrallyMaintained='Y'
;

-- Oct 27, 2012 10:24:15 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_Field SET Name='Service Component Name', Description='The service component name that implements the interface for toolbar actions', Help='The OSGi service component name that implements the IAction interface for toolbar action' WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=200018) AND IsCentrallyMaintained='Y'
;

-- Oct 27, 2012 10:24:15 AM MYT
-- IDEMPIERE-234 Configurable Toolbar
UPDATE AD_PrintFormatItem SET PrintName='Service Component Name', Name='Service Component Name' WHERE IsCentrallyMaintained='Y' AND EXISTS (SELECT * FROM AD_Column c WHERE c.AD_Column_ID=AD_PrintFormatItem.AD_Column_ID AND c.AD_Element_ID=200018)
;

SELECT register_migration_script('948_IDEMPIERE-234.sql') FROM dual
;
