-- IDEMPIERE-4713 Allow definition of context variables to inject on menu and window definition
-- Feb 19, 2021, 7:13:25 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203475,0,0,'Y',TO_TIMESTAMP('2021-02-19 19:12:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-19 19:12:32','YYYY-MM-DD HH24:MI:SS'),100,'PredefinedContextVariables','Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',NULL,'Predefined Context Variables','D','901ebd74-5da3-4686-b327-8e759a72b544')
;

-- Feb 19, 2021, 7:15:30 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214411,0,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',116,'PredefinedContextVariables',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-19 19:15:29','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-19 19:15:29','YYYY-MM-DD HH24:MI:SS'),100,203475,'Y','N','D','N','N','N','Y','0863f890-c2be-44a8-88cd-9772d1c2e5d2','Y',0,'N','N','N')
;

-- Feb 19, 2021, 7:15:59 PM CET
ALTER TABLE AD_Menu ADD COLUMN PredefinedContextVariables VARCHAR(4000) DEFAULT NULL 
;

-- Feb 19, 2021, 7:16:18 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206595,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',110,214411,'Y',4000,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-19 19:16:18','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-19 19:16:18','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b2f36f4b-1058-4f1c-a55c-be9cbd00a363','Y',190,5)
;

-- Feb 19, 2021, 7:16:52 PM CET
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-19 19:16:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206595
;

-- Feb 19, 2021, 7:17:35 PM CET
UPDATE AD_Field SET DisplayLogic='@IsSummary@=N', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-19 19:17:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206595
;

-- Feb 19, 2021, 7:18:18 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214412,0,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',105,'PredefinedContextVariables',4000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2021-02-19 19:18:17','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-19 19:18:17','YYYY-MM-DD HH24:MI:SS'),100,203475,'Y','N','D','N','N','N','Y','56b9d393-46d3-468b-bdcd-0c5a6088aed4','Y',0,'N','N','N','N')
;

-- Feb 19, 2021, 7:18:39 PM CET
ALTER TABLE AD_Window ADD COLUMN PredefinedContextVariables VARCHAR(4000) DEFAULT NULL 
;

-- Feb 19, 2021, 7:19:45 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206596,'Predefined Context Variables','Predefined context variables to inject when opening a menu entry or a window',105,214412,'Y',4000,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2021-02-19 19:19:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2021-02-19 19:19:45','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','8d645d35-c38f-4c73-a0ab-dfe85f3777b6','Y',160,5)
;

-- Feb 19, 2021, 7:20:00 PM CET
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-19 19:20:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206596
;

-- Feb 19, 2021, 7:20:00 PM CET
UPDATE AD_Field SET SeqNo=0, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-19 19:20:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202514
;

-- Feb 19, 2021, 8:51:44 PM CET
UPDATE AD_Field SET DisplayLogic='@IsSummary@=N & @Action@!T & @Action@!F', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2021-02-19 20:51:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206595
;

SELECT register_migration_script('202102191922_IDEMPIERE-4713.sql') FROM dual
;

