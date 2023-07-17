-- IDEMPIERE-5772
SELECT register_migration_script('202306190914_IDEMPIERE-5772.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Jun 19, 2023, 9:14:41 AM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (215853,0,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200108,'AD_InfoWindow_ID',22,'N','N','N','N','N',0,'N',19,0,0,'Y',TO_TIMESTAMP('2023-06-19 09:14:40','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-19 09:14:40','YYYY-MM-DD HH24:MI:SS'),100,3068,'Y','N','D','N','N','N','Y','78d7ed91-8563-461a-ab16-39e62c393e78','Y',0,'N','N','C','N')
;

-- Jun 19, 2023, 9:14:44 AM CEST
UPDATE AD_Column SET FKConstraintName='ADInfoWindow_ADStatusLineUsedI', FKConstraintType='C',Updated=TO_TIMESTAMP('2023-06-19 09:14:44','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215853
;

-- Jun 19, 2023, 9:14:44 AM CEST
ALTER TABLE AD_StatusLineUsedIn ADD AD_InfoWindow_ID NUMBER(10) DEFAULT NULL 
;

-- Jun 19, 2023, 9:14:44 AM CEST
ALTER TABLE AD_StatusLineUsedIn ADD CONSTRAINT ADInfoWindow_ADStatusLineUsedI FOREIGN KEY (AD_InfoWindow_ID) REFERENCES ad_infowindow(ad_infowindow_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED
;

-- Jun 19, 2023, 9:15:04 AM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207654,'Info Window','Info and search/select Window','The Info window is used to search and select records as well as display information relevant to the selection.',200115,215853,'Y',22,110,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-06-19 09:15:03','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2023-06-19 09:15:03','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','2ab90c17-a77d-4b89-bc17-17dc3f7b775d','Y',80,2)
;

-- Jun 19, 2023, 9:22:16 AM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Window_ID@=0 & @AD_InfoWindow_ID@=0', SeqNo=40,Updated=TO_TIMESTAMP('2023-06-19 09:22:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202573
;

-- Jun 19, 2023, 9:22:16 AM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Table_ID@=0 & @AD_InfoWindow_ID@=0', SeqNo=60,Updated=TO_TIMESTAMP('2023-06-19 09:22:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202574
;

-- Jun 19, 2023, 9:22:16 AM CEST
UPDATE AD_Field SET DisplayLogic='@AD_Table_ID@=0 & @AD_InfoWindow_ID@=0', SeqNo=70,Updated=TO_TIMESTAMP('2023-06-19 09:22:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202575
;

-- Jun 19, 2023, 9:22:16 AM CEST
UPDATE AD_Field SET IsDisplayed='Y', DisplayLogic='@AD_Table_ID@=0 & @AD_Window_ID@=0', SeqNo=80, XPosition=1,Updated=TO_TIMESTAMP('2023-06-19 09:22:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207654
;

-- Jun 19, 2023, 9:22:16 AM CEST
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2023-06-19 09:22:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202576
;

-- Jun 19, 2023, 9:22:16 AM CEST
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2023-06-19 09:22:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202578
;

-- Jul 13, 2023, 6:38:30 PM CEST
UPDATE AD_Column SET DefaultValue='NULL',Updated=TO_TIMESTAMP('2023-07-13 18:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215853
;
