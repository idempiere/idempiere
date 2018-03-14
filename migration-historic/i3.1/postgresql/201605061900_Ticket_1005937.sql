-- May 6, 2016 4:30:09 PM MYT
-- 1005937 Create new Field Reference Type for scanned image upload and display
INSERT INTO AD_Column (AD_Column_ID,SeqNoSelection,IsSyncDatabase,Version,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsParent,FieldLength,IsSelectionColumn,IsKey,IsAutocomplete,IsAllowLogging,AD_Column_UU,Updated,IsUpdateable,ColumnName,Description,Help,Name,IsAllowCopy,IsActive,CreatedBy,UpdatedBy,IsToolbarButton,IsAlwaysUpdateable,AD_Client_ID,AD_Org_ID,Created,EntityType,IsEncrypted,IsSecure,FKConstraintType,AD_Element_ID,AD_Reference_ID,AD_Table_ID) VALUES (212756,0,'N',0,'N','N','N',0,'N',22,'N','N','N','Y','82704f4a-b798-4dbc-81ca-14b1a1a45506',TO_TIMESTAMP('2016-05-06 16:30:02','YYYY-MM-DD HH24:MI:SS'),'Y','AD_Image_ID','Image or Icon','Images and Icon can be used to display supported graphic formats (gif, jpg, png).
You can either load the image (in the database) or point to a graphic via a URI (i.e. it can point to a resource, http address)','Image','N','Y',100,100,'N','N',0,0,TO_TIMESTAMP('2016-05-06 16:30:02','YYYY-MM-DD HH24:MI:SS'),'U','N','N','N',1639,32,114)
;

-- May 6, 2016 4:30:24 PM MYT
UPDATE AD_Column SET FKConstraintType='N', FKConstraintName='ADImage_ADUser',Updated=TO_TIMESTAMP('2016-05-06 16:30:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212756
;

-- May 6, 2016 4:30:24 PM MYT
ALTER TABLE AD_User ADD COLUMN AD_Image_ID NUMERIC(10) DEFAULT NULL 
;

-- May 6, 2016 4:30:25 PM MYT
ALTER TABLE AD_User ADD CONSTRAINT ADImage_ADUser FOREIGN KEY (AD_Image_ID) REFERENCES ad_image(ad_image_id) DEFERRABLE INITIALLY DEFERRED
;

-- May 6, 2016 4:31:04 PM MYT
UPDATE AD_Column SET EntityType='D',Updated=TO_TIMESTAMP('2016-05-06 16:31:04','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=212756
;

-- May 6, 2016 4:31:30 PM MYT
INSERT INTO AD_Style (AD_Style_ID,AD_Style_UU,Name,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy) VALUES (200000,'2761af49-8165-416c-8522-b1acc548e492','User Image',0,0,TO_TIMESTAMP('2016-05-06 16:31:24','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2016-05-06 16:31:24','YYYY-MM-DD HH24:MI:SS'),100)
;

-- May 6, 2016 4:33:40 PM MYT
INSERT INTO AD_StyleLine (InlineStyle,AD_StyleLine_UU,AD_Client_ID,AD_Org_ID,Created,CreatedBy,IsActive,Updated,UpdatedBy,AD_StyleLine_ID,DisplayLogic,Line,AD_Style_ID) VALUES ('width: 320px; height: 240px; position: absolute; right: 0;','ed12951e-c319-4242-9f76-e53709e1d53b',0,0,TO_TIMESTAMP('2016-05-06 16:33:38','YYYY-MM-DD HH24:MI:SS'),100,'Y',TO_TIMESTAMP('2016-05-06 16:33:38','YYYY-MM-DD HH24:MI:SS'),100,200000,'@_Editor_IsGridView@=N',10,200000)
;

-- May 6, 2016 4:42:03 PM MYT
INSERT INTO AD_Field (SortNo,AD_Field_ID,IsEncrypted,DisplayLength,IsSameLine,IsHeading,SeqNo,IsCentrallyMaintained,IsReadOnly,Help,AD_Org_ID,Updated,Description,Name,AD_Field_UU,IsDisplayed,IsFieldOnly,CreatedBy,UpdatedBy,IsActive,IsDisplayedGrid,SeqNoGrid,XPosition,IsQuickEntry,AD_Client_ID,Created,ColumnSpan,NumLines,IsAdvancedField,IsDefaultFocus,AD_Column_ID,EntityType,AD_Tab_ID,AD_FieldStyle_ID) VALUES (0,204217,'N',0,'N','N',3020,'Y','N','Images and Icon can be used to display supported graphic formats (gif, jpg, png).
You can either load the image (in the database) or point to a graphic via a URI (i.e. it can point to a resource, http address)',0,TO_TIMESTAMP('2016-05-06 16:41:57','YYYY-MM-DD HH24:MI:SS'),'Image or Icon','Image','4e7be56e-d613-4efe-af41-40dd4825cd4b','Y','Y',100,100,'Y','Y',3020,4,'N',0,TO_TIMESTAMP('2016-05-06 16:41:57','YYYY-MM-DD HH24:MI:SS'),3,1,'N','N',212756,'D',118,200000)
;

-- May 6, 2016 4:44:15 PM MYT
UPDATE AD_Field SET SeqNo=20, IsDisplayed='Y', XPosition=4,Updated=TO_TIMESTAMP('2016-05-06 16:44:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=204217
;

-- May 6, 2016 4:44:15 PM MYT
UPDATE AD_Field SET SeqNo=30, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2016-05-06 16:44:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=2001
;

-- May 6, 2016 4:44:15 PM MYT
UPDATE AD_Field SET SeqNo=40,Updated=TO_TIMESTAMP('2016-05-06 16:44:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=300
;

-- May 6, 2016 4:44:15 PM MYT
UPDATE AD_Field SET SeqNo=50, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2016-05-06 16:44:15','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=13755
;

-- May 6, 2016 4:44:16 PM MYT
UPDATE AD_Field SET SeqNo=60, ColumnSpan=2,Updated=TO_TIMESTAMP('2016-05-06 16:44:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=301
;

-- May 6, 2016 4:44:16 PM MYT
UPDATE AD_Field SET SeqNo=70, ColumnSpan=2,Updated=TO_TIMESTAMP('2016-05-06 16:44:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6522
;

-- May 6, 2016 4:44:16 PM MYT
UPDATE AD_Field SET SeqNo=80,Updated=TO_TIMESTAMP('2016-05-06 16:44:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=303
;

-- May 6, 2016 4:44:16 PM MYT
UPDATE AD_Field SET SeqNo=90,Updated=TO_TIMESTAMP('2016-05-06 16:44:16','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4623
;

-- May 6, 2016 4:44:17 PM MYT
UPDATE AD_Field SET SeqNo=100, IsDisplayed='Y', XPosition=1,Updated=TO_TIMESTAMP('2016-05-06 16:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6516
;

-- May 6, 2016 4:44:17 PM MYT
UPDATE AD_Field SET SeqNo=110,Updated=TO_TIMESTAMP('2016-05-06 16:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4260
;

-- May 6, 2016 4:44:17 PM MYT
UPDATE AD_Field SET SeqNo=120,Updated=TO_TIMESTAMP('2016-05-06 16:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=302
;

-- May 6, 2016 4:44:17 PM MYT
UPDATE AD_Field SET SeqNo=130,Updated=TO_TIMESTAMP('2016-05-06 16:44:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6521
;

-- May 6, 2016 4:44:18 PM MYT
UPDATE AD_Field SET SeqNo=140,Updated=TO_TIMESTAMP('2016-05-06 16:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52010
;

-- May 6, 2016 4:44:18 PM MYT
UPDATE AD_Field SET SeqNo=150,Updated=TO_TIMESTAMP('2016-05-06 16:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6515
;

-- May 6, 2016 4:44:18 PM MYT
UPDATE AD_Field SET SeqNo=160,Updated=TO_TIMESTAMP('2016-05-06 16:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6517
;

-- May 6, 2016 4:44:18 PM MYT
UPDATE AD_Field SET SeqNo=170,Updated=TO_TIMESTAMP('2016-05-06 16:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6514
;

-- May 6, 2016 4:44:18 PM MYT
UPDATE AD_Field SET SeqNo=180,Updated=TO_TIMESTAMP('2016-05-06 16:44:18','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6518
;

-- May 6, 2016 4:44:19 PM MYT
UPDATE AD_Field SET SeqNo=190,Updated=TO_TIMESTAMP('2016-05-06 16:44:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11679
;

-- May 6, 2016 4:44:19 PM MYT
UPDATE AD_Field SET SeqNo=200,Updated=TO_TIMESTAMP('2016-05-06 16:44:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12324
;

-- May 6, 2016 4:44:19 PM MYT
UPDATE AD_Field SET SeqNo=210,Updated=TO_TIMESTAMP('2016-05-06 16:44:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12323
;

-- May 6, 2016 4:44:19 PM MYT
UPDATE AD_Field SET SeqNo=220,Updated=TO_TIMESTAMP('2016-05-06 16:44:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5883
;

-- May 6, 2016 4:44:19 PM MYT
UPDATE AD_Field SET SeqNo=230,Updated=TO_TIMESTAMP('2016-05-06 16:44:19','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5884
;

-- May 6, 2016 4:44:20 PM MYT
UPDATE AD_Field SET SeqNo=240,Updated=TO_TIMESTAMP('2016-05-06 16:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=4261
;

-- May 6, 2016 4:44:20 PM MYT
UPDATE AD_Field SET SeqNo=260,Updated=TO_TIMESTAMP('2016-05-06 16:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200072
;

-- May 6, 2016 4:44:20 PM MYT
UPDATE AD_Field SET SeqNo=270,Updated=TO_TIMESTAMP('2016-05-06 16:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6513
;

-- May 6, 2016 4:44:20 PM MYT
UPDATE AD_Field SET SeqNo=280,Updated=TO_TIMESTAMP('2016-05-06 16:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11525
;

-- May 6, 2016 4:44:20 PM MYT
UPDATE AD_Field SET SeqNo=290,Updated=TO_TIMESTAMP('2016-05-06 16:44:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8342
;

-- May 6, 2016 4:44:21 PM MYT
UPDATE AD_Field SET SeqNo=300,Updated=TO_TIMESTAMP('2016-05-06 16:44:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6519
;

-- May 6, 2016 4:44:21 PM MYT
UPDATE AD_Field SET SeqNo=310,Updated=TO_TIMESTAMP('2016-05-06 16:44:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- May 6, 2016 4:44:21 PM MYT
UPDATE AD_Field SET SeqNo=320,Updated=TO_TIMESTAMP('2016-05-06 16:44:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- May 6, 2016 4:44:21 PM MYT
UPDATE AD_Field SET SeqNo=330,Updated=TO_TIMESTAMP('2016-05-06 16:44:21','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- May 6, 2016 4:44:22 PM MYT
UPDATE AD_Field SET SeqNo=340,Updated=TO_TIMESTAMP('2016-05-06 16:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- May 6, 2016 4:44:22 PM MYT
UPDATE AD_Field SET SeqNo=350,Updated=TO_TIMESTAMP('2016-05-06 16:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- May 6, 2016 4:44:22 PM MYT
UPDATE AD_Field SET SeqNo=360,Updated=TO_TIMESTAMP('2016-05-06 16:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- May 6, 2016 4:44:22 PM MYT
UPDATE AD_Field SET SeqNo=370,Updated=TO_TIMESTAMP('2016-05-06 16:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200474
;

-- May 6, 2016 4:44:22 PM MYT
UPDATE AD_Field SET SeqNo=380,Updated=TO_TIMESTAMP('2016-05-06 16:44:22','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000975
;

-- May 6, 2016 4:44:23 PM MYT
UPDATE AD_Field SET SeqNo=390,Updated=TO_TIMESTAMP('2016-05-06 16:44:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000976
;

-- May 6, 2016 4:44:23 PM MYT
UPDATE AD_Field SET SeqNo=400,Updated=TO_TIMESTAMP('2016-05-06 16:44:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000977
;

-- May 6, 2016 4:44:23 PM MYT
UPDATE AD_Field SET SeqNo=410,Updated=TO_TIMESTAMP('2016-05-06 16:44:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1000978
;

-- May 6, 2016 4:44:23 PM MYT
UPDATE AD_Field SET SeqNo=420,Updated=TO_TIMESTAMP('2016-05-06 16:44:23','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1003008
;

-- May 6, 2016 4:44:24 PM MYT
UPDATE AD_Field SET SeqNo=430,Updated=TO_TIMESTAMP('2016-05-06 16:44:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1003005
;

-- May 6, 2016 4:44:24 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2016-05-06 16:44:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10491
;

-- May 6, 2016 4:44:24 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2016-05-06 16:44:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6520
;

-- May 6, 2016 4:44:24 PM MYT
UPDATE AD_Field SET SeqNo=0,Updated=TO_TIMESTAMP('2016-05-06 16:44:24','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=1003173
;

SELECT register_migration_script('201605061900_Ticket_1005937.sql') FROM dual
;

