SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4459
-- Sep 16, 2020, 4:15:42 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214314,0,'User defined Info Window',200268,'AD_UserDef_Info_ID',22,'N','Y','Y','N','N',0,'N',19,0,0,'Y',TO_DATE('2020-09-16 16:15:42','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-16 16:15:42','YYYY-MM-DD HH24:MI:SS'),100,203433,'N','N','D','N','N','N','Y','8758377a-2340-4fb1-9f59-9949d1a3dcab','Y',0,'N','N','N','N')
;

-- Sep 16, 2020, 4:15:51 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADUserDefInfo_ADUserDefInfoCol', FKConstraintType='N',Updated=TO_DATE('2020-09-16 16:15:51','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214314
;

-- Sep 16, 2020, 4:15:51 PM CEST
ALTER TABLE AD_UserDef_Info_Column ADD AD_UserDef_Info_ID NUMBER(10) NOT NULL
;

-- Sep 16, 2020, 4:16:20 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADUserDefInfo_ADUserDefInfoCol', FKConstraintType='N',Updated=TO_DATE('2020-09-16 16:16:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214314
;

-- Sep 16, 2020, 4:16:20 PM CEST
ALTER TABLE AD_UserDef_Info_Column ADD CONSTRAINT ADUserDefInfo_ADUserDefInfoCol FOREIGN KEY (AD_UserDef_Info_ID) REFERENCES ad_userdef_info(ad_userdef_info_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 16, 2020, 4:17:17 PM CEST
UPDATE AD_Column SET IsParent='Y', IsUpdateable='N',Updated=TO_DATE('2020-09-16 16:17:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214254
;

-- Sep 16, 2020, 4:17:22 PM CEST
UPDATE AD_Column SET IsUpdateable='N', FKConstraintName='ADUserDefInfo_ADUserDefInfoRel', FKConstraintType='N',Updated=TO_DATE('2020-09-16 16:17:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214254
;

-- Sep 16, 2020, 4:17:22 PM CEST
ALTER TABLE AD_UserDef_Info_Related MODIFY AD_UserDef_Info_ID NUMBER(10)
;

-- Sep 16, 2020, 4:17:22 PM CEST
ALTER TABLE AD_UserDef_Info_Related ADD CONSTRAINT ADUserDefInfo_ADUserDefInfoRel FOREIGN KEY (AD_UserDef_Info_ID) REFERENCES ad_userdef_info(ad_userdef_info_id) DEFERRABLE INITIALLY DEFERRED
;

-- Sep 16, 2020, 4:19:49 PM CEST
UPDATE AD_Column SET DefaultValue='@AD_UserDef_Info_ID@', IsUpdateable='N',Updated=TO_DATE('2020-09-16 16:19:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214314
;

-- Sep 16, 2020, 4:24:24 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206506,'User defined Info Window',200279,214314,'Y',22,300,'N','N','N','N',0,0,'Y',TO_DATE('2020-09-16 16:24:23','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-09-16 16:24:23','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','166e9f9d-d7ec-478c-bb64-54e4c7355f8a','Y',370,2)
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=30, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206506
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206437
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206433
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206434
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206435
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206469
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206443
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206441
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206455
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206442
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206464
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206449
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206462
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206450
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206460
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206467
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206468
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206465
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206445
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206448
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=230, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206447
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=240, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206453
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206452
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206456
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206458
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206459
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206457
;

-- Sep 16, 2020, 4:24:44 PM CEST
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206466
;

-- Sep 16, 2020, 4:25:01 PM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:25:01','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206506
;

-- Sep 16, 2020, 4:33:34 PM CEST
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2020-09-16 16:33:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214287
;

-- Sep 16, 2020, 4:33:35 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsDisplayed CHAR(1) DEFAULT 'Y'
;

-- Sep 16, 2020, 4:33:36 PM CEST
UPDATE AD_UserDef_Info_Column SET IsDisplayed='Y' WHERE IsDisplayed IS NULL
;

-- Sep 16, 2020, 4:34:04 PM CEST
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2020-09-16 16:34:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214307
;

-- Sep 16, 2020, 4:34:05 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsMandatory CHAR(1)
;

-- Sep 16, 2020, 4:34:30 PM CEST
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2020-09-16 16:34:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214288
;

-- Sep 16, 2020, 4:34:31 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsQueryCriteria CHAR(1)
;

-- Sep 16, 2020, 4:35:36 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206443
;

-- Sep 16, 2020, 4:35:36 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206442
;

-- Sep 16, 2020, 4:35:36 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2020-09-16 16:35:36','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206462
;

-- Sep 16, 2020, 4:35:54 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2020-09-16 16:35:54','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214288
;

-- Sep 16, 2020, 4:35:57 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsQueryCriteria CHAR(1) DEFAULT NULL 
;

-- Sep 16, 2020, 4:35:57 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsQueryCriteria NULL
;

-- Sep 16, 2020, 4:36:12 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2020-09-16 16:36:12','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214307
;

-- Sep 16, 2020, 4:36:13 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsMandatory CHAR(1) DEFAULT NULL 
;

-- Sep 16, 2020, 4:36:13 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsMandatory NULL
;

-- Sep 16, 2020, 4:36:27 PM CEST
UPDATE AD_Column SET IsMandatory='N',Updated=TO_DATE('2020-09-16 16:36:27','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214287
;

-- Sep 16, 2020, 4:36:28 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsDisplayed CHAR(1) DEFAULT 'Y'
;

-- Sep 16, 2020, 4:36:28 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsDisplayed NULL
;

-- Sep 16, 2020, 4:37:00 PM CEST
UPDATE AD_Column SET DefaultValue=NULL, AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2020-09-16 16:37:00','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214264
;

-- Sep 16, 2020, 4:37:01 PM CEST
ALTER TABLE AD_UserDef_Info_Related MODIFY IsDisplayed CHAR(1) DEFAULT NULL 
;

-- Sep 16, 2020, 4:37:08 PM CEST
UPDATE AD_Column SET DefaultValue=NULL,Updated=TO_DATE('2020-09-16 16:37:08','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=214287
;

-- Sep 16, 2020, 4:37:09 PM CEST
ALTER TABLE AD_UserDef_Info_Column MODIFY IsDisplayed CHAR(1) DEFAULT NULL 
;

SELECT register_migration_script('202009161615_IDEMPIERE-4459.sql') FROM dual
;
