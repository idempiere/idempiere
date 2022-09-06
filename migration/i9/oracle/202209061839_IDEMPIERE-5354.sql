-- IDEMPIERE-5354 Manage use case for microsoft OAuth2 preferred_username (FHCA-3757)
SELECT register_migration_script('202209061839_IDEMPIERE-5354.sql') FROM dual;

SET SQLBLANKLINES ON
SET DEFINE OFF

-- Sep 6, 2022, 6:39:31 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203652,0,0,'Y',TO_TIMESTAMP('2022-09-06 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 18:39:05','YYYY-MM-DD HH24:MI:SS'),100,'Preferred_UserName','Preferred User Name',NULL,NULL,'Preferred User Name','D','ebd1289c-1990-4830-a692-e25607b68e19')
;

-- Sep 6, 2022, 6:39:45 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215284,0,'Preferred User Name',200272,'Preferred_UserName',1000,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2022-09-06 18:39:45','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 18:39:45','YYYY-MM-DD HH24:MI:SS'),100,203652,'Y','Y','D','N','N','N','Y','fe8b3a07-abd5-45ff-b9a6-29dacc8999e8','Y',10,'N','N','N')
;

-- Sep 6, 2022, 6:39:52 PM CEST
ALTER TABLE AD_AuthorizationAccount ADD Preferred_UserName VARCHAR2(1000 CHAR) DEFAULT NULL 
;

-- Sep 6, 2022, 7:36:38 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207188,'Preferred User Name',200287,215284,'Y',1000,150,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-09-06 19:36:37','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-09-06 19:36:37','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','5949327f-b53c-4697-9883-1b967de1ba20','Y',120,5)
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206586
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206585
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207188
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206587
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206588
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206589
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206590
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206591
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206592
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206593
;

-- Sep 6, 2022, 7:37:20 PM CEST
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:37:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206594
;

-- Sep 6, 2022, 7:38:30 PM CEST
UPDATE AD_Field SET IsReadOnly='Y', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2022-09-06 19:38:30','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=207188
;

