-- IDEMPIERE-2353 Please, add to WLocationDialog & C_Location new field Address5
-- 23.07.2017 11:06:25 MSK
INSERT INTO AD_Element (AD_Element_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,ColumnName,Name,Description,Help,PrintName,EntityType,AD_Element_UU) VALUES (203117,0,0,'Y',TO_TIMESTAMP('2017-07-23 11:06:24','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-23 11:06:24','YYYY-MM-DD HH24:MI:SS'),100,'Address5','Address 5','Address Line 5 for the location','The Address 5 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.','Address 5','D','3b1f35e1-30e1-4bc6-b108-6a1c9da54f51')
;

-- 23.07.2017 11:06:51 MSK
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213141,1,'Address 5','Address Line 5 for the location','The Address 5 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.',162,'Address5',60,'N','N','N','N','N',0,'N',10,0,0,'Y',TO_TIMESTAMP('2017-07-23 11:06:50','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-23 11:06:50','YYYY-MM-DD HH24:MI:SS'),100,203117,'N','N','D','N','N','N','Y','680e8d95-5b70-4d81-a4bb-b9b7f54a3cce','Y','N','N')
;

-- 23.07.2017 11:08:15 MSK
INSERT INTO AD_Column (AD_Column_ID,Version,Name,Description,Help,AD_Table_ID,ColumnName,FieldLength,IsKey,IsParent,IsMandatory,IsTranslated,IsIdentifier,SeqNo,IsEncrypted,AD_Reference_ID,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,AD_Element_ID,IsUpdateable,IsSelectionColumn,EntityType,IsSyncDatabase,IsAlwaysUpdateable,IsAutocomplete,IsAllowLogging,AD_Column_UU,IsAllowCopy,IsToolbarButton,IsSecure) VALUES (213142,1,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',162,'Comments',2000,'N','N','N','N','N',0,'N',14,0,0,'Y',TO_TIMESTAMP('2017-07-23 11:08:15','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-23 11:08:15','YYYY-MM-DD HH24:MI:SS'),100,230,'Y','N','D','N','N','N','Y','79d8ffc6-6885-43a1-bc9e-9fbd73771f52','Y','N','N')
;

-- 23.07.2017 11:10:55 MSK
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205137,'Address 5','Address Line 5 for the location','The Address 5 provides additional address information for an entity.  It can be used for building location, apartment number or similar information.',154,213141,'Y',60,190,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-23 11:10:54','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-23 11:10:54','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','U','11698caa-47e0-44f2-a319-31185fc081d7','Y',70,1,5,1,'N','N','N')
;

-- 23.07.2017 11:11:02 MSK
UPDATE AD_Field SET EntityType='D', AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:11:02','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205137
;

-- 23.07.2017 11:11:58 MSK
INSERT INTO AD_Field (AD_Field_ID,Name,Description,Help,AD_Tab_ID,AD_Column_ID,IsDisplayed,DisplayLength,SeqNo,IsSameLine,IsHeading,IsFieldOnly,IsEncrypted,AD_Client_ID,AD_Org_ID,IsActive,Created,CreatedBy,Updated,UpdatedBy,IsReadOnly,IsCentrallyMaintained,EntityType,AD_Field_UU,IsDisplayedGrid,SeqNoGrid,XPosition,ColumnSpan,NumLines,IsQuickEntry,IsDefaultFocus,IsAdvancedField) VALUES (205138,'Comments','Comments or additional information','The Comments field allows for free form entry of additional information.',154,213142,'Y',60,200,'N','N','N','N',0,0,'Y',TO_TIMESTAMP('2017-07-23 11:11:57','YYYY-MM-DD HH24:MI:SS'),100,TO_TIMESTAMP('2017-07-23 11:11:57','YYYY-MM-DD HH24:MI:SS'),100,'N','Y','D','84a69cfb-ae19-4379-8427-69e017a6d480','Y',70,1,5,1,'N','N','N')
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, ColumnSpan=2, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205137
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=110, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=545
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=120, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=550
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=130, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=547
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=140, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=6297
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=150, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=548
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=160, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202473
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=170, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202474
;

-- 23.07.2017 11:13:32 MSK
UPDATE AD_Field SET SeqNo=180, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:32','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202475
;

-- 23.07.2017 11:13:33 MSK
UPDATE AD_Field SET SeqNo=190, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=202476
;

-- 23.07.2017 11:13:33 MSK
UPDATE AD_Field SET SeqNo=200, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, NumLines=3, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:13:33','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205138
;

-- 23.07.2017 11:14:17 MSK
UPDATE AD_Field SET SeqNo=80,IsDisplayed='Y' WHERE AD_Field_ID=205137
;

-- 23.07.2017 11:14:17 MSK
UPDATE AD_Field SET SeqNo=90,IsDisplayed='Y' WHERE AD_Field_ID=546
;

-- 23.07.2017 11:14:17 MSK
UPDATE AD_Field SET SeqNo=100,IsDisplayed='Y' WHERE AD_Field_ID=5754
;

-- 23.07.2017 11:18:35 MSK
UPDATE C_Country SET CaptureSequence='@CO@ @R@ @A1@ @C@ @P@ @A2@ @A3@ @A4@ @A5@',Updated=TO_TIMESTAMP('2017-07-23 11:18:35','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Country_ID=286
;

-- 23.07.2017 11:20:04 MSK
ALTER TABLE C_Location ADD COLUMN Address5 VARCHAR(60) DEFAULT NULL 
;

-- 23.07.2017 11:20:19 MSK
ALTER TABLE C_Location ADD COLUMN Comments VARCHAR(2000) DEFAULT NULL 
;

-- 23.07.2017 11:21:03 MSK
UPDATE AD_Field SET SeqNo=80, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:21:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=546
;

-- 23.07.2017 11:21:03 MSK
UPDATE AD_Field SET SeqNo=90, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:21:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=5754
;

-- 23.07.2017 11:21:03 MSK
UPDATE AD_Field SET IsDisplayed='Y', SeqNo=100, AD_Reference_Value_ID=NULL, AD_Val_Rule_ID=NULL, XPosition=4, IsToolbarButton=NULL,Updated=TO_TIMESTAMP('2017-07-23 11:21:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Field_ID=205137
;

-- 23.07.2017 11:22:13 MSK
UPDATE AD_Column SET IsUpdateable='Y',Updated=TO_TIMESTAMP('2017-07-23 11:22:13','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Column_ID=213141
;

-- 23.07.2017 11:31:57 MSK
UPDATE C_Country SET CaptureSequence='@CO@ @R@ @A1@ @C@ @P@ @A2@ @A3@ @A4@ @A5@ @Com@',Updated=TO_TIMESTAMP('2017-07-23 11:31:57','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE C_Country_ID=286
;

SELECT register_migration_script('201708020730_IDEMPIERE-2353.sql') FROM dual
;

