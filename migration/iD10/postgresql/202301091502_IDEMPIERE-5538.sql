-- IDEMPIERE-5538
SELECT register_migration_script('202301091502_IDEMPIERE-5538.sql') FROM dual;

-- Jan 9, 2023, 3:02:37 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215738,0,'Valid','Element is valid','The element passed the validation check',200335,'IsValid','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2023-01-09 15:02:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-09 15:02:36','YYYY-MM-DD HH24:MI:SS'),100,2002,'Y','N','D','N','N','N','Y','8b4d9a1c-ef04-4b39-bab3-d35ebbbaa399','Y',0,'N','N','N')
;

-- Jan 9, 2023, 3:02:49 PM CET
ALTER TABLE AD_Process_DrillRule ADD COLUMN IsValid CHAR(1) DEFAULT 'N' CHECK (IsValid IN ('Y','N')) NOT NULL
;

-- Jan 9, 2023, 3:03:06 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (207523,'Valid','Element is valid','The element passed the validation check',200308,215738,'Y',1,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-01-09 15:03:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-09 15:03:06','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','aa4a1aca-cf2c-4754-bbd2-c84ab8b6934c','Y',110,2,2)
;

-- Jan 9, 2023, 3:03:46 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, XPosition=5,Updated=TO_TIMESTAMP('2023-01-09 15:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207523
;

-- Jan 9, 2023, 3:03:46 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-01-09 15:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206930
;

-- Jan 9, 2023, 3:03:46 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-01-09 15:03:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207109
;

-- Jan 9, 2023, 3:29:30 PM CET
UPDATE AD_Field SET IsReadOnly='Y',Updated=TO_TIMESTAMP('2023-01-09 15:29:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207523
;

-- Jan 9, 2023, 4:27:35 PM CET
INSERT INTO AD_Process (AD_Process_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,Name,Description,Help,IsReport,Value,IsDirectPrint,Classname,AccessLevel,EntityType,Statistic_Count,Statistic_Seconds,IsBetaFunctionality,ShowHelp,AD_Process_UU) VALUES (200147,0,0,'Y',TO_TIMESTAMP('2023-01-09 16:27:35','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-01-09 16:27:35','YYYY-MM-DD HH24:MI:SS'),100,'Validate','Validate Drill Rule Parameters','Validate the Drill Rule, if all mandatory parameters are set.','N','AD_Process_DrillRule_Validate','N','org.compiere.process.DrillRuleValidate','6','D',0,0,'N','Y','858ac391-3f7e-498d-bbef-caa1ad94e5f6')
;

-- Jan 9, 2023, 4:29:11 PM CET
INSERT INTO AD_ToolBarButton (AD_Client_ID,AD_Org_ID,Created,CreatedBy,ComponentName,IsActive,AD_ToolBarButton_ID,Name,Updated,UpdatedBy,IsCustomization,AD_ToolBarButton_UU,"action",AD_Tab_ID,AD_Process_ID,SeqNo,EntityType) VALUES (0,0,TO_TIMESTAMP('2023-01-09 16:29:10','YYYY-MM-DD HH24:MI:SS'),100,'Validate','Y',200128,'Validate',TO_TIMESTAMP('2023-01-09 16:29:10','YYYY-MM-DD HH24:MI:SS'),100,'N','b739ac8e-704e-4c34-8eab-87e3eb087dba','W',200308,200147,20,'D')
;

-- Jan 9, 2023, 4:31:45 PM CET
UPDATE AD_ToolBarButton SET DisplayLogic='@AD_Client_ID@=@#AD_Client_ID@',Updated=TO_TIMESTAMP('2023-01-09 16:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_ToolBarButton_ID=200128
;

