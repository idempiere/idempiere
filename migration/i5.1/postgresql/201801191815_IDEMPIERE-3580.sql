-- IDEMPIERE-3580 Advanced Zoom Across
-- Jan 19, 2018 6:08:19 PM CET
INSERT INTO AD_SysConfig (AD_SysConfig_ID,AD_Client_ID,AD_Org_ID,Created,Updated,CreatedBy,UpdatedBy,IsActive,Name,Value,Description,EntityType,ConfigurationLevel,AD_SysConfig_UU) VALUES (200113,0,0,TO_TIMESTAMP('2018-01-19 18:08:19','YYYY-MM-DD HH24:MI:SS'),TO_TIMESTAMP('2018-01-19 18:08:19','YYYY-MM-DD HH24:MI:SS'),100,100,'Y','ZOOM_ACROSS_QUERY_TIMEOUT','5','Timeout in seconds for the count queries ran when pushing the button Zoom Across','D','C','a1f85478-e2d8-4c78-98ab-283f74e090ec')
;

-- Jan 19, 2018 6:10:52 PM CET
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203157,0,0,'Y',TO_TIMESTAMP('2018-01-19 18:09:06','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 18:09:06','YYYY-MM-DD HH24:MI:SS'),100,'IsDetailedZoomAcross','Detailed Zoom Across',NULL,'The toolbar button zoom across discover where the record on screen is used on first tabs of windows.  With detailed zoom across it goes deeper in the discovery of relationships within detailed tabs.','Detailed Zoom Across','D','58745104-ed8b-459c-aed8-6a9d9c4e33a1')
;

-- Jan 19, 2018 6:11:25 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Help,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure) VALUES (213339,0,'Detailed Zoom Across','The toolbar button zoom across discover where the record on screen is used on first tabs of windows.  With detailed zoom across it goes deeper in the discovery of relationships within detailed tabs.',200174,'IsDetailedZoomAcross','N',1,'N','N','N','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2018-01-19 18:11:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 18:11:24','YYYY-MM-DD HH24:MI:SS'),100,203157,'Y','N','D','N','N','N','Y','c2e13243-17fa-45f4-9135-4fb4d1572664','Y',0,'N','N')
;

-- Jan 19, 2018 6:11:30 PM CET
ALTER TABLE AD_UserPreference ADD COLUMN IsDetailedZoomAcross CHAR(1) DEFAULT 'N' CHECK (IsDetailedZoomAcross IN ('Y','N'))
;

-- Jan 19, 2018 6:11:39 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan) VALUES (205303,'Detailed Zoom Across','The toolbar button zoom across discover where the record on screen is used on first tabs of windows.  With detailed zoom across it goes deeper in the discovery of relationships within detailed tabs.',200189,213339,'Y',1,90,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2018-01-19 18:11:39','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2018-01-19 18:11:39','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','6c0b384b-f05e-4843-8b0e-eb15e2ee81d2','Y',90,2,2)
;

-- Jan 19, 2018 6:13:19 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=50, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-01-19 18:13:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203797
;

-- Jan 19, 2018 6:13:19 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=70, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-01-19 18:13:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205303
;

-- Jan 19, 2018 6:13:19 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-01-19 18:13:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203800
;

-- Jan 19, 2018 6:13:19 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=2, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2018-01-19 18:13:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=203798
;

SELECT register_migration_script('201801191815_IDEMPIERE-3580.sql') FROM dual
;

