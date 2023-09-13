-- IDEMPIERE-5567 Support of UUID as Key (FHCA-4195)
SELECT register_migration_script('202309111844_IDEMPIERE-5567_ADPInstance.sql') FROM dual;

-- Sep 11, 2023, 6:44:35 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215912,0,'Table','Database Table information','The Database Table provides the information of the table definition',282,'AD_Table_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-09-11 18:44:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 18:44:34','YYYY-MM-DD HH24:MI:SS'),100,126,'Y','N','D','N','N','N','Y','2f7ad2ed-750c-40b9-b12a-8c47b58d3b42','Y',0,'N','N','N','N')
;

-- Sep 11, 2023, 6:45:53 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215913,0,'Record UUID',282,'Record_UU',36,'N','N','N','N','N',0,'N',200240,0,0,'Y',TO_TIMESTAMP('2023-09-11 18:45:52','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 18:45:52','YYYY-MM-DD HH24:MI:SS'),100,203804,'N','N','D','N','N','N','Y','a6104789-a5da-42e5-bfab-0c188630bbf1','Y',0,'N','N','D','N')
;

-- Sep 11, 2023, 6:46:17 PM CEST
UPDATE AD_Column SET AD_Reference_ID=200202, FKConstraintType='D',Updated=TO_TIMESTAMP('2023-09-11 18:46:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=2782
;

-- Sep 11, 2023, 6:46:29 PM CEST
UPDATE AD_Column SET IsUpdateable='N',Updated=TO_TIMESTAMP('2023-09-11 18:46:29','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215912
;

-- Sep 11, 2023, 6:48:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207720,'Name','Alphanumeric identifier of the entity','The name of an entity (record) is used as an default search option in addition to the search key. The name is up to 60 characters in length.',663,210890,'Y',60,170,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-09-11 18:48:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 18:48:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','bfef1933-138a-4c2e-a0f0-9b4e2f722939','Y',170,5)
;

-- Sep 11, 2023, 6:48:04 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207721,'Table','Database Table information','The Database Table provides the information of the table definition',663,215912,'Y',10,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-09-11 18:48:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 18:48:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','f271284f-7b1d-4e78-86b3-0433b4d4b5f4','Y',180,2)
;

-- Sep 11, 2023, 6:48:05 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207722,'Record UUID',663,215913,'Y',36,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-09-11 18:48:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-09-11 18:48:04','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','16d8bd0a-2133-4a94-99c9-c8f16bca5ced','Y',190,2)
;

-- Sep 11, 2023, 6:49:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, XPosition=1,Updated=TO_TIMESTAMP('2023-09-11 18:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207721
;

-- Sep 11, 2023, 6:49:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@=''''', SeqNo=70, XPosition=4,Updated=TO_TIMESTAMP('2023-09-11 18:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10494
;

-- Sep 11, 2023, 6:49:24 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@Record_UU@!''''', SeqNo=80, XPosition=4,Updated=TO_TIMESTAMP('2023-09-11 18:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207722
;

-- Sep 11, 2023, 6:49:24 PM CEST
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2023-09-11 18:49:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10497
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10500
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10501
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207416
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10495
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202845
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202847
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207405
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207407
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207406
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207408
;

-- Sep 11, 2023, 6:49:25 PM CEST
UPDATE AD_Field SET DisplayLogic='@Name@!''''', SeqNo=200,Updated=TO_TIMESTAMP('2023-09-11 18:49:25','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207720
;

-- Sep 12, 2023, 12:15:31 PM CEST
UPDATE AD_Column SET FKConstraintName='ADTable_ADPInstance', FKConstraintType='N',Updated=TO_TIMESTAMP('2023-09-12 12:15:31','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215912
;

-- Sep 12, 2023, 12:15:31 PM CEST
ALTER TABLE AD_PInstance ADD COLUMN AD_Table_ID NUMERIC(10) DEFAULT NULL 
;

-- Sep 12, 2023, 12:15:31 PM CEST
ALTER TABLE AD_PInstance ADD CONSTRAINT ADTable_ADPInstance FOREIGN KEY (AD_Table_ID) REFERENCES ad_table(ad_table_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 12, 2023, 12:15:56 PM CEST
ALTER TABLE AD_PInstance ADD COLUMN Record_UU VARCHAR(36) DEFAULT NULL 
;

-- Sep 12, 2023, 12:29:54 PM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Table_ID:0@>0',Updated=TO_TIMESTAMP('2023-09-12 12:29:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207721
;

-- Sep 12, 2023, 3:40:47 PM CEST
UPDATE AD_Field SET DisplayLogic='(@Record_UU@='''' & @Record_ID@>0) | (@Record_UU@='''' & @AD_Table_ID@>0)',Updated=TO_TIMESTAMP('2023-09-12 15:40:47','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10494
;

-- set AD_Table_ID from related column
CREATE INDEX tmp_deleteme20230912 ON AD_Column (AD_Process_ID);

UPDATE AD_PInstance
SET AD_Table_ID = (SELECT DISTINCT AD_Table_ID FROM AD_Column WHERE AD_Column.AD_Process_ID=AD_PInstance.AD_Process_ID)
WHERE Record_ID > 0 AND AD_Table_ID IS NULL
AND (SELECT COUNT(DISTINCT AD_Table_ID) FROM AD_Column WHERE AD_Column.AD_Process_ID=AD_PInstance.AD_Process_ID) = 1;

DROP INDEX tmp_deleteme20230912;

-- set AD_Table_ID from related toolbar button
UPDATE AD_PInstance
SET AD_Table_ID = (SELECT DISTINCT AD_Tab.AD_Table_ID FROM AD_ToolbarButton JOIN AD_Tab ON (AD_Tab.AD_Tab_ID=AD_ToolbarButton.AD_Tab_ID) WHERE AD_ToolbarButton.AD_Process_ID=AD_PInstance.AD_Process_ID)
WHERE Record_ID > 0 AND AD_Table_ID IS NULL
AND (SELECT COUNT(DISTINCT AD_Tab.AD_Table_ID) FROM AD_ToolbarButton JOIN AD_Tab ON (AD_Tab.AD_Tab_ID=AD_ToolbarButton.AD_Tab_ID) WHERE AD_ToolbarButton.AD_Process_ID=AD_PInstance.AD_Process_ID) = 1;

-- set AD_Table_ID from hardcoded reports
UPDATE AD_PInstance SET AD_Table_ID = 259 /* C_Order */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 110 /* Rpt C_Order */;

UPDATE AD_PInstance SET AD_Table_ID = 318 /* C_Invoice */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 116 /* Rpt C_Invoice */;

UPDATE AD_PInstance SET AD_Table_ID = 319 /* M_InOut */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 117 /* Rpt M_InOut */;

UPDATE AD_PInstance SET AD_Table_ID = 301 /* C_Dunning */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 159 /* Rpt C_Dunning */;

UPDATE AD_PInstance SET AD_Table_ID = 203 /* C_Project */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 217 /* Rpt C_Project */;

UPDATE AD_PInstance SET AD_Table_ID = 674 /* C_RfQResponse */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 276 /* Rpt C_RfQResponse */;

UPDATE AD_PInstance SET AD_Table_ID = 727 /* M_InOutConfirm */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 292 /* Rpt M_InOutConfirm */;

UPDATE AD_PInstance SET AD_Table_ID = 335 /* C_Payment */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 313 /* Rpt C_Payment */;

UPDATE AD_PInstance SET AD_Table_ID = 53027 /* PP_Order */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 53028 /* Rpt PP_Order */;

UPDATE AD_PInstance SET AD_Table_ID = 53037 /* DD_Order */ WHERE Record_ID > 0 AND AD_Table_ID IS NULL AND AD_Process_ID = 53044 /* Rpt DD_Order */;

-- set AD_Table_ID from report view
UPDATE AD_PInstance
SET AD_Table_ID = (SELECT AD_ReportView.AD_Table_ID FROM AD_ReportView JOIN AD_Process ON (AD_Process.AD_ReportView_ID=AD_ReportView.AD_ReportView_ID) WHERE AD_Process.AD_Process_ID=AD_PInstance.AD_Process_ID)
WHERE Record_ID > 0 AND AD_Table_ID IS NULL
AND EXISTS (SELECT AD_ReportView.AD_Table_ID FROM AD_ReportView JOIN AD_Process ON (AD_Process.AD_ReportView_ID=AD_ReportView.AD_ReportView_ID) WHERE AD_Process.AD_Process_ID=AD_PInstance.AD_Process_ID);

-- set AD_Table_ID from table of print format
UPDATE AD_PInstance
SET AD_Table_ID = (SELECT AD_PrintFormat.AD_Table_ID FROM AD_PrintFormat JOIN AD_Process ON (AD_Process.AD_PrintFormat_ID=AD_PrintFormat.AD_PrintFormat_ID) WHERE AD_Process.AD_Process_ID=AD_PInstance.AD_Process_ID AND AD_PrintFormat.AD_Table_ID > 0)
WHERE Record_ID > 0 AND AD_Table_ID IS NULL
AND EXISTS (SELECT AD_PrintFormat.AD_Table_ID FROM AD_PrintFormat JOIN AD_Process ON (AD_Process.AD_PrintFormat_ID=AD_PrintFormat.AD_PrintFormat_ID) WHERE AD_Process.AD_Process_ID=AD_PInstance.AD_Process_ID AND AD_PrintFormat.AD_Table_ID > 0);

-- set AD_Table_ID from table of jasper print format
UPDATE AD_PInstance
SET AD_Table_ID = (SELECT DISTINCT AD_PrintFormat.AD_Table_ID FROM AD_PrintFormat JOIN AD_Process ON (AD_PrintFormat.JasperProcess_ID=AD_Process.AD_Process_ID) WHERE AD_Process.AD_Process_ID=AD_PInstance.AD_Process_ID AND AD_PrintFormat.AD_Table_ID > 0)
WHERE Record_ID > 0 AND AD_Table_ID IS NULL
AND (SELECT COUNT(DISTINCT AD_PrintFormat.AD_Table_ID) FROM AD_PrintFormat JOIN AD_Process ON (AD_PrintFormat.JasperProcess_ID=AD_Process.AD_Process_ID) WHERE AD_Process.AD_Process_ID=AD_PInstance.AD_Process_ID AND AD_PrintFormat.AD_Table_ID > 0) = 1;

-- set AD_Table_ID from info window process
UPDATE AD_PInstance
SET AD_Table_ID = (SELECT AD_InfoWindow.AD_Table_ID FROM AD_InfoProcess JOIN AD_InfoWindow ON (AD_InfoProcess.AD_InfoWindow_ID=AD_InfoWindow.AD_InfoWindow_ID) WHERE AD_InfoProcess.AD_Process_ID=AD_PInstance.AD_Process_ID)
WHERE Record_ID > 0 AND AD_Table_ID IS NULL
AND EXISTS (SELECT AD_InfoWindow.AD_Table_ID FROM AD_InfoProcess JOIN AD_InfoWindow ON (AD_InfoProcess.AD_InfoWindow_ID=AD_InfoWindow.AD_InfoWindow_ID) WHERE AD_InfoProcess.AD_Process_ID=AD_PInstance.AD_Process_ID);

