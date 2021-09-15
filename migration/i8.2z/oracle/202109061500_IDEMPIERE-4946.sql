SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4926
-- Sep 6, 2021, 2:41:16 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214582,0,'Show in Dashboard','Show the dashlet in the dashboard',200266,'IsShowInDashboard',NULL,1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_DATE('2021-09-06 14:41:16','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-06 14:41:16','YYYY-MM-DD HH24:MI:SS'),0,200074,'Y','N','D','N','N','N','Y','1a35ffc9-8410-4c49-a1f9-199b7f63ad43','Y',0,'N','N','N')
;

-- Sep 6, 2021, 2:41:18 PM CEST
ALTER TABLE AD_UserDef_Info ADD IsShowInDashboard CHAR(1) DEFAULT NULL  CHECK (IsShowInDashboard IN ('Y','N'))
;

-- Sep 6, 2021, 2:41:32 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214583,0,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200266,'SeqNo','0',22,'N','N','Y','N','N',0,'N',11,0,0,'Y',TO_DATE('2021-09-06 14:41:32','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-06 14:41:32','YYYY-MM-DD HH24:MI:SS'),0,566,'Y','N','D','N','N','N','Y','0fff6c69-6a1c-4a1f-94e7-ace7f8de2d67','Y',0,'N','N','N')
;

-- Sep 6, 2021, 2:41:34 PM CEST
ALTER TABLE AD_UserDef_Info ADD SeqNo NUMBER(10) DEFAULT 0 NOT NULL
;

-- Sep 6, 2021, 2:41:46 PM CEST
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (214584,0,'Image URL','URL of  image','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.',200266,'ImageURL',120,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_DATE('2021-09-06 14:41:45','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-06 14:41:45','YYYY-MM-DD HH24:MI:SS'),0,1720,'Y','N','D','N','N','N','Y','3fbb45d7-e7e1-46b2-ab01-abd3a649a086','Y',0,'N','N','N')
;

-- Sep 6, 2021, 2:41:47 PM CEST
ALTER TABLE AD_UserDef_Info ADD ImageURL VARCHAR2(120 CHAR) DEFAULT NULL 
;

-- Sep 6, 2021, 2:41:56 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (206744,'Show in Dashboard','Show the dashlet in the dashboard',200280,214582,'Y',1,110,'N','N','N','N',0,0,'Y',TO_DATE('2021-09-06 14:41:55','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-06 14:41:55','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','d053c68b-e027-46a2-bf16-95f20bf0a5b9','Y',130,2,2)
;

-- Sep 6, 2021, 2:41:56 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206745,'Sequence','Method of ordering records; lowest number comes first','The Sequence indicates the order of records',200280,214583,'Y',22,120,'N','N','N','N',0,0,'Y',TO_DATE('2021-09-06 14:41:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-06 14:41:56','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','a13e5dcb-bd6a-495e-94c1-eb27e0a7b827','Y',140,2)
;

-- Sep 6, 2021, 2:41:57 PM CEST
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (206746,'Image URL','URL of  image','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.',200280,214584,'Y',120,130,'N','N','N','N',0,0,'Y',TO_DATE('2021-09-06 14:41:56','YYYY-MM-DD HH24:MI:SS'),0,TO_DATE('2021-09-06 14:41:56','YYYY-MM-DD HH24:MI:SS'),0,'N','Y','D','be2d702e-f1ec-4099-932e-fc4ce7fdf921','Y',150,5)
;

-- Sep 6, 2021, 3:19:23 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-06 15:19:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206745
;

-- Sep 6, 2021, 3:19:32 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-06 15:19:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206746
;

-- Sep 6, 2021, 3:19:58 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-06 15:19:58','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206745
;

-- Sep 6, 2021, 3:20:23 PM CEST
UPDATE AD_Column SET AD_Reference_ID=17, AD_Reference_Value_ID=319,Updated=TO_DATE('2021-09-06 15:20:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Column_ID=214582
;

-- Sep 6, 2021, 3:25:38 PM CEST
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_DATE('2021-09-06 15:25:38','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=0 WHERE AD_Field_ID=206744
;

SELECT register_migration_script('202109061500_IDEMPIERE-4946.sql') FROM dual
;
