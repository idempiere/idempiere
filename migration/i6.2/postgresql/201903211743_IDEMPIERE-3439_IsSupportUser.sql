-- IDEMPIERE-3352 Enhancement of Batch Level Costing
-- Mar 21, 2019, 5:27:07 PM BRT
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203304,0,0,'Y',TO_TIMESTAMP('2019-03-21 17:25:13','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-21 17:25:13','YYYY-MM-DD HH24:MI:SS'),100,'IsSupportUser','Support User',NULL,NULL,'Support User','D','d25abb34-0978-4475-b27f-c9141985b1db')
;

-- Mar 21, 2019, 5:27:36 PM BRT
INSERT INTO AD_Column (AD_Column_ID,Version,Name,AD_Table_ID,ColumnName,DefaultValue,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,SeqNoSelection,IsToolbarButton,IsSecure,IsHtml) VALUES (213857,0,'Support User',114,'IsSupportUser','N',1,'N','N','Y','N','N',0,'N',20,0,0,'Y',TO_TIMESTAMP('2019-03-21 17:27:36','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-21 17:27:36','YYYY-MM-DD HH24:MI:SS'),100,203304,'Y','N','D','N','N','N','Y','fe4fbe00-ff30-4810-bc60-9608ac6fc885','Y',0,'N','N','N')
;

-- Mar 21, 2019, 5:27:38 PM BRT
ALTER TABLE AD_User ADD COLUMN IsSupportUser CHAR(1) DEFAULT 'N' CHECK (IsSupportUser IN ('Y','N')) NOT NULL
;

-- Mar 21, 2019, 5:30:34 PM BRT
INSERT INTO AD_Field (AD_Field_ID,Name,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,SortNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205948,'Support User',118,213857,'Y',0,430,0,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2019-03-21 17:30:34','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2019-03-21 17:30:34','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','01a94208-4db0-4b76-81ff-273561203926','Y',430,1,1,1,'N','N','N')
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=204217
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=5884
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=12640
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=52010
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=0,IsDisplayedGrid='N', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=302
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=10,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=309
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=20,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=300
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=110,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6521
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=120,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6515
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=130,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6517
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=140,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6514
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=150,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6518
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=160,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=11679
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=170,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=12324
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=180,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=12323
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=190,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=5883
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=200,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=4261
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=210,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=10491
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=220,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6511
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=230,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200072
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=240,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=202876
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=250,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=202875
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=260,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6513
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=270,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=11525
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=280,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6520
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=290,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=8342
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=300,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=6519
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=310,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=320,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=330,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=340,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=350,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=360,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=370,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200474
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=380,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200475
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=390,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=200473
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=400,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205948
;

-- Mar 21, 2019, 5:31:23 PM BRT
UPDATE AD_Field SET SeqNoGrid=410,IsDisplayedGrid='Y', Updated=statement_timestamp(), UpdatedBy=100 WHERE AD_Field_ID=205827
;

-- Mar 21, 2019, 5:37:45 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6515
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:45','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12323
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6517
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6514
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6518
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11679
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=12324
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=210, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=52010
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=250, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=10491
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=260, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205948
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=270, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6511
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=280, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200072
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=290, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6513
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=300, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=11525
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=310, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202876
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=320, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202875
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=330, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6520
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=340, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=8342
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=350, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6519
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=360, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=1, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200400
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=370, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200405
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=380, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200406
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=390, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=5, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200474
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=400, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=6, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205827
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=410, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200403
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=420, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200401
;

-- Mar 21, 2019, 5:37:46 PM BRT
UPDATE AD_Field SET SeqNo=430, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2019-03-21 17:37:46','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=200402
;

-- Mar 21, 2019, 5:38:17 PM BRT
UPDATE AD_Field SET AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL, IsAdvancedField='Y',Updated=TO_TIMESTAMP('2019-03-21 17:38:17','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205948
;

-- Mar 21, 2019, 5:41:32 PM BRT
UPDATE AD_User SET IsSupportUser='Y',Updated=TO_TIMESTAMP('2019-03-21 17:41:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_User_ID=100
;

SELECT register_migration_script('201903211743_IDEMPIERE-3439_IsSupportUser.sql') FROM dual
;

