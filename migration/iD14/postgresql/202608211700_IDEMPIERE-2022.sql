-- IDEMPIERE-2022 Workflow - Wait (Schedule) Action for scheduled workflow activities
SELECT register_migration_script('202608211700_IDEMPIERE-2022.sql') FROM dual;

-- Aug 21, 2026, 5:00:00 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,Description,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200778,'Wait (Schedule)','Wait until a dynamically calculated date and time',302,'S',0,0,'Y',TO_TIMESTAMP('2026-08-21 17:00:00','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-21 17:00:00','YYYY-MM-DD HH24:MI:SS'),100,'D','5c67d246-70f0-4538-9075-a1d70cb51330')
;

-- Aug 21, 2026, 5:00:01 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (204121,0,0,'Y',TO_TIMESTAMP('2026-08-21 17:00:01','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-21 17:00:01','YYYY-MM-DD HH24:MI:SS'),100,'ScheduleExpression','Schedule Expression','SQL expression that determines when a scheduled workflow activity resumes','The expression must start with @SQL= and return one timestamp. It is evaluated when the activity is created and again on every workflow processor run. Context variables are resolved from the workflow record.','Schedule Expression','D','b84d9acf-93fd-4ee6-88bc-20cff9f44a42')
;

-- Aug 21, 2026, 5:00:02 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml,IsPartitionKey) VALUES (217655,0,'Schedule Expression','SQL expression that determines when a scheduled workflow activity resumes','The expression must start with @SQL= and return one timestamp. It is evaluated when the activity is created and again on every workflow processor run. Context variables are resolved from the workflow record.',129,'ScheduleExpression',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2026-08-21 17:00:02','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-21 17:00:02','YYYY-MM-DD HH24:MI:SS'),100,204121,'Y','N','D','N','N','N','Y','3f09efa7-a7fb-4ae4-90f9-e71850a7eaf8','Y',0,'N','N','N','N')
;

-- Aug 21, 2026, 5:00:03 PM CEST
ALTER TABLE AD_WF_Node ADD COLUMN ScheduleExpression VARCHAR(2000) DEFAULT NULL
;

-- Aug 21, 2026, 5:00:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,XPosition,ColumnSpan,NumLines) VALUES (209240,'Schedule Expression','SQL expression that determines when a scheduled workflow activity resumes','The expression must start with @SQL= and return one timestamp. It is evaluated when the activity is created and again on every workflow processor run. Context variables are resolved from the workflow record.',(SELECT AD_Tab_ID FROM AD_Field WHERE AD_Field_ID=10088),217655,'Y','@Action@=S',60,225,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2026-08-21 17:00:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2026-08-21 17:00:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','e91cd828-31d2-46f5-9cf9-a4763e614d4f','N',1,5,3)
;
