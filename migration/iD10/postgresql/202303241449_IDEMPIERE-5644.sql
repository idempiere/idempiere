-- IDEMPIERE-5644
SELECT register_migration_script('202303241449_IDEMPIERE-5644.sql') FROM dual;

-- Mar 24, 2023, 2:49:11 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (215794,0,'Image URL','URL of  image','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.',376,'ImageURL',120,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2023-03-24 14:49:10','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-03-24 14:49:10','YYYY-MM-DD HH24:MI:SS'),10,1720,'N','N','D','N','N','N','Y','e40c4dbe-eb3d-4698-9b63-2549c8723366','Y',0,'N','N','N')
;

-- Mar 24, 2023, 2:49:20 PM CET
ALTER TABLE AD_Form ADD COLUMN ImageURL VARCHAR(120) DEFAULT NULL 
;

-- Mar 24, 2023, 2:49:32 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (207581,'Image URL','URL of  image','URL of image; The image is not stored in the database, but retrieved at runtime. The image can be a gif, jpeg or png.',302,215794,'Y',120,120,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2023-03-24 14:49:31','YYYY-MM-DD HH24:MI:SS'),10,TO_TIMESTAMP('2023-03-24 14:49:31','YYYY-MM-DD HH24:MI:SS'),10,'N','Y','D','552aebfc-40bb-458a-83dd-f157003ef60c','Y',110,5)
;

-- Mar 24, 2023, 2:49:41 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=120, XPosition=4, ColumnSpan=2,Updated=TO_TIMESTAMP('2023-03-24 14:49:41','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=10 WHERE AD_Field_ID=207581
;

-- Mar 24, 2023, 2:53:50 PM CET
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2023-03-24 14:53:50','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=215794
;

