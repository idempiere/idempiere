SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-5232
-- Mar 15, 2022, 2:30:49 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214712,0,'Chart',107,'AD_Chart_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2022-03-15 14:30:49','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:30:49','YYYY-MM-DD HH24:MI:SS'),0,54268,'Y','N','D','N','N','N','Y','1f3620c0-0def-4180-a577-fc1e682ff8e6','Y',0,'N','N','N','N')
;

-- Mar 15, 2022, 2:30:50 PM CET
UPDATE AD_Column SET FKConstraintName='ADChart_ADField', FKConstraintType='N',Updated=TO_DATE('2022-03-15 14:30:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214712
;

-- Mar 15, 2022, 2:30:50 PM CET
ALTER TABLE AD_Field ADD AD_Chart_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 15, 2022, 2:30:50 PM CET
ALTER TABLE AD_Field ADD CONSTRAINT ADChart_ADField FOREIGN KEY (AD_Chart_ID) REFERENCES ad_chart(ad_chart_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 15, 2022, 2:31:08 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (214713,0,'Chart',464,'AD_Chart_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_DATE('2022-03-15 14:31:08','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:31:08','YYYY-MM-DD HH24:MI:SS'),0,54268,'Y','N','D','N','N','N','Y','bc6b9241-f8bf-49fb-8198-fcd53f80b047','Y',0,'N','N','N','N')
;

-- Mar 15, 2022, 2:31:09 PM CET
UPDATE AD_Column SET FKConstraintName='ADChart_ADUserDefField', FKConstraintType='N',Updated=TO_DATE('2022-03-15 14:31:09','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214713
;

-- Mar 15, 2022, 2:31:09 PM CET
ALTER TABLE AD_UserDef_Field ADD AD_Chart_ID NUMBER(10) DEFAULT NULL 
;

-- Mar 15, 2022, 2:31:09 PM CET
ALTER TABLE AD_UserDef_Field ADD CONSTRAINT ADChart_ADUserDefField FOREIGN KEY (AD_Chart_ID) REFERENCES ad_chart(ad_chart_id) DEFERRABLE INITIALLY DEFERRED
;

-- Mar 15, 2022, 2:31:24 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206914,'Chart',107,214712,'Y',22,510,'N','N','N','N',0,0,'Y',TO_DATE('2022-03-15 14:31:24','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:31:24','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','df23d2db-b8ab-4e63-af6f-f5283b907f72','Y',500,2)
;

-- Mar 15, 2022, 2:31:34 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=53370', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:31:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206914
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=450, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206914
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=460, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=53280
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=470, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203500
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=480, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200836
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=490, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200835
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=500, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=136
;

-- Mar 15, 2022, 2:32:10 PM CET
UPDATE AD_Field SET SeqNo=510, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=139
;

-- Mar 15, 2022, 2:32:22 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206915,'Chart',395,214713,'Y',22,390,'N','N','N','N',0,0,'Y',TO_DATE('2022-03-15 14:32:22','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2022-03-15 14:32:22','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','b1b92474-66d4-40b3-9623-31c776bc0c3f','Y',360,2)
;

-- Mar 15, 2022, 2:32:34 PM CET
UPDATE AD_Field SET DisplayLogic='@AD_Reference_ID@=53370', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:34','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206915
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206915
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200852
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=203499
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=200854
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=5051
;

-- Mar 15, 2022, 2:32:49 PM CET
UPDATE AD_Field SET SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2022-03-15 14:32:49','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=5057
;

-- Mar 15, 2022, 2:33:06 PM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ad_chart_id, c.ad_chart_id)',Updated=TO_DATE('2022-03-15 14:33:06','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ViewColumn_ID=200277
;

-- Mar 15, 2022, 2:33:19 PM CET
UPDATE AD_ViewColumn SET ColumnSQL='COALESCE(f.ad_chart_id, c.ad_chart_id)',Updated=TO_DATE('2022-03-15 14:33:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_ViewColumn_ID=200348
;

-- Mar 16, 2022, 7:09:20 AM CET
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-03-16 07:09:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=53284
;

-- Mar 16, 2022, 7:09:23 AM CET
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-03-16 07:09:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=200122
;

-- Mar 16, 2022, 7:09:28 AM CET
UPDATE AD_Table SET AccessLevel='6',Updated=TO_TIMESTAMP('2022-03-16 07:09:28','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Table_ID=53282
;

-- Mar 22, 2022, 4:27:04 PM CET
UPDATE AD_Tab SET IsAdvancedTab='Y',Updated=TO_TIMESTAMP('2022-03-22 16:27:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Tab_ID=53340
;

SELECT register_migration_script('202203151430_IDEMPIERE-5232.sql') FROM dual
;
