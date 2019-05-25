-- IDEMPIERE-2850
-- May 20, 2019, 9:32:31 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,PrintName,EntityType,AD_Element_UU) VALUES (203337,0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:30','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:30','YYYY-MM-DD HH24:MI:SS'),100,'ReportOutputType','Report Output Type','Report Output Type','D','cd782f63-e5c5-4f12-8925-4b13733002b8')
;

-- May 20, 2019, 9:32:31 PM CEST
INSERT INTO AD_Reference (AD_Reference_ID,Name,ValidationType,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,IsOrderByValue,AD_Reference_UU) VALUES (200169,'ReportOutputType','L',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:31','YYYY-MM-DD HH24:MI:SS'),100,'D','N','b6fc4bb2-ce72-4de3-b753-302da5fd1173')
;

-- May 20, 2019, 9:32:32 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200470,'PDF',200169,'PDF',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:31','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:31','YYYY-MM-DD HH24:MI:SS'),100,'D','303c23cc-5dcf-4f5a-a105-8b62f856165a')
;

-- May 20, 2019, 9:32:32 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200471,'HTML',200169,'HTML',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:32','YYYY-MM-DD HH24:MI:SS'),100,'D','67cf2cdf-75a2-441c-ab33-12033e121e69')
;

-- May 20, 2019, 9:32:32 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200472,'Excel',200169,'XLS',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:32','YYYY-MM-DD HH24:MI:SS'),100,'D','0190b839-041b-43ae-a5f5-a52efb120e9d')
;

-- May 20, 2019, 9:32:33 PM CEST
INSERT INTO AD_Ref_List (AD_Ref_List_ID,Name,AD_Reference_ID,Value,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Ref_List_UU) VALUES (200473,'CSV',200169,'CSV',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:32','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:32','YYYY-MM-DD HH24:MI:SS'),100,'D','e0aa166a-b354-46d5-8a60-e2e21bf49f44')
;

-- May 20, 2019, 9:32:33 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Reference_Value_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType) VALUES (213942,1,'Report Output Type',688,'ReportOutputType',4,'N','N','N','N','N',0,'N',17,200169,0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:33','YYYY-MM-DD HH24:MI:SS'),100,203337,'Y','N','D','Y','N','N','Y','45acf545-7427-4c34-a6a5-c74b10ebb13b','Y',0,'N','N','N')
;

-- May 20, 2019, 9:32:33 PM CEST
ALTER TABLE AD_Scheduler ADD COLUMN ReportOutputType VARCHAR(4) DEFAULT NULL 
;

-- May 20, 2019, 9:32:33 PM CEST
INSERT INTO AD_Val_Rule (AD_Val_Rule_ID,Name,Type,Code,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,EntityType,AD_Val_Rule_UU) VALUES (200135,'PrintFormat for Process','S','AD_PrintFormat.AD_Table_ID IN (select coalesce(rv.ad_table_id,pp.ad_table_id) from ad_process p left join ad_reportview rv on p.ad_reportview_id=rv.ad_reportview_id left join ad_printformat pp on p.ad_printformat_id=pp.ad_printformat_id where p.ad_process_id=@AD_Process_ID@)',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:33','YYYY-MM-DD HH24:MI:SS'),100,'D','5b2362f8-10ed-4b0d-b636-c47b7cd15b78')
;

-- May 20, 2019, 9:32:34 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,AD_Val_Rule_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintName,FKConstraintType) VALUES (213943,0,'Print Format','Data Print Format','The print format determines how data is rendered for print.',688,200135,'AD_PrintFormat_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:33','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:33','YYYY-MM-DD HH24:MI:SS'),100,1790,'Y','N','D','Y','N','N','Y','81d67ace-8a49-403c-bc6f-5604d944cfd8','Y',0,'N','N','ADPrintFormat_ADScheduler','S')
;

-- May 20, 2019, 9:32:34 PM CEST
ALTER TABLE AD_Scheduler ADD COLUMN AD_PrintFormat_ID NUMERIC(10) DEFAULT NULL 
;

-- May 20, 2019, 9:32:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206075,'Print Format','Data Print Format','The print format determines how data is rendered for print.',589,213943,'Y','@AD_Process_ID.IsReport@=Y',0,64,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bc1c07e4-3306-466c-a14b-144eaf6c900e','Y',64,4,2,1,'N','N','N')
;

-- May 20, 2019, 9:32:34 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLogic,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (206076,'Report Output Type',589,213942,'Y','@AD_Process_ID.IsReport@=Y',0,65,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-05-20 21:32:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-05-20 21:32:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','43f6c13e-6eb0-4a22-b293-49f980f40098','Y',65,1,1,1,'N','N','N')
;

-- May 20, 2019, 9:32:35 PM CEST
ALTER TABLE AD_Scheduler ADD CONSTRAINT ADPrintFormat_ADScheduler FOREIGN KEY (AD_PrintFormat_ID) REFERENCES ad_printformat(ad_printformat_id) ON DELETE SET NULL DEFERRABLE INITIALLY DEFERRED
;

-- May 21, 2019, 1:03:56 PM CEST
UPDATE AD_SysConfig SET Description='Type of output in zkwebui for reports of type form, possible values are PDF, HTML, XLS, CSV',Updated=TO_TIMESTAMP('2019-05-21 13:03:56','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200002
;

-- May 21, 2019, 1:04:10 PM CEST
UPDATE AD_SysConfig SET Description='Type of output in zkwebui for reports of type table, possible values are PDF, HTML, XLS, CSV',Updated=TO_TIMESTAMP('2019-05-21 13:04:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200003
;

-- May 21, 2019, 1:04:51 PM CEST
UPDATE AD_SysConfig SET Description='Type of output in zkwebui for jasper reports, possible values are PDF, HTML, XLS, CSV, SSV',Updated=TO_TIMESTAMP('2019-05-21 13:04:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_SysConfig_ID=200030
;

-- May 21, 2019, 2:59:39 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Process_ID.IsReport@=Y & @AD_Process_ID.JasperReport=''''', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-05-21 14:59:39','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206075
;

SELECT register_migration_script('201905202132_IDEMPIERE-2850.sql') FROM dual
;

