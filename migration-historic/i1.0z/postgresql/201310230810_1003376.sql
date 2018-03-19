-- Oct 23, 2013 3:21:49 PM MYT
-- 1003376 Form to captured process parameter for scheduler
INSERT INTO AD_Element (ColumnName,AD_Element_ID,Help,Name,Description,PrintName,AD_Element_UU,Created,Updated,AD_Org_ID,CreatedBy,UpdatedBy,IsActive,AD_Client_ID,EntityType) VALUES ('ParameterToDefault',202621,'The default value can be a variable like @#Date@ ','Default To Parameter','Default value of the to parameter','Default To Parameter','51de5831-4534-45e3-865b-d3ae57c7770d',TO_TIMESTAMP('2013-10-23 15:21:48','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-23 15:21:48','YYYY-MM-DD HH24:MI:SS'),0,100,100,'Y',0,'D')
;

-- Oct 23, 2013 3:22:53 PM MYT
-- 1003376 Form to captured process parameter for scheduler
INSERT INTO AD_Column (IsSyncDatabase,Version,AD_Table_ID,AD_Column_ID,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,AD_Reference_ID,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,Updated,CreatedBy,AD_Org_ID,IsActive,Created,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,EntityType,IsEncrypted,AD_Element_ID,IsSecure) VALUES ('N',1,698,210881,'N','N','N',0,'N',255,'N',10,'N','N','N','c3d45397-19b4-4cd9-9dda-1cde8d35ef8b','Y','ParameterToDefault','Default value of the to parameter','The default value can be a variable like @#Date@ ','Default To Parameter','Y',TO_TIMESTAMP('2013-10-23 15:22:52','YYYY-MM-DD HH24:MI:SS'),100,0,'Y',TO_TIMESTAMP('2013-10-23 15:22:52','YYYY-MM-DD HH24:MI:SS'),100,'N','N',0,'D','N',202621,'N')
;

-- Oct 23, 2013 3:23:22 PM MYT
-- 1003376 Form to captured process parameter for scheduler
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2013-10-23 15:23:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=210881
;

-- Oct 23, 2013 3:23:39 PM MYT
-- 1003376 Form to captured process parameter for scheduler
ALTER TABLE AD_Scheduler_Para ADD COLUMN ParameterToDefault VARCHAR(255) DEFAULT NULL 
;

-- Oct 23, 2013 3:25:14 PM MYT
-- 1003376 Form to captured process parameter for scheduler
INSERT INTO AD_Field (SortNo,IsEncrypted,AD_Tab_ID,DisplayLength,IsSameLine,IsHeading,AD_Column_ID,SeqNo,IsCentrallyMaintained,AD_Field_ID,IsReadOnly,Help,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,UpdatedBy,AD_Org_ID,Created,CreatedBy,Updated,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,ColumnSpan,NumLines,EntityType,IsAdvancedField,IsDefaultFocus) VALUES (0,'N',590,0,'N','N',210881,80,'Y',202528,'N','The default value can be a variable like @#Date@ ','Default value of the to parameter','Default To Parameter','f9902ce8-90b2-4192-ab23-a1f218e34535','Y','N',100,0,TO_TIMESTAMP('2013-10-23 15:25:12','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-23 15:25:12','YYYY-MM-DD HH24:MI:SS'),'Y','Y',80,1,'N',0,2,1,'D','N','N')
;

-- Oct 23, 2013 3:25:45 PM MYT
-- 1003376 Form to captured process parameter for scheduler
UPDATE AD_Field SET SeqNo=70, IsDisplayed='Y', XPosition=1, ColumnSpan=5,Updated=TO_TIMESTAMP('2013-10-23 15:25:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202528
;

-- Oct 23, 2013 3:25:45 PM MYT
-- 1003376 Form to captured process parameter for scheduler
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2013-10-23 15:25:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=9447
;

-- Oct 23, 2013 3:27:43 PM MYT
-- 1003376 Form to captured process parameter for scheduler
INSERT INTO AD_Form (AccessLevel,Classname,AD_Form_ID,IsBetaFunctionality,AD_Form_UU,Name,AD_Org_ID,UpdatedBy,CreatedBy,Updated,Created,IsActive,AD_Client_ID,EntityType) VALUES ('4','org.adempiere.webui.apps.form.WProcessParameter',200008,'N','0a47e803-4917-4e7f-af33-39135b8b2415','Captured Process Parameter',0,100,100,TO_TIMESTAMP('2013-10-23 15:27:42','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2013-10-23 15:27:42','YYYY-MM-DD HH24:MI:SS'),'Y',0,'D')
;

-- Oct 23, 2013 3:28:05 PM MYT
-- 1003376 Form to captured process parameter for scheduler
INSERT INTO AD_Process (CopyFromProcess,AD_Process_ID,IsDirectPrint,IsReport,AD_Process_UU,AccessLevel,IsBetaFunctionality,IsServerProcess,Statistic_Seconds,Statistic_Count,ShowHelp,AD_Form_ID,AD_Org_ID,Updated,UpdatedBy,Created,IsActive,CreatedBy,Name,Value,AD_Client_ID,EntityType) VALUES ('N',200064,'N','N','cef75223-9f82-4eb3-a2e9-9702eb2f7d69','4','N','N',0,0,'Y',200008,0,TO_TIMESTAMP('2013-10-23 15:28:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2013-10-23 15:28:05','YYYY-MM-DD HH24:MI:SS'),'Y',100,'Captured Process Parameter','CapturedProcessParameter',0,'D')
;

-- Oct 23, 2013 3:29:32 PM MYT
-- 1003376 Form to captured process parameter for scheduler
INSERT INTO AD_ToolBarButton ("action",AD_Tab_ID,AD_Process_ID,SeqNo,Created,AD_Org_ID,IsCustomization,Name,ComponentName,CreatedBy,AD_ToolBarButton_ID,Updated,UpdatedBy,IsActive,AD_Client_ID,AD_ToolBarButton_UU) VALUES ('W',589,200064,10,TO_TIMESTAMP('2013-10-23 15:29:31','YYYY-MM-DD HH24:MI:SS'),0,'N','Captured Process Parameter','CapturedProcessParameter',100,200077,TO_TIMESTAMP('2013-10-23 15:29:31','YYYY-MM-DD HH24:MI:SS'),100,'Y',0,'45728640-5c48-41be-b2b6-5970199b05db')
;

SELECT register_migration_script('201310230810_1003376.sql') FROM dual
;

