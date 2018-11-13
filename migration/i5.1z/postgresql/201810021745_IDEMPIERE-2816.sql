-- Oct 2, 2018 5:20:14 PM CEST
-- IDEMPIERE-2816/IDEMPIERE-2351 Force background/foreground based on parameters
INSERT INTO AD_Element (AD_Element_ID,ColumnName,Help,Updated,Name,Description,PrintName,AD_Element_UU,IsActive,Created,CreatedBy,UpdatedBy,AD_Client_ID,EntityType,AD_Org_ID) VALUES (203268,'ExecutionType','Execution Type defines whether the report/process will always run in background or foreground. The System Configurator "BACKGROUND_JOB_ALLOWED" has greater precedence.',TO_TIMESTAMP('2018-10-02 17:20:14','YYYY-MM-DD HH24:MI:SS'),'Execution Type','Execution Type defines whether the report/process will always run in background or foreground. ','Execution Type','0132dcc1-96b3-427f-a057-de8a7616b2c4','Y',TO_TIMESTAMP('2018-10-02 17:20:14','YYYY-MM-DD HH24:MI:SS'),100,100,0,'D',0)
;

-- Oct 2, 2018 5:22:04 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,AD_Reference_UU,IsOrderByValue,Description,ValidationType,VFormat,Updated,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,EntityType,AD_Org_ID) VALUES (200157,'AD_Process Execution Type','1acef8a3-44b6-49c1-9309-d848829e3898','N','Report/Process Execution Type','L',NULL,TO_TIMESTAMP('2018-10-02 17:22:04','YYYY-MM-DD HH24:MI:SS'),'Y',100,100,0,TO_TIMESTAMP('2018-10-02 17:22:04','YYYY-MM-DD HH24:MI:SS'),'D',0)
;

-- Oct 2, 2018 5:22:47 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Description,AD_Ref_List_UU,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,Updated,EntityType,AD_Reference_ID,Value,AD_Org_ID) VALUES (200438,'It forces the report/process to always run on background. This can be useful for slow reports.','24e2cb33-193c-45ca-9281-fea9752bf59f','Force Background','Y',100,100,0,TO_TIMESTAMP('2018-10-02 17:22:46','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2018-10-02 17:22:46','YYYY-MM-DD HH24:MI:SS'),'D',200157,'B',0)
;

-- Oct 2, 2018 5:23:25 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Description,AD_Ref_List_UU,Name,IsActive,CreatedBy,UpdatedBy,AD_Client_ID,Created,Updated,EntityType,AD_Reference_ID,Value,AD_Org_ID) VALUES (200439,'It forces the report/process to always run on foreground.','9a4c7179-17f7-4fc0-9ccb-bdcdf36488a4','Force Foreground','Y',100,100,0,TO_TIMESTAMP('2018-10-02 17:23:24','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2018-10-02 17:23:24','YYYY-MM-DD HH24:MI:SS'),'D',200157,'F',0)
;

-- Oct 2, 2018 5:24:15 PM CEST
INSERT INTO AD_Column (AD_Column_ID,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsAlwaysUpdateable,AD_Client_ID,Created,IsSecure,EntityType,IsEncrypted,AD_Element_ID,AD_Reference_Value_ID,AD_Table_ID,AD_Reference_ID,IsToolbarButton,AD_Org_ID) VALUES (213698,'N',0,'N','N','N',0,'N',1,'N','N','N','Y','11fe0ed8-bdfb-47b6-9683-2acdc05f64f7',TO_TIMESTAMP('2018-10-02 17:24:14','YYYY-MM-DD HH24:MI:SS'),'Y','ExecutionType','Execution Type defines whether the report/process will always run in background or foreground. ','Execution Type defines whether the report/process will always run in background or foreground. The System Configurator "BACKGROUND_JOB_ALLOWED" has greater precedence.','Execution Type','Y','Y',100,100,'Y',0,TO_TIMESTAMP('2018-10-02 17:24:14','YYYY-MM-DD HH24:MI:SS'),'N','D','N',203268,200157,284,17,'N',0)
;

-- Oct 2, 2018 5:28:15 PM CEST
ALTER TABLE AD_Process ADD COLUMN ExecutionType CHAR(1) DEFAULT NULL 
;

-- Oct 2, 2018 5:28:56 PM CEST
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_Org_ID) VALUES (0,205836,'N',22,'N','N',270,'Y','N','Execution Type defines whether the report/process will always run in background or foreground. The System Configurator "BACKGROUND_JOB_ALLOWED" has greater precedence.',TO_TIMESTAMP('2018-10-02 17:28:55','YYYY-MM-DD HH24:MI:SS'),'Execution Type defines whether the report/process will always run in background or foreground. ','Execution Type','6283412f-702d-4a39-ae95-67a25ada2228','Y','N',100,100,'Y','Y',230,2,'N',0,TO_TIMESTAMP('2018-10-02 17:28:55','YYYY-MM-DD HH24:MI:SS'),2,1,'N','N',213698,'D',245,0)
;

-- Oct 2, 2018 5:29:18 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 17:29:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4540
;

-- Oct 2, 2018 5:29:18 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Val_Rule_ID=NULL, IsDisplayed='Y', XPosition=4, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 17:29:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205836
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2571
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12100
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3703
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2534
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10235
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56497
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3278
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=3219
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5849
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50155
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5850
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5851
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=240, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=50156
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=201809
;

-- Oct 2, 2018 2:31:45 PM CEST
UPDATE AD_Field SET SeqNo=260, AD_Val_Rule_ID=NULL, AD_Reference_Value_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-10-02 14:31:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=57342
;

SELECT register_migration_script('201810021745_IDEMPIERE-2816.sql') FROM dual
;


