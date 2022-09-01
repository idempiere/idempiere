-- IDEMPIERE-5396 Replace CreateFrom form with Info Window Process
SELECT register_migration_script('202208291623_IDEMPIERE-5396.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Aug 29, 2022, 4:23:16 PM SGT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215101,0,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',284,'AD_InfoWindow_ID',10,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2022-08-29 16:23:04','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-29 16:23:04','YYYY-MM-DD HH24:MI:SS'),100,3068,'N','N','D','N','N','N','Y','63b0ad3b-7b85-4b22-8061-64bd18c6dd49','Y','N','N','C','N')
;

-- Aug 29, 2022, 4:24:26 PM SGT
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2022-08-29 16:24:26','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215101
;

-- Aug 29, 2022, 4:24:44 PM SGT
UPDATE AD_Column SET FKConstraintName='ADInfoWindow_ADProcess', FKConstraintType='C',Updated=TO_TIMESTAMP('2022-08-29 16:24:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215101
;

-- Aug 29, 2022, 4:24:44 PM SGT
ALTER TABLE AD_Process ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Aug 29, 2022, 4:24:44 PM SGT
ALTER TABLE AD_Process ADD CONSTRAINT ADInfoWindow_ADProcess FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Aug 29, 2022, 4:26:00 PM SGT
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207137,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',245,215101,'Y',10,280,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-08-29 16:25:59','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-08-29 16:25:59','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','7d26d2ae-1bdd-4f64-9d60-177e651e6691','Y',260,2)
;

-- Aug 29, 2022, 4:27:42 PM SGT
UPDATE AD_Field SET SeqNo=172, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, SeqNoGrid=142, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-08-29 16:27:42','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207137
;

