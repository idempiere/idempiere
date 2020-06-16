SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4338  Enable Copy-Paste on fields
-- Jun 16, 2020, 2:17:00 PM CEST
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203418,0,0,'Y',TO_DATE('2020-06-16 14:15:02','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-16 14:15:02','YYYY-MM-DD HH24:MI:SS'),100,'IsMenuOnField','Context Menu on Field','Set the context menu on field, or just in label','When this flag is checked the context menu is set on fields as well as the label, when is unchecked, then the context menu is set just on the label.','Context Menu on Field','D','907540ac-3084-496e-832f-b2143b95a7a3')
;

-- Jun 16, 2020, 2:17:29 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214206,0,'Context Menu on Field','Set the context menu on field, or just in label','When this flag is checked the context menu is set on fields as well as the label, when is unchecked, then the context menu is set just on the label.',200174,'IsMenuOnField','Y',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_DATE('2020-06-16 14:17:29','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-16 14:17:29','YYYY-MM-DD HH24:MI:SS'),100,203418,'Y','N','D','N','N','N','Y','4eaf6c71-1771-4a17-bd2f-f58d7a11fe6f','Y',0,'N','N','N')
;

-- Jun 16, 2020, 2:17:32 PM CEST
ALTER TABLE AD_UserPreference ADD IsMenuOnField CHAR(1) DEFAULT 'Y' CHECK (IsMenuOnField IN ('Y','N')) NOT NULL
;

-- Jun 16, 2020, 2:17:53 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206413,'Context Menu on Field','Set the context menu on field, or just in label','When this flag is checked the context menu is set on fields as well as the label, when is unchecked, then the context menu is set just on the label.',200189,214206,'Y',1,160,'N','N','N','N',0,0,'Y',TO_DATE('2020-06-16 14:17:52','YYYY-MM-DD HH24:MI:SS'),100,TO_DATE('2020-06-16 14:17:52','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','16a8d76a-e873-4a75-bc91-5a0b20930b0d','Y',160,2,2)
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203798
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203796
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=60, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203797
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203800
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206413
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206133
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206134
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205303
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203913
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205304
;

-- Jun 16, 2020, 2:21:40 PM CEST
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_DATE('2020-06-16 14:21:40','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=206407
;

SELECT register_migration_script('202006161426_IDEMPIERE-4338.sql') FROM dual
;

