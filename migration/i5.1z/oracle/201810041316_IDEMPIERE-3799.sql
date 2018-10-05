SET SQLBLANKLINES ON
SET DEFINE OFF

-- Oct 2, 2018 6:52:02 PM CEST
-- IDEMPIERE-3799 Avoid users re-running a report that is already being processed
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203269,'AllowMultipleExecution','1. Disallow multiple executions: Never allow to execute a process that is already running.
2. Disallow multiple executions with the same parameters: Allow to execute a process multiple times with different parameters.
3. When blank: Always allow to execute a process multiple times.',TO_DATE('2018-10-02 18:52:01','YYYY-MM-DD HH24:MI:SS'),'Multiple Execution','Allow or disallow executing a process/report multiple times.','Multiple Execution','f8a79725-bf46-4682-aba8-4c1191ba9ddc','Y',TO_DATE('2018-10-02 18:52:01','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Oct 2, 2018 6:53:12 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,Description,ValidationType,VFormat,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType,AD_Org_ID) VALUES (200158,'AD_Process Multiple Execution','e08cde11-cfd5-45e8-9813-0e3005269c97','N','Multiple execution rule list','L',NULL,TO_DATE('2018-10-02 18:53:11','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_DATE('2018-10-02 18:53:11','YYYY-MM-DD HH24:MI:SS'),'D',0)
;

-- Oct 2, 2018 6:53:40 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Description,AD_Ref_List_UU,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,Updated,EntityType,AD_Reference_ID,Value,AD_Org_ID) VALUES (200440,'Never allow to execute a process that is already running','cd374cc2-e928-4e76-a376-9021ec5f31e7','Disallow multiple executions','Y',100,100,0,TO_DATE('2018-10-02 18:53:39','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-10-02 18:53:39','YYYY-MM-DD HH24:MI:SS'),'D',200158,'N',0)
;

-- Oct 2, 2018 6:53:58 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Description,AD_Ref_List_UU,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,Updated,EntityType,AD_Reference_ID,Value,AD_Org_ID) VALUES (200441,'Allow to execute a process multiple times with different parameters.','1dcb3178-d9f5-449e-9592-5e6e29453cf1','Disallow multiple executions with the same parameters','Y',100,100,0,TO_DATE('2018-10-02 18:53:57','YYYY-MM-DD HH24:MI:SS'),TO_DATE('2018-10-02 18:53:57','YYYY-MM-DD HH24:MI:SS'),'D',200158,'P',0)
;

-- Oct 2, 2018 6:58:23 PM CEST
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,DefaultValue,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID) VALUES (213699,'N',0,'N','N','N',0,'N',1,'N','N','N','Y','2996d521-d5f3-4b8f-b93d-fab92a71b406',TO_DATE('2018-10-02 18:58:23','YYYY-MM-DD HH24:MI:SS'),'Y','AllowMultipleExecution','Allow or disallow executing a process/report multiple times.','P','1. Disallow multiple executions: Never allow to execute a process that is already running.
2. Disallow multiple executions with the same parameters: Allow to execute a process multiple times with different parameters.
3. When blank: Always allow to execute a process multiple times.','Multiple Execution','Y','Y',100,100,'Y',0,TO_DATE('2018-10-02 18:58:23','YYYY-MM-DD HH24:MI:SS'),'N','D','N',203269,200158,284,17,'N',0)
;

-- Oct 2, 2018 6:58:37 PM CEST
ALTER TABLE AD_Process ADD AllowMultipleExecution CHAR(1) DEFAULT 'P'
;

-- Oct 2, 2018 7:00:24 PM CEST
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205837,'N',0,'N','N',270,'Y','N','1. Disallow multiple executions: Never allow to execute a process that is already running.
2. Disallow multiple executions with the same parameters: Allow to execute a process multiple times with different parameters.
3. When blank: Always allow to execute a process multiple times.',TO_DATE('2018-10-02 19:00:23','YYYY-MM-DD HH24:MI:SS'),'Allow or disallow executing a process/report multiple times.','Multiple Execution','f4a81a10-57ca-459f-bb21-a17812a75381','Y','N',100,100,'Y','Y',240,1,'N',0,TO_DATE('2018-10-02 19:00:23','YYYY-MM-DD HH24:MI:SS'),1,1,'N','N',213699,'D',245,0)
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=4, ColumnSpan=2, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205837
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4540
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205836
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2571
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12100
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3703
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2534
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10235
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56497
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3278
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3219
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5849
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50155
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5850
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=240, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5851
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50156
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=260, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201809
;

-- Oct 2, 2018 7:03:16 PM CEST
UPDATE AD_Field SET SeqNo=270, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2018-10-02 19:03:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57342
;

-- Oct 2, 2018 7:05:07 PM CEST
INSERT INTO AD_Message (MsgType,MsgText,AD_Message_ID,AD_Message_UU,Updated,IsActive,CreatedBy,AD_Client_ID,Created,UpdatedBy,EntityType,Value,AD_Org_ID) VALUES ('I','Another instance of this process is already running, please wait until it finishes to run it again.',200483,'db33903f-5eb2-4585-be6f-9a6bcae3940e',TO_DATE('2018-10-02 19:05:06','YYYY-MM-DD HH24:MI:SS'),'Y',100,0,TO_DATE('2018-10-02 19:05:06','YYYY-MM-DD HH24:MI:SS'),100,'D','ProcessAlreadyRunning',0)
;

-- Oct 4, 2018 4:52:16 PM CEST
UPDATE AD_Process SET allowMultipleExecution = NULL WHERE isReport ='N'
;

-- Oct 4, 2018 4:52:16 PM CEST
UPDATE AD_Process SET allowMultipleExecution = 'P' WHERE isReport ='Y'
;

SELECT register_migration_script('201810041316_IDEMPIERE-3799.sql') FROM dual
;
