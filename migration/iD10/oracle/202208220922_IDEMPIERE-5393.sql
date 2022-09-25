-- IDEMPIERE-5393
SELECT register_migration_script('202208220922_IDEMPIERE-5393.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 18, 2022, 11:13:06 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215099,0,'Status Line',50010,'AD_StatusLine_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-08-18 11:13:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-18 11:13:06','YYYY-MM-DD HH24:MI:SS'),100,202635,'Y','N','D','N','N','N','Y','6318c76d-e4e1-4846-a1e8-57d4c5a52df3','N',0,'N','N','N','N')
;

-- Aug 18, 2022, 11:13:15 AM CEST
UPDATE AD_Column SET FKConstraintName='ADStatusLine_PADashboardConten', FKConstraintType='N',Updated=TO_TIMESTAMP('2022-08-18 11:13:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215099
;

-- Aug 18, 2022, 11:13:15 AM CEST
ALTER TABLE PA_DashboardContent ADD AD_StatusLine_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 18, 2022, 11:13:15 AM CEST
ALTER TABLE PA_DashboardContent ADD CONSTRAINT ADStatusLine_PADashboardConten FOREIGN KEY (AD_StatusLine_ID) REFERENCES ad_statusline(ad_statusline_id) DEFERRABLE INITIALLY DEFERRED
;

-- Aug 18, 2022, 11:13:37 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207135,'Status Line',50010,215099,'Y',22,220,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-08-18 11:13:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-18 11:13:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','b855dcfe-397a-48a7-bebc-0903f6caf14e','Y',210,2)
;

-- Aug 18, 2022, 11:15:07 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-18 11:15:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207135
;

-- Aug 18, 2022, 11:15:07 AM CEST
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-18 11:15:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=56504
;

-- Aug 18, 2022, 11:15:07 AM CEST
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-18 11:15:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200268
;

-- Aug 18, 2022, 11:15:07 AM CEST
UPDATE AD_Field SET SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-18 11:15:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200260
;

-- Aug 18, 2022, 11:15:07 AM CEST
UPDATE AD_Field SET SeqNo=220, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-18 11:15:07','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202286
;

