-- CLDE-899
SELECT register_migration_script('202211231610_PlaceholderForTicket.sql') FROM dual;

-- Nov 23, 2022, 4:10:27 PM CET
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,FKConstraintType,IsHtml) VALUES (1000041,0,'System Color','Color for backgrounds or indicators',776,'AD_Color_ID',22,'N','N','N','N','N',0,'N',27,0,0,'Y',TO_TIMESTAMP('2022-11-23 16:10:27','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-23 16:10:27','YYYY-MM-DD HH24:MI:SS'),100,1636,'Y','N','U','N','N','N','Y','3105709f-5795-4ff5-8a0c-1cb7a1469d21','Y',0,'N','N','N','N')
;

-- Nov 23, 2022, 4:10:31 PM CET
ALTER TABLE R_Status ADD COLUMN AD_Color_ID VARCHAR(22) DEFAULT NULL 
;

-- Nov 23, 2022, 4:10:58 PM CET
INSERT INTO AD_Field (AD_Field_ID,Name,Description,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,ColumnSpan) VALUES (1000029,'System Color','Color for backgrounds or indicators',702,1000041,'Y',22,180,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2022-11-23 16:10:58','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2022-11-23 16:10:58','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','c5d215a0-4376-489c-a910-096fdf4eb1eb','Y',180,2)
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=40, XPosition=4,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000029
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=50,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13005
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=60,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11513
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=70,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11360
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11359
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11358
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=100,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11356
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11511
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11675
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11678
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11677
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11676
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11512
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11510
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11674
;

-- Nov 23, 2022, 4:11:10 PM CET
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2022-11-23 16:11:10','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205045
;

